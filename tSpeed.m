%%Returns test motor current speed in (RPM)
function RPM = tSpeed(serialPort)
    %rRPM=fscanf(serialPort,'%s');%empty the serial buffer in Arduino
	pause(0.1);
	fwrite(serialPort,'3');
    pause(2);
    rRPM=fscanf(serialPort,'%s');
    rRPM=rRPM(1:end-1);
    rRPM=str2double(rRPM);
    RPM = rRPM; 
end