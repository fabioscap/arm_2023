function img = takePicture(folder, type)
    arguments
        folder
        type="rgb"
    end
%TAKEPICTURE Summary of this function goes here
%   Detailed explanation goes here
    if type=="rgb"
        ImgSub = rossubscriber("/camera/rgb/image_raw","sensor_msgs/Image","DataFormat","struct");
    elseif type=="depth"
        ImgSub = rossubscriber("/camera/depth/image_raw","sensor_msgs/Image","DataFormat","struct");
    end
    curImage = receive(ImgSub,3);
    pause(1)
    img = rosReadImage(ImgSub.LatestMessage); 
    if folder ~= "None"
        filename = folder+nextname(folder+"pic","000",".png");
        imwrite(img,filename);
    end
end

