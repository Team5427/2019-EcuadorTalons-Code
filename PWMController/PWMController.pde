//Sai Juttu

/* 
   •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••          
   §                                                                   §
   §   This class takes input from a Wired Xbox Controller and send    §
   §   the data via XBees through serial communication to an Arduino   §
   §   which decodes byte information in order to control PWM Motors   §
   §                                                                   §
   •••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
   
   Todo:
   ¶ test for trigger functionality
   ¶ make a user interface to display all the inputs of the controller
   ¶ retest with new code
   
*/


import processing.serial.*;            //Library import for Serial Communication via XBee
  
import net.java.games.input.*;         //Game Control Plus library import which allows us to use the Xbox Controller with Processing
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.ControlHat;

ControlDevice cont;    //The Game Controller
ControlIO control;     //Retrieves information from every method of input on a controller (buttons and joysticks)

Serial xbee;           //the xbee adapter that is connected to the Arduino

ControlHat dpad;       //dpad 

float leftY;           //left joystick Y-axis
float leftX;           //left joystic X-axis
float rightY;          //right joystick Y-axis
float rightX;          //right joystick X-axis
float lYPrev;          //previous left joystick Y value
float lXPrev;          //previous left joystick X value
float rYPrev;          //previous right joystick Y value
float rXPrev;          //previous right joystick X value

float triggerLeft;     //"LB" button
float triggerRight;    //"RB" button
float lPrev;           //previous left trigger value
float rPrev;           //previous right trigger value

boolean buttonLeft;    //"LB" button
boolean buttonRight;   //"RB" button

//boolean dPadUp;        //d-pad up
//boolean dPadDown;      //d-pad down
//boolean dPadRight;     //d-pad right
//boolean dPadLeft;      //d-pad left

boolean buttonA;       //"A" button
boolean buttonB;       //"B" button
boolean buttonX;       //"X" button
boolean buttonY;       //"Y" button

boolean buttonShare;   //the two screens button
boolean buttonHome;    //the xbox button
boolean buttonMenu;    //the three lined button
boolean stickInLeft;   //push the left joystick in
boolean stickInRight;  //push the right joystick in

void setup()                                               //This method runs once at the beginning of the program to setup everything
{    
  
      size(360, 200);                                      //Creates a window with the specified pixel size. This will give feedback used when getting controller values. 
      println(Serial.list());                              //This line of code will list everything attached to COM ports on the Arduino. Run to find the index of the serial port of your Arduino.

      control = ControlIO.getInstance(this);               //Initializes with current instance of the ControlIO, with currently connected devices.
      cont = control.getMatchedDevice("controllerconfig"); //Initializes controller to the ControlDevice matching the configuration described in the file, "xbs".
      if(cont == null)                                     //Stops the program if the specified controller is not detected to avoid crashing
      {                       
        println("Controller was not found!");
        System.exit(-1);
      }
//xbee = new Serial(this, Serial.list()[2], 9600);
    
}
void draw()                                                                 //runs ins a loop like in ArduinoIDE until the program is stopped
{
     getUserInput();                                                        //Updates the thumb values by getting the user input
     communicate();                                                         //sends data to the xbee
     background(rightY,100,255);                                            //Changes color of the window, giving us a visual indicator of the change in thumb values. (only one stick tho)

}
public void getUserInput()                                                                  //This method gets the user input from the map
{  
     dpad            = cont.getHat("dpad");                                                //
     leftY           = map(cont.getSlider("leftY").getValue(), -1, 1, 50, 100);            //assign a float value for the position of the left joystick in the y axis from 50 to 100
     leftX           = map(cont.getSlider("leftX").getValue(), -1, 1, 150, 200);           //assign a float value for the position of the left joystick in the x axis from 150 to 200
     rightY          = map(cont.getSlider("rightY").getValue(), -1, 1, 250, 300);          //assign a float value for the position of the right joystick in the y axis from 250 to 300
     rightX          = map(cont.getSlider("rightX").getValue(), -1, 1, 350, 400);          //assign a float value for the position of the right joystick in the x axis from 350 to 300
     lYPrev = 0;                                                                           //setup the latest position for the left joystick in the y axis
     lXPrev = 0;                                                                           //setup the latest position for the left joystick in the x axis
     rYPrev = 0;                                                                           //setup the latest position for the right joystick in the y axis
     rXPrev = 0;                                                                           //setup the latest position for the right joystick in the x axis
    
     triggerLeft     = map(cont.getSlider("lt").getValue(), -1, 1, 450, 500);              //assign the float value for the position of the left trigger from 450 to 500
     triggerRight    = map(cont.getSlider("rt").getValue(), -1, 1, 550, 600);              //assign the float value for the position of the right trigger from 550 to 600
     lPrev = 0;                                                                            //setup the latest position for the left trigger
     rPrev = 0;                                                                            //setup the latest position for the right trigger
     
     buttonLeft      = cont.getButton("lb").pressed();                                     //assign the current status of the left button
     buttonRight     = cont.getButton("rb").pressed();                                     //assign the current status of the right button
    
     //dPadUp          = cont.getButton("up").pressed();                                   //assign the current status of the d-pad up button
     //dPadDown        = cont.getButton("down").pressed();                                 //assign the current status of the d-pad down button
     //dPadRight       = cont.getButton("right").pressed();                                //assign the current status of the d-pad right button
     //dPadLeft        = cont.getButton("left").pressed();                                 //assign the current status of the d-pad left button
    
     buttonA         = cont.getButton("a").pressed();                                      //assign the current status of the a button
     buttonB         = cont.getButton("b").pressed();                                      //assign the current status of the b button
     buttonX         = cont.getButton("x").pressed();                                      //assign the current status of the x button
     buttonY         = cont.getButton("y").pressed();                                      //assign the current status of the y button
    
     buttonShare     = cont.getButton("share").pressed();                                  //assign the current status of the share button
     buttonHome      = cont.getButton("home").pressed();                                   //assign the current status of the home button
     buttonMenu      = cont.getButton("options").pressed();                                   //assign the current status of the menu button
     stickInLeft     = cont.getButton("leftstickbutton").pressed();                        //assign the current status of the left stick in button
     stickInRight    = cont.getButton("rightstickbutton").pressed();                       //assign the current status of the right stick in button
     
}
public void communicate()
{
  /* 
   •••••••••••••••••••••••••••••••••••••••••••••••••••••••   
   §                                                     §
   §   ByteCodes                                         §
   §                                                     §
   §   leftY        50-100       buttonA       621-622   §
   §   leftX        150-200      buttonB       623-624   §
   §   rightY       250-300      buttonX       625-626   §
   §   rightX       350-400      buttonY       627-628   §
   §   triggerLeft  450-500      buttonShare   631-632   §
   §   triggerRight 550-600      buttonHome    633-634   §
   §                             buttonMenu    635-636   §
   §   buttonLeft   601-602      stickInLeft   637-638   §
   §   buttonRight  603-604      stickInRight  639-640   §
   §   dPadUp       611-612      dpadupright   641-642   §
   §   dPadDown     613-614      dpadrightdown 643-644   §
   §   dPadRight    615-616      dpaddownleft  645-646   §
   §   dPadLeft     617-618      dpadleftup    647-648   §
   §                                                     §
   •••••••••••••••••••••••••••••••••••••••••••••••••••••••
   
   
*/     
      
     //Float Controls
     
     //if(lYPrev != leftY)                                         //Left Joystick Y
     //{
     //   xbee.write((int)leftY);
     //   lYPrev = leftY;
     //   System.out.println("left joy y"+(int)(leftY));
     //}
     //if(lXPrev != leftX)                                         //Left Joystick X
     //{
     //   xbee.write((int)leftX);
     //   lXPrev = leftX;
     //   System.out.println("left joy x"+(int)(leftX));
     //}
     //if(rYPrev != rightY)                                        //Right Joystick Y
     //{
     //   xbee.write((int)rightY);
     //   rYPrev = rightY;
     //   System.out.println("right joy y"+(int)(rightY));
     //}
     //if(rXPrev != rightX)                                        //Right Joystick X
     //{
     //   xbee.write((int)rightX);
     //   rXPrev = rightX;
     //   System.out.println("right joy x"+(int)(rightX));
     //}
     //if(lPrev != triggerLeft)                                    //Left Trigger
     //{
     //   xbee.write((int)triggerLeft);
     //   lPrev = triggerLeft;
     //   System.out.println("left trigger"+(int)(triggerLeft));
     //}
     //if(rPrev != triggerRight)                                   //Right Trigger
     //{
     //   xbee.write((int)triggerRight);
     //   rPrev = triggerRight;
     //   System.out.println("right trigger"+(int)(triggerRight));
     //}
     
     //Boolean Controlls
     
     //if(buttonLeft)                                             //left button on
     //{ xbee.write(601); System.out.println("left button"); }
     //else                                                       //left button off
     //{ xbee.write(602); }
     
     //if(buttonRight)                                            //right button on 
     //{ xbee.write(603); System.out.println("right button"); }
     //else                                                       //right button off 
     //{ xbee.write(604); }
     
     ////button  style dpad
     ////if(dPadUp)                                                 //dpad up on
     ////{ xbee.write(611); System.out.println("up"); }
     ////else                                                       //dpad up off
     ////{ xbee.write(612); }
     
     ////if(dPadDown)                                               //dpad down on 
     ////{ xbee.write(613); System.out.println("down"); }
     ////else                                                       //dpad down off 
     ////{ xbee.write(614); }
     
     ////if(dPadRight)                                              //dpad right  on 
     ////{ xbee.write(615); System.out.println("right"); }
     ////else                                                       //dpad right off 
     ////{ xbee.write(616); }
     
     ////if(dPadLeft)                                               //dpad left on 
     ////{ xbee.write(617); System.out.println("left"); }
     ////else                                                       //dpad left off 
     ////{ xbee.write(618); }
     
     ////hat style dpad
     //if(dpad.up() && !dpad.left() && !dpad.right())                //dpad up
     //{ xbee.write(611); }
     //else
     //{ xbee.write(612); }
     
     //if(dpad.up() && dpad.right())                                //dpad up and right
     //{ xbee.write(641); }
     //else
     //{ xbee.write(642); }
     
     //if(dpad.right() && !dpad.up() && !dpad.down())               //dpad right
     //{ xbee.write(615); }
     //else
     //{ xbee.write(616); }
     
     //if(dpad.right() && dpad.down())                              //dpad right and down 
     //{ xbee.write(643); }
     //else
     //{ xbee.write(644); }
     
     //if(dpad.down() && !dpad.left() && !dpad.right())             //dpad down
     //{ xbee.write(613); }
     //else
     //{ xbee.write(614); }
     
     //if(dpad.down() && dpad.left())                              //dpad down and left
     //{ xbee.write(645); }
     //else
     //{ xbee.write(646); }
     
     //if(dpad.left() && !dpad.up() && !dpad.down())               //dpad left
     //{ xbee.write(617); }
     //else
     //{ xbee.write(618); }
     
     //if(dpad.left() && dpad.up())                                //dpad left and up
     //{ xbee.write(647); }
     //else
     //{ xbee.write(648); }
     
     ////abxy buttons
     //if(buttonA)                                                //button a on
     //{ xbee.write(621); System.out.println("A"); }
     //else                                                       //button a off
     //{ xbee.write(622); }
     
     //if(buttonB)                                                //button b on
     //{ xbee.write(623); System.out.println("B"); }
     //else                                                       //button b off
     //{ xbee.write(624); }
     
     //if(buttonX)                                                //button x on
     //{ xbee.write(625); System.out.println("X"); }
     //else                                                       //button x off
     //{ xbee.write(626); }
     
     //if(buttonY)                                                //button y on
     //{ xbee.write(627); System.out.println("Y"); }
     //else                                                       //button y off
     //{ xbee.write(628); }
     
     ////options buttons
     //if(buttonShare)                                            //share button on 
     //{ xbee.write(631); System.out.println("share"); }
     //else                                                       //share button off 
     //{ xbee.write(632); }
     
     //if(buttonHome)                                             //home button on
     //{ xbee.write(633); System.out.println("home"); }
     //else                                                       //home button off
     //{ xbee.write(634); }
     
     //if(buttonMenu)                                             //menu button on 
     //{ xbee.write(635); System.out.println("menu"); }
     //else                                                       //menu button off
     //{ xbee.write(636); }
     
     ////push stick buttons
     //if(stickInLeft)                                            //left stick in on
     //{ xbee.write(637); System.out.println("left stick in"); }
     //else                                                       //left stick in off
     //{ xbee.write(638); }
     
     //if(stickInRight)                                           //right stick in on
     //{ xbee.write(639); System.out.println("right stick in"); }
     //else                                                       //right stick in off
     //{ xbee.write(640); }
     
     
}
