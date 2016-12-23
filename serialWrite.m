%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				@author: Mahmoud Shaheen				%%
%%		As a part of project: Motor Test Bench			%%
%%		  Supervisor: Dr.Ing. Mohammed Ahmed			%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				  serialWrite function					%%
%%			takes a number, convert it to string		%%
%%					send it on serial port 				%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function serialWrite(serialPort, serialValue)
    serialString = num2str(serialValue); %convert received number into a string to avoid errors
	fwrite(serialPort, serialString); %send the string on the serial port to Arduino
	pause(0.1); %pause to avoid errors due to serial communication delay
end