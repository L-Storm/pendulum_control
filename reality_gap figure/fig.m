phys_data = load("phys_data.mat");
sim_data = load("sim_data.mat");
%%
%plot 
plot(sim_data.time,sim_data.theta1);
hold on 
plot(theta1.time,theta1.signals.values);

hold off 
figure; 
plot(sim_data.time, sim_data.theta2)
plot(theta1.time,theta1.signals.values);
