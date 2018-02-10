function [displacement] = alignIMG_center(color, ref, w)
%align Summary of this function goes here
%   Detailed explanation goes here
displacement = [-w, -w];
similarity = -inf; %inf if using SSD, -inf for NCC

for x = -w:w
    for y = -w:w
        shiftedIMG = circshift(color,[y x]);
        %SSD = sum(sum((shiftedIMG-ref).^2));
        NCC = sum(sum((shiftedIMG.*ref)))/sqrt( sum(sum((shiftedIMG.*shiftedIMG)))*sum(sum((ref.*ref))));
        if(NCC > similarity)
            similarity = NCC;
            displacement = [y x];
        end
    end
end


end

