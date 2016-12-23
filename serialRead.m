%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				@author: Mahmoud Shaheen				%%
%%		As a part of project: Motor Test Bench			%%
%%		  Supervisor: Dr.Ing. Mohammed Ahmed			%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				  serialRead function					%%
%%			reads a string from serial buffer,			%%
%%		  remove terminator, convert it to float 		%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function serialFloat = serialRead(serialPort)
	pause(0.1); %pause to avoid errors due to serial communication delay
    serialString = fscanf(serialPort,'%s'); %read from serial port and save the string to 'serialString'
	serialString = serialString(1:end-1);   %remove the terminator '}' from serial string
    serialFloat = str2double(serialString); %convert the string to a number
end