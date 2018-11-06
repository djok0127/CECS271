t = input('Please input T > 0');
n = input('Please input the partition size n');
c = input('0=Euler, 1 = predictor-correction, 2=exact second-order, 3 = midpoint, 4 = Ralston’s');


switch c
    case 0
        % find the delta x for the euler's 
        delta_x = t/n;
        
        % find the first value when x or t is equal to 0
        % x0 is at index 1
        y(1) = diff_eq(0);
        %fprintf('i: %d, xi: %f, y approx: %f, y true: %f',);
        
        % loop until the index reaches n
        for i = 2:n
            xi = delta_x *i;
            y(i) = euler(xi, y(i-1), delta_x);
            fprintf('i: %d, xi: %f, y approx: %f, y true: %f \n', i, xi, y(i), true(xi));
        end
        
        % output prints i, xi, approximation of yi, the true value for yi
        
end
        

function approx = euler(xi, prev_y, delta_x)

    % calculate the euler's method
    approx =  prev_y + delta_x * diff_eq(xi);
end

function compute = diff_eq(t)
    compute = (1/4) - (3/500) * ((125/3) + (100/3) * exp(-3 * t/500));
end

function compute = true(t)
    compute =(125/3) + (100/3) * exp(-3 * t/500);
end