function [statusArm5,statusArm6,statusArm7] = wheelboxIn(Arm,GoalMsg)
%Rosactionclient and Ros Master are already initialized
%  Movement 2 - Pick wheel's box and place it onto the working area

% Open gripper
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.116;
rospublisher('/vx300/gripper/command',msg);

% Allign gripper vertically with the wheel's box
P1_2 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P1_2.Positions = [0.2378 0.6182 1.7334 -1.2333 1.7288];
P1_2.Velocities = zeros(1,5);
P1_2.TimeFromStart = rosduration(1.0);

P2_2 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P2_2.Positions = [0.2378 0.6182 1.7334 -1.2333 1.7288];
P2_2.Velocities = zeros(1,5);
P2_2.TimeFromStart = rosduration(2.0);

% Lower z coordinate to grasp wheel box
Pbox_2 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
Pbox_2.Positions = [0.1718 0.6703 1.7334 -1.1014 1.7303];
Pbox_2.Velocities = zeros(1,5);
Pbox_2.TimeFromStart = rosduration(3.0);

GoalMsg.Trajectory.Points = [P1_2, P2_2, Pbox_2];
[~,statusArm5,~] = sendGoalAndWait(Arm,GoalMsg);

% Close gripper to grasp the box  
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.095;
rospublisher('/vx300/gripper/command',msg);

% Increase z coordinate
P3_2 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P3_2.Positions = [0.3282 0.5400 1.7150 -1.3806 1.7150];
P3_2.Velocities = zeros(1,5);
P3_2.TimeFromStart = rosduration(1.0);

P4_2 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P4_2.Positions = [0.3282 0.5400 1.7150 -1.3806 1.7150];
P4_2.Velocities = zeros(1,5);
P4_2.TimeFromStart = rosduration(2.0);

% Move to center with higher z coordinate
P5_2 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P5_2.Positions = [-0.9250 -0.3129 0.0215 -0.9741 0.0169];
P5_2.Velocities = zeros(1,5);
P5_2.TimeFromStart = rosduration(3.0);

% Lower gripper to drop the box
P6_2 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P6_2.Positions = [-1.0324 -0.0706 0.0215 -0.6151 0.0169];
P6_2.Velocities = zeros(1,5);
P6_2.TimeFromStart = rosduration(4.0);

GoalMsg.Trajectory.Points = [P3_2, P4_2, P5_2, P6_2];
[~,statusArm6,~] = sendGoalAndWait(Arm,GoalMsg);

% Open gripper
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.116;
rospublisher('/vx300/gripper/command',msg);

% Go back to initial configuration
sleepConfig = rosmessage('trajectory_msgs/JointTrajectoryPoint');
sleepConfig.Positions = [-1.3346 -1.1106 0 0.21 0];
sleepConfig.TimeFromStart = rosduration(1.0);

sleepConfig1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
sleepConfig1.Positions = [-1.33 -1.11 0 0.21 0];
sleepConfig1.TimeFromStart = rosduration(2.0);
GoalMsg.Trajectory.Points = [sleepConfig, sleepConfig1];
[~,statusArm7,~] = sendGoalAndWait(Arm,GoalMsg);

end

