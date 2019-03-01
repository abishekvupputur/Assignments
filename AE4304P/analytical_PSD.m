function [] = analytical_PSD(sys)
Nomega = 2000;
w_a = logspace(-2,2,Nomega);
D=zeros(1,5);
input_nr=3;
figure;
for i =1:4
    subplot(2,2,i)
    C=zeros(1,10);
    C(1,i)=1;
    temp = bode(sys.A,sys.B(:,3),C,D(:,3),input_nr,w_a); 
    S_out  = temp.*temp;
    %temp = bode(sys.A,sys.B,C,D,input_nr,w_a); 
    
    loglog(w_a,S_out/2);
end
end

