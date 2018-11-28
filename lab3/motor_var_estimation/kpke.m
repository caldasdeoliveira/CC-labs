ls
clear;
load('data_step.mat')
delta_the=max(tensao_pot.signals.values(:,1))-min(tensao_pot.signals.values(:,1));
Kp=360/delta_the;

load('steps.mat')
p=polyfit(vec_step,vec_g,1);
Ke=p(1);

save('../modelestimation/ke_kp.mat','Kp','Ke');

%o Ke está positivo, falar com o stor!!!.