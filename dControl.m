%Main
%open serial connection with Arduino and Call test functions
%initialize serial connection and set it to match Arduino code
serialPort = serial('Com5', 'BaudRate', 9600, 'timeout', 10, 'terminator', {'}','}'});

fopen(serialPort);

%Call Test Functions
averageEfficiency = noLoadTest(serialPort);
loadTest(serialPort, averageEfficiency);
fclose(instrfind);
