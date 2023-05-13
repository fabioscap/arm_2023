function [K,P] = getCameraMatrix
%GETCAMERAMATRIX Returns the parameters of the camera
%   Inputs:
%        
%   Outputs:
%       K: K matrix
%       P: P matrix
    persistent K_ P_
    if isempty(K_)
        sub = rossubscriber("/camera/rgb/camera_info");
        msg = receive(sub,10);
        K_ = reshape(msg.K,3,3);
        P_ = reshape(msg.P,3,4);
    end
    K=K_';
    P = P_;  

end