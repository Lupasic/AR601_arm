% L1 0.5 L2 0.6 L3 0.8
disp('kek specs super magic for oleg')

pos=FK_OLEG([-15 20 -35])

qq=IK_OLEG(pos)
for i=1:4
pos-FK_OLEG(qq(:,i))
end

function pos=FK_OLEG(q)
q=deg2rad(q);
pt = transH([0 0 0.5]')*rotH([0 0 q(1)]')*rotH([q(2) 0 0]')*transH([0.6 0 0]')*...
    rotH([0 q(3) 0]')*transH([0.8 0 0]');
pos=pt(1:3,4);
end

function q=IK_OLEG(pos)

phi=acos((0.5-pos(3))/0.8);
[xout,yout] = circcirc(0,0,0.6,pos(1),pos(2),0.8*sin(phi));

q11=atan2(yout(1),xout(1));
q12=atan2(yout(2),xout(2));

q31=-acos(-(0.6^2+0.8^2-norm(pos-[0 0 0.5]')^2)/(2*0.8*0.6));

q21=acos(-(pos(3)-0.5)/(0.8*sin(q31)));
q24=acos(-(pos(3)-0.5)/(0.8*sin(-q31)));

q=rad2deg([q11 q12 q11 q12; q21 -q21 -q24 q24; q31 q31 -q31 -q31]);
end