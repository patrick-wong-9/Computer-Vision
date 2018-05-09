function [corners] = getCardVertex(grayIm, coord )
    %grayIm - input image
    %coord  - pixels of contours
    %---------------------------------------------------------------------
    %returns corners for the three cards, ordered starting with the bottom
    %left corner of cards being 1, and moving counter-clockwise
    
    [cim, r, c] = harris(grayIm, 2, 2000, 2, 0, 0);
    candidate_corners =zeros(size(r,1), 2);
    corners = zeros(3,4,3);
    
    for ID = 1:3 %Left, Middle, and Right cards
        %have a list of harris corner detector pts: r and c
        for i = 1:size(r,1)
            %contour boundary pixels
            bound = coord{ID};
            %calculating euclidean distances
            dist = sqrt( (bound(:,1) - r(i)).^2 + (bound(:,2) - c(i)).^2);
            %sort to find close contour point to each harris point
            [B, I] = min(dist);
            candidate_corners(i,1:2) = [B,I];
        end
        
        %finding top 4 smallest distances (corresponding to 4 potential
        %corners)
        [euc_dist, ind] = sort(candidate_corners(:,1)); %idxs for harris
        ind2 = checkCorners(ind, 50, r, c, grayIm);
        
        temp = [c(ind2(1:4))'; r(ind2(1:4))'; [1, 1, 1, 1]];
        corners(:,:,ID) = sortPoints(temp);
        
    end
    %% check if corners are reasonable distance apart
    function corners = checkCorners(ind, th, r, c, grayIm)
        % checks to see if 4 points are truly reasonable distance apart
        terminate = false;
        %
        %                 figure
        %                 imshow(grayIm)
        %                 hold on
        % by using th as a gauge
        for ii = 1:4
            %                         plot(c(ind(ii)), r(ind(ii)), 'rX')
            %                         hold on
            for jj = ii+1:4
                %                                 plot(c(ind(jj)), r(ind(jj)), 'gX')
                %                                 hold on
                dist2 = sqrt( (r(ind(ii)) - r(ind(jj)))^2 + (c(ind(ii)) - c(ind(jj)))^2 );
                % points are too close to each other
                if(dist2 < th)
                    ind(jj) = [];
                    terminate = true;
                    break;
                end
            end
            if(terminate == true)
                break;
            end
        end
        if(terminate == true)
            corners = checkCorners(ind, th, r, c, grayIm);
        else
            corners = ind(1:4);
        end
    end
    
    
end