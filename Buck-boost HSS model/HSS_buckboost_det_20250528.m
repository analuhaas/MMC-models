%% Buck-boost converter detailed HSS model
% Ana HAAS / LE 02/06/2025

%% HSS model: Steady-state
clc,clear all,close all,

%% Parameters

R=3.57; %resistance [ohm]
L=16.968*10^-3;%inductance [H]
C=3.55*10^-3;% capa [F]
Vin=12;%input voltage[V]
Fdec= 100; %took a smal value just to be able to rebuild the signal
N=30; %Nmb of harmonics

alpha=5/17;  %duty cycle
Fnom = 50;   % nominal frequency [Hz] (in case of DC we take a value prop to fdec)
w0 = 2*pi*Fnom;  % angular frequency [rd/sec]
T0 = 1/Fnom;
Ts = 1e-7;

%% Compute Fourier coefficients of the switching functions sw
fft_sw_2N = calculate_fft(alpha,2*N,Fnom); % It returns the dc and the positive harmonics: [sw_{0},sw_{1},sw_{2},sw_{3},sw_{4}]
fft_sw_N = calculate_fft(alpha,N,Fnom); % It returns the dc and the positive harmonics: [sw_{0},sw_{1},sw_{2}]

% Note from MATLAB help: The spectrum in the positive frequencies is the complex conjugate of the spectrum in the negative frequencies
fft_sw_2N = [flip(conj(fft_sw_2N(1,2:end))) fft_sw_2N]; % We add the negative harmonics: [sw_{-4},sw_{-3}sw_{-2},sw_{-1},sw_{0},sw_{1},sw_{2},sw_{3},sw_{4}]
fft_sw_N = [flip(conj(fft_sw_N(1,2:end))) fft_sw_N]; % We add the negative harmonics: [sw_{-2},sw_{-1},sw_{0},sw_{1},sw_{2}]

fft_sw_2N = (conj(fft_sw_2N)); % Put the harmonics in the right place (starts with 2N to -2N ?)
fft_sw_N = (conj(fft_sw_N)); % Put the harmonics in the right place (starts with N to -N ?)

%%  A and B matrices in frequency domain:
%matrix A:
n = 1;
for k = -2*N:2*N
    i = sym(k);
    Sk = fft_sw_2N';
    p = k + 2*N + 1;
    Sk = Sk(int32(p));
    % A(:,:,n) = [0 1/L*(kroneckerDelta(i)-Sk); 1/C*(Sk-kroneckerDelta(i)) -(1/(R*C))*kroneckerDelta(i)];
    A(:,:,n) = [0 1/L*(Delta(0,k)-Sk); 1/C*(Sk-Delta(0,k)) -(1/(R*C))*Delta(0,k)];
    n=n+1;
end

Af = mtoeplitz(A);

%matrix B:
n = 1;
for k = -2*N:2*N
    i = sym(k);
    % B(:,:,n) = [1/L*kroneckerDelta(i);0];
    B(:,:,n) = [1/L*Delta(0,k);0];
    n=n+1;
end

Bf = mtoeplitz(B);

%% Matrix U in frequency domain
u=Vin*fft_sw_N';
Uf=u;

%% Matrix Nt
I = eye(2,2); % 2 = nb of state variables
Nt = [];
for k = -N:N
    Nt = blkdiag(Nt,1i*w0*k*I);
end

%% Steady state calculation with the HSS model
Xss = -inv(Af-Nt)*Bf*Uf; % Solution of the HSS model Y = (-C.(A-N)^-1.B + D)U using that C = eye(n.(2N+1),n.(2N+1)) and D = zeros(n.(2N+1),m.(2N+1)) (n = nb of state variables, m = nb of input variables)

%% Restitution of vectors from Xss
Il = zeros(2*N+1,1);
Vs = zeros(2*N+1,1);
v = [Il,Vs];     % Matrix composed by the Fourier coefficients

for i = 1:size(v,2)
    j = i;
    k = 1;                  % Index to move within each vector Il,Vs
    while j <= (2*N+1)*2
        v(k,i) = Xss(j);
        j = j+2;
        k = k+1;
    end
end

%% Transformation to time domain
t=0:Ts:2*T0; % To see the results in two period 2.T0
for p=1:length(t)
    gamma = [];
    for k = -N:N
        gamma = [gamma, exp(+w0*k*1i*t(p))];
    end
    il_det(p) = gamma*v(:,1); % il(t) = sum_k=-N:N( Il_k . exp(+w0*k*1i*t) )
    vs_det(p) = gamma*v(:,2); % Vs(t) = sum_k=-N:N( Vs_k . exp(+w0*k*1i*t) )
    st(p)=gamma*fft_sw_N'; % s(t) = sum_k=-N:N( S_k . exp(+w0*k*1i*t) )

end

%% Results plot
subplot(3,1,1)
plot(t,st,'LineWidth',2)
legend(num2str([N].','N= %d'));
xlabel('time [s]')
ylabel('s(t) [A]')
%xlim([x_start x_end]);
hold on,grid on, box on

subplot(3,1,2)
p1 = plot(t,il_det,'r');
legend(num2str([N].','N= %d'));
p1.LineWidth = 1.5;
xlabel('time [s]')
ylabel('i_{L} [A]')
%xlim([x_start x_end]);
hold on,grid on, box on

subplot(3,1,3)
p2 = plot(t,vs_det,'g');
legend(num2str([N].','N= %d'));
p2.LineWidth = 1.5;
xlabel('time [s]')
ylabel('v_{s} [V]')
%xlim([x_start x_end]);
hold on,grid on, box on


%% Calculation functions 

function delta_k = Delta(m,n)
if m == n
    delta_k = 1;
else
    delta_k = 0;
end
end

% Toeplitz matrix calculation
function At = mtoeplitz(A)
sz_A = size(A);
nv = sz_A(1);       % number of states = 2 for Buck-Boost
nh = (sz_A(3)-1)/4; % number of harmonics = N
w0 = 2*nh+1;        % position of harmonic 0
w = w0;
At = [];
Al = [];

for n = 0:2*nh
    for k = 0:2*nh
        Al = [Al A(:,:,w)]; % creates the lines of the toeplitz matrix
        w = w - 1;
    end
    At = [At ; Al]; % piles the toeplitz matrix lines together
    Al = [];
    w = w0 + (n+1);
end
end


% PWM and fft
function fft_sw = calculate_fft(alpha,N,f0)
% f0 = Switching frequency 
% N = nb of harmonics
% alpha = duty cycle

T0 = 1/f0;
Ts = 1e-7; % Sampling time
t = 0:Ts:T0;
L = length(t);
fdec=100;

% Switching function calculation using PWM
a=alpha*ones(size(t));
Tdec = 1/fdec;
porteuse = mod(t * 1 / Tdec, 1);
modulante=a;
sw = zeros(size(t));
idx  = find(modulante >= porteuse);
sw(idx)= 1;

% FFT calculation
fft_sw = fft(sw)/L; % Note from MATLAB help: Because the fft function includes a scaling factor L between the original and the transformed signals, rescale Y by dividing by L 
fft_sw = fft_sw(1,1:(N+1)); % Note from MATLAB help: The first half of its spectrum is in positive frequencies and the second half is in negative frequencies
% f = 1/(Ts*L)*(0:(L/2)); % Note from MATLAB help: frequency domain for the positive frequencies
end
