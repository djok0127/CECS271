
n = input('Please enter n for the Horners algorithm: ');

% initialize the the array with zeros
a = zeros(1,n);
for i = 1:n
    a(i) = input('Please input a number \n');
end

% get the user input of x
x = input('Please enter the x for the Hornets equation: ');

poly1 = poly(a,x);

fprintf('poly: %f \n', poly1);
 
% define the function poly(a, x)
function sum = poly(a, x)
    total = 0;
    % declare l as the length of the array inputted
    l = length(a);
    
    % loop through the array and add the sum to the previous sum
    for i = 1:l
        % accrues total value
        total = total * x + a(i);
    end
    
    sum = total;
end

function sum = poly_prime(a, x) % use horners algorithm use poly(a,x)

    total = 0;
    
    % declare l as the length of the array inputted
    l = length(a);
    
    % loop through the array and add the sum to the previous sum
    for i = 1:l
        % accrues total value
        total = total + (l - i + 1) * power(x, l - i);
    end
    
    sum = total;
end
