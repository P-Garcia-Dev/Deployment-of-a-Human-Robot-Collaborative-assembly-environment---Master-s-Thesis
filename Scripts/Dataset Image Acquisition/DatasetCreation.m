%% Script for image dataset acquisition
%by Pedro Garcia, July 2021

clc
clear
imaqreset 

%% 
cam = videoinput('winvideo', 2, 'MJPG_1024x576'); %SONY Camera indexing in local machine 
start(cam);

pause(5); %Necessary pause to start image edge webcam software by SONY

ImgCount = 0;

while (ImgCount <= 3869)
    img=getsnapshot(cam);
    
    %Names and path on local machine where .jpg image files were saved 
    fname = ['C:\Users\Pedro G\Desktop\Tese\Development\Dataset\AssemblyImg\AssemblyImg' num2str(ImgCount+1) '.jpg']; 
    
    %Save images in the desired path
    imwrite(img, fname);
    
    %Display image 
    imshow(img)
    pause(1)
    close
    
    ImgCount = ImgCount+1;
end