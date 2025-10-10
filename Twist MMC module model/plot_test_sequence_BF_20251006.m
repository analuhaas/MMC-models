%% Picoscope plot
% Ana HAAS / LE 18/09/2025

clear all, close all, clc
%% Parameter definition

sim_LF_ini = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC40V_15Ohms_Basse_Frequence_ini.mat");
sim_LF_feeder_noC1low = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC40V_15Ohms_Basse_Frequence_feeder_sansC1lowelec");
sim_LF_nofeeder_noC1low = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC40V_145Ohms_Basse_Frequence_6Vext_sansC1lowelec.mat");

sim_LF_feeder_noC1low_50V = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC50V_19Ohms_Basse_Frequence_feeder_sansC1lowelec");
sim_LF_feeder_noC1low_60V = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC60V_23Ohms_Basse_Frequence_feeder_sansC1lowelec");
sim_LF_nofeeder_noC1low_50V = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC50V_19Ohms_Basse_Frequence_6Vext_sansC1lowelec");
sim_LF_nofeeder_noC1low_60V = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC60V_23Ohms_Basse_Frequence_6Vext_sansC1lowelec");
sim_LF_nofeeder_noC1low_jumperopen_50V = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC50V_19Ohms_Basse_Frequence_6Vext_sansC1lowelec_jumperopen");
sim_LF_nofeeder_noC1low_jumperopen_60V = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC60V_23Ohms_Basse_Frequence_6Vext_sansC1lowelec_jumperopen");

sim_LF_feeder_noC1low_OFFlong = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC40V_15Ohms_Basse_Frequence_feeder_sansC1lowelec_OFFlong");
sim_LF_nofeeder_noC1low_OFFlong = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC40V_15Ohms_Basse_Frequence_6Vext_sansC1lowelec_OFFlong");

sim_LF_nofeeder_C1low_jumperopen = load("Module simulation\sim_results\20250930\basse_frequence\results_SIM_VDC40V_15Ohms_Basse_Frequence_6Vext_avecC1low_jumperopen");
sim_LF_nofeeder_noC1low_jumperopen = load("Module simulation\sim_results\20250930\basse_frequence\results_SIM_VDC40V_15Ohms_Basse_Frequence_6Vext_sansC1lowelec_jumperopen");
sim_LF_nofeeder_noC1low_jumperopen_RADCexp = load("Module simulation\sim_results\20250930\basse_frequence\results_SIM_VDC40V_15Ohms_Basse_Frequence_6Vext_sansC1lowelec_jumperopen_RADCexp");
sim_LF_nofeeder_noC1low_jumperopen_20251006 = load("Module simulation\sim_results\20251006\basse_frequence\results_SIM_VDC40V_15Ohms_Basse_Frequence_6Vext_sansC1lowelec_jumperopen.mat");

DELIMITER = ';'; HEADERLINES = 3;
csv_directory_B2_20250926 = 'Test_module_20250926/donnes_csv_B2'; % Replace with the name of the directory which contains the CSV files 
csv_directory_B2_20251001 = 'Test_module_20251001/donnes_csv_B2'; % Replace with the name of the directory which contains the CSV files 
csv_directory_B2_20251007 = 'Test_module_20251007/donnes_csv_B2'; % Replace with the name of the directory which contains the CSV files 
csv_directory_B4_20251007 = 'Test_module_20251007/donnes_csv_B4'; % Replace with the name of the directory which contains the CSV files 
csv_directory_B4_jumperopen = 'Test_module_20251002'; % Replace with the name of the directory which contains the CSV files 
csv_directory_B4_20251001 = 'Test_module_20251001/donnes_csv_B4'; % Replace with the name of the directory which contains the CSV files 

csv_files_B2_20251001 = dir(fullfile(csv_directory_B2_20251001, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B4_20251001 = dir(fullfile(csv_directory_B4_20251001, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B4_jumperopen = dir(fullfile(csv_directory_B4_jumperopen, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B2_20251001_LF = csv_files_B2_20251001(contains({csv_files_B2_20251001.name}, ["LF"]));
csv_files_B2_20250926 = dir(fullfile(csv_directory_B2_20250926, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B2_20251007 = dir(fullfile(csv_directory_B2_20251007, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B4_20251007 = dir(fullfile(csv_directory_B4_20251007, '*.csv')); % Lists all CSV files in the specified directory
csv_files_B4_20251007_LF = csv_files_B4_20251007(contains({csv_files_B4_20251007.name}, ["LF"]));

%% Plot Sequence normale with feeder long OFF

figure(1), box on, grid on, hold on

t_sim_vC = sim_LF_feeder_noC1low_OFFlong.results.MMC_M1.time;
sim_vC = sim_LF_feeder_noC1low_OFFlong.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 5
    csv_file_path = fullfile(csv_directory_B2_20251001, csv_files_B2_20251001_LF(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1);  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end
legend('Sim LF - feeder and no $C_{electrolytique}$','Exp LF - feeder and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later
xlim([-0.01, 3])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale exp without feeder long OFF

figure(2), box on, grid on, hold on

t_sim_vC = sim_LF_nofeeder_noC1low_OFFlong.results.MMC_M1.time;
sim_vC = sim_LF_nofeeder_noC1low_OFFlong.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 6
    csv_file_path = fullfile(csv_directory_B2_20251001, csv_files_B2_20251001_LF(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1);  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end
legend('Sim LF - 6 V ext and no $C_{electrolytique}$','Exp LF - 6 V ext and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later
xlim([-0.01, 3])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale with feeder 50 V and 60 V

figure(3), box on, grid on, hold on

t_sim_vC = sim_LF_feeder_noC1low_50V.results.MMC_M1.time;
sim_vC = sim_LF_feeder_noC1low_50V.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 3
    csv_file_path = fullfile(csv_directory_B2_20251001, csv_files_B2_20251001_LF(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end

t_sim_vC = sim_LF_feeder_noC1low_60V.results.MMC_M1.time;
sim_vC = sim_LF_feeder_noC1low_60V.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 3
    csv_file_path = fullfile(csv_directory_B2_20251007, csv_files_B2_20251007(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end
legend('Sim LF 50 V - feeder and no $C_{electrolytique}$','Exp LF 50 V - feeder and no $C_{electrolytique}$','Sim LF 60 V - feeder and no $C_{electrolytique}$','Exp LF 60 V - feeder and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later
xlim([-0.01, 0.95])
ylim([0, 30])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale with feeder jumper open B4

figure(4), box on, grid on, hold on

t_sim_vC = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.MMC_M1.time;
sim_vC = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 2
    csv_file_path = fullfile(csv_directory_B4_jumperopen, csv_files_B4_jumperopen(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end
legend('Sim LF - with feeder jumper open','Exp LF - with feeder jumper open','Interpreter','latex'), legend boxon % R2018b and later
xlim([-0.01, 1])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale with feeder without C1low B4

figure(5), hold on
subplot(5,1,1), box on, grid on, hold on

t_sim_VDC = sim_LF_feeder_noC1low.results.bus_dc.time;
sim_VDC = sim_LF_feeder_noC1low.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

for i = 3
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_VDC,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Sim LF - with feeder and no $C_{electrolytique}$','Exp LF - with feeder and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_LF_feeder_noC1low.results.Q1.time;
sim_Q1 = sim_LF_feeder_noC1low.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'r','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_LF_feeder_noC1low.results.Q2.time;
sim_Q2 = sim_LF_feeder_noC1low.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'g','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')


subplot(5,1,4), box on, grid on, hold on

t_sim_iM = sim_LF_feeder_noC1low.results.MMC_M1.time;
sim_iM = sim_LF_feeder_noC1low.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

for i = 3
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_iM,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([-2, 5])
ylabel('$i_M$ [A]','Interpreter','latex')

subplot(5,1,5), box on, grid on, hold on

t_sim_vC = sim_LF_feeder_noC1low.results.MMC_M1.time;
sim_vC = sim_LF_feeder_noC1low.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 3
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')


%% Plot Sequence normale 6V ext without C1low B4

figure(6), hold on
subplot(5,1,1), box on, grid on, hold on

t_sim_VDC = sim_LF_nofeeder_noC1low.results.bus_dc.time;
sim_VDC = sim_LF_nofeeder_noC1low.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

for i = 4
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_VDC,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Sim LF - with feeder and no $C_{electrolytique}$','Exp LF - with feeder and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_LF_nofeeder_noC1low.results.Q1.time;
sim_Q1 = sim_LF_nofeeder_noC1low.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'r','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_LF_nofeeder_noC1low.results.Q2.time;
sim_Q2 = sim_LF_nofeeder_noC1low.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'g','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')


subplot(5,1,4), box on, grid on, hold on

t_sim_iM = sim_LF_nofeeder_noC1low.results.MMC_M1.time;
sim_iM = sim_LF_nofeeder_noC1low.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

for i = 4
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_iM,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([-2, 5])
ylabel('$i_M$ [A]','Interpreter','latex')

subplot(5,1,5), box on, grid on, hold on

t_sim_vC = sim_LF_nofeeder_noC1low.results.MMC_M1.time;
sim_vC = sim_LF_nofeeder_noC1low.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 4
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale 6V ext without C1low with open jumper B4

figure(7), hold on
subplot(5,1,1), box on, grid on, hold on

t_sim_VDC = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.bus_dc.time;
sim_VDC = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

for i = 2
    csv_file_path = fullfile(csv_directory_B4_jumperopen, csv_files_B4_jumperopen(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_VDC,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Sim LF - with feeder jumper open','Exp LF - with feeder jumper open','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.Q1.time;
sim_Q1 = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'r','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.Q2.time;
sim_Q2 = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'g','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')


subplot(5,1,4), box on, grid on, hold on

t_sim_iM = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.MMC_M1.time;
sim_iM = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

for i = 2
    csv_file_path = fullfile(csv_directory_B4_jumperopen, csv_files_B4_jumperopen(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_iM,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([-2, 5])
ylabel('$i_M$ [A]','Interpreter','latex')

subplot(5,1,5), box on, grid on, hold on

t_sim_vC = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.MMC_M1.time;
sim_vC = sim_LF_nofeeder_noC1low_jumperopen_20251006.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 2
    csv_file_path = fullfile(csv_directory_B4_jumperopen, csv_files_B4_jumperopen(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale with 6 V external 50 V and 60 V

figure(8), box on, grid on, hold on

t_sim_vC = sim_LF_nofeeder_noC1low_50V.results.MMC_M1.time;
sim_vC = sim_LF_nofeeder_noC1low_50V.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 4
    csv_file_path = fullfile(csv_directory_B2_20251001, csv_files_B2_20251001_LF(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end

t_sim_vC = sim_LF_nofeeder_noC1low_60V.results.MMC_M1.time;
sim_vC = sim_LF_nofeeder_noC1low_60V.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 4
    csv_file_path = fullfile(csv_directory_B2_20251007, csv_files_B2_20251007(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end
legend('Sim LF 50 V - 6 V ext and no $C_{electrolytique}$','Exp LF 50 V - 6 V ext and no $C_{electrolytique}$','Sim LF 60 V - 6 V ext and no $C_{electrolytique}$','Exp LF 60 V - 6 V ext and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later
xlim([-0.01, 0.95])
ylim([0, 30])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale with feeder jumper open 50 V and 60 V

figure(9), box on, grid on, hold on

t_sim_vC = sim_LF_nofeeder_noC1low_jumperopen_50V.results.MMC_M1.time;
sim_vC = sim_LF_nofeeder_noC1low_jumperopen_50V.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 2
    csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_LF(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end

t_sim_vC = sim_LF_nofeeder_noC1low_jumperopen_60V.results.MMC_M1.time;
sim_vC = sim_LF_nofeeder_noC1low_jumperopen_60V.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 4
    csv_file_path = fullfile(csv_directory_B4_20251007, csv_files_B4_20251007_LF(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end
legend('Sim LF 50 V - 6 V ext and no $C_{electrolytique}$','Exp LF 50 V - 6 V ext and no $C_{electrolytique}$','Sim LF 60 V - 6 V ext and no $C_{electrolytique}$','Exp LF 60 V - 6 V ext and no $C_{electrolytique}$','Interpreter','latex'), legend boxon % R2018b and later
xlim([-0.01, 0.95])
ylim([0, 30])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale with feeder with C1low B4 - Simulation initiale

figure(10), hold on
subplot(5,1,1), box on, grid on, hold on

t_sim_VDC = sim_LF_ini.results.bus_dc.time;
sim_VDC = sim_LF_ini.results.bus_dc.signals.values(:,3);

plot(t_sim_VDC,sim_VDC,'--','LineWidth',1);

for i = 1
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_VDC,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([0, 50])
ylabel('$V_{DC}$ [V]','Interpreter','latex')
legend('Initial Sim LF','Exp LF','Interpreter','latex'), legend boxon % R2018b and later

subplot(5,1,2), box on, grid on, hold on

t_sim_Q1 = sim_LF_ini.results.Q1.time;
sim_Q1 = sim_LF_ini.results.Q1.signals.values(:,1);

plot(t_sim_Q1,sim_Q1,'r','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q1}$ [-]','Interpreter','latex')

subplot(5,1,3), box on, grid on, hold on

t_sim_Q2 = sim_LF_ini.results.Q2.time;
sim_Q2 = sim_LF_ini.results.Q2.signals.values(:,1);

plot(t_sim_Q2,sim_Q2,'g','LineWidth',1);

xlim([-0.01, 0.95])
ylim([0, 1.2])
ylabel('$sw_{Q2}$ [-]','Interpreter','latex')


subplot(5,1,4), box on, grid on, hold on

t_sim_iM = sim_LF_ini.results.MMC_M1.time;
sim_iM = sim_LF_ini.results.MMC_M1.signals.values(:,1);

plot(t_sim_iM,sim_iM,'--','LineWidth',1);

for i = 1
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_iM,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([-2, 5])
ylabel('$i_M$ [A]','Interpreter','latex')

subplot(5,1,5), box on, grid on, hold on

t_sim_vC = sim_LF_ini.results.MMC_M1.time;
sim_vC = sim_LF_ini.results.MMC_M1.signals.values(:,2);

plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 1
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1);
end

xlim([-0.01, 0.95])
ylim([0, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')

%% Plot Sequence normale with feeder with C1low B4 - Feeder behavior at rising

figure(11), box on, grid on, hold on

% t_sim_vC = sim_LF_ini.results.MMC_M1.time;
% sim_vC = sim_LF_ini.results.MMC_M1.signals.values(:,2);
% 
% plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 1
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1,'Color','#D95319');
end

xlim([0.04, 0.07])
ylim([8, 11])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')
legend('Exp LF - feeder behavior at rising','Interpreter','latex'), legend boxon % R2018b and later

%% Plot Sequence normale with feeder with C1low B4 - Feeder behavior at falling

figure(12), box on, grid on, hold on

% t_sim_vC = sim_LF_ini.results.MMC_M1.time;
% sim_vC = sim_LF_ini.results.MMC_M1.signals.values(:,2);
% 
% plot(t_sim_vC,sim_vC,'--','LineWidth',1);

for i = 1
    csv_file_path = fullfile(csv_directory_B4_20251001, csv_files_B4_20251001(i).name);
    data = readmatrix(csv_file_path,"Delimiter",DELIMITER,"NumHeaderLines",HEADERLINES,"DecimalSeparator",",");
    t_exp = data(:, 1)*1e-3;  
    exp_vC = data(:, 2);
    exp_VDC = data(:, 3);
    exp_iM = data(:, 4);
    plot(t_exp,exp_vC,'-','LineWidth',1,'Color','#D95319');
end

xlim([0.24, 0.255])
ylim([8, 20])
xlabel('$time$ [s]','Interpreter','latex')
ylabel('$v_C$ [V]','Interpreter','latex')
legend('Exp LF - feeder behavior at falling','Interpreter','latex'), legend boxon % R2018b and later

%% Export
addpath('C:\Users\ana\Documents\PhD\Presentations et livrables\Templates_Loic\figure_PP_QUEVAL_20231221\core') % Add figure_PP folder to the path

figure_PP(1,'LF_expsim_feeder_noC1low_OFFlong_vC.png','width',26.25,'height',12) % Export to .png
figure_PP(2,'LF_expsim_nofeeder_noC1low_OFFlong_vC.png','width',26.25,'height',12) % Export to .png
figure_PP(3,'LF_expsim_50V_60V_feeder_noC1low_vC.png','width',26.25,'height',12) % Export to .png
figure_PP(4,'LF_expsim_jumperopen_noC1low_vC.png','width',26.25,'height',12) % Export to .png
figure_PP(5,'LF_expsim_feeder_noC1low.png','width',26.25,'height',12) % Export to .png
figure_PP(6,'LF_expsim_nofeeder_noC1low.png','width',26.25,'height',12) % Export to .png
figure_PP(7,'LF_expsim_jumperopen_noC1low.png','width',26.25,'height',12) % Export to .png
figure_PP(8,'LF_expsim_50V_60V_nofeeder_noC1low.png','width',26.25,'height',12) % Export to .png
figure_PP(9,'LF_expsim_50V_60V_jumperopen_noC1low.png','width',26.25,'height',12) % Export to .png
figure_PP(10,'LF_expsim_feeder_C1low_initial.png','width',26.25,'height',12) % Export to .png
figure_PP(11,'LF_expsim_feeder_C1low_initial_risingfeeder.png','width',8.75,'height',6) % Export to .png
figure_PP(12,'LF_expsim_feeder_C1low_initial_fallingfeeder.png','width',8.75,'height',6) % Export to .png
