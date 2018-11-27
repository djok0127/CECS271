t = input('Please input T > 0: ');
n = input('Please input the partition size n: ');
c = input('0=Euler, 1 = predictor-correction, 2=exact second-order, 3 = midpoint, 4 = Ralstonís: ');


% find the delta x for the euler's 
delta_x = t/n;

% set xi to 0
xi = 0;

% find the first value when x or t is equal to 0
% x0 is at index 1
y(1) = true(xi);



% loop until the index reaches n
for i = 2:n
    xi = delta_x + xi;
    switch c
        case 0
            y(i) = euler(xi, y(i-1), delta_x);
        case 1 
            y(i) = PC_euler(xi, y(i-1), delta_x);
        case 2
            
        case 3
            y(i) = mid(xi, y(i-1), delta_x);
    end
    % index starts at 2 because array in matlab is from 1
    fprintf('i: %d, xi: %f, y approx: %f, y true: %f \n', i - 1, xi, y(i-1), true(xi));
end

        

% @param xi = current x index
% @param prev_y = previous y value that is already computed
% @param delta_x = h value for euler
% @returns approx = eulers approximation
% Computes the approximation using eulers method
function approx = euler(xi, prev_y, delta_x)

    % calculate the euler's method
    approx =  prev_y + delta_x * diff_eq(xi);
end

% @param xi = current x index
% @param prev_y = previous y value that is already computed
% @param delta_x = h value for euler
% @returns approx = eulers approximation
% Computes the approximation using eulers prediction correction method
function approx = PC_euler(xi, prev_y, delta_x)
    
    % does not need a y star since the function only depends on variable t
    y_star = euler(xi, prev_y, delta_x);
    
    approx = prev_y + delta_x * (diff_eq(xi)+diff_eq(xi+delta_x)/2);
end

% @param xi = current x index
% @param prev_y = previous y value that is already computed
% @param delta_x = h value for euler
% @returns approx = eulers approximation
% Computes the approximation using midpoint prediction method
function approx = mid(xi, prev_y, delta_x)
    
    % does not need a y star since the function only depends on variable t
    % need to fix the y star if it is going to be used
    y_star = euler(xi, prev_y, delta_x);
    
    approx = prev_y + delta_x * diff_eq(xi + delta_x/2 );
end

% differential equation
function compute = diff_eq(t)
    compute = (1/4) - (3/500) * ((125/3) + (100/3) * exp(-3 * t/500));
end

% function that finds S(t)
function compute = true(t)
    compute =(125/3) + (100/3) * exp(-3 * t/500);
end