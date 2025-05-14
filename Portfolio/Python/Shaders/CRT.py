import numpy as np
from PIL import Image
import moderngl

# ==== CONFIGURAÇÕES DE EFEITO ====
input_name = "img.png"
output_name = "img_CRT.png"

chromatic_on = True
chromatic_strength = 1.0
chromatic_offset = 100.0 # Deslocamento em pixels

color_conversion = False

scanlines_on = False
scanline_spacing = 1.0
dark_lines = 0.25 # Intensidade das linhas escuras (+ escurece)
light_lines = 0.0 # Intensidade das linhas claras (- escurece)
# =================================

# Carrega a imagem
input_image = Image.open(input_name).convert("RGB")
img_width, img_height = input_image.size
input_data = np.array(input_image).astype('f4') / 255.0

# Cria contexto OpenGL
ctx = moderngl.create_standalone_context()

# Textura de entrada
texture = ctx.texture((img_width, img_height), 3, (input_data * 255).astype('u1').tobytes())
texture.build_mipmaps()
texture.use(0)

# Framebuffer de saída
fbo = ctx.framebuffer(color_attachments=[ctx.texture((img_width, img_height), 3)])
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
uniform bool color_conversion;
uniform float scanline_spacing;
uniform float chromatic_strength;
uniform float chromatic_offset;
uniform float dark_lines;
uniform float light_lines;

in vec2 uv;
out vec4 fragColor;

float ToLinear1(float c){ return (c<=0.04045)? c/12.92 : pow((c+0.055)/1.055, 2.4); }
float ToSrgb1(float c){ return (c<0.0031308)? c*12.92 : 1.055*pow(c,0.41666)-0.055; }

vec3 ToLinear(vec3 c){ return vec3(ToLinear1(c.r), ToLinear1(c.g), ToLinear1(c.b)); }
vec3 ToSrgb(vec3 c){ return vec3(ToSrgb1(c.r), ToSrgb1(c.g), ToSrgb1(c.b)); }

void main() {
    vec2 pixel = 1.0 / resolution;
    vec3 color = texture(tex, uv).rgb;

    // Efeito de aberração cromática
    if (chromatic_on && chromatic_strength > 0.0) {
        float offset = pixel.x * chromatic_strength * chromatic_offset;
        float r = texture(tex, uv + vec2(offset, 0.0)).r;
        float g = texture(tex, uv).g;
        float b = texture(tex, uv - vec2(offset, 0.0)).b;
        color = vec3(r, g, b);
    }

    // Efeito de scanlines
    if (scanlines_on && (dark_lines != 0.0 || light_lines != 0.0)) {
        float s = sin(uv.y * resolution.y * 3.1415 / scanline_spacing);
        float scan = 1.0 - dark_lines * max(0.0, -s) + light_lines * max(0.0, s);
        color *= scan;
    }

    if (color_conversion) {
        fragColor = vec4(ToSrgb(color), 1.0);
    }
    else {
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
prog['scanline_spacing'].value = scanline_spacing
prog['color_conversion'].value = color_conversion

# Renderiza
vao.render(moderngl.TRIANGLE_STRIP)

# Lê e salva
data = fbo.read(components=3, alignment=1)
output_image = Image.frombytes('RGB', (img_width, img_height), data)
output_image = output_image.transpose(Image.FLIP_TOP_BOTTOM)
output_image.save(output_name)

