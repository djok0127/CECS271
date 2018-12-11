fprintf('----------------number 1----------------\n');

k = input('Please input K ( K >= 0 ) : ');

% gets the input either sine or cosine
SoC = input('Please input 1 for sine or 2 for cosine: ');

% segment for Fourier coefficient.
n = 100;

if(SoC == 1)
    fprintf('sine: \n');
else
    fprintf('cosine: \n');
    % find c0
    fprintf('simpsons approx 0: %f \n', simpson(0,SoC,n));
end



% finding c1 to cn d1 to dn
for i=1:k
    fprintf('simpsons approx %d: %f \n',i,simpson(i,SoC,n));
end

fprintf('----------------number 2----------------\n');

% get input n from the user
% nth order trigonometric polynomial
n = input('Please input n > 0: ');

fprintf('sse: %f \n', simpsons2(n));

fprintf('----------------number 3----------------\n');

% get input n
n = input('Please input n > 0: ');

% get input m
m = input('Please input m > 0: ');

delta_x = 2*pi / m;
xi = 0;
i = 0;
while(xi < 2*pi - delta_x)
    xi = xi + delta_x;
    i = i + 1;
    
    all_x(i) =  xi;
    approx(i) = pnt(n, xi);
    ft(i) = f(xi);
end

linspace(0,2*pi, m);
dot_graph_x = all_x;
dot_graph_y = approx;
scatter(dot_graph_x,dot_graph_y);
title('number 3');
hold on

line_graph_x = all_x;
line_graph_y = ft;
plot(line_graph_x,line_graph_y);

%----------------------------- number 1 functions -----------------------------
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
           temp = f(x) *sin(k*x);
        %find ck
        elseif(SoC == 2)
           temp = f(x) *cos(k*x);
        end
    else % c0
        temp = f(x);
    end % end of computing coefficients
    
    compute = temp;
end % end of function compute

%----------------------------- number 2 functions -----------------------------
% change function if necessary
function compute = f(x)
    compute = x^2; 
end %end of f function

function compute = f_pnt(x,n)
    compute = (f(x)-pnt(n,x))^2;
end %end of f_pnt

function compute = pnt(n,x)

    % get cosine when i = 0;
    collect = simpson(0,2,n);
    
    % get sine and cosine
    for i = 1:n
        % get sine
        collect = collect + simpson(i,1,n) * sin(x * i);
        % get cosine
        collect = collect + simpson(i,2,n) * cos(x * i);
    end %end for
    
    compute = collect;
end % ned of pnt

function compute = simpsons2(n)
    %1000 segments
    seg = 1000;
    
    delta_x = (2 * pi) / seg;
    xi = 0;
    
    % add the first index at 0
    sum = f_pnt(xi,n);
    xi = xi + delta_x;
    four = 1;
    
    % compute until xi reaches 2pi - xi
    while(xi <= (2 * pi - delta_x))
        
        if(four == 1)
            sum = sum + 4 *f_pnt(xi,n);
            four = 0;
        elseif (four == 0)
            sum = sum + 2 *f_pnt(xi,n);
            four = 1;
        end % end of if
        
        %fprintf('x_i = %f \n',xi);
        xi = xi + delta_x;
    end % end of while loop
    
    sum = sum + f_pnt(xi,n);
    compute = sum * delta_x / 3;
end % end of simpsons2