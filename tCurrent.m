%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				@author: Mahmoud Shaheen				%%
%%		As a part of project: Motor Test Bench			%%
%%		  Supervisor: Dr.Ing. Mohammed Ahmed			%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				  testCurrent function					%%
%%			   Returns test motor's Current				%%
%%						in Ampere		 				%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function current = tCurrent(serialPort)
    serialWrite(serialPort, 4);  %tells Arduino to read test motor Current value
    Current = serialRead(serialPort); %read the Current value Arduino sent
end