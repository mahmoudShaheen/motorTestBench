%% No load test "Apply voltage and calculate speed, current"
function averageEfficiency = noLoadTest(serialPort)
	%temp arrays for plotting
	x = [0 0];	%Test voltage
	y = [0 0];	%Test Speed
	z = [0 0];	%Test Current
	
	%Plotting
	figure;
	title('No load Test')
	
	subplot(2,1,1);
	%properties
	title('Speed')
	xlabel('Applied Voltage')
	ylabel('Speed RPM')
	
	subplot(2,1,2);
	%properties
	title('Current')
	xlabel('Applied Voltage')
	ylabel('Current "Ampere"')

	%test parameters
	startVolt = 1;
	endVolt = 5;
	step = 0.5;
    
	%start test
	for volt = startVolt:step:endVolt
		%%PWM
		outTest(serialPort,volt);
		pause(0.1);
		index 				= 	(volt-step)/step;
        index = index +1 ;
		
		testVoltage(index)	=	volt;
		testSpeed(index)	= 	abs(tSpeed(serialPort));
		testCurrent(index)	= 	abs(tCurrent(serialPort));
		
		motorVoltage(index)	=	abs(mVoltage(serialPort));
		motorCurrent(index)	=	abs(mCurrent(serialPort));
		
		Pout				= 	motorVoltage(index)	*	motorCurrent(index);
		Pin					=	testVoltage(index)	*	testCurrent(index);
		
		efficiency(index) 	= 	Pout / Pin;
		
		%Set Values for Temp arrays 
        if index > 1
            tx = [	testVoltage(index-1)	testVoltage(index)	];
            ty = [	testSpeed(index-1)		testSpeed(index)	];
            tz = [	testCurrent(index-1)	testCurrent(index)	];
            x =  [	x   tx  ];
            y =  [	y	ty  ];
            z =  [	z	tz  ];
        end 
		
		%Real Time Plotting
		subplot(2,1,1);
		plot(x,y);
		
		subplot(2,1,2);
		plot(x,z);
	end
	outTest(serialPort,0); %Stop the test motor
	averageEfficiency=mean(efficiency); %%test motor average efficiency
end