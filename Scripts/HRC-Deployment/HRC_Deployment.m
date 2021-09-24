%% Script for implementing and managing a Real-time Human-robot collaborative assembly process
%
% by Pedro Garcia, August of 2021
%
% Run section by section. 
% ROS Master of the robotic arm must already be running either on a Virtual Machine or on a different machine with Ubuntu
%
% The deep learning algorithm used for this system is a 11 object class fine-tuned YOLOv3 neural network,
% initially trained with 80 classes over COCO dataset. 

clear
clc
imaqreset

%Establish conection to ROS Master and ROS Action Client, load the trained YOLOv3 multi-object detector (11 classes)
load('C:\Users\Pedro G\Desktop\Tese\Development\Algorithms\YOLO\YOLOv3_DarkNet53_Trained.mat','yolov3Detector','inputSize');
YOLOv3 = yolov3Detector;
imgSz = inputSize(1,1:2); %Input size of the input layer of the YOLOv3 detector

ipaddress = '192.168.1.101';
rosinit(ipaddress)

[Arm, GoalMsg] = rosactionclient('/vx300/arm_controller/follow_joint_trajectory');
GoalMsg.Trajectory.JointNames = {'elbow', ...
                           'shoulder', ...
                           'waist', ...
                           'wrist_angle',...
                           'wrist_rotate',...
                           };
                       
%Create video object with the SONY Camera 
vidobj = imaq.VideoDevice('winvideo', 2);

%% Deployment with the Robot and the computer vision-enabling deep learning model

%Initialize each joints' movevent status as 'none' because the movements haven't yet been done
statusArm1 = 'none';
statusArm2 = 'none';
statusArm3 = 'none';
statusArm4 = 'none';
statusArm5 = 'none';
statusArm6 = 'none';
statusArm7 = 'none';
statusArm8 = 'none';
statusArm9 = 'none';
statusArm10 = 'none';
statusArm11 = 'none';
statusArm12 = 'none';
statusArm13 = 'none';

%Initialize labels variable - frames captured in each cycle framesN
framesN = 10;
labels = cell(1,framesN);

while strcmp(statusArm13,'none') == 1
%Detection of the components - Assessment of detections made every 10 frames
    for i=1:framesN 
        frame = step(vidobj);
        frameSz1 = imresize(frame,imgSz);
         
        [bboxes,~,detLabel] = detect(YOLOv3,frameSz1);
        labels{1,i} = detLabel;
         
        detImg = insertObjectAnnotation(frameSz1,'Rectangle',bboxes,cellstr(detLabel));
        imshow(detImg)
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movement 1 - pick screwdriver and place it inside the working space
count1 = 0;

    for n=1:length(labels)
        %Objects to detect: Base and Stepper
        if strcmp(statusArm1,'none') == 1 && strcmp(statusArm2,'none') == 1 && strcmp(statusArm3,'none') == 1 && strcmp(statusArm4,'none') == 1 && ismember('Base',labels{1,n}) == 1 && ismember('Stepper',labels{1,n}) == 1 && ismember('Screwdriver',labels{1,n}) == 0 && ismember('Belt',labels{1,n}) == 0 && ismember('Screw',labels{1,n}) == 0 && ismember('Wheel_A',labels{1,n}) == 0 && ismember('Wheel_B',labels{1,n}) == 0 && ismember('Wheel_C',labels{1,n}) == 0 && ismember('Wheel_D',labels{1,n}) == 0        
            count1 = count1 + 1;
        end
    end
    
    if count1 >= 7 %if 7 out of the last 10 frames detect all the Objects to detect, execute movement 1
        [statusArm1,statusArm2,statusArm3,statusArm4] = screwdriverIn(Arm,GoalMsg);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movement 2 - pick wheel box and place it inside the working space
count2 = 0;

    for m=1:length(labels)
        %Objects to detect: Base and Screw
        if strcmp(statusArm1,'succeeded') == 1 && strcmp(statusArm2,'succeeded') == 1 && strcmp(statusArm3,'succeeded') == 1 && strcmp(statusArm4,'succeeded') == 1 && strcmp(statusArm5,'none') == 1 && strcmp(statusArm6,'none') == 1 && strcmp(statusArm7,'none') == 1 && ismember('Base',labels{1,m}) == 1 && ismember('Screw',labels{1,m}) == 1 && ismember('Belt',labels{1,m}) == 0 && ismember('Wheel_A',labels{1,m}) == 0 && ismember('Wheel_B',labels{1,m}) == 0 && ismember('Wheel_C',labels{1,m}) == 0 && ismember('Wheel_D',labels{1,m}) == 0        
            count2 = count2 + 1;
        end
    end
    
    if count2 >= 5 %if 5 out of the last 10 frames detect all the Object to detect and all the prior movements were already made, execute movement 2
        [statusArm5,statusArm6,statusArm7] = wheelboxIn(Arm,GoalMsg);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movement 3 - pick screwdriver and place it outside of the working space
count3 = 0;

    for k=1:length(labels)
        %Objects to detect: Base
        if strcmp(statusArm1,'succeeded') == 1 && strcmp(statusArm2,'succeeded') == 1 && strcmp(statusArm3,'succeeded') == 1 && strcmp(statusArm4,'succeeded') == 1 && strcmp(statusArm5,'succeeded') == 1 && strcmp(statusArm6,'succeeded') == 1 && strcmp(statusArm7,'succeeded') == 1 && strcmp(statusArm8,'none') == 1 && strcmp(statusArm9,'none') == 1 && strcmp(statusArm10,'none') == 1 && ismember('Base',labels{1,k}) == 1 && ismember('Screw',labels{1,k}) == 0        
            count3 = count3 + 1;
        end
    end
    
    if count3 >= 3 %if 3 out of the last 10 frames detect all the Objects to detect and all the prior movements were already made, execute movement 3
        [statusArm8,statusArm9,statusArm10] = screwdriverOut(Arm,GoalMsg);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Movement 4 - pick wheel box and place it outside of the working space
count4 = 0;

    for p=1:length(labels)
        %Objects to detect: Base, Belt, Wheel_A, Wheel_B
        if strcmp(statusArm1,'succeeded') == 1 && strcmp(statusArm2,'succeeded') == 1 && strcmp(statusArm3,'succeeded') == 1 && strcmp(statusArm4,'succeeded') == 1 && strcmp(statusArm5,'succeeded') == 1 && strcmp(statusArm6,'succeeded') == 1 && strcmp(statusArm7,'succeeded') == 1 && strcmp(statusArm8,'succeeded') == 1 && strcmp(statusArm9,'succeeded') == 1 && strcmp(statusArm10,'succeeded') == 1 && ismember('Base',labels{1,p}) == 1 && ismember('Belt',labels{1,p}) == 1 && ismember('Wheel_A',labels{1,p}) == 1 && ismember('Wheel_B',labels{1,p}) == 1     
            count4 = count4 + 1;
        end
    end
    
    if count4 >= 2 %if 2 out of the last 10 frames detect all the Object to detect and all the prior movements were already made, execute movement 4
        [statusArm11,statusArm12,statusArm13] = wheelboxOut(Arm,GoalMsg);
        pause(1.0)
    end

labels = cell(1,framesN);
end

rosshutdown