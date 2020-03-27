%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit: Isaac Skog (skog@kth.se), 2016-09-06
% Revised: Bo Bernhardsson, 2018-01-01
% Revised: Idriss Riouak (idriss.riouak@cs.lth.se) 27/03/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear
Ts=0.01; %Sampling period of the data
Tmax=60;
t=0:Ts:Tmax; %6001 sampling (100 minutes)
N=length(t);

% Initialize state vector x
xLund=zeros(10,1);
xLund(end)=1;

xStockholm=zeros(10,1);
xStockholm(end)=1;

% Try out different biases
accbias = [0;0;0];
gyrobias = [0.01*pi/180;0;0];
%Lund geographic coordiantes:
%https://dateandtime.info/citycoordinates.php?id=2693678
uLund = [gravity(55,51) + accbias ; gyrobias];

%Stockholm geographic coordinates:
%https://dateandtime.info/citycoordinates.php?id=2673730
uStockholm = [gravity(59,28) + accbias ; gyrobias];

% simulate IMU standalone navigation system
posLund=zeros(3,N);
posStockholm=zeros(3,N);
for n=2:N
   xLund = Nav_eq(xLund,uLund,Ts);
   xStockholm = Nav_eq(xStockholm,uStockholm,Ts);
   posLund(:,n) = xLund(1:3);
   posStockholm(:,n) = xStockholm(1:3);
end



figure(1)
clf
plot(t,posLund(1,:)','r',t,posLund(2,:)','g',t,posLund(3,:)','b', 'LineWidth',5)
grid on
ylabel('Position error [m]')
xlabel('Time [s]')

hold on
%https://www.mathworks.com/help/matlab/ref/polyfit.html
yPol = polyfit(t,posLund(2,:), 3)
plot((0:10:t(end)), polyval(yPol,(0:10:t(end))),'ro')
legend('x:error','y:error','z:error','y:error approximation')




hold off
figure(2)
clf
plot(t,posStockholm(1,:)','r',t,posStockholm(2,:)','g',t,posStockholm(3,:)','b', 'LineWidth',5)
grid on
ylabel('Position error [m]')
xlabel('Time [s]')
legend('x:error','y:error','z:error')
hold on
plot((0:10:t(end)), polyval(yPol,(0:10:t(end))),'ro')
legend('x:error','y:error','z:error','y:error approximation')






% figure(2)
% loglog(t,pos')
% pos2=9.82*gyrobias(1)*t.^3/6;  % theoretical 
% pos3=9.82*(gyrobias(1))^2*t.^4/24; % theoretical
% hold on
% loglog(t,pos2,'k--')
% loglog(t,pos3,'k--')


