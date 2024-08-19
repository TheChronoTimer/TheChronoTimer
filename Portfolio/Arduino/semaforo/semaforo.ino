#define Start A0
#define Stop A1

#define Red 10
#define Yellow 9
#define Green 8

bool Onoff = 0;
int State = 1;
bool FirstTime = 0;
int Time = 100;
unsigned long int Clock = millis() + Time;

void setup()
{
	pinMode(Start, INPUT);
	pinMode(Stop, INPUT);
  
	pinMode(Red, OUTPUT);
	pinMode(Yellow, OUTPUT);
	pinMode(Green, OUTPUT);
  
    digitalWrite(Red, LOW);
    digitalWrite(Yellow, LOW);
    digitalWrite(Green, LOW);
}

void loop()
{
  if(digitalRead(Start) == HIGH)
  {
    Onoff = 1;
    if(FirstTime == 1) State = 1;
    else FirstTime = 1;
    Clock = millis() + Time;
  }
  else if(digitalRead(Stop) == HIGH) Onoff = 0;
  
  if((Clock <= millis()) && Onoff == 1)
  {
    if(State == 3) State = 1;
    else State++;
    Clock = millis() + Time;
  }
  
  if(Onoff == 0)
  {
    digitalWrite(Red, LOW);
    digitalWrite(Yellow, LOW);
    digitalWrite(Green, LOW);
  }
  else
  {
  	if(State == 1)
    {
        digitalWrite(Red, LOW);
    	digitalWrite(Yellow, LOW);
    	digitalWrite(Green, HIGH);
    }
      
    if(State == 2)
    {
        digitalWrite(Red, LOW);
    	digitalWrite(Yellow, HIGH);
    	digitalWrite(Green, LOW);
    }
      
     if(State == 3)
    {
        digitalWrite(Red, HIGH);
    	digitalWrite(Yellow, LOW);
    	digitalWrite(Green, LOW);
    }
  }
}
