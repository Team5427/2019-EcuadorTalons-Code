//This class controls the servo motors on the Arduino using xbs, a file written 
//by processing that writes instructions for the game controller. 

//Processing that allows us to configure controller buttons
import processing.serial.*;

//Game Control Plus which allows us to use the game controller with Processing
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

//allows control of arduino controller
import cc.arduino.*;
//implements Fermata protocol for communicating with software on the host computer
import org.firmata.*;

//the game controller
ControlDevice cont;
//retrieves information about connected devices and data from them
ControlIO control;
//the Arduino controller
Arduino arduino;

//values of the sliders on the game controller
float thumbLeft;
float thumbRight;

//This method runs once at the beginning of the program. Think of this as a constructor.
void setup()
{
  //creates a window with the specified size. This will give feedback used when getting controller values. 
  size(360, 200);

  //initializes with current instance of the ControlIO, with currently connected devices
  control = ControlIO.getInstance(this);
  //initializes controller to the ControlDevice matching the configuration described in xbs
  cont = control.getMatchedDevice("xbs");

  //stops the program if the specified controller is not detected to avoid crashing
  if(cont == null) {
    println("Controller was not found");
    System.exit(-1);
  }

  //This line of code will list everything attached to COM ports on the Arduino. 
  //uncomment it and run to find the index of the serial port of your Arduino.
  //println(Arduino.list());

  //To access the serial port your Arduino is on, change the number in the square
  //brackets to match the index of the port in the list you printed above.
  arduino = new Arduino(this, Arduino.list()[2], 57600);

  //Configures the Arduino pins.
  //parameters:
    //pin- the Arduino pin number to set the mode of. Change this number to match the pins your servos are attached to.
    //mode- defines how the pin behaves
  arduino.pinMode(3, Arduino.SERVO);
  arduino.pinMode(9, Arduino.SERVO);
}

//This method gets the user input from the map
public void getUserInput()
{
 //assign our float value
 //access the controller
 thumbLeft = map(cont.getSlider("leftStickY").getValue(), -1, 1, 6, 179);
 thumbRight = map(cont.getSlider("rightStickY").getValue(), -1, 1, 6, 179);
}

//Called periodically during the program, similar to loop() in the ArduinoIDE and 
//robotPeriodic() in the FRC libraries. 
void draw()
{
 //updates the thumb values by getting the user input
 getUserInput();
 //changes color of the window, giving us a visual indicator of the change in thumb values.
 background(thumbLeft,100,255);
 background(thumbRight,100,255);

 //runs the servo motors with the specified port according to the values on the game controller.
 //Change the ports to match the wiring of your Arduino.
 //parameters:
   //port- the port of the servo being controlled.
   //angle- the value used to determine how much power to give to the servo.
 arduino.servoWrite(3,(int) thumbLeft); 
 arduino.servoWrite(9,(int) thumbRight);
  
}
