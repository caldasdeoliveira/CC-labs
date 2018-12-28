clear;
close all;
load('../Part_I/modelestimation/ke_kp.mat')
load('selected_models/model_matrix_data.mat') % Contains State space model matrices from previous LAB 

%Sampling time
Ts=0.02;

R=300; % Start value
Q=C'*C;
G=eye(length(A));
I=eye(size(A));

%LQ gain computation
[K,S,E] = dlqr(A,B,Q,R);

%LTR Recovery
Qw=100*I;
Rv=2.5;

%Kalman filter gain
[M,P,Z,EE] = dlqe(A,G,C,Qw,Rv);


%LQG controller structure
N_matrix = inv([A-eye(size(A)), B; C,0])*[zeros(size(A,1),1);1];
Nx = N_matrix(1:end-1,:);
Ny = N_matrix(end,:);
N = Ny+K*Nx;

sim('lab_cc_controlador');

%calculate plants transfer function
sys=ss(A,B,C,D,Ts);


%% Plots
figure;
plot(t, ref);
hold on;
grid on;
plot(t, y);
xlabel('Time (s)');
legend('ref', 'y');
title(['Reference Tracking with R=' num2str(R)]);

% figure;
% plot(t, x(:,4));
% hold on;
% grid on;
% plot(t, x_hat(:,4));
% xlabel('Time (s)');
% legend('x', 'x\_hat');
% title(['Reference Tracking with R=' num2str(R)]);


figure;
plot(t, ref);
hold on;
grid on;
plot(t, error);
xlabel('Time (s)');
legend('ref', 'erro');
title(['Reference Tracking with R=' num2str(R)]);


%% Bode Plots

clear;
close all;
load model_matrix_data.mat % Contains State space model matrices from previous LAB 

%Sampling time
Ts=0.02;

R=300; % Start value
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

sim('lab_cc_controlador');

%calculate plants transfer function
sys=ss(A,B,C,D,Ts);

%LQR open system

T_lqr = ss(A,B,K,0,Ts);

%LQR closed system

C_lqr = ss(A-B*K,B*N,C,0,Ts);

%Phie-Gammae
PHIE = A-M*C*A; 
GAMMAE = B-M*C*B;

%Explicitly determine the controller response

K2_lqg = ss(PHIE-GAMMAE*K,M,K,0,Ts);

[NK2_lqg,DK_lqg] = tfdata(K2_lqg,'v'); 

NK_lqg = wshift('1D',NK2_lqg,1); 
K_lqg = tf(NK_lqg,DK_lqg,Ts);
T_lqg = series(G,K_lqg);


%Compute the joint system/controller dynamics

T2_lqg = ss([A zeros(size(A)); M*C*A PHIE-GAMMAE*K], ...            
    [B; M*C*B],[zeros(size(K)) K],0,Ts);

C2_lqg = ss([A -B*K; M*C*A PHIE-GAMMAE*K-M*C*B*K], ...            
    [B; M*C*B+GAMMAE]*N,[C zeros(size(C))],0,Ts);


subplot(2,1,1)
step(T2_lqg)
subplot(2,1,2)
impulse(T2_lqg)



%% Plots
%Time response only
figure;
plot(t, ref);
hold on;
grid on;
plot(t, y);
xlabel('Time (s)');
legend('ref', 'y');
title(['Reference Tracking with R=' num2str(R)]);
fig=gcf;
saveas(fig,'TimeresponseLQG.png');


%Time response and error
figure;
plot(t, ref);
hold on;
grid on;
plot(t, error);
xlabel('Time (s)');
legend('ref', 'erro');
title(['Reference Tracking with R=' num2str(R)]);
fig=gcf;
saveas(fig,'TimeresponseanderrorLQG.png');

figure
bode(T_lqr);
hold on;
grid on;
title(['LQR open system Bode Diagram with R=' num2str(R)]);

figure
bode(C_lqr);
hold on
grid on
title(['LQR closed system Bode Diagram with R=' num2str(R)]);


figure
clf
bode(T_lqr)
hold on;
bode(T2_lqg);
legend('T (LQR)','T (LQG)');
fig=gcf;
saveas(fig,'TLQRVSTLQG424.eps','epsc')

figure
bode(C_lqr,C2_lqg);
legend('C (LQR)','C (LQG)');
fig=gcf;
saveas(fig,'CLQRVSCLQG424.eps','epsc')
