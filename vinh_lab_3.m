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
        fprintf('nddf_polynomial: %f \n', newton_Divided(P,z));
    case 4
        % number 4
        P = input('Please enter the matrix: ');
        m = input('Please enter m: ');
        
        A = graph(P,m)
end
function coeff = ndff(m,i,j)
    if i == j
        coeff = m(i,2);
    elseif (abs(i-j)==1)
        x_1 = m(i,1);
        x_2 = m(j,1);
        y_1 = m(i,2);
        y_2 = m(j,2);
        coeff = (y_2-y_1)/(x_2-x_1);
    else
        coeff = (( ndff(m,i+1,j)- ndff(m,i,j-1)))/ ( m(j,1)- m(i,1));
    end   

end

function pn = poly_newton (b ,x ,z)
    prod = 0;
    for i = 1: length(b)
        if i == 1
            pn = b(i);  
        else 
            prod = 1;
            for k = 1 : i-1
                prod = prod * (z-x(k));
            end 
            prod = prod * b(i);
        end 
        pn = pn + prod;
    end
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

function matrix_z = graph(matrix, m)
    z = [];
    [x,y] = size(matrix);
    delt_x = (matrix(x,1)-matrix(1,1))/m;
    for i = 1 : m
        z_i = matrix(1,1) + i*delt_x;
        z(end+1) = z_i;
    end
    Pn_z = []; 
    for i = 1 : length(z)
        Pn_i = newton_Divided (matrix,z(i));
        Pn_z(end+1) = Pn_i;
    end
    
    vertical_z = reshape(z,[length(z),1]);
    vert_Pn_z = reshape (Pn_z, [length(Pn_z),1]);
    matrix_z = cat(2,vertical_z,vert_Pn_z);
end