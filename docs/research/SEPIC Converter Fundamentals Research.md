

# **A Comprehensive Analysis of the SEPIC DC-DC Converter: Topology, Steady-State Analysis, and Design**

## **Section I: Fundamental Operating Principles of the SEPIC Converter**

### **1.1 Introduction to the SEPIC Topology**

The Single-Ended Primary-Inductor Converter (SEPIC) is a non-isolated, fourth-order DC-DC switched-mode power supply (SMPS) topology.1 Its "fourth-order" designation derives from its four reactive storage elements: two inductors and two capacitors in its canonical form.

The basic SEPIC circuit comprises:

* An input inductor (L1)  
* A coupling capacitor ($C\_s$ or $C\_{cp}$), also referred to as the series or energy-transfer capacitor  
* A second inductor (L2)  
* A primary active switch (S1), typically a MOSFET  
* A rectifying diode (D1) 3

In a practical implementation, an input capacitor ($C\_{IN}$) is used to buffer the input voltage source, and an output capacitor ($C\_{OUT}$) is used to filter the output voltage and supply the load.4

The defining characteristic of the SEPIC converter is its ability to produce a non-inverting output voltage ($V\_{OUT}$) that can be greater than, less than, or equal to the input voltage ($V\_{IN}$).3 This non-inverting "buck-boost" capability makes it an extremely versatile topology. Topologically, the SEPIC can be conceptualized as a standard boost converter (formed by L1, S1, and D1) followed by an inverted buck-boost converter, with the coupling capacitor $C\_s$ serving to couple energy between the stages.3

### **1.2 Continuous Conduction Mode (CCM) Analysis**

The converter is defined as operating in Continuous Conduction Mode (CCM) when the currents flowing through both inductors, L1 and L2, remain positive (i.e., never fall to zero) throughout the entire switching cycle.3 The operation in CCM is characterized by two distinct states, or time intervals, within one switching period ($T\_s$). The duration of the first state is defined by the duty cycle, $D$, of the main switch S1.

**State 1: Switch S1 ON (Closed) — Interval $DT\_s$**

During this interval, the main switch S1 is closed, creating two primary current paths:

1. **Input Inductor Path:** The input voltage source ($V\_{IN}$) is applied directly across the input inductor L1. This causes the voltage $V\_{L1}$ to equal $V\_{IN}$, and the current through L1 ($I\_{L1}$) increases linearly (stores energy).3  
2. **Coupling Capacitor/Second Inductor Path:** The coupling capacitor $C\_s$, which was charged during the previous state, discharges. It is connected in parallel with the second inductor L2, applying a voltage $V\_{L2} \\approx V\_{C\_s}$ across it. This causes the current $I\_{L2}$ to increase linearly, storing energy in L2.3  
3. **Output Path:** The diode D1 is reverse-biased (its anode is at $-V\_{C\_s}$ relative to its cathode at $V\_{OUT}$) and is therefore OFF.3 The output stage is isolated from the input. The output capacitor $C\_{OUT}$ supplies the full load current ($I\_{LOAD}$) during this time.3

**State 2: Switch S1 OFF (Open) — Interval $(1-D)T\_s$**

During this interval, the main switch S1 is opened:

1. **Main Energy Transfer Path:** The switch S1 opens. The current $I\_{L1}$ from the input inductor cannot change instantaneously. It now flows from the input source, through L1, through the coupling capacitor $C\_s$, and through the now forward-biased diode D1 to the output.3  
2. **Second Inductor Path:** Simultaneously, the current $I\_{L2}$ stored in the second inductor also flows through the forward-biased diode D1 to the output.3  
3. **Output Path:** The diode D1 conducts the sum of the two inductor currents ($I\_{D1} \= I\_{L1} \+ I\_{L2}$).6 This combined current splits, supplying the $I\_{LOAD}$ and recharging the output capacitor $C\_{OUT}$.6  
4. **Component Voltages:** With the diode D1 conducting, the voltage across L2 is clamped to $-V\_{OUT}$.6 The voltage across L1 is found via KVL to be $V\_{L1} \= V\_{IN} \- V\_{C\_s} \- V\_{OUT}$.

This two-state analysis reveals several defining characteristics of the SEPIC topology. First, by tracing the current from $V\_{IN}$ and L1, it is clear that the input inductor is *never* disconnected from the input source during either state in CCM. This results in a continuous, non-pulsating input current 7, which is a significant advantage that reduces input filter requirements and electromagnetic interference (EMI) compared to converters with discontinuous input current like the standard buck or buck-boost.8

Second, the coupling capacitor $C\_s$ is central to the converter's operation. It is subjected to a high-frequency, high-magnitude AC current as it discharges to charge L2 (State 1\) and is recharged by L1 (State 2).3 The high RMS current flowing through this capacitor's Equivalent Series Resistance (ESR) makes it a primary source of power loss ($P\_{loss} \= I\_{RMS}^2 \\cdot ESR$) and thermal stress.10 Consequently, the selection of $C\_s$ is critical, demanding low-ESR (e.g., ceramic or polymer) capacitors with high ripple current ratings.11

Finally, as will be proven in the next section, the average voltage across $C\_s$ in steady-state is equal to $V\_{IN}$.3 This means the voltage waveforms across L1 and L2 are identical ($V\_L \= V\_{IN}$ during the ON-time, and $V\_L \= \-V\_{OUT}$ during the OFF-time). This property allows L1 and L2 to be wound on the same core, creating a "coupled inductor" that can save space and cost.4

## **Section II: Steady-State Analysis and Voltage Transfer Characteristics (CCM)**

The ideal DC voltage transfer function (or gain) of the converter, $M(D) \= V\_{OUT}/V\_{IN}$, is derived by applying the principle of Inductor Volt-Second Balance (IVSB). This principle states that for a converter operating in steady-state, the average voltage across any inductor over one complete switching cycle ($T\_s$) must be zero.6 A related principle, Capacitor Charge Balance (CCB), states the average current into any capacitor must also be zero.3

### **2.1 Derivation of the Voltage Gain $M(D)$**

The gain can be derived by applying IVSB to either L1 or L2. Applying it to L2 is slightly more direct.

1. **IVSB on Inductor L2:**  
   * During State 1 (Interval $DT\_s$): The voltage across L2 is $V\_{L2}(t) \= V\_{C\_s}$.  
   * During State 2 (Interval $(1-D)T\_s$): The diode D1 clamps L2 to the output, so $V\_{L2}(t) \= \-V\_{OUT}$.6  
   * Applying the IVSB principle:  
     $$\\langle V\_{L2} \\rangle \= \\frac{1}{T\_s} \\left \= 0$$  
     $$V\_{C\_s} \\cdot D \= V\_{OUT} \\cdot (1-D)$$  
   * This first result provides a relationship between the coupling capacitor voltage and the output voltage: $V\_{C\_s} \= V\_{OUT} \\cdot \\frac{1-D}{D}$.  
2. **IVSB on Inductor L1:**  
   * During State 1 (Interval $DT\_s$): The voltage across L1 is $V\_{L1}(t) \= V\_{IN}$.  
   * During State 2 (Interval $(1-D)T\_s$): Applying KVL to the outer loop gives $V\_{L1}(t) \= V\_{IN} \- V\_{C\_s} \- V\_{OUT}$.  
   * Applying the IVSB principle:  
     $$\\langle V\_{L1} \\rangle \= \\frac{1}{T\_s} \\left \= 0$$  
     $$V\_{IN} \\cdot D \+ (V\_{IN} \- V\_{C\_s} \- V\_{OUT}) \\cdot (1-D) \= 0$$  
3. **Solving for $M(D)$:**  
   * Substitute the expression for $V\_{C\_s}$ from step 1 into the L1 equation:  
     $$V\_{IN} \\cdot D \+ \\left(V\_{IN} \- \\left \- V\_{OUT}\\right) \\cdot (1-D) \= 0$$  
   * Factor out $V\_{IN}$ and $V\_{OUT}$:  
     $$V\_{IN} \\cdot (D \+ 1 \- D) \= V\_{OUT} \\cdot \\left$$$$V\_{IN} \= V\_{OUT} \\cdot (1-D) \\cdot \\left$$$$V\_{IN} \= V\_{OUT} \\cdot (1-D) \\cdot \\left$$  
     $$V\_{IN} \= V\_{OUT} \\cdot \\left( \\frac{1-D}{D} \\right)$$  
   * Rearranging for the voltage gain $M(D)$ yields the final equation for ideal CCM operation:

     $$\\frac{V\_{OUT}}{V\_{IN}} \= M(D) \= \\frac{D}{1-D}$$

This result is cited in numerous technical sources.4

A key consequence of this derivation is the confirmation of the coupling capacitor's average voltage. By substituting the final gain equation ($V\_{OUT} \= V\_{IN} \\cdot \\frac{D}{1-D}$) back into the result from step 1 ($V\_{C\_s} \= V\_{OUT} \\cdot \\frac{1-D}{D}$), we find:

$$V\_{C\_s} \= \\left(V\_{IN} \\cdot \\frac{D}{1-D}\\right) \\cdot \\left(\\frac{1-D}{D}\\right) \= V\_{IN}$$

This confirms the assertion from 3 that the average DC voltage across the coupling capacitor is equal to the input voltage. This is a critical design parameter, as $C\_s$ must be rated to withstand at least $V\_{IN(max)}$.

### **2.2 The Non-Inverting Buck-Boost Characteristic**

The gain equation $M(D) \= D/(1-D)$ quantitatively defines the SEPIC's flexible conversion capability:

* **Step-Down (Buck) Mode:** When the duty cycle $D \< 0.5$, the denominator $(1-D)$ is larger than the numerator $D$, resulting in $V\_{OUT} \< V\_{IN}$.  
* **Unity Gain Mode:** When $D \= 0.5$, $M(D) \= 0.5 / 0.5 \= 1$, resulting in $V\_{OUT} \= V\_{IN}$.  
* **Step-Up (Boost) Mode:** When $D \> 0.5$, the numerator $D$ is larger than the denominator $(1-D)$, resulting in $V\_{OUT} \> V\_{IN}$.

This characteristic is ideal for applications where the input voltage can vary both above and below the desired output. A common example is a system powered by a single-cell Lithium-Ion battery, which may discharge from 4.2 V to 3.0 V. A SEPIC converter can efficiently maintain a regulated 3.3 V output across this entire input range, seamlessly transitioning from buck mode to boost mode as the battery voltage drops.3

The fact that the SEPIC's gain equation is identical to that of the inverting buck-boost converter 17 and the Cuk converter is significant. It shows that these topologies belong to the same converter "family".18 This shared gain structure implies they also share underlying dynamic characteristics. Notably, the SEPIC, like the boost and buck-boost, exhibits a Right-Half-Plane Zero (RHPZ) in its control-to-output transfer function.19 This RHPZ represents a "non-minimum phase" behavior (an initial control change causes the output to move briefly in the opposite direction) that complicates feedback loop compensation and typically limits the achievable control bandwidth to low frequencies, often below 10 kHz.10

## **Section III: Conduction Modes: CCM, DCM, and Boundary Conditions**

Like all SMPS, the SEPIC converter can operate in two primary conduction modes, with the mode being determined by the load current.

### **3.1 Defining Conduction Modes**

* **Continuous Conduction Mode (CCM):** As analyzed previously, this mode occurs at higher load currents. It is defined by the fact that the currents in both inductors (L1 and L2) remain positive (greater than zero) for the entire switching period $T\_s$.3  
* **Discontinuous Conduction Mode (DCM):** This mode occurs at lighter load currents. In DCM, the inductor currents (specifically, the sum of the currents flowing through the diode D1) fall to zero before the $(1-D)T\_s$ OFF-time interval is over.21 This introduces a "third state" (duration $D\_3 T\_s$) into the switching cycle, during which both the switch S1 and the diode D1 are OFF, and the output capacitor $C\_{OUT}$ alone supplies the load current.21

When operating in DCM, the voltage gain $M(D)$ is no longer solely a function of $D$, but also becomes dependent on the load resistance ($R$), inductance values ($L$), and the switching period ($T\_s$).21

### **3.2 Derivation of the CCM-DCM Boundary Condition**

The boundary condition (also known as Boundary Conduction Mode, or BCM) is the precise operating point where the converter transitions between CCM and DCM. This occurs when the inductor/diode current just reaches zero exactly at the end of the switching cycle.23

This boundary is mathematically defined by a critical value $k\_c$ (or $k\_{crit}$) of a dimensionless parameter $k$.15

* The parameter $k$ is defined as: $k \= \\frac{2L}{R \\cdot T\_s}$, where $L$ is the equivalent inductance (assuming $L1=L2=L$), $R$ is the load resistance, and $T\_s$ is the switching period.15  
* The critical boundary value $k\_c$ is derived from the converter's state equations.  
* The conduction mode is then determined by comparing $k$ to $k\_c$:  
  * If $k \> k\_c$, the converter operates in **CCM**.15  
  * If $k \< k\_c$, the converter operates in **DCM**.15

Analysis of the state equations at the boundary (where the diode conduction time $d\_2 \= 1-d\_1$, $d\_1$ being the duty cycle $D$) yields the expression for the critical boundary.24

Boundary Condition Equation:

$$k\_c \= (1 \- D)^2$$  
This equation, cited in 24, defines the boundary. Therefore, the converter operates in CCM as long as:

$$\\frac{2L}{R \\cdot T\_s} \> (1 \- D)^2$$  
This expression shows that to remain in CCM, the converter needs lower load resistance (higher load), larger inductance, or a higher switching frequency ($f\_s \= 1/T\_s$).

It is notable that this boundary condition $k\_c \= (1-D)^2$ is exactly the same as that for the standard inverting buck-boost converter.24 This further reinforces the concept of a shared "topological family." This shared characteristic leads to a critical design trade-off. Operation in CCM (high $k$) generally provides higher efficiency by minimizing peak-to-average current ratios. However, operation in DCM (low $k$) often eliminates the problematic RHPZ, which vastly simplifies the control loop design.20 Designers must balance the need for high efficiency (favoring CCM) against the need for simple, high-bandwidth control (favoring DCM).

## **Section IV: Comparative Analysis of Non-Inverting Buck-Boost Topologies**

The SEPIC's utility is best understood by comparing it to its main topological competitors: the standard (inverting) Buck-Boost, the Cuk converter, and the modern 4-switch buck-boost.

### **4.1 Advantage: Non-Inverting Output Voltage**

* **SEPIC:** The output voltage has the same polarity as the input (e.g., $+V\_{IN} \\to \+V\_{OUT}$).3  
* **Inverting Buck-Boost & Cuk:** Both of these topologies produce an output voltage that is *inverted* relative to the input (e.g., $+V\_{IN} \\to \-V\_{OUT}$).8  
* **Implication:** This is arguably the SEPIC's most significant advantage. The vast majority of electronic systems require positive voltage rails. The SEPIC provides the required buck-boost function without the need for inverting the ground reference or using an isolation transformer, which is a major drawback for the Cuk and inverting buck-boost topologies in many common applications.25

### **4.2 Advantage: Continuous Input Current**

* **SEPIC & Cuk:** Both topologies feature an inductor (L1) placed directly at the input, which is never disconnected from the source in CCM. This draws a smooth, continuous current.8  
* **Inverting Buck-Boost:** This converter has a discontinuous ("chopped") input current, as the input inductor is disconnected from the source during the switch OFF-time.9  
* **Implication:** The continuous input current of the SEPIC and Cuk converters generates significantly less conducted EMI, simplifying the design and reducing the cost of the input filter.8

### **4.3 Advantage: Inherent Short-Circuit Tolerance**

* **SEPIC:** The coupling capacitor $C\_s$ is in series with the main power transfer path from input to output.13 As a capacitor, it *blocks DC current*.3  
* **Implication:** If the output is shorted to ground, $C\_s$ prevents a catastrophic DC current from flowing directly from $V\_{IN}$ to the short. This provides a level of "short-circuit resistance" 5 that is not present in topologies like the boost converter, where an output short creates a direct path from the input through the inductor and diode.28  
* **Critical Caveat:** This "protection" is often misunderstood. It does not make the converter "short-circuit-proof." As noted in 28, a hard short will still cause very high *peak* current pulses to flow through the switch S1 (when ON) and the diode D1 (when OFF). The components must be oversized to handle the thermal stress of these fault pulses until the controller's over-current protection (OCP) circuitry reacts and shuts the converter down.28

### **4.4 Disadvantage: Discontinuous (Pulsating) Output Current**

* **SEPIC:** This is the SEPIC's primary drawback. During the switch ON-time (State 1), the output stage is completely disconnected from the power train, and the load is supplied *only* by the output capacitor $C\_{OUT}$.3 This creates a highly pulsating, discontinuous current at the output.8  
* **Cuk:** In sharp contrast, the Cuk converter's output inductor ensures its output current is *continuous*.8  
* **Implication:** The SEPIC's pulsating output current results in high output voltage ripple. To mitigate this, the SEPIC requires a larger and more expensive output capacitor ($C\_{OUT}$) with a very low ESR.8 The Cuk, with its smooth output current, can achieve the same ripple specification with a much smaller capacitor.

### **4.5 Disadvantage: Component Count, Cost, and Efficiency**

* **Component Count:** As a 4th-order converter, the SEPIC requires two inductors and a high-stress coupling capacitor, making it more complex, physically larger, and more costly than a basic buck-boost topology.5  
* **Efficiency:** The SEPIC topology has multiple sources of loss. The high RMS current in $C\_s$ creates $I^2R$ losses in the capacitor's ESR 10, and the circuit has conduction losses from two separate inductors.  
* **Implication:** When compared to the modern 4-switch synchronous buck-boost (which replaces the diode with an efficient MOSFET), the SEPIC is less efficient. A common design heuristic is that for low-power applications (e.g., \< 1 A), a SEPIC is a good choice. However, for higher-power applications (\> 1 A), a 4-switch buck-boost will "always be the better solution" due to its superior efficiency.10

### **4.6 Summary: Topological Selection Matrix**

| Feature | Inverting Buck-Boost | SEPIC | Cuk | 4-Switch Buck-Boost |
| :---- | :---- | :---- | :---- | :---- |
| **Output Polarity** | **Inverting** 17 | **Non-Inverting** 3 | **Inverting** 25 | **Non-Inverting** |
| **Input Current** | Discontinuous 9 | **Continuous** 8 | **Continuous** 8 | Continuous |
| **Output Current** | Discontinuous | **Discontinuous** 8 | **Continuous** 25 | Mode-Dependent |
| **SC Tolerance** | (via $L$) | **Good (via $C\_s$)** 5 | **Good (via $C\_s$)** | (via controller) |
| **Component Count** | Low (3rd Order) | **High (4th Order)** 13 | **High (4th Order)** | Very High (4 FETs) |
| **Key Advantage** | Simplicity | Non-inverting, low input EMI | Low input/output EMI | High efficiency, non-inverting |
| **Key Disadvantage** | Inverting, high input EMI | Pulsating output, lower eff. | Inverting output | High cost, complex control |

## **Section V: Practical Design Procedure and Component Selection**

Translating the preceding theory into a practical design requires a systematic, step-by-step methodology for selecting and sizing the key components. The following steps are based on design guides from Texas Instruments 29 and other technical sources.12

### **5.1 Step-by-Step Component Sizing Methodology**

1. **Define Specifications:** The designer must first define the operating parameters: $V\_{IN(min)}$, $V\_{IN(max)}$, $V\_{OUT}$, $I\_{OUT(max)}$, $f\_{sw}$ (switching frequency), and the allowable output voltage ripple $\\Delta V\_{OUT}$.12  
2. Calculate Maximum Duty Cycle ($D\_{max}$): The maximum duty cycle occurs at the minimum input voltage ($V\_{IN(min)}$) and is essential for calculating peak currents. The non-ideal equation, including the diode forward voltage ($V\_D$), must be used for accuracy:

   $$D\_{max} \= \\frac{V\_{OUT} \+ V\_D}{V\_{IN(min)} \+ V\_{OUT} \+ V\_D}$$  
   (from 29, Eq. 18\)  
3. **Inductor Selection (L1, L2):**  
   * It is common practice to set $L1 \= L2 \= L$, which simplifies design and allows for a coupled inductor.29  
   * The inductance $L$ is calculated based on a target inductor ripple current ($\\Delta I\_L$), typically 20-40% of the maximum input current.29  
   * $$L\_1 \= L\_2 \= L \= \\frac{V\_{IN(min)}}{\\Delta I\_L \\times f\_{sw}} \\times D\_{max}$$  
     (from 29, Eq. 21\)  
   * The inductors and the main switch S1 must be rated for the peak switch current, which is the sum of the peak currents in both inductors: $I\_{SW(peak)} \= I\_{L1(peak)} \+ I\_{L2(peak)}$.14  
4. **Coupling Capacitor ($C\_s$) Selection:**  
   * This component is selected based on two criteria: its RMS current rating and its capacitance value (to limit voltage ripple $\\Delta V\_{Cs}$). The RMS current rating is almost always the limiting factor.  
   * RMS Current: $C\_s$ must be rated to handle the high RMS current. A good approximation is given by:

     $$I\_{Cs(rms)} \= I\_{OUT} \\times \\frac{V\_{OUT} \+ V\_D}{V\_{IN(min)}}$$  
     (from 29, Eq. 27\)  
   * Capacitance: The capacitance value is chosen to limit the ripple $\\Delta V\_{Cs}$, which can impact the voltage on L2.

     $$\\Delta V\_{Cs} \= \\frac{I\_{OUT} \\times D\_{max}}{C\_s \\times f\_{sw}}$$  
     (from 29, Eq. 28\)  
   * A low-ESR ceramic (e.g., X7R) or polymer capacitor is required to handle the high RMS current and minimize self-heating.12  
5. **Output Capacitor ($C\_{out}$) Selection:**  
   * $C\_{out}$ selection is critical due to the pulsating output current and is driven by two requirements:  
   * 1\. Output Ripple ($\\Delta V\_{ripple}$): The capacitance must be large enough, and the ESR low enough, to meet the ripple specification. The ESR is often the dominant factor.

     $$ESR\_{max} \\approx \\frac{\\Delta V\_{ripple}}{I\_{L1(peak)} \+ I\_{L2(peak)}}$$  
     (based on 29, Eq. 30\)  
   * 2\. Transient Droop ($\\Delta V\_{droop}$): This is often the true limiting factor. When the load suddenly increases ($\\Delta I\_{step}$), the control loop needs time (set by its bandwidth, $f\_c$) to respond. During this time, $C\_{out}$ must supply the current, causing a voltage "droop."

     $$C\_{out,droop} \\approx \\frac{\\Delta I\_{step}}{2 \\pi f\_c \\Delta V\_{droop}}$$  
     (from 12)  
   * The designer must calculate the capacitance required for *both* ripple and transient droop, and select the *larger* of the two values.12  
6. **Switch (S1) and Diode (D1) Selection:**  
   * **Voltage Stress:** Both S1 and D1 must be able to block the peak voltage when OFF. This voltage is the sum of the maximum input and output voltages: $V\_{peak} \= V\_{IN(max)} \+ V\_{OUT}$.  
   * **Current Stress:** Both components must be rated to handle the peak current $I\_{SW(peak)} \= I\_{L1(peak)} \+ I\_{L2(peak)}$.14 A Schottky diode is preferred for D1 to minimize forward voltage drop and improve efficiency.12

### **5.2 Design Example Case Studies**

The following tables summarize the design values from two practical examples, illustrating the application of these equations.

Table 1: Design Example (High Current, 2.5 A Output)  
This example demonstrates the component selection for a 3.3 V, 2.5 A output from a variable input, as detailed in Texas Instruments Application Note SNVA168E.29

* **Specifications:** $V\_{IN}$: 3.0 V \- 5.7 V; $V\_{OUT}$: 3.3 V; $I\_{OUT}$: 2.5 A; $f\_{sw}$: 330 kHz

| Component | Parameter | Equation (per ) | Calculation | Selected Value |
| :---- | :---- | :---- | :---- | :---- |
| **Duty Cycle** | $D\_{max}$ (at $V\_{IN(min)}$, $V\_D=0.5V$) | $D \= \\frac{V\_{OUT} \+ V\_D}{V\_{IN(min)} \+ V\_{OUT} \+ V\_D}$ (Eq. 18\) | $\\frac{3.3 \+ 0.5}{3.0 \+ 3.3 \+ 0.5} \= 0.56$ | **0.56** |
| **Inductors** | $\\Delta I\_L$ (40% ripple) | $\\Delta I\_L \= I\_{OUT} \\frac{V\_{OUT}}{V\_{IN(min)}} (0.4)$ (Eq. 20\) | $2.5 \\cdot \\frac{3.3}{3.0} \\cdot 0.4 \= 1.1 A$ | **1.1 A** |
|  | $L1 \= L2 \= L$ | $L \= \\frac{V\_{IN(min)}}{\\Delta I\_L \\cdot f\_{sw}} \\cdot D\_{max}$ (Eq. 21\) | $\\frac{3.0}{1.1 \\cdot 330k} \\cdot 0.56 \= 4.6 \\mu H$ | **4.7 $\\mu$H** |
| **Coupling Cap** | $I\_{Cs(rms)}$ | $I\_{Cs(rms)} \= I\_{OUT} \\frac{V\_{OUT} \+ V\_D}{V\_{IN(min)}}$ (Eq. 27\) | $2.5 \\cdot \\frac{3.3 \+ 0.5}{3.0} \\approx 2.8 A$ | **Rated \> 2.8 A RMS** |
|  | $C\_s$ | (Value check with Eq. 28\) | $\\Delta V\_{Cs} \= \\frac{2.5 \\cdot 0.56}{10\\mu \\cdot 330k} \= 0.42 V$ | **10 $\\mu$F** |
| **Output Cap** | $C\_{out(min)}$ (for ripple) | $C\_{out} \\ge \\frac{I\_{OUT} \\cdot D\_{max}}{\\Delta V\_{ripple} \\cdot f\_{sw}}$ (Eq. 31, mod.) | $\\frac{2.5 \\cdot 0.56}{(0.02 \\cdot 3.3) \\cdot 330k} \\approx 141 \\mu F$ | **2 x 100 $\\mu$F** |

Table 2: Design Example (Transient-Focused, 1.0 A Output)  
This example highlights the importance of designing the output capacitor for transient load-step response, which is often the more demanding requirement.12

* **Specifications:** $V\_{IN}$: 3.0 V \- 4.2 V; $V\_{OUT}$: 3.3 V; $I\_{OUT}$: 1.0 A; $f\_{sw}$: 500 kHz; $f\_c$ (control loop bandwidth): 10 kHz

| Component | Parameter | Equation (per ) | Calculation | Selected Value |
| :---- | :---- | :---- | :---- | :---- |
| **Inductors** | $L\_{min}$ | (Proprietary formula) | $\\approx 4.0 \\mu H$ | **6.8 $\\mu$H** |
| **Output Cap** | $C\_{out,rip}$ (for ripple) | $C\_{out} \= \\frac{I\_{out} \\cdot D\_{max}}{f\_{sw} \\cdot \\Delta V\_{out, C}}$ | $\\frac{1.0 \\cdot 0.552}{500k \\cdot 0.0165} \\approx 66.9 \\mu F$ | **N/A** (Not limiting) |
|  | $C\_{out,droop}$ (for transient) | $C\_{out} \= \\frac{\\Delta I\_{step}}{2 \\pi f\_c \\Delta V\_{droop}}$ | $\\frac{0.5}{2 \\pi \\cdot 10k \\cdot 0.099} \\approx 80.4 \\mu F$ | **100 $\\mu$F** (Selected) |
|  | $ESR\_{max}$ | $ESR \= \\frac{\\Delta V\_{out, ESR}}{\\Delta I\_{Cout, avg}}$ | $\\frac{0.0165}{0.395} \\approx 41.7 m\\Omega$ | **\< 41.7 m$\\Omega$** |

## **Section VI: Foundational References for SEPIC Converter Analysis**

The analysis within this report is grounded in the foundational principles of power electronics as established in authoritative textbooks and key technical papers. The following sources are considered canonical references for advanced converter analysis and design.

### **6.1 Authoritative Power Electronics Textbooks**

* **Erickson & Maksimovic:**  
  * **Citation:** Erickson, R. W., and Maksimovic, D. (2001). *Fundamentals of Power Electronics*. (2nd ed., ch. 7, pp. 27–31). Springer (formerly Kluwer Academic Publishers)..1  
  * **Relevance:** This is a standard graduate-level text renowned for its rigorous mathematical modeling of switched-mode converters, including fourth-order topologies and their complex dynamics, such as the Right-Half-Plane Zero.19  
* **Rashid:**  
  * **Citation:** Rashid, M. H. (2014). *Power Electronics Devices, Circuits and Applications*. (4th ed., ch. 5, pp. 269–275). Pearson..1  
  * **Relevance:** A comprehensive and widely used reference for both undergraduate education and practicing engineers, covering the breadth of power electronics from devices to converter applications.33  
* **Mohan, Undeland, & Robbins:**  
  * **Citation:** Mohan, N., Undeland, T. M., and Robbins, W. P. (2003). *Power Electronics Converters, Applications and Design*. (3rd ed., ch. 7, pp. 184–188). John Wiley & Sons, Inc..1  
  * **Relevance:** A foundational textbook that effectively bridges theoretical converter analysis with practical design and applications.36

### **6.2 Key Application Notes and Technical Papers**

* **Texas Instruments (TI):**  
  * (SNVA168E) "SEPIC Converter Design Example".29  
  * (SLVA904) "TPS61500 SEPIC Configuration".14  
  * (SLVA337) "How to Design a SEPIC Converter With the TPS61175".16  
* **ONSEMI:**  
  * (AND90136-D) "SEPIC Converter Analysis and Design".4  
* **Jørgensen, A. B. (Aalborg University):**  
  * "Derivation, Design and Simulation of the Single-Ended Primary-Inductor Converter (SEPIC)." (Preprint, 2019).1  
  * **Relevance:** This paper is notable for explicitly identifying the "gap" in open-access literature between basic textbook derivations and practical, in-depth design equations for fourth-order converters like the SEPIC.1

#### **Works cited**

1. Derivation, Design and Simulation of the Single-Ended Primary ..., accessed October 29, 2025, [https://vbn.aau.dk/files/302791680/abj\_sepic\_engrxiv.pdf](https://vbn.aau.dk/files/302791680/abj_sepic_engrxiv.pdf)  
2. Derivation, Design and Simulation of the Single-Ended Primary-Inductor Converter (SEPIC), accessed October 29, 2025, [https://www.researchgate.net/publication/332817638\_Derivation\_Design\_and\_Simulation\_of\_the\_Single-Ended\_Primary-Inductor\_Converter\_SEPIC](https://www.researchgate.net/publication/332817638_Derivation_Design_and_Simulation_of_the_Single-Ended_Primary-Inductor_Converter_SEPIC)  
3. Single-ended primary-inductor converter \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Single-ended\_primary-inductor\_converter](https://en.wikipedia.org/wiki/Single-ended_primary-inductor_converter)  
4. AND90136 \- SEPIC Converter Analysis and Design \- onsemi, accessed October 29, 2025, [https://www.onsemi.com/pub/collateral/and90136-d.pdf](https://www.onsemi.com/pub/collateral/and90136-d.pdf)  
5. SEPIC Converter | Applications & Industries Guide | Würth Elektronik, accessed October 29, 2025, [https://www.we-online.com/en/components/applicationguide/sepic\_converter](https://www.we-online.com/en/components/applicationguide/sepic_converter)  
6. SEPIC Converters \- Monolithic Power Systems, accessed October 29, 2025, [https://www.monolithicpower.com/en/learning/mpscholar/power-electronics/dc-dc-converters/sepic-converters](https://www.monolithicpower.com/en/learning/mpscholar/power-electronics/dc-dc-converters/sepic-converters)  
7. DIGITAL WE DAYS 2025 Practical Tactics for Designing SEPICs, accessed October 29, 2025, [https://www.we-online.com/files/pdf1/practical-tactics-for-designing-sepics.pdf](https://www.we-online.com/files/pdf1/practical-tactics-for-designing-sepics.pdf)  
8. Comparative Study of Buck-Boost, SEPIC, Cuk and Zeta DC-DC ..., accessed October 29, 2025, [https://www.mdpi.com/1996-1073/15/21/7936](https://www.mdpi.com/1996-1073/15/21/7936)  
9. Switch Mode Power Supply Topologies: A Comparison \- Würth Elektronik, accessed October 29, 2025, [https://www.we-online.com/en/news-center/blog?d=switch-mode-power-supply](https://www.we-online.com/en/news-center/blog?d=switch-mode-power-supply)  
10. Tradeoffs of 4-sw buck/boost VS SEPIC \- Monolithic Power Systems' Technical Forum, accessed October 29, 2025, [https://forum.monolithicpower.com/t/tradeoffs-of-4-sw-buck-boost-vs-sepic/130](https://forum.monolithicpower.com/t/tradeoffs-of-4-sw-buck-boost-vs-sepic/130)  
11. DC-DC SEPIC Converter \- Power4all, accessed October 29, 2025, [https://power4all.in/SEPIC\_Converter.php](https://power4all.in/SEPIC_Converter.php)  
12. SEPIC Converter Design and Calculation \- passive-components.eu, accessed October 29, 2025, [https://passive-components.eu/sepic-converter-design-and-calculation/](https://passive-components.eu/sepic-converter-design-and-calculation/)  
13. Comparing Coupled- and Uncoupled-Inductor | DigiKey, accessed October 29, 2025, [https://www.digikey.com/en/articles/comparing-coupled-and-uncoupled-inductor-sepic-voltage-converters](https://www.digikey.com/en/articles/comparing-coupled-and-uncoupled-inductor-sepic-voltage-converters)  
14. TPS61500 SEPIC Configuration \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slva904](https://www.ti.com/lit/pdf/slva904)  
15. Study of Multiple Discontinuous Conduction Modes in SEPIC, Ćuk ..., accessed October 29, 2025, [https://www.mdpi.com/2079-9292/11/22/3744](https://www.mdpi.com/2079-9292/11/22/3744)  
16. How to design a SEPIC converter with the TPS61175 \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slva337](https://www.ti.com/lit/pdf/slva337)  
17. Buck–boost converter \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Buck%E2%80%93boost\_converter](https://en.wikipedia.org/wiki/Buck%E2%80%93boost_converter)  
18. Comparative Analysis of Buck-Boost Converter with Sepic Converter for Optimization of Wind Power Plant Output Voltage \- Atlantis Press, accessed October 29, 2025, [https://www.atlantis-press.com/article/125998341.pdf](https://www.atlantis-press.com/article/125998341.pdf)  
19. Analyzing the Sepic Converter \- TI E2E, accessed October 29, 2025, [https://e2e.ti.com/cfs-file/\_\_key/communityserver-discussions-components-files/234/Sepic-Analysis.pdf](https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/234/Sepic-Analysis.pdf)  
20. Discontinuous Mode SEPIC Reference Design With Modulated Output Voltage \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/tidt328](https://www.ti.com/lit/pdf/tidt328)  
21. LECTURE 39 CCM to DCM Boundary Conditions HW \#2 DUE next time A. CCM to DCM Transition Boundary, accessed October 29, 2025, [https://www.engr.colostate.edu/ECE562/98lectures/l39.pdf](https://www.engr.colostate.edu/ECE562/98lectures/l39.pdf)  
22. (PDF) Discontinuous conduction mode in the SEPIC converter \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/3548450\_Discontinuous\_conduction\_mode\_in\_the\_SEPIC\_converter](https://www.researchgate.net/publication/3548450_Discontinuous_conduction_mode_in_the_SEPIC_converter)  
23. Analysis and Design of a DCM SEPIC PFC with Adjustable Output Voltage \- VTechWorks, accessed October 29, 2025, [https://vtechworks.lib.vt.edu/bitstream/10919/51664/1/Chen\_R\_T\_2015.pdf](https://vtechworks.lib.vt.edu/bitstream/10919/51664/1/Chen_R_T_2015.pdf)  
24. Modelling of SEPIC, Ćuk and Zeta Converters in Discontinuous ..., accessed October 29, 2025, [https://pmc.ncbi.nlm.nih.gov/articles/PMC8618931/](https://pmc.ncbi.nlm.nih.gov/articles/PMC8618931/)  
25. Why do DC/DC switching controllers seem to favour the buck-boost topology over similar ones like Cuk, SEPIC and Zeta?, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/553854/why-do-dc-dc-switching-controllers-seem-to-favour-the-buck-boost-topology-over-s](https://electronics.stackexchange.com/questions/553854/why-do-dc-dc-switching-controllers-seem-to-favour-the-buck-boost-topology-over-s)  
26. DIY SEPIC Converter : 7 Steps \- Instructables, accessed October 29, 2025, [https://www.instructables.com/DIY-SEPIC-Converter/](https://www.instructables.com/DIY-SEPIC-Converter/)  
27. Synchronous Inverse SEPIC Topology Provides High Efficiency ..., accessed October 29, 2025, [https://www.analog.com/en/resources/analog-dialogue/articles/buck-boost-voltage-converters-with-sepic.html](https://www.analog.com/en/resources/analog-dialogue/articles/buck-boost-voltage-converters-with-sepic.html)  
28. Short Circuit Protection with SEPIC DC-DC Converter Topology \- Power management forum, accessed October 29, 2025, [https://e2e.ti.com/support/power-management-group/power-management/f/power-management-forum/630178/short-circuit-protection-with-sepic-dc-dc-converter-topology](https://e2e.ti.com/support/power-management-group/power-management/f/power-management-forum/630178/short-circuit-protection-with-sepic-dc-dc-converter-topology)  
29. AN-1484 Designing A SEPIC Converter (Rev. E) \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/an/snva168e/snva168e.pdf](https://www.ti.com/lit/an/snva168e/snva168e.pdf)  
30. Tutorial 1: SEPIC Analysis \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=\_bmI14s9Lx8](https://www.youtube.com/watch?v=_bmI14s9Lx8)  
31. design and simulation of high gain sepic dc–dc converter \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/366862313\_DESIGN\_AND\_SIMULATION\_OF\_HIGH\_GAIN\_SEPIC\_DC-DC\_CONVERTER](https://www.researchgate.net/publication/366862313_DESIGN_AND_SIMULATION_OF_HIGH_GAIN_SEPIC_DC-DC_CONVERTER)  
32. Rashid, M.H. (2013) Power Electronics Devices, Circuits, and ..., accessed October 29, 2025, [https://www.scirp.org/reference/referencespapers?referenceid=1917218](https://www.scirp.org/reference/referencespapers?referenceid=1917218)  
33. Power Electronics Devices, Circuits & Applications 4/E \- ElCoM, accessed October 29, 2025, [https://elcom-team.com/Subjects/power%20electronics/%D8%A7%D9%84%D9%83%D8%AA%D8%A8%20%D9%88%20%D8%A7%D9%84%D8%AD%D9%84%D9%88%D9%84/power-electro-reference-book-(4th-ed).pdf](https://elcom-team.com/Subjects/power%20electronics/%D8%A7%D9%84%D9%83%D8%AA%D8%A8%20%D9%88%20%D8%A7%D9%84%D8%AD%D9%84%D9%88%D9%84/power-electro-reference-book-\(4th-ed\).pdf)  
34. Design and Implementation of a SEPIC Topology DC-DC Converter \- ASEE PEER, accessed October 29, 2025, [https://peer.asee.org/design-and-implementation-of-a-sepic-topology-dc-dc-converter.pdf](https://peer.asee.org/design-and-implementation-of-a-sepic-topology-dc-dc-converter.pdf)  
35. First Course on Power Electronics, accessed October 29, 2025, [http://103.203.175.90:81/fdScript/RootOfEBooks/E%20Book%20collection%20-%202020%20-%20A/ECE/PowerElectronicsAFirstCoursebyMohan-1.pdf](http://103.203.175.90:81/fdScript/RootOfEBooks/E%20Book%20collection%20-%202020%20-%20A/ECE/PowerElectronicsAFirstCoursebyMohan-1.pdf)  
36. Power Electronics, A First Course: Simulations and Laboratory Implementations \- Ned Mohan, Siddharth Raju \- Google Books, accessed October 29, 2025, [https://books.google.com/books/about/Power\_Electronics\_A\_First\_Course.html?id=bKOgEAAAQBAJ](https://books.google.com/books/about/Power_Electronics_A_First_Course.html?id=bKOgEAAAQBAJ)