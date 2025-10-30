# Interleaved Bridgeless SEPIC PFC Converter Project - Complete File Documentation

**Project Focus:** Mathematical modeling, analysis, and control design for a novel 9th-order interleaved bridgeless SEPIC Power Factor Correction (PFC) converter as proposed by Ts. Vinukumar Luckose.

**Documentation Date:** October 29, 2025

---

## Table of Contents
1. [Core MATLAB Implementation Files](#core-matlab-implementation-files)
2. [Reference Circuit and Specification Documents](#reference-circuit-and-specification-documents)
3. [Presentation and Documentation Files](#presentation-and-documentation-files)
4. [Key Findings and Discoveries](#key-findings-and-discoveries)
5. [Project Evolution and Corrections](#project-evolution-and-corrections)

---

## Core MATLAB Implementation Files

### 1. `build_per_topology_matrices.m`
**Location:** `j:\FYP stuff\build_per_topology_matrices.m`

**Purpose:**  
Defines the symbolic state-space matrices for all four switching topologies of the interleaved bridgeless SEPIC PFC converter during the positive AC half-cycle (s = +1).

**Key Contents:**
- **State Vector Order (7th-order model):** `x = [iL1a, iL2a, vCsa, iL1b, iL2b, vCsb, vbus]'`
- **Symbolic Component Parameters:** L1a, L2a, Csa, L1b, L2b, Csb, Cbus
- **Four Topology Matrices:**
  - **A11, B_in_11:** Both switches ON (S1 ON, S2 ON) - Energy storage phase
  - **A10, B_in_10:** S1 ON, S2 OFF - Phase A stores, Phase B transfers
  - **A01, B_in_01:** S1 OFF, S2 ON - Phase B stores, Phase A transfers (derived via permutation)
  - **A00, B_in_00:** Both switches OFF - Energy transfer phase

**Mathematical Approach:**
- Uses symbolic computation to maintain exact forms
- Implements permutation matrix P to derive A01 from A10: `A01 = P * A10 * P'`
- Permutation swaps phase-A triplet [rows 1,2,3] with phase-B triplet [rows 4,5,6], keeping vbus [row 7] fixed

**Critical Discovery:**
- This file implements a **7th-order model**, but discussions revealed the actual Vinukumar circuit requires a **9th-order model** including L5 and L6 (output inductors) as independent states

**Usage:**
```matlab
run('build_per_topology_matrices.m')
% Produces: A11, A10, A01, A00, B_in_11, B_in_10, B_in_01, B_in_00 (symbolic)
```

---

### 2. `phase3_avg_linearize.m`
**Location:** `j:\FYP stuff\phase3_avg_linearize.m`

**Purpose:**  
Complete implementation of state-space averaging, DC operating point solution, small-signal linearization, transfer function derivation, and PI controller tuning for the SEPIC converter.

**Key Sections:**

#### Section 0: Matrix Loading
- Runs `build_per_topology_matrices.m` to obtain symbolic matrices
- Substitutes numerical component values to convert symbolic → numeric matrices

**Example Parameters:**
```matlab
L1a = L2a = L1b = L2b = 200 µH
Csa = Csb = 1 µF
Cbus = 1000 µF
```

#### Section 1: Operating Point Setup
**Operating Conditions:**
```matlab
s = +1                  % Positive half-cycle
Vin0 = 170 V           % Frozen input voltage
P0 = 1500 W            % Load power (CPL)
d1 = d2 = 0.35         % Duty cycles for both phases
```

#### Section 2: State-Space Averaging
**Duty Cycle Weights (Piecewise):**
```matlab
w11 = max(0, d1 + d2 - 1)    % Overlap region
w00 = max(0, 1 - d1 - d2)    % Both OFF region
w10 = d1 - w11                % S1 only ON
w01 = d2 - w11                % S2 only ON
```

**Averaged Matrices:**
```matlab
Aavg = w11*A11 + w10*A10 + w01*A01 + w00*A00
Binavg = s*(w11*B_in_11 + w10*B_in_10 + w01*B_in_01 + w00*B_in_00)
```

**Key Insight:**  
- Variable `s = sign(Vin)` only multiplies `Binavg` (input matrix), NOT `Aavg` (state matrix)
- This handles AC polarity elegantly without duplicating matrices

#### Section 3: DC Operating Point Solution
**Nonlinear System:**
```matlab
ẋ = Aavg*x + Binavg*Vin + [0; 0; 0; 0; 0; 0; -P/(Cbus*vbus)]
```

**Solution Method:**
- Uses MATLAB's `fsolve` to solve for x0 where ẋ = 0
- Includes Constant Power Load (CPL) term: `-P/(Cbus*vbus)` on bus equation

**Typical Result:**
- `vbus0 ≈ 373 V` at Vin0=170V, P0=1500W, d1=d2=0.35

#### Section 4: Small-Signal Linearization
**Linearized State Matrix:**
```matlab
A_linear = Aavg
A_linear(7,7) += P0/(Cbus*vbus0^2)  % CPL Jacobian term
```

**Control Input Matrix B_d (7×2):**
- Computed using chain rule through duty-weight derivatives
- Piecewise calculation based on whether d1+d2 < 1 or > 1

**Derivation:**
```matlab
g_k = A_k*x0 + s*B_in_k*Vin0  (for k = 11, 10, 01, 00)
Bd1 = Σ(∂w_k/∂d1) * g_k
Bd2 = Σ(∂w_k/∂d2) * g_k
B_d = [Bd1, Bd2]
```

**Load Disturbance Vector:**
```matlab
B_P = [0; 0; 0; 0; 0; 0; -1/(Cbus*vbus0)]
```

#### Section 5: Transfer Function Extraction
**Measurement Matrices:**
```matlab
C_i = s * [1 0 0 1 0 0 0]     % Input current: y_i = s*(iL1a + iL1b)
C_v = [0 0 0 0 0 0 1]         % Bus voltage
```

**Key Transfer Functions:**
```matlab
G_id_d: Duty → Input Current  (for current loop design)
G_vd_d: Duty → Bus Voltage    (for voltage loop design)
```

#### Section 6: PI Controller Tuning Helpers
**Inner Current Loop (Fast):**
```matlab
fc_i = 3 kHz                   % Target crossover frequency
Kp_i ≈ 0.00838                % Example tuned gain
Ki_i ≈ 31.6                   % Example integral gain
```

**Outer Voltage Loop (Slow):**
```matlab
fc_v = 15 Hz                   % Target crossover frequency
Kp_v ≈ 0.00174                % Example tuned gain
Ki_v ≈ 0.0327                 % Example integral gain
```

**Optional Roll-Off:**
- Adds high-frequency pole at 10×fc_v to prevent second crossover at resonance

**Critical Limitations Identified:**
- This script is based on the **7th-order model** (missing L5, L6 states)
- For full accuracy with Vinukumar's circuit, must extend to **9th-order**

---

## Reference Circuit and Specification Documents

### 3. `VINUKUMAR-LUCKOSE-ICCE2022-corrected - V2.pdf`
**Location:** `j:\FYP stuff\tools\VINUKUMAR-LUCKOSE-ICCE2022-corrected - V2.pdf`

**Document Type:** IEEE Conference Paper (ICCE 2022)

**Title:** *"Design and Analysis of Two-Stage Interleaved Bridgeless SEPIC-Based PFC Converter"*

**Author:** Ts. Vinukumar Luckose

**Key Information:**

#### Circuit Topology Description
**Component Count:**
- **6 Inductors:** L1, L2, L3, L4, L5, L6
- **5 Capacitors:** C1, C2, C3, C4, C0 (output bus)
- **2 Active Switches:** S1, S2 (MOSFETs)
- **8 Diodes:** D1–D8 (for bridgeless operation and output rectification)
- D5, D6: Return path diodes for positive/negative half-cycles
- D7, D8: Output rectifier diodes per phase

**True System Order:** **9th-order**
- 6 independent inductor currents: iL1, iL2, iL3, iL4, iL5, iL6
- 3 independent capacitor voltages: vC12 (C1‖C2), vC34 (C3‖C4), vCo (C0)

#### Operating Modes (Positive Half-Cycle)
**Mode 1: S1 ON, S2 ON**
- **Active Inductors:** L1, L2 (charging from Vin)
- **Conducting Diodes:** D1, D3 (forward-biased), D5 (return path)
- **Charging Capacitors:** C1, C3 (to diode drop voltage)
- **Output:** D7, D8 reverse-biased; bus isolated

**Mode 2: S1 OFF, S2 OFF**
- **Active Inductors:** L1, L2 (discharging to bus via L5, L6)
- **Conducting Diodes:** D7, D8 (forward-biased to bus), D5 (return)
- **Energy Transfer:** L1→D7→C0, L2→D8→C0

**Mode 3 (Negative Half): S1 ON, S2 ON**
- **Active Inductors:** L3, L4 (charging)
- **Conducting Diodes:** D2, D4, D6 (return path)
- **Output:** Isolated

**Mode 4 (Negative Half): S1 OFF, S2 OFF**
- **Active Inductors:** L3, L4 (discharging to bus)
- **Conducting Diodes:** D7, D8, D6

#### Critical Circuit Insights from Paper
**Phase Grouping (Corrected Understanding):**
- **S1-Side:** Uses L2 (charging), L4 (charging in neg cycle), couples via C1‖C2, outputs via D7 and L5
- **S2-Side:** Uses L1 (charging), L3 (charging in neg cycle), couples via C3‖C4, outputs via D8 and L6

**Cross-Connected Topology:**
- L1 connects between top AC line and C3‖C4 node
- L2 connects between top AC line and C1‖C2 node
- L3 connects between bottom AC line and C2‖C4 node
- L4 connects between bottom AC line and C1‖C4 node
- This is NOT a standard SEPIC; it's a novel cross-connected bridgeless variant

---

### 4. `VINUKUMAR-LUCKOSE-ICCE2022-corrected - V2.jpeg`
**Location:** `j:\FYP stuff\tools\VINUKUMAR-LUCKOSE-ICCE2022-corrected - V2.jpeg`

**Content:** Circuit schematic diagram extracted from the conference paper

**Visual Elements:**
- Complete component labeling (L1–L6, C1–C4, C0, S1, S2, D1–D8, D5, D6)
- AC source connection points
- Bridgeless input diode arrangement
- Load resistor RL and output capacitor C0
- Shows the unusual "U-shape" non-connections that differentiate this from standard topologies

**Critical Discovery from Schematic Analysis:**
- Visual inspection revealed that C1‖C2 and C3‖C4 are physically separate node pairs
- L5 and L6 are NOT just "routing" inductors—they store and release energy during switching
- This confirmed the need for a 9th-order model, not 7th-order

---

## Presentation and Documentation Files

### 5. `Mathematical_Model_for_the_Interleaved_Bridgeless_SEPIC_PFC_Converter.pdf` (Version 1)
**Location:** `j:\FYP stuff\Mathematical_Model_for_the_Interleaved_Bridgeless_SEPIC_PFC_Converter.pdf`

**Purpose:** Initial presentation draft

**Status:** **Superseded** - contained errors

**Known Issues:**
- Mixed "9th-order" and "7th-order" references inconsistently
- Per-topology equations incomplete (missing L5/L6 dynamics)
- Used incorrect schematic (boost PFC instead of SEPIC in some slides)

---

### 6. `Mathematical_Model_for_the_Interleaved_Bridgeless_SEPIC_PFC_Converter_2.pdf` (Version 2)
**Location:** `j:\FYP stuff\Mathematical_Model_for_the_Interleaved_Bridgeless_SEPIC_PFC_Converter_2.pdf`

**Purpose:** Second iteration with improvements

**Status:** **Superseded**

**Improvements:**
- Added modeling assumptions slide
- Clarified s = sign(Vin) usage
- Added duty-cycle weights visualization

**Remaining Issues:**
- Still used 7th-order model foundation
- L5/L6 equations incorrect or missing

---

### 7. `Mathematical_Model_for_the_Interleaved_Bridgeless_SEPIC_PFC_Converter_3.pdf` (Version 3)
**Location:** `j:\FYP stuff\Mathematical_Model_for_the_Interleaved_Bridgeless_SEPIC_PFC_Converter_3.pdf`

**Purpose:** Major revision after discovering system order error

**Status:** **Superseded**

**Major Changes:**
- Declared system as 9th-order throughout
- Updated state vector to include all 9 states
- Revised per-topology equations

**Remaining Issues:**
- L5/L6 dynamics in Topology 11 incorrectly showed non-zero rates
- Some equations still needed sign/direction corrections

---

### 8. `Mathematical_Model_for_the_Interleaved_Bridgeless_SEPIC_PFC_Converter_4.pdf` (Version 4 - CURRENT)
**Location:** `j:\FYP stuff\Mathematical_Model_for_the_Interleaved_Bridgeless_SEPIC_PFC_Converter_4.pdf`

**Purpose:** **Final corrected version** for presentation to Ts. Vinukumar Luckose

**Status:** **CURRENT / VERIFIED**

**Complete Slide Structure (16 slides):**

#### Slide 1: Title
- Title: "Mathematical Model for the Interleaved Bridgeless SEPIC PFC Converter"
- Subtitle: "A Comprehensive Analysis from Fundamental Physics to Control Design"
- Date: October 10, 2025

#### Slide 2: Introduction and Objectives
**Document Objective:**
- Complete mathematical equations for dynamic behavior
- Rigorous step-by-step derivation from physics to control design

**Three Levels of Abstraction:**
1. Level 1: Per-topology state equations (frame-by-frame physics)
2. Level 2: Nonlinear state-space averaged model (big picture)
3. Level 3: Small-signal linearized model (nudge test for control)

#### Slide 3: Deconstructing System Complexity
**Three Challenges:**
1. **Higher-Order System (9th-Order):**
   - 6 independent inductors + 3 capacitors = 9 energy storage elements
   - Multiple energy pathways and complex state interactions

2. **Time-Varying Nature:**
   - Four distinct switching topologies per cycle
   - Continuously transitions between configurations
   - Piecewise-defined governing equations

3. **Nonlinear Behavior:**
   - Duty cycle modulation (control × states)
   - Constant Power Load (P/vbus term)
   - Prevents direct linear control application

#### Slide 4: Key Modeling Assumptions
**Comprehensive List:**
1. Continuous Conduction Mode (CCM) for all inductors
2. Ideal switches/diodes (zero drops, instant switching)
3. Ideal passive components (no ESR, no core loss)
4. Symmetrical interleaved phases (180° phase shift)
5. High switching frequency (quasi-static Vin assumption)
6. Constant Power Load (CPL): I_load = P/vbus

**Purpose Statement:**
- Focus on fundamental energy transfer mechanisms
- Maintain mathematical tractability
- Create baseline for adding non-idealities later

#### Slide 5: Analytical Strategy (Flowchart)
**Step 1: Per-Topology Analysis**
- Deconstruct into 4 switching states
- Apply KVL/KCL for exact state-space per topology
- Output: A_k and B_k matrices (ground truth)

**Step 2: State-Space Averaging**
- Blend 4 topologies using duty-cycle weights
- Output: Single nonlinear averaged equation

**Step 3: Small-Signal Linearization**
- Taylor expansion around DC operating point
- Output: Linearized model for transfer functions and control design

#### Slide 6: Level 1 - The "Frame-by-Frame" Physics
**Concept Explanation:**
- Like watching high-speed video, pausing at each switching state
- Engine cycle analogy: intake, compression, power, exhaust

**The Four Topologies:**
- **Topology 11:** Both switches ON (energy storage)
- **Topology 10:** S1 ON, S2 OFF (mixed storage/transfer)
- **Topology 01:** S1 OFF, S2 ON (mixed storage/transfer)
- **Topology 00:** Both switches OFF (energy transfer)

**Key Insight Box:**
"Each topology produces 9 first-order differential equations (one per state variable), derived directly from KVL/KCL."

#### Slide 7: Level 1 - Per-Topology State Equations (CORRECTED)
**Verified Equations for Positive Half-Cycle:**

**Topology 11 (Both Switches ON):**
```
diL1/dt = Vin / L1
diL2/dt = Vin / L2
diL3/dt = 0                    (inactive in positive cycle)
diL4/dt = 0                    (inactive in positive cycle)
diL5/dt = 0                    (isolated, D7 OFF)
diL6/dt = 0                    (isolated, D8 OFF)
dvC12/dt = 0                   (clamped by D1)
dvC34/dt = 0                   (clamped by D3)
dvCo/dt = -P / (C0 * vCo)     (CPL draining bus)
```

**Topology 10 (S1 ON, S2 OFF):**
```
diL1/dt = (Vin - vC34 - vCo) / L1    (transferring via D8)
diL2/dt = Vin / L2                    (charging)
diL3/dt = 0
diL4/dt = 0
diL5/dt = 0                           (not in active path)
diL6/dt = -vCo / L6                   (delivering to bus)
dvC12/dt = 0
dvC34/dt = iL1 / (C3 + C4)
dvCo/dt = (iL1 + iL6) / C0 - P / (C0 * vCo)
```

**Topology 01 (S1 OFF, S2 ON):**
```
diL1/dt = Vin / L1                    (charging)
diL2/dt = (Vin - vC12 - vCo) / L2    (transferring via D7)
diL3/dt = 0
diL4/dt = 0
diL5/dt = -vCo / L5                   (delivering to bus)
diL6/dt = 0
dvC12/dt = iL2 / (C1 + C2)
dvC34/dt = 0
dvCo/dt = (iL2 + iL5) / C0 - P / (C0 * vCo)
```

**Topology 00 (Both Switches OFF):**
```
diL1/dt = (Vin - vC34 - vCo) / L1
diL2/dt = (Vin - vC12 - vCo) / L2
diL3/dt = 0
diL4/dt = 0
diL5/dt = -vCo / L5
diL6/dt = -vCo / L6
dvC12/dt = iL2 / (C1 + C2)
dvC34/dt = iL1 / (C3 + C4)
dvCo/dt = (iL1 + iL2 + iL5 + iL6) / C0 - P / (C0 * vCo)
```

**Note:**
"These equations are the ground truth for the positive AC half-cycle. Each topology has 9 differential equations (9th-order system) and forms the basis for the averaged model."

#### Slide 8: Handling AC Polarity - The s Variable
**The Challenge:**
- Bridgeless topology behaves like two circuits (positive/negative half-cycles)
- Separate models would be redundant

**The Solution:**
```
s = sign(Vin)
s = +1 when Vin > 0
s = -1 when Vin < 0
```

**Key Insight (Highlighted Box):**
"The s variable ONLY multiplies the input matrix B_in, NOT the state matrix A_avg."

**Mathematical Form:**
```
B_in,avg = s · (w11·B_in,11 + w10·B_in,10 + w01·B_in,01 + w00·B_in,00)
```

**Physical Meaning:**
- **Internal Physics (A_avg):** Energy exchange between components is independent of input polarity
- **Input's Effect (B_in,avg):** Direction of energy "push" from input depends on polarity

**Result:**
"A single, unified model valid for the entire AC cycle"

#### Slide 9: Level 2 - The "Big Picture" Averaged Model
**Concept:**
- State-space averaging combines 4 topologies into single unified model
- Describes average behavior over full switching cycle

**Feynman Analogy:**
"Like calculating a car's average horsepower over a full engine cycle rather than analyzing each piston stroke separately"

**Averaging Formula:**
```
A_avg = w11·A11 + w10·A10 + w01·A01 + w00·A00
```

Where:
- **A_k:** System matrices from Level 1 equations
- **w_k:** Duty cycle weights (fraction of time in each state)

**Key Insight:**
"Averaged model is nonlinear because weights w_k are functions of duty cycles (d1, d2)"

**Purpose:**
"Solve for steady-state DC operating point"

#### Slide 10: Visualizing Duty Cycle Weights
**What They Represent:**
"Fraction of time spent in each of 4 switching states, determined by d1 and d2"

**Two Operating Regions:**

**Case 1: Non-Overlapping (d1 + d2 < 1)**
- Lower duty cycles
- Sequence: S1 ON → Both OFF → S2 ON → Both OFF
- Timing diagram showing separated pulses

**Case 2: Overlapping (d1 + d2 > 1)**
- Higher duty cycles
- Sequence: S1 only → Both ON → S2 only
- Timing diagram showing overlapped pulses

**Mathematical Formulas:**
```
w11 = max(0, d1 + d2 - 1)        [overlap duration]
w00 = max(0, 1 - d1 - d2)        [both OFF duration]
w10 = d1 - w11                    [S1 only duration]
w01 = d2 - w11                    [S2 only duration]
```

**Key Insights:**
- Weights always sum to 1: w11 + w10 + w01 + w00 = 1
- Non-overlapping: w11 = 0, w00 > 0
- Overlapping: w11 > 0, w00 = 0
- Boundary (d1+d2=1): Both w11=0 and w00=0

#### Slide 11: Level 2 - Averaged Equation of Motion
**The Complete Nonlinear Model:**
```
ẋ = A_avg(d1, d2)·x + B_in,avg(d1, d2, s)·Vin + B_load(x)
```

**Component Definitions:**

**A_avg (9×9):** Averaged State Matrix
```
A_avg = w11·A11 + w10·A10 + w01·A01 + w00·A00
```
Represents blended "internal physics"

**B_in,avg (9×1):** Averaged Input Matrix
```
B_in,avg = s·(w11·B_in,11 + w10·B_in,10 + w01·B_in,01 + w00·B_in,00)
```
Represents blended "external force" with polarity switch

**B_load(x) (9×1):** Nonlinear Load Vector
```
B_load(x) = [0, 0, 0, 0, 0, 0, 0, 0, -P/(C0·vCo)]ᵀ
```
Isolates CPL nonlinearity on bus voltage equation only

**Key Characteristics:**
- **Unified:** Accounts for all 4 topologies in single equation
- **Nonlinear:** A_avg and B_in,avg are functions of (d1, d2); load term nonlinear in vCo
- **9th-Order:** All matrices dimensioned for 9 states
- **Purpose:** Solve for DC operating point x0 by setting ẋ = 0

#### Slide 12: Level 3 - The "Nudge Test" Linearized Model
**The Goal:**
"Create a linear approximation valid for small ripples around steady-state operating point"

**Feynman Analogy - The Tangent Line:**
"On a winding mountain road, if you zoom into your current position, a one-meter section looks almost straight. That's linearization—replacing a complex curve with a simple line accurate for small movements."

**The Linearization Process:**

**Step 1: Find Operating Point**
- Solve ẋ = 0 in averaged model
- Get DC values (x₀, d₁₀, d₂₀, Vin₀)
- This is "current position"

**Step 2: Define Small Perturbations**
- Express as DC + AC: x = x₀ + x̃, d1 = d₁₀ + d̃1
- Tilde (~) represents small deviations

**Step 3: Taylor Expansion**
- Compute Jacobian matrices ∂f/∂x, ∂f/∂d evaluated at operating point
- Gives constant-coefficient matrices

**Final Linear Form:**
```
d(x̃)/dt = A_linear·x̃ + B_d·[d̃1, d̃2]ᵀ + B_in·Ṽin + B_P·P̃
```

All matrices are now constant numerical values!

**Why Linearization Matters:**
"Enables use of powerful linear control theory tools: transfer functions, Bode plots, pole-zero analysis, and classical controller design"

#### Slide 13: Deriving the Control Input Matrix B_d
**The "Nudge Test" in Detail:**
"If I nudge duty cycle d̃1 slightly, how does each state respond?"

**Physical Analogy:**
"A complex machine with interconnected gears. The control lever does two things:
1. **Direct Effect:** Pushes fuel injector, adds energy
2. **Indirect Effect:** Changes gear ratios, alters internal interactions
B_d captures the TOTAL effect"

**Mathematical Challenge:**
Duty cycles appear inside averaged matrices:
```
ẋ = A_avg(d1,d2)·x + B_in,avg(d1,d2)·Vin + B_load(x)
```
Both A_avg and B_in,avg depend on d1, d2 through weights w_k → requires chain rule

**Step-by-Step Implementation:**

**Step 1: Compute Fixed-State Dynamics**
```
g_k = A_k·x0 + s·B_in,k·Vin0    (for k = 11, 10, 01, 00)
```

**Step 2: Calculate Weight Derivatives**
Find ∂w_k/∂d1 and ∂w_k/∂d2 (piecewise by d1+d2 region)

**Step 3: Sum Contributions**
```
B_d,col1 = Σ(∂w_k/∂d1)·g_k
B_d,col2 = Σ(∂w_k/∂d2)·g_k
```

**The Concept:**
"Chain rule in action: total change = Σ(time-fraction change) × (state behavior in that time)"

#### Slide 14: Level 3 - The Final Linearized Equation of Motion
**Complete Small-Signal Model:**
```
d(x̃)/dt = A_linear·x̃ + B_d·ũd + B_in·Ṽin + B_P·P̃
```
where ũd = [d̃1, d̃2]ᵀ

**Component Definitions:**

**A_linear (9×9):** Linearized State Matrix
```
A_linear = A_avg |_(operating point)
A_linear(9,9) += P0/(C0·vCo,0²)    [CPL Jacobian]
```
Captures how state changes affect other state rates

**B_d (9×2):** Control Input Matrix
```
B_d = [∂f/∂d1 | ∂f/∂d2] = Σ[(∂f/∂w_k)·(∂w_k/∂di)]
```
Primary control input for duty cycle modulation

**B_in (9×1):** Input Disturbance Matrix
```
B_in = ∂f/∂Vin |_(operating point)
```
For input voltage disturbance rejection analysis

**B_P (9×1):** Load Disturbance Vector
```
B_P = [0, 0, 0, 0, 0, 0, 0, 0, -1/(C0·vCo,0)]ᵀ
```
CPL term affects only bus voltage equation

**Significance:**
"This 9th-order model fully captures dynamics of all 6 inductors and 3 capacitors, providing accurate representation for high-bandwidth control design and CPL stability analysis."

#### Slide 15: The Ultimate Goal - Transfer Functions for Control
**From Linearized Model to Controllers:**

**Key Transfer Functions:**

1. **Control-to-Output Voltage:**
```
G_vd(s) = ṽCo(s) / d̃i(s)
```
Primary for voltage loop controller design

2. **Input Impedance:**
```
Z_in(s) = Ṽin(s) / ĩin(s)
```
For power quality standards compliance

3. **Output Impedance:**
```
Z_out(s) = ṽCo(s) / ĩload(s)
```
For load regulation analysis

**Two-Loop Control Architecture:**

**Inner Current Loop (Fast):**
- Regulates input current to follow sinusoidal reference
- Achieves Power Factor Correction
- Bandwidth: 1-5 kHz

**Outer Voltage Loop (Slow):**
- Maintains constant output voltage
- Adjusts current reference amplitude
- Bandwidth: 10-50 Hz

**Applications of Transfer Functions:**
- Bode plot analysis (gain/phase margins)
- Pole-zero placement for transient response
- Lead-lag, PI, or PID compensator design
- CPL stability analysis
- Sensitivity to component variations
- Disturbance rejection performance

**From Physics to Control:**
"The journey from KVL/KCL (Level 1) → averaging (Level 2) → linearization (Level 3) culminates in transfer functions that transform complex 9th-order physics into tractable tools for control design."

#### Slide 16: Conclusion and Next Steps
**Key Milestones Achieved:**

✅ **Complete Mathematical Framework**
- Captured 9th-order system dynamics
- Three levels of abstraction: per-topology → averaged → linearized

✅ **Rigorous Derivation**
- Systematic from KVL/KCL to transfer functions
- Mathematical rigor at every step

✅ **Unified AC Polarity Handling**
- Single model for full AC cycle using s = sign(Vin)

✅ **CPL Stability Foundation**
- Explicitly modeled destabilizing CPL effect
- Basis for stability analysis and compensation

**Next Steps:**

1. **Transfer Function Derivation**
   - Extract G(s) = C(sI - A_linear)⁻¹B + D

2. **Controller Design**
   - Design cascaded voltage/current loops
   - Appropriate compensators for bandwidth and margins

3. **Stability Analysis**
   - Frequency-domain (Bode, Nyquist)
   - Time-domain simulations
   - Verify CPL stability

4. **Experimental Validation**
   - Hardware prototype
   - Measure transient and frequency response

**Final Statement:**
"This document provides complete mathematical foundation for understanding, analyzing, and controlling the Interleaved Bridgeless SEPIC PFC Converter. Every equation is traceable to fundamental circuit physics."

---

**Critical Corrections in Version 4:**
1. ✅ All slides consistently state **9th-order system**
2. ✅ State vector explicitly includes all 9 states: [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vCo]
3. ✅ Per-topology equations (Slide 7) have **correct L5/L6 dynamics:**
   - Topology 11: diL5/dt = 0, diL6/dt = 0 (isolated, D7/D8 OFF)
   - Topology 10: diL5/dt = 0, diL6/dt = -vCo/L6
   - Topology 01: diL5/dt = -vCo/L5, diL6/dt = 0
   - Topology 00: Both active
4. ✅ Capacitor states correctly labeled: vC12 for C1‖C2, vC34 for C3‖C4
5. ✅ s = sign(Vin) clearly stated to multiply B_in only, not A_avg
6. ✅ All matrix dimensions are 9×9 (A), 9×2 (B_d), 9×1 (B_in, B_P)
7. ✅ CPL Jacobian correctly shown as +P0/(C0·vCo0²) in A_linear(9,9)
8. ✅ Correct Vinukumar schematic used (not boost PFC)

---

## Key Findings and Discoveries

### Finding 1: System Order Correction (Critical)
**Initial Assumption:** 7th-order system
- Based on "two inductors per phase + coupling caps + bus cap"
- State vector: [iL1a, iL2a, vCsa, iL1b, iL2b, vCsb, vbus]

**Discovery Process:**
1. Detailed schematic analysis revealed 6 distinct inductors (L1–L6)
2. Circuit tracing of all 4 modes showed L5, L6 actively store/release energy
3. L5, L6 are NOT just "routing wires"—they set current slopes during transfer phases

**Corrected Understanding:** **9th-order system**
- 6 independent inductor current states
- 3 capacitor voltage states (node-sharing for C1‖C2 and C3‖C4)
- Total: 9 states

**Impact:**
- All matrices must be 9×9 (not 7×7)
- Per-topology equations must include diL5/dt and diL6/dt
- MATLAB scripts need complete rewrite for 9th-order

---

### Finding 2: Phase Mapping and Current Paths
**Initial Confusion:**
- Paper's text description was misleading
- Standard SEPIC terminology didn't apply

**Corrected Phase Definitions (from circuit tracing):**

**S1-Side (associated with switch S1):**
- **Positive half-cycle:**
  - Charging path: AC → L2 → D1 → S1 → Ground, return via D5
  - Transfer path: L2 → D7 → L5 → C0
- **Negative half-cycle:**
  - Charging path: AC → L4 → D2 → S1 → Ground, return via D6
  - Transfer path: L4 → D7 → L5 → C0

**S2-Side (associated with switch S2):**
- **Positive half-cycle:**
  - Charging path: AC → L1 → D3 → S2 → Ground, return via D5
  - Transfer path: L1 → D8 → L6 → C0
- **Negative half-cycle:**
  - Charging path: AC → L3 → D4 → S2 → Ground, return via D6
  - Transfer path: L3 → D8 → L6 → C0

**Key Insight:**
"This is a cross-connected topology, NOT a traditional parallel-SEPIC arrangement"

---

### Finding 3: Capacitor Node Sharing
**Physical Reality:**
- C1 and C2 are in parallel → share one node voltage vC12
- C3 and C4 are in parallel → share one node voltage vC34
- Even though there are 4 physical capacitors, only 2 independent voltage states exist (plus C0)

**Mathematical Treatment:**
- One state variable per shared node
- Effective capacitance: Ceq = C1 + C2 (for that node)
- You still "charge both capacitors," but track one voltage

**Why This Matters:**
- Explains why 5 physical capacitors → 3 states
- Capacitance values in equations are sums: (C1+C2) and (C3+C4)

---

### Finding 4: AC Polarity Handling with s Variable
**The Problem:**
- Bridgeless converter uses different current paths for positive/negative half-cycles
- Could require separate models for each

**The Solution:**
- Introduce polarity switch variable: s = sign(Vin) ∈ {+1, -1}
- Apply s ONLY to the input forcing (B_in matrix)
- Internal state interactions (A matrix) remain unchanged

**Physical Justification:**
- Internal energy exchange (L↔C) follows same physics regardless of input polarity
- Only the direction of input "push" reverses

**Mathematical Form:**
```
B_in,avg = s·(w11·B_in,11 + w10·B_in,10 + w01·B_in,01 + w00·B_in,00)
A_avg = w11·A11 + w10·A10 + w01·A01 + w00·A00    [no s term]
```

**Result:**
One unified model for entire AC cycle, elegantly handling polarity asymmetry

---

### Finding 5: Duty Cycle Weights are Piecewise
**Two Distinct Operating Regions:**

**Region 1: Non-Overlapping (d1 + d2 < 1)**
```
w11 = 0                    [no overlap]
w00 = 1 - d1 - d2         [gap when both OFF]
w10 = d1                   [S1 active alone]
w01 = d2                   [S2 active alone]
```

**Region 2: Overlapping (d1 + d2 > 1)**
```
w11 = d1 + d2 - 1         [overlap duration]
w00 = 0                    [no gap]
w10 = 1 - d2              [S1 before overlap]
w01 = 1 - d1              [S2 after overlap]
```

**Critical Boundary:**
- At d1 + d2 = 1, both w11 and w00 are exactly zero
- Derivatives ∂w/∂d are discontinuous at this point
- Must avoid linearizing exactly at boundary

**Impact on B_d Calculation:**
- Must use correct piecewise derivatives for given operating point
- MATLAB implementation includes boundary detection and appropriate formulas

---

### Finding 6: CPL Introduces Destabilizing Nonlinearity
**Constant Power Load Model:**
```
I_load = P/vbus    [hyperbolic relationship]
```

**In State Equations:**
```
dvbus/dt = (i_inductors - I_load)/C0
dvbus/dt = (i_inductors)/C0 - P/(C0·vbus)    [nonlinear term]
```

**Linearization:**
```
∂/∂vbus[-P/(C0·vbus)] = +P/(C0·vbus0²)    [positive feedback!]
```

**Physical Interpretation:**
- CPL acts like negative resistance
- If bus voltage drops, CPL draws MORE current to maintain power
- Creates positive feedback loop → potential instability
- This term is added to A_linear(9,9), making the system harder to stabilize

**Control Design Implication:**
Outer voltage loop must be designed carefully with adequate phase margin to ensure stability under CPL conditions

---

### Finding 7: Interleaving Benefits
**Purpose of 180° Phase Shift:**
- When d1 + d2 < 1 (non-overlapping), input current has "dead zones"
- Interleaving fills these gaps, reducing input current ripple
- Both phases contribute to output, sharing power stress

**Duty Cycle Relationship:**
- For balanced operation: d1 = d2 (symmetric)
- Phase shift ensures complementary ON times
- Optimal ripple cancellation at d1 = d2 = 0.5

---

## Project Evolution and Corrections

### Phase 1: Initial Implementation (7th-Order Model)
**Period:** Early October 2025

**Activities:**
- Created `build_per_topology_matrices.m` with symbolic 7×7 matrices
- Implemented `phase3_avg_linearize.m` for averaging and linearization
- Generated Version 1 presentation

**State of Understanding:**
- Assumed simplified model with "main" inductors only
- L5, L6 treated as part of conduction path, not independent states
- Capacitors incorrectly assumed to reduce via some unspecified mechanism

**Status:** Functional but incomplete model

---

### Phase 2: Schematic Deep-Dive (Discovery Phase)
**Period:** Mid-October 2025

**Key Activities:**
1. Obtained and analyzed Vinukumar conference paper PDF
2. Extracted circuit schematic JPEG
3. Traced current paths for all 4 modes in positive and negative half-cycles
4. Identified component roles and connections

**Major Discoveries:**
- 6 inductors ALL participate in energy storage/transfer
- L5, L6 are not "just wires"—they have significant di/dt during switching
- Cross-connected topology differs from standard SEPIC

**Triggered Major Revision:** Recognition that 7th-order model is insufficient

---

### Phase 3: Model Reconstruction (9th-Order Transition)
**Period:** Late October 2025

**Activities:**
1. Updated presentation to declare 9th-order system (Version 3)
2. Expanded state vector to include iL5, iL6
3. Began rewriting per-topology equations

**Challenges Encountered:**
- L5/L6 equations initially had sign errors
- Topology 11 incorrectly showed L5/L6 charging (should be isolated)
- Needed to carefully trace which inductors are active in each mode

---

### Phase 4: Final Corrections (Version 4 - Current)
**Period:** October 29, 2025

**Final Corrections Applied:**

**Per-Topology Equations (Slide 7):**
- ✅ Topology 11: Set diL5/dt = 0, diL6/dt = 0 (D7, D8 reverse-biased)
- ✅ Topology 10: diL5/dt = 0 (not in path), diL6/dt = -vCo/L6 (delivering)
- ✅ Topology 01: diL5/dt = -vCo/L5 (delivering), diL6/dt = 0 (not in path)
- ✅ Topology 00: Both L5 and L6 active (both delivering to bus)

**Consistency Checks:**
- ✅ All 9 states present in every topology equation set
- ✅ Signs consistent with current flow directions
- ✅ CPL term -P/(C0·vCo) present in bus equation for all topologies
- ✅ Variable naming: vCo (not mixed with vbus), C0 (not mixed with Co/Cbus)

**Presentation Polish:**
- ✅ Added comprehensive modeling assumptions slide
- ✅ Clarified s = sign(Vin) usage with highlighted box
- ✅ Added duty cycle weights visualization with timing diagrams
- ✅ Explained B_d derivation with step-by-step chain rule
- ✅ Emphasized 9th-order significance throughout

---

## Outstanding Work (Not Yet in Files)

### 1. MATLAB Scripts Update to 9th-Order
**Required Changes:**
- Expand state vector in `build_per_topology_matrices.m` to 9 elements
- Add L5, L6 symbolic variables
- Rewrite all 4 topology matrices as 9×9
- Include L5, L6 in B_in vectors where appropriate

**New Structure:**
```matlab
% State: x = [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vCo]'
syms L1 L2 L3 L4 L5 L6 C12 C34 C0 real
```

### 2. Experimental Validation Data
**Missing:**
- Hardware prototype measurements
- Component values from actual design
- Measured transfer functions
- Transient response captures

**Needed For:**
- Model validation
- Parameter identification
- Real-world stability verification

### 3. Negative Half-Cycle Equations
**Current Status:**
- Only positive half-cycle equations explicitly written
- Negative half-cycle implied through s = -1 usage

**Enhancement:**
- Could add explicit negative half-cycle equation set
- Would show L3, L4 active (L1, L2 inactive)
- Demonstrate s variable application

---

## Summary of Document Relationships

```
VINUKUMAR-LUCKOSE-ICCE2022-corrected - V2.pdf
    ↓ (provides)
Circuit Topology & Component Count
    ↓ (informs)
build_per_topology_matrices.m
    ↓ (generates)
Symbolic A_k and B_in,k matrices
    ↓ (used by)
phase3_avg_linearize.m
    ↓ (performs)
Averaging → Linearization → Transfer Functions
    ↓ (documented in)
Mathematical_Model_v4.pdf (16-slide presentation)
```

**Information Flow:**
1. Paper provides circuit topology and operating modes
2. MATLAB scripts implement mathematical modeling
3. Presentation documents complete derivation for supervisor review
4. Corrections flow back to update all documents for consistency

---

## Files Not Yet Created (Recommended)

### 1. `build_9th_order_matrices.m`
**Purpose:** Correct 9th-order per-topology matrix generation
**Status:** Needed (current `build_per_topology_matrices.m` is 7th-order)

### 2. `phase3_9th_order_complete.m`
**Purpose:** Full implementation for 9th-order system
**Status:** Needed (current `phase3_avg_linearize.m` is 7th-order)

### 3. `validate_model_vs_paper.m`
**Purpose:** Compare derived equations against paper's modes
**Status:** Recommended for verification

### 4. `parameter_identification.m`
**Purpose:** Extract component values from experimental data
**Status:** Needed for real hardware

### 5. `discrete_controller_design.m`
**Purpose:** Convert continuous-time PI to discrete for microcontroller
**Status:** Needed for implementation

### 6. `SEPIC_Model_Validation_Report.md`
**Purpose:** Document all verification steps and results
**Status:** Recommended for thesis documentation

---

## Conclusion

This documentation captures the complete journey of understanding and modeling the novel interleaved bridgeless SEPIC PFC converter proposed by Ts. Vinukumar Luckose. The project evolved from an initial 7th-order simplification to the correct 9th-order full-physics model through careful circuit analysis and equation verification.

**Current State:**
- ✅ Correct understanding of circuit topology
- ✅ Verified per-topology state equations (9th-order)
- ✅ Comprehensive presentation ready for supervisor review
- ⏳ MATLAB implementation awaits update to 9th-order
- ⏳ Experimental validation pending hardware prototype

**Key Takeaway:**
"The devil is in the details. What appeared to be a standard dual-SEPIC topology revealed itself as a novel cross-connected variant requiring careful analysis. The distinction between 7th and 9th order is not academic—it determines whether the model captures all significant energy storage dynamics, especially those of the output-side inductors L5 and L6."

---

**Document Version:** 1.0  
**Last Updated:** October 29, 2025  
**Maintained By:** FYP Project Team  
**For:** Ts. Vinukumar Luckose, Project Supervisor
