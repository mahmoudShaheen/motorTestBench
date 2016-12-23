%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				@author: Mahmoud Shaheen				%%
%%		As a part of project: Motor Test Bench			%%
%%		  Supervisor: Dr.Ing. Mohammed Ahmed			%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%					outTest function					%%
%%			set the test motor output voltage			%%
%%				using the received value 				%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function outTest(serialPort, volt)
	serialWrite(serialPort,1); %tells Arduino to choose outTest function 
								 %and to wait for a voltage value
	
	serialWrite(serialPort,volt); %send the voltage value to Arduino
									%to put it on test motor pin
end