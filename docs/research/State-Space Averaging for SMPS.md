

# **A Comprehensive Analysis of State-Space Averaging in Switched-Mode Power Supplies: Derivation, Modulation, and Foundational Principles**

## **The Foundational Challenge of SMPS Modeling**

### **1.1 The Nature of Switched-Mode Converters**

Switched-Mode Power Supplies (SMPS) are a foundational technology in modern electronics, yet their analysis presents a significant theoretical challenge. By their very nature, SMPS are nonlinear, time-varying systems.1 Their operation relies on the high-frequency action of semiconductor switches (e.g., MOSFETs, diodes) that intentionally alter the circuit's topology multiple times within a single switching period ($T\_s$).2

During one part of the cycle (e.g., the switch is "ON"), the converter is described by one set of linear differential equations. In the next part of the cycle (e.g., the switch is "OFF"), it is described by a *different* set of linear differential equations. This periodic switching between linear topologies makes the overall system behavior nonlinear and time-variant. As a result, the powerful and familiar tools of classical Linear Time-Invariant (LTI) system analysis—such as the Laplace transform, Bode plots, and pole-zero analysis—cannot be directly applied to the converter's complete, switched-level model.

### **1.2 The Need for Dynamic Modeling**

While simple steady-state analyses, such as the inductor volt-second balance principle 4, are sufficient for calculating DC conversion ratios (e.g., $V\_{out} \= D \\cdot V\_{in}$ for an ideal buck converter), they provide no information about the converter's dynamic behavior. This dynamic response—how the converter reacts to a sudden change in load current or a fluctuation in the input voltage—is critical for robust real-world performance.

To design a stable feedback control loop, a dynamic *small-signal* model is essential.1 Control engineers must have a linear model to analyze the system's gain and phase margins, predict its response to transients, and ensure stability across all operating conditions.7 Before the mid-1970s, a significant gap existed in the field.8 Designers were faced with a choice: either use highly accurate but mathematically unwieldy discrete-time models, or use oversimplified "circuit averaging" techniques that lacked a rigorous mathematical foundation and could not be generalized. The field required a method that offered the generality of a state-space approach while yielding the intuitive, practical utility of a linear circuit model.8

## **The Seminal Contribution: Middlebrook and Cuk's Unified Approach**

### **2.1 The Foundational Paper**

This gap was definitively bridged in 1976 by Dr. R. D. Middlebrook and his student Slobodan Cuk at the California Institute of Technology. Their paper, presented at the IEEE Power Electronics Specialists Conference (PESC), was titled: **"A general unified approach to modelling switching-converter power stages"**.8

This work introduced the formal, systematic method of **"state-space averaged modelling"**.8 Instead of averaging individual component waveforms, Middlebrook and Cuk applied the averaging technique directly to the state-space matrices of the switched circuit topologies. This rigorous mathematical approach successfully bridged the gap between complex state-space analysis and practical, averaged modeling, offering the advantages of both.8

### **2.2 The Canonical Circuit Model**

A primary and profound outcome of the state-space averaging (SSA) technique was the development of a **"new canonical circuit model"**.8 This represented a significant conceptual leap in power electronics. Middlebrook and Cuk demonstrated that the complex, low-frequency dynamics of *any* Pulse-Width Modulated (PWM) DC-DC converter—regardless of its specific topology (buck, boost, buck-boost, or even novel configurations)—could be accurately represented by a *single, fixed-topology equivalent circuit*.8

This canonical model contains all the essential input-output and control properties of the converter.10 A new converter topology could now be characterized simply by calculating a set of parameters for this universal model. This breakthrough was a powerful enabler for computer-aided design (CAD) and optimization.10 A database could be populated with the canonical model parameters for various converters, allowing engineers to systematically analyze and compare different designs.10

Furthermore, the model was predictive. It was the first to formally demonstrate that the switching action itself introduces new, previously unmodeled zeros and poles into the converter's transfer functions (specifically, the duty-ratio-to-output transfer function).10 This explained dynamic behaviors that had been observed experimentally but were not predicted by simpler models, such as the right-half-plane zero in the boost and buck-boost converters.16

The concept of this unification is illustrated in Table 1, showing how different converters are simply different parameter sets for one universal model.

**Table 1: Conceptual Canonical Model Characterization**

| Converter Topology | Effective Filter Transfer Function He​(s) | Duty-Cycle Modulation Term Em​(s) | Input Voltage Modulation Term Vm​(s) |
| :---- | :---- | :---- | :---- |
| Buck | $H\_{buck}(s)$ | $E\_{buck}(s)$ | $V\_{buck}(s)$ |
| Boost | $H\_{boost}(s)$ | $E\_{boost}(s)$ | $V\_{boost}(s)$ |
| Buck-Boost | $H\_{buck-boost}(s)$ | $E\_{buck-boost}(s)$ | $V\_{buck-boost}(s)$ |

## **Mathematical Derivation of the Nonlinear Averaged Model**

The derivation of the state-space averaged model is a systematic, multi-step process that transforms the switched, nonlinear system into a single, continuous-time model.

### **3.1 Step 1: Establishing the State-Space**

The derivation begins by identifying the converter's **state variables**. These are the physical quantities whose values cannot change instantaneously and which collectively describe the energy stored in the system. For a typical SMPS, the state variables are the inductor currents ($i\_L$) and the capacitor voltages ($v\_C$).17 These are assembled into a state vector, $x(t)$.

Additionally, an input vector, $u(t)$, is defined to contain the independent sources (like the input voltage $v\_g$), and an output vector, $y(t)$, is defined for the variables of interest (like the output voltage $v\_o$).

### **3.2 Step 2: Modeling the Switched Topologies (Sub-intervals)**

A PWM converter operating in Continuous Conduction Mode (CCM) can be described by two distinct circuit topologies, or "states," corresponding to the ON and OFF states of the main switch.3

For each state, the circuit is composed only of linear components (R, L, C) and sources. Therefore, it can be described by a standard LTI state-space representation.17

Interval 1 (Switch ON, duration $dT\_s$):  
The circuit dynamics are described by:

$$\\dot{x} \= A\_1 x \+ B\_1 u$$  
$$y \= C\_1 x \+ E\_1 u$$  
Interval 2 (Switch OFF, duration $(1-d)T\_s$ or $d'T\_s$):  
The circuit dynamics change to a new topology, described by:

$$\\dot{x} \= A\_2 x \+ B\_2 u$$  
$$y \= C\_2 x \+ E\_2 u$$  
Here, $A\_1$ and $A\_2$ are the state matrices, $B\_1$ and $B\_2$ are the input matrices, $C\_1$ and $C\_2$ are the output matrices, and $E\_1$ and $E\_2$ are the feed-forward matrices for each sub-interval.21

### **3.3 Step 3: The Averaging Process**

This step is the central postulate of the SSA technique. It rests on a critical assumption: the switching frequency ($f\_s \= 1/T\_s$) is assumed to be *much higher* than the highest natural frequency of the converter's RLC network.23 This is known as the **"small ripple approximation"**.18 This assumption implies that the state variables (inductor currents and capacitor voltages) do not change significantly within a single switching cycle, so their high-frequency ripple is small compared to their DC component.

Under this assumption, the average rate of change of the state vector over one full cycle $T\_s$ can be approximated as the weighted average of the rates of change from each sub-interval.17

The average state derivative $\\dot{x}\_{avg}$ is:

$$\\dot{x}\_{avg} \= \\frac{1}{T\_s} \\int\_0^{T\_s} \\dot{x}(t) dt \= \\frac{1}{T\_s} \\left$$  
Because the interval $T\_s$ is so short (due to the high-frequency assumption), we can approximate $x(t)$ and $u(t)$ as being constant within the cycle ($x(t) \\approx x\_{avg}$ and $u(t) \\approx u\_{avg}$). The equation simplifies to a simple weighted average:

$$\\dot{x} \\approx (A\_1 x \+ B\_1 u) \\cdot d \+ (A\_2 x \+ B\_2 u) \\cdot (1-d)$$  
By collecting terms, we arrive at the final **Nonlinear Averaged Model**, where $d$ is now treated as a continuous, time-varying function $d(t)$ that represents the instantaneous duty cycle:

State Equation:

$$\\dot{x} \= \[A\_1 d(t) \+ A\_2 (1-d(t))\] x \+ u$$  
Output Equation:

$$y \= \[C\_1 d(t) \+ C\_2 (1-d(t))\] x \+ \[E\_1 d(t) \+ E\_2 (1-d(t))\] u$$  
This model 22 is now continuous-time, which has eliminated the switching action. However, it is fundamentally **nonlinear**. It contains product terms of time-varying quantities, such as $d(t) \\cdot x(t)$ and $d(t) \\cdot u(t)$. This model is highly effective for large-signal simulations 26 but cannot be used for frequency-domain analysis.

## **Linearization via Small-Signal Perturbation**

To create a linear model suitable for control design, the nonlinear averaged model must be linearized around a quiescent (DC) operating point. This is achieved through small-signal perturbation analysis.7

### **4.1 Step 4: Perturbation Analysis**

We assume that the converter is operating at a stable, steady-state DC point and we will only analyze its response to *small* AC perturbations around this point. Each variable in the model is represented as the sum of a large-signal DC component (uppercase letter) and a small-signal AC perturbation (lowercase letter with a hat, $\\hat{}$, or tilde, $\\tilde{}$) 22:

* State vector: $x(t) \= X \+ \\hat{x}(t)$  
* Input vector: $u(t) \= U \+ \\hat{u}(t)$  
* Control input: $d(t) \= D \+ \\hat{d}(t)$  
* Output vector: $y(t) \= Y \+ \\hat{y}(t)$

### **4.2 Step 5: Substitution and Linearization**

These perturbed variables are substituted back into the nonlinear averaged state equation from Section 3.3 22:

$$\\frac{d}{dt}(X \+ \\hat{x}) \= (X+\\hat{x}) \+ (U+\\hat{u})$$  
This complex equation is then expanded. For example, the product term $A\_1 d(t) x(t)$ becomes:  
$$ A\_1 (D+\\hat{d}) (X+\\hat{x}) \= \\underbrace{A\_1 D X}{\\text{DC Term}} \+ \\underbrace{A\_1 D \\hat{x}}{\\text{AC Term}} \+ \\underbrace{A\_1 \\hat{d} X}{\\text{AC Term}} \+ \\underbrace{A\_1 \\hat{d} \\hat{x}}{\\text{2nd-Order AC Term}} $$  
This is the key linearization step. The term $A\_1 \\hat{d} \\hat{x}$ is a product of two small-signal AC quantities, and its magnitude is considered negligible compared to the first-order AC and DC terms. This and all other "second-order" AC product terms are eliminated.17 This is the mathematical embodiment of the "small-signal" assumption.

### **4.3 Separation of DC and AC Equations**

After expanding all terms and discarding the second-order AC products, the single equation is separated into two distinct, simpler equations based on the order of the terms.17

1\. The DC (Steady-State) Model (0th-Order Terms):  
By gathering all DC terms and noting that in steady-state the state vector is constant ($\\dot{X} \= 0$), we get:

$$0 \= X \+ U$$  
$$Y \= X \+ U$$

This is a set of algebraic equations that defines the converter's DC operating point (the values of $X$, $Y$, and $U$ for a given $D$).22  
2\. The AC (Small-Signal) Model (1st-Order Terms):  
By gathering all first-order AC terms and noting $\\frac{d}{dt}(X+\\hat{x}) \= \\dot{\\hat{x}}$ (since $X$ is constant), we get the dynamic model:

$$\\dot{\\hat{x}} \= \\hat{x} \+ \\hat{u} \+ \\hat{d}$$  
$$\\hat{y} \= \\hat{x} \+ \\hat{u} \+ \[(C\_1-C\_2)X \+ (E\_1-E\_2)U\] \\hat{d}$$

### **4.4 The Final Linearized AC Model (LTI Form)**

This AC model is now a true Linear Time-Invariant (LTI) system. It can be written in the standard compact state-space form 32:

$$\\dot{\\hat{x}} \= A \\hat{x} \+ B \\hat{u} \+ E \\hat{d}$$  
$$\\hat{y} \= C \\hat{x} \+ F \\hat{u} \+ G \\hat{d}$$  
Where the new, averaged system matrices are composed of the DC operating point values (which are constants):

* $A \= A\_1 D \+ A\_2 (1-D)$ (Averaged state matrix)  
* $B \= B\_1 D \+ B\_2 (1-D)$ (Averaged input matrix)  
* $C \= C\_1 D \+ C\_2 (1-D)$ (Averaged output matrix)  
* $F \= E\_1 D \+ E\_2 (1-D)$ (Averaged feed-forward matrix)  
* $E \= (A\_1 \- A\_2) X \+ (B\_1 \- B\_2) U$ (Duty cycle to state modulation matrix)  
* $G \= (C\_1 \- C\_2) X \+ (E\_1 \- E\_2) U$ (Duty cycle to output modulation matrix)

This is the ultimate goal of the derivation. The "duty cycle modulation" $\\hat{d}(t)$ now appears as an independent *control input* to the linear system. Its influence on the system dynamics is mathematically captured by the $E$ and $G$ matrices.32 This final LTI model unlocks the full suite of classical control theory for frequency-domain analysis and controller design.5

The complete process is summarized in Table 2\.

**Table 2: Summary of the State-Space Averaging Derivation Process**

| Stage of Model | Generic Mathematical Form | Purpose / Significance |
| :---- | :---- | :---- |
| 1\. Switched Model | $\\dot{x} \= A\_i x \+ B\_i u$ | Models one linear topology (e.g., switch ON). Not LTI. |
| 2\. Nonlinear Averaged Model | $\\dot{x} \= \[A\_1 d \+ A\_2 d'\]x \+ \\dots$ | Combines topologies into one continuous *nonlinear* model. |
| 3\. Perturbation | $x \= X \+ \\hat{x}$, $d \= D \+ \\hat{d}$ | Separates DC operating point from AC dynamics. |
| 4\. DC Steady-State Model | $0 \= AX \+ BU$ | A set of algebraic equations to solve for the DC operating point. |
| 5\. AC Small-Signal Model | $\\dot{\\hat{x}} \= A\\hat{x} \+ B\\hat{u} \+ E\\hat{d}$ | The final LTI model, suitable for transfer function derivation and control loop design. |

## **Dynamic Analysis and Transfer Function Derivation**

### **5.1 Applying the Laplace Transform**

With the LTI small-signal model from Section 4.4, we can now apply the Laplace transform ($s$-domain) to analyze the converter's frequency response.19 The time-domain equations:

$$\\dot{\\hat{x}} \= A\\hat{x} \+ B\\hat{u} \+ E\\hat{d}$$  
$$\\hat{y} \= C\\hat{x} \+ F\\hat{u} \+ G\\hat{d}$$  
...become the $s$-domain algebraic equations:

$$s\\hat{x}(s) \= A\\hat{x}(s) \+ B\\hat{u}(s) \+ E\\hat{d}(s)$$  
$$\\hat{y}(s) \= C\\hat{x}(s) \+ F\\hat{u}(s) \+ G\\hat{d}(s)$$

### **5.2 Solving the General Model**

First, we solve the state equation for the state vector response $\\hat{x}(s)$:

$$sI\\hat{x}(s) \- A\\hat{x}(s) \= B\\hat{u}(s) \+ E\\hat{d}(s)$$  
$$(sI \- A)\\hat{x}(s) \= B\\hat{u}(s) \+ E\\hat{d}(s)$$  
$$\\hat{x}(s) \= (sI \- A)^{-1}$$  
Where $I$ is the identity matrix. Next, this expression for $\\hat{x}(s)$ is substituted into the output equation:

$$\\hat{y}(s) \= C (sI \- A)^{-1} \+ F\\hat{u}(s) \+ G\\hat{d}(s)$$

### **5.3 Derivation 1: Control-to-Output Transfer Function ($G\_{vd}(s)$)**

The **control-to-output transfer function**, often labeled $G\_{vd}(s)$, models the **duty cycle modulation**.31 It describes the dynamic relationship from the control input ($\\hat{d}$) to the system output ($\\hat{y}$, typically $\\hat{v}\_o$). This is the most critical transfer function for designing the voltage feedback compensator.6

To find $G\_{vd}(s)$, we set all other AC inputs (like $\\hat{u}(s)$) to zero, per the principle of superposition 31, and find the ratio $\\hat{y}(s) / \\hat{d}(s)$:

$$\\mathbf{G\_{vd}(s)} \= \\frac{\\hat{y}(s)}{\\hat{d}(s)} \\Bigg|\_{\\hat{u}=0} \= \\mathbf{C(sI \- A)^{-1}E \+ G}$$  
This final matrix equation provides the complete small-signal dynamic response from the controller to the output.22

### **5.4 Derivation 2: Input-to-Output Transfer Function / Audio-Susceptibility ($G\_{vg}(s)$)**

This transfer function describes how perturbations on the input source ($\\hat{u}$, typically $\\hat{v}\_g$) "feed through" to the output ($\\hat{y}$). This characteristic is formally known as **audio-susceptibility** or line-to-output transfer function.34 It is a key performance metric that quantifies the regulator's ability to *reject* input voltage ripple and noise.34 A lower gain is desirable.

To find $G\_{vg}(s)$, we set the control input $\\hat{d}(s)$ to zero 31 and find the ratio $\\hat{y}(s) / \\hat{u}(s)$:

$$\\mathbf{G\_{vg}(s)} \= \\frac{\\hat{y}(s)}{\\hat{u}(s)} \\Bigg|\_{\\hat{d}=0} \= \\mathbf{C(sI \- A)^{-1}B \+ F}$$  
The SSA methodology elegantly provides both of these crucial transfer functions from a single, unified derivation.22 This allows for a complete analysis of the converter's open-loop dynamics, enabling the design of a closed-loop controller that not only is stable (based on $G\_{vd}$) but also provides good line rejection (based on $G\_{vg}$).

## **Case Study: Complete SSA Derivation for the Buck Converter (CCM)**

To demonstrate the practical application of the method, we will apply the complete 5-step derivation to an ideal buck converter operating in Continuous Conduction Mode (CCM).6

### **6.1 Step 1: State and I/O Variables**

* State Vector: $x \= \\begin{bmatrix} i\_L \\\\ v\_C \\end{bmatrix}$ (Inductor current $i\_L$, Capacitor voltage $v\_C$)  
* Input Vector: $u \= \[v\_g\]$ (Input voltage $v\_g$)  
* Output Vector: $y \= \[v\_C\]$ (Output voltage $v\_C$)

### **6.2 Step 2: Switched-State Matrices**

Interval 1 (Switch ON, $0 \< t \< dT\_s$):  
The input $v\_g$ is connected to the inductor.

* Kirchhoff's Laws: $L\\frac{di\_L}{dt} \= v\_g \- v\_C$ and $C\\frac{dv\_C}{dt} \= i\_L \- \\frac{v\_C}{R}$  
* Matrices: $A\_1 \= \\begin{bmatrix} 0 & \-1/L \\\\ 1/C & \-1/RC \\end{bmatrix}$, $B\_1 \= \\begin{bmatrix} 1/L \\\\ 0 \\end{bmatrix}$, $C\_1 \= \\begin{bmatrix} 0 & 1 \\end{bmatrix}$, $E\_1 \= $

Interval 2 (Switch OFF, $dT\_s \< t \< T\_s$):  
The diode conducts, and the inductor is connected to ground.

* Kirchhoff's Laws: $L\\frac{di\_L}{dt} \= \-v\_C$ and $C\\frac{dv\_C}{dt} \= i\_L \- \\frac{v\_C}{R}$  
* Matrices: $A\_2 \= \\begin{bmatrix} 0 & \-1/L \\\\ 1/C & \-1/RC \\end{bmatrix}$, $B\_2 \= \\begin{bmatrix} 0 \\\\ 0 \\end{bmatrix}$, $C\_2 \= \\begin{bmatrix} 0 & 1 \\end{bmatrix}$, $E\_2 \= $

### **6.3 Step 3 & 4.1: Averaged Matrices and DC Solution**

* $A \= A\_1 D \+ A\_2 (1-D) \= \\begin{bmatrix} 0 & \-1/L \\\\ 1/C & \-1/RC \\end{bmatrix}$ (Note: $A\_1 \= A\_2$)  
* $B \= B\_1 D \+ B\_2 (1-D) \= \\begin{bmatrix} D/L \\\\ 0 \\end{bmatrix}$  
* $C \= C\_1 D \+ C\_2 (1-D) \= \\begin{bmatrix} 0 & 1 \\end{bmatrix}$  
* $F \= E\_1 D \+ E\_2 (1-D) \= $  
* $G \= (C\_1 \- C\_2)X \+ (E\_1 \- E\_2)U \= $

DC Solution (from $0 \= AX \+ BU$):  
$$ 0 \= \\begin{bmatrix} 0 & \-1/L \\ 1/C & \-1/RC \\end{bmatrix} \\begin{bmatrix} I\_L \\ V\_C \\end{bmatrix} \+ \\begin{bmatrix} D/L \\ 0 \\end{bmatrix} \[V\_g\] $$  
Solving the first row: $0 \= (-1/L)V\_C \+ (D/L)V\_g \\implies V\_C \= D V\_g$.  
Solving the second row: $0 \= (1/C)I\_L \- (1/RC)V\_C \\implies I\_L \= V\_C/R \= D V\_g / R$.  
The DC state vector is $X \= \\begin{bmatrix} DV\_g/R \\\\ DV\_g \\end{bmatrix}$. This confirms the well-known DC transfer ratio.

### **6.4 Step 4.2: Deriving the $E$ Matrix (Modulation Term)**

* $E \= (A\_1 \- A\_2) X \+ (B\_1 \- B\_2) U$  
* $A\_1 \- A\_2 \= \\begin{bmatrix} 0 & 0 \\\\ 0 & 0 \\end{bmatrix}$ (The zero matrix)  
* $B\_1 \- B\_2 \= \\begin{bmatrix} 1/L \\\\ 0 \\end{bmatrix}$  
* $U \= V\_g$  
* $E \= \\left( \\begin{bmatrix} 0 & 0 \\\\ 0 & 0 \\end{bmatrix} \\begin{bmatrix} I\_L \\\\ V\_C \\end{bmatrix} \\right) \+ \\left( \\begin{bmatrix} 1/L \\\\ 0 \\end{bmatrix} V\_g \\right) \= \\begin{bmatrix} V\_g/L \\\\ 0 \\end{bmatrix}$

### **6.5 Step 5: Deriving the Transfer Functions**

The final AC model is $\\dot{\\hat{x}} \= A\\hat{x} \+ B\\hat{u} \+ E\\hat{d}$ and $\\hat{y} \= C\\hat{x}$.

Control-to-Output ($G\_{vd}(s)$):

$$G\_{vd}(s) \= C(sI \- A)^{-1}E$$

$$ (sI \- A) \= \\begin{bmatrix} s & 0 \\ 0 & s \\end{bmatrix} \- \\begin{bmatrix} 0 & \-1/L \\ 1/C & \-1/RC \\end{bmatrix} \= \\begin{bmatrix} s & 1/L \\ \-1/C & s+1/RC \\end{bmatrix} $$  
The determinant is $\\Delta(s) \= s(s+1/RC) \+ 1/LC \= s^2 \+ \\frac{1}{RC}s \+ \\frac{1}{LC}$.  
The inverse is $(sI \- A)^{-1} \= \\frac{1}{\\Delta(s)} \\begin{bmatrix} s+1/RC & \-1/L \\\\ 1/C & s \\end{bmatrix}$.  
Now, we solve for $G\_{vd}(s)$:  
$$ G\_{vd}(s) \= \\frac{1}{\\Delta(s)} \\begin{bmatrix} 0 & 1 \\end{bmatrix} \\begin{bmatrix} s+1/RC & \-1/L \\ 1/C & s \\end{bmatrix} \\begin{bmatrix} V\_g/L \\ 0 \\end{bmatrix} $$  
$$ G\_{vd}(s) \= \\frac{1}{\\Delta(s)} \\begin{bmatrix} 1/C & s \\end{bmatrix} \\begin{bmatrix} V\_g/L \\ 0 \\end{bmatrix} \= \\frac{V\_g / LC}{\\Delta(s)} $$$$ \\mathbf{G\_{vd}(s)} \= V\_g \\left( \\frac{1}{1 \+ \\frac{L}{R}s \+ LCs^2} \\right)$$  
This result 38 is the classic 2nd-order low-pass filter response, where the DC gain of the control-to-output transfer function is the input voltage $V\_g$.  
Input-to-Output ($G\_{vg}(s)$):

$$G\_{vg}(s) \= C(sI \- A)^{-1}B$$

$$ G\_{vg}(s) \= \\frac{1}{\\Delta(s)} \\begin{bmatrix} 0 & 1 \\end{bmatrix} \\begin{bmatrix} s+1/RC & \-1/L \\ 1/C & s \\end{bmatrix} \\begin{bmatrix} D/L \\ 0 \\end{bmatrix} $$  
$$ G\_{vg}(s) \= \\frac{1}{\\Delta(s)} \\begin{bmatrix} 1/C & s \\end{bmatrix} \\begin{bmatrix} D/L \\ 0 \\end{bmatrix} \= \\frac{D / LC}{\\Delta(s)} $$$$ \\mathbf{G\_{vg}(s)} \= D \\left( \\frac{1}{1 \+ \\frac{L}{R}s \+ LCs^2} \\right)$$  
This shows the audio-susceptibility has the same 2nd-order filter dynamic, with a DC gain equal to the duty cycle $D$. The complete set of matrices for this case study is summarized in Table 3\.  
**Table 3: Buck Converter (Ideal, CCM) SSA Case Study Matrices**

| Matrix | Value |
| :---- | :---- |
| $x$ | $\\begin{bmatrix} i\_L \\\\ v\_C \\end{bmatrix}$ |
| $A\_1$, $A\_2$, $A$ | $\\begin{bmatrix} 0 & \-1/L \\\\ 1/C & \-1/RC \\end{bmatrix}$ |
| $B\_1$ | $\\begin{bmatrix} 1/L \\\\ 0 \\end{bmatrix}$ |
| $B\_2$ | $\\begin{bmatrix} 0 \\\\ 0 \\end{bmatrix}$ |
| $B$ | $\\begin{bmatrix} D/L \\\\ 0 \\end{bmatrix}$ |
| $C$ | $\\begin{bmatrix} 0 & 1 \\end{bmatrix}$ |
| $E$ | $\\begin{bmatrix} V\_g/L \\\\ 0 \\end{bmatrix}$ |
| $X$ | $\\begin{bmatrix} DV\_g/R \\\\ DV\_g \\end{bmatrix}$ |
| $G\_{vd}(s)$ | $V\_g \\left( \\frac{1}{1 \+ s(L/R) \+ s^2LC} \\right)$ |
| $G\_{vg}(s)$ | $D \\left( \\frac{1}{1 \+ s(L/R) \+ s^2LC} \\right)$ |

## **Critical Assumptions, Limitations, and Model Validity**

Despite its power and utility, the state-space averaging method is an *approximation*. Its validity is constrained by several critical assumptions.

### **7.1 The "Small Ripple Approximation" (SRA)**

The foundational assumption of SSA is the Small Ripple Approximation.4 This posits that the switching ripple in inductor currents and capacitor voltages is small compared to their DC components. This is not merely an issue of magnitude; this assumption is what justifies replacing the integral of a time-varying state variable $x(t)$ with the simple product of its average value $X$ and the sub-interval time (e.g., $dT\_s$).

This assumption fails completely in Discontinuous Conduction Mode (DCM), where the inductor current ripple is, by definition, 100% (it starts at zero and returns to zero in every cycle). Because the SRA is violated, the standard SSA derivation is not valid for DCM, and different modeling techniques are required.41

### **7.2 Frequency Domain Limitations**

The most significant practical limitation of SSA is its frequency range of validity.23 The model is, by its very design, a *low-frequency approximation*. The averaging process explicitly filters out all information related to the switching frequency itself.

The resulting small-signal model is only accurate for modulation frequencies ($f\_{mod}$, the frequency of $\\hat{d}$) that are *much lower* than the switching frequency ($f\_s$). A common rule of thumb is that the model is valid for frequencies up to one-tenth to one-fifth of the switching frequency ($f\_{mod} \\le f\_s/10$).23

SSA *cannot* predict or model:

* Switching ripple waveforms or magnitude.  
* EMI/EMC behavior, which is governed by high-frequency harmonics.  
* Any dynamic phenomena that occur *at or near* the switching frequency.

This last point is critical. SSA cannot predict the sub-harmonic oscillation (an instability at $f\_s/2$) that is characteristic of current-mode control. For such phenomena, more advanced models are required, such as the sampled-data models or the specific models for current-programmed control.42

### **7.3 Inapplicability to Other Converter Types**

The state-space averaging technique, as derived, is specifically for Pulse-Width Modulated (PWM) converters operating at a fixed frequency. It is not directly applicable to other converter types, such as resonant or quasi-resonant converters, which rely on zero-voltage or zero-current switching, or hysteretic controllers, which do not have a fixed switching frequency.

## **Legacy and Modern Perspectives**

### **8.1 Enduring Legacy**

The 1976 Middlebrook and Cuk paper transformed SMPS design from a "black art" into a rigorous, analyzable engineering discipline.5 The contribution of SSA was not just *a* model, but a *systematic, general-purpose methodology*.43 It gave engineers the first reliable tool to design and stabilize feedback loops based on classical control theory.

To this day, state-space averaging remains the foundational technique taught in all introductory and advanced power electronics curricula.42 It continues to be the "workhorse" model for the first-order design and analysis of analog control loops for PWM converters operating in CCM.

### **8.2 Modern Extensions**

To overcome the inherent limitations of SSA, more advanced modeling techniques have been developed, often building on its conceptual foundation.

* **Generalized State-Space Averaging (GSSA):** This technique, also known as multi-frequency averaging, extends the SSA concept. Instead of averaging to a DC value, it uses a Fourier series expansion to represent the state variables.1 This allows the model to capture the behavior of the fundamental component and its harmonics, extending the model's accuracy to higher frequencies.  
* **Sampled-Data Models:** These models abandon the continuous-time approximation altogether. They treat the converter as a discrete-time system, which is sampled once per switching cycle.2 This approach is inherently more accurate, does not rely on the small-ripple assumption, and is valid for frequencies up to and beyond the Nyquist frequency ($f\_s/2$).46 It is particularly well-suited for modeling the dynamics of digitally controlled power converters.

In conclusion, the state-space averaging technique remains the indispensable "DC and low-frequency AC" model for power converters. For high-frequency dynamics, harmonic analysis, or digital control, it serves as the conceptual baseline from which more complex and accurate models are built.

#### **Works cited**

1. Comprehensive GSSA and D-Q frame dynamic modeling of dual-active-bridge DC-DC converters \- AIMS Press, accessed October 29, 2025, [https://www.aimspress.com/article/doi/10.3934/electreng.2025014?viewType=HTML](https://www.aimspress.com/article/doi/10.3934/electreng.2025014?viewType=HTML)  
2. Exact Modeling of Time-Interval-Modulated Switched Networks \- PDXScholar, accessed October 29, 2025, [https://pdxscholar.library.pdx.edu/cgi/viewcontent.cgi?article=5693\&context=open\_access\_etds](https://pdxscholar.library.pdx.edu/cgi/viewcontent.cgi?article=5693&context=open_access_etds)  
3. Multifrequency Averaging in Power Electronic Systems \- UKnowledge, accessed October 29, 2025, [https://uknowledge.uky.edu/context/ece\_etds/article/1062/viewcontent/Dissertation.pdf](https://uknowledge.uky.edu/context/ece_etds/article/1062/viewcontent/Dissertation.pdf)  
4. Fundamentals of Power Electronics, accessed October 29, 2025, [https://fmipa.umri.ac.id/wp-content/uploads/2016/03/R.\_Erickson\_Fundamentals\_of\_Power\_Electronics\_pBookZZ.org\_.pdf](https://fmipa.umri.ac.id/wp-content/uploads/2016/03/R._Erickson_Fundamentals_of_Power_Electronics_pBookZZ.org_.pdf)  
5. Concepts and Variables with State-Space and Canonical Models \- Technical Articles, accessed October 29, 2025, [https://www.allaboutcircuits.com/technical-articles/concepts-and-variables-with-state-space-and-canonical-models/](https://www.allaboutcircuits.com/technical-articles/concepts-and-variables-with-state-space-and-canonical-models/)  
6. Modelling and Control of a Buck Converter Using State-Space Averaging and Classical Feedback Techniques \- arXiv, accessed October 29, 2025, [https://arxiv.org/pdf/2507.09115](https://arxiv.org/pdf/2507.09115)  
7. Power Electronics \- KorAcademy, accessed October 29, 2025, [https://koracademy.com/sites/default/files/inline-files/Power%20Electronics%2CDaniel%20W.%20Hart.pdf](https://koracademy.com/sites/default/files/inline-files/Power%20Electronics%2CDaniel%20W.%20Hart.pdf)  
8. A General Unified Approach To Modelling Switching-Converter Power Stages \- Scribd, accessed October 29, 2025, [https://www.scribd.com/document/385029858/A-General-Unified-Approach-to-Modelling-Switching-converter-Power-Stages](https://www.scribd.com/document/385029858/A-General-Unified-Approach-to-Modelling-Switching-converter-Power-Stages)  
9. A GENERAL UNIFIED APPROACH TO ... \- Mikrocontroller.net, accessed October 29, 2025, [https://www.mikrocontroller.net/attachment/124600/SSA\_Cuk\_Middlebrook.pdf](https://www.mikrocontroller.net/attachment/124600/SSA_Cuk_Middlebrook.pdf)  
10. R.D. MIDDLEBROOK, S. CUK, "A general unified approach to modelling switching converter power stages", IEEE Power Electronic Specialists Conference, 1976, pp. 18-34. \- Thierry LEQUEU, accessed October 29, 2025, [https://www.thierry-lequeu.fr/data/ART270.HTM](https://www.thierry-lequeu.fr/data/ART270.HTM)  
11. A general unified approach to modelling switching-converter power stages \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/336049492\_A\_general\_unified\_approach\_to\_modelling\_switching-converter\_power\_stages](https://www.researchgate.net/publication/336049492_A_general_unified_approach_to_modelling_switching-converter_power_stages)  
12. Analysis Of Power Electronic Converters Using The Generalized State-space Averaging Approach \- Circuits and Systems I, accessed October 29, 2025, [https://pearl.shanghaitech.edu.cn/teaching/2023fall/EE270/Lectures/paper\_gssa2.pdf](https://pearl.shanghaitech.edu.cn/teaching/2023fall/EE270/Lectures/paper_gssa2.pdf)  
13. Middlebrook, Robert David \- Library Feeds \- Caltech, accessed October 29, 2025, [https://feeds.library.caltech.edu/people/Middlebrook-R-D/combined.html](https://feeds.library.caltech.edu/people/Middlebrook-R-D/combined.html)  
14. Use of the State-Space Averaging Technique in Fast Steady-State Simulation Algorithms for Switching Power Converters \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/221280036\_Use\_of\_the\_State-Space\_Averaging\_Technique\_in\_Fast\_Steady-State\_Simulation\_Algorithms\_for\_Switching\_Power\_Converters](https://www.researchgate.net/publication/221280036_Use_of_the_State-Space_Averaging_Technique_in_Fast_Steady-State_Simulation_Algorithms_for_Switching_Power_Converters)  
15. A general unified approach to modelling switching-converter power stages, accessed October 29, 2025, [https://www.semanticscholar.org/paper/A-general-unified-approach-to-modelling-power-Middlebrook-Cuk/e72e24b89fc03dd12a1983919cee0b7c5fde11c0](https://www.semanticscholar.org/paper/A-general-unified-approach-to-modelling-power-Middlebrook-Cuk/e72e24b89fc03dd12a1983919cee0b7c5fde11c0)  
16. State-Space Average modelling of converters with parasitics and storage-time modulation \- SciSpace, accessed October 29, 2025, [https://scispace.com/pdf/state-space-average-modelling-of-converters-with-parasitics-2dx6nmp05o.pdf](https://scispace.com/pdf/state-space-average-modelling-of-converters-with-parasitics-2dx6nmp05o.pdf)  
17. State Space Averaging | PDF | Electrical Network ... \- Scribd, accessed October 29, 2025, [https://www.scribd.com/presentation/296271231/State-Space-Averaging](https://www.scribd.com/presentation/296271231/State-Space-Averaging)  
18. DC-DC Power Converters, accessed October 29, 2025, [https://www.eng.auburn.edu/\~agrawvd/COURSE/READING/LOWP/Erikson\_DC\_2\_DC.pdf](https://www.eng.auburn.edu/~agrawvd/COURSE/READING/LOWP/Erikson_DC_2_DC.pdf)  
19. State-space average Modeling of DC-DC Converters with parasitic in Discontinuous Conduction Mode (DCM). Prof. S. Samanta \- CORE, accessed October 29, 2025, [https://core.ac.uk/download/pdf/53187372.pdf](https://core.ac.uk/download/pdf/53187372.pdf)  
20. Small Signal Modelling of a Buck Converter using State Space Averaging for Magnet Load \- Paper Publications, accessed October 29, 2025, [https://www.paperpublications.org/upload/book/Small%20Signal%20Modelling-783.pdf](https://www.paperpublications.org/upload/book/Small%20Signal%20Modelling-783.pdf)  
21. Synthesis of averaged circuit models for switched power converters, accessed October 29, 2025, [http://power.eecs.berkeley.edu/publications/sanders\_verghese\_synthesis.pdf](http://power.eecs.berkeley.edu/publications/sanders_verghese_synthesis.pdf)  
22. AN-1489 Techniques of State Space Modeling \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/an/snva171/snva171.pdf](https://www.ti.com/lit/an/snva171/snva171.pdf)  
23. (PDF) State-Space Averaging (SSA) revisited: On the accuracy of ..., accessed October 29, 2025, [https://www.researchgate.net/publication/228742320\_State-Space\_Averaging\_SSA\_revisited\_On\_the\_accuracy\_of\_SSA-Based\_line-to-output\_frequency\_responses\_of\_switched\_DC-DC\_converters](https://www.researchgate.net/publication/228742320_State-Space_Averaging_SSA_revisited_On_the_accuracy_of_SSA-Based_line-to-output_frequency_responses_of_switched_DC-DC_converters)  
24. Buck Converter \- Output Voltage Ripple \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/566558/buck-converter-output-voltage-ripple](https://electronics.stackexchange.com/questions/566558/buck-converter-output-voltage-ripple)  
25. Course Material on Switched Mode Power Conversion \- EE | IISc, accessed October 29, 2025, [https://ee.iisc.ac.in/wp-content/uploads/2023/01/SMPC\_VRamnarayanan.pdf](https://ee.iisc.ac.in/wp-content/uploads/2023/01/SMPC_VRamnarayanan.pdf)  
26. Switch-Mode Power Supplies : Spice Simulations and Practical Designs, accessed October 29, 2025, [https://miamioh.ecampus.com/switchmode-power-supplies-spice/bk/9780071508582](https://miamioh.ecampus.com/switchmode-power-supplies-spice/bk/9780071508582)  
27. DIGITAL CONTROL OF HIGH-FREQUENCY SWITCHED-MODE POWER CONVERTERS, accessed October 29, 2025, [https://picture.iczhiku.com/resource/eetop/sYKtshUYRLjhKCvn.pdf](https://picture.iczhiku.com/resource/eetop/sYKtshUYRLjhKCvn.pdf)  
28. First Course on Power Electronics, accessed October 29, 2025, [http://103.203.175.90:81/fdScript/RootOfEBooks/E%20Book%20collection%20-%202020%20-%20A/ECE/PowerElectronicsAFirstCoursebyMohan-1.pdf](http://103.203.175.90:81/fdScript/RootOfEBooks/E%20Book%20collection%20-%202020%20-%20A/ECE/PowerElectronicsAFirstCoursebyMohan-1.pdf)  
29. Power Electronics A First Course (for \- \-): Simulations and Laboratory Implementations \- konkur.in, accessed October 29, 2025, [https://dl.konkur.in/2025/04/Implementations2023-\[www.konkur.in\].pdf](https://dl.konkur.in/2025/04/Implementations2023-[www.konkur.in].pdf)  
30. Review of Small-Signal Modeling Methods Including Frequency-Coupling Dynamics of Power Converters \- Aalborg Universitets forskningsportal, accessed October 29, 2025, [https://vbn.aau.dk/files/306353873/08410450.pdf](https://vbn.aau.dk/files/306353873/08410450.pdf)  
31. State Space Average Modeling, Small Signal Analysis, and Control ..., accessed October 29, 2025, [https://www.mdpi.com/2079-9292/13/16/3264](https://www.mdpi.com/2079-9292/13/16/3264)  
32. Chapter 7\. AC Equivalent Circuit Modeling, accessed October 29, 2025, [https://www.ieee.li/pdf/introduction\_to\_power\_electronics/chapter\_07.pdf](https://www.ieee.li/pdf/introduction_to_power_electronics/chapter_07.pdf)  
33. Topic 3 Feedback in the Fast Lane – Modeling Current-Mode Control in High-Frequency Converters \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/download/trng/docs/seminar/Topic3BL.pdf](https://www.ti.com/download/trng/docs/seminar/Topic3BL.pdf)  
34. input filter \- NASA Technical Reports Server (NTRS), accessed October 29, 2025, [https://ntrs.nasa.gov/api/citations/19840008391/downloads/19840008391.pdf](https://ntrs.nasa.gov/api/citations/19840008391/downloads/19840008391.pdf)  
35. COLLEGE ENGINEERING VIRGINIA POLYTECHNIC INSTITUTE STATE UNIVERSITY \- NASA Technical Reports Server (NTRS), accessed October 29, 2025, [https://ntrs.nasa.gov/api/citations/19840016907/downloads/19840016907.pdf](https://ntrs.nasa.gov/api/citations/19840016907/downloads/19840016907.pdf)  
36. Improved Models for DC-DC Converters Johansson, Bengt, accessed October 29, 2025, [https://lucris.lub.lu.se/ws/files/5717458/587911.pdf](https://lucris.lub.lu.se/ws/files/5717458/587911.pdf)  
37. Equivalent Circuit Model for Current Mode Controls and Its Extensions \- VTechWorks, accessed October 29, 2025, [https://vtechworks.lib.vt.edu/bitstream/handle/10919/50485/Yan\_Y\_D\_2013.pdf](https://vtechworks.lib.vt.edu/bitstream/handle/10919/50485/Yan_Y_D_2013.pdf)  
38. Power electronics \-state-space average modeling technique, accessed October 29, 2025, [http://dnxy.yzu.edu.cn/\_\_local/9/E0/7D/F53321EC8EC5B8A7D47AD55C391\_DDAE8977\_425F2.pdf?e=.pdf](http://dnxy.yzu.edu.cn/__local/9/E0/7D/F53321EC8EC5B8A7D47AD55C391_DDAE8977_425F2.pdf?e=.pdf)  
39. continuous-time averaged modeling of dc–dc converters \- COPYRIGHTED MATERIAL, accessed October 29, 2025, [https://catalogimages.wiley.com/images/db/pdf/9781118935101.excerpt.pdf](https://catalogimages.wiley.com/images/db/pdf/9781118935101.excerpt.pdf)  
40. Fundamentals of Power Electronics \- Tayloredge, accessed October 29, 2025, [https://tayloredge.com/reference/Electronics/PowerSupplies/SwitcherSlides.pdf](https://tayloredge.com/reference/Electronics/PowerSupplies/SwitcherSlides.pdf)  
41. Modified input-to-output and control-to-output transfer functions of a non-ideal buck converter working in discontinuous conduction mode, accessed October 29, 2025, [https://journals.pan.pl/Content/133388/PDF/11\_5k.pdf?handler=pdf](https://journals.pan.pl/Content/133388/PDF/11_5k.pdf?handler=pdf)  
42. Fundamentals of Power Electronics \- Robert W. Erickson, Dragan Maksimović \- Google Books, accessed October 29, 2025, [https://books.google.com/books?id=nhrxDwAAQBAJ\&printsec=copyright](https://books.google.com/books?id=nhrxDwAAQBAJ&printsec=copyright)  
43. State-Space Averaged Modeling of a Nonideal Boost Converter. \- Akamai University, accessed October 29, 2025, [https://www.akamai.university/uploads/1/2/7/7/127725089/pjst9\_2\_302.pdf](https://www.akamai.university/uploads/1/2/7/7/127725089/pjst9_2_302.pdf)  
44. Textbook | Prof. Robert Erickson | University of Colorado Boulder, accessed October 29, 2025, [https://www.colorado.edu/faculty/erickson/textbook](https://www.colorado.edu/faculty/erickson/textbook)  
45. Fundamentals of Power Electronics by Robert W. Erickson | Goodreads, accessed October 29, 2025, [https://www.goodreads.com/book/show/1607143.Fundamentals\_of\_Power\_Electronics](https://www.goodreads.com/book/show/1607143.Fundamentals_of_Power_Electronics)  
46. Accurate Small-Signal Modeling of Digitally Controlled Buck Converters with ADC-PWM Synchronization \- arXiv, accessed October 29, 2025, [https://arxiv.org/html/2510.00943v2](https://arxiv.org/html/2510.00943v2)