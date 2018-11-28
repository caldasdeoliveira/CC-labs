load('sem_motor.mat')
teste=tensao_pot.signals.values(:,2);

s01=teste(find(tensao_pot.time==0):find(tensao_pot.time==1.555));
mean01=sum(s01)/length(s01);

s02=teste(find(tensao_pot.time==4.44):find(tensao_pot.time==5.849));
mean02=sum(s02)/length(s02);

s03=teste(find(tensao_pot.time==8.782):find(tensao_pot.time==10.92));
mean03=sum(s03)/length(s03);

s04=teste(find(tensao_pot.time==14.17):find(tensao_pot.time==16.06));
mean04=sum(s04)/length(s04);

s05=teste(find(tensao_pot.time==17.85):find(tensao_pot.time==22.97));
mean05=sum(s05)/length(s05);

s06=teste(find(tensao_pot.time==25.27):find(tensao_pot.time==27.14));
mean06=sum(s06)/length(s06);

s07=teste(find(tensao_pot.time==29.59):find(tensao_pot.time==33));
mean07=sum(s07)/length(s07);

s08=teste(find(tensao_pot.time==36.7):find(tensao_pot.time==38.67));
mean08=sum(s08)/length(s08);

s09=teste(find(tensao_pot.time==43.1):find(tensao_pot.time==44.39));
mean09=sum(s09)/length(s09);

s10=teste(find(tensao_pot.time==49.63):find(tensao_pot.time==50.19));
mean10=sum(s10)/length(s10);

s11=teste(find(tensao_pot.time==55.5):find(tensao_pot.time==57.47));
mean11=sum(s11)/length(s11);

s12=teste(find(tensao_pot.time==61.18):find(tensao_pot.time==62.96));
mean12=sum(s12)/length(s12);

s13=teste(find(tensao_pot.time==66.9):find(tensao_pot.time==67.79));
mean13=sum(s13)/length(s13);

s14=teste(find(tensao_pot.time==71.66):find(tensao_pot.time==72.42));
mean14=sum(s14)/length(s14);

s15=teste(find(tensao_pot.time==75.42):find(tensao_pot.time==76.48));
mean15=sum(s15)/length(s15);

vec_step=[mean01 mean02 mean03 mean04 mean05 mean06 mean07 mean08 mean09 mean10 mean11 mean12 mean13 mean14 mean15];
vec_cm=[-3.7, -3.05, -2.4, -1.8, -1.1, -0.5, 0, 0.6, 1.4, 2, 2.65, 3.3, 3.9, 4.55, 5.2];
vec_cm=-vec_cm;
vec_g=atan2d(vec_cm,40);
save('steps.mat','vec_g','vec_step');
