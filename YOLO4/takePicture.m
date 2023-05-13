function img = takePicture(folder, type)
%TAKEPICTURE Takes a picture using the camera on the robot
%   Inputs:
%       folder: where to save the picture. If "None" it does not save the
%       picture
%       type: type of picture. Either "rgb" or "depth"
%   Outputs:
%       img: the picture
    arguments
        folder
        type="rgb"
    end
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

