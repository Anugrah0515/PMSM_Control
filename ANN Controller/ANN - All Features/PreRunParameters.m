
clear all;
clc;

Rs=0.02;
Ls=0.4;
Sm=0.2205;
p=4;
J=0.006;
B=0;
f=60;

intialSpeed = 0;
speedChange = 200;
loadTorque = 0;
Vdc = 500;
samplingTime = 50; 
% sampling will be done at 50 * 1e-6 
% 1e-6 factor is added there itself
