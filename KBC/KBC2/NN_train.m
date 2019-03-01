load('Training_data.mat');
dt=t(2)-t(1); % assume uniformly sampled.
r(:,:,1)=des.th;
r(:,:,2)=r(:,:,1)-dt*des.th_d(:,:,1);
r(:,:,3)=r(:,:,1)-dt^2*des.th_dd(:,:,1)-r(:,:,2);
c(:,:,1)=curr.th;
c(:,:,2)=c(:,:,1)-dt*curr.th_d;
Input(:,:,1:3)=r;
Input(:,:,4:5)=c;
Inp=reshape(Input,[size(Input,1)*size(Input,3), size(Input,2)]);
Output(:,:)=curr.tau_ff;

l1_conf=10;
net=feedforwardnet(l1_conf,'trainbfg');
net=patternnet([10,20]);
view(net)
%%
net=train(net,Inp,Output)
tau_ff = [0; 0];