# motorTestBench
Given any motor with unknown characteristics, 
the project aims to get and plot the characteristics of this motor 
with the help of a known motor that works as a reference.

The project uses Arduino and Matlab to get the characteristics of the motor 
using serial ports as a means of communication.

The Main program named: dControl.

•	We connected two motors to one another 
•	The current sensor is connected in series with the main motor.
•	RPM sensor is connected on the other side of the motor where the pierced wheel is connected.
•	Whenever a hole in the wheel is passed, we get a pulse.
•	Knowing the number of holes in the wheel, the number of pulses and the time the sensor took to calculate the pulses we can calculate the RPM.
•	As for the voltage it’s very strait forward, we need to connect an analog pin to the motor 2 (+) and Arduino’s ground to motor 2 (-).
•	We will also need to output a varying voltage to drive the motor and to be able to calculate the Characteristics at different applied voltage.
•	Arduino’s current won’t drive the motor so we used a motor driver L293D to drive the motor.
•	Arduino’s analogWrite function uses PWM method to output voltage, we use this method to tell the motor driver L293D what to do.
