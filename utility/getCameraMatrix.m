function [K,P] = getCameraMatrix
    persistent K_ P_
    sub = rossubscriber("/camera/rgb/camera_info");
    msg = receive(sub,10);
    K_ = reshape(msg.K,3,3);
    K=K_';
    P_ = reshape(msg.P,3,4);
    P = P_  

end