%%%%%%%%%%%%%%%%% AE4304P- Stochastic Aerospace Systems %%%%%%%%%%%%%%%%%%%
%%%%%%%%------------------- Abishek Narasimhan -------------%%%%%%%%%%%%%%%
%%%%%%%%----------------------- 4788613 --------------------%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A lot of the code used in this assignment was adopted from the lecture
% notes of the course AE4304. 
%%
clc; clear all; close all;

Flag =1; %0 for Full model and 1 for reduced!

if Flag==0
    AircraftModel %Loads Full Aircraft Model.
else
    reduced %reduced A/c Model.
end

%% Stability Analysis
p = eig(A)
sys=ss(A, B(:,1), eye(size(A,2)),zeros(size(A,2),size(B(:,1),2)));
figure;
pzmap(sys);
title('Pole Zero Map')
hold on
%%%%%%%%%%%%%%%% CONTROLLER DESIGN  %%%%%%%%%%%%%%%%%%%%%%%
% FOR EFFECT OF K_phi ON AIRCRAFT RESPONSES, ONE OTHER K_phi IS USED
Kphi = -0.1;
K      = zeros(1,size(A,2)); K(1,2) = Kphi;
A2   = A-B(:,1)*K;
% SHOW EIGENVALUES OF THIS CONTROLLED SYSTEM
%eig(A2), pause
C=eye(size(A,2));
D=zeros(size(A,2),size(B,2));
sys2=ss(A2,B,C,D);
pzmap(sys2);
    legend('Original System','Controller added');
    grid on
    hold off;
    
%% Time Domain Simulation
% TIME AXIS INPUT VECTOR DEFINITION
dt = 0.01;
T  = 150-dt; t = [0:dt:T]; N = length(t);
%rng('shuffle'); %Generates randn sequence based on time
% INPUT VECTOR DEFINITION
nn = zeros(1,N);             % zero input elevator
w2 = randn(1,N)/sqrt(dt);    % scaled input lateral turbulence,
                             % note the sqrt(dt) because of lsim
w3 = randn(1,N)/sqrt(dt);    % scaled input vert. turbulence,
                             % note the sqrt(dt) because of lsim
u=zeros(size(w2,2),size(B,2));
u(: , end-1 : end)  = [w2' w3'];% input vector definition (vertical and lateral
                             % turbulence only, can be changed).                        
Y   =     lsim(sys2,u,t);    %Simulate Output

figure;
subplot(2,1,1)
    plot(t,w2);
    xlabel('time [s]');
    ylabel('Scaled Input');
    grid on
    title('White Noise Input Lateral Axis');
subplot(2,1,2)
    plot(t,w3);
    xlabel('time [s]');
    ylabel('Scaled Input');
    grid on
    title('White Noise Input Vertical Axis');
    
StatesPlotter(Y,t);
%%Acceleration Y
% The Value of Beta dot can be calculated from the first row of the A matrix
% And thus the first row of A matrix is copied into C matrix and the value
% of yaw rate is extracted. And the C matrix is pre multiplied with a
% velocity factor that sums the sideslip rate and the yaw rate.

Cd =  A2(1,:);                  %First row of A matrix
C  =  [ Cd ; zeros(size(Cd)) ]; 
C(2,4) = 2*V/b;                 %Yaw rate Extraction
C  =  [ V  V ]*C; %Extract The new C matrix with multiplying with V factors.
D  =  B(1,:);
sys_ay  =   ss(A2,B,C,D);
Ay = lsim(sys_ay,u,t);
figure;
plot(t,Ay);
    title('Acceleration Y');
    xlabel('time [s]');
    ylabel('Ay [m/s^2]');
    grid on

%% Spectral Analysis
S_Ay = PSD_exp(Ay,Flag); %Welch and FFT Method
S_Y = PSD_exp(Y,Flag);
Fs = 100; df = 2*pi*Fs/length(Ay);
freq = [0 : df : 2*pi*Fs/2];

%% Variances
disp('Variance Estimated is as follows');
Names_of_States = {'Side Slip' ;'Roll Angle' ; 'pb/2V' ; 'rb/2v' ; 'Lateral Acceleration'};
Variance_Function = [ var(Y(:,1:4))' ; var(Ay) ];
Variance_Analytical = [trapz(df,S_Y(1:end,1));trapz(df,S_Y(1:end,2));trapz(df,S_Y(1:end,3));trapz(df,S_Y(1:end,4));trapz(df,S_Ay(1:end))];
Variance_Lyapunov = lyap(A2,B(:,end-1:end)*B(:,end-1:end)');
Variance_Lyapunov = diag(Variance_Lyapunov);
Variance_Lyapunov = [Variance_Lyapunov(1:4); ((C.*C)*Variance_Lyapunov)];
Table = table(Names_of_States,Variance_Function,Variance_Analytical,Variance_Lyapunov);
disp(Table);
