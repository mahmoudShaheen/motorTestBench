%%Returns test motor current current in (Ampere)
function current = tCurrent(serialPort)
	%rCurrent=fscanf(serialPort,'%s');%empty the serial buffer in Arduino
	pause(0.1);
    fwrite(serialPort,'4');
    rCurrent = fscanf(serialPort,'%s');
    rCurrent = rCurrent(1:end-1);
    current = str2double(rCurrent);
end