clc;
clear all;
s=tf('s');
%% Question 1
Plant=-2*(s+5)/(s^2-2*s+1);
Model=3/(s+3);
[sys_m.a,sys_m.b,sys_m.c,sys_m.d]=tf2ss([3],[1,3]);
[sys_p.a,sys_p.b,sys_p.c,sys_p.d]=tf2ss([-2,-10],[1,-2,1]);
A=[-1,0;0,-1;];
B=[1,0,0;0,1,0];
C=[-2,-4];
D=[3,0,-1.5];
sim("Ass3.slx");
sim("Ass3_2.slx");
figure;
    sz=size(Q1_adaptive.time);
    plot(Q1_adaptive.time, reshape(Q1_adaptive.signals(1).values,sz), Q1_adaptive.time, reshape(Q1_adaptive.signals(2).values,sz));
    grid on
    legend('Reference Model','Adaptive Model');
    xlabel('time [s]');
    ylabel('Amplitude');
    title('Question 1 Adaptive');

    figure;
    sz=size(Q1_direct.time);
    plot(Q1_direct.time, reshape(Q1_direct.signals(1).values,sz), Q1_direct.time, reshape(Q1_direct.signals(2).values,sz));
    grid on
    legend('Reference Model','Adaptive Model');
    xlabel('time [s]');
    ylabel('Amplitude');
    title('Question 1 Direct');
%% Question 2
[ss_pl.a,ss_pl.b,ss_pl.c,ss_pl.d]=tf2ss([1 1.5],[1 0.75 2.5]);
[ss_mo.a,ss_mo.b,ss_mo.c,ss_mo.d]=tf2ss([1 50],[1 15 50]);
K=-ss_mo.a+ss_pl.a;
K=K(1,:);
l=50/1.5;