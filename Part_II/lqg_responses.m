%%
%Calculate the matrixes for the current observer
%(phie is equivallent to A and gammae is equivallent to B)
PHIE = A-M*C*A;
GAMMAE = B-M*C*B;

%%
%Plots for current observer
%the eigenvalues of PHIE must be equal to the poles of EE
figure();
subplot(1,2,1)
zplane([],eig(PHIE))
title('Eigenvalues of PHIE');
subplot(1,2,2)
zplane([],EE)
title('Poles from dlqe');

%%
%calculate closed-loop state-space

CL_lqg_ss = ss([A -B*K; M*C*A PHIE-GAMMAE*K-M*C*B*K], ...
            [B; M*C*B+GAMMAE]*N,[C zeros(size(C))],0,Ts);
        
figure();
bode(CL_lqg_ss)
        
%%
%calculate closed-loop transfer function

[CL_lqg_num,CL_lqg_den] = ss2tf(CL_lqg_ss.A,CL_lqg_ss.B,CL_lqg_ss.C,CL_lqg_ss.D);

%%
%obtain time response

u=[zeros(1,100) ones(1,1000)];

t_resp = filter(CL_lqg_num,CL_lqg_den,u);

figure();
plot(0:1099,t_resp)

