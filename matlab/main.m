%% Beginning of scirpt for testing Navigation Algorithms
% Started December 8, 2017
% Contact Justin with any questions
clear; clc; 
dt = 0.1;
x = 5;

accFile = 'acceleration.csv';
aRaw = csvread(accFile);
n = size(aRaw,1);


aCurr = sum(aRaw(1:x))/(x+1);

vRaw = zeros(n,1);
xRaw = zeros(n,1);

aSmooth = vRaw;
vSmooth = vRaw;
xSmooth = vRaw;

aSensor = vRaw; % Noisey data from IMU
aBuffer = zeros(x,1); % This is what the pod gets
xLastStrip = 0;

for i=x+1:n
	aSensor(i) = get_acc(i);
	aBuffer(mod(i,x)+1) = aSensor(i);
	aSmooth(i) = sum(aBuffer)/x;
	vSmooth(i) = vSmooth(i-1) + aSmooth(i)*dt;
	xSmooth(i) = xSmooth(i-1) + vSmooth(i)*dt;
	
	vRaw(i) = aRaw(i)*dt + vRaw(i-1);
	xRaw(i) = xRaw(i-1) + vRaw(i)*dt;
	
	if(xRaw(i) - xLastStrip > 100) 
		xLastStrip = xRaw(i) - mod(xRaw(i), 100);
		xSmooth(i) = xLastStrip;
	end
end

xx = 1:n;
xError = abs(xSmooth-xRaw);
fprintf('Max distance error: %3.3f\n', max(xError));

figure(1); plot(xx,xSmooth, xx, xRaw);
figure(2); plot(xx, aSmooth, xx, aSensor);