% CECS 271 MatLab Assignment 3
% Dr. Todd Ebert
% Due: October 15th

method = input ('1 = nddf; 2 = poly_newton; 3 = nddf_polynomial; 4 = draw: ');

switch method
    case 1
        % number 1
        P = input('Please enter the matrix: ');
        i = input('Please enter the i for the nddf: ');
        j = input('Please enter the j for the nddf: ');
        fprintf('nddf: %f \n', nddf(i,j,P));
    case 2
        % number 2
        b = input('Please enter the vector b: ');
        x = input('Please enter the vector x: ');
        z = input('Please enter the input z: ');
        fprintf('poly_newton %f \n', poly_newton(b,x,z));
    case 3
        % number 3
        P = input('Please enter the matrix: ');
        z = input('Please enter the input z: ');
        fprintf('nddf_polynomial: %f \n', nddf_polynomial(P,z));
    case 4
        % number 4
        P = input('Please enter the matrix: ');
        m = input('Please enter m: ');
        
        draw(P,m)
end


% define the function nddf(i,j,P)
function slope = nddf(i, j, P)

    if(j == 0)
        % return slope 0
        % indexing: rows, columns
        % to get rid of indexing error for the matrix, the indexes are
        % added with + 1
        slope = P(i+1,2);
    else
        % recursive functionality
        % there will not be indexing error until the i-ij == 1 therefore
        % nothing to add to reduce indexing error
        slope = (nddf(i, j - 1, P) - nddf(i - 1, j - 1,P))/((P(i + 1, 1) - P(i+1-j, 1)));
    end
end

function sum = poly_newton(b,x,z)
    total = 0;
    
    % declare l as the length of the array inputted
    l = length(b);
    
    % loop through the array and add the sum to the previous sum
    for i = 1:l
        
        % redfine mult into 1 so it could be multiplied and accrue values
        mult = 1;
        
        % on the first iteration, only take the b of 0
        if(i == 1)
            total = b(i);
        else % accrue value and multiply
            % find the multiplication value next to b
            for j = 1:i-1
                mult = mult * (z - x(j));
            end
            
            % add b to multiplication
            total = total + b(i) * mult;
        end
    end
    
    % return the total sum
    sum = total;
end
function new_P = newton_Divided (m, z)
    p_n = [];
    
    coeff = [];
    for i = 1: size(m,1)
        coeff(end+1) = ndff(m,1,i);
    end
    
    x = [];
    for j = 1 : size(m,1)
        x(end+1) = m(j,1);
    end
    
    for k = 1 : length(z)
        p_n(end+1) = poly_newton(coeff,x,z(k));
    end
    
    new_P = p_n;
    
end

function sum = nddf_polynomial(P, z)

    % find the length of z to compute
    l_z = length(z);
    
    % preallocate the space for the array b
    b = zeros(1,l_z);
    x = zeros(1,l_z);
    a = zeros(1,l_z);
    l_p = length(P);
    for i = 1:l_p
        % get the x values from matrix
        x(i) = P(i,1);
    end 
    
    % compute nddf
    for i = 1:l_p
        b(i) = nddf(i-1,i-1,P);
    end
    for i = 1:l_z
       a(i) = poly_newton(b,x,z(i));
    end
    % compute the values
    sum = a;
end

function draw(P,m)
    
    n = length(P);
    z_x = [];
    z_y = [];
    
    for i = 1:n
        % create the x values for the array of z
        z_x(i) = P(1,1) + i*(P(n,1)-P(1,1))/m;
    end
    
    for i = 1:n
        z_y(i) = nddf_polynomial(P,z_x(i));
        fprintf('z_y: %f i: %d \n',  z_y(i),i);
    end
    
    hold on
    % plots the black dots of z
    plot(z_x(:),z_y(:), 'ko');
    plot(P(:,1),P(:,2), 'r');
    hold off
end