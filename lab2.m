
which = input('1 for horner 2 for number 3: ');
if(which == 1)
    a = input('Please enter a for the Horners algorithm as an array: ');
    l = length(a);

    % get the user input of x
    x = input('Please enter the x for the Hornets equation: ');

    poly1 = poly(a,x);

    fprintf('poly: %f \n', poly1);

    poly_primel = poly_prime(a,x);

    fprintf('poly_prime: %f \n', poly_primel);

else
    a_c = input('Please enter an array of coefficients: ');
    left_end = input ('Please enter a left end point: ');
    right_end = input ('Please enter a right end point: ');

    method = input ('Please enter a method for finding a zero of the polynomial. 1=bisection, 2=newton, 3=secant');

    allowed_error = input('Please enter the maximum allowable absoluate relative approximation error: ');

    switch method
        case 1
            dis = bisection(a_c, right_end, left_end,  allowed_error);
        case 2
            dis = newton(a_c, right_end, left_end,  allowed_error);
        case 3
            dis = secant(a_c, right_end, left_end,  allowed_error);
    end
    % x at the root, f(x), n ,relative_error
    fprintf('x: %f f(x):%f n:%d relateive error: %f \n', dis(1),dis(2),dis(3),dis(4));
end
% define the function poly(a, x)
function sum = poly(a, x)

    total = 0;
    
    % declare l as the length of the array inputted
    l = length(a);
    
    % loop through the array and add the sum to the previous sum
    for i = 1:l
        % accrues total value
        total = horner(a(i), x, total);
    end
    
    sum = total;
end

% define horner's algorithm as a function
function sum = horner(c, x, previous)

    % array that includes the previous value and next polynomial value
    polynomial = [previous * x , c ];
    % horner's algorithm

    sum = polynomial(1) + polynomial(2);
end

function sum = poly_prime(a, x) % use horners algorithm use poly(a,x)

    total = 0;
    
    % declare l as the length of the array inputted
    l = length(a);
    
    % create the prime array
    for i = 1:l
        a(i) = a(i) * (l-i);
    end
    % loop through the array and add the sum to the previous sum
    for i = 1:l-1

        
        % accrues total value
        total = horner(a(i) , x, total);
    end
    
    sum = total;
end

function bisect = bisection(a, r, l, accepted_error)
    relative_error = 9999999;
    n = 1;
    mean = (r + l)/2;
    previous = mean;
    root = 999;
    while(accepted_error < relative_error)
        direction_l = poly(a, mean) * poly(a, l);
        direction_r = poly(a, mean) * poly(a, r);
        
        if (direction_l < 0)
            r = mean;
        elseif (direction_r < 0)
            l = mean;
        else
            root = mean;
        end

        mean = (r + l)/2;
        current = mean;

        relative_error = abs((current - previous)/current);

        previous = current;

        n = n + 1;

    end
    bisect = [mean, poly(a,mean), n - 1 ,relative_error];
end

function newt = newton(a, r, l, allowed_error)

    relative_error = 9999999;
    n = 1;
    current = input('Please enter the X0: ');
    while(allowed_error < relative_error)
        next = current - poly(a, current)/poly_prime(a, current);
        
        relative_error = abs((next - current )/next);
        current = next;
        
        n = n + 1;
    end
    newt = [next, poly(a, next), n-1, relative_error];
end

function sect = secant(a, r, l,  allowed_error)
    relative_error = 9999999;
    n = 1;
    previous = input('Please enter X0: ');
    current = input('Please enter X1: ');
    
    
    while(allowed_error < relative_error)
        f_prime = (poly(a, current) - poly(a, previous))/(current - previous);
        
        next = current - poly(a, current)/f_prime;
        previous = current;
        relative_error = abs((next - current )/next);
        current = next;

        
        n = n + 1;
    end
    sect = [next, poly(a, next), n-1, relative_error];
end