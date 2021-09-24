function [statusArm8,statusArm9,statusArm10] = screwdriverOut(Arm,GoalMsg)
%Rosactionclient and Ros Master are already initialized
% Movement 3 - Pick up Screwdriver and place it outside of working area

P1_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P1_3.Positions = [-0.5860 0.0169 0.8698 -0.9863 0.8682];
P1_3.Velocities = zeros(1,5);
P1_3.TimeFromStart = rosduration(1.0);

P2_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P2_3.Positions = [-0.5860 0.0169 0.8698 -0.9863 0.8682];
P2_3.Velocities = zeros(1,5);
P2_3.TimeFromStart = rosduration(2.0);

% Ready to grasp the screwdriver
Pscrew_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
Pscrew_3.Positions = [-0.3099 0.3513 0.6796 -0.9235 0.6734];
Pscrew_3.Velocities = zeros(1,5);
Pscrew_3.TimeFromStart = rosduration(3.0);

GoalMsg.Trajectory.Points = [P1_3, P2_3, Pscrew_3];
[~,statusArm8,~] = sendGoalAndWait(Arm,GoalMsg);

% Close gripper to grasp the screwdriver
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.055;
rospublisher('/vx300/gripper/command',msg);

P3_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P3_3.Positions = [-0.2362 0.2117 0.6903 -1.1597 0.6857];
P3_3.Velocities = zeros(1,5);
P3_3.TimeFromStart = rosduration(1.0);

P4_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P4_3.Positions = [-0.2362 0.2117 0.6903 -1.1597 0.6857];
P4_3.Velocities = zeros(1,5);
P4_3.TimeFromStart = rosduration(2.0);

P5_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P5_3.Positions = [0.5129 0.5411 1.2396 -1.56 1.2398];
P5_3.Velocities = zeros(1,5);
P5_3.TimeFromStart = rosduration(3.0);

PdropS_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
PdropS_3.Positions = [0.2178 0.6381 1.2195 -1.1796 1.2180];
PdropS_3.Velocities = zeros(1,5);
PdropS_3.TimeFromStart = rosduration(4.0);

GoalMsg.Trajectory.Points = [P3_3 ,P4_3, P5_3, PdropS_3];
[~,statusArm9,~] = sendGoalAndWait(Arm,GoalMsg);

% Open Gripper
msg = rosmessage('std_msgs/Float64');
msg.Data = 0.10;
rospublisher('/vx300/gripper/command',msg);

% Go back to initial configuration for any movement: Sleep configuration
P6_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P6_3.Positions = [0.2700 0.5001 1.3284 -1.3883 1.3223];
P6_3.TimeFromStart = rosduration(1.0);

P7_3 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
P7_3.Positions = [0.2700 0.5001 1.3284 -1.3883 1.3223];
P7_3.TimeFromStart = rosduration(2.0);

sleepConfig = rosmessage('trajectory_msgs/JointTrajectoryPoint');
sleepConfig.Positions = [-1.3346 -1.1106 0 0.21 0];
sleepConfig.TimeFromStart = rosduration(3.0);

sleepConfig1 = rosmessage('trajectory_msgs/JointTrajectoryPoint');
sleepConfig1.Positions = [-1.33 -1.11 0 0.21 0];
sleepConfig1.TimeFromStart = rosduration(4.0);

GoalMsg.Trajectory.Points = [P6_3, P7_3 sleepConfig, sleepConfig1];
[~,statusArm10,~] = sendGoalAndWait(Arm,GoalMsg);

end