function [tf, pctf, rmse] = modelfit(pc,pcmodel,initGuess, scale)
%MODELFIT Finds the best transformation between two pointclouds
%   Inputs:
%       pc: fixed pointcloud
%       pcmodel: moving pointcloud
%       initGuess: initial guess for the transformation
%       scale: scale of the model
%   Outputs:
%       tf: found transformation
%       pctf: transformed pointcloud of pcmodel
%       rmse: root mean square error calculated over the point of pctf
    arguments
        pc
        pcmodel
        initGuess = "None"
        scale=1 % I already scaled
    end
    pcsc = pointCloud(scale*pcmodel);
    if class(initGuess) == "string"
        [tf, pctf, rmse] = pcregistericp(pcsc, ...
                                         pcdownsample(pointCloud(pc),"gridAverage",0.001),...
                                         "Metric", "PlaneToPlane");
    else
        [tf, pctf, rmse] = pcregistericp(pcsc, ...
                                 pcdownsample(pointCloud(pc),"gridAverage",0.001),...
                                 "Metric", "PlaneToPlane", "InitialTransform", initGuess);
    end
    pctf = pctf.Location;
end
