%%%% Dynamics Controller
function tau_ff = ff_yours(th_curr, th_d_curr, th_des, th_d_des, th_dd_des, your_parameters)
%     the robot draws the ellipse approx. twice, consider wrapping the
%     angles to get better training data
%     
%     if you want to use Cartesian positions instead of joint positions in
%     your function approximator:
%     [x_des, x_d_des, x_dd_des, ~] = FK(th_des, th_d_des, th_dd_des, rp);
%     and this is the only purpose for which you are allowed to use the
%     robot parameters rp.
%   
    dt=your_parameters;
    r(1)=th_des;
    r(2)=r(1)-dt*th_d_des;
    r(3)=r(1)-dt^2*th_dd_des-r(2);
    c(1)=th_curr;
    c(2)=c(1)-dt*th_d_curr;
    l1_conf=10;
    net=feedforwardnet(l1_conf,'traingd');
    tau_ff = [0; 0];
end