%% Clean everything
clear all; clc; 
% close all;

%% Sequence and Twist configuration

data_save = true; % true : save in a .mat file the following data : duty / VHigh / V1Low / V2Low / IHigh / I1Low / I2Low
power_losses = false; % true : takes into account power losses from the MOSFETs / false : no power losses
isInterleaved = false; % true : 180° phase shift between leg 1 and leg 2 / false : 0° phase shift
isHighFrequencyTest = false; % true : tests module in high frequency, false : tests module with normal sequence
isC1low1Active = true;
isC2low1Active = false;
is6VExternallySupplied = false;
isFeederJumperOpen = false;
C1low_variable = false;

% Normal sequence = (VDC ON) BLOCK -> ON -> OFF -> (VDC OFF) OFF -> BLOCK -> ON
% High frequency = (VDC ON) BLOCK -> ON/OFF in HF -> (VDC OFF) ON/OFF in HF -> BLOCK

% Initialize times and frequencies
twist_freq_data_sampling = 20e3; %data sampling frequency
twist_data_sampling_period = 1/twist_freq_data_sampling; %data sampling delay
twist_data_acquisition_delay = 50e-9; %data acquisition at the peak of the carry

%% Simulation configuration

% latest_sim_name = 'MMC_1module_twist_20250910.slx'; %Version without modifications
latest_sim_name = 'MMC_1module_twist_20251006.slx'; %Version with modifications: Power supply characteristics, Feeder, Feeder threshold

latest_MMC_parameters = "MMC_parameters.m";
latest_twist_parameters = "twist_parameters.m";
% latest_twist_parameters = "twist_parameters_before.m";

sim_time_BF = 1; %overall simulation time
sim_time_HF = 1; %overall simulation time
t_init_sim = -0.01; % [s] Simulation start time
Ts = 1e-6; % [s] Simulation sample period

%Sequence variables - LF sequence
if(isHighFrequencyTest == false) % Low Frequency test
    if(is6VExternallySupplied == false)
        if(isC1low1Active == true)
            Vdc_off_time = 0.493785; %[s] time where VDC = 0V
            % Vdc_off_time = 0.590685; %[s] time where VDC = 0V
            Vdc_on_time = -0.002445; %[s] time where VDC = 40V
            expdelay = 0.04406;
        else % Electrolytic C1low disconnected
            % Vdc_off_time = 0.493865; %[s] time where VDC = 0V
            Vdc_off_time = 0.59134; %[s] time where VDC = 0V
            Vdc_on_time = -0.002445; %[s] time where VDC = 40V
            expdelay = 0.045615;
        end
    else % 6 V supplied externally
        if(isFeederJumperOpen == true)
            if(isC1low1Active == true)
                Vdc_off_time = 0.4921; %[s] time where VDC = 0V
                Vdc_on_time = -0.00289; %[s] time where VDC = 40V
                expdelay = 0.0086001;
            else % Electrolytic C1low disconnected
                Vdc_off_time = 0.4897; %[s] time where VDC = 0V
                Vdc_on_time = -0.002316; %[s] time where VDC = 40V
                expdelay = 0.008081;
            end
        else % Feeder jumper closed
            if(isC1low1Active == true)
                Vdc_off_time = 0.493865; %[s] time where VDC = 0V
                Vdc_on_time = -0.002445; %[s] time where VDC = 40V
                expdelay = 0.007225;
            else % Electrolytic C1low disconnected
                % Vdc_off_time = 0.49369; %[s] time where VDC = 0V
                Vdc_off_time = 0.590785; %[s] time where VDC = 0V
                Vdc_on_time = -0.002445; %[s] time where VDC = 40V
                expdelay = 0.00807;
            end
        end
    end
end
%Sequence variables - HF sequence
f_HF_test = 1000; % [Hz] Switching frequency for high frequency test
f_HF_tab = [1000,5000]; % [Hz] Multiple switching frequencies tested in HF sequence
C_HF_tab = [100]; % [Hz] Multiple switching frequencies tested in HF sequence
%% Adaptation parameters

%Power supply model
power_supply_rC_up = 0.1;
power_supply_rC_down = 7.016e-2;
power_supply_C = 62.71e-2;

%% Setup depending on user configuration

if(~isHighFrequencyTest)
    loop_sim_f = 1;
    sim_time = sim_time_BF;
    loop_sim_C = 1;
else
    if(C1low_variable)
        loop_sim_C = length(C_HF_tab);
    else
        loop_sim_C = 1;
    end
    loop_sim_f = length(f_HF_tab);
    sim_time = sim_time_HF;
end

if(~isInterleaved)
    twist_phase_shift_leg_2_deg = 0; %no phase shift
else
    twist_phase_shift_leg_2_deg = 180; %interleaved phase shift
end

if(~isC1low1Active)
    C1low1_active = 0;
else
    C1low1_active = 1;
end

if(~isC2low1Active)
    C2low1_active = 0;
else
    C2low1_active = 1;
end

%% Initialize MMC parameters

run(latest_MMC_parameters);
%% Initialize twist parameters

run(latest_twist_parameters);
% source_V = twist_USB_voltage;  %source voltage [V] - inicial module capacitor voltage
source_V = 0;  %source voltage [V] - inicial module capacitor voltage
twist_high_side_adc_R,

if(is6VExternallySupplied == false)
    feeder_current_lower_rate_limit = -300;
else
    feeder_current_lower_rate_limit = -10;

end
%% Start simulink simulation

tic

open(latest_sim_name);

for f_index=1:loop_sim_f
    for C_index=1:loop_sim_C
        if(isHighFrequencyTest == true)
            f_HF_test = f_HF_tab(f_index);
            if(is6VExternallySupplied == false)

                    if(isC1low1Active == true)
                        if(f_HF_test == 1000)
                            Vdc_off_time = 0.4899; %[s] time where VDC = 0V
                            Vdc_on_time = -0.002385; %[s] time where VDC = 40V
                            expdelay = 0.04549;
                        elseif(f_HF_test == 5000)
                            Vdc_off_time = 0.44206; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.043425;
                        else
                            Vdc_off_time = 0.44206; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.043425;
                        end
                    else % Electrolytic C1low disconnected
                        if(f_HF_test == 1000)
                            Vdc_off_time = 0.4886; %[s] time where VDC = 0V
                            Vdc_on_time = -0.00236; %[s] time where VDC = 40V
                            expdelay = 0.04632;
                        elseif(f_HF_test == 5000)
                            Vdc_off_time = 0.4887; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.045896;
                        else
                            Vdc_off_time = 0.4887; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.045896;
                        end
                    end

            else % 6 V supplied externally
                if(isFeederJumperOpen == true)
                    if(isC1low1Active == true)
                        if(f_HF_test == 1000)
                            Vdc_off_time = 0.48965; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0025; %[s] time where VDC = 40V
                            expdelay = 0.01079;
                        elseif(f_HF_test == 5000)
                            Vdc_off_time = 0.4912; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.00886;
                        else
                            Vdc_off_time = 0.4912; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.008089;
                        end
                    else % Electrolytic C1low disconnected
                        if(f_HF_test == 1000)
                            Vdc_off_time = 0.4926; %[s] time where VDC = 0V
                            Vdc_on_time = -0.002385; %[s] time where VDC = 40V
                            expdelay = 0.009405;
                        elseif(f_HF_test == 5000)
                            Vdc_off_time = 0.4912; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.00879;
                        else
                            Vdc_off_time = 0.4912; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.0080879;
                        end
                    end
                else
                    if(isC1low1Active == true)
                        if(f_HF_test == 1000)
                            Vdc_off_time = 0.4426; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0025; %[s] time where VDC = 40V
                            expdelay = 0.008285;
                        elseif(f_HF_test == 5000)
                            Vdc_off_time = 0.4912; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.007605;
                        else
                            Vdc_off_time = 0.4912; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.007605;
                        end
                    else % Electrolytic C1low disconnected
                        if(f_HF_test == 1000)
                            Vdc_off_time = 0.4926; %[s] time where VDC = 0V
                            Vdc_on_time = -0.002385; %[s] time where VDC = 40V
                            expdelay = 0.008165;
                        elseif(f_HF_test == 5000)
                            Vdc_off_time = 0.4912; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.00798;
                        else
                            Vdc_off_time = 0.4912; %[s] time where VDC = 0V
                            Vdc_on_time = -0.0024; %[s] time where VDC = 40V
                            expdelay = 0.00798;
                        end
                    end
                end
                
            end
    
            sim(latest_sim_name);
    
            if(data_save == true)
                % Data output save
                results = ans;
                VDC_name = string(VDC);
                if(is6VExternallySupplied == false)
                    if(isC1low1Active == true)
                        save('sim_results/20251006/haute_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Haute_Frequence'+round(f_HF_test)+'Hz_feeder_avecC1low','results');
                    else
                        save('sim_results/20251006/haute_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Haute_Frequence'+round(f_HF_test)+'Hz_feeder_sansC1lowelec','results');
                    end
                else
                    if(isFeederJumperOpen == true)
                        if(isC1low1Active == true)
                            save('sim_results/20251006/haute_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Haute_Frequence'+round(f_HF_test)+'Hz_6Vext_avecC1low_jumperopen','results');
                        else
                            save('sim_results/20251006/haute_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Haute_Frequence'+round(f_HF_test)+'Hz_6Vext_sansC1lowelec_jumperopen','results');
                        end
                    else
                        if(isC1low1Active == true)
                            save('sim_results/20251006/haute_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Haute_Frequence'+round(f_HF_test)+'Hz_6Vext_avecC1low','results');
                        else
                            save('sim_results/20251006/haute_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Haute_Frequence'+round(f_HF_test)+'Hz_6Vext_sansC1lowelec','results');
                        end
                    end
                    
                end
            end
        else
            sim(latest_sim_name);
            if(data_save == true)
            % Data output save
            results = ans;
            VDC_name = string(VDC);
                if(is6VExternallySupplied == false)
                    if(isC1low1Active == true)
                        save('sim_results/20251006/basse_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Basse_Frequence_feeder_avecC1low','results');
                        % save('sim_results/20251006/basse_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Basse_Frequence_ini','results');
                    else
                        save('sim_results/20251006/basse_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Basse_Frequence_feeder_sansC1lowelec','results');
                    end
                else
                    if(isFeederJumperOpen == true)
                        if(isC1low1Active == true)
                            save('sim_results/20251006/basse_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Basse_Frequence_6Vext_avecC1low_jumperopen','results');
                        else
                            save('sim_results/20251006/basse_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Basse_Frequence_6Vext_sansC1lowelec_jumperopen','results');
                        end
                    else
                        if(isC1low1Active == true)
                            save('sim_results/20251006/basse_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Basse_Frequence_6Vext_avecC1low','results');
                        else
                            save('sim_results/20251006/basse_frequence/results_SIM_VDC'+VDC_name+'V_'+Rdec+'Ohms_Basse_Frequence_6Vext_sansC1lowelec','results');
                        end
                    end

                end
            end
        end
    end
end

toc


