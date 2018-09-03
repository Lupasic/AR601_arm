angles = sym('q',[6,1],'real');
robot.bodyHeight = sym('L1','real');
robot.armAngle = sym('qConst','real');
robot.shoulderLength = sym('L2','real');
robot.elbowHeight = sym('L3','real');
robot.wristLength = sym('L4','real');


[T0, ~, ~] = FKfull(angles,"L",robot);
T0