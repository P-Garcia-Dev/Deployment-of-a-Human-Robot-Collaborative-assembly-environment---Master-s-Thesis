function [statusArm11,statusArm12,statusArm13] = wheelboxOut(Arm,GoalMsg)
%Rosactionclient and Ros Master are already initialized
% Movement 4 - Pick wheels box from working space and place it outside the working area

% Open gripper
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.116;
rospublisher('/vx300/gripper/command',msg);

% Allign gripper with higher z coordinate with wheel box
P1_4 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P1_4.Positions = [-0.9250 -0.3129 0.0215 -0.9741 0.0169];
P1_4.Velocities = zeros(1,5);
P1_4.TimeFromStart = rosduration(1.0);

P2_4 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P2_4.Positions = [-0.9250 -0.3129 0.0215 -0.9741 0.0169];
P2_4.Velocities = zeros(1,5);
P2_4.TimeFromStart = rosduration(2.0);

% Lower z coordinate to wheel box
P3_4 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P3_4.Positions = [-1.04 -0.0414 0.0169 -0.5752 0.0184];
P3_4.Velocities = zeros(1,5);
P3_4.TimeFromStart = rosduration(3.0);

GoalMsg.Trajectory.Points = [P1_4, P2_4, P3_4];
[~,statusArm11,~] = sendGoalAndWait(Arm,GoalMsg);

% Close gripper to grasp the box  
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.095;
rospublisher('/vx300/gripper/command',msg);

% Increase z coordinate in place
P4_4 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P4_4.Positions = [-0.6167 -0.6320 0.0031 -1.5984 -0.0015];
P4_4.Velocities = zeros(1,5);
P4_4.TimeFromStart = rosduration(1.0);

P5_4 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P5_4.Positions = [-0.6167 -0.6320 0.0031 -1.5984 -0.0015];
P5_4.Velocities = zeros(1,5);
P5_4.TimeFromStart = rosduration(2.0);

P6_4 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P6_4.Positions = [0.2378 0.6182 1.7334 -1.2333 1.7288];
P6_4.Velocities = zeros(1,5);
P6_4.TimeFromStart = rosduration(3.0);

P7_4 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P7_4.Positions = [0.2378 0.6182 1.7334 -1.2333 1.7288];
P7_4.Velocities = zeros(1,5);
P7_4.TimeFromStart = rosduration(4.0);

% Lower z coordinate to grasp wheel box
Pbox_4 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
Pbox_4.Positions = [0.1718 0.6703 1.7334 -1.1014 1.7303];
Pbox_4.Velocities = zeros(1,5);
Pbox_4.TimeFromStart = rosduration(5.0);

GoalMsg.Trajectory.Points = [P4_4, P5_4, P6_4, P7_4, Pbox_4];
[~,statusArm12,~] = sendGoalAndWait(Arm,GoalMsg);

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
[~,statusArm13,~] = sendGoalAndWait(Arm,GoalMsg);

end