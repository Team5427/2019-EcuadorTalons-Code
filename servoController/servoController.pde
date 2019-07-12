import processing.serial.*;

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import cc.arduino.*;
import org.firmata.*;

ControlDevice cont;
ControlIO control;

Arduino arduino;

float thumbLeft;
float thumbRight;

void setup()
{
  size(360, 200);
  
  control = ControlIO.getInstance(this);
  cont = control.getMatchedDevice("xbs");
  
  if(cont == null) {
    println("not today chump");
    System.exit(-1);
  }
  
  //println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  arduino.pinMode(3, Arduino.SERVO);
  arduino.pinMode(9, Arduino.SERVO);
 
  
}

public void getUserInput()
{
 //assign our float value
 //access the controller
 thumbLeft = map(cont.getSlider("leftStickY").getValue(), -1, 1, 6, 179);
 thumbRight = map(cont.getSlider("rightStickY").getValue(), -1, 1, 6, 179);
 println(thumbLeft);
 println(thumbRight); 
  
}

void draw(){
 getUserInput();
 background(thumbLeft,100,255);
 background(thumbRight,100,255);
 
 arduino.servoWrite(3,(int) thumbLeft); 
 arduino.servoWrite(9,(int) thumbRight);
  
}
