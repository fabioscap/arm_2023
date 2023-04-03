function rgbImg = takePicture(folder)
%TAKEPICTURE Summary of this function goes here
%   Detailed explanation goes here
    rgbImgSub = rossubscriber("/camera/rgb/image_raw","sensor_msgs/Image","DataFormat","struct");
    curImage = receive(rgbImgSub,3);
    pause(1)
    rgbImg = rosReadImage(rgbImgSub.LatestMessage); 
    if folder ~= "None"
        filename = folder+nextname(folder+"pic","000",".png");
        imwrite(rgbImg,filename);
    end
end

