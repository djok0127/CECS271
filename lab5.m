fprintf('----------------number 1----------------');

k = input('Please input K ( K >= 0 ) : ');

% gets the input either sine or cosine
SoC = input('Please input 1 for sine or 2 for cosine: ');

% segment for Fourier coefficient.
n = 100;

if(SoC == 1)
    fprintf('sine: \n');
else
    fprintf('cosine: \n');
end

% find c0
fprintf('simpsons approx c0: %f \n', simpson(0,SoC,n));

% finding c1 to cn d1 to dn
for i=1:k
    fprintf('simpsons approx %d %f \n',i,simpson(i,SoC,n));
end

fprintf('----------------number 2----------------');

% get input n from the user
n = input('Please input n > 0: ');

% get input m
m = input('Please input m > 0: ');





function approx = simpson(k,SoC,n)
    delta_x = (2 * pi) / n;
    xi = 0;
    
    % divide by 2pi when k = 0
    if(k == 0)
        pi_div = 1/(2*pi);
    else % divide by pi for other k
        pi_div = 1/pi;
    end
    % add the first index at 0
    sum = f_x(xi,k,SoC);
    xi = xi + delta_x;
    four = 1;
    
    % compute until xi reaches 2pi - xi
    while(xi <= (2 * pi - delta_x))
        
        if(four == 1)
            sum = sum + 4 *f_x(xi,k, SoC);
            four = 0;
        elseif (four == 0)
            sum = sum + 2 *f_x(xi,k, SoC);
            four = 1;
        end % end of if
        
        %fprintf('x_i = %f \n',xi);
        xi = xi + delta_x;
    end % end of while loop
    % adds the end sum
    sum = sum + f_x(2*pi,k,SoC);
    % add the last index at 2pi and divide the approximation with pi
    approx = (sum)*(2*pi/(3*n))*(pi_div) ;
end %end of simpsons approximation

function compute = f_x(x,k,SoC)
    temp = 1;
    
    % computing for none 0 coefficients
    if(k ~= 0)
        %find dk    
        if(SoC == 1)
           temp = x^2 *sin(k*x);
        %find ck
        elseif(SoC == 2)
           temp = x^2 *cos(k*x);
        end
    else % c0
        temp = x^2;
    end % end of computing coefficients
    
    compute = temp;
end % end of function compute