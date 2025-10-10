%% Picoscope plot
% Ana HAAS / LE 05/09/2025

clear all, close all, clc
%% Parameter definition

DELIMITER = ';'; HEADERLINES = 3;
csv_directory_B2 = 'Test_module_20250926/donnes_csv_B2'; % Replace with the name of the directory which contains the CSV files 

csv_files_B2 = dir(fullfile(csv_directory_B2, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B2_1000Hz = csv_files_B2(contains({csv_files_B2.name}, ["1000Hz"]));
csv_files_B2_5000Hz = csv_files_B2(contains({csv_files_B2.name}, ["5000Hz"]));

csv_directory_B4 = 'Test_module_20250926/donnes_csv_B4'; % Replace with the name of the directory which contains the CSV files 
csv_directory_B4_20251007 = 'Test_module_20251007/donnes_csv_B4'; % Replace with the name of the directory which contains the CSV files 

csv_files_B4 = dir(fullfile(csv_directory_B4, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B4_1000Hz = csv_files_B4(contains({csv_files_B4.name}, ["1000Hz"]));
csv_files_B4_5000Hz = csv_files_B4(contains({csv_files_B4.name}, ["5000Hz"]));

csv_files_B4_20251007 = dir(fullfile(csv_directory_B4_20251007, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B4_20251007_1000Hz = csv_files_B4_20251007(contains({csv_files_B4_20251007.name}, ["1000Hz"]));
csv_files_B4_20251007_5000Hz = csv_files_B4_20251007(contains({csv_files_B4_20251007.name}, ["5000Hz"]));

sim_HF_feeder_C1low_1000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence1000Hz_feeder_avecC1low.mat");
sim_HF_feeder_noC1low_1000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence1000Hz_feeder_sansC1lowelec.mat");
sim_HF_nofeeder_C1low_1000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence1000Hz_6Vext_avecC1low.mat");
sim_HF_nofeeder_noC1low_1000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence1000Hz_6Vext_sansC1lowelec.mat");
sim_HF_jumperopen_C1low_1000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence1000Hz_6Vext_avecC1low_jumperopen.mat");
sim_HF_jumperopen_noC1low_1000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence1000Hz_6Vext_sansC1lowelec_jumperopen.mat");


sim_HF_feeder_C1low_5000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence5000Hz_feeder_avecC1low.mat");
sim_HF_feeder_noC1low_5000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence5000Hz_feeder_sansC1lowelec.mat");
sim_HF_nofeeder_C1low_5000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence5000Hz_6Vext_avecC1low.mat");
sim_HF_nofeeder_noC1low_5000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence5000Hz_6Vext_sansC1lowelec.mat");
sim_HF_jumperopen_C1low_5000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence5000Hz_6Vext_avecC1low_jumperopen.mat");
sim_HF_jumperopen_noC1low_5000Hz = load("Module simulation\sim_results\20251006\haute_frequence\results_SIM_VDC40V_15Ohms_Haute_Frequence5000Hz_6Vext_sansC1lowelec_jumperopen.mat");

%% Plot Sequence HF comparison f with feeder with C1low electrolytique

figure(1), hold on
subplot(5,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_feeder_C1low_1000Hz.results.bus_dc.time;
sim_VDC = sim_HF_feeder_C1low_1000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_feeder_C1low_5000Hz.results.bus_dc.time;
sim_VDC = sim_HF_feeder_C1low_5000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Exp 1000 Hz - feeder and $C_{electrolytique}$','Sim 1000 Hz - feeder and $C_{electrolytique}$','Exp 5000 Hz - feeder and $C_{electrolytique}$','Sim 5000 Hz - feeder and $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_HF_feeder_C1low_1000Hz.results.Q1.time;
sim_Q1 = sim_HF_feeder_C1low_1000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#D95319");

t_sim_Q1 = sim_HF_feeder_C1low_5000Hz.results.Q1.time;
sim_Q1 = sim_HF_feeder_C1low_5000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_HF_feeder_C1low_1000Hz.results.Q2.time;
sim_Q2 = sim_HF_feeder_C1low_1000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#D95319");

t_sim_Q2 = sim_HF_feeder_C1low_5000Hz.results.Q2.time;
sim_Q2 = sim_HF_feeder_C1low_5000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')

subplot(5,1,4), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_feeder_C1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_feeder_C1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_feeder_C1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_feeder_C1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')


subplot(5,1,5), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_feeder_C1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_feeder_C1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_feeder_C1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_feeder_C1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f with feeder without C1low electrolytique

figure(2), hold on
subplot(5,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_feeder_noC1low_1000Hz.results.bus_dc.time;
sim_VDC = sim_HF_feeder_noC1low_1000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_feeder_noC1low_5000Hz.results.bus_dc.time;
sim_VDC = sim_HF_feeder_noC1low_5000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Exp 1000 Hz - feeder and no $C_{electrolytique}$','Sim 1000 Hz - feeder and no $C_{electrolytique}$','Exp 5000 Hz - feeder and no $C_{electrolytique}$','Sim 5000 Hz - feeder and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_HF_feeder_noC1low_1000Hz.results.Q1.time;
sim_Q1 = sim_HF_feeder_noC1low_1000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#D95319");

t_sim_Q1 = sim_HF_feeder_noC1low_5000Hz.results.Q1.time;
sim_Q1 = sim_HF_feeder_noC1low_5000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_HF_feeder_noC1low_1000Hz.results.Q2.time;
sim_Q2 = sim_HF_feeder_noC1low_1000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#D95319");

t_sim_Q2 = sim_HF_feeder_noC1low_5000Hz.results.Q2.time;
sim_Q2 = sim_HF_feeder_noC1low_5000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')

subplot(5,1,4), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_feeder_noC1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_feeder_noC1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_feeder_noC1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_feeder_noC1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')


subplot(5,1,5), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_feeder_noC1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_feeder_noC1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_feeder_noC1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_feeder_noC1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f without feeder (6 V ext) with C1low electrolytique

figure(3), hold on
subplot(5,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_nofeeder_C1low_1000Hz.results.bus_dc.time;
sim_VDC = sim_HF_nofeeder_C1low_1000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_nofeeder_C1low_5000Hz.results.bus_dc.time;
sim_VDC = sim_HF_nofeeder_C1low_5000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Exp 1000 Hz - no feeder and $C_{electrolytique}$','Sim 1000 Hz - no feeder and $C_{electrolytique}$','Exp 5000 Hz - no feeder and $C_{electrolytique}$','Sim 5000 Hz - no feeder and $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_HF_nofeeder_C1low_1000Hz.results.Q1.time;
sim_Q1 = sim_HF_nofeeder_C1low_1000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#D95319");

t_sim_Q1 = sim_HF_nofeeder_C1low_5000Hz.results.Q1.time;
sim_Q1 = sim_HF_nofeeder_C1low_5000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_HF_nofeeder_C1low_1000Hz.results.Q2.time;
sim_Q2 = sim_HF_nofeeder_C1low_1000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#D95319");

t_sim_Q2 = sim_HF_nofeeder_C1low_5000Hz.results.Q2.time;
sim_Q2 = sim_HF_nofeeder_C1low_5000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')

subplot(5,1,4), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_nofeeder_C1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_nofeeder_C1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_nofeeder_C1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_nofeeder_C1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')


subplot(5,1,5), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_nofeeder_C1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_nofeeder_C1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_nofeeder_C1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_nofeeder_C1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f without feeder (6 V ext) without C1low electrolytique

figure(4), hold on
subplot(5,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_nofeeder_noC1low_1000Hz.results.bus_dc.time;
sim_VDC = sim_HF_nofeeder_noC1low_1000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_nofeeder_noC1low_5000Hz.results.bus_dc.time;
sim_VDC = sim_HF_nofeeder_noC1low_5000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Exp 1000 Hz - no feeder and no $C_{electrolytique}$','Sim 1000 Hz - no feeder and no $C_{electrolytique}$','Exp 5000 Hz - no feeder and no $C_{electrolytique}$','Sim 5000 Hz - no feeder and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_HF_nofeeder_noC1low_1000Hz.results.Q1.time;
sim_Q1 = sim_HF_nofeeder_noC1low_1000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#D95319");

t_sim_Q1 = sim_HF_nofeeder_noC1low_5000Hz.results.Q1.time;
sim_Q1 = sim_HF_nofeeder_noC1low_5000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_HF_nofeeder_noC1low_1000Hz.results.Q2.time;
sim_Q2 = sim_HF_nofeeder_noC1low_1000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#D95319");

t_sim_Q2 = sim_HF_nofeeder_noC1low_5000Hz.results.Q2.time;
sim_Q2 = sim_HF_nofeeder_noC1low_5000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')

subplot(5,1,4), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_nofeeder_noC1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_nofeeder_noC1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_nofeeder_noC1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_nofeeder_noC1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')


subplot(5,1,5), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_nofeeder_noC1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_nofeeder_noC1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_nofeeder_noC1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_nofeeder_noC1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')
%% Plot Sequence HF comparison f with feeder with C1low electrolytique

figure(5), hold on
subplot(2,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_feeder_C1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_feeder_C1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_feeder_C1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_feeder_C1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([0.393, 0.41])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')
legend('Exp 1000 Hz - feeder and $C_{electrolytique}$','Sim 1000 Hz - feeder and $C_{electrolytique}$','Exp 5000 Hz - feeder and $C_{electrolytique}$','Sim 5000 Hz - feeder and $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(2,1,2), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_feeder_C1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_feeder_C1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_feeder_C1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_feeder_C1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([0.393, 0.41])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')
%% Plot Sequence HF comparison f with feeder without C1low electrolytique

figure(6), hold on
subplot(2,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_feeder_noC1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_feeder_noC1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_feeder_noC1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_feeder_noC1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([0.395, 0.41])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')
legend('Exp 1000 Hz - feeder and no $C_{electrolytique}$','Sim 1000 Hz - feeder and no $C_{electrolytique}$','Exp 5000 Hz - feeder and no $C_{electrolytique}$','Sim 5000 Hz - feeder and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later


subplot(2,1,2), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_feeder_noC1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_feeder_noC1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(3).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_feeder_noC1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_feeder_noC1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([0.395, 0.41])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f without feeder (6 V ext) with C1low electrolytique

figure(7), hold on
subplot(2,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_nofeeder_C1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_nofeeder_C1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_nofeeder_C1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_nofeeder_C1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([0.357, 0.37])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')
legend('Exp 1000 Hz - no feeder and $C_{electrolytique}$','Sim 1000 Hz - no feeder and $C_{electrolytique}$','Exp 5000 Hz - no feeder and $C_{electrolytique}$','Sim 5000 Hz - no feeder and $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later


subplot(2,1,2), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_nofeeder_C1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_nofeeder_C1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_nofeeder_C1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_nofeeder_C1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([0.357, 0.37])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f without feeder (6 V ext) without C1low electrolytique

figure(8), hold on
subplot(2,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_nofeeder_noC1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_nofeeder_noC1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_nofeeder_noC1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_nofeeder_noC1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);


xlim([0.357, 0.37])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')
legend('Exp 1000 Hz - no feeder and no $C_{electrolytique}$','Sim 1000 Hz - no feeder and no $C_{electrolytique}$','Exp 5000 Hz - no feeder and no $C_{electrolytique}$','Sim 5000 Hz - no feeder and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later


subplot(2,1,2), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_1000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_nofeeder_noC1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_nofeeder_noC1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B2, csv_files_B2_5000Hz(4).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_nofeeder_noC1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_nofeeder_noC1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([0.357, 0.37])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f jumper feeder open with C1low electrolytique

figure(9), hold on
subplot(5,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_jumperopen_C1low_1000Hz.results.bus_dc.time;
sim_VDC = sim_HF_jumperopen_C1low_1000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_jumperopen_C1low_5000Hz.results.bus_dc.time;
sim_VDC = sim_HF_jumperopen_C1low_5000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Exp 1000 Hz - feeder jumper open and $C_{electrolytique}$','Sim 1000 Hz - feeder jumper open and $C_{electrolytique}$','Exp 5000 Hz - feeder jumper open and $C_{electrolytique}$','Sim 5000 Hz - feeder jumper open and $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_HF_jumperopen_C1low_1000Hz.results.Q1.time;
sim_Q1 = sim_HF_jumperopen_C1low_1000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#D95319");

t_sim_Q1 = sim_HF_jumperopen_C1low_5000Hz.results.Q1.time;
sim_Q1 = sim_HF_jumperopen_C1low_5000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_HF_jumperopen_C1low_1000Hz.results.Q2.time;
sim_Q2 = sim_HF_jumperopen_C1low_1000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#D95319");

t_sim_Q2 = sim_HF_jumperopen_C1low_5000Hz.results.Q2.time;
sim_Q2 = sim_HF_jumperopen_C1low_5000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')

subplot(5,1,4), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')


subplot(5,1,5), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f jumper feeder open without C1low electrolytique

figure(10), hold on
subplot(5,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_jumperopen_noC1low_1000Hz.results.bus_dc.time;
sim_VDC = sim_HF_jumperopen_noC1low_1000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_VDC,'-','LineWidth',1);

t_sim_VDC = sim_HF_jumperopen_noC1low_5000Hz.results.bus_dc.time;
sim_VDC = sim_HF_jumperopen_noC1low_5000Hz.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Exp 1000 Hz - feeder jumper open and no $C_{electrolytique}$','Sim 1000 Hz - feeder jumper open and no $C_{electrolytique}$','Exp 5000 Hz - feeder jumper open and no $C_{electrolytique}$','Sim 5000 Hz - feeder jumper open and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_HF_jumperopen_noC1low_1000Hz.results.Q1.time;
sim_Q1 = sim_HF_jumperopen_noC1low_1000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#D95319");

t_sim_Q1 = sim_HF_jumperopen_noC1low_5000Hz.results.Q1.time;
sim_Q1 = sim_HF_jumperopen_noC1low_5000Hz.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_HF_jumperopen_noC1low_1000Hz.results.Q2.time;
sim_Q2 = sim_HF_jumperopen_noC1low_1000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#D95319");

t_sim_Q2 = sim_HF_jumperopen_noC1low_5000Hz.results.Q2.time;
sim_Q2 = sim_HF_jumperopen_noC1low_5000Hz.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'-','LineWidth',1, "Color","#7E2F8E");

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')

subplot(5,1,4), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')


subplot(5,1,5), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f jumper feeder open with C1low electrolytique

figure(11), hold on

subplot(2,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([0.357, 0.37])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')
legend('Exp 1000 Hz - feeder jumper open and $C_{electrolytique}$','Sim 1000 Hz - feeder jumper open and $C_{electrolytique}$','Exp 5000 Hz - feeder jumper open and $C_{electrolytique}$','Sim 5000 Hz - feeder jumper open and $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(2,1,2), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([0.357, 0.37])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f jumper feeder open without C1low electrolytique

figure(12), hold on

subplot(2,1,1), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.time;
sim_iM = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_iM,'-','LineWidth',1);

t_sim_iM = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.time;
sim_iM = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

xlim([0.357, 0.37])
ylim([-5, 10])
ylabel('$i_M$ [A]','Interpreter','latex')
legend('Exp 1000 Hz - feeder jumper open and no $C_{electrolytique}$','Sim 1000 Hz - feeder jumper open and no $C_{electrolytique}$','Exp 5000 Hz - feeder jumper open and no $C_{electrolytique}$','Sim 5000 Hz - feeder jumper open and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later


subplot(2,1,2), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([0.357, 0.37])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence HF comparison f jumper feeder open with C1low electrolytique

figure(13), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_C1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(1).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_C1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([0.8, 0.82])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')
legend('Exp 1000 Hz - feeder jumper open and $C_{electrolytique}$','Sim 1000 Hz - feeder jumper open and $C_{electrolytique}$','Exp 5000 Hz - feeder jumper open and $C_{electrolytique}$','Sim 5000 Hz - feeder jumper open and $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

%% Plot Sequence HF comparison f jumper feeder open without C1low electrolytique

figure(14), box on, grid on, hold on

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_1000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_noC1low_1000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_5000Hz(2).name);
data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
t_exp = data(:, 1)*1e-3; 
exp_vC = data(:, 2);
exp_VDC = data(:, 3);
exp_iM = data(:, 4);
plot(t_exp,exp_vC,'-','LineWidth',1);

t_sim_vC = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.time;
sim_vC = sim_HF_jumperopen_noC1low_5000Hz.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

xlim([0.8, 0.82])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')
legend('Exp 1000 Hz - feeder jumper open and no $C_{electrolytique}$','Sim 1000 Hz - feeder jumper open and no $C_{electrolytique}$','Exp 5000 Hz - feeder jumper open and no $C_{electrolytique}$','Sim 5000 Hz - feeder jumper open and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

%% Export
addpath('C:\Users\ana\Documents\PhD\Presentations et livrables\Templates_Loic\figure_PP_QUEVAL_20231221\core') % Add figure_PP folder to the path
figure_PP(1,'HF_expsim_compf_feeder_C1low_all.png','width',26.25,'height',12) % Export to .png
figure_PP(2,'HF_expsim_compf_feeder_noC1low_all.png','width',26.25,'height',12) % Export to .png
figure_PP(3,'HF_expsim_compf_nofeeder_avecC1low_all.png','width',26.25,'height',12) % Export to .png
figure_PP(4,'HF_expsim_compf_nofeeder_noC1low_all.png','width',26.25,'height',12) % Export to .png
figure_PP(9,'HF_expsim_compf_jumperopen_avecC1low_all.png','width',26.25,'height',12) % Export to .png
figure_PP(10,'HF_expsim_compf_jumperopen_noC1low_all.png','width',26.25,'height',12) % Export to .png
figure_PP(5,'HF_expsim_compf_feeder_C1low.png','width',26.25,'height',12) % Export to .png
figure_PP(6,'HF_expsim_compf_feeder_noC1low.png','width',26.25,'height',12) % Export to .png
figure_PP(7,'HF_expsim_compf_nofeeder_avecC1low.png','width',26.25,'height',12) % Export to .png
figure_PP(8,'HF_expsim_compf_nofeeder_noC1low.png','width',26.25,'height',12) % Export to .png
figure_PP(13,'HF_expsim_compf_jumperopen_avecC1low_discharge.png','width',26.25,'height',12) % Export to .png
figure_PP(14,'HF_expsim_compf_jumperopen_noC1low_discharge.png','width',26.25,'height',12) % Export to .png
figure_PP(11,'HF_expsim_compf_jumperopen_avecC1low_ONOFF.png','width',26.25,'height',12) % Export to .png
figure_PP(12,'HF_expsim_compf_jumperopen_noC1low_ONOFF.png','width',26.25,'height',12) % Export to .png