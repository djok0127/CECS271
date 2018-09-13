
% Start of exercise 1

% prompt the user to get the limit of the loop
user_approx_error = input('Please input an absolute relative approximate error: ');

% Variable delcaration
approx_e = 0;
relative_approx_e = 99999;
previous_value = 0;

n = 1;

% iterate until the relataive approximate error is less than the input
while relative_approx_e > user_approx_error
    
    % declare width of the rectangle
    delta_x = 2*pi/n;
    
    % reset the total area to 0
    total_area = 0;
    
    % loop until the area is found
    for i = 1: n
        
        % gets the area of the rectangle
        rect_area = exp(cos(delta_x*(i-1))) * delta_x;
        total_area = rect_area + total_area;
    end
    
    if n > 1 % print the number of iteration, approx error, and relative error
        %calculate the approximate error
        approx_e = abs(total_area - previous_value);
        
        %caculate the relative approximate error
        relative_approx_e = abs(approx_e / total_area);

        fprintf("n: %d, approx error: %f, relative error: %f approx area: %f\n", n, approx_e, relative_approx_e,total_area);
    else % print the first iteration, where the approximate error and relative error is not valid.
        fprintf("n: %d \n", n);
    end
    
    % update counter
    previous_value = total_area;
    n = n+1;
end


% Start of Exercise 2

% declaration of the variables
k = input('Please provide a positive number for k for the equation (xn - xn - 1)/xn = 1/n^k: ');
p = input('Please provide a positive number for upper bound for n: ');
m = input('Please provide a positive number for lower bound for n: ');

% Starting index for the equation 
% 'i' will be used instead of n, because n was used in the first exercise.
i = 2;

% f(x) = 1

% x of 1 is equal to 1
previous_value = 1;


printer = p - m + 1;

% if the bound includes 1, print x1
if printer == 1
     fprintf('x1: 1.000000 \n');
end

while i <= p % iterate until the upper limit is met
    
    
    % Compute the equation
    equation = (1/(1-(1/i^k)))* previous_value;
    
    previous_value = equation;
    % Print the values from the p - m +1 to p
    if i >= printer
        fprintf('x%d: %f \n', i, equation);
    end
    
    % Update the counter
    i = i + 1;
end





