////////////////////////////////////////////////////////////
//               @author: Mahmoud Shaheen                 //
//         As a part of project: Motor Test Bench         //
//           Supervisor: Dr.Ing. Mohammed Ahmed           //
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// Arduino Code to measure ch/cs of a motor using Matlab  //
//  -Comunicates Serially with matlab                     //
//  -Matlab Sends a code for what function                //
//      it wants Arduino to call                          //
//      and other parameters 'if any'                     //
//  -Arduino calls that function and                      //
//      returns the output 'if any'                       //
////////////////////////////////////////////////////////////

//Arduino Pins definition
#define    motorPin        10 //motor driver enable for other motor
#define    testPin         11 //motor driver enable for motor under test
#define    tSpeedPin        2 //RPS sensor
#define    tCurrentPin     A0 //current sensor for motor under test
#define    mCurrentPin     A1 //current sensor for other motor
#define    mVoltagePin     A2 //voltage feedback for other motor

char   serialRead     =   0; //for storing serial string 'recieved'
float  serialWrite    =   0; //for storing serial string 'to be sent'
float  tempFloat      =   0; //temporary Float variable
int    tempInt        =   0; //temporary int variable 
String inString       =  ""; //for storing serial string to be converted
int    pulse          =   0; //for storing pulses from RPS sensor

void setup() {
  //Setting input/output Pins
  pinMode(  motorPin,     OUTPUT);
  pinMode(  testPin,      OUTPUT);
  pinMode(  tSpeedPin,    INPUT);
  pinMode(  tCurrentPin,  INPUT);
  pinMode(  mCurrentPin,  INPUT);
  pinMode(  mVoltagePin,  INPUT);
  //initialize Serial Communication to communicate with Matlab, with Baud rate=9600
  Serial.begin(9600);
}

//Check serial buffer for any strings from Matlab and call Corresponding Function 
void loop() {
  if(Serial.available() > 0) { //Check serial buffer if any data available
    serialRead = Serial.read(); //read string from serial buffer
    tempInt = char2Int(serialRead); //convert this string to int 'Switch accepts only int' 
     switch(tempInt){ 
       //call the Corresponding Function
       case 1:
         //turn test motor on with any voltage
         outTest();
         break;
       case 2: 
         //turn other motor on with any voltage
         outMotor();
         break;
       case 3: 
         //Calculate the speed of motors
         tSpeed();
         break;
       case 4: 
         //Calculate the current test motor using
         tCurrent();
         break;
       case 5: 
         //Calculate the current other motor using
         mCurrent();
         break;
       case 6: 
         //Calculate the voltage on other motor
         mVoltage();
         break;
       default: 
         //in case of errors
         serialWrite = -1;
         serialPrint(serialWrite);
         break; 
    }
  }
}

//turn test motor on with any voltage
void outTest() {
  while(Serial.available() <= 0){ //wait until Matlab sends voltage on serial buffer
  }
  serialRead = Serial.read(); //get the desired voltage from serial
  tempFloat = char2Float(serialRead); //converting serial string into float
  tempFloat = (tempFloat / 5) * 255; //converting voltage to PWM (0-5)->(0-255)
  analogWrite(testPin, tempFloat);  //output PWM on test motor
}

//turn other motor on with any voltage
void outMotor() {
  while(Serial.available() <= 0){ //wait until Matlab sends voltage on serial buffer
  }
  serialRead = Serial.read(); //get the desired voltage from serial
  tempFloat = char2Float(serialRead); //converting serial string into float
  tempFloat = (tempFloat / 5) * 255; //converting voltage to PWM (0-5)->(0-255)
  analogWrite(motorPin, tempFloat); //output PWM on test motor
}

//Calculate the speed of motors
void tSpeed() {
  float RPS;
  pulse = 0; //reset pulses counter
  long start = millis(); //get the current timer 'in millis'
  long finish=0; //to get the time during the loop 'in millis'
  long elapsed=0; //to calculate elapsed time for speed measurement
  //define speed sensor pin as interrupt pin to add one automatically to pulses count
  attachInterrupt(digitalPinToInterrupt(tSpeedPin), counter, RISING);
  while (elapsed <=1000 ){ //while elapsed time < 1 Sec wait 'ISR counts pulses recieved from RPS Sensor'
    finish = millis(); //get the current time 'in millis'
    elapsed = finish - start; //calculate elapsed time 'in millis'
  }
  RPS = pulse / 2; //as sensor gives 2 pulses per revolution
  serialWrite = RPS / (elapsed/1000); //speed = revs/time 'divided by 1000 to convert millis to seconds'
  serialPrint(serialWrite); //print speed on serial port
}

//adds one to pulses: used as ISR 'called when RPS sensor detects new revolution'
void counter() {
  pulse = pulse + 1;
}

//Calculate the current test motor using
void tCurrent() {
  tempFloat = analogRead(tCurrentPin); //read from test current sensor pin
  tempFloat = (tempFloat * 5) / 1024; //converting binary number to voltage (0-1024)->(0-5)
  tempFloat = tempFloat - 2; //subtracting sensor offset
  serialWrite = tempFloat / 0.185; //mapping sensor output 'Voltage' to 'Ampere', 185mV/A
  serialPrint(serialWrite); //print sensor output on serial port
}

//Calculate the current other motor using
void mCurrent() {
  tempFloat = analogRead(mCurrentPin); //read from motor current sensor pin
  tempFloat = (tempFloat * 5) / 1024; //converting binary number to voltage (0-1024)->(0-5)
  tempFloat = tempFloat - 2; //subtracting sensor offset
  serialWrite = tempFloat / 0.185; //mapping sensor output 'Voltage' to 'Ampere', 185mV/A
  serialPrint(serialWrite); //print sensor output on serial port
}

//Calculate the voltage on other motor
void mVoltage() {
  tempFloat = analogRead(mVoltagePin); //read from motor Voltage feedbaack pin
  serialWrite = tempFloat * (5 / 1024); //converting binary number to voltage (0-1024)->(0-5)
  serialPrint(serialWrite); //print sensor output on serial port
}

//accepts float variable and prints it on serial port
void serialPrint(float rSerialWrite) {
  Serial.print(rSerialWrite); //print the variable on serial port
  Serial.print('}'); //print stop char to verify data end
}

//converting array of characters to int
int char2Int (char ch){
  inString = ""; //empty the string
  inString += (char)ch; //add the array to the empty string
  int temp = inString.toInt(); //convert the string to int
  return temp; //return converted variable
}

//converting array of characters to float
float char2Float (char ch){
  inString = ""; //empty the string
  inString += (char)ch; //add the array to the empty string
  float temp = inString.toFloat(); //convert the string to float
  return temp; //return converted variable
}

