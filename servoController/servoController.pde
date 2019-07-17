//This class controls the servo motors on the Arduino using xbs, a file written  //by processing that writes instructions for the game controller.  //Make sure to include these imports after installing the libraries! //Processing that allows us to configure controller buttons
import processing.serial.*;

import net.java.games.input.*;//Game Control Plus which allows us to use the game controller with Processing
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import cc.arduino.*;//Allows control of arduino controller

import org.firmata.*;//Implements Fermata protocol for communicating with software on the host computer


ControlDevice cont;//The game controller
ControlIO control;//Retrieves information about connected devices and data from them

Arduino arduino;//The Arduino controller
Serial xbee;
                  
float thumbLeft;//Values of the sliders on the game controller
float thumbRight;
float leftPrev = 0;
float rightPrev = 0;
boolean thumbLeftDropper;
boolean thumbRightDropper;


void setup() //This method runs once at the beginning of the program. Think of this as a constructor to initialize variables used in the program. 
{
  
  size(360, 200); //Creates a window with the specified size. This will give feedback used when getting controller values. 
   
  control = ControlIO.getInstance(this); //Initializes with current instance of the ControlIO, with currently connected devices
  cont = control.getMatchedDevice("xbs"); //Initializes controller to the ControlDevice matching the configuration described in xbs

  if(cont == null) {                         //Stops the program if the specified controller is not detected to avoid crashing
    println("Controller was not found!");
    System.exit(-1);
  }
  
  //println(Arduino.list());//This line of code will list everything attached to COM ports on the Arduino. //Uncomment it and run to find the index of the serial port of your Arduino.
  arduino = new Arduino(this, Arduino.list()[2], 57600);  //To access the serial port your Arduino is on, change the number in the square //Brackets to match the index of the port in the list you printed above.
  xbee = new Serial(this, Arduino.list()[2], 57600); 

  //Configures the Arduino pins. //Parameters: //pin- the Arduino pin number to set the mode of. Change this number to match the pins your servos are attached to. //mode- defines how the pin behaves
  arduino.pinMode(3, Arduino.SERVO);
  arduino.pinMode(9, Arduino.SERVO);
  arduino.pinMode(-1, Arduino.SERVO);
  
}

public void getUserInput() //This method gets the user input from the map
{
 
 thumbLeft = map(cont.getSlider("leftStickY").getValue(), -1, 1, 6, 179); //Assign our float value //Access the controller
 thumbRight = map(cont.getSlider("rightStickY").getValue(), -1, 1, 6, 179);
 thumbRightDropper = cont.getButton("RT").pressed();
 thumbLeftDropper = cont.getButton("LT").pressed();
}


void draw() //Called in a loop during the program, similar to loop() in the ArduinoIDE.  
{
 getUserInput(); //Updates the thumb values by getting the user input
 background(thumbLeft,100,255);   //Changes color of the window, giving us a visual indicator of the change in thumb values. (only one stick tho)
 background(thumbRight,100,255);

 //Runs the servo motors with the specified port according to the values on the game controller. //Change the ports to match the wiring of your Arduino. 
 //Parameters: //port- the port of the servo being controlled. //angle- the value used to determine how much power to give to the servo.
 //arduino.servoWrite(3,(int) thumbLeft); 
 if(thumbLeft>6 && leftPrev != thumbLeft)
 {
   xbee.write('L');
   xbee.write((int)thumbLeft);
   leftPrev = thumbLeft;
 }
 
 //arduino.servoWrite(9,(int) thumbRight);
 if(thumbRight>6 && rightPrev != thumbRight)
 {
   xbee.write('R');
   xbee.write((int)thumbRight);
   rightPrev = thumbRight;
 }
 
 if(thumbRightDropper)
 {
  //arduino.servoWrite(-1, 180); 
  xbee.write('A');
 }
 else if(thumbLeftDropper)
 {
  //arduino.servoWrite(-1, 0);
  xbee.write('B');
 }
}
