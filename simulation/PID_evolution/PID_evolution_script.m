%% Inverted Pendulum model parameters (init model params) 
% Run this block to initialise simscape pendulum model parameters
g = 9.81;
enable_preference = false; 
generations = 30; 
add_pretuned = true;
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
results = struct(); % pre-define the results data. 
disp("init model params")
%% PID evolution algorythm. 

%% sample plan
P = bestlh(100,6,100,60);
P = P*3; 
%P(:,1:3) = P(:,1:3)*100;
%P(:,4:6) = P(:,4:6)*1000;
save('P.mat',"P")
disp(P);
%STEP1 : load in init population
%P = load("P.mat").P;
disp("pop data loaded")

if add_pretuned
P(1,:) = [0.01 2 0 1 2 1];
disp("with pre-tuned data")
end 
%%

for n = 1:generations
% STEP1.1 : evaluate init population
[c r] = size(P);
tests = 100;
for i = 1:tests
disp(['run', num2str(i),  'gen' , num2str(n),  "started"])

tuningValues.Kp1 = P(i,1);
tuningValues.Ki1 = P(i,2); 
tuningValues.Kd1 = P(i,3); 
tuningValues.Kp2 = P(i,4);
tuningValues.Ki2 = P(i,5);
tuningValues.Kd2 = P(i,6); 
disp("init tuning params")
tuning_bus_info = Simulink.Bus.createObject(tuningValues);
tuning_bus = evalin('base', tuning_bus_info.busName);

%run sim mechanics + return results. 
otpt = sim_function();

% Evaluate results and store them in the results structure
results.(['run', num2str(i),'gen',num2str(n)]) = evaluation_function(otpt, tuningValues);
disp(["run: " num2str(i), 'gen', num2str(n) "complete"])

end

Z = zeros(tests,4);
for i = 1:tests
ans = results.(["run" + num2str(i)+'gen'+ num2str(n)]).evaluation;
% Convert structure fields to a cell array
ansCell = struct2cell(ans);

% Filter out numeric values
numericValues = cellfun(@isnumeric, ansCell);

% Extract numeric values and concatenate them into a row vector
Z(i,:) = [ansCell{numericValues}];
end

% Step 2.1: Non-dominated sorting with preferability (flipped ranking)
if enable_preference
ranking = rank_prf(Z, goals, priority);
else
ranking = rank_nds(Z);
end

% inverse the ranking (makes bigger numbers better) 
ranking = max(ranking) - ranking;

% get crowding distances. 
% Step 2.2: Crowding distance assignment
% NSGA-II density estimator
distances = crowding(Z, ranking);


% Step 3: Performing selection-for-selection
% Binary tournament selection with replacement.
% Returns the indices of the selected individuals.
selectThese = btwr(distances, length(distances));

% Step 4: Performing variation

% Step 4.1: Simulated binary crossover
% Simulated Binary Crossover operator
% for real number representations.

% Z -> objectives
% P - > decision variables

parents  = P(selectThese, :);
bounds = [0, 0, 0, 0, 0, 0; 100, 100,100,1000,1000,1000];

% Step 4.2: Polynomial mutation
% Polynomial mutation operator
% for real number representations.%
C = polymut(parents, bounds);

 % Step 5: Performing selection-for-survival

% Step 5.1: Combine the parent and offspring populations
unifiedPop = [P(1:tests,:); C];

% Step 5.2: Reducing the population
% NSGA II clustering procedure.
% Selects the new parent population from the unified population
% of previous parents and offspring.
sploosh = size(C);
Z_u = Z; 
for i = 1:sploosh(1)
disp(['run', num2str(i),  'gen' , num2str(n),  "child started"])

tuningValues.Kp1 = C(i,1);
tuningValues.Ki1 = C(i,2); 
tuningValues.Kd1 = C(i,3); 
tuningValues.Kp2 = C(i,4);
tuningValues.Ki2 = C(i,5);
tuningValues.Kd2 = C(i,6); 
disp("init tuning params")
tuning_bus_info = Simulink.Bus.createObject(tuningValues);
tuning_bus = evalin('base', tuning_bus_info.busName);

%run sim mechanics + return results. 
otpt = sim_function();

% Evaluate results and store them in the results structure
Z_unified = results; 
Z_unified.(['child', num2str(i),'gen',num2str(n)])= evaluation_function(otpt, tuningValues);

ans = Z_unified.(["child" + num2str(i)+'gen'+ num2str(n)]).evaluation;
% Convert structure fields to a cell array
ansCell = struct2cell(ans);

% Filter out numeric values
numericValues = cellfun(@isnumeric, ansCell);

% Extract numeric values and concatenate them into a row vector
Z_u = [Z_u; ansCell{numericValues}];



end

if enable_preference
new_indices = reducerNSGA_II(unifiedPop, rank_prf(Z_u, goals, priority), crowding(Z_unified, rank_prf(Z_unified, goals, priority)));
else
new_indices = reducerNSGA_II(unifiedPop, rank_nds(Z_u), crowding(Z_u, rank_nds(Z_u)));
end

% Step 5.3: Select the new population
P = unifiedPop(new_indices, :);
end 



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
if ~isempty(indices_within_range) & run.evaluation.ssrmse2 < 1
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

if length(crossings) >= 2 & run.evaluation.ssrmse2 < 1
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

    if run.evaluation.ssrmse2 < 0.005
        run.evaluation.overshoot2 = 0; % if it doesn't overshoot, and SSRMS is low, perhaps its critically damped?  
    end
end


run.evaluation.note = "SSRMSE1: deviation from init theta 1 [rad]" + ...
    "SSRMSE2 deviation from init theta 2 [rad]" + ...
    "settingTime2 time untill  theta 2 responce remains within 0.5 degrees of origin. [s]" + ...
    "overshoot: amount theta 2 passes the inital angle by as a percentage of init displacement.";
disp("finished evaluation")
end 

