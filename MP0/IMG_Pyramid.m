function [translation] = IMG_Pyramid(s,w,color,ref,trans)
%UNTITLED8 Summary of this function goes here
%   scale down image starting from coarsest image to finest
%   aligns color to reference image

    if(s > 1)
        %fed in downscaled image     
        %center of scaled images
        centH = floor(size(ref,1)/2);
        centW = floor(size(ref,2)/2);
        %{
        disp("scale: " + s)
        disp("centH: " + centH)
        disp("centW: " + centW)
        disp("w: " + w)
       %}
        %window trimmed to center critical region
        cColor = color(centH-w:centH+w, centW-w:centW+w);
        cRef = ref(centH-w:centH+w, centW-w:centW+w); 
       
        %finding translation in current image (scaled down)
        %disp("trans: " + trans)
        temp = alignIMG_center(cColor,cRef,w);
        %disp("Scale: " + s + " | trans: " + temp)
        cColor = circshift(cColor,temp);
        temp = temp + trans; 
        translation =  IMG_Pyramid(s/2, w/2, imresize(cColor,2),imresize(cRef,2),2*temp);
  
    else
        centH = floor(size(color,1)/2);
        centW = floor(size(color,2)/2);
       %disp("centH: " + centH + " centW: " + centW)
        %disp("trans: " + trans)
        cColor = color(centH-w:centH+w, centW-w:centW+w);
        cRef = ref(centH-w:centH+w, centW-w:centW+w);
        %finding translation
        temp = alignIMG_center(cColor,cRef,w); 
        %disp("temp: " + temp)
        translation = temp+ trans; 
        
    end
end

