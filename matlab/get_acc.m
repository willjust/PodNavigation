function [ acc ] = get_acc(currentStep)
nLevel = 5;
accFile = 'acceleration.csv';
aData = csvread(accFile);
acc = aData(currentStep);
noise = rand(1)*nLevel-nLevel/2;
acc = acc+noise;
end

