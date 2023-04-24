position = [0.6,0,0.4,-pi,0,0];

if ~exist("cloud_pouches","var")
    moveTo(position);
    pause(3);
    cloud = getPointCloud2;
    
    mn = [0.48,-0.2,-0.082];
    mx = [0.65,0.16,10-0.615];
    cloud_pouches = pcrestrict(cloud.Location, mn, mx);
else
    disp("skipping photos");
end

n_pouches = 6; % the number of pouches ( the easy ones )

ctrs_good = [    0.6217   -0.1294   -0.0816;
    0.5347    0.1301   -0.0817;
    0.6218   -0.0307   -0.0809;
    0.5355   -0.0325   -0.0814;
    0.5345    0.0411   -0.0817;
    0.6224    0.0419   -0.0811]; % a good initial guess (pouches only rotate)

[labels, ctrs] = kmeans(cloud_pouches, n_pouches, "Start", ctrs_good);

colors = ["r","g","b","magenta","cyan","yellow"];
z_approach = [0 0 0.1 0 0 0];

for i=1:n_pouches
    moveTo
    pouch_i = cloud_pouches(labels==i,1:2);
    center = mean(pouch_i);
    
    theta = pouchOrient(pouch_i);
    disp("pouch angle " + theta*180/pi + " deg")

    moveGripper(0.03, 0); % theres not much distance btween pouches so 
                        % we approach them with a smaller width
    pause(2);
    moveGripper(0.03, 0);
    pause(2);
    moveTo([center, -0.075, -pi, 0, -theta] + z_approach)
    pause(10);
    moveTo([center, -0.080, -pi, 0, -theta])
    pause(10);
    moveTo([center, -0.095, -pi, 0, -theta])
    pause(10);


    moveGripper(0.029/2,50);
    pause(10);
    moveTo([center, -0.075, -pi, 0, -theta] + z_approach)
    moveTo
    moveTo(scale_pos + z_approach);
    pause(10)
    moveTo(scale_pos);
    moveGripper(0.03, 0.0);
    moveTo(scale_pos+ [0 0 -0.01 0 0 0]);
    moveGripper(0.029/2,50);
    pause(2)
    moveTo
    moveTo(canBin);
    moveGripper(0.04,0);
    pause(2)
    moveGripper(0.03,0);
    pause(2)
    % TODO try fitting a square to the point cloud
    % https://people.inf.ethz.ch/arbenz/MatlabKurs/node85.html
end


