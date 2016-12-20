%%load test "Apply load and calculate torque, position"
function loadTest(serialPort, averageEfficiency)
	%%Constant test motor voltage
	outTest(serialPort,5);
	
	%temp arrays for plotting
	x = [0 0];	%Applied Torque
	y = [0 0];	%Test Speed
	z = [0 0];	%Test Current
	
	%Plotting
	figure;
	title('load Test')
	
	subplot(2,1,1);
	%properties
	title('Speed')
	xlabel('Applied Torque mN.M')
	ylabel('Speed RPM')
	
	subplot(2,1,2);
	%properties
	title('Current')
	xlabel('Applied Torque mN.M')
	ylabel('Current "Ampere"')
	
	%test parameters
	startVolt = 1;
	endVolt = 5;
	step = 0.5;
	
	for volt = startVolt:step:endVolt
		%%PWM
		outMotor(serialPort,volt);
		
		pause(0.1); 
		index				=	(volt-step)/step;
        index = index +1 ;
		
		%Measured Values
		testVoltage(index)	=	volt;
		testSpeed(index)	=	abs(tSpeed(serialPort));
		testCurrent(index)	=	abs(tCurrent(serialPort));
		
		appliedTorque(index)	=	(testCurrent(index)*testVoltage(index)*averageEfficiency*1000)/testSpeed(index); %in (mN.M)
		
		%Set Values for Temp arrays 
		if index > 1
			tx = [	appliedTorque(index-1)	appliedTorque(index)];
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
	outMotor(serialPort,0); %Stop the known motor
end