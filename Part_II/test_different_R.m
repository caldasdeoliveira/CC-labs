clear;
close all;
load model_matrix_data424.mat % Contains State space model matrices from previous LAB 

%Sampling time
Ts=0.02;

vec_R=[150, 100 , 50, 10];

Q=C'*C;
G=eye(length(A));
I=eye(size(A));

%LTR Recovery
Qw=100*I;
Rv=1;

%Kalman filter gain
[M,P,Z,EE] = dlqe(A,G,C,Qw,Rv);

%calculate plants states space
plant_ss=ss(A,B,C,D,Ts);

%calculate the tf of the plant
[NG,DG] = tfdata(plant_ss,'v');
[NG,DG] = eqtflength(NG,DG);
SRL = tf(conv(NG,fliplr(NG)),conv(DG,fliplr(DG)));

    
for R=vec_R
    %LQ gain computation
    [K,S,E] = dlqr(A,B,Q,R);

    %LQG controller structure
    N_matrix = inv([A-eye(size(A)), B; C,0])*[zeros(size(A,1),1);1];
    Nx = N_matrix(1:end-1,:);
    Ny = N_matrix(end,:);
    N = Ny+K*Nx;
    
    %calculate state space of the lqr
    C_lqr = ss(A-B*K,B*N,C,0,Ts);
    
    %calculate transfer function of the lqr
    [NC_lqr,DC_lqr] = tfdata(C_lqr,'v');

    sim('lab_cc_controlador');
    
%     figure;
%     plot(t, ref);
%     hold on;
%     grid on;
%     plot(t, y);
%     xlabel('Time (s)');
%     legend('ref', 'y');
%     title(['Reference Tracking with R=' num2str(R)]);
% 
%     figure;
%     plot(t, ref);
%     hold on;
%     grid on;
%     plot(t, error);
%     xlabel('Time (s)');
%     legend('ref', 'erro');
%     title(['Reference Tracking with R=' num2str(R)]);
    
    figure;
    p_srl = rlocus(SRL,1/R);
    zplane([],p_srl)
    title(['SRL poles for \rho = 1/R = ' num2str(1/R)])
    ax = axis;
end
