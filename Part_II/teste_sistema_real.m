close all;

load('../Part_I/modelestimation/ke_kp.mat')
load('selected_models/model_matrix_data424.mat')
%sampling time
Ts=0.02;


R=100; % Start value
Q=C'*C;
G=eye(length(A));
I=eye(size(A));

%LQ gain computation
[K,S,E] = dlqr(A,B,Q,R);

%LTR Recovery
Qw=100*I;
Rv=1;

%Kalman filter gain
[M,P,Z,EE] = dlqe(A,G,C,Qw,Rv);


%LQG controller structure
N_matrix = inv([A-eye(size(A)), B; C,0])*[zeros(size(A,1),1);1];
Nx = N_matrix(1:end-1,:);
Ny = N_matrix(end,:);
N = Ny+K*Nx;

%%
sim('sistema_real');