function [xyz_restricted] = pcrestrict(xyz,mn,mx)
    xyz_restricted = xyz(xyz(:,1)>=mn(1) & xyz(:,2)>=mn(2) & xyz(:,3)>=mn(3) &...
                         xyz(:,1)<=mx(1) & xyz(:,2)<=mx(2) & xyz(:,3)<=mx(3)  ...
                        ,:);

end

