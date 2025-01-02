close all; clear all; clc;

len = 1e4;
dt = .1;
w = 1e-3;
r = nan(1,len);
r(1) = 0;

alpha = .5;

for i=1:len-1
    
% Sine wave %%%
% r(i+1) = sin(w*i) + randn/100;

% Bistable switch %%%
%     r(i+1) = r(i) + dt*(r(i)*(1-r(i)^2) + 1*randn);

% Fixed point %%%
%     r(i+1) = r(i) + dt*(-.5*r(i) + .1*randn + .1*0);
%     r(i+1) = abs(r(i+1));

%%%

% Random walk %%%
    r(i+1) = r(i) + dt*(-alpha*r(i) + 1e-1*randn);

% Add boundary conditions %%%
%     if r(i+1) > 1
%         r(i+1) = 1;%r(i+1) - 1;
%     end
%     if r(i+1) < -1
%         r(i+1) = -1;%r(i+1) + 1;
%     end
%%%

end

xaxis = [0:len-1]*dt/60;
figure; plot(xaxis,r);
xlabel('t (min)'); ylabel('m(t)'); set(gca,'FontSize',15);


compute_and_plot_VF(r,1,1,dt)
box off;
