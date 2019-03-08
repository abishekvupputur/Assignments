clear all;
Fs = 100; df = 2*pi*Fs/length(1:100000);
freq = [0 : df : 2*pi*Fs/2];
for i=1:4
    figure;
    load dumpfile
    C=eye(size(A2,1));
    D=zeros(size(A2,1),size(B,2));
    tmp=bode(A2,B,C(i,:),D(i,:),size(D,2),freq);
    S(:,i)=tmp.*tmp;
    tmp=bode(A2,B,C(i,:),D(i,:),size(D,2)-1,freq);
    S(:,i)=S(:,i)+tmp.*tmp;
    loglog(freq,S(:,i))
    hold on
    load dumpfile2
    C=eye(size(A2,1));
    D=zeros(size(A2,1),size(B,2));
    tmp=bode(A2,B,C(i,:),D(i,:),size(D,2),freq);
    S(:,i)=tmp.*tmp;
    tmp=bode(A2,B,C(i,:),D(i,:),size(D,2)-1,freq);
    S(:,i)=S(:,i)+tmp.*tmp;
    loglog(freq,S(:,i))
         switch(i)
            case 1 
                ylabel('Side Slip Angle [rad]')
                title('Power Spectral Density Side Slip');
            case 2 
                ylabel('Roll Angle [rad]')
                title('Power Spectral Density Roll Angle');
            case 3 
                ylabel('pb/2V')
                title('Power Spectral Density pb/2V');
            case 4 
                ylabel('rb/2V')
                title('Power Spectral Density rb/2V');
        end
        grid on;
end