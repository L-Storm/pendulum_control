%% Inverted Pendulum model parameters (init model params) 
% Run this block to initialise simscape pendulum model parameters
g = 9.81;

% DC Motor Parameters
kt=0.00768;% torque constant (got from data sheet)
km=0.00768;% motor back-emf constant (got from data sheet) +- 12% max 0.00860
R=2.6;% terminal resistance (got from data sheet)
L=0.00018;% terminal inductance (got from data sheet)

% Inverted Pendulum Parameters
% lengths are in cm and mass in kg
base_size=12.5; % length of pendulum base cube (init 7)

% Rotary arm parameters
rod_rad=3;% rotary arm radius (NA)
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
disp("init model params")
%% PID evolution algorythm. 

%% sample plan
%P = bestlh(100,6,100,60);
%P(:,1:3) = P(:,1:3)*100;
%P(:,4:6) = P(:,4:6)*1000;
%save('P.mat',"P")
%disp(P);
load("P.mat")
%%
% init PID 
tuningValues.Kp1 = 60;
tuningValues.Ki1 = 40; 
tuningValues.Kd1 = 0; 
tuningValues.Kp2 = 600;
tuningValues.Ki2 = 100;
tuningValues.Kd2 = 0; 
disp("init tuning params")
tuning_bus_info = Simulink.Bus.createObject(tuningValues);
tuning_bus = evalin('base', tuning_bus_info.busName);

%run sim mechanics + return results. 
otpt = sim_function();

%evaluate results
results.run1 = evaluation_function(otpt,tuningValues);



%% FUNCTIONS 


function [otpt] = sim_function()
%SIM_FINCTION run the simmechanics simulation and return the
%results. 

sim_return = sim('PID_evolution_mdl.slx',10); % run sim for 10 secs. 

otpt = sim_return.yout;


disp("finished simulation")
end

function [run] = evaluation_function(otpt,tuningValues)
%EVALUATION FUNCTION returns the performance of a simulation based upon the
%results of sim_function.


run.tuningValues = tuningValues;
run.theta1 = otpt{1}.Values.Data;
run.theta2 = otpt{2}.Values.Data;
run.time   = otpt{2}.Values.Time;


%% SSRMSE 
% Extract time and theta data;
theta1 = otpt{1}.Values.Data;
time = otpt{2}.Values.Time;
theta2 = otpt{2}.Values.Data;

% Define the setpoint (assuming the setpoint is 0)
setpoint1 = 0;
setpoint2 = 3.1415926;
% Find the indices where time is greater than 5 seconds
indices = find(time > 5);

% Extract the relevant time and theta values
time_ss = time(indices);
theta1_ss = theta1(indices);
theta2_ss = theta2(indices); 

% Calculate the error
err_theta1_ss = theta1_ss - setpoint1;
err_theta2_ss = theta2_ss - setpoint2; 

% Compute RMSE
run.evaluation.ssrmse1 = sqrt(mean(err_theta1_ss.^2));
run.evaluation.ssrmse2 = sqrt(mean(err_theta2_ss.^2));

%% setting time: 
% Example time series data

% Define the thresholds
diff = 0.00872665; % 0.5 degrees. 
lower_threshold = pi-diff;
upper_threshold = pi+diff;

% Find indices where data is within the specified range
indices_within_range = find(theta2 <= lower_threshold | theta2 >= upper_threshold);

% Check if there are any indices within the specified range
if ~isempty(indices_within_range)
    % Find the latest time (maximum index) where data is within the specified range
    latest_index_within_range = max(indices_within_range);
    run.evaluation.settingTime2 = time(latest_index_within_range);
else
    disp('No instances found where the data is within the range');
    run.evaluation.settingTime2 = 11;
end


%% overshoot 
% Define the threshold (pi)
threshold = setpoint2; % pi 

% Find indices where data crosses from below to above threshold
crossings = find(theta2(1:end-1) < threshold & theta2(2:end) >= threshold);

if length(crossings) >= 2
    % Get times of the first and second crossings
    time_first_crossing = time(crossings(1));
    time_second_crossing = time(crossings(2));
    
    % Find maximum value of data between the two crossings
    data_between_crossings = theta2(time >= time_first_crossing & time <= time_second_crossing);
    max_value_between_crossings = max(data_between_crossings);
    
    % Calculate overshoot
    run.evaluation.overshoot2 = (max_value_between_crossings - threshold) / 0.174533 * 100; % 0.17 is init displacement condition. 
    
else
    disp('err calculating overshoot. less than 2 crossings found');
    run.evaluation.overshoot2 = 11; 

    if run.evaluation.ssrmse < 0.005
        run.evaluation.overshoot2 = 0; % if it doesn't overshoot, and SSRMS is low, perhaps its critically damped?  
    end
end


run.evaluation.note = "SSRMSE1: deviation from init theta 1 [rad]" + ...
    "SSRMSE2 deviation from init theta 2 [rad]" + ...
    "settingTime2 time untill  theta 2 responce remains within 0.5 degrees of origin. [s]" + ...
    "overshoot: amount theta 2 passes the inital angle by as a percentage of init displacement.";
disp("finished evaluation")
end 