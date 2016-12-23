	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%				@author: Mahmoud Shaheen				%%
	%%		As a part of project: Motor Test Bench			%%
	%%		  Supervisor: Dr.Ing. Mohammed Ahmed			%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%						loadTest function						%%
%%				Apply Voltage gradually on test motor			%%
%%					and measure speed and current 				%%
%%			Also calculates averageEfficiency of other motor	%%
%% which is used to calculate applied torque later in load test	%%
%%		 so other motor parameters need not to be known			%%
%%		  'Assuming friction between the 2 motors = 0'			%%
%% 'and other motor doesn't require any torque to start moving'	%%
%%						Also plots results						%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function averageEfficiency = noLoadTest(serialPort)
	%temp arrays for plotting
	x = [0 0];	%Test voltage
	y = [0 0];	%Test Speed
	z = [0 0];	%Test Current
	
	%Plotting
	figure, title('No load Test')
	
	subplot(2,1,1);
	%properties
	title('Speed')
	xlabel('Applied Voltage')
	ylabel('Speed RPS')
	hold on
	grid on
	
	subplot(2,1,2);
	%properties
	title('Current')
	xlabel('Applied Voltage')
	ylabel('Current "Ampere"')
	hold on
	grid on
	
	%test parameters
	startVolt = 1;
	endVolt = 5;
	step = 0.5;
    
	%start test
	for volt = startVolt:step:endVolt
		outTest(serialPort,volt); %apply the voltage on test motor
		pause(0.1); %wait for motor response
		
		%mapping steps to arrays index
		index 				= 	(volt-step)/step; 
        index = index +1 ;
		
		%measure test parameters and put them in corresponding arrays
		%test motor parameters
		testVoltage(index)	=	volt;
		testSpeed(index)	= 	tSpeed(serialPort);
		testCurrent(index)	= 	tCurrent(serialPort);
		
		%other motor parameters 'for calculating motor efficiency'
		motorVoltage(index)	=	mVoltage(serialPort);
		motorCurrent(index)	=	mCurrent(serialPort);
		
		Pout				= 	motorVoltage(index)	*	motorCurrent(index);
		Pin					=	testVoltage(index)	*	testCurrent(index);
		
		efficiency(index) 	= 	Pout / Pin;
		
		%put test motor parameters in Temp arrays 'for real-time plotting'
        if index > 1 %to skip first index 'wait for the second index to draw a line'
            x =  [	x    [	testVoltage(index-1)	testVoltage(index)	]  ];
            y =  [	y	 [	testSpeed(index-1)		testSpeed(index)	]  ];
            z =  [	z	 [	testCurrent(index-1)	testCurrent(index)	]  ];
        end 
		
		%Plotting
		subplot(2,1,1);
		plot(x,y);
		
		subplot(2,1,2);
		plot(x,z);
	end
	outTest(serialPort,0); %Stop the test motor
	averageEfficiency=mean(efficiency); %%calculate other motor average efficiency
end