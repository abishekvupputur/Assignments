function S= PSD_exp(x)
Fs=100;
dt=1/Fs;
figure;
window = 750;
noverlap = 500;
Nomega = 2000;
w_a = logspace(-2,2,Nomega);
D=zeros(1,5);
input_nr=1;
load dumpfile
if size(x,2)==1
    N = length(x);
    xdft = dt*fft(x);
    xdft = xdft(1:int16(N/2+1));
    psdx = (1/(dt*N)) * abs(xdft).^2;
    psdx(2:end-1) = 1*psdx(2:end-1);
    freq = 0:2*pi*Fs/length(x):2*pi*Fs/2; %Till Nyquist Frequency
    loglog(freq,psdx);
    grid on;
    hold on;
    [a,b]=pwelch(x, window, noverlap, N, Fs, 'onesided');
    loglog(2*pi*b,a); %So same
    grid on;
    grid on;
    hold on;
    Cd =  A2(1,:);
    C  =  [ Cd ; zeros(size(Cd)) ];
    C(2,4) = 8.9671;
    C  =  [ V  V ]*C;
    D  =  B(1,:);
    tmp=bode(A2,B,C,D,5,freq);
    S=tmp.*tmp;
    loglog(freq,S)
    legend('Periodogram','Pwelch','Analytical');
    title('Power Spectral Density Ay');
    hold off
else
    for i=1:4
        N = length(x(:,i));
        xdft = dt*fft(x(:,i));
        xdft = xdft(1:N/2+1);
        psdx = (1/(dt*N)) * abs(xdft).^2;
        psdx(2:end-1) = 1*psdx(2:end-1);
        freq = 0:2*pi*Fs/length(x):2*pi*Fs/2;
        subplot(2,2,i)
        loglog(freq,psdx);
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
        hold on;
        [a,b]=pwelch(x(:,i), window, noverlap, N, Fs, 'onesided');
        loglog(b*2*pi,a);
        grid on;
        hold on;
        C=eye(size(A2,1));
        D=zeros(size(A2,1),size(B,2));
        tmp=bode(A2,B,C(i,:),D(i,:),5,freq);
        S(:,i)=tmp.*tmp;
        loglog(freq,S(:,i))
        legend('Periodogram','Pwelch','Analytical');
        hold off
    end
end
end