

# **The Destabilizing Effects of Constant Power Loads in DC Systems: Modeling, Linearization, and Advanced Stability Analysis**

**Abstract:** This report provides an exhaustive analysis of the phenomena associated with Constant Power Loads (CPLs) in DC microgrids and distributed power systems. It establishes the standard definition and mathematical origin of the CPL, deriving its characteristic Negative Incremental Resistance (NIR). The report details the system-level destabilizing effects, including negative damping, interaction with filter impedance, and the mechanisms of voltage oscillation and collapse, substantiated with numerical examples from authoritative literature. A rigorous treatment of CPL linearization for small-signal modeling is presented, including the derivation of the CPL's contribution to the system Jacobian matrix. Finally, the report provides a comprehensive survey of stability analysis methodologies, contrasting the limitations of linear (impedance-based) methods like the Middlebrook and Nyquist criteria against the necessities and applications of nonlinear, large-signal stability (LSS) techniques, including Lyapunov's Direct Method, the Mixed Potential Function (MPF), and the Basin of Attraction (BoA).

## **I. The Constant Power Load (CPL): Definition, Modeling, and Characteristics**

This section formally defines the Constant Power Load (CPL), not as a discrete physical component, but as a system-level behavior characteristic of modern power electronic-based loads. Its fundamental nonlinear model and the critical concept of negative incremental resistance are derived.

### **A. Conceptual and Standard Definitions of CPLs in DC Systems**

A Constant Power Load (CPL) is a load that draws a constant amount of power ($P$) from its source, regardless of variations in the source voltage ($V$).1 This is not a fundamental component, such as a resistor or capacitor, but rather a *behavioral model* that describes the input characteristic of a specific class of loads.2

This CPL behavior is a direct and often unconsidered consequence of the tightly-regulated, high-gain, and wide-bandwidth power electronic converters (PECs) that interface modern loads to the DC bus.1 This behavior originates in two primary ways:

1. **DC-DC Converters:** A Point-of-Load (POL) converter, such as a buck converter, is designed to provide a tightly regulated, constant output voltage ($V\_o$) to its load (e.g., a microprocessor).1 If this load is resistive ($R\_L$), it consumes a constant output power $P\_{out} \= V\_o^2 / R\_L$. Assuming high converter efficiency, the input power $P\_{in}$ must equal $P\_{out}$, and is therefore also constant.1  
2. **DC-AC Inverters:** In systems like all-electric ships or electric vehicles, a DC-AC inverter may drive an AC motor (e.g., for propulsion).5 If the motor is controlled to maintain a constant speed ($\\omega$) against a constant torque ($T$), the mechanical power $P\_{mech} \= T\\omega$ is constant. This power is reflected back to the inverter's DC input terminals, causing the inverter to appear to the DC bus as a CPL.5

The CPL behavior is, therefore, an artifact of *good* control design. The destabilizing effect is created by the very feedback loops intended to provide high-quality, stable power to the end load.1 As described in 1, if a change occurs in the source voltage, the load converter's controller will adjust its duty cycle to regulate its output voltage, which forces the input current to change in the opposite direction of the input voltage to maintain constant power. This "fighting" response is the source of the instability. This also implies that the CPL behavior is frequency-dependent and exists primarily within the bandwidth of the load converter's control loop.1

The "negative impedance instability" problem associated with these CPLs was first formally defined in the context of cascaded converter stability in a seminal 1976 paper by Dr. R. David Middlebrook.6

### **B. The Nonlinear V-I Characteristic and Fundamental Mathematical Model**

The fundamental mathematical relationship defining an ideal CPL is:

$$P\_{in} \= V \\cdot I \= P\_0 \= \\text{const}$$

where $V$ and $I$ are the input voltage and current of the load converter, and $P\_0$ is the constant power consumed.1  
This relationship can be algebraically rearranged to express the current as a function of voltage:

$$I \= \\frac{P\_0}{V}$$

This defines a hyperbolic curve in the V-I plane, as illustrated in.2 This hyperbolic relationship is inherently nonlinear. This nonlinearity is the primary reason why standard linear circuit analysis is insufficient to fully describe the system and why CPLs can induce complex behaviors such as multiple equilibria (stable and unstable) and limit cycle oscillations.1

### **C. The Phenomenon of Negative Incremental Resistance (NIR)**

The most critical characteristic of a CPL is its Negative Incremental Resistance (NIR), also referred to as Incremental Negative Resistance (INR).1 This is the *dynamic* or *small-signal* resistance of the load, which describes how the load's current responds to small changes in voltage.

#### **1\. Mathematical Derivation**

The NIR is derived by analyzing the CPL's response to small perturbations around a steady-state DC operating point $(V\_0, I\_0)$.

1. Start with the constant power equation: $P(v, i) \= v \\cdot i \= P\_0$.1  
2. Take the total differential of this equation. Since $P\_0$ is constant, its differential is zero:

   $$\\partial P(v, i) \= \\frac{\\partial P}{\\partial v}dv \+ \\frac{\\partial P}{\\partial i}di \= 0$$  
   1  
3. Calculating the partial derivatives yields: $i \\cdot dv \+ v \\cdot di \= 0$.1  
4. The *incremental resistance*, $r\_{in}$, is defined as the ratio of the differential change in voltage to the differential change in current: $r\_{in} \= dv/di$.10  
5. Rearranging the differential equation from step 3:

   $$i \\cdot dv \= \-v \\cdot di \\implies \\frac{dv}{di} \= \-\\frac{v}{i}$$  
   1  
6. Evaluating this dynamic resistance at the DC operating point $(V\_0, I\_0)$, we find the small-signal resistance:

   $$r\_{in} \= \- \\frac{V\_0}{I\_0}$$  
   1

Since $V\_0$ and $I\_0$ are both positive for a load consuming power, the incremental resistance $r\_{in}$ is *always negative*.1

#### **2\. Graphical Analysis of the CPL V-I Curve**

The V-I characteristic curve for a CPL, as shown in sources 2, graphically illustrates this property. The curve shows that as the load current $I$ increases, the terminal voltage $V$ *decreases*.8 The incremental resistance $r\_{in} \= dv/di$ is the *slope* of this V-I curve at the operating point. A visual inspection of this hyperbola confirms that its slope is always negative.1

#### **3\. Distinction: Incremental (Dynamic) vs. Static Resistance**

This reveals a critical distinction that is a common source of confusion.

* **Static Resistance (DC):** $R\_{static} \= V\_0 / I\_0$. This is the ratio of the DC voltage to the DC current at the operating point. Since the CPL *consumes* power, $V\_0$ and $I\_0$ are positive, and $R\_{static}$ is *always positive*.1  
* **Incremental Resistance (Dynamic/AC):** $r\_{in} \= dv/di \= \-V\_0 / I\_0$. This describes the system's *response* to a small change. It is *always negative*.1

A CPL is therefore a passive load that *consumes* power ($R\_{static} \> 0$) but *responds* to perturbations as an *active* component ($r\_{in} \< 0$). This active, negative-resistance response is what injects energy into system resonances, destabilizing the system.

**Table 1: Glossary of Standard Terminology**

| Term | Definition | Authoritative Source(s) |
| :---- | :---- | :---- |
| **CPL** | **Constant Power Load:** A load that draws a constant amount of power ($P=VI$) from its source, typically a behavior of tightly controlled power electronic converters. | 1 |
| **NIR / INR** | **Negative Incremental Resistance:** The small-signal dynamic resistance of a CPL, $r\_{in} \= dv/di \= \-V\_0/I\_0$, which acts as a negative damping element. | 1 |
| **LSS** | **Large-Signal Stability:** The stability of a system under large disturbances, considering the full nonlinear system dynamics. | 13 |
| **BoA / RoA** | **Basin of Attraction / Region of Attraction:** The set of initial conditions (system states) from which a dynamical system will converge to a specific stable equilibrium point. | 16 |
| **MPF** | **Mixed Potential Function:** A scalar function derived from circuit topology (via Brayton-Moser theory) used to systematically construct a Lyapunov function for LSS analysis. | 14 |
| **CROA** | **Constraint Region of Attraction:** An LSS analysis framework that defines the BoA while also considering the physical (voltage, current, duty cycle) constraints of the system. | 19 |
| **Middlebrook Criterion** | An impedance-based stability criterion for cascaded systems, stating that stability is guaranteed if the source output impedance is significantly smaller than the load input impedance. | 7 |
| **GNC** | **Generalized Nyquist Criterion:** A frequency-domain stability criterion for linear systems, used for a precise (less conservative) assessment of the impedance ratio $Z\_S/Z\_L$. | 22 |

## **II. System-Level Destabilizing Effects of CPLs**

This section analyzes the system-level consequences of the NIR characteristic, moving from the concept of negative damping to the physical mechanisms of oscillation and voltage collapse.

### **A. The CPL as a Negative Damping Element**

In a standard RLC circuit, the resistance ($R$) provides positive damping by dissipating energy (as heat, $P \= I^2 R$), causing oscillations to decay over time. The CPL's Negative Incremental Resistance ($r\_{in} \< 0$) acts as a *negative* resistor. Instead of dissipating energy, this element *injects* energy into the system during transients. This "negative damping" 1 counteracts the natural passive damping provided by system components like line resistance and filter damping resistors.

From a control theory perspective, in an RLC circuit (such as a converter's input LC filter), the system poles are located at $s \= \-\\alpha \\pm \\sqrt{\\alpha^2 \- \\omega\_0^2}$, where $\\alpha \= R\_{total}/(2L)$ is the damping factor. If the total equivalent resistance $R\_{total} \= R\_{passive} \+ r\_{in}$ becomes negative (i.e., the CPL's negative resistance is larger in magnitude than the system's positive resistance), the damping factor $\\alpha$ becomes negative. This *moves the system poles* from the stable Left-Half Plane (LHP) to the unstable Right-Half Plane (RHP), causing any small oscillation to grow exponentially rather than decay.24

### **B. Interaction with Source Impedance and Input LC Filters**

Instability is not caused by the CPL in isolation. It is a system-level problem caused by the *interaction* between the CPL's negative input impedance ($Z\_L$) and the source's positive output impedance ($Z\_S$).1 In a DC microgrid, the "source" as seen by a CPL is typically an upstream source converter (e.g., a bus regulator) and its associated output LC filter.6

An LC filter is a second-order system with a natural resonant frequency. At or near this frequency, the filter's output impedance $Z\_S$ peaks. The CPL's input impedance $Z\_L \\approx r\_{in} \= \-V\_0/I\_0$ is negative. When the CPL's negative impedance interacts with the high positive impedance of the source filter at its resonance, the total system damping becomes negative. This "excites" the filter's natural resonance, causing the system to oscillate.1

### **C. Analysis of DC Bus Voltage Oscillation and Limit Cycles**

The primary and most common symptom of CPL-induced instability is the appearance of "unacceptably large voltage oscillations" on the DC bus.9 These oscillations increase stress on components and can lead to system-wide failure.1

In many cases, these oscillations do not grow to infinity (which would be predicted by a purely linear model with RHP poles). Instead, they settle into a stable, sustained, periodic oscillation of a fixed amplitude. This phenomenon is known as a *limit cycle*.1 The existence of limit cycles is a critical diagnostic observation. A purely linear system can only be stable (oscillations decay) or unstable (oscillations grow exponentially); it *cannot* produce a stable, fixed-amplitude oscillation. The fact that CPL systems exhibit limit cycles is definitive proof that the system is behaving nonlinearly. This means that linear analysis methods (covered in Section IV.A) are only valid for small-signal analysis and are *incapable* of predicting the final behavior (e.g., the amplitude or existence) of these limit cycles. This insight provides the primary justification for the nonlinear, Large-Signal Stability (LSS) analysis methods discussed in Section IV.B.

### **D. Mechanism of Voltage Collapse and High Inrush Current**

Voltage collapse is the catastrophic failure mode of a CPL-dominated system, where the DC bus voltage irreversibly drops to zero.1 This is caused by a positive feedback loop:

1. A system disturbance (e.g., a sudden increase in load) causes a small, initial *drop* in the DC bus voltage $V$.  
2. The CPL's high-gain control loop responds, attempting to maintain constant power $P\_0$. To do this, it *increases* its current draw $I \= P\_0 / V$.1  
3. This higher current $I$ is drawn from the source filter's bus capacitor $C$, causing the voltage $V$ to drop even *faster* (since $i\_C \= C \\cdot dv/dt$).  
4. This creates a self-reinforcing, "vicious" positive feedback loop: $V \\downarrow \\implies I \\uparrow \\implies V \\downarrow\\downarrow$.  
5. This cycle repeats, rapidly discharging the bus capacitor and causing the system voltage to "collapse" to the stable, but undesirable, equilibrium point at $V=0$.1

This same mechanism explains the "high inrush current" phenomenon observed during system startup.1 When the system is first energized, $V$ starts at or near zero. The CPL's controller, attempting to draw its set power $P\_0$, demands a theoretically infinite current ($I \= P\_0 / 0$). This results in a massive current spike that can damage components or trip protective devices.9

### **E. Case Study: Numerical Analysis of Instability**

A numerical example from the 2004 IEEE paper "The Instability Effect of Constant Power Loads" demonstrates a fundamental limit to CPL stability.24

* **System Parameters:**  
  * DC Source Voltage: 270 V  
  * Filter Inductance (L): $150 \\, \\mu H$  
  * Filter Capacitance ($C\_1$): $300 \\, \\mu F$  
* **Scenario 1 (High Power / Unstable):**  
  * CPL Power: $P\_0 \= 243 \\, kW$  
  * Resulting Small-Signal Resistance: $r\_{in} \= \-V\_0^2 / P\_0 \= \-(270^2) / 243000 \= \-0.3 \\, \\Omega$.24  
  * **Result:** The system poles are in the RHP. The analysis concludes that the system "remains unstable for all values of damping resistance".24  
* **Scenario 2 (Lower Power / Conditionally Stable):**  
  * CPL Power: $P\_0 \= 122 \\, kW$  
  * Resulting Small-Signal Resistance: $r\_{in} \= \-V\_0^2 / P\_0 \= \-(270^2) / 122000 \\approx \-0.6 \\, \\Omega$.24  
  * **Result:** The system *can* be stabilized by adding an appropriate passive damping resistor, which provides enough positive resistance to overcome the CPL's negative resistance and move the system poles back into the LHP.24

This numerical example reveals a critical principle: for any given source and filter design, there exists a *maximum CPL power ($P\_{max}$)* that the system can stably support. The system's passive damping (from line resistance, etc.) can overcome a small amount of negative damping from a low-power CPL. However, if $P\_{CPL} \> P\_{max}$, the net system damping ($R\_{passive} \+ r\_{in}$) becomes negative, and the system is unconditionally unstable. A primary goal of CPL stability analysis is therefore to calculate and enforce this "limit of CPL".17

## **III. Linearization and Small-Signal Modeling of CPL Systems**

This section details the mathematical process required to analyze the stability of the nonlinear CPL system using linear control tools. This involves *linearizing* the system around a steady-state equilibrium point.

### **A. Principles of State-Space Averaging and Jacobian Linearization**

Power electronic converters are switching systems, which makes them inherently time-varying and difficult to analyze.

1. State-Space Averaging (SSA): The SSA technique 29 is a standard method to create an approximate, time-invariant model that represents the average behavior of the system over one switching cycle. This process results in a nonlinear averaged state-space model of the form:

   $$\\dot{x} \= f(x, u)$$

   where $x$ is the vector of state variables (e.g., inductor currents, capacitor voltages) and $u$ is the vector of inputs (e.g., duty cycle).29  
2. **Linearization:** To analyze the stability *near* a specific DC operating point (equilibrium) $X\_0$, this nonlinear model is linearized using a first-order Taylor-series expansion.32  
3. Perturbation: Small-signal perturbation variables are defined as the deviation from the equilibrium point:

   $$\\hat{x}(t) \= x(t) \- X\_0$$  
   32  
4. Linearized Model: The dynamics of these small perturbations are described by the linear state equation:

   $$\\dot{\\hat{x}} \= A\\hat{x} \+ B\\hat{u}$$

   The matrix $A$ is the Jacobian matrix (or state matrix) 32, and $B$ is the input matrix, defined by the partial derivatives of $f$ evaluated at the equilibrium point:

   $$A \= J \= \\left\[ \\frac{\\partial f}{\\partial x} \\right\]\_{x=X\_0, u=U\_0} \\quad \\text{and} \\quad B \= \\left\[ \\frac{\\partial f}{\\partial u} \\right\]\_{x=X\_0, u=U\_0}$$  
   32

The *local* or *small-signal* stability of the equilibrium point $X\_0$ is then determined entirely by the *eigenvalues* of the Jacobian matrix $A$.37 If all eigenvalues of $A$ have negative real parts (i.e., are in the LHP), the equilibrium is small-signal stable.

### **B. Derivation: The Linearized Small-Signal Model of an Ideal CPL**

This derivation shows how the nonlinear CPL function $I\_{CPL} \= P\_0 / V\_C$ is converted into a linear, small-signal equivalent component for use in the state-space model.

* **Nonlinear Function:** The CPL current is a nonlinear function of the state variable $v\_C$: $i\_{CPL}(v\_C) \= P\_0 / v\_C$.  
* **Operating Point:** The DC operating point is $(V\_C, I\_{CPL})$, where $I\_{CPL} \= P\_0 / V\_C$.  
* Linearization (Taylor Expansion): We represent the total current $i\_{CPL}(t)$ and voltage $v\_C(t)$ as the sum of their DC and AC (small-signal) components:

  $$i\_{CPL}(t) \= I\_{CPL} \+ \\hat{i}\_{cpl}(t)$$  
  $$v\_C(t) \= V\_C \+ \\hat{v}\_c(t)$$

  The small-signal current $\\hat{i}\_{cpl}$ is the first-order term of the Taylor expansion:

  $$\\hat{i}\_{cpl} \\approx \\left\[ \\frac{d(i\_{CPL})}{dv\_C} \\right\]\_{v\_C=V\_C} \\cdot \\hat{v}\_c$$  
* Calculating the Derivative:

  $$\\frac{d}{dv\_C} \\left( \\frac{P\_0}{v\_C} \\right) \= \- \\frac{P\_0}{v\_C^2}$$  
* Small-Signal Model: Evaluating this derivative at the operating point $v\_C \= V\_C$ gives the linear model:

  $$\\hat{i}\_{cpl} \= \\left( \- \\frac{P\_0}{V\_C^2} \\right) \\hat{v}\_c$$  
  39  
* Alternative Form: Since the DC power is $P\_0 \= V\_C \\cdot I\_{CPL}$, this can be rewritten:

  $$\\hat{i}\_{cpl} \= \\left( \- \\frac{V\_C I\_{CPL}}{V\_C^2} \\right) \\hat{v}\_c \= \\left( \- \\frac{I\_{CPL}}{V\_C} \\right) \\hat{v}\_c$$

This derivation is critical. The equation $\\hat{i}\_{cpl} \= (-I\_{CPL}/V\_C) \\cdot \\hat{v}\_c$ has the familiar form of Ohm's law, $i \= G \\cdot v$. This proves that for small-signal analysis, the nonlinear CPL behaves *identically* to a linear component with a *negative conductance* $G\_{cpl} \= \-I\_{CPL}/V\_C$. The equivalent small-signal resistance is $r\_{in} \= 1/G\_{cpl} \= \-V\_C/I\_{CPL}$. This result rigorously confirms the NIR derivation from Section I.C.1 using a state-space linearization approach.1 The term $-P\_0/V\_C^2$ found in 39 is the *negative admittance* (or conductance) of the CPL.

### **C. Formulation of the System Jacobian Matrix for a CPL-Fed Converter**

This demonstrates how the linearized CPL term from (B) modifies the system's state matrix $A$.

* **Example System:** Consider a simplified DC bus model where a source current $i\_S$ feeds a bus capacitor $C$ and a CPL.  
* Nonlinear State Equation (KCL): The rate of change of the capacitor voltage (the state variable) is:

  $$\\dot{v}\_C \= \\frac{1}{C} i\_C \= \\frac{1}{C} (i\_S \- i\_{CPL}) \= \\frac{1}{C} (i\_S \- \\frac{P\_0}{v\_C})$$  
* **State Vector:** $x \= \[v\_C\]$.  
* **Nonlinear Function:** $f(x) \= \\frac{1}{C} (I\_S \- \\frac{P\_0}{v\_C})$ (assuming $i\_S$ is a constant DC input $I\_S$ for this example).  
* Jacobian Matrix (A): The Jacobian is a 1x1 matrix (a scalar):

  $$A \= J \= \\frac{df}{dv\_C} \= \\frac{1}{C} \\frac{d}{dv\_C} (I\_S \- P\_0 v\_C^{-1})$$  
  $$A \= \\frac{1}{C} (0 \- P\_0(-1)v\_C^{-2}) \= \\frac{P\_0}{C v\_C^2}$$  
* **Linearized System:** The linearized system is $\\dot{\\hat{v}}\_c \= A \\hat{v}\_c$, where $A \= \\frac{P\_0}{C V\_C^2}$.  
* **Analysis:** The system's only eigenvalue is $\\lambda \= P\_0 / (C V\_C^2)$. Since $P\_0, C$, and $V\_C^2$ are all positive, the eigenvalue $\\lambda$ is *positive*. A positive eigenvalue signifies an unstable equilibrium point.1 This simple model confirms that a CPL connected directly to an ideal capacitor is inherently unstable.

### **D. Implications of the CPL Term on System Eigenvalues**

In a more realistic system, such as a source converter with an LC filter feeding the CPL, the state vector is $x \= \[i\_L, v\_C\]^T$, where $i\_L$ is the filter inductor current and $v\_C$ is the bus capacitor voltage.

* **State Equations:**  
  1. $\\dot{i}\_L \= f\_1(i\_L, v\_C, v\_{in}, d)$ (from KVL on the inductor loop)  
  2. $\\dot{v}\_C \= f\_2 \= \\frac{1}{C}(i\_L \- i\_{CPL}) \= \\frac{1}{C}(i\_L \- P\_0/v\_C)$ (from KCL on the capacitor node)  
* Jacobian Formulation: The $2 \\times 2$ Jacobian matrix $A$ is:

  $$A \= \\begin{bmatrix} \\frac{\\partial f\_1}{\\partial i\_L} & \\frac{\\partial f\_1}{\\partial v\_C} \\\\ \\frac{\\partial f\_2}{\\partial i\_L} & \\frac{\\partial f\_2}{\\partial v\_C} \\end{bmatrix}\_{X\_0}$$  
* CPL Contribution: The CPL only affects the $A\_{22}$ term (the partial derivative of $\\dot{v}\_C$ with respect to $v\_C$):

  $$A\_{22} \= \\frac{\\partial f\_2}{\\partial v\_C} \= \\frac{1}{C} \\frac{\\partial}{\\partial v\_C} (i\_L \- P\_0/v\_C) \= \\frac{1}{C} (0 \- P\_0(-1)v\_C^{-2}) \= \\frac{P\_0}{C V\_C^2}$$

  The $A\_{21}$ term is simply $\\partial f\_2 / \\partial i\_L \= 1/C$.

  $$A \= \\begin{bmatrix} \\dots & \\dots \\\\ 1/C & \\frac{P\_0}{C V\_C^2} \\end{bmatrix}$$

This mathematical result is the "damping destroyer." The stability of the system is determined by the eigenvalues of $A$, which are found from the characteristic equation $\\lambda^2 \- \\text{Tr}(A)\\lambda \+ \\det(A) \= 0$. The damping of the system is directly related to the trace, $\\text{Tr}(A) \= A\_{11} \+ A\_{22}$. For a stable system, the trace (which is the sum of the eigenvalues) must be negative. The CPL contributes the term $A\_{22} \= P\_0 / (C V\_C^2)$, which is *always positive*. As the CPL power $P\_0$ increases, this positive term grows, making the total trace $\\text{Tr}(A)$ *less negative* and pushing it toward becoming positive. This is the precise mathematical mechanism by which the CPL acts as negative damping 1, eroding the system's stability margin and pushing its poles (eigenvalues) toward the unstable RHP.1

## **IV. Stability Analysis Methodologies for DC Systems with CPLs**

This section surveys the primary methods for analyzing CPL system stability, distinguishing between small-signal (linear) and large-signal (nonlinear) approaches.

### **A. Impedance-Based Stability Analysis (Small-Signal)**

This approach, rooted in classical control theory, models the system in the frequency domain. It assesses stability by comparing the source and load impedances at their point of connection.20

#### **1\. The Middlebrook Criterion: Source and Load Impedance Interaction**

This method originates from the foundational 1976 paper by R.D. Middlebrook.6

* **Concept:** The system is modeled as a source (or "feeder") with an output impedance $Z\_S(s)$ cascaded with a load (the CPL converter) with an input impedance $Z\_L(s)$.21  
* **The Criterion:** Middlebrook's stability criterion states that the cascaded system is *guaranteed* to be stable if the magnitude of the load's input impedance $|Z\_L(j\\omega)|$ is *always greater* than the magnitude of the source's output impedance $|Z\_S(j\\omega)|$ at all frequencies.21  
* **Practical Guideline:** A robust design rule is to ensure $|Z\_S(j\\omega)| \\ll |Z\_L(j\\omega)|$. A "good separation" of at least 10 dB (meaning $|Z\_L|$ is more than 3.16 times $|Z\_S|$) is often recommended to ensure a healthy stability margin.21 Instability becomes a high risk at frequencies where the impedance plots "overlap," typically where the source filter's impedance $Z\_S$ *peaks* at its resonance and the load's impedance $Z\_L$ is low.44

#### **2\. The Loop Gain Criterion ($T\_o \= Z\_S / Z\_L$)**

The ratio $T\_o(s) \= Z\_S(s) / Z\_L(s)$ is defined as the minor loop gain of the cascaded system.46 The Middlebrook criterion ($|Z\_S| \\ll |Z\_L|$) is a simplified version of the Nyquist criterion, which is a *sufficient* condition for stability. It states that if the magnitude of the loop gain $|T\_o(j\\omega)| \< 1$ for all frequencies, the system is stable.46

This criterion is well-known to be *conservative* (i.e., sufficient, but not necessary).46 A system *can* be stable even if $|T\_o| \> 1$ at some frequencies, but the Middlebrook criterion would fail it. It is a simple, robust design guide but can lead to over-design (e.g., excessive damping).40

#### **3\. Application of the Generalized Nyquist Criterion (GNC)**

The GNC provides an *exact* stability assessment for the linearized system and is less conservative than the simple Middlebrook magnitude criterion.22 It is the proper tool for analyzing the loop gain $T\_o(s)$.

* **Procedure:** The GNC is applied to the loop gain $T\_o(s) \= Z\_S(s) / Z\_L(s)$. The stability of the system is determined by the number of encirclements ($N$) of the critical point $(-1, j0)$ by the Nyquist plot of $T\_o(s)$.23  
* **Formula:** The stability is given by $Z \= P \- N$, where $Z$ is the number of RHP poles of the *closed-loop* system (instability), $P$ is the number of RHP poles of the *open-loop* function $T\_o(s)$ (which is 0 for a stable source and stable load, but non-zero if the CPL's RHP pole is included), and $N$ is the number of clockwise encirclements of \-1.  
* **Connection:** The Middlebrook criterion ($|T\_o| \< 1$) is equivalent to demanding that the Nyquist plot of $T\_o$ remains *inside the unit circle*.46 This guarantees $N=0$ and thus $Z=P$. The GNC, however, allows for stability even if $|T\_o| \> 1$, as long as the plot does not encircle the \-1 point in a destabilizing way.

### **B. Large-Signal Stability (LSS) Analysis (Nonlinear)**

#### **1\. Limitations of Linear Analysis**

Linear analysis methods (Jacobian eigenvalues, Middlebrook, Nyquist) are fundamentally *local*. They only guarantee stability for *infinitesimally small* disturbances around *one* specific operating point.15

These methods fail in several key areas:

* They *cannot* predict system behavior under *large* disturbances, such as load steps 14, source voltage sags, or system faults.  
* They *cannot* define the *size* of the stable operating region (i.e., how large a disturbance the system can tolerate).50  
* They *cannot* predict or analyze inherently *nonlinear* phenomena like the *limit cycles* discussed in Section II.C.1  
* Nonlinear CPL systems possess *multiple equilibrium points* 3—at minimum, one stable (the desired $V\_C$) and one unstable (voltage collapse at $V\_C=0$). Linear analysis only examines the stability of *one* of these points, failing to see the complete picture.

#### **2\. Lyapunov's Direct Method for Proving Stability**

Lyapunov's Direct Method is the most rigorous mathematical tool for proving the stability of nonlinear systems.52

* **Lyapunov Function $V(x)$:** The method relies on finding a scalar function $V(x)$, analogous to the total "energy" of the system, where $x$ is the state vector.52  
* **Stability Conditions:** If, in a region around an equilibrium $x\_e$, a function $V(x)$ can be found such that:  
  1. $V(x)$ is positive definite: $V(x\_e) \= 0$ and $V(x) \> 0$ for all $x \\neq x\_e$.  
  2. The time derivative $\\dot{V}(x) \= \\frac{\\partial V}{\\partial x} \\cdot f(x)$ is negative definite: $\\dot{V}(x) \< 0$ for all $x \\neq x\_e$.  
* ...then the equilibrium $x\_e$ is *asymptotically stable* in that region.52 A negative derivative means the system's "energy" is always dissipating, forcing all trajectories to return to the zero-energy state at $x\_e$.  
* **Challenge:** The primary difficulty of this method is that there is no systematic way to find a suitable $V(x)$ (a "Lyapunov function"). Its discovery is a non-trivial, creative task.14

#### **3\. The Basin of Attraction (BoA) as the "Secure Operation Region"**

* **Definition:** The *Basin of Attraction* (BoA), also called the *Region of Attraction* (RoA), is the set of *all* initial conditions (all states $x\_0$) for which the system's trajectory will successfully converge to the desired stable equilibrium point.16  
* **The "Stability Limit":** The *boundary* of the BoA separates states that lead to stability from states that lead to failure (e.g., convergence to the $V=0$ voltage collapse equilibrium).16  
* **Importance:** The *size of the BoA* is the *true* measure of a CPL system's robustness to large disturbances. A system can be "small-signal stable" (all eigenvalues in the LHP) but have a *tiny* BoA. A small load step could "kick" the system's state (e.g., the vector $\[i\_L, v\_C\]$) outside this tiny BoA, causing it to become unstable and converge to the $V=0$ equilibrium (voltage collapse), even though linear analysis predicted it was stable.50 Therefore, LSS analysis is not merely about *proving* stability, but about *quantifying* the BoA, which is the "secure operation region".50

#### **4\. Advanced LSS: The Mixed Potential Function (MPF) Method**

This is a specialized LSS technique for nonlinear circuits, derived from Brayton-Moser's mixed potential theory.18

* **Advantage:** It overcomes the main challenge of Lyapunov's method (finding $V(x)$). The MPF method is *constructive*: it uses the circuit's topology (KCL for capacitors, KVL for inductors) to *systematically build* a scalar function $P(i, v)$ (the Mixed Potential Function).14  
* **Relation to Lyapunov:** This $P(i, v)$ is then used to *derive* a related Lyapunov energy function $P^\*(i, v)$.14 By analyzing $P^\*$ and its derivative $dP^\*/dt$, one can derive the large-signal stability criteria and estimate the asymptotic stability region (BoA).14 It is praised for its "simplified modeling" and "clear physical meaning".14

#### **5\. Advanced LSS: The Constraint Region of Attraction (CROA)**

A significant limitation of traditional LSS analysis (Lyapunov, MPF) is that it often ignores real-world *physical limits*, making its results "over-optimistic".19 A theoretical BoA might include a state with an inductor current of 1000 A, but a real-world system would have long since tripped its overcurrent protection.

* **Solution (CROA):** The CROA is a more practical and "low-conservatism" LSS method. It *explicitly* incorporates the physical variable constraints of the system into the stability analysis, such as:  
  * Voltage limits ($V\_{min}, V\_{max}$)  
  * Current limits ($I\_{max}$)  
  * PWM duty cycle limits ($D\_{min}, D\_{max}$)  
* **Practical Utility:** The CROA is the *intersection* of the theoretical BoA (from Lyapunov) and the set of physically allowable states.19 This provides a designer with a *guaranteed, realistic* secure operating region that accounts for both nonlinear dynamics *and* physical saturation/protection limits, making it a far more powerful and trustworthy design tool.

**Table 2: Comparison of Stability Analysis Methodologies**

| Methodology | Domain | Model Type | Stability Assessed | Key Use Case & Limitations | Source(s) |
| :---- | :---- | :---- | :---- | :---- | :---- |
| **Jacobian Eigenvalue Analysis** | Time-Domain | Linearized (Small-Signal) State-Space | **Local** (Small-Signal) | **Use:** Pole-zero analysis, linear controller design. **Limit:** Valid *only* for small perturbations near one equilibrium. Cannot predict limit cycles or BoA. | 32 |
| **Impedance-Based (Middlebrook)** | Frequency-Domain | Linearized (Small-Signal) Impedance ($Z\_S, Z\_L$) | **Local** (Small-Signal) | **Use:** Filter design, stability of cascaded systems. **Limit:** Sufficient but not necessary (conservative). Valid only for small signals. | 7 |
| **Impedance-Based (Nyquist)** | Frequency-Domain | Linearized (Small-Signal) Impedance ($T\_o \= Z\_S/Z\_L$) | **Local** (Small-Signal) | **Use:** Exact, less conservative assessment of cascaded systems. **Limit:** Valid only for small signals. More complex to apply than Middlebrook. | 22 |
| **Lyapunov's Direct Method** | Time-Domain | Nonlinear State-Space | **Global or Local** (Large-Signal) | **Use:** Rigorous proof of LSS, estimation of BoA. **Limit:** Extremely difficult to find a Lyapunov function ($V(x)$) for complex systems. | 50 |
| **Mixed Potential Function (MPF)** | Time-Domain | Nonlinear Circuit Model (KCL/KVL) | **Global or Local** (Large-Signal) | **Use:** *Systematic construction* of a Lyapunov function for power electronics. **Limit:** Still mathematically complex; may ignore physical limits. | 14 |
| **Constraint Region of Attraction (CROA)** | Time-Domain | Nonlinear State-Space \+ Constraints | **Local** (Large-Signal) | **Use:** Provides a *practically* useful, non-conservative BoA by including physical limits (current, voltage). **Limit:** State-of-the-art; computationally intensive. | 19 |

## **V. Synthesis and Key Authoritative References**

This report has detailed the CPL from its definition as a control artifact to the advanced nonlinear methods required to ensure its stability. The following foundational textbooks and seminal papers, identified in the research, are essential for any expert-level study of this topic.

### **A. Foundational Textbooks**

* **Erickson, R.W. and Maksimovic, D., *Fundamentals of Power Electronics***  
  * **Significance:** This is the canonical, graduate-level textbook for the entire field of power electronics.57 Its 2nd (2001) and 3rd editions are standards. It provides the rigorous foundation for the *state-space averaging* 29 and *small-signal ac models* 59 that are the prerequisites for performing the Jacobian and impedance-based analyses discussed in this report.  
* **Dragicevic, T., Wheeler, P., and Blaabjerg, F. (Editors), *DC Distribution Systems and Microgrids*** (IET, 2018\)  
  * **Significance:** This text directly addresses the report's topic.3 Chapter 3, "Stability analysis and stabilization of DC microgrids," by Alexis Kwasinski, is a key resource. It explicitly discusses the CPL's nonlinear nature, the existence of an *unstable equilibrium point*, and the critical need for control to achieve stability.3

### **B. Seminal IEEE Papers and Standards Documents**

* **Middlebrook, R.D. (1976), "Input filter considerations in design and application of switching regulators."**  
  * **Citation:** IEEE Industry Applications Society Annual Meeting, Chicago, IL, October 1976, pp. 366-382.7  
  * **Significance:** This is the *most important seminal paper* for small-signal stability in this domain.6 It first defined the CPL problem in cascaded converters and established the impedance-based stability criterion (i.e., $|Z\_S| \\ll |Z\_L|$) that bears his name.21  
* **Emadi, A., Khaligh, A., Rivetta, C.H., et al. (2006), "Constant power loads and negative impedance instability in automotive systems: definition, modeling, stability, and control of power electronic converters and motor drives."**  
  * **Citation:** *IEEE Transactions on Vehicular Technology*, vol. 55, no. 4, pp. 1112-1125.28  
  * **Significance:** A highly-cited and comprehensive review paper that defines and models the CPL problem in the context of modern DC distributed power systems, such as those in "all-electric ships" 4, automotive systems, and aircraft.28  
* **Kwasinski, A. and Onwuchekwa, C.N. (2011), "Dynamic behavior and stabilization of DC microgrids with instantaneous constant-power loads."**  
  * **Citation:** *IEEE Transactions on Power Electronics*, vol. 26, no. 3, pp. 836-846 (approx.).38  
  * **Significance:** A key paper exploring the *dynamic* (large-signal) behavior and stabilization of DC microgrids, forming a critical bridge from the linear (Middlebrook) analysis to the modern nonlinear (LSS) analysis.  
* **Primary Journals:** The most authoritative, peer-reviewed research on this topic is consistently published in *IEEE Transactions on Power Electronics (TPEL)* 24 and *IEEE Transactions on Industrial Electronics (TIE)*.38

#### **Works cited**

1. Constant Power Loads (CPL) with Microgrids: Problem Definition ..., accessed October 29, 2025, [https://www.mdpi.com/1996-1073/10/10/1656](https://www.mdpi.com/1996-1073/10/10/1656)  
2. Constant Power Loads (CPL) with Microgrids: Problem Definition, Stability Analysis and Compensation Techniques \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/319631561\_Constant\_Power\_Loads\_CPL\_with\_Microgrids\_Problem\_Definition\_Stability\_Analysis\_and\_Compensation\_Techniques](https://www.researchgate.net/publication/319631561_Constant_Power_Loads_CPL_with_Microgrids_Problem_Definition_Stability_Analysis_and_Compensation_Techniques)  
3. DC Distribution Systems and Microgrids | IET Digital Library, accessed October 29, 2025, [https://digital-library.theiet.org/doi/book/10.1049/pbpo115e](https://digital-library.theiet.org/doi/book/10.1049/pbpo115e)  
4. Constant Power Load Instability Mitigation in DC Shipboard Power Systems Using Negative Series Virtual Inductor Method \- Aalborg Universitets forskningsportal, accessed October 29, 2025, [https://vbn.aau.dk/files/265887483/IECON\_NSVI.pdf](https://vbn.aau.dk/files/265887483/IECON_NSVI.pdf)  
5. DC Shipboard Microgrids with Constant Power Loads A Review of Advanced Nonlinear Control Strategies and Stabilization Techniques \- Aalborg Universitets forskningsportal, accessed October 29, 2025, [https://vbn.aau.dk/files/532538299/DC\_Shipboard\_Microgrids\_with\_Constant\_Power\_Loads\_A\_Review\_of\_Advanced\_Nonlinear\_Control\_Strategies\_and\_Stabilization\_Techniques.pdf](https://vbn.aau.dk/files/532538299/DC_Shipboard_Microgrids_with_Constant_Power_Loads_A_Review_of_Advanced_Nonlinear_Control_Strategies_and_Stabilization_Techniques.pdf)  
6. Constant Power Loads in DC Microgrids: A Review of Modern Nonlinear Control Approaches and Stabilisation Techniques \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/375157609\_Constant\_Power\_Loads\_in\_DC\_Microgrids\_A\_Review\_of\_Modern\_Nonlinear\_Control\_Approaches\_and\_Stabilisation\_Techniques](https://www.researchgate.net/publication/375157609_Constant_Power_Loads_in_DC_Microgrids_A_Review_of_Modern_Nonlinear_Control_Approaches_and_Stabilisation_Techniques)  
7. Input filter considerations in design and application of switching ..., accessed October 29, 2025, [https://www.semanticscholar.org/paper/Input-filter-considerations-in-design-and-of-Middlebrook/22397996af080102703615bbf902bfbe48868300](https://www.semanticscholar.org/paper/Input-filter-considerations-in-design-and-of-Middlebrook/22397996af080102703615bbf902bfbe48868300)  
8. Negative impedance characteristic of CPL, the voltage decreases exponentially with increase in current \[6\]. \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/figure/Negative-impedance-characteristic-of-CPL-the-voltage-decreases-exponentially-with\_fig1\_323969184](https://www.researchgate.net/figure/Negative-impedance-characteristic-of-CPL-the-voltage-decreases-exponentially-with_fig1_323969184)  
9. Mitigation of Destabilizing Effect of CPLs in Island DC Microgrid using Nonlinear Control, accessed October 29, 2025, [https://www.researchgate.net/publication/309539688\_Mitigation\_of\_Destabilizing\_Effect\_of\_CPLs\_in\_Island\_DC\_Microgrid\_using\_Nonlinear\_Control](https://www.researchgate.net/publication/309539688_Mitigation_of_Destabilizing_Effect_of_CPLs_in_Island_DC_Microgrid_using_Nonlinear_Control)  
10. Is resistance the derivative dV/dI or the ratio V/I? \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/518522/is-resistance-the-derivative-dv-di-or-the-ratio-v-i](https://electronics.stackexchange.com/questions/518522/is-resistance-the-derivative-dv-di-or-the-ratio-v-i)  
11. (PDF) Constant Power Loads and Negative Impedance Instability in Automotive Systems: Definition, Modeling, Stability, and Control of Power Electronic Converters and Motor Drives \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/3156197\_Constant\_Power\_Loads\_and\_Negative\_Impedance\_Instability\_in\_Automotive\_Systems\_Definition\_Modeling\_Stability\_and\_Control\_of\_Power\_Electronic\_Converters\_and\_Motor\_Drives](https://www.researchgate.net/publication/3156197_Constant_Power_Loads_and_Negative_Impedance_Instability_in_Automotive_Systems_Definition_Modeling_Stability_and_Control_of_Power_Electronic_Converters_and_Motor_Drives)  
12. Incremental negative impedance behavior of a CPL. \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/figure/Incremental-negative-impedance-behavior-of-a-CPL\_fig4\_367989450](https://www.researchgate.net/figure/Incremental-negative-impedance-behavior-of-a-CPL_fig4_367989450)  
13. Large-Signal Stability Improvement of DC-DC Converters in DC Microgrid \- Aalborg University's Research Portal, accessed October 29, 2025, [https://vbn.aau.dk/en/publications/large-signal-stability-improvement-of-dc-dc-converters-in-dc-micr](https://vbn.aau.dk/en/publications/large-signal-stability-improvement-of-dc-dc-converters-in-dc-micr)  
14. Mixed-potential-function-based large-signal stability ... \- Frontiers, accessed October 29, 2025, [https://www.frontiersin.org/journals/energy-research/articles/10.3389/fenrg.2022.1052789/full](https://www.frontiersin.org/journals/energy-research/articles/10.3389/fenrg.2022.1052789/full)  
15. System-Level Large-Signal Stability Analysis of Droop-Controlled DC Microgrids \- Aalborg Universitets forskningsportal, accessed October 29, 2025, [https://vbn.aau.dk/files/475857902/System\_Level\_Large\_Signal\_Stability\_Analysis\_of\_Droop\_Controlled\_DC\_Microgrids.pdf](https://vbn.aau.dk/files/475857902/System_Level_Large_Signal_Stability_Analysis_of_Droop_Controlled_DC_Microgrids.pdf)  
16. Basin of attraction \- Scholarpedia, accessed October 29, 2025, [http://www.scholarpedia.org/article/Basin\_of\_attraction](http://www.scholarpedia.org/article/Basin_of_attraction)  
17. Large-Signal Stability Analysis for Islanded DC Microgrids with n+1 Parallel Energy-Storage Converters \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2079-9292/12/19/4032](https://www.mdpi.com/2079-9292/12/19/4032)  
18. Large Signal Stability Analysis of Hybrid AC/DC Microgrids When a Single-Phase-to-Ground Fault Occurs \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2079-9292/13/7/1232](https://www.mdpi.com/2079-9292/13/7/1232)  
19. A constraint region of attraction-based large-signal stability analysis ..., accessed October 29, 2025, [https://ira.lib.polyu.edu.hk/bitstream/10397/109881/1/1-s2.0-S0142061523008293-main.pdf](https://ira.lib.polyu.edu.hk/bitstream/10397/109881/1/1-s2.0-S0142061523008293-main.pdf)  
20. Stability Analysis of Buck Converter Based on Passivity-Based Stability Criterion \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2076-3417/14/5/1755](https://www.mdpi.com/2076-3417/14/5/1755)  
21. Practical Application of Middlebrook Filter Criteria \- Technical Articles \- EEPower, accessed October 29, 2025, [https://eepower.com/technical-articles/practical-application-of-middlebrooks-filter-criteria/](https://eepower.com/technical-articles/practical-application-of-middlebrooks-filter-criteria/)  
22. Stability Analysis of Power Converter-Based Constant Power Load With Reduced-Order Model \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/367397725\_Stability\_Analysis\_of\_Power\_Converter-Based\_Constant\_Power\_Load\_With\_Reduced-Order\_Model](https://www.researchgate.net/publication/367397725_Stability_Analysis_of_Power_Converter-Based_Constant_Power_Load_With_Reduced-Order_Model)  
23. Nyquist Stability Criterion and its Application to Power Electronic Systems \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/profile/Mohammad\_Amin7/publication/333003566\_Nyquist\_Stability\_Criterion\_and\_its\_Application\_to\_Power\_Electronics\_Systems/links/5cdac735299bf14d95956aab/Nyquist-Stability-Criterion-and-its-Application-to-Power-Electronics-Systems.pdf](https://www.researchgate.net/profile/Mohammad_Amin7/publication/333003566_Nyquist_Stability_Criterion_and_its_Application_to_Power_Electronics_Systems/links/5cdac735299bf14d95956aab/Nyquist-Stability-Criterion-and-its-Application-to-Power-Electronics-Systems.pdf)  
24. (PDF) The instability effect of constant power loads \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/4155560\_The\_instability\_effect\_of\_constant\_power\_loads](https://www.researchgate.net/publication/4155560_The_instability_effect_of_constant_power_loads)  
25. Modelling and Identification of Interaction Effects for Stability Analysis in LVDC Power Networks \- White Rose eTheses Online, accessed October 29, 2025, [https://etheses.whiterose.ac.uk/29465/1/Modelling%20and%20Identification%20of%20Interaction%20Effects%20for%20Stability%20Analysis%20in%20LVDC%20DPS.pdf](https://etheses.whiterose.ac.uk/29465/1/Modelling%20and%20Identification%20of%20Interaction%20Effects%20for%20Stability%20Analysis%20in%20LVDC%20DPS.pdf)  
26. Mitigation of Instability Issues Developed by CPL on DC Microgrid \- Technoarete, accessed October 29, 2025, [https://www.technoarete.org/common\_abstract/pdf/IJEREEE/v10/i5/Ext\_21546.pdf](https://www.technoarete.org/common_abstract/pdf/IJEREEE/v10/i5/Ext_21546.pdf)  
27. Mitigation of Destabilizing Effects of CPL in a Boost Converter Feeding Total CPL | Request PDF \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/311998868\_Mitigation\_of\_Destabilizing\_Effects\_of\_CPL\_in\_a\_Boost\_Converter\_Feeding\_Total\_CPL](https://www.researchgate.net/publication/311998868_Mitigation_of_Destabilizing_Effects_of_CPL_in_a_Boost_Converter_Feeding_Total_CPL)  
28. Mitigation of destabilising effect of CPLs in island DC micro-grid using non-linear control, accessed October 29, 2025, [https://digital-library.theiet.org/doi/full/10.1049/iet-pel.2015.0520](https://digital-library.theiet.org/doi/full/10.1049/iet-pel.2015.0520)  
29. Small Signal Modelling: State Space Representation \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=psMB9fpm2wk](https://www.youtube.com/watch?v=psMB9fpm2wk)  
30. State Space Average Modeling, Small Signal Analysis, and Control Implementation of an Efficient Single-Switch High-Gain Multicell Boost DC-DC Converter with Low Voltage Stress \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2079-9292/13/16/3264](https://www.mdpi.com/2079-9292/13/16/3264)  
31. State Space Models, Linearization, Transfer Function \- Automatic Control, Basic Course, Lecture 2, accessed October 29, 2025, [https://www.control.lth.se/fileadmin/control/Education/EngineeringProgram/FRTF05\_China/slides\_Lec2\_20191029.pdf](https://www.control.lth.se/fileadmin/control/Education/EngineeringProgram/FRTF05_China/slides_Lec2_20191029.pdf)  
32. How to linearize with multivariable Calculus: (This would work for systems of n autonomous first order differential equations,, accessed October 29, 2025, [http://www.math.utah.edu/\~korevaar/2280spring17/apr24.pdf](http://www.math.utah.edu/~korevaar/2280spring17/apr24.pdf)  
33. 19 Jacobian Linearizations, equilibrium points \- Graduate Degree in Control \+ Dynamical Systems, accessed October 29, 2025, [http://www.cds.caltech.edu/\~murray/courses/cds101/fa02/caltech/pph02-ch19-23.pdf](http://www.cds.caltech.edu/~murray/courses/cds101/fa02/caltech/pph02-ch19-23.pdf)  
34. Jacobian linearization and near equilibrium point behavior of nonlinear systems \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=NRTag7otSqo](https://www.youtube.com/watch?v=NRTag7otSqo)  
35. Linearization of Generator Current-State Space Model, accessed October 29, 2025, [https://home.engineering.iastate.edu/\~jdm/ee554/linearized\_current\_model.pdf](https://home.engineering.iastate.edu/~jdm/ee554/linearized_current_model.pdf)  
36. Jacobian matrix and determinant \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Jacobian\_matrix\_and\_determinant](https://en.wikipedia.org/wiki/Jacobian_matrix_and_determinant)  
37. Existence Conditions and Stability for the Power-Flow of DC Micro-Grids With CPLs, accessed October 29, 2025, [https://www.researchgate.net/publication/361158402\_Existence\_Conditions\_and\_Stability\_for\_the\_Power-Flow\_of\_DC\_Micro-grids\_with\_CPLs](https://www.researchgate.net/publication/361158402_Existence_Conditions_and_Stability_for_the_Power-Flow_of_DC_Micro-grids_with_CPLs)  
38. \[PDF\] Stability analysis of DC microgrids with constant power load ..., accessed October 29, 2025, [https://www.semanticscholar.org/paper/Stability-analysis-of-DC-microgrids-with-constant-Liu-Su/dc950b0029e04045f5f3d44455942a6df33fd093](https://www.semanticscholar.org/paper/Stability-analysis-of-DC-microgrids-with-constant-Liu-Su/dc950b0029e04045f5f3d44455942a6df33fd093)  
39. Robust Feedback Linearization Control for DAB Converter ... \- IFAT, accessed October 29, 2025, [https://ifatwww.et.uni-magdeburg.de/ifac2020/media/pdfs/0068.pdf](https://ifatwww.et.uni-magdeburg.de/ifac2020/media/pdfs/0068.pdf)  
40. A method of defining the load impedance specification for a stable distributed power system, accessed October 29, 2025, [https://www.researchgate.net/publication/238837633\_A\_method\_of\_defining\_the\_load\_impedance\_specification\_for\_a\_stable\_distributed\_power\_system](https://www.researchgate.net/publication/238837633_A_method_of_defining_the_load_impedance_specification_for_a_stable_distributed_power_system)  
41. Input Filter Interaction, accessed October 29, 2025, [http://u.dianyuan.com/bbs/u/31/1121915659.htm](http://u.dianyuan.com/bbs/u/31/1121915659.htm)  
42. Middlebrook, R.D. (1976) Input Filter Considerations in Design and Application of Switching Regulators. IEEE Industry Applications Society Annual Meeting, Chicago, IL, October 1976, 366-382. \- References, accessed October 29, 2025, [https://www.scirp.org/reference/referencespapers?referenceid=3018004](https://www.scirp.org/reference/referencespapers?referenceid=3018004)  
43. Exclusive Technology Feature The Engineer's Guide To EMI In DC-DC Converters (Part 10): Input Filter Impact On Stability, accessed October 29, 2025, [https://premiermag.com/wp-content/uploads/2022/01/H2PToday1911\_design\_TexasInstruments\_part10.pdf](https://premiermag.com/wp-content/uploads/2022/01/H2PToday1911_design_TexasInstruments_part10.pdf)  
44. Impedance-Based Modeling and Common Bus Stability Enhancement Control Algorithm in DC Microgrid \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/347083800\_Impedance-Based\_Modeling\_and\_Common\_Bus\_Stability\_Enhancement\_Control\_Algorithm\_in\_DC\_Microgrid](https://www.researchgate.net/publication/347083800_Impedance-Based_Modeling_and_Common_Bus_Stability_Enhancement_Control_Algorithm_in_DC_Microgrid)  
45. Stability Analysis of a Constant Power Load Serviced by a Buck Converter as the Source Impedance Varies, accessed October 29, 2025, [https://upload.wikimedia.org/wikipedia/commons/1/13/Stability\_Analysis\_of\_a\_Constant\_Power\_Load\_Serviced\_by\_a\_Buck\_Converter\_as\_the\_Source\_Impedance\_Varies\_%28IA\_stabilityanalysi1094517451%29.pdf](https://upload.wikimedia.org/wikipedia/commons/1/13/Stability_Analysis_of_a_Constant_Power_Load_Serviced_by_a_Buck_Converter_as_the_Source_Impedance_Varies_%28IA_stabilityanalysi1094517451%29.pdf)  
46. Comparative Study of Control Strategies for Stabilization and ... \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/13/10/2663](https://www.mdpi.com/1996-1073/13/10/2663)  
47. Stability Analysis of a DC Microgrid with Constant Power Load \- astesj, accessed October 29, 2025, [https://www.astesj.com/publications/ASTESJ\_070206.pdf](https://www.astesj.com/publications/ASTESJ_070206.pdf)  
48. DC Microgrid StabilityAffected by Aggregated Constant Power, accessed October 29, 2025, [https://powertechjournal.com/index.php/journal/article/view/22](https://powertechjournal.com/index.php/journal/article/view/22)  
49. Impedance Modeling With Stability Boundaries for Constant Power Load During Line Failure, accessed October 29, 2025, [https://www.researchgate.net/publication/374232255\_Impedance\_Modeling\_with\_Stability\_Boundaries\_for\_Constant\_Power\_Load\_During\_Line\_Failure](https://www.researchgate.net/publication/374232255_Impedance_Modeling_with_Stability_Boundaries_for_Constant_Power_Load_During_Line_Failure)  
50. Stability Criteria for Input Filter Design in Converters with CPL ..., accessed October 29, 2025, [https://www.mdpi.com/1996-1073/12/21/4048](https://www.mdpi.com/1996-1073/12/21/4048)  
51. Potential-Based Large-Signal Stability Analysis in DC Power Grids With Multiple Constant Power Loads, accessed October 29, 2025, [https://par.nsf.gov/servlets/purl/10347686](https://par.nsf.gov/servlets/purl/10347686)  
52. Lyapunov stability \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Lyapunov\_stability](https://en.wikipedia.org/wiki/Lyapunov_stability)  
53. What is Lyapunov stability and why is it important to control theory in general? \- Quora, accessed October 29, 2025, [https://www.quora.com/What-is-Lyapunov-stability-and-why-is-it-important-to-control-theory-in-general](https://www.quora.com/What-is-Lyapunov-stability-and-why-is-it-important-to-control-theory-in-general)  
54. Closed-Loop System Analysis Using Lyapunov Stability Theory \- DTIC, accessed October 29, 2025, [https://apps.dtic.mil/sti/tr/pdf/ADA196116.pdf](https://apps.dtic.mil/sti/tr/pdf/ADA196116.pdf)  
55. Estimating basins of attraction for arbitrary dynamical systems \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/355224703\_Estimating\_basins\_of\_attraction\_for\_arbitrary\_dynamical\_systems](https://www.researchgate.net/publication/355224703_Estimating_basins_of_attraction_for_arbitrary_dynamical_systems)  
56. Robust Stability Analysis of DC Microgrids with Constant Power Loads \- arXiv, accessed October 29, 2025, [https://arxiv.org/pdf/1702.07580](https://arxiv.org/pdf/1702.07580)  
57. Fundamentals of Power Electronics by Dragan Maksimovic and Robert W. Erickson... \- eBay, accessed October 29, 2025, [https://www.ebay.com/itm/315418933633](https://www.ebay.com/itm/315418933633)  
58. Fundamentals of Power Electronics \- Robert W. Erickson, Dragan Maksimovic \- Google Books, accessed October 29, 2025, [https://books.google.com/books/about/Fundamentals\_of\_Power\_Electronics.html?id=B4XhBwAAQBAJ](https://books.google.com/books/about/Fundamentals_of_Power_Electronics.html?id=B4XhBwAAQBAJ)  
59. Textbook | Prof. Robert Erickson | University of Colorado Boulder, accessed October 29, 2025, [https://www.colorado.edu/faculty/erickson/textbook](https://www.colorado.edu/faculty/erickson/textbook)  
60. IEEE Transactions on Power Electronics, accessed October 29, 2025, [https://www.ieee-pels.org/publications/transactions-on-power-electronics/](https://www.ieee-pels.org/publications/transactions-on-power-electronics/)  
61. Stability Analysis of Power-Converter-Dominated Microgrid by, accessed October 29, 2025, [http://deepblue.lib.umich.edu/bitstream/2027.42/174676/1/Fangyuan%20Chang%20Final%20Dissertation.pdf](http://deepblue.lib.umich.edu/bitstream/2027.42/174676/1/Fangyuan%20Chang%20Final%20Dissertation.pdf)  
62. Large-Signal Stability Criteria in DC Power Grids with Distributed, accessed October 29, 2025, [https://deepblue.lib.umich.edu/bitstream/handle/2027.42/155426/Large-Signal\_Stability\_Criteria\_in\_DC\_Power\_Grids\_with\_Distributed-Controlled\_Converters\_and\_Constant\_Power\_Loads.pdf?sequence=1\&isAllowed=y](https://deepblue.lib.umich.edu/bitstream/handle/2027.42/155426/Large-Signal_Stability_Criteria_in_DC_Power_Grids_with_Distributed-Controlled_Converters_and_Constant_Power_Loads.pdf?sequence=1&isAllowed=y)  
63. Stability analysis of DC micro-grids with CPLs under novel decentralized primary and distributed secondary control, accessed October 29, 2025, [https://eprints.whiterose.ac.uk/id/eprint/181684/1/stability\_analysis\_revised\_final.pdf](https://eprints.whiterose.ac.uk/id/eprint/181684/1/stability_analysis_revised_final.pdf)