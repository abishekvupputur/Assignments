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
    subplot(2,1,1)
    sz=size(Q1_adaptive.time);
    plot(Q1_adaptive.time, reshape(Q1_adaptive.signals(1).values,sz), Q1_adaptive.time, reshape(Q1_adaptive.signals(2).values,sz));
    grid on
    legend('Reference Model','Adaptive Model');
    xlabel('time [s]');
    ylabel('Amplitude');
    title('Question 1 Adaptive');
    subplot(2,1,2)
    sz=size(ErrorQ1_2.time);
    plot(ErrorQ1_2.time, reshape(ErrorQ1_2.signals.values,sz));
    grid on
    xlabel('time [s]');
    ylabel('Error');
    
    figure;
    subplot(2,1,1);
    sz=size(Q1_direct.time);
    plot(Q1_direct.time, reshape(Q1_direct.signals(1).values,sz), Q1_direct.time, reshape(Q1_direct.signals(2).values,sz));
    grid on
    legend('Reference Model','Adaptive Model');
    xlabel('time [s]');
    ylabel('Amplitude');
    title('Question 1 Direct');
    subplot(2,1,2)
    sz=size(ErrorQ1_1.time);
    plot(ErrorQ1_1.time, reshape(ErrorQ1_1.signals.values,sz));
    grid on
    xlabel('time [s]');
    ylabel('Error');
    
%% Question 2
[ss_pl.a,ss_pl.b,ss_pl.c,ss_pl.d]=tf2ss([1 1.5],[1 0.75 2.5]);
[ss_mo.a,ss_mo.b,ss_mo.c,ss_mo.d]=tf2ss([1 50],[1 15 50]);
K=-ss_mo.a+ss_pl.a;
K=K(1,:);
l=50/1.5;
flag =0; %Set as 0 for sine, 1 for step.
sim("Ass3Q2_1");
    figure;
    subplot(2,1,1);
    sz=size(Q2_direct.time);
    plot(Q2_direct.time, reshape(Q2_direct.signals(1).values,sz), Q2_direct.time, reshape(Q2_direct.signals(2).values,sz));
    grid on
    legend('Reference Model','Plant with Calculated feedback Parameters');
    xlabel('time [s]');
    ylabel('Amplitude');
    title('Question 2 Direct ref A, B, K Matrix');
    subplot(2,1,2)
    sz=size(ErrorQ2_1.time);
    plot(ErrorQ2_1.time, reshape(ErrorQ2_1.signals.values,sz));
    grid on
    xlabel('time [s]');
    ylabel('Error');
    
%% Q2 Part 2
syms x y z
eqn1 = x + z == 34.25;
eqn2 = 0.75*x + y +51.5*z == -32.5;
eqn3 = 2.5*x + 1.5*y + 75*z == 50;
[A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [x, y, z]);
X = double(linsolve(A,B));
A=[-50,0;0,-50;];
B=[1,0,0;0,1,0];
C=[X(2),X(1)];
D=[X(3),0,1];
sim("Ass3Q2_2");
    figure;
    subplot(2,1,1);
    sz=size(Q2_2_direct.time);
    plot(Q2_2_direct.time, reshape(Q2_2_direct.signals(1).values,sz), Q2_2_direct.time, reshape(Q2_2_direct.signals(2).values,sz));
    grid on
    legend('Reference Model','Plant with Calculated feedback Parameters');
    xlabel('time [s]');
    ylabel('Amplitude');
    title('Question 2 Direct Calculated theta');
    subplot(2,1,2)
    sz=size(ErrorQ2_2.time);
    plot(ErrorQ2_2.time, reshape(ErrorQ2_2.signals.values,sz));
    grid on
    xlabel('time [s]');
    ylabel('Error');
    