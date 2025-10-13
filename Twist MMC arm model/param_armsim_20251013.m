%% Parameters settings
clear all, clc

%% MMC parameters (Bogdan)

% VDC = 150; % [V] DC voltage
% f0 = 50; % [Hz] Electrical frequency
% L_ac = 30e-3; % [H] Arm test inductance
% R_ac = 6; % [Ω] Arm test resistance
% 
% C_m = 2.24e-3; % [F] Module capacitor capacitance
% N=5; % [-] Total number of modules per arm

%% MMC parameters (Twist)

VDC = 150; % [V] DC voltage
f0 = 500; % [Hz] Electrical frequency
L_ac = 30e-3; % [H] Arm test inductance
R_ac = 6; % [Ω] Arm test resistance

C_m = 188.4e-6; % [F] Module capacitor capacitance
N=5; % [-] Total number of modules per arm
Module_diode_Ron = 1e-4;
Module_snubber_R = 1e5;
Module_snubber_C = inf;

%% Modulation parameters in ULabc (simple model)
m = 1; % Modulation for simple model -> Vac = m * VDC/2
a = 1; % Modulation for simple model -> Changes the state of charge of voltage module Vm = a * VDC/2 + m * VDC/2 sin(wt)

%% Parameters SW
Fc=2.5e3; % [Hz] Carriers frequency
Ts = 1e-6; % [s] Simulation time step

t_init_sim = 0; % [s] Simulation start time
sim_time = 1; % [s] Simulation time
f_control = 10e3; % [Hz] Control task frequency
phi = pi/2;
time_charge = 0.2;

%% Parameters PWM and algo tri

isAlgoTriActive = true;
isPWMActive = false;