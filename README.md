Install Links
Arduino IDE - https://www.arduino.cc/en/main/software
*make sure to download the latest version of Arduino IDE for your operating system
Processing - https://processing.org/download/
* make sure to download the latest version of Processing for your operating system
X-CTU - https://www.digi.com/products/iot-platform/xctu#productsupport-utilities 
*make sure to download the latest version of X-CTU for your operating system
*premade files - https://github.com/Team5427/2019-EcuadorTalons-Code

Arduino IDE Setup
*after installation, open the Arduino IDE and select Tools<Board<”Arduino/Genuino Uno”
*plug in your Arduino Uno via usb cable and then proceed to Tools<Port<(select your port which is connected to the arduino)
*now proceed to File<Examples<Firmata<StandardFirmata and upload this to your Arduino Uno via the upload button near the top left

Programming Setup
*after installation go to Sketch<Import Library<Add Library
Add “Game Control Plus”
Add “Arduino (Firmata)”
Add “G4P”
Add each library by clicking install near the bottom.

Testing Processing to Arduino Communication
Refer to the example files for everything below-
*Go to File<Examples<Arduino (Firmata)<arduino_servo
*Run ‘arduino_servo’ and look in the array in the console to find which index your communication port is in
Example: usb1 usb2 usb3
			    ^
*this would be in index 2 as we start with 0
*Change the index in the code to match your port
	Example: arduino = new Arduino(this, Arduino.list()[2], 57600);
										   ^
	*for this example our index was ‘2’
*Change the code for the pins the motor is attached to
Example:  arduino.pinMode(3, Arduino.SERVO);
				    ^
    arduino.pinMode(9, Arduino.SERVO);
			    ^
*change your values to the pins your motors are attached to on the Arduino Uno and add or remove commands depending on the number of motors
*match the pin number for the arduino.servoWrite command
	Example: arduino.servoWrite(3, constrain(mouseX / 2, 0, 180));
						 ^
    arduino.servoWrite(9, constrain(mouseX / 2, 0, 180));
						 ^
*change your values to the pins your motors are attached to on the Arduino Uno and add or remove commands depending on the number of motors
*press play in the top right corner to run the program and move the mouse to the right and left in the new window to change the speed of the motor

Configuring Your Xbox Controller
*Go to File<Examples<Game Control Plus<Configurator
*run the program and select your Xbox Controller by clicking on the green button to the left of the entry
*now enter the information in this order and connect the pink tabs to their respective inputs(if the inputs do not match up press the buttons on the controller and ensure your are connecting the right names to the right input tabs)
	Key name:		Description:			Input:
	LT			the LT button			z
	RT			the Rt button			rz
	LB			the LB button			4
	RB			the RB button			5
	leftStickX		the left thumbstick x		x
	leftStickY		the left thumbstick y		y
	rightStickX	the right thumbstick x	rx
	rightStickY	the right thumbstick y	ry
	up			d-pad up				11
	down			d-pad down				12
	left			d-pad left				13
	right			d-pad right			14
	a			a button				0
	b			b button				1
	x	  		x button				2
	y	 		y button				3
	home			xbox button			10
	menu			the three lined button	8
	share			the two screens button	9
	leftStickIn	push the left stick in	6
	rightStickIn	push the right stick in	7
*now type “controls the arduino with the controller” in ‘Device Role’
*type “xbs” in ‘Filename’
*click ‘Verify’ then if there are no issues then click ‘Save’

Connecting the Controller through Code
*first open an empty sketch File<New then save it File<Save As (name it servoController
*open the file explorer Documents<Processing<libraries<GameControlPlus<examples<Configurator and copy the ‘data’ folder.
*paste the data folder in Documents<Processing<servoController
*now in servoController in Processing click on Sketch<Import Library... and import the following:
Arduino (Firmata)
Game Control Plus
Serial
* now for the code view the code file in GitHub with the annotations

Running Your Program
*now run your code while your xbox controller is plugged in



Xbee Setup
*place the xbee on the explorer adapter and plug it into a computer OR 	make the following connections from the xbee to the arduino uno:
	XBEE -- Arduino
	Pin1 → 3.3v
	Pin10 → GND
	Pin2 Tx → Tx
	Pin3 Rx → Rx
Then connect the RST pin on the Arduino to the GND pin on the Arduino (this is to bypass the Bootloader)
*plug in the arduino uno with the xbee attached or the adapter(make sure that xbees are plugged in)
*right click on the windows logo and open ‘Device Manager’ then navigate to PORTS and note down the com ports for the xbee and the arduino uno
*on XCTU search for a device select the correct com ports and click next
*leave the port parameters on default: 9600;8;none;1;none and click finish and select both devices and click add selected devices
*click on the first radio and select update firmware and select ‘ZIGBEE TH Reg’ under Function Set and select the latest firmware and click finish to upgrade the firmware and click ok when finished
*now to configure the first xbee as a coordinator set the ‘ID PAN ID’ to ‘1234’
*now set the ‘DL Destination Address Low’ to ‘FFFF’
*now for the ‘NI Node Identifier’ enter ‘COORDINATOR’
*now set the ‘AP API Enable’ to ‘Transparent mode[0]’ or just leave it default
*now set the ‘CE Coordinator Enable’ to ‘Enabled[1]’  and click ‘Write radio settings’ or the pencil icon
*now click on the second radio to configure it as router and update the firmware like before
*set the ‘ID PAN ID’ as ‘1234’
*set the ‘JV Channel Verification’ to ‘Enabled[1]’
*set the ‘CE Coordinator Enable’ to ‘Disabled[0]’ and write the radios

Testing the Xbees
*delete the second radio from X-CTU and click on the first one
*now open another instance of X-CTU click on search and select the com port of the second radio, leave all the settings as default and add the second radio 
*now click on the radio to load the settings
*now name it under ‘NI Node Identifier’ ‘ROUTER’ and click the pencil to the right of  it to upload the changes
*place the windows side by side (router on the left and coordinator on the right)
*click on the terminal icon (on the top right computer monitor) then click on the serial close buttons(top left ish plugs closing) on both windows
*now type in the console on one to see it on the second one (transmitted message is in blue and received characters are in red)

