%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				@author: Mahmoud Shaheen				%%
%%		As a part of project: Motor Test Bench			%%
%%		  Supervisor: Dr.Ing. Mohammed Ahmed			%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%					  Main Program						%%
%%			open serial connection with Arduino			%%
%%				and Call test functions					%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

				%Serial Communication%
%Serial parameters
com 		=	'Com5'		%Arduino communication port 'adjust this according to your Arduino port'
baudRate 	= 	9600		%Serial data rate between Arduino and Matlab
timeout 	= 	10			%how much time to wait for the terminator 'adjust this according to sensor's delay'
terminator 	= 	{'}','}'}	%terminator for read and write 'according to Arduino code'

%initialize serial connection and set it to match Arduino code
serialPort = serial(com, 'BaudRate', baudRate, 'timeout', timeout, 'terminator', terminator);

%open communication port 'serial' with Arduino
fopen(serialPort);

				%Call Test Functions%

%start no load test 'calculates and plots test motor's "applied voltage VS. speed and Current"'
%and returns average efficiency for other motor 'used to calculate applied torque in load test'
averageEfficiency = noLoadTest(serialPort);

%start load test 'calculates and plots "applied torque 'from other motor' VS. current and speed"'
%calculates applied torque using average efficiency of the other motor
loadTest(serialPort, averageEfficiency);

%stop the communication with Arduino and close serial port
fclose(instrfind);
