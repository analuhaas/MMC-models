%% Parameters settings
clear all, clc

%% MMC parameters
R_arm = 1e-2; % [Ω] Arm resistance
L_arm = 1e-3; % [H] Arm inductance

Ceq = 3e-3; % [F] Equivalent capacitor capacitance
N=6; % [-] Total number of modules per arm

%% External parameters 
f0 = 50; % [Hz] Electrical frequency
L_ac = 100e-6; % [H] Motor inductance
R_ac = 1; % [Ω] Motor resistance

R = 1e-6; % [Ω] DC cables resistance (simple model only)

VDC = 800; % [V] DC voltage
%% Modulation parameters in ΔΣdq0 (AVM et SW)
m_Delta_0_n = 0;
m_Sigma_0_n = 1;

M_Delta = 1;
Phi_Delta = 0;
M_Sigma = 0;
Phi_Sigma = 0;

%% Modulation parameters in ULabc (simple model)
m = 1; % Modulation for simple model -> Vac = m * VDC/2
a = 1; % Modulation for simple model -> Changes the state of charge of voltage module Vm = a * VDC/2 + m * VDC/2 sin(wt)

%% Modulation computations in ΔΣdq0 (AVM et SW)
m_Delta_d = M_Delta*sin(Phi_Delta);
m_Delta_q = -M_Delta*cos(Phi_Delta);
m_Delta_0 = m_Delta_0_n;

m_Sigma_d =  M_Sigma*sin(Phi_Sigma);
m_Sigma_q =  -M_Sigma*cos(Phi_Sigma);
m_Sigma_0 = m_Sigma_0_n;

%% Parameters SW
Fc=1e3; % [Hz] Carriers frequency