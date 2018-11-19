%% Plotting TRANSFORMER POWER
time = 0:(24/143):24;
hvac_oscillation(1:143,1) = csvread("HVAC_Oscillation\T_1_AS_632.csv",9,1);
normal(1:143,1) = csvread("Default_Outputs\T_1_AS_632.csv",9,1);
hvac_outputs2(1:143,1) = csvread("HVAC_Outputs2\T_1_AS_632.csv",9,1);
hvac_evse(1:143,1) =  csvread("HVAC_EVSE_Outputs\T_1_AS_632.csv",9,1);

hvac_oscillation(1:143,2) = time(1:143);
normal(1:143,2) = time(1:143);
hvac_outputs2(1:143,2) = time(1:143);
hvac_evse(1:143,2) = time(1:143);

limit = [];
limit(1:143,1) = 20000;
limit(1:143,2) = time(1:143);
figure;
area(limit(:,2),limit(:,1));
hold on;
area(hvac_oscillation(:,2), hvac_oscillation(:,1));
hold on;
area(hvac_outputs2(:,2),hvac_outputs2(:,1));
hold on;
area(hvac_evse(:,2), hvac_evse(:,1));
hold on;
area(normal(:,2), normal(:,1));
hold on;

legend("Transformer Rating","Hvac Oscillation","HVAC when house empty", "HVAC when EVSE on", "Normal");
ylabel("Power Usage (kVA)");
xlabel("Time (Hours)");
title("Transformer Load");

%% Plotting HVAC LOAD

time = 0:(24/143):24;
hvac_oscillation(1:143,1) = csvread("HVAC_Oscillation\H_1_HVAC.csv",9,1);
normal(1:143,1) = csvread("Default_Outputs\H_1_HVAC.csv",9,1);
hvac_outputs2(1:143,1) = csvread("HVAC_Outputs2\H_1_HVAC.csv",9,1);
hvac_evse(1:143,1) =  csvread("HVAC_EVSE_Outputs\H_1_HVAC.csv",9,1);

hvac_oscillation(1:143,2) = time(1:143);
normal(1:143,2) = time(1:143);
hvac_outputs2(1:143,2) = time(1:143);
hvac_evse(1:143,2) = time(1:143);

figure;

area(hvac_outputs2(:,2),hvac_outputs2(:,1));
hold on;
area(hvac_evse(:,2), hvac_evse(:,1));
hold on;
area(hvac_oscillation(:,2), hvac_oscillation(:,1));
hold on;
area(normal(:,2), normal(:,1));
hold on;

legend("HVAC when house empty", "HVAC when EVSE on","Hvac Oscillation", "Normal");
ylabel("Power Usage (kW)");
xlabel("Time (Hours)");
title("HVAC Load");
