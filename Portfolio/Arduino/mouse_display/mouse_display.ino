/* Bibliotecas */

#include <SoftwareSerial.h>
#include <OS_SerialTFT.h>

/* Variáveis e Constantes */

#define RX 4
#define TX 2

SerialTFT TFT(RX, TX);

#define VRx A0
#define VRy A1

#define maxY 240
#define maxX 320

int PointerX = maxX/2;
int PointerY = maxY/2;

int circle[250][3];
int counter = 0;

bool click = 0;

/* Sub-Rotinas */


void fundo()
{
  TFT.fillRect(0, 0, maxX, maxY, TFT.color565(0, 0, 0));
  for(int i = 0; i <= counter; i++)
  {
    TFT.fillCircle(circle[i][0], circle[i][1], 10, circle[i][2]);
  }
}

void mouse(int x, int y)
{
  TFT.fillTriangle(x, y, x+16, y+40, x+40, y+16,TFT.color565(255, 255, 255));
}

int Xscan()
{
  int x = ((analogRead(VRx)-511)/12)+1;
  return x;
}

int Yscan()
{
  int y = (analogRead(VRy)-511)/12;
  return y;
}

/* Rotina */

void setup()
{
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(3, INPUT_PULLUP);

  TFT.begin(9600);
  TFT.setBacklight(255);

  Serial.begin(9600);
}

void loop()
{
  if((PointerY - Xscan()) <= 240 && (PointerY - Xscan()) >= 0) PointerY -= Xscan();
  if((PointerX + Yscan()) <= 320 && (PointerX + Yscan()) >= 0) PointerX += Yscan();

  fundo();
  mouse(PointerX, PointerY);
  if(!digitalRead(3) && !click)
  {
    int color = TFT.color565(random(0,255),random(0,255),random(0,255));
    TFT.fillCircle(PointerX, PointerY, 10, color);
    circle[counter][0] = PointerX;
    circle[counter][1] = PointerY;
    circle[counter][2] = color;
    counter += 1;
    click = 1;
  }
  if(digitalRead(3)) click = 0;
}