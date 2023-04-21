function [tf, pctf, rmse] = modelfit(pc,pcmodel, scale)
    arguments
        pc
        pcmodel
        scale=1 % I already scaled
    end
    pcsc = pointCloud(scale*pcmodel);
    [tf, pctf, rmse] = pcregistericp(pcsc, ...
                                     pcdownsample(pointCloud(pc),"gridAverage",0.001),...
                                     "Metric", "PlaneToPlane");
    pctf = pctf.Location;
    rmse
    pcshow(pc,"r"); hold on; pcshow(pctf,"b");
end

