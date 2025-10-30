% SCRIPT: build_per_topology_matrices_9th_order.m
%
% This script defines the state-space matrices for the Interleaved Bridgeless
% SEPIC PFC converter for the positive half-cycle (s = +1).
%
% **9TH-ORDER SYSTEM**
% State vector order: x = [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vC0]'
%
% Where:
%   iL1, iL2, iL3, iL4: Input inductor currents (1200 μH each)
%   iL5, iL6: Output inductor currents (1.2 H each) ← NEW STATES
%   vC12: Phase 1 capacitor voltage (C1||C2)
%   vC34: Phase 2 capacitor voltage (C3||C4)
%   vC0: Output DC link voltage
%
% Reference: VINUKUMAR-LUCKOSE-ICCE2022
% Derivation: COMPLETE_36_EQUATION_DERIVATION.md

clear; clc;

% --- Define Symbolic Variables ---
syms L1 L2 L3 L4 L5 L6 C12 C34 C0 real
syms iL1 iL2 iL3 iL4 iL5 iL6 vC12 vC34 vC0 Vin P real

% --- Phase 2.1: Per-Topology Matrices (9×9 for 9th-order) ---

%% ========================================================================
%% TOPOLOGY 11: S1 ON, S2 ON (Both Switches Closed)
%% ========================================================================
disp('--- Building Matrices for Topology 11 (S1 ON, S2 ON) ---');

% Initialize 9×9 matrix
A11 = sym(zeros(9,9));

% Row 1: diL1/dt = (Vin - vC34) / L1
A11(1, 8) = -1/L1;  % -vC34/L1

% Row 2: diL2/dt = (Vin - vC12) / L2
A11(2, 7) = -1/L2;  % -vC12/L2

% Row 3: diL3/dt = 0 (isolated in positive cycle Topology 11)
% All elements remain zero

% Row 4: diL4/dt = (Vin - vC34) / L4
A11(4, 8) = -1/L4;  % -vC34/L4

% Row 5: diL5/dt = 0 (D7 reverse biased, isolated)
% All elements remain zero

% Row 6: diL6/dt = 0 (D8 reverse biased, isolated)
% All elements remain zero

% Row 7: dvC12/dt = (iL2 + iL3) / C12
A11(7, 2) = 1/C12;  % +iL2/C12
A11(7, 3) = 1/C12;  % +iL3/C12

% Row 8: dvC34/dt = (iL1 + iL4) / C34
A11(8, 1) = 1/C34;  % +iL1/C34
A11(8, 4) = 1/C34;  % +iL4/C34

% Row 9: dvC0/dt = -P/(C0·vC0) [CPL term added separately in averaging]
% No state coupling in A matrix for vC0 in Topology 11

% Input matrix B_in (9×1)
B_in_11 = sym(zeros(9,1));
B_in_11(1, 1) = 1/L1;  % Vin couples to L1
B_in_11(2, 1) = 1/L2;  % Vin couples to L2
B_in_11(4, 1) = 1/L4;  % Vin couples to L4

disp('A11 (9×9) ='); disp(A11);
disp('B_in_11 (9×1) ='); disp(B_in_11);


%% ========================================================================
%% TOPOLOGY 10: S1 ON, S2 OFF
%% ========================================================================
disp('--- Building Matrices for Topology 10 (S1 ON, S2 OFF) ---');

A10 = sym(zeros(9,9));

% Row 1: diL1/dt = (Vin - vC34 - vC0) / L1
A10(1, 8) = -1/L1;  % -vC34/L1
A10(1, 9) = -1/L1;  % -vC0/L1

% Row 2: diL2/dt = (Vin - vC12) / L2
A10(2, 7) = -1/L2;  % -vC12/L2

% Row 3: diL3/dt = 0 (still isolated in Topology 10)
% All elements remain zero

% Row 4: diL4/dt = (Vin - vC34 - vC0) / L4
A10(4, 8) = -1/L4;  % -vC34/L4
A10(4, 9) = -1/L4;  % -vC0/L4

% Row 5: diL5/dt = 0 (conservative: D7 not yet conducting)
% All elements remain zero

% Row 6: diL6/dt = (vC34 - vC0) / L6
A10(6, 8) = 1/L6;   % +vC34/L6
A10(6, 9) = -1/L6;  % -vC0/L6

% Row 7: dvC12/dt = (iL2 + iL3) / C12
A10(7, 2) = 1/C12;
A10(7, 3) = 1/C12;

% Row 8: dvC34/dt = (iL1 + iL4 - iL6) / C34
A10(8, 1) = 1/C34;
A10(8, 4) = 1/C34;
A10(8, 6) = -1/C34;  % -iL6/C34

% Row 9: dvC0/dt = (iL6 - P/vC0) / C0
A10(9, 6) = 1/C0;  % +iL6/C0

B_in_10 = sym(zeros(9,1));
B_in_10(1, 1) = 1/L1;
B_in_10(2, 1) = 1/L2;
B_in_10(4, 1) = 1/L4;

disp('A10 (9×9) ='); disp(A10);
disp('B_in_10 (9×1) ='); disp(B_in_10);


%% ========================================================================
%% TOPOLOGY 00: S1 OFF, S2 OFF (Both Switches Open)
%% ========================================================================
disp('--- Building Matrices for Topology 00 (S1 OFF, S2 OFF) ---');

A00 = sym(zeros(9,9));

% Row 1: diL1/dt = (Vin - vC34 - vC0) / L1
A00(1, 8) = -1/L1;
A00(1, 9) = -1/L1;

% Row 2: diL2/dt = (Vin - vC12 - vC0) / L2
A00(2, 7) = -1/L2;
A00(2, 9) = -1/L2;

% Row 3: diL3/dt = (Vin - vC12 - vC0) / L3
A00(3, 7) = -1/L3;
A00(3, 9) = -1/L3;

% Row 4: diL4/dt = (Vin - vC34 - vC0) / L4
A00(4, 8) = -1/L4;
A00(4, 9) = -1/L4;

% Row 5: diL5/dt = (vC12 - vC0) / L5
A00(5, 7) = 1/L5;   % +vC12/L5
A00(5, 9) = -1/L5;  % -vC0/L5

% Row 6: diL6/dt = (vC34 - vC0) / L6
A00(6, 8) = 1/L6;   % +vC34/L6
A00(6, 9) = -1/L6;  % -vC0/L6

% Row 7: dvC12/dt = (iL2 + iL3 - iL5) / C12
A00(7, 2) = 1/C12;
A00(7, 3) = 1/C12;
A00(7, 5) = -1/C12;  % -iL5/C12

% Row 8: dvC34/dt = (iL1 + iL4 - iL6) / C34
A00(8, 1) = 1/C34;
A00(8, 4) = 1/C34;
A00(8, 6) = -1/C34;  % -iL6/C34

% Row 9: dvC0/dt = (iL5 + iL6 - P/vC0) / C0
A00(9, 5) = 1/C0;  % +iL5/C0
A00(9, 6) = 1/C0;  % +iL6/C0

B_in_00 = sym(zeros(9,1));
B_in_00(1, 1) = 1/L1;
B_in_00(2, 1) = 1/L2;
B_in_00(3, 1) = 1/L3;
B_in_00(4, 1) = 1/L4;

disp('A00 (9×9) ='); disp(A00);
disp('B_in_00 (9×1) ='); disp(B_in_00);


%% ========================================================================
%% TOPOLOGY 01: S1 OFF, S2 ON
%% ========================================================================
disp('--- Building Matrices for Topology 01 (S1 OFF, S2 ON) ---');

% This topology is the complement of Topology 10
% Phase 1 transfers (S1 OFF), Phase 2 charges (S2 ON)

A01 = sym(zeros(9,9));

% Row 1: diL1/dt = (Vin - vC34) / L1
A01(1, 8) = -1/L1;

% Row 2: diL2/dt = (Vin - vC12 - vC0) / L2
A01(2, 7) = -1/L2;
A01(2, 9) = -1/L2;

% Row 3: diL3/dt = (Vin - vC12 - vC0) / L3
A01(3, 7) = -1/L3;
A01(3, 9) = -1/L3;

% Row 4: diL4/dt = (Vin - vC34) / L4
A01(4, 8) = -1/L4;

% Row 5: diL5/dt = (vC12 - vC0) / L5
A01(5, 7) = 1/L5;
A01(5, 9) = -1/L5;

% Row 6: diL6/dt = 0 (D8 reverse biased)
% All elements remain zero

% Row 7: dvC12/dt = (iL2 + iL3 - iL5) / C12
A01(7, 2) = 1/C12;
A01(7, 3) = 1/C12;
A01(7, 5) = -1/C12;

% Row 8: dvC34/dt = (iL1 + iL4) / C34
A01(8, 1) = 1/C34;
A01(8, 4) = 1/C34;

% Row 9: dvC0/dt = (iL5 - P/vC0) / C0
A01(9, 5) = 1/C0;

B_in_01 = sym(zeros(9,1));
B_in_01(1, 1) = 1/L1;
B_in_01(2, 1) = 1/L2;
B_in_01(3, 1) = 1/L3;
B_in_01(4, 1) = 1/L4;

disp('A01 (9×9) ='); disp(A01);
disp('B_in_01 (9×1) ='); disp(B_in_01);


%% ========================================================================
%% Save Matrices to MAT File
%% ========================================================================
disp('--- Saving Symbolic Matrices ---');
save('per_topology_matrices_9th_order.mat', 'A11', 'A10', 'A00', 'A01', ...
     'B_in_11', 'B_in_10', 'B_in_00', 'B_in_01');

disp('✅ All 9×9 matrices built successfully!');
disp('   Matrices saved to: per_topology_matrices_9th_order.mat');


%% ========================================================================
%% Verification: Check Matrix Dimensions
%% ========================================================================
disp('--- Matrix Dimension Verification ---');
fprintf('A11 size: %d×%d ✅\n', size(A11, 1), size(A11, 2));
fprintf('A10 size: %d×%d ✅\n', size(A10, 1), size(A10, 2));
fprintf('A00 size: %d×%d ✅\n', size(A00, 1), size(A00, 2));
fprintf('A01 size: %d×%d ✅\n', size(A01, 1), size(A01, 2));
fprintf('B_in_11 size: %d×%d ✅\n', size(B_in_11, 1), size(B_in_11, 2));
fprintf('B_in_10 size: %d×%d ✅\n', size(B_in_10, 1), size(B_in_10, 2));
fprintf('B_in_00 size: %d×%d ✅\n', size(B_in_00, 1), size(B_in_00, 2));
fprintf('B_in_01 size: %d×%d ✅\n', size(B_in_01, 1), size(B_in_01, 2));

disp('');
disp('✅ 9TH-ORDER SYSTEM IMPLEMENTATION COMPLETE');
disp('   State vector: x = [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vC0]''');
disp('   Ready for averaging and linearization in phase3 script.');
