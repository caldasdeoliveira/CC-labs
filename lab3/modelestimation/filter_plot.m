figure;
af = 0.6;
Afilt = [1 -af];
Bfilt = (1-af)*[1 -1] ;
sys=tf(Bfilt,Afilt, 0.01)

af = 0.8;
Afilt = [1 -af];
Bfilt = (1-af)*[1 -1] ;
sys2=tf(Bfilt,Afilt, 0.01)

af = 0.9;
Afilt = [1 -af];
Bfilt = (1-af)*[1 -1] ;
sys3=tf(Bfilt,Afilt, 0.01)
bode(sys, sys2, sys3)
legend('af=0.6','af=0.8', 'af=0.9')
