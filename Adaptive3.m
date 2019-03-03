s=tf('s');
Plant=-2*(s+5)/(s^2-2*s+1);
Model=3/(s+3);
%%
[sys_m.a,sys_m.b,sys_m.c,sys_m.d]=tf2ss([3],[1,3]);
[sys_p.a,sys_p.b,sys_p.c,sys_p.d]=tf2ss([-2,-10],[1,-2,1]);