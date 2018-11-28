%% Models
load('models.mat');
fit_model=0;
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


for i=1:length(sub(:,1))
    for n=1:9
            load(link(n,:));
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

            th_model=th(:,:,sub(i,1),sub(i,2)); % th is a structure in identification toolbox format

            [den1,num1] = polydata(th_model(:,:)); %extraction of the coeficient vectors from th;

            yfsim = filter(num1,den1,u); % Equivalent to idsim(u,th) for comparison;  

            [~,fit_model(i,n)]=compare(z,th_model(:,:));
            disp(n)
            disp(i)
    end
end
