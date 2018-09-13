%prompt the user to get the limit of the loop
user_approx_error = input('Please input an absolute relative approximate error: ');

approx_e = 0;
relative_approx_e = 99999;
previous_value = 0;

n = 1;
% iterate until the relataive approximate error is less than the input
while relative_approx_e > user_approx_error
    
    % declare width of the rectangle
    delta_x = 2*pi/n;
    total_area = 0;
    
    for i = 1: n
        
        % gets the area of the rectangle
        rect_area = exp(cos(delta_x*(i-1))) * delta_x;
        total_area = rect_area + total_area;
    end
    
    if n > 1
        %calculate the approximate error
        approx_e = total_area - previous_value;
        
        %caculate the relative approximate error
        relative_approx_e = abs(approx_e / total_area);

        fprintf("n: %d, approx error: %f, relative error: %f \n", n, approx_e, relative_approx_e);
    else
        fprintf("n: %d \n", n);
    end
    
    % update counter
    previous_value = total_area;
    n = n+1;
end

