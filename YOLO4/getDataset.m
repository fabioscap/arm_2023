xmin = 0;
xmax = 0.6;
ymin = -0.5;
ymax = 0.5;
zmin = 0.3;
zmax = 0.4;

rxmin = -pi-0.7;
rxmax = -pi+0.7;
rymin = 0.7;
rymax = 0.7;
rzmin = -pi;
rzmax = pi;

for x=xmin:0.2:xmax
    for y=ymin:0.2:ymax
        for z=zmin:0.1:zmax
            if x==0 && y<0.11 && y>-0.11
                break
            end
            disp([x,y,z]);
            for i=1:2
                pose = [x,y,z,0.4,rxmin+(rxmax-rxmin)*rand(1),rymin+(rymax-rymin)*rand(1),rzmin+(rzmax-rzmin)*rand(1)];
                moveTo(pose);
                takePicture("pictures/");
            end
        end
    end
end
