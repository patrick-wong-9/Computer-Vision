
function [sorted] =  sortPoints(pts)
    quad_pts = pts';
    %sort by x coordinates
    quad_pts = sortrows(quad_pts,[1 2]);
    sorted = zeros(size(quad_pts'));
    
%--------------------corner vertex ordering--------------------------------
    %4      %3
    
    
    
    %1      %2
%--------------------------------------------------------------------------
    % comparing between top left and bottom left
    if(quad_pts(1,2) > quad_pts(2,2))
        sorted(:,1)= quad_pts(1,:);
        sorted(:,4) = quad_pts(2,:);
    else
        sorted(:,1)= quad_pts(2,:);
        sorted(:,4) = quad_pts(1,:);
    end
    %comparing between top right, and bottom right
    if(quad_pts(3,2) > quad_pts(4,2) )
        sorted(:,2) = quad_pts(3,:);
        sorted(:,3) = quad_pts(4,:);
    else
        sorted(:,2) = quad_pts(4,:);
        sorted(:,3) = quad_pts(3,:);
    end
    
end