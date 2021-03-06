t = 0;  % time 0
s = 75; %salt dissolved
T = input('Please input T > 0: ');
n = input('Please input the partition size n: ');
c = input('0=Euler, 1 = predictor-correction, 2=exact second-order, 3 = midpoint, 4 = Ralstonís: ');


% find the delta x for the euler's 
h = T/n;

approx = [];
real = [];
all_t = [];
i = 1;

which = input('0 for number 1 and 2\n1 for number 4 \n');
if(which == 0)
    switch c
        case 0 % Euler
            while t <= T
                EU = euler(t,s,h);
                real_s = real_S(t,s);
                approx(end+1) = EU;
                real(end+1) = real_s;
                all_t(end+1) = t;
                fprintf('i: %d \n',i);
                fprintf('Euler approximation: %f. \n', EU);
                fprintf('true value: %f. \n',real_s);
                t = t + h;
                s = EU; 
                i = i + 1;
            end
            graph_title = 'Euler Approximation Graph';


        case 1 %predictor corrector
            while t <= T
                pre = pred(t,s,t+h,h);
                real_s = real_S(t,s);
                approx(end+1) = pre;
                real(end+1) = real_s;
                all_t(end+1) = t;
                fprintf('i: %d \n',i);
                fprintf('Prediction Correction approximation: %f. \n', pre);
                fprintf('true value: %f. \n',real_s);
                s = pre;
                t = t + h;
                i = i + 1;
            end
            graph_title = 'Predction-Correction Approximation Graph';


        case 2 % exact second order
            while t <= T
                sec = exact_2nd(t,s,h);
                real_s = real_S(t,s);
                approx(end+1) = sec;
                real(end+1) = real_s;
                all_t(end+1) = t;
                fprintf('i: %d \n',i);
                fprintf('Exact 2nd Order approximation: %f. \n', sec);
                fprintf('true value: %f. \n',real_s);
                t = t + h;
                s = sec;
                i = i + 1;
            end

            graph_title = 'Second Order Approximation Graph';

        case 3 % midpoint
            while t <= T
               middle = mid(t,s,h);
               real_s = real_S(t,s);
               approx(end+1) = middle;
               real(end+1) = real_s;
               all_t(end+1) = t;
               fprintf('i: %d \n',i);
               fprintf('Midpoint approximation: %f. \n', middle);
               fprintf('true value: %f. \n',real_s);
               t = t + h;
               s = middle;
               i = i + 1;
            end

            graph_title = 'Midpoint Approximation Graph';

        case 4 % ralston
            while t <= T
                rals = ralston(t,s,h);
                real_s = real_S(t,s);
                approx(end+1) = rals;
                real(end+1) = real_s;
                all_t(end+1) = t;
                fprintf('i: %d \n',i);
                fprintf('Ralston approximation: %f. \n', rals);
                fprintf('true value: %f. \n',real_s);
                t = t + h;
                s = rals;
                i = i + 1;
            end
            graph_title = 'Ralston Approximation Graph';
    end
    dot_graph_x = all_t;
    dot_graph_y = approx;
    scatter(dot_graph_x,dot_graph_y);
    title(graph_title);
    hold on

    line_graph_x = all_t;
    line_graph_y = real;
    plot(line_graph_x,line_graph_y);    
else


    value_EU = 0;
    value_pre = 0;
    value_sec = 0;
    value_middle = 0;
    value_rals = 0;
    t_EU = t;
    t_pre = t;
    t_sec = t;
    t_mid = t;
    t_rals = t;

    while t_EU <= T
        EU = euler(t_EU,s,h);
        real_s = real_S(t_EU,s);
        value_EU = value_EU + (EU - real_s)^2;
        s = EU;
        t_EU = t_EU + h;
    end

    s = 75;
    while t_pre<=T
        pre = pred(t_pre,s,t_pre+h,h);
        real_pre = real_S(t_pre,s);
        value_pre = value_pre + (pre-real_pre)^2;
        s = pre;
        t_pre = t_pre+h;
    end

    s=75;
    while t_sec<=T
        sec = exact_2nd(t_sec,s,h);
        real_sec = real_S(t_sec,s);
        value_sec = value_sec + (sec - real_sec)^2;
        s = sec;
        t_sec = t_sec + h;
    end

    s=75;
    while t_mid<=T
        middle = mid(t_mid,s,h);
        real_middle = real_S(t_mid,s);
        value_middle = value_middle + (middle - real_middle)^2;
        s = middle;
        t_mid = t_mid + h ;
    end

    s=75;
    while t_rals<=T
        rals = ralston(t_rals,s,h);
        real_rals = real_S(t_rals,s);
        value_rals = value_rals + (rals-real_rals)^2;
        s = rals;
        t_rals = t_rals + h;
    end

    EU_close = sqrt(value_EU);
    pre_close = sqrt(value_pre);
    sec_close = sqrt(value_sec);
    mid_close = sqrt(value_middle);
    rals_close = sqrt(value_rals);

    fprintf("Euler: %f \nPredction-Correction: %f \nExact Order: %f \nMidpoint: %f \nRalston: %f\n",EU_close, pre_close, sec_close, mid_close, rals_close);
end


% get the real value 
function real = real_S(x,y)
    real = (125/3)+(100/3)*exp(-3*x/500);
end

% get the dS function value
function f = funct_S(x,y)
    f =(1/4)-(3/500)*((125/3)+(100/3)*exp(-3*x/500));
end

% get the euler approximation
function eu = euler(x,y,h)
    eu = (y+h*funct_S(x,y));
end

% get the prediction correction approximation
function pre_corr = pred(x, y ,x_1 , h)
    y_star = y+h*funct_S(x,y);
    pre_corr = (y+h*(funct_S(x,y)+funct_S(x_1,y_star))/2);
end

% get the second order approximation
function second = exact_2nd (x,y,h)
    der = (-3/500)*((1/4)-((3/500)*((125/3)+(100/3)*exp(-3*x/500))));
    second = y+h*funct_S(x,y)+h^2*der/2;
end

% get the mid point approximation
function midd = mid(x,y,h)
    y_star = y + h*funct_S(x,y)/2;
    midd = y + h*funct_S(x+1/2*h,y_star);
end

% get the ralston approximation
function rals = ralston (x,y,h)
    y_star = y +(3/4)*h*funct_S(x,y);
    rals = y + h*((1/3)*funct_S(x,y)+(2/3)*funct_S(x+(3/4)*h,y_star));
end
