% CECS 271 MatLab Assignment 3
% Dr. Todd Ebert
% Due: October 15th

method = input ('1 = nddf; 2 = poly_newton; 3 = nddf_polynomial: ');

switch method
    case 1
        % number 1
        P = input('Please enter the matrix: ');
        i = input('Please enter the i for the nddf: ');
        ij = input('Please enter the i-j for the nddf: ');
        fprintf('nddf: %f \n', nddf(i,ij,P));
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
end


% define the function nddf(i,j,P)
function slope = nddf(i, ij, P)
    
    % if the difference of the two indexes are only one idex appart,
    % compute the slope
    if(i-ij == 1)

        % return slope 0
        % indexing: rows, columns
        % to get rid of indexing error for the matrix, the indexes are
        % added with + 1
        slope = (P(i+1, 2) - P(ij + 1, 2))/(P(i + 1, 1) - P(ij +1, 1));
    else
        
        % recursive functionality
        % there will not be indexing error until the i-ij == 1 therefore
        % nothing to add to reduce indexing error
        slope = (nddf(i, ij + 1, P) - nddf(i - 1, ij,P))/((P(i + 1, 1) - P(ij +1, 1)));
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
            for j = 1:i
                mult = mult * (z - x(i-1));
            end
            
            % add b to multiplication
            total = total + b(i)*x(i-1);
        end
    end
    
    % return the total sum
    sum = total;
end

function sum = nddf_polynomial(P, z)

    % find the length of z to compute
    l_z = length(z);
    
    % preallocate the space for the array b
    b = zeros(1,l_z);
    x = zeros(1,l_z);
    
    for i = 1:l_z
        
        % get the x values from matrix
        x(i) = P(i,1);
    end 
    
    % compute nddf
    for i = 1:l_z
        b(i) = nddf(i,0,P);
    end
    
    % compute the values
    sum = poly_newton(b,x,z);
end

function draw(P,m)
    z = zeros(m);
    n = length(P);
    for i = 1:m
        z(i) = P(1,1) + i*(P(n,1)-P(1,1))/m;
    end
end