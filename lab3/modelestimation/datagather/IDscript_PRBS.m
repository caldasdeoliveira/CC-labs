

clc;
clear;

t=(0:1/50:62)';
B=0.1;
u = idinput(length(t),'PRBS',[0 B]);

sampling_time=0.02;
begin=10/sampling_time;

u = u(begin:end);
t=t(1:(end-begin)+1);