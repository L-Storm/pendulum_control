%% Inverted Pendulum model parameters
% Run this block to initialise simscape pendulum model parameters
g = 9.81;

% DC Motor Parameters
kt=0.00768;% torque constant (got from data sheet)
km=0.00768;% motor back-emf constant (got from data sheet)
R=2.6;% terminal resistance (got from data sheet)
L=0.00018;% terminal inductance (got from data sheet)

% Inverted Pendulum Parameters
% lengths are in cm and mass in kg
base_size=12.5; % length of pendulum base cube (init 7)

% Rotary arm parameters
rod_rad=1;% rotary arm radius (NA)
rod_length=22;% rotary arm length
rod_mass=0.256;% rotary arm mass

% Pendulum parameters
p_rad=0.6;% pendulum radius
p_length=33;% pendulum length
p_mass=0.126;% pendulum mass
rt1=base_size/2;
rt2=rod_length-0.4;
rt4=p_length/2;
D_r=0.0015/2;
D_p=0.0005/2;

% Initial pendulum intial angle in degrees
% 180 corresponds to upright position
% can also be selected in the simulink model
alpha_0=170;


%% State space equation for state-feedback controller for Inverted Pendulum
% Run this block to initialise state-space controller parameters

% Inverted Pendulum Parameters
% Rotary arm parameters
L_1=rod_length/100;%convert cm to m
r_1=rod_rad/100;%convert cm to m
m_1=rod_mass;
l_1 = 0.5* L_1; % center of mass 
J_1=(1/4)*m_1*r_1^2+(1/3)*m_1*L_1^2;% rotary arm moment of inertia (arm1)
% Pendulum parameters
L_2=p_length/100;
m_2=p_mass;
r_2=p_rad/100;
l_2 = 0.5* L_2;
J_2=(1/4)*m_2*r_2^2+(1/3)*m_2*L_2^2;% pendulum moment of inertia (arm2)

% System linearized at [0 0 0 0]' or [0 pi 0 0]'
% For [0 0 0 0]' set l=1 For comparing state-space and nonlinear model
% For [0 pi 0 0]' set l=-1 (for controller design)
l=-1;


M=[m_2*L_1^2+J_1 -l*0.5*m_2*L_2*L_1;
   l*0.5*m_2*L_2*L_1 J_2+0.25*m_2*L_2^2];

G=[D_r+kt*km/R 0;0 D_p];

K=[0 0;0 l*0.5*m_2*L_2*9.8];

F=[kt/R;0];

%Linearized System Matrices
A=[zeros(2) eye(2);-inv(M)*K -inv(M)*G];
B=[0;0;inv(M)*F];
C=[1 0 0 0;
   0 1 0 0];
D=[0;0];


%linearised jacobiean 
Jh_1 = J_1 + m_1*l_1^2;
Jh_2 = J_2 + m_2*l_2^2;
Jh_0 = J_1 + m_1*l_1^2 + m_2*L_1^2; 
b1 = 2.8e-4; %guess (damping coefficent at motor)
b2 = 1e-4; %guess (damping coeff between arm1 and arm2)

A_32 = (g*m_2^2*l_2^2*L_1)\(Jh_0*Jh_2-m_2^2*L_1^2*l_2^2);
A_33 = (-b1*Jh_2)\(Jh_0*Jh_2 - m_2^2*L_1^2*l_2^2);
A_34 =  (-b2*m_2*l_2*L_1)\(Jh_0*Jh_2 - m_2^2*L_1^2*l_2^2);
A_42 = (g*m_2*l_2*Jh_0)\(Jh_0*Jh_2-m_2^2*L_1^2*l_2^2);
A_43 = (-b1*m_2*l_2*L_1)\(Jh_0*Jh_2-m_2^2*L_1^2*l_2^2);
A_44 = (-b2*Jh_0)\(Jh_0*Jh_2-m_2^2*L_1^2*l_2^2);

B_31 = Jh_2\(Jh_0*Jh_2-m_2^2*L_1^2*l_2^2);
B_41 = (m_2*L_1*l_2)\(Jh_0*Jh_2-m_2^2*L_1^2*l_2^2);


if l == 1
A_34 = -A_34;
A_42 = -A_42;
A_43 = -A_43;
B_32 = -B_32;
end 


A2 = [0 0 1 0; ...
      0 0 0 1; ...
      0 A_32 A_33 A_34; ...
      0 A_42 A_43 A_44];

B2 = [0; 0; B_31; B_41];

%A = A2;
%B = B2;
% Observer based state-feedback controller
%Feedback controller design
K_c=place(A,B,[-8 -5 -6 -1]);
%Observer design
L_o=place(A',C',5*[-8 -5 -6 -1])';

%% LQR controller design
%Process Noise for Kalman Filter
W=10e-3*B*B';
%Sensor Noise for Kalman Filter
V=10e-3*eye(2);
%System for Kalman filter design
sys=ss(A,[B eye(4)],C,[zeros(2,1) zeros(2,4)]);
%Kalman filter based Observer design
[kest,L_q,P] = kalman(sys,W,V,zeros(4,2));

q_u=1;% control weight
q_y=100;% output weight
Q=q_y*(C'*C+eye(4));
R_p=q_u;
%Controller Design using LQR
[X,K,Leig] = icare(A,B,Q,R_p,zeros(4,1),eye(4),zeros(4));

K_final=K;