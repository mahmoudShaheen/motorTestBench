%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				@author: Mahmoud Shaheen				%%
%%		As a part of project: Motor Test Bench			%%
%%		  Supervisor: Dr.Ing. Mohammed Ahmed			%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				  motorVoltage function					%%
%%			   Returns other motor's Voltage			%%
%%						in volt			 				%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function volt = mVoltage(serialPort)
    serialWrite(serialPort,6); %tells Arduino to read motor voltage value
    volt = serialRead(serialPort); %read the voltage value Arduino sent
end