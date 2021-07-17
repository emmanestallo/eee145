%Authors:
%Mark Lester Cuaresma
%Han Espinosa
%Andrei Mikhail Serra
%Emmanuel Jesus Estallo

M = 0.02;
D = 0.5;
K = 4.5;
mu = 1.25664e-6;


%%
%question number 2 
i = [0.2 0.5 0.8];
t1 = 0:0.01:1;
x_0 = [0.02 0];
figure('NumberTitle', 'off', 'Name', 'Question 2');
for n = 1:3 
    [t,y] = ode45(@(t,y) calc_ode(t,y,M,D,K,i(n)), t1, x_0);
    plot(t,y(:,1)*1000)
    ylabel('Gap Length (mm)')
    xlabel('Time (s)')
    title('Armature Position')
    hold on
    legend('i=0.2', 'i=0.5', 'i=0.8')
end

%%
%question number 3
i = [0.2 0.5 0.8];
t1 = 0:0.01:1;
x_0 = [0.02 0];
figure('NumberTitle', 'off', 'Name', 'Question 3');
for n = 1:3 
    [t,y] = ode45(@(t,y) calc_ode(t,y,M,D,K,i(n)*(1-exp(-30*t))), t1, x_0);
    plot(t,y(:,1)*1000)
    ylabel('Gap Length (mm)')
    xlabel('Time (s)')
    title('Armature Position with an Exponential Current Decay')
    hold on
    legend('i=0.2', 'i=0.5', 'i=0.8')
end

%% 
%question number 4
i = [0.2 0.5 0.8];
t1 = 0:0.01:1;
x_0 = [0.02 0];
mu = 1.25664e-6;
dist = 0.004;
w = 0.02;
h = 0.04;
N = 100;
xrow = (linspace(x_0(1),x_0(2),101))'*1000;
const = ones(101,1)*(-2*mu*w*h*N*N);
figure('NumberTitle', 'off', 'Name', 'Question 4');
for n = 1:3 
    [t,y] = ode45(@(t,y) calc_ode(t,y,M,D,K,i(n)), t1, x_0);
    plot(t, ( (const*i(n)) ./ ((y(:,1) + dist*ones(101,1)).^(2)) ) .* y(:,2))
    ylabel('Voltage across the coil')
    xlabel('Time (s)')
    hold on
    legend('i=0.2', 'i=0.5', 'i=0.8')
end

%%
%question number 1
function y_prime = calc_ode(t,y,M,D,K,a)
    mu = 1.25664e-6;
    dist = 0.004;
    w = 0.02;
    h = 0.04;
    N = 100;
    x_0 = [0.02 0];
    y_prime = zeros(2,1);
    y_prime(1) = y(2);
    y_prime(2) = ((-mu*w*h*((N*a)^2))/((y(1)+dist)^2))/M + K*x_0(1)/M ... 
        -(D/M)*y(2) - (K/M)*y(1);  
end
