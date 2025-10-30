% Phase 3: Averaging, operating-point solve, linearization, and loop plants
% **9TH-ORDER SYSTEM**
% Requires: run build_per_topology_matrices_9th_order.m first
%
% State vector: x = [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vC0]'

clear; clc;

% --- 0) Load per-topology symbolic matrices ---
run('build_per_topology_matrices_9th_order.m');  
% Defines: A11, A10, A00, A01, B_in_11, B_in_10, B_in_00, B_in_01 (9×9 and 9×1)

% --- 1) Define numeric parameters ---
params = struct( ...
  'L1', 1200e-6,  'L2', 1200e-6,  'L3', 1200e-6,  'L4', 1200e-6, ...
  'L5', 1.2,      'L6', 1.2, ...      % Output inductors (1000× larger!)
  'C12', 1e-6,    'C34', 1e-6, ...    % C1||C2 and C3||C4
  'C0', 500e-6);                       % Output capacitor

% Define symbolic variables for substitution
syms L1 L2 L3 L4 L5 L6 C12 C34 C0

symVars = [L1 L2 L3 L4 L5 L6 C12 C34 C0];
symVals = [params.L1 params.L2 params.L3 params.L4 params.L5 params.L6 ...
           params.C12 params.C34 params.C0];

% Substitute numerical values
A11n     = double(subs(A11,     symVars, symVals));
A10n     = double(subs(A10,     symVars, symVals));
A00n     = double(subs(A00,     symVars, symVals));
A01n     = double(subs(A01,     symVars, symVals));
B_in_11n = double(subs(B_in_11, symVars, symVals));
B_in_10n = double(subs(B_in_10, symVars, symVals));
B_in_00n = double(subs(B_in_00, symVars, symVals));
B_in_01n = double(subs(B_in_01, symVars, symVals));

disp('✅ Matrices converted to numeric (9×9)');

% --- 2) Choose frozen operating point and weights ---
s     = +1;                 % half-cycle sign (positive)
Vin0  = 170;                % frozen input voltage [V] (peak, not RMS)
P0    = 1500;               % load power [W]
d1    = 0.35;               % phase-A duty cycle
d2    = 0.35;               % phase-B duty cycle

% Weights (piecewise formulation)
w11 = max(0, d1 + d2 - 1);  % Overlap
w00 = max(0, 1 - d1 - d2);  % Gap
w10 = d1 - w11;              % S1 only
w01 = d2 - w11;              % S2 only

% Verify weights sum to 1
weight_sum = w11 + w10 + w01 + w00;
fprintf('Weight verification: w11+w10+w01+w00 = %.6f ✅\n', weight_sum);

% Averaged matrices (A independent of s; B_in gets s)
Aavg   = w11*A11n + w10*A10n + w01*A01n + w00*A00n;
Binavg = s*(w11*B_in_11n + w10*B_in_10n + w01*B_in_01n + w00*B_in_00n);

disp('✅ Averaged matrices computed');

% --- 3) Solve DC operating point x0 from xdot = 0 with CPL load ---
n = 9;  % System order
C0 = params.C0;

% State: x = [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vC0]'
% CPL term appears in row 9 (vC0 equation): -P/(C0·vC0)

% Nonlinear equation: 0 = Aavg*x + Binavg*Vin + [0; 0; 0; 0; 0; 0; 0; 0; -P/(C0·vC0)]
f = @(x) Aavg*x + Binavg*Vin0 + [zeros(n-1,1); -(P0/max(x(9),1e-6))/C0];

% Initial guess
x0 = [zeros(8,1); 380];  % All currents ~0, vC0 ~ 380V

if exist('fsolve','file')
  opts = optimoptions('fsolve','Display','iter','FunctionTolerance',1e-12,'StepTolerance',1e-12);
  x0 = fsolve(f, x0, opts);
else
  warning('fsolve not available - using initial guess as operating point');
end

% Extract operating point values
iL1_0 = x0(1);
iL2_0 = x0(2);
iL3_0 = x0(3);
iL4_0 = x0(4);
iL5_0 = x0(5);
iL6_0 = x0(6);
vC12_0 = x0(7);
vC34_0 = x0(8);
vC0_0 = x0(9);

fprintf('\n--- Operating Point (9th-Order) ---\n');
fprintf('iL1  = %.4f A\n', iL1_0);
fprintf('iL2  = %.4f A\n', iL2_0);
fprintf('iL3  = %.4f A\n', iL3_0);
fprintf('iL4  = %.4f A\n', iL4_0);
fprintf('iL5  = %.4f A ← Output inductor\n', iL5_0);
fprintf('iL6  = %.4f A ← Output inductor\n', iL6_0);
fprintf('vC12 = %.2f V\n', vC12_0);
fprintf('vC34 = %.2f V\n', vC34_0);
fprintf('vC0  = %.2f V (DC bus)\n', vC0_0);
fprintf('Vin  = %.2f V\n', Vin0);
fprintf('P    = %.2f W\n', P0);
fprintf('d1   = %.3f\n', d1);
fprintf('d2   = %.3f\n', d2);

% --- 4) Linearize: A_linear, B_in, B_d, B_P ---
A_linear = Aavg;
A_linear(9,9) = A_linear(9,9) + P0/(C0*vC0_0^2);  % CPL Jacobian correction

B_in = Binavg;

B_P = zeros(n,1);
B_P(9) = -1/(C0*vC0_0);  % Power disturbance input

disp('✅ Linearization complete with CPL Jacobian');

% Build g_k at operating point (for B_d calculation)
g11 = A11n*x0 + s*B_in_11n*Vin0;
g10 = A10n*x0 + s*B_in_10n*Vin0;
g01 = A01n*x0 + s*B_in_01n*Vin0;
g00 = A00n*x0 + s*B_in_00n*Vin0;

% Duty partials (piecewise; avoid discontinuity at d1+d2==1)
sumd = d1 + d2;
if abs(sumd - 1) < 1e-9
  sumd = sumd + 1e-6;  % Nudge away from boundary
end

if sumd < 1
  % Region: w11=0, w00>0, w10=d1, w01=d2
  dw = struct('w11_d1',0,'w11_d2',0,'w00_d1',-1,'w00_d2',-1, ...
              'w10_d1',1,'w10_d2',0,'w01_d1',0,'w01_d2',1);
else
  % Region: w00=0, w11>0, w10=1-d2, w01=1-d1
  dw = struct('w11_d1',1,'w11_d2',1,'w00_d1',0,'w00_d2',0, ...
              'w10_d1',0,'w10_d2',-1,'w01_d1',-1,'w01_d2',0);
end

% Control input matrix B_d (9×2)
Bd1 = dw.w11_d1*g11 + dw.w10_d1*g10 + dw.w01_d1*g01 + dw.w00_d1*g00;
Bd2 = dw.w11_d2*g11 + dw.w10_d2*g10 + dw.w01_d2*g01 + dw.w00_d2*g00;
B_d = [Bd1 Bd2];

fprintf('B_d size: %d×%d ✅\n', size(B_d, 1), size(B_d, 2));

% --- 5) Build loop plants (duty→current/voltage) ---
% Output measurement matrices
C_i = s * [1 0 0 1 0 0 0 0 0];  % Input current: y_i = s*(iL1 + iL4) 
                                  % Or could use iL1+iL2+iL3+iL4 for total input
C_v = [0 0 0 0 0 0 0 0 1];       % Bus voltage: y_v = vC0

H_i = 1;     % current sense gain
H_v = 1;     % voltage sense gain
K_pwm = 1;   % PWM gain

% State-space system: ẋ = A·x + [B_d B_in B_P]·[d̃; Ṽin; P̃]
%                     y = C·x
Gss = ss(A_linear, [B_d B_in B_P], [C_i; C_v], zeros(2, 2+1+1));

% Symmetric-duty plants (sum columns 1 and 2 for d1=d2 operation)
G_id_d = H_i * (Gss(1,1) + Gss(1,2)) * K_pwm;  % duty → input current
G_vd_d = H_v * (Gss(2,1) + Gss(2,2)) * K_pwm;  % duty → bus voltage

disp('✅ Transfer functions extracted');

% Report
fprintf('\n--- Transfer Function Summary ---\n');
fprintf('G_id_d: Duty → Input Current (order %d)\n', order(G_id_d));
fprintf('G_vd_d: Duty → Bus Voltage (order %d)\n', order(G_vd_d));

% Check eigenvalues
eigs_A = eig(A_linear);
fprintf('\n--- Stability Analysis ---\n');
fprintf('Number of states: %d\n', n);
fprintf('Number of eigenvalues: %d\n', length(eigs_A));
if all(real(eigs_A) < 0)
  fprintf('✅ All poles in left-half plane (stable)\n');
else
  fprintf('⚠️  Some poles have positive real part (unstable or marginally stable)\n');
  fprintf('   Check CPL effect and operating point\n');
end

%% --- 6) PI tuning helpers (inner loop + optional outer) ---
fs   = 50e3;           % switching frequency [Hz]
fc_i = 3e3;            % desired inner current-loop crossover [Hz]
zfac_i = 5;            % place PI zero at fc_i/zfac_i

wc_i = 2*pi*fc_i;

% Get magnitude of G_id_d at jω = wc_i
try
  mag_id = abs(freqresp(G_id_d, wc_i));
catch
  [magv,~] = bode(G_id_d, wc_i);
  mag_id = magv(:).'; mag_id = mag_id(1);
end

Kp_i = 1/max(mag_id, eps);
wz_i = wc_i / zfac_i;
Ki_i = Kp_i * wz_i;

Ci = tf([Kp_i Ki_i],[1 0]);  % PI_i(s) = Kp_i + Ki_i/s
Li = Ci * G_id_d;             % open-loop inner current loop

fprintf('\n--- Inner Current Loop (fc = %.0f Hz) ---\n', fc_i);
fprintf('Kp_i = %.6f\n', Kp_i);
fprintf('Ki_i = %.6f\n', Ki_i);

% --- Outer voltage loop ---
fc_v = 15;             % desired outer voltage-loop crossover [Hz]
zfac_v = 5;
wv = 2*pi*fc_v;

try
  mag_v = abs(freqresp(G_vd_d, wv));
catch
  [magv2,~] = bode(G_vd_d, wv);
  mag_v = magv2(:).'; mag_v = mag_v(1);
end

Kp_v = 1/max(mag_v, eps);
wz_v = wv / zfac_v;
Ki_v = Kp_v * wz_v;

Cv = tf([Kp_v Ki_v],[1 0]);  % PI_v(s)
Lv = Cv * G_vd_d;             % open-loop outer voltage loop

fprintf('\n--- Outer Voltage Loop (fc = %.0f Hz) ---\n', fc_v);
fprintf('Kp_v = %.6f\n', Kp_v);
fprintf('Ki_v = %.6f\n', Ki_v);

% Bandwidth separation check
bw_ratio = fc_i / fc_v;
fprintf('\nBandwidth separation: %.1f× ✅\n', bw_ratio);
if bw_ratio >= 10
  fprintf('✅ Adequate separation for cascaded control\n');
else
  fprintf('⚠️  Consider increasing inner loop bandwidth\n');
end

% Optional: Add roll-off to outer loop
rollfac_v = 10;
wp_roll = 2*pi*fc_v*rollfac_v;
Cf_roll = 1 / tf([1/wp_roll 1], 1);
Cv_roll = Cv * Cf_roll;
Lv_roll = Cv_roll * G_vd_d;

fprintf('\n✅ 9TH-ORDER ANALYSIS COMPLETE\n');
fprintf('   All matrices, operating point, linearization, and control design ready\n');

%% Optional: Plot Bode diagrams
% figure; bode(G_id_d); grid on; title('G_{id,d}(s) - Duty to Input Current');
% figure; bode(G_vd_d); grid on; title('G_{vd,d}(s) - Duty to Bus Voltage');
% figure; margin(Li); grid on; title('Inner Current Loop L_i(s)');
% figure; margin(Lv_roll); grid on; title('Outer Voltage Loop L_v(s) with Roll-off');
