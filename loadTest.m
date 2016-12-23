	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%%				@author: Mahmoud Shaheen				%%
	%%		As a part of project: Motor Test Bench			%%
	%%		  Supervisor: Dr.Ing. Mohammed Ahmed			%%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%						loadTest function						%%
%%			Apply static Voltage  on test motor = 5V			%%
%%			 Apply Voltage gradually on other motor 			%%
%% 			  other motor moves in other direction 				%%
%%			with respect to test motor moving direction			%%
%%		 use averageEfficiency to calculate applied torque		%%
%%				now we managed to apply torque					%%
%%		 speed and current of test sensore are calculated		%%
%%		  				Also plots results						%%
%%		  'Assuming friction between the 2 motors = 0'			%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function loadTest(serialPort, averageEfficiency)
	%%apply Constant test motor Voltage = 5V
	outTest(serialPort,5);
	
	%temp arrays for plotting
	x = [0 0];	%Applied Torque
	y = [0 0];	%Test Speed
	z = [0 0];	%Test Current
	
	%Plotting
	figure, title('load Test')
	
	subplot(2,1,1);
	%properties
	title('Speed')
	xlabel('Applied Torque mN.M')
	ylabel('Speed RPS')
	hold on
	grid on
	
	subplot(2,1,2);
	%properties
	title('Current')
	xlabel('Applied Torque mN.M')
	ylabel('Current "Ampere"')
	hold on
	grid on
	
	%test parameters
	startVolt = 1;
	endVolt = 5;
	step = 0.5;
	
	for volt = startVolt:step:endVolt
		outMotor(serialPort,volt); %apply the voltage on other motor
		pause(0.1); %wait for motor response
		
		%mapping steps to arrays index
		index				=	(volt-step)/step;
        index = index +1 ;
		
		%measure test parameters and put them in corresponding arrays
		%%test motor parameters
		testVoltage(index)	=	volt;
		testSpeed(index)	=	tSpeed(serialPort);
		testCurrent(index)	=	tCurrent(serialPort);
		
		%calculate applied torque
		appliedTorque(index)	=	(testCurrent(index)*testVoltage(index)*averageEfficiency*1000)/testSpeed(index); %in (mN.M)
		
		%put test motor parameters in Temp arrays 'for real-time plotting'
		if index > 1 %to skip first index 'wait for the second index to draw a line'
			x =  [	x    [	appliedTorque(index-1)	appliedTorque(index)]  ];
            y =  [	y	 [	testSpeed(index-1)		testSpeed(index)	]  ];
            z =  [	z	 [	testCurrent(index-1)	testCurrent(index)	]  ];
		end
		
		%Real Time Plotting
		subplot(2,1,1);
		plot(x,y);
		
		subplot(2,1,2);
		plot(x,z);
	end
	outTest(serialPort,0); %Stop the test motor
	outMotor(serialPort,0); %Stop the other motor
end