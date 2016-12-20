%%Set the test motor output voltage
function outTest(serialPort,volt)
	%temp=fscanf(serialPort,'%s');%empty the serial buffer in Arduino
	pause(0.1);
	fwrite(serialPort,'1');
	%temp=fscanf(serialPort,'%s');%empty the serial buffer in Arduino
	pause(0.1);
    s = num2str(volt);
	fwrite(serialPort,s);
end