%% Nicrome Wire Calculator
% Cost data from http://www.jacobs-online.biz/nichrome_v_wire.htm
desired_amps = 270; % Amps
desired_gauge = 22; % Gauge
desired_voltage = 270; % Volts
desired_time = 300; % seconds

switch desired_gauge
	case 12
		resistancePerFoot = 0.1; % Ohm/ft
		costPerFoot = 30/33.25; % $/ft
		maxCurrent = 65; %amps
		diameter = 2.057; %mm
		
	case 22
		resistancePerFoot = 1.02;
		costPerFoot = 21/150;
		maxCurrent = 12;
		diameter = 0.643; % mm

	otherwise
		fprintf('Bad Gauge size, select different size or add case.\n');
		return
end

% Electrical Properties
% I = V/R
maxResistance = desired_voltage/desired_amps;
neededResistance = desired_voltage/maxCurrent;
neededLength = ceil(neededResistance/resistancePerFoot);
%1/R = numParallel * (1/R)
numParallel = ceil(neededLength*resistancePerFoot/maxResistance);
totalLength = neededLength*numParallel;
totalCost = costPerFoot*totalLength;

% Thermal Properties (Not working correctly)
thermalConductivityNichrome = 11.3; % W/m-K
thermalConductivityAir = 2E-2;

surfaceArea = pi*diameter/1000;

dt = 0.01; 
kappa = dt*thermalConductivityAir*surfaceArea;
t = 0:dt:desired_time;

wireTemp = ones(size(t))*25.1;
airTempIntake = wireTemp; % degC
airTempOutlet = airTempIntake;

for i=2:size(t,2)
	wireTemp(i) = wireTemp(i-1) + resistancePerFoot*maxCurrent*dt;
	wireTemp(i) = wireTemp(i)  - (wireTemp(i-1) - airTempIntake(i-1))*kappa;
	airTempOutlet(i) = (wireTemp(i-1) - airTempIntake(i-1))*kappa;
end
%plot(t, wireTemp);

fprintf('To meet the desired characteristics, use the following design\n');
fprintf('Total Length: %2.1f ft\tParallel Strands %d\tStrand Length: %2.1f ft\n', totalLength, numParallel, neededLength);
fprintf('using %d gauge wire with %d amps in each strand\n', desired_gauge, maxCurrent);
fprintf('Estimated Cost for the wire is $%3.2f\n', totalCost);