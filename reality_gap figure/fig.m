phys_data = load("phys_data.mat");
sim_data = load("sim_data2.mat");
disp("data loaded")
%%
<<<<<<< Updated upstream
%plot 
%plot(sim_data.time,sim_data.theta1);
%hold on 
%plot(theta1.time,theta1.signals.values);
%hold off 

plot(sim_data.time, sim_data.theta2)
hold on
plot(theta2.time,theta2.signals.values);
=======
% Exclude data where time is past 5 seconds
sim_time_limit = sim_data.time <= 5;
phys_time_limit = phys_data.time <= 5;

% Figure 1
figure(1);
plot(sim_data.time(sim_time_limit), sim_data.theta1(sim_time_limit), 'r', 'LineWidth', 2); % Red line for simulation data
hold on 
plot(phys_data.time(phys_time_limit), phys_data.thetaX(phys_time_limit), 'k', 'LineWidth', 2); % Black line for physical data
hold off
grid on; % Add grid
title('Comparison of \theta_1 between Simulation and Physical Data'); % Add title
xlabel('Time (s)'); % Add x-axis label
ylabel('\theta_1 (degrees)'); % Add y-axis label
legend('Simulation \theta_1', 'Physical \theta_X'); % Add legend

% Figure 2
figure(2);
plot(sim_data.time(sim_time_limit), sim_data.theta2(sim_time_limit), 'r', 'LineWidth', 2); % Red line for simulation data
hold on
plot(phys_data.time(phys_time_limit), phys_data.thetaY(phys_time_limit) + 180, 'k', 'LineWidth', 2); % Black line for physical data
hold off
grid on; % Add grid
title('Comparison of \theta_2 between Simulation and Physical Data'); % Add title
xlabel('Time (s)'); % Add x-axis label
ylabel('\theta_2 (degrees)'); % Add y-axis label
legend('Simulation \theta_2', 'Physical \theta_Y + 180'); % Add legend

>>>>>>> Stashed changes
