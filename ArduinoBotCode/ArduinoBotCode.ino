#include <Servo.h>
//#define rxPin 2 
//#define txPin 3
#define motor1pin 3
#define motor2pin 9
Servo motor1;
Servo motor2;

void setup() {
  // put your setup code here, to run once:
  //pinMode(rxPin, INPUT);
  //pinMode(txPin, OUTPUT);
  motor1.attach(motor1pin);
  motor2.attach(motor2pin);
  //xbee.begin(9600);
  Serial.begin(9600);
  Serial.println("StartingXBee Communication");
   
}

void loop() {
  // put your main code here, to run repeatedly:
  //Serial.println("Waiting for Xb");
  
    /*char c = Serial.read();
     if(c == 'A')
     {
       Serial.println("A");
       motor1.writeMicroseconds(map(0,0,255,1000,2000));
       
     }
     else if(c == 'B')
     {
       Serial.println("B");
       motor1.writeMicroseconds(map(255,0,255,1000,2000));
       

     }
      if(c == 'L')
      {
        Serial.println("L");
        Serial.println(Serial.read());
        //int i = Serial.read();
        char d = Serial.read();
        if(d == 'F')
        {
          motor1.writeMicroseconds(map(255,0,255,1000,2000));
        }
        if(d == 'S')
        {
          motor1.writeMicroseconds(map(127,0,255,1000,2000));
        }
        if(d == 'B')
        {
          motor1.writeMicroseconds(map(6,0,255,1000,2000));
        }
      
      }
      if(c == 'R')
      {
        //erial.println("R");
        //Serial.println(Serial.read());
        //int i = Serial.read();
        char d = Serial.read();
        if(d == 'F')
        {
          motor2.writeMicroseconds(map(255,0,255,1000,2000));
        }
        if(d == 'S')
        {
          motor2.writeMicroseconds(map(127,0,255,1000,2000));
        }
        if(d == 'B')
        {
          motor2.writeMicroseconds(map(0,0,255,1000,2000));
        }      
      }*/
     
   
      //byte c = Serial.read();
      /* //0-255 motor 1 256-510 motor 2 511-765 motor 3
      if((int)c == 500)
      {
        //Serial.println("A");
        motor1.writeMicroseconds(map(0,0,255,1000,2000));
        //delay(21);
      }
      else if((int)c == 600)
      {
        //Serial.println("B");
        motor1.writeMicroseconds(map(255,0,255,1000,2000));
        //delay(21);
        
      }
      else if((int)c == 700)
      {
        motor1.writeMicroseconds(map(127,0,255,1000,2000));
      }*/
      byte c = Serial.read();
      //101-200 motor 1 201-300 motor 2 301-400 motor 3
      if((int)c >=50 && (int)c <= 100)//motor 1
      {
        motor1.writeMicroseconds(map((int)c,50,100,1000,2000));
      }
      else if((int)c >=150 && (int)c <= 200)//motor 1
      {
        motor2.writeMicroseconds(map((int)c,150,200,1000,2000));
      }
      else if((int)c >=250 && (int)c <= 300)//motor 1
      {
        //motor1.writeMicroseconds(map((int)c,250,300,1000,2000));
      }


      
      /*else if(c == 'L')
      {
        motor1.writeMicroseconds(map(6,6,179,1000,2000));
        //byte i = Serial.read();
        //motor1.writeMicroseconds(map((int)i,6,179,1000,2000));
      
      }
      else if(c == 'R')
      {
        motor1.writeMicroseconds(map(179,6,179,1000,2000));
        //byte i = Serial.read();
        //motor2.writeMicroseconds(map((int)i,6,179,1000,2000));
      
      }*/
    
}
