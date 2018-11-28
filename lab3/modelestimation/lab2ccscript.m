
clear;
close all;

load ke_kp.mat;
load th_models.mat;
%load data_step2.mat;
load ./datagather/model_data_for_estimation_squarewave01f35.mat;

%For burn in PRBS
sampling_time=0.02;
begin=5/sampling_time;
stop=52/sampling_time;
%For squarewave
%begin=1;
%stop=60/sampling_time;

% Modelling identif.

t = model_data_for_estimation.time; 
sigs = model_data_for_estimation.signals.values; 


utrend = sigs(:,1); % Entrada -  Input signal
thetae = sigs(:,2); % Potenciómetro  -  Potentiometer signal
alphae = sigs(:,3); % Extensómetro  - Starin gage signal

% Reconstrução ângulo total da barra – Computation of total bar angle 
ytrend = thetae*Kp + alphae*Ke;


%Differentiation and filtering
af = 0.9;
Afilt = [1 -af];
Bfilt = (1-af)*[1 -1] ;
% Filtragem seguida de eliminação de tendências
% Filtering and detrending
yf = filter(Bfilt,Afilt,ytrend); % filtered and detrended y

u = detrend(utrend);  % removing tref (average value)

%figure;
%tfestimate(u,yf, [],[],[],50)
%Performing burn
yf=yf(begin:stop);
u=u(begin:stop);
t=t(begin:stop);

%performing identification

z = [yf u];
% na = 2; % AR part
% nb = 1; % X part
% nc = 2; % MA part || =na
% nk = 1; % Atraso puro – pure delay
% nn = [na nb nc nk];
% th = armax(z,nn);  % th is a structure in identification toolbox format
th=th_models(:,:,6);
[den1,num1] = polydata(th); %extraction of the coeficient vectors from th;

yfsim = filter(num1,den1,u); % Equivalent to idsim(u,th) for comparison;

figure;
plot(t, yfsim); %  Comparison of the data for the differentiated output with the model output;
hold on;
grid on;
plot(t, yf); 
legend('Model response','Real response');
xlabel('Time(s)');
ylabel('Total differentiated angle(º)');

[~,fit]=compare(z,th)

%adding the integrator;
[num,den] = eqtflength(num1,conv(den1,[1 -1])); 

%num  %transfer func. numerator
%den  %transfer func. denominador

save('../modeldata/tf_data', 'den','num')

[A,B,C,D] = tf2ss(num,den); % state model; 
 
save('../modeldata/model_matrix_data','A','B','C','D')

%%
y = filter(num,den,u); % Equivalent to idsim(u,th) for comparison;
figure;
plot(t, y); %  Comparison of the data for the differentiated output with the model output;
hold on;
grid on;
plot(t, u); 
legend('Model response','Input Signal');
xlabel('Time(s)');
ylabel('Total differentiated angle(º)');

