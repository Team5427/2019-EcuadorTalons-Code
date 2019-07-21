/*This class controls the servo motors on the Arduino using xbs, a file written  
by processing that writes instructions for the game controller.  
Make sure to include these imports after installing the libraries! */

//Processing that allows us to configure controller buttons
import processing.serial.*;

import cc.arduino.*; //Allows interaction with the Arduino. 

import net.java.games.input.*;//Game Control Plus which allows us to use the game controller with Processing
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlDevice cont;//The game controller
ControlIO control;//Retrieves information about connected devices and data from them

Serial xbee; //the xbee adapter that is connected to the Arduino
                  
float thumbLeft;//Values of the sliders on the game controller
float thumbRight;
float leftPrev = 0;
float rightPrev = 0;
boolean thumbLeftDropper;
boolean thumbRightDropper;

//This method runs once at the beginning of the program. Think of this as a constructor to initialize variables used in the program. 
void setup()
{
  size(360, 200); //Creates a window with the specified pixel size. This will give feedback used when getting controller values. 
   
  control = ControlIO.getInstance(this); //Initializes with current instance of the ControlIO, with currently connected devices.
  cont = control.getMatchedDevice("xbs"); //Initializes controller to the ControlDevice matching the configuration described in the file, "xbs".

  //Stops the program if the specified controller is not detected to avoid crashing
  if(cont == null) 
  {                       
    println("Controller was not found!");
    System.exit(-1);
  }
  
  println((Object[])Arduino.list());//This line of code will list everything attached to COM ports on the Arduino. Run to find the index of the serial port of your Arduino.
  xbee = new Serial(this, Serial.list()[2], 9600);                         
}

public void getUserInput() //This method gets the user input from the map
{
 
 thumbLeft = map(cont.getSlider("leftStickY").getValue(), -1, 1, 50, 100); //Assign our float value. Access the controller
 thumbRight = map(cont.getSlider("rightStickY").getValue(), -1, 1, 150, 200);
 thumbRightDropper = cont.getButton("RB").pressed();
 thumbLeftDropper = cont.getButton("LB").pressed();
}


void draw() //Called in a loop during the program, similar to loop() in the ArduinoIDE. Think of this method as a loop that runs during your program. 
{
 getUserInput(); //Updates the thumb values by getting the user input
 background(thumbLeft,100,255);   //Changes color of the window, giving us a visual indicator of the change in thumb values. (only one stick tho)
 background(thumbRight,100,255);


 //Dropper Controls
 //sends numbers based on what is pressed. We will work with this numbers in the Arduino code. 
 if(thumbRightDropper && !thumbLeftDropper)//right is pressed and left isn't
 { 
  xbee.write(500);//sends 500 to the xbee on the Arduino
  System.out.println("right button");
 }
 else if(!thumbRightDropper && thumbLeftDropper)//left is pressed and right isn't
 {
   xbee.write(600);//sends 600
   System.out.println("left button");
 }
 else if(!thumbRightDropper && !thumbLeftDropper)//both aren't pressed
 {
   xbee.write(700);//sends 700
 }

  //Slider Controls
  if(rightPrev != thumbRight) // motor 2: 150-200
  {
   xbee.write((int)thumbRight);
   rightPrev = thumbRight;
   System.out.println("right thumb"+(int)(thumbRight));
  }
  if(leftPrev != thumbLeft) // motor 1: 50-100
  {
   xbee.write((int)thumbLeft);
   leftPrev = thumbLeft;
   System.out.println("left thumb"+(int)(thumbLeft));
  }
}
