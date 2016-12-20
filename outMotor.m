%%Set the known motor output voltage
function outMotor(serialPort,volt)
	%temp=fscanf(serialPort,'%s');%empty the serial buffer in Arduino
	pause(0.1);
	fwrite(serialPort,'2');
	%temp=fscanf(serialPort,'%s');%empty the serial buffer in Arduino
	pause(0.1);
    s = num2str(volt);
	fwrite(serialPort,s);
end