
%% The equations of motion for a rotary pendulum (furuta pendulum) is
% tested by ode45 against a SimMechanics simulation.
% Actuation is in torque at the base.
% Equations are the full non-linear version but neglect friction and
% lateral inertia.
% 
% See Benjamin Seth Cazzolato and Zebb Prime, "On the Dynamics of the 
% Furuta Pendulum,"Journal of Control Science and Engineering, Volume 2011,
% Article ID 528341, 8 pages, doi:10.1155/2011/528341
%
% Created by Alan Jennings, 2012, alanjenningsohio (at) hotmail dot com

%% Set parameters
m1=0.2;%kg
m2=0.7; %kg
L1=1.4;%m
L2=0.5;%m
g=9.81; %m/sec^2
%create base input to excite the system, must be the same as in Simulink
%for perfict comparison
% u=@(x,t) 10.00*(t<10.01); 
u_base=@(x,t) 5*sin(2*pi*t)+10; %N*m, 
% x is state vector [angle(base, pen), vel(base, pen)];
%note that the Simulink has an delay for state feedback

Mod2pi=@(a) atan2(sin(a),cos(a));

%% Pull output from Simulink if results are in the workspace
Flag_Pen.SimResults=false;
t_sim=linspace(0,1,100);
x_o=[0,0,0,1].';

%% Set up and use ode45 to find response

MassMatrixInv=@(a2) [(m1*L1^2/3+m2*L1^2+4/3*m2*L2^2*sin(a2)^2), ...
    (-m2*L1*L2*cos(a2)); (-m2*L1*L2*cos(a2)), 4/3*m2*L2^2]^-1;
Dynamics=@(t,x) [x(3);x(4);(...
    MassMatrixInv(x(2))*([u_base(x,t)+...
    -x(3)*x(4)*4/3*m2*L2^2*(2*sin(x(2))*cos(x(2)))-x(4)^2*m2*L1*L2*sin(x(2));...
    +x(3)^2*4/3*m2*L2^2*sin(x(2))*cos(x(2))+m2*g*L2*sin(x(2))]))];

[t,Theta]=ode45(Dynamics,t_sim,x_o);

% Recalculate derivatives and control for comparison
Theta_dot=zeros(size(Theta));
U=zeros(size(t));
for angie=1:length(t)
    Theta_dot(angie,:)=Dynamics(t(angie),Theta(angie,:)).';
    U(angie)=u_base(Theta(angie,:),t(angie));
end

figure(50);clf;
subplot(2,1,1);
plot(t,atan2(sin(Theta(:,1:2)),cos(Theta(:,1:2)))*180/pi);
xlabel('t (sec)');ylabel('Angle (deg)');title('ODE45 Results');
legend('\theta_b_a_s_e','\theta_p_e_n');
subplot(2,1,2);
plot(t,Theta(:,3:4)*180/pi)
xlabel('t (sec)');ylabel('Angular Velocity (deg/sec)'); 


figure(52);clf;
subplot(3,1,1);
plot(t,Mod2pi(Theta(:,1))*180/pi,'b-', ...
    t_sim,Theta1_sim(:)*180/pi,'g--')
ylabel('Angle (deg)');title('\theta_b_a_s_e')
legend('ode','SimMech')
subplot(3,1,2);
plot(t,Theta(:,3)*180/pi,'b-',...% t,Theta_dot(:,1)*180/pi,'c-x', ...
    t_sim,Theta1d_sim(:)*180/pi,'g-')
ylabel('Velocity (deg/sec)');
subplot(3,1,3);
plot(t,Theta_dot(:,3)*180/pi,'b-', ...
    t_sim,Theta1dd_sim(:)*180/pi,'g-')
xlabel('t (sec)');ylabel('Accel (deg/sec^2)');

figure(53);clf;
subplot(3,1,1);
plot(t,Mod2pi(Theta(:,2))*180/pi,'b-', ...
    t_sim,Theta2_sim(:)*180/pi,'g--')
ylabel('Angle (deg)');title('\theta_p_e_n')
legend('ode','SimMech')
subplot(3,1,2);
plot(t,Theta(:,4)*180/pi,'b-',...% t,Theta_dot(:,2)*180/pi,'c-x', ...
    t_sim,Theta2d_sim(:)*180/pi,'g-')
ylabel('Velocity (deg/sec)');
subplot(3,1,3);
plot(t,Theta_dot(:,4)*180/pi,'b-', ...
    t_sim,Theta2dd_sim(:)*180/pi,'g-')
xlabel('t (sec)');ylabel('Accel (deg/sec^2)');