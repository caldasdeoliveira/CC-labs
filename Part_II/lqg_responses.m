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
%