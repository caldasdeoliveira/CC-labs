clear;
close all;
load model_matrix_data.mat % Contains State space model matrices from previous LAB 

%Sampling time
Ts=0.02;

R=100; % Start value
Q=C'*C;
G=eye(length(A));
I=eye(5);

%LQ gain computation
[K,S,e] = dlqr(A,B,Q,R);

%LTR Recovery
Qw=100*I;
Rv=1;

%Kalman filter gain
[M,P,Z,E] = dlqe(A,G,C,Qw,Rv);


%LQG controller structure
N_matrix = inv([A-eye(size(A)), B; C,0])*[zeros(size(A,1),1);1];
Nx = N_matrix(1:end-1,:);
Ny = N_matrix(end,:);
N = Ny+K*Nx;

sim('lab_cc_controlador');

%% Plots
figure;
plot(t, ref);
hold on;
grid on;
plot(t, y);
xlabel('Time (s)');
legend('ref', 'y');
title(['Reference Tracking with R=' num2str(R)]);

figure;
plot(t, ref);
hold on;
grid on;
plot(t, error);
xlabel('Time (s)');
legend('ref', 'erro');
title(['Reference Tracking with R=' num2str(R)]);