function [H] = homography(x)
    %% x_p is the desired points
    x_p = .25*[1,375,375,1;525,525,1,1;1,1,1,1];
  
    zero = [0;0;0]';
    %% length is 1.4 * width
    %From lecture 13 "alignment - fitting a homography"
    A = [zero    x(:,1)'     -x_p(2,1)*x(:,1)';
        x(:,1)'  zero        -x_p(1,1)*x(:,1)';
        zero    x(:,2)'     -x_p(2,2)*x(:,2)';
        x(:,2)'  zero        -x_p(1,2)*x(:,2)';
        zero    x(:,3)'     -x_p(2,3)*x(:,3)';
        x(:,3)'  zero        -x_p(1,3)*x(:,3)';
        zero    x(:,4)'     -x_p(2,4)*x(:,4)';
        x(:,4)'  zero        -x_p(1,4)*x(:,4)'];
    
    [U, S, V] = svd(A,0);
    H = reshape( V(:, 9), [3,3])';
  
end
