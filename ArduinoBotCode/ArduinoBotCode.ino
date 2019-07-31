//Sai Juttu
/* 
   •••••••••••••••••••••••••••••••••••••••••••••••••••••••         
   §                                                     §
   §   This class recieves input from a router XBee      §
   §   and decodes the byte data into values that are .  §
   §   understood by the PWM motors to set  a speed      §                                         §
   §                                                     §
   •••••••••••••••••••••••••••••••••••••••••••••••••••••••
   
   Todo:
   ¶ test for trigger functionality
   ¶ retest with new code
   
*/

#include <Servo.h>      //import the servo library to use to control the PWM Motors

#define motor1pin 3     //set the pin numbers for the motors
#define motor2pin 9     

Servo motor1;           //declare the motors
Servo motor2; 

void setup()                     //runs once to setup everything
{
    motor1.attach(motor1pin);    //attachss motor 1 to its pin
    motor2.attach(motor2pin);    //attaches motor 2 to its pin
    Serial.begin(9600);          //begins serial communication at the same baud rate
}

void loop()
{
  
      byte c = Serial.read();                                         //reads data from serial port and stores it into a byte variable
/* 
   •••••••••••••••••••••••••••••••••••••••••••••••••••••••   
   §                                                     §
   §   ByteCodes                                         §
   §                                                     §
   §   joyLeftY     50-100       buttonA       621-622   §
   §   joyLeftX     150-200      buttonB       623-624   §
   §   joyRightY    250-300      buttonX       625-626   §
   §   joyRightX    350-400      buttonY       627-628   §
   §   triggerLeft  450-500      buttonShare   631-632   §
   §   triggerRight 550-600      buttonHome    633-634   §
   §                             buttonMenu    635-636   §
   §   buttonLeft   601-602      stickInLeft   637-638   §
   §   buttonRight  603-604      stickInRight  639-640   §
   §   dPadUp       611-612                              §
   §   dPadDown     613-614                              §
   §   dPadRight    615-616                              §
   §   dPadLeft     617-618                              §
   §                                                     §
   •••••••••••••••••••••••••••••••••••••••••••••••••••••••
   
   
*/     
      //Float Controls

      if((int)c >=50 && (int)c <= 100)                                //left joystick y axis
      { motor1.writeMicroseconds(map((int)c,50,100,1000,2000)); }
      else if((int)c >=150 && (int)c <= 200)                          //left joystick x axis
      {}
      else if((int)c >=250 && (int)c <= 300)                          //right joystick y axis
      { motor2.writeMicroseconds(map((int)c,150,200,1000,2000)); }
      else if((int)c >=350 && (int)c <= 400)                          //right joystick x axis
      {}
      else if((int)c >=450 && (int)c <= 500)                          //left trigger
      {}
      else if((int)c >=550 && (int)c <= 600)                          //right trigger
      {}

      //Boolean Controls

      if((int)c == 601)                                                   //left button on
      {}
      else if((int)c == 602)                                              //left button off
      {}
      else if((int)c == 603)                                              //right button on 
      {}
      else if((int)c == 604)                                              //right button off 
      {}
      else if((int)c == 611)                                              //dpad up on
      {}
      else if((int)c == 612)                                              //dpad up off
      {}
      else if((int)c == 613)                                              //dpad down on 
      {}
      else if((int)c == 614)                                              //dpad down off 
      {}
      else if((int)c == 615)                                              //dpad right  on 
      {}
      else if((int)c == 616)                                              //dpad right off 
      {}
      else if((int)c == 617)                                              //dpad left on 
      {}
      else if((int)c == 618)                                              //dpad left off
      {}
      else if((int)c == 621)                                              //button a on
      {}
      else if((int)c == 622)                                              //button a off                 
      {}
      else if((int)c == 623)                                              //button b on
      {}
      else if((int)c == 624)                                              //button b off
      {}
      else if((int)c == 625)                                              //button x on
      {}
      else if((int)c == 626)                                              //button x off
      {}
      else if((int)c == 627)                                              //button y on
      {}
      else if((int)c == 628)                                              //button y off
      {}
      else if((int)c == 631)                                              //share button on 
      {}
      else if((int)c == 632)                                              //share button off 
      {}
      else if((int)c == 633)                                              //home button on
      {}
      else if((int)c == 634)                                              //home button off
      {}
      else if((int)c == 635)                                              //menu button on 
      {}
      else if((int)c == 636)                                              //menu button on 
      {}
      else if((int)c == 637)                                              //left stick in on
      {}  
      else if((int)c == 638)                                              //left stick in off
      {}
      else if((int)c == 639)                                              //right stick in on
      {}
      else if((int)c == 640)                                              //right stick in off
      {}
      
      
      
    
}
