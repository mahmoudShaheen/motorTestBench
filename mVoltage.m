%%Returns known motor current rVoltage in (rVolt)
function volt = mVoltage(serialPort)
	%rVolt=fscanf(serialPort,'%s');%empty the serial buffer in Arduino
	pause(0.1);
    fwrite(serialPort,'6');
    rVolt = fscanf(serialPort,'%s');
    rVolt = rVolt(1:end-1);
    volt = str2double(rVolt);
end