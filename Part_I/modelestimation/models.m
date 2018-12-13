clear;
close all;

load ke_kp.mat;
link=['./datagather/model_data_for_estimation_PRBS______(f05)'
      './datagather/model_data_for_estimation_PRBS______(f10)'
      './datagather/model_data_for_estimation_PRBS______(f15)'
      './datagather/model_data_for_estimation_PRBS______(f20)'
      './datagather/model_data_for_estimation_squarewave_____'
      './datagather/model_data_for_estimation_squarewave(f30)'
      './datagather/model_data_for_estimation_squarewave(f35)'
      './datagather/model_data_for_estimation_squarewave(f45)'
      './datagather/model_data_for_estimation_squarewave(f50)'];

sampling_time=0.02;
begin=5/sampling_time;
stop=52/sampling_time;

for n=1:3*3*7
    nia=ceil(n/9)+1;
    nib=ceil((rem(n,9)+1)/3);
    nic=nia+1-rem(rem(n,9),3);
    N(:,n)=[nia;nib;nic];
end
for i=1:9
    load(link(i,:));
    for n=1:length(N(1,:))
        % Modelling identif.

        t = model_data_for_estimation.time; 
        sigs = model_data_for_estimation.signals.values; 



        utrend = sigs(:,1); % Entrada -  Input signal
        thetae = sigs(:,2); % Potenciómetro  -  Potentiometer signal
        alphae = sigs(:,3); % Extensómetro  - Starin gage signal

        % Reconstrução ângulo total da barra – Computation of total bar angle 
        ytrend = thetae*Kp + alphae*Ke;

        af = 0.8;
        Afilt = [1 -af];
        Bfilt = (1-af)*[1 -1] ;
        % Filtragem seguida de eliminação de tendências
        % Filtering and detrending
        yf = filter(Bfilt,Afilt,ytrend); % filtered and detrended y

        u = detrend(utrend);  % removing tref (average value)

        %Performing burn
        yf=yf(begin:stop);
        u=u(begin:stop);
        t=t(begin:stop);

        %performing identification

        z = [yf u];
        na = N(1,n); % AR part
        nb = N(2,n); % X part
        nc = N(3,n); % MA part || =na
        nk = 1; % Atraso puro – pure delay
        nn = [na nb nc nk];
        th(:,:,i,n)= armax(z,nn);  % th is a structure in identification toolbox format

        [den1,num1] = polydata(th(:,:,i,n)); %extraction of the coeficient vectors from th;

        yfsim = filter(num1,den1,u); % Equivalent to idsim(u,th) for comparison;  

        [~,fit(i,n)]=compare(z,th(:,:,i,n));
    end
end
