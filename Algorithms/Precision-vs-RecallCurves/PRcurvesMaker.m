%% Create precision vs recall curves
%by Pedro P. Garcia, July 2021

clear
clc

%% Load results of the 4 deep learning models

%ResNet-50 -> Faster R-CNN
load('C:\Users\Pedro G\Desktop\Tese\Development\Algorithms\FasterRCNN\ResNet50-Detections.mat','ap','recall','precision')
ap50 = ap;
recall50 = recall;
precision50 = precision;
clear ap recall precision

%ResNet-101 -> Faster R-CNN
load('C:\Users\Pedro G\Desktop\Tese\Development\Algorithms\FasterRCNN\ResNet101-Detections.mat','ap','recall','precision')
ap101 = ap;
recall101 = recall;
precision101 = precision;
clear ap recall precision

%Darknet-19 -> YOLOv2
load('C:\Users\Pedro G\Desktop\Tese\Development\Algorithms\YOLO\YOLOv2-Detections.mat','ap','recall','precision')
ap19 = ap;
recall19 = recall;
precision19 = precision;
clear ap recall precision

%Darknet-53 -> YOLOv3
load('C:\Users\Pedro G\Desktop\Tese\Development\Algorithms\YOLO\YOLOv3-Detections.mat','ap','recall','precision')
ap53 = ap;
recall53 = recall;

precision53 = precision;
clear ap recall precision
%% Create the plot for the PR curves

for i=1:4
    if i == 1
        x1 = recall50{1,1};
        y1 = precision50{1,1};
        x2 = recall50{2,1};
        y2 = precision50{2,1};
        x3 = recall50{3,1};
        y3 = precision50{3,1};
        x4 = recall50{4,1};
        y4 = precision50{4,1};
        x5 = recall50{5,1};
        y5 = precision50{5,1};
        x6 = recall50{6,1};
        y6 = precision50{6,1};
        x7 = recall50{7,1};
        y7 = precision50{7,1};
        x8 = recall50{8,1};
        y8 = precision50{8,1};
        x9 = recall50{9,1};
        y9 = precision50{9,1};
        x10 = recall50{10,1};
        y10 = precision50{10,1};
        x11 = recall50{11,1};
        y11 = precision50{11,1};
        
        plot(x1,y1,'b','DisplayName','Base')
        hold on
        plot(x2,y2,'DisplayName','Stepper')
        plot(x3,y3,'DisplayName','Belt')
        plot(x4,y4,'DisplayName','Robot')
        plot(x5,y5,'DisplayName','Screwdriver')
        plot(x6,y6,'--o','DisplayName','Screw')
        plot(x7,y7,'--','DisplayName','HumanHand')
        plot(x8,y8,'--','DisplayName','Wheel_A')
        plot(x9,y9,'--','DisplayName','Wheel_B')
        plot(x10,y10,'--','DisplayName','Wheel_C')
        plot(x11,y11,'--','DisplayName','Wheel_D')
        hold off
        
        lgd = legend;
        lgd.NumColumns = 2;
        lgd.Location = 'southeast';
        lgd.Title.String = 'Object Classes';
        xlabel('Recall')
        ylabel('Precision')
        grid on
        title(sprintf('YOLOv3 | mAP = %.2f%%', sum(ap50)/11*100))
        ylim([0 1])
        xlim([0 1])
    elseif i == 2
        x1 = recall101{1,1};
        y1 = precision101{1,1};
        x2 = recall101{2,1};
        y2 = precision101{2,1};
        x3 = recall101{3,1};
        y3 = precision101{3,1};
        x4 = recall101{4,1};
        y4 = precision101{4,1};
        x5 = recall101{5,1};
        y5 = precision101{5,1};
        x6 = recall101{6,1};
        y6 = precision101{6,1};
        x7 = recall101{7,1};
        y7 = precision101{7,1};
        x8 = recall101{8,1};
        y8 = precision101{8,1};
        x9 = recall101{9,1};
        y9 = precision101{9,1};
        x10 = recall101{10,1};
        y10 = precision101{10,1};
        x11 = recall101{11,1};
        y11 = precision101{11,1};
        
        plot(x1,y1,'b','DisplayName','Base')
        hold on
        plot(x2,y2,'DisplayName','Stepper')
        plot(x3,y3,'DisplayName','Belt')
        plot(x4,y4,'DisplayName','Robot')
        plot(x5,y5,'DisplayName','Screwdriver')
        plot(x6,y6,'--o','DisplayName','Screw')
        plot(x7,y7,'--','DisplayName','HumanHand')
        plot(x8,y8,'--','DisplayName','Wheel_A')
        plot(x9,y9,'--','DisplayName','Wheel_B')
        plot(x10,y10,'--','DisplayName','Wheel_C')
        plot(x11,y11,'--','DisplayName','Wheel_D')
        hold off
        
        lgd = legend;
        lgd.NumColumns = 2;
        lgd.Location = 'southeast';
        lgd.Title.String = 'Object Classes';
        xlabel('Recall')
        ylabel('Precision')
        grid on
        title(sprintf('YOLOv3 | mAP = %.2f%%', sum(ap101)/11*100))
        ylim([0 1])
        xlim([0 1])
        
    elseif i == 3
        x1 = recall19{1,1};
        y1 = precision19{1,1};
        x2 = recall19{2,1};
        y2 = precision19{2,1};
        x3 = recall19{3,1};
        y3 = precision19{3,1};
        x4 = recall19{4,1};
        y4 = precision19{4,1};
        x5 = recall19{5,1};
        y5 = precision19{5,1};
        x6 = recall19{6,1};
        y6 = precision19{6,1};
        x7 = recall19{7,1};
        y7 = precision19{7,1};
        x8 = recall19{8,1};
        y8 = precision19{8,1};
        x9 = recall19{9,1};
        y9 = precision19{9,1};
        x10 = recall19{10,1};
        y10 = precision19{10,1};
        x11 = recall19{11,1};
        y11 = precision19{11,1};
        
        plot(x1,y1,'b','DisplayName','Base')
        hold on
        plot(x2,y2,'DisplayName','Stepper')
        plot(x3,y3,'DisplayName','Belt')
        plot(x4,y4,'DisplayName','Robot')
        plot(x5,y5,'DisplayName','Screwdriver')
        plot(x6,y6,'--o','DisplayName','Screw')
        plot(x7,y7,'--','DisplayName','HumanHand')
        plot(x8,y8,'--','DisplayName','Wheel_A')
        plot(x9,y9,'--','DisplayName','Wheel_B')
        plot(x10,y10,'--','DisplayName','Wheel_C')
        plot(x11,y11,'--','DisplayName','Wheel_D')
        hold off
        
        lgd = legend;
        lgd.NumColumns = 2;
        lgd.Location = 'southeast';
        lgd.Title.String = 'Object Classes';
        xlabel('Recall')
        ylabel('Precision')
        grid on
        title(sprintf('YOLOv3 | mAP = %.2f%%', sum(ap19)/11*100))
        ylim([0 1])
        xlim([0 1])
        
    else
        x1 = recall53{1,1};
        y1 = precision53{1,1};
        x2 = recall53{2,1};
        y2 = precision53{2,1};
        x3 = recall53{3,1};
        y3 = precision53{3,1};
        x4 = recall53{4,1};
        y4 = precision53{4,1};
        x5 = recall53{5,1};
        y5 = precision53{5,1};
        x6 = recall53{6,1};
        y6 = precision53{6,1};
        x7 = recall53{7,1};
        y7 = precision53{7,1};
        x8 = recall53{8,1};
        y8 = precision53{8,1};
        x9 = recall53{9,1};
        y9 = precision53{9,1};
        x10 = recall53{10,1};
        y10 = precision53{10,1};
        x11 = recall53{11,1};
        y11 = precision53{11,1};
        
        plot(x1,y1,'b','DisplayName','Base')
        hold on
        plot(x2,y2,'DisplayName','Stepper')
        plot(x3,y3,'DisplayName','Belt')
        plot(x4,y4,'DisplayName','Robot')
        plot(x5,y5,'DisplayName','Screwdriver')
        plot(x6,y6,'--o','DisplayName','Screw')
        plot(x7,y7,'--','DisplayName','HumanHand')
        plot(x8,y8,'--','DisplayName','Wheel_A')
        plot(x9,y9,'--','DisplayName','Wheel_B')
        plot(x10,y10,'--','DisplayName','Wheel_C')
        plot(x11,y11,'--','DisplayName','Wheel_D')
        hold off
        
        lgd = legend;
        lgd.NumColumns = 2;
        lgd.Location = 'southeast';
        lgd.Title.String = 'Object Classes';
        xlabel('Recall')
        ylabel('Precision')
        grid on
        title(sprintf('YOLOv3 | mAP = %.2f%%', sum(ap53)/11*100))
        ylim([0 1])
        xlim([0 1])
    end
end