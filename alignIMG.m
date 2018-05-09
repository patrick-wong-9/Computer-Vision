function [SSD, displacement] = alignIMG(img1, img2, w)
    % align two images based on similarity score (SSD)
    % 
    displacement = [-w, -w];
    SSD = inf;
    for x = -w:w
        for y = -w:w
            shiftedIMG = circshift(img1,[y x]);
            if( sum(sum( (shiftedIMG-img2).^2)) < SSD)
                SSD = sum(sum( (shiftedIMG-img2).^2));
                displacement = [y x];
            end
        end
    end   
end

