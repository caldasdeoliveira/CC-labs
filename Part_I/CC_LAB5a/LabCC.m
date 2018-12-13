%barra 03025

figure;
plot(input.time, input.signals.values)
figure;
plot(tensao_pot.time, tensao_pot.signals.values)

p=polyfit(x,y,1); %p(1):declive
y=polyval(p.x)