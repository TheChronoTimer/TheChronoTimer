import numpy as np
from PIL import Image
import moderngl

# === CONFIGURAÇÕES DE ENTRADA E SAÍDA ===
input_name = "img.png"
output_name = "img_CRT.png"

# === UPSCALE ===
upscale_x = 1.0
upscale_y = 1.0
upscale_before_shader = False

# === ABERRAÇÃO CROMÁTICA ===
chromatic_on = False
chromatic_strength = 1.0
chromatic_offset = 4
chromatic_spread_r = 3
chromatic_spread_g = 1
chromatic_spread_b = 2

# === CONVERSÃO DE COR ===
color_conversion = False

# === CURVATURA ===
curvature_on = True
curvature_strength = 0.1
curvature_clamp = True

# === SCANLINES ===
scanlines_on = True
scanline_dark_size = 1
scanline_light_size = 2
dark_lines = 0.25
light_lines = 0.0
# ========================================

# Upscaling
input_image = Image.open(input_name).convert("RGB")

if upscale_before_shader:
    img_width = int(input_image.width * upscale_x)
    img_height = int(input_image.height * upscale_y)
    input_image = input_image.resize((img_width, img_height), resample=Image.BICUBIC)
else:
    img_width, img_height = input_image.size

input_data = np.array(input_image).astype('f4') / 255.0

# Tamanho de saída
output_width = int(img_width * (1 if upscale_before_shader else upscale_x))
output_height = int(img_height * (1 if upscale_before_shader else upscale_y))

# OpenGL
ctx = moderngl.create_standalone_context()

# Textura de entrada
texture = ctx.texture((img_width, img_height), 3, (input_data * 255).astype('u1').tobytes())
texture.build_mipmaps()
texture.use(0)

# Framebuffer de saída
fbo = ctx.framebuffer(color_attachments=[ctx.texture((output_width, output_height), 3)])
fbo.use()

# Vertex shader
vertex_shader = '''
#version 330
in vec2 in_vert;
out vec2 uv;
void main() {
    uv = vec2(in_vert.x, -in_vert.y) * 0.5 + 0.5;
    gl_Position = vec4(in_vert, 0.0, 1.0);
}
'''

# Fragment shader
fragment_shader = '''
#version 330

uniform sampler2D tex;
uniform vec2 resolution;
uniform bool chromatic_on;
uniform bool scanlines_on;
uniform bool curvature_on;
uniform bool curvature_clamp;
uniform bool color_conversion;
uniform float curvature_strength;
uniform int scanline_dark_size;
uniform int scanline_light_size;
uniform float chromatic_strength;
uniform float dark_lines;
uniform float light_lines;
uniform int chromatic_offset;
uniform int chromatic_spread_r;
uniform int chromatic_spread_g;
uniform int chromatic_spread_b;

in vec2 uv;
out vec4 fragColor;

float ToLinear1(float c) {
    return (c <= 0.04045) ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4);
}

float ToSrgb1(float c) {
    return (c < 0.0031308) ? c * 12.92 : 1.055 * pow(c, 0.41666) - 0.055;
}

vec3 ToLinear(vec3 c) {
    return vec3(ToLinear1(c.r), ToLinear1(c.g), ToLinear1(c.b));
}

vec3 ToSrgb(vec3 c) {
    return vec3(ToSrgb1(c.r), ToSrgb1(c.g), ToSrgb1(c.b));
}

float Gaussian(float x, float sigma) {
    return exp(-0.5 * (x * x) / (sigma * sigma));
}

void main() {
    vec2 curved_uv = uv;

    if (curvature_on) {
        vec2 cc = uv * 2.0 - 1.0;
        cc *= 1.0 + curvature_strength * dot(cc, cc);
        curved_uv = cc * 0.5 + 0.5;

        if (curvature_clamp) {
            if (any(lessThan(curved_uv, vec2(0.0))) || any(greaterThan(curved_uv, vec2(1.0)))) {
                fragColor = vec4(0.0, 0.0, 0.0, 1.0);
                return;
            }
        }
    }

    vec2 pixel = 1.0 / resolution;
    vec3 color = texture(tex, curved_uv).rgb;

    if (chromatic_on && chromatic_strength > 0.0) {
        float offset = pixel.x * chromatic_strength * float(chromatic_offset);

        float sigma_r = float(chromatic_spread_r) * 0.5;
        float sigma_g = float(chromatic_spread_g) * 0.5;
        float sigma_b = float(chromatic_spread_b) * 0.5;

        int num_samples_r = int(3 + float(chromatic_spread_r) * 2);
        int num_samples_g = int(3 + float(chromatic_spread_g) * 2);
        int num_samples_b = int(3 + float(chromatic_spread_b) * 2);

        float total_weight = 0.0;
        float red = 0.0;
        float green = 0.0;
        float blue = 0.0;

        // Red
        for (int i = -num_samples_r / 2; i <= num_samples_r / 2; i++) {
            float weight = Gaussian(float(i), sigma_r);
            vec2 offset_uv = curved_uv + vec2(float(i) * pixel.x + offset, 0.0);
            red += weight * texture(tex, offset_uv).r;
            total_weight += weight;
        }
        red /= total_weight;

        // Green
        total_weight = 0.0;
        for (int i = -num_samples_g / 2; i <= num_samples_g / 2; i++) {
            float weight = Gaussian(float(i), sigma_g);
            vec2 offset_uv = curved_uv + vec2(float(i) * pixel.x, 0.0);
            green += weight * texture(tex, offset_uv).g;
            total_weight += weight;
        }
        green /= total_weight;

        // Blue
        total_weight = 0.0;
        for (int i = -num_samples_b / 2; i <= num_samples_b / 2; i++) {
            float weight = Gaussian(float(i), sigma_b);
            vec2 offset_uv = curved_uv + vec2(float(i) * pixel.x - offset, 0.0);
            blue += weight * texture(tex, offset_uv).b;
            total_weight += weight;
        }
        blue /= total_weight;

        color = vec3(red, green, blue);
    }

    if (scanlines_on && (dark_lines != 0.0 || light_lines != 0.0) && scanline_light_size > 0 && scanline_dark_size > 0) {
        int total_scanline_height = scanline_dark_size + scanline_light_size;
        int y = int(curved_uv.y * resolution.y);
        int pos_in_block = y % total_scanline_height;

        float scan = 1.0;
        if (pos_in_block < scanline_dark_size) {
            scan -= dark_lines;
        } else {
            scan += light_lines;
        }
        color *= clamp(scan, 0.0, 1.0);
    }

    if (color_conversion) {
        fragColor = vec4(ToSrgb(color), 1.0);
    } else {
        fragColor = vec4(color, 1.0);
    }
}
'''

# Quad
quad = ctx.buffer(np.array([
    -1.0, -1.0,
     1.0, -1.0,
    -1.0,  1.0,
     1.0,  1.0,
], dtype='f4'))

# Programa e VAO
prog = ctx.program(vertex_shader=vertex_shader, fragment_shader=fragment_shader)
vao = ctx.simple_vertex_array(prog, quad, 'in_vert')

# Uniforms
prog['tex'] = 0
prog['resolution'].value = (img_width, img_height)
prog['chromatic_on'].value = chromatic_on
prog['scanlines_on'].value = scanlines_on
prog['chromatic_strength'].value = chromatic_strength
prog['chromatic_offset'].value = chromatic_offset
prog['dark_lines'].value = dark_lines
prog['light_lines'].value = light_lines
prog['scanline_dark_size'].value = scanline_dark_size
prog['scanline_light_size'].value = scanline_light_size
prog['color_conversion'].value = color_conversion
prog['curvature_on'].value = curvature_on
prog['curvature_strength'].value = curvature_strength
prog['curvature_clamp'].value = curvature_clamp
prog['chromatic_spread_r'].value = chromatic_spread_r
prog['chromatic_spread_g'].value = chromatic_spread_g
prog['chromatic_spread_b'].value = chromatic_spread_b

# Renderiza
vao.render(moderngl.TRIANGLE_STRIP)

# Lê e salva
data = fbo.read(components=3, alignment=1)
output_image = Image.frombytes('RGB', (output_width, output_height), data)
output_image = output_image.transpose(Image.FLIP_TOP_BOTTOM)
output_image.save(output_name)
