function [statusArm1,statusArm2,statusArm3,statusArm4] = screwdriverIn(Arm,GoalMsg)
%Rosactionclient and Ros Master are already initialized
%  Movement 1 - Pick up Screwdriver and place it inside of working area  

% Initial configuration for any movement: Sleep configuration
sleepConfig = rosmessage('trajectory_msgs/JointTrajectoryPoint');
sleepConfig.Positions = [-1.3346 -1.1106 0 0.21 0];
sleepConfig.Velocities = zeros(1,5);
sleepConfig.TimeFromStart = rosduration(1.0);

sleepConfig1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
sleepConfig1.Positions = [-1.33 -1.11 0 0.21 0];
sleepConfig1.Velocities = zeros(1,5);
sleepConfig1.TimeFromStart = rosduration(2.0);

% Point 1_1 - Gripper with Pitch of pi/2 
P1_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P1_1.Positions = [-0.80 -0.65 0 -1.43 0];
P1_1.Velocities = zeros(1,5);
P1_1.TimeFromStart = rosduration(3.0);

GoalMsg.Trajectory.Points = [sleepConfig, sleepConfig1, P1_1];
[~,statusArm1,~] = sendGoalAndWait(Arm,GoalMsg);

% Open gripper
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.10;
rospublisher('/vx300/gripper/command',msg);

% Point 3 - Move gripper with current pose to position vertically aligned with the Screwdriver
P2_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P2_1.Positions = [0.5129 0.5411 1.2396 -1.56 1.2398];
P2_1.Velocities = zeros(1,5);
P2_1.TimeFromStart = rosduration(1.0);

% Point 3_1 - Move gripper with current pose to position vertically aligned with the Screwdriver
P3_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P3_1.Positions = [0.5129 0.5411 1.2396 -1.56 1.2398];
P3_1.Velocities = zeros(1,5);
P3_1.TimeFromStart = rosduration(2.0);

% Point of grasping - Lower z coordinate of the gripper to match the z coordinate of the Screwdriver
Pgrasp_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
Pgrasp_1.Positions = [0.2328 0.6503 1.2396 -1.1709 1.2398];
Pgrasp_1.Velocities = zeros(1,5);
Pgrasp_1.TimeFromStart = rosduration(3.0);

GoalMsg.Trajectory.Points = [P2_1,P3_1,Pgrasp_1];
[~,statusArm2,~] = sendGoalAndWait(Arm,GoalMsg);

% Close gripper to grasp 'Screwdriver'
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.056;
rospublisher('/vx300/gripper/command',msg);

% Point 5 - Increase z coordinate slowly
P4_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P4_1.Positions = [0.382 0.569 1.247 -1.43 1.25];
P4_1.Velocities = zeros(1,5);
P4_1.TimeFromStart = rosduration(1.0);

P5_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P5_1.Positions = [0.382 0.569 1.247 -1.43 1.25];
P5_1.Velocities = zeros(1,5);
P5_1.TimeFromStart = rosduration(2.0);

Pup1_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
Pup1_1.Positions = [-0.2838 0.2148 0.7026 -1.1075 0.6995];
Pup1_1.Velocities = zeros(1,5);
Pup1_1.TimeFromStart = rosduration(3.0);

% Point of dropping 
Pdrop = rosmessage('trajectory_msgs/JointTrajectoryPoint');
Pdrop.Positions = [-0.3682 0.3359 0.7026 -0.8790 0.6995];
Pdrop.Velocities = zeros(1,5);
Pdrop.TimeFromStart = rosduration(4.0);

GoalMsg.Trajectory.Points = [P4_1,P5_1, Pup1_1, Pdrop];
[~,statusArm3,~] = sendGoalAndWait(Arm,GoalMsg);

% Open gripper
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.10;
rospublisher('/vx300/gripper/command',msg);

% Go back to initial configuration for any movement: Sleep configuration
% Increase z coordinate slightly
Pup2_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
Pup2_1.Positions = [-0.3559 0.2056 0.7249 -1.0462 0.7240];
Pup2_1.TimeFromStart = rosduration(1.0);

Pup3_1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
Pup3_1.Positions = [-0.3559 0.2056 0.7249 -1.0462 0.7240];
Pup3_1.TimeFromStart = rosduration(2.0);

sleepConfig = rosmessage('trajectory_msgs/JointTrajectoryPoint');
sleepConfig.Positions = [-1.3346 -1.1106 0 0.21 0];
sleepConfig.TimeFromStart = rosduration(3.0);

sleepConfig1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
sleepConfig1.Positions = [-1.33 -1.11 0 0.21 0];
sleepConfig1.TimeFromStart = rosduration(4.0);
GoalMsg.Trajectory.Points = [Pup2_1, Pup3_1, sleepConfig, sleepConfig1];
[~,statusArm4,~] = sendGoalAndWait(Arm,GoalMsg);

end
