function RMSE = getRMSE(pcFixed, pcMoving)
%GETRMSE Calculate the RMSE between the two pointclouds for each point in
%pcFixed calculating the nwerest point in pcMoving
%   Inputs: 
%       pcFixed: the fixed point cloud
%       pcMoving: the moving pointcloud
%   Outputs:
%       RMSE: the root mean squared error
RMSE = 0;
for i=1:length(pcFixed)
    [indices,dists] = findNearestNeighbors(pointCloud(pcMoving),pcFixed(i,:),1);
    RMSE = RMSE + dists^2;

end
RMSE = sqrt(RMSE/length(pcFixed));