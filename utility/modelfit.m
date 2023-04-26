function [tf, pctf, rmse] = modelfit(pc,pcmodel,initGuess, scale)
    arguments
        pc
        pcmodel
        initGuess = "None"
        scale=1 % I already scaled
    end
    pcsc = pointCloud(scale*pcmodel);
    if initGuess == "None"
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
