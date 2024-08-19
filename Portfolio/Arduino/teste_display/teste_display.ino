#include <SoftwareSerial.h>
#include <OS_SerialTFT.h>

#define RX 4
#define TX 2

int state = 0;

SerialTFT TFT(RX, TX);

void setup()
{
  Serial.begin(9600);
  TFT.begin(9600);
  randomSeed(analogRead(A0));
}

void loop()
{
  if(Serial.available() > 0)
  {
    if((int(Serial.read()) - 48)!=-38)
    {
      state = int(Serial.read()) - 48;
    }
  }
  Serial.print(state);
  delay(100);
  switch(state)
  {
    case 0:
      TFT.fillCircle(random(0,325), random(0,240), random(5,40), TFT.color565(random(1,255),random(1,255),random(1,255)));
    break;
    
    case '1':
      TFT.fillRect(random(0,325), random(0,240), random(5,80), random(5,80), TFT.color565(random(1,255),random(1,255),random(1,255)));
    break;

    case '2':
      TFT.fillTriangle(random(0,325), random(0,240), random(0,325), random(0,240), random(0,325), random(0,240), TFT.color565(random(1,255),random(1,255),random(1,255)));
    break;
  }
}
