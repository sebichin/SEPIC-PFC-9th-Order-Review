

# **Dynamic Analysis and Control Design for Switched-Mode Power Converters: A Foundational Report on Transfer Functions, Pole-Zero Analysis, and Frequency-Domain Compensation**

## **The Small-Signal Model: From Switching Circuits to Linear Transfer Functions**

### **The Challenge: Modeling Non-Linear, Time-Varying Systems**

Switched-mode power converters (SMPCs) are, by their nature, non-linear time-discontinuous systems.1 The very act of switching components (e.g., a MOSFET and a diode) on and off creates a system whose mathematical model changes drastically within a single switching period. This presents a fundamental conflict for control design. The powerful, frequency-domain tools of classical feedback control theory, such as Bode plots, Nyquist criteria, and root-locus analysis, are only applicable to Linear Time-Invariant (LTI) systems.1

To bridge this gap, a modeling technique is required to represent the complex, periodic switching behavior of the converter as an equivalent LTI system. This model must be valid for small perturbations around a fixed, steady-state (DC) operating point. This is the objective of "small-signal modeling".2 The resulting model, or "small-signal transfer function," allows engineers to predict the converter's dynamic behavior and systematically design a stable, high-performance feedback compensator.3

### **The Solution: State-Space Averaging (SSA)**

The most foundational and widely adopted method for this transformation is **State-Space Averaging (SSA)**. This technique was introduced in a seminal 1976 IEEE Power Electronics Specialists Conference (PESC) paper by R.D. Middlebrook and Slobodan Ćuk, titled "A General Unified Approach to Modelling Switching-Converter Power Stages".4

The significance of the SSA method was its unification of two previously disconnected approaches: (1) rigorous but abstract state-space equation manipulations, and (2) intuitive but less formal averaging techniques. The result was a single, *averaged equivalent linear circuit model*.4 This averaged model is invaluable because it provides the circuit designer with both a mathematically sound model and deep physical insight, allowing the use of familiar linear circuit analysis tools.4

The SSA derivation process follows a formal, systematic procedure:

1. **State Identification:** The converter's operation is first divided into its discrete topological states. For a converter in Continuous Conduction Mode (CCM), this consists of two linear circuits: one for when the main switch is ON (interval $D \\cdot T\_s$), and one for when it is OFF (interval $(1-D) \\cdot T\_s$).7  
2. **State-Space Formulation:** The exact state equations are written for each linear topology. The state vector, $x(t)$, is composed of the variables that store energy, namely the inductor currents and capacitor voltages. This results in two sets of state-space equations 8:  
   * Switch ON (Interval 1): $\\dot{x} \= A\_1x \+ B\_1u$  
   * Switch OFF (Interval 2): $\\dot{x} \= A\_2x \+ B\_2u$  
3. **Averaging:** The core step of SSA is to replace these two discrete-time descriptions with a single, continuous-time averaged model. This is achieved by taking a weighted average of the state matrices over one full switching period ($T\_s$), where the weighting factor is the duty cycle $D$.4 The resulting averaged state-space description is:  
   * $\\dot{\\bar{x}} \=\\bar{x} \+\\bar{u}$  
   * This is simplified to: $\\dot{\\bar{x}} \= A\\bar{x} \+ B\\bar{u}$  
4. **Perturbation and Linearization:** To perform AC analysis, small AC perturbations (denoted by $\\tilde{\\cdot}$) are introduced around the DC steady-state operating point (denoted by uppercase letters) for all state variables, inputs ($u$), and the control variable ($d$) 8:  
   * $x(t) \= X \+ \\tilde{x}(t)$  
   * $u(t) \= U \+ \\tilde{u}(t)$  
   * $d(t) \= D \+ \\tilde{d}(t)$  
5. These expressions are substituted into the averaged model. The resulting equation is expanded, and two key simplifications are made: (1) the DC (steady-state) terms are set to zero, and (2) all products of two or more AC perturbation terms (e.g., $\\tilde{x}(t) \\cdot \\tilde{d}(t)$) are assumed to be negligibly small and are eliminated.8  
6. **The Final AC Model:** This linearization process yields the final, LTI small-signal AC model 11:  
   * $\\dot{\\tilde{x}} \= A\\tilde{x} \+ B\_d\\tilde{d} \+...$  
7. **Laplace Transform:** By applying the Laplace transform to this final AC model, the system of differential equations is converted into a set of algebraic equations in the s-domain. This allows for solving for any transfer function of interest by finding the $s$-domain ratio of a specific output to a specific input.8

### **Defining the Key Transfer Functions**

The complete SSA model provides a full Multiple-Input Multiple-Output (MIMO) description. For the design of a closed-loop voltage regulator, two of these transfer functions are of primary importance.

* **Control-to-Output Transfer Function, $G\_{vd}(s)$:**  
  * **Definition:** This transfer function, $G\_{vd}(s)$, describes the dynamic relationship between the control input (the duty cycle perturbation, $\\tilde{d}(s)$) and the output voltage perturbation ($\\tilde{v}(s)$).12  
  * **Formal Derivation:** It is derived from the AC model by setting all other AC input variations, such as the input voltage perturbation ($\\tilde{v}\_g(s)$), to zero.12  
  * $G\_{vd}(s) \= \\frac{\\tilde{v}(s)}{\\tilde{d}(s)}\\Biggr|\_{\\tilde{v}\_g(s)=0}$ 12  
  * **Significance:** This is the *plant* transfer function. It represents the system that the feedback compensator must control. It is a key component of the total loop gain, $T(s)$, and its characteristics (poles, zeros, and gain) dictate the entire control design strategy.12  
* **Line-to-Output Transfer Function, $G\_{vg}(s)$:**  
  * **Definition:** This transfer function, $G\_{vg}(s)$, describes how disturbances or variations on the input voltage line ($\\tilde{v}\_g(s)$) propagate to and create disturbances on the output voltage ($\\tilde{v}(s)$).12  
  * **Formal Derivation:** It is derived by setting the AC control input ($\\tilde{d}(s)$) to zero.12  
  * $G\_{vg}(s) \= \\frac{\\tilde{v}(s)}{\\tilde{v}\_g(s)}\\Biggr|\_{\\tilde{d}(s)=0}$ 12  
  * **Significance:** This transfer function represents the converter's intrinsic *audiosusceptibility* or *line rejection*. For example, it determines how much of the 120 Hz ripple from an offline rectifier will appear at the converter's output.13 A well-designed feedback loop will have high gain at these disturbance frequencies to actively sense and reject them.

### **Limitations of State-Space Averaging**

While foundational, State-Space Averaging is a model with specific limitations that are critical to understand in modern power electronics. The entire method is predicated on the "small ripple" assumption—that is, the AC ripple in the inductor currents and capacitor voltages is small compared to their DC values.15

This assumption, and thus the model's accuracy, breaks down in several key cases:

1. **Discontinuous Conduction Mode (DCM):** In DCM, the inductor current ripple is *not* small; it falls to zero for a portion of the cycle. This requires a different, though related, modeling approach.2  
2. **Resonant Converters:** In these topologies, the state variables are intentionally large-signal sinusoids, not DC-like waveforms. SSA is fundamentally inapplicable to these converters.15

Furthermore, SSA is an *averaging* model, which inherently acts as a low-pass filter on the system dynamics. The model is widely understood to be accurate for frequencies well below the switching frequency ($f\_s$), but it loses accuracy as the frequency approaches and exceeds half the switching frequency ($f\_s/2$).1

For a simple, single-converter system, this limitation is acceptable, as the control loop bandwidth is almost always designed to be well below $f\_s/2$. However, in modern power-electronic-based power systems (e.g., microgrids, data centers), where multiple converters are interconnected, this limitation is severe. SSA-based models *cannot* predict high-frequency, frequency-coupling interactions (such as beat frequency oscillations) that can occur between converters.1 For analyzing such system-level stability, more advanced techniques like Harmonic State-Space (HSS) modeling are required.1

## **Canonical Transfer Functions of Fundamental Converters (CCM)**

The application of the State-Space Averaging technique to the fundamental converter topologies (Buck, Boost, and Buck-Boost) yields a set of "canonical" small-signal transfer functions. These models, as detailed in the authoritative textbook *Fundamentals of Power Electronics* by Erickson and Maksimovic, form the basis of practical control design.16 The following are the control-to-output transfer functions, $G\_{vd}(s)$, for these converters operating in Continuous Conduction Mode (CCM).

### **Analysis of the Buck Converter**

The $G\_{vd}(s)$ of an ideal Buck converter is a second-order system.23 Its dynamics are dominated by the output $LC$ filter.24

* Canonical Form: The transfer function is written in a standardized form to expose its salient features:

  $$G\_{vd}(s) \= G\_{d0} \\frac{1 \+ \\frac{s}{\\omega\_{z,ESR}}}{1 \+ \\frac{s}{Q\\omega\_0} \+ (\\frac{s}{\\omega\_0})^2}$$  
  23  
* **Key Features:**  
  * **DC Gain ($G\_{d0}$):** $G\_{d0} \= V\_g$. (Note: $V\_g$ is the DC input voltage. Some texts use $V/D$, where $V$ is the output voltage; since $V=DV\_g$, these are equivalent).13  
  * **Resonant Pole ($\\omega\_0$):** $\\omega\_0 \= \\frac{1}{\\sqrt{LC}}$.13 This is the resonant frequency of the output filter.  
  * **Quality Factor ($Q$):** $Q \= R\\sqrt{\\frac{C}{L}}$.13  
  * **ESR Zero ($\\omega\_{z,ESR}$):** $\\omega\_{z,ESR} \= \\frac{1}{ESR \\cdot C}$.24  
* The Quality Factor $Q$ is a strong function of the load resistance $R$. A light load (high $R$) results in a high $Q$. This causes significant gain "peaking" at the resonant frequency $\\omega\_0$ and a very rapid \-180° phase shift, a condition which is more difficult to stabilize than a heavily loaded (low $Q$) converter.

### **Analysis of the Boost Converter**

The Boost converter is an "indirect energy transfer" topology, which fundamentally alters its transfer function by introducing a Right-Half-Plane Zero (RHPZ).27

* Canonical Form:

  $$G\_{vd}(s) \= G\_{d0} \\frac{(1 \- \\frac{s}{\\omega\_{RHPZ}})(1 \+ \\frac{s}{\\omega\_{z,ESR}})}{1 \+ \\frac{s}{Q\\omega\_0} \+ (\\frac{s}{\\omega\_0})^2}$$  
  14  
* **Key Features:**  
  * **DC Gain ($G\_{d0}$):** $G\_{d0} \= \-\\frac{V}{D'}$. (Where $V$ is the output voltage and $D' \= 1-D$).13  
  * **Resonant Pole ($\\omega\_0$):** $\\omega\_0 \= \\frac{D'}{\\sqrt{LC}}$.13  
  * **Quality Factor ($Q$):** $Q \= D'R\\sqrt{\\frac{C}{L}}$.13  
  * **Right-Half-Plane Zero ($\\omega\_{RHPZ}$):** $\\omega\_{z} \= \\frac{D'^2R}{L}$.13  
* Unlike the Buck converter, the Boost converter's key dynamic features ($\\omega\_0$, $Q$, and $\\omega\_{RHPZ}$) are all strong functions of the steady-state operating point ($D'$ and $R$).14 As the input voltage $V\_g$ decreases, the duty cycle $D$ must increase, causing $D'$ to decrease. This, in turn, *lowers* the resonant frequency and the RHPZ frequency. The controller must be designed to be robust and stable across this wide variation in "plant" dynamics.

### **Analysis of the Buck-Boost Converter**

The Buck-Boost converter, also an indirect energy transfer topology, shares the same challenging control characteristics as the Boost converter.29

* **Key Features:** Its $G\_{vd}(s)$ is qualitatively identical to the Boost converter's, possessing the same set of features.  
  * **Resonant Pole ($\\omega\_0$):** $\\omega\_0 \= \\frac{D'}{\\sqrt{LC}}$.13  
  * **Quality Factor ($Q$):** $Q \= D'R\\sqrt{\\frac{C}{L}}$.13  
  * **Right-Half-Plane Zero ($\\omega\_{RHPZ}$):** $\\omega\_{z} \= \\frac{D'^2R}{L}$.13

The salient features for the CCM control-to-output transfer functions of these basic converters are summarized in Table 1\. This table codifies the mathematical output of the SSA modeling process into a practical reference. The most striking contrast is between the Buck converter and the Boost/Buck-Boost topologies. The appearance of the $D'$ term in the dynamics of the latter, and most critically, the presence of a finite Right-Half-Plane Zero ($\\omega\_z$) versus infinity for the Buck, mathematically illustrates why the Buck converter is fundamentally simpler to control.

Table 1: Canonical Small-Signal Features of CCM Converters  
(Source: Extracted from Erickson & Maksimovic, as cited in 13\)

| Converter | DC Gain (Gd0​) | Resonant Pole (ω0​) | Quality Factor (Q) | RHP Zero (ωz​) |
| :---- | :---- | :---- | :---- | :---- |
| **Buck** | $\\frac{V}{D}$ (or $V\_g$) | $\\frac{1}{\\sqrt{LC}}$ | $R\\sqrt{\\frac{C}{L}}$ | $\\infty$ (none) |
| **Boost** | $-\\frac{V}{D'}$ | $\\frac{D'}{\\sqrt{LC}}$ | $D'R\\sqrt{\\frac{C}{L}}$ | $\\frac{D'^2R}{L}$ |
| **Buck-Boost** | $-\\frac{V}{D'}$ | $\\frac{D'}{\\sqrt{LC}}$ | $D'R\\sqrt{\\frac{C}{L}}$ | $\\frac{D'^2R}{L}$ |

## **A Deep-Dive Analysis of Transfer Function Poles and Zeros**

Understanding the mathematical location of poles and zeros is the first step. Understanding their *physical origin* and *control implications* is the key to effective compensator design.25

### **The Output Filter Resonance (The $LC$ Double Pole, $f\_0$)**

* **Physical Origin:** This feature is the most intuitive. It is the natural, second-order resonant frequency of the output inductor ($L$) and output capacitor ($C$) acting as a classic passive $LC$ filter.24  
* **Bode Plot Signature:** This complex double pole, located at $f\_0 \= \\omega\_0 / (2\\pi)$, dominates the voltage-mode transfer function. It introduces a sharp gain roll-off of **\-40 dB/decade** and, most problematically, a sudden **\-180° phase shift** in the loop gain.23  
* **Control Implication (The Core Problem):** This \-180° phase lag from the plant is the central challenge of voltage-mode control. A practical compensator requires an integrator (a pole at the origin) to achieve zero steady-state error, which contributes its own \-90° phase lag. The combination ($180^\\circ \+ 90^\\circ \= 270^\\circ$) results in a total phase lag of \-270° well before the crossover frequency, making the loop unconditionally unstable without proper compensation.32 The entire goal of compensator design is to strategically add phase *boost* to counteract this \-180° drop at the desired crossover frequency.33

### **The Output Capacitor ESR Zero ($f\_{z,ESR}$)**

* **Physical Origin:** This zero is not an intended design feature but a consequence of a real-world component parasitic: the **Equivalent Series Resistance (ESR)** of the output capacitor ($C$).26 At low frequencies, the capacitor's impedance is dominated by its capacitance ($Z \\approx 1/sC$). At very high frequencies, the capacitance becomes a short, and the impedance is dominated by its resistance ($Z \\approx ESR$). The ESR zero occurs at the frequency where these two impedance contributions are equal: $f\_{z,ESR} \= 1 / (2 \\pi \\cdot ESR \\cdot C)$.24  
* **Bode Plot Signature:** This is a **Left-Half-Plane (LHP) zero**. In the gain plot, it stops the \-40 dB/decade roll-off from the $LC$ poles and flattens it to \-20 dB/decade. Critically, in the phase plot, it provides a **\+90° phase lead** (the opposite of a pole).26  
* **Control Implication (The Old Solution vs. The Modern Problem):**  
  * *The Old Solution:* For decades, designers *relied* on this \+90° phase boost.34 Standard electrolytic or tantalum output capacitors had a "just right" amount of ESR, which conveniently placed $f\_{z,ESR}$ just after the $LC$ resonance $f\_0$. This phase boost naturally stabilized the loop, allowing for a simple (Type II) compensator.35  
  * *The Modern Problem:* The modern trend toward low-cost, high-density, and low-ripple designs favors **Multilayer Ceramic Capacitors (MLCCs)**.34 MLCCs have a *near-zero ESR*.34 This low ESR pushes $f\_{z,ESR}$ to an extremely high frequency, often above $f\_s/2$.32 The result is that the beneficial \+90° phase boost *vanishes* from the frequency range of interest (i.e., below $f\_s/2$). This *removes* the natural stabilization and is the direct reason why voltage-mode converters using all-ceramic output capacitors are inherently unstable and *require* a more complex (Type III) compensator to add the phase boost back in.32

### **The Right-Half-Plane Zero ($f\_{RHPZ}$)**

* **Physical Origin (The Two-Step Energy Transfer):** This is the most counter-intuitive and challenging feature in power electronics. The RHPZ is a fundamental, unavoidable property of any topology with *indirect* energy transfer, such as the Boost, Buck-Boost, and Flyback converters.27 Its origin lies in the two-step power conversion process:  
  1. **Step 1 (Switch ON, $D \\cdot T\_s$):** The inductor is connected to the source, and energy is *stored*. No energy is delivered to the output.28  
  2. **Step 2 (Switch OFF, $(1-D) \\cdot T\_s$):** The inductor's stored energy is *delivered* to the output capacitor and load.28  
  * **The RHPZ Event:** Consider the output voltage sagging. The control loop demands more power. To do this, it commands a *longer* duty cycle, $D$, to store more energy in the inductor. However, by *increasing* the "store" time $D$, it simultaneously *decreases* the "deliver" time $(1-D)$.27 The immediate, instantaneous effect is that *less* energy is delivered to the output. The output voltage *first dips* (goes the "wrong way") before the increased average inductor current can build up and cause it to rise.36  
* **Bode Plot Signature:** This "wrong way" transient response manifests in the s-domain as a **Right-Half-Plane (RHP) zero**. On a Bode plot, it exhibits the same **\+20 dB/decade gain** as a normal (LHP) zero, but it contributes a catastrophic **\-90° phase lag** (the same as a pole).36  
* **Control Implication (The Hard Bandwidth Limit):** This feature is "difficult if not impossible to compensate".36 The combination of *rising gain* (which pushes the loop toward 0 dB) and *falling phase* (which pushes the loop toward \-180°) is the worst-possible scenario for a feedback loop, as it rapidly destroys phase margin.37 The designer has no choice but to concede to this limitation. The loop gain *must* be rolled off, and the crossover frequency ($f\_c$) set *well below* the RHPZ frequency. The standard industry rule of thumb is to set the crossover frequency $f\_c \\le f\_{RHPZ} / 3$, or 20%-30% of the RHPZ frequency, to keep the additional phase lag from the RHPZ to a manageable level (e.g., \< 20°).38 This places a *fundamental topological limit* on the transient response speed of Boost and Buck-Boost converters, a limit that cannot be overcome by simply increasing the switching frequency.36

## **Bode Plot Interpretation and Stability Criteria**

The Bode plot is the primary frequency-domain tool used to analyze the open-loop gain and design a compensator that ensures closed-loop stability.25

### **The Open-Loop Gain ($T(s)$)**

For a typical voltage-mode converter, the system is a closed loop. The total **open-loop gain**, $T(s)$, is the product of the transfer functions of all blocks inside the loop: the power stage (plant) $G\_{vd}(s)$, the error amplifier (compensator) $G\_c(s)$, and the feedback and modulator stage $H(s)$.14

$T(s) \= G\_{vd}(s) \\cdot G\_c(s) \\cdot H(s)$

Stability of the entire closed-loop system is determined by analyzing the Bode plot of this open-loop transfer function, $T(s)$.40

### **Nyquist and Bode Stability Criteria**

The formal basis for stability in feedback systems is the **Nyquist Criterion**. It states that a closed-loop system is stable if the Nyquist plot of $T(s)$ (a polar plot of gain versus phase) does not encircle the critical (-1, 0\) point.42

The **Bode Criterion** is a practical and intuitive simplification of the Nyquist criterion.42 The critical (-1, 0\) point in the Nyquist domain corresponds to two conditions being met simultaneously: a gain of 1 (or 0 dB) and a phase shift of \-180°.42 The Bode plot "unrolls" the Nyquist plot, allowing us to check these two conditions on separate graphs.

This simplification, however, has a critical caveat. The Bode criterion is only a reliable proxy for the Nyquist criterion in simple systems that have only one 0 dB crossover frequency and one \-180° phase crossover frequency. In complex, high-order systems 66, the gain may cross 0 dB multiple times. In such cases, a system can display "good" phase and gain margins at the primary crossover, yet still be "conditionally stable" and dangerously close to the (-1, 0\) point at another frequency.42 Therefore, it is essential to inspect the *entire* Bode plot for such unusual gain/phase interactions, not just the single-point metrics.42

### **Key Stability Metrics**

The Bode plot of $T(s)$ is used to measure three key metrics that define the loop's stability and performance 40:

* **Crossover Frequency ($f\_c$ or $f\_{BW}$):**  
  * **Definition:** The frequency at which the magnitude of the loop gain $|T(s)|$ equals 1, or **0 dB**.43  
  * **Significance:** This is the *bandwidth* of the control loop.47 It is the primary indicator of the *speed* of the converter. A higher crossover frequency $f\_c$ directly translates to a faster response to load changes and a quicker settling time.40  
* **Phase Margin (PM):**  
  * **Definition:** Measured *at the crossover frequency ($f\_c$)*. It is defined as the difference between the loop's phase at that frequency and \-180°.43 Mathematically: $PM \= \\angle T(j\\omega\_c) \- (-180^\\circ)$.41  
  * **Significance:** This is the single most critical measure of stability. It determines the *damping* of the closed-loop system.48  
* **Gain Margin (GM):**  
  * **Definition:** Measured *at the phase crossover frequency ($f\_{pc}$)*, which is the frequency where the loop's phase first crosses \-180°.43 The Gain Margin is the amount of gain (in dB) *below* 0 dB at that frequency.43  
  * **Significance:** This measures the system's robustness against gain variations (e.g., from component tolerances). A low GM indicates that a small, unexpected increase in plant gain could cause the system to become unstable.40

### **Design Targets and Transient Response**

These metrics are not just analytical; they form the concrete targets for the design process.

* **Quantitative Design Targets:**  
  * **Phase Margin (PM):** While any positive PM is *technically* stable, a PM below 30° is unreliable and results in a highly oscillatory response.48 The standard industry minimum requirement is **45°**.35 A more conservative and highly recommended target for a well-damped response is **60°**.47  
  * **Gain Margin (GM):** A minimum of **8 dB to 10 dB** is the standard target to ensure robust stability.47  
  * **Crossover Frequency ($f\_c$):** This is a performance target. It is set as high as possible for a fast response, but is limited by two factors: (1) it must be *well below* the RHPZ frequency (if one exists) 38, and (2) it must be limited to **1/10 to 1/5 of the switching frequency ($f\_s$)**.35 This upper limit $f\_s/5$ is necessary to avoid amplifying the switching ripple and to respect the $f\_s/2$ validity limit of the small-signal model itself.

There is a direct, causal relationship between the measured Phase Margin and the converter's time-domain transient response to a load step 48:

* **Low PM (\< 30°):** *Causes* a highly underdamped response. This is visible on an oscilloscope as significant voltage overshoot/undershoot and multiple "rings" or oscillations before settling.48  
* **High PM (e.g., 60°-75°):** *Causes* a well-damped response. The output voltage has minimal overshoot and settles quickly to its new steady state. This is the ideal response.48  
* **Very High PM (\> 75°):** *Causes* an overdamped, "sluggish" response. The system is extremely stable but slow to react. The 60° target is widely considered the optimal trade-off between speed and stability.54

## **Practical Compensator Design for Loop Stabilization**

The final step is synthesis: designing a compensator, $G\_c(s)$, that manipulates the poles and zeros of the total loop gain, $T(s)$, to "fix" the plant's $G\_{vd}(s)$ and achieve the stability targets from Section 4\.39

### **The Compensator's Role**

The compensator is an error amplifier (either an op-amp or a transconductance amplifier) with a specific RC network.33 Its purpose is to re-shape the $T(s)$ Bode plot to achieve three goals:

1. Provide very high gain at DC (an integrator pole at the origin) to ensure high-accuracy DC voltage regulation.  
2. Force the loop gain to cross 0 dB at the desired crossover frequency ($f\_c$) with a stable **\-20 dB/decade slope**.35  
3. Ensure that at $f\_c$, the Phase Margin is \> 45° and the Gain Margin is \> 8 dB.35

This is accomplished using two primary compensator topologies: Type II and Type III.52

### **Type II Compensation (PI Controller)**

* **Topology:** A Type II compensator provides one pole at the origin (the integrator), one zero ($f\_{z1}$), and one high-frequency pole ($f\_{p1}$).33 It provides a maximum of \+90° phase boost.  
* **Application:** This simple compensator is suitable in two main scenarios:  
  1. **Current-Mode Control (CMC):** In CMC, the inner current loop effectively "hides" the inductor from the outer voltage loop, making the plant $G\_{vd}(s)$ behave like a simple, single-pole system.47 A Type II compensator is all that is needed to stabilize this first-order system.47  
  2. **Voltage-Mode Control (VMC) with High-ESR Capacitors:** This compensator is used when the plant's ESR zero ($f\_{z,ESR}$) is *below* the target crossover frequency ($f\_c$).35 This is typical for converters using electrolytic or tantalum output capacitors.  
* **Pole-Zero Placement Strategy (VMC w/ High-ESR):**  
  * **Compensator Zero ($f\_{z1}$):** Place $f\_{z1}$ to *cancel* the plant's $LC$ double pole, $f\_0$. A common rule is $f\_{z1} \\approx 0.75 \\cdot f\_0$.35  
  * **Compensator Pole ($f\_{p1}$):** Place $f\_{p1}$ to *cancel* the plant's ESR zero, $f\_{z,ESR}$.35  
  * The result is a $T(s)$ where the plant's poles are canceled by the compensator's zero, and the plant's zero is canceled by the compensator's pole, leaving a dominant \-20 dB/decade slope.

### **Type III Compensation (PID Controller)**

* **Topology:** A Type III compensator is a more complex network. It provides one pole at the origin, **two zeros ($f\_{z1}, f\_{z2}$)**, and **two high-frequency poles ($f\_{p1}, f\_{p2}$)**.33  
* **Application (The Critical Use Case):** This compensator is *essential* for VMC converters when the plant's $f\_{z,ESR}$ is *above* the target $f\_c$.35 This is the *defining characteristic* of using **low-ESR MLCC output capacitors**.32  
* The causal chain for its selection is:  
  1. MLCC output capacitors are chosen for their small size and low output ripple.35  
  2. Their near-zero ESR pushes $f\_{z,ESR}$ to a very high frequency.32  
  3. The plant $G\_{vd}(s)$ now has a severe \-180° phase drop at $f\_0$ with *no* compensating phase boost from an ESR zero.32  
  4. A Type II compensator, with only one zero, can only provide a maximum of \+90° of phase boost, which is insufficient to counter a \-180° drop and maintain phase margin.57  
  5. Therefore, a Type III compensator is *required*. Its **two zeros** can be placed together to provide up to **\+180° of phase boost**, which *can* directly counteract the \-180° lag from the $LC$ filter.32  
* **Pole-Zero Placement Strategy (VMC w/ Ceramic):**  
  * **Compensator Zeros ($f\_{z1}, f\_{z2}$):** Place both zeros *at* or *near* the plant's $LC$ resonant frequency, $f\_0$.52 This "PID" action uses the \+180° phase boost from the zeros to *directly cancel* the \-180° phase lag from the $LC$ poles.  
  * **Compensator Poles ($f\_{p1}, f\_{p2}$):** These poles are placed at higher frequencies to roll off the compensator's gain.  
    * $f\_{p1}$ is typically placed at the (now very high) $f\_{z,ESR}$.35  
    * $f\_{p2}$ is typically placed at or just below half the switching frequency ($f\_s/2$) to ensure attenuation of switching noise.35

This selection logic is summarized in Table 2, which provides a practical guide for connecting the plant analysis to the compensation solution.

**Table 2: Compensator Selection and Pole-Zero Placement Strategy**

| Plant Type / Control Mode | Key Plant Features | Required Compensator | Compensator Zeros Placement (fz1​,fz2​) | Compensator Poles Placement (fp1​,fp2​) |
| :---- | :---- | :---- | :---- | :---- |
| **VMC Buck** (High-ESR / Electrolytic Cap) | $f\_{LC} \< f\_{z,ESR} \< f\_c$ | **Type II** | $f\_{z1}$ at $f\_{LC}$ | $f\_{p1}$ at $f\_{z,ESR}$ |
| **VMC Buck** (Low-ESR / Ceramic Cap) | $f\_{LC} \< f\_c \< f\_s/2 \< f\_{z,ESR}$ | **Type III** | $f\_{z1}, f\_{z2}$ at $f\_{LC}$ | $f\_{p1}$ at $f\_{z,ESR}$, $f\_{p2}$ at $f\_s/2$ |
| **Current-Mode (CMC) Buck** (Any Cap) | Plant is 1st-Order | **Type II** | $f\_{z1}$ at Plant Pole | $f\_{p1}$ at $f\_{z,ESR}$ or $f\_s/2$ |
| **VMC Boost / Buck-Boost** (Any Cap) | $f\_{RHPZ}$ exists | **Type II / III** | *(Placement as above, but with a critical caveat)* | *(Placement as above, but with a critical caveat)* |
| *Caveat for RHPZ Topologies* | $f\_c$ *must* be set $\\ll f\_{RHPZ}$ (e.g., $f\_c \\le f\_{RHPZ}/3$).38 This constraint *overrides* all other placement goals and limits the achievable bandwidth. |  |  |  |

### **A Step-by-Step Design Example (VMC Buck w/ Ceramic Capacitors)**

This process can be demonstrated with a narrative, step-by-step design procedure based on industry-standard application notes.33

1. **Collect System Parameters:** A VMC Buck converter is specified with $L=1.0 \\mu H$, $C=100 \\mu F$ (MLCC), $ESR \= 1 m\\Omega$, and $f\_s \= 500 kHz$.35  
2. **Analyze the Plant:** The plant's pole and zero frequencies are calculated 35:  
   * $f\_0 \= 1 / (2\\pi\\sqrt{LC}) \= 1 / (2\\pi\\sqrt{1\\mu H \\cdot 100\\mu F}) \\approx 15.9 kHz$  
   * $f\_{z,ESR} \= 1 / (2\\pi \\cdot ESR \\cdot C) \= 1 / (2\\pi \\cdot 1m\\Omega \\cdot 100\\mu F) \\approx 1.59 MHz$  
3. **Select Target $f\_c$:** A high bandwidth is desired. The $f\_c$ is targeted at $1/10$ of $f\_s$: $f\_c \= 500 kHz / 10 \= 50 kHz$.35  
4. **Determine Compensation Type:** The designer compares the frequencies:  
   * $f\_0$ (15.9 kHz) \< $f\_c$ (50 kHz) \< $f\_s/2$ (250 kHz) \< $f\_{z,ESR}$ (1.59 MHz)  
   * Based on the condition $F\_{LC} \< F\_0 \< F\_S/2 \< F\_{ESR}$, the design *requires a Type III-B compensator*.35  
5. **Place Compensator Poles/Zeros:** Following the strategy from Section 5.3 52:  
   * Place the two zeros to cancel the $LC$ pole: $f\_{z1} \= f\_{z2} \= f\_0 \= 15.9 kHz$.  
   * Place the two poles to roll off the gain: $f\_{p1} \= f\_s/2 \= 250 kHz$ and $f\_{p2} \= f\_{z,ESR} \= 1.59 MHz$. (The pole at $f\_s/2$ provides noise attenuation, while the other cancels the ESR zero).  
6. **Calculate R/C Values:** The designer uses the standard equations for a Type III op-amp circuit 33 to solve for the specific R1, R2, R3, C1, C2, C3 values that produce these exact pole/zero frequencies. This process is often automated using design tools like LTpowerCAD or TI-PSpice.32

## **Experimental Verification and Measurement**

The design process does not end with calculation. The final, critical step is to perform model verification on a hardware prototype.60 It is "good engineering practice" to measure the converter's transfer functions to verify that the mathematical model was correct and that the designed compensator achieves the target stability margins.12

### **The Method: Voltage Injection (Middlebrook's Method)**

A feedback loop cannot be physically "opened" for measurement, as the circuit would lose its DC operating point. The standard technique used to measure the open-loop gain of a *running, closed-loop* system is the **voltage injection method**, also pioneered by R.D. Middlebrook.61

* **Setup:** A small injection resistor (e.g., 5-10 $\\Omega$) is inserted into the feedback path (typically in series with the feedback resistor to the op-amp's inverting input). A small, sweeping-frequency AC signal is then "injected" across this resistor using an isolation transformer.61  
* **Instrumentation:** A Vector Network Analyzer (VNA) or Frequency Response Analyzer (FRA) is used.61 Modern high-end oscilloscopes often have this capability built-in.62  
* **Measurement:** The VNA connects two probes, one at each side of the injection resistor (call them point A and point B). It then sweeps the injection frequency and measures the complex voltage ratio $V(B) / V(A)$. This measured ratio is, by definition, the open-loop gain $T(s)$ of the system.61

### **Interpreting the Measured Bode Plot**

The VNA or FRA directly displays the measured $T(s)$ as a Bode plot, showing both the gain and phase curves versus frequency.40 The designer can then read the *actual, hardware-verified* stability metrics from this plot 40:

1. Locate the 0 dB crossing on the gain plot to find the *measured* **crossover frequency ($f\_c$)**.  
2. At that *exact* frequency, read the phase from the phase plot to find the *measured* **Phase Margin (PM)**.  
3. Locate the \-180° crossing on the phase plot to find the *measured* **Gain Margin (GM)**.

This final measurement "closes the loop" on the entire design-oriented analysis, confirming that the physical prototype meets the stability targets (e.g., PM \> 45° and GM \> 8 dB) and is a robust, stable, and well-designed product.

#### **Works cited**

1. Review of Small-Signal Modeling Methods Including Frequency-Coupling Dynamics of Power Converters \- Aalborg Universitets forskningsportal, accessed October 29, 2025, [https://vbn.aau.dk/files/306353873/08410450.pdf](https://vbn.aau.dk/files/306353873/08410450.pdf)  
2. Modified input-to-output and control-to-output transfer functions of a non-ideal buck converter working in discontinuous conduction mode, accessed October 29, 2025, [https://journals.pan.pl/Content/133388/PDF/11\_5k.pdf?handler=pdf](https://journals.pan.pl/Content/133388/PDF/11_5k.pdf?handler=pdf)  
3. Alternative Way to Develop Small-Signal Models of Power Converters, accessed October 29, 2025, [https://www.ieee-pels.org/magazine/alternative-way-to-develop-small-signal-models-of-power-converters/](https://www.ieee-pels.org/magazine/alternative-way-to-develop-small-signal-models-of-power-converters/)  
4. A GENERAL UNIFIED APPROACH TO ... \- Mikrocontroller.net, accessed October 29, 2025, [https://www.mikrocontroller.net/attachment/124600/SSA\_Cuk\_Middlebrook.pdf](https://www.mikrocontroller.net/attachment/124600/SSA_Cuk_Middlebrook.pdf)  
5. A general unified approach to modelling switching-converter power stages \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/336049492\_A\_general\_unified\_approach\_to\_modelling\_switching-converter\_power\_stages](https://www.researchgate.net/publication/336049492_A_general_unified_approach_to_modelling_switching-converter_power_stages)  
6. Middlebrook, R.D. and Cuk, S. (1976) A General Unified Approach to Modelling Switching-Converter Power Stages. 1976 IEEE Power Electronics Specialists Conference, Cleveland, 8-10 June 1976, 18-34. \- References \- Scientific Research Publishing, accessed October 29, 2025, [https://www.scirp.org/reference/referencespapers?referenceid=2989883](https://www.scirp.org/reference/referencespapers?referenceid=2989883)  
7. State Space Averaging Technique of Power Converter with Digital PID Controller \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/profile/Mohammad-Faridun-Naim-Tajuddin/publication/224106992\_State\_space\_averaging\_technique\_of\_power\_converter\_with\_digital\_PID\_controller/links/54695f430cf20dedafd0d883/State-space-averaging-technique-of-power-converter-with-digital-PID-controller.pdf](https://www.researchgate.net/profile/Mohammad-Faridun-Naim-Tajuddin/publication/224106992_State_space_averaging_technique_of_power_converter_with_digital_PID_controller/links/54695f430cf20dedafd0d883/State-space-averaging-technique-of-power-converter-with-digital-PID-controller.pdf)  
8. State-space average Modeling of DC-DC Converters with parasitic in Discontinuous Conduction Mode (DCM). Prof. S. Samanta \- CORE, accessed October 29, 2025, [https://core.ac.uk/download/pdf/53187372.pdf](https://core.ac.uk/download/pdf/53187372.pdf)  
9. Small Signal Modelling of a Buck Converter using State Space Averaging for Magnet Load \- Paper Publications, accessed October 29, 2025, [https://www.paperpublications.org/upload/book/Small%20Signal%20Modelling-783.pdf](https://www.paperpublications.org/upload/book/Small%20Signal%20Modelling-783.pdf)  
10. A general unified approach to modelling switching-converter power stages \- SciSpace, accessed October 29, 2025, [https://scispace.com/pdf/a-general-unified-approach-to-modelling-switching-converter-71l6bkfbjq.pdf](https://scispace.com/pdf/a-general-unified-approach-to-modelling-switching-converter-71l6bkfbjq.pdf)  
11. Modelling and Control of a Buck Converter Using State-Space Averaging and Classical Feedback Techniques \- arXiv, accessed October 29, 2025, [https://arxiv.org/pdf/2507.09115](https://arxiv.org/pdf/2507.09115)  
12. Converter Transfer Functions, accessed October 29, 2025, [https://uodiyala.edu.iq/uploads/PDF%20ELIBRARY%20UODIYALA/EL23/powerfundamentals.pdf](https://uodiyala.edu.iq/uploads/PDF%20ELIBRARY%20UODIYALA/EL23/powerfundamentals.pdf)  
13. Exp. 4, Part 2 \- UTK-EECS, accessed October 29, 2025, [https://web.eecs.utk.edu/\~dcostine/ECE482/materials/ACTutorial.pdf](https://web.eecs.utk.edu/~dcostine/ECE482/materials/ACTutorial.pdf)  
14. Voltage Mode Boost Converter Small Signal Control Loop Analysis Using the TPS61030 \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slva274](https://www.ti.com/lit/pdf/slva274)  
15. Generalized Averaging Method for Power Conversion Circuits \* \- DSpace@MIT, accessed October 29, 2025, [https://dspace.mit.edu/bitstream/handle/1721.1/3200/P-1970-21542778.pdf](https://dspace.mit.edu/bitstream/handle/1721.1/3200/P-1970-21542778.pdf)  
16. Fundamentals of Power Electronics \- SciSpace, accessed October 29, 2025, [https://scispace.com/pdf/fundamentals-of-power-electronics-57kz8pj23p.pdf](https://scispace.com/pdf/fundamentals-of-power-electronics-57kz8pj23p.pdf)  
17. Chapter 11 AC and DC Equivalent Circuit Modeling of the Discontinuous Conduction Mode, accessed October 29, 2025, [https://ieee.li/pdf/introduction\_to\_power\_electronics/chapter\_11.pdf](https://ieee.li/pdf/introduction_to_power_electronics/chapter_11.pdf)  
18. Small Signal Equivalent Circuit Modeling of Resonant Converters \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/3279056\_Small\_Signal\_Equivalent\_Circuit\_Modeling\_of\_Resonant\_Converters](https://www.researchgate.net/publication/3279056_Small_Signal_Equivalent_Circuit_Modeling_of_Resonant_Converters)  
19. Aalborg Universitet Harmonic State Space (HSS) Modeling for Power Electronic Based Power Systems Kwon, Jun Bum, accessed October 29, 2025, [https://vbn.aau.dk/files/549544075/PHD\_Jun\_Bum\_Kwon\_E\_pdf.pdf](https://vbn.aau.dk/files/549544075/PHD_Jun_Bum_Kwon_E_pdf.pdf)  
20. Textbook | Prof. Robert Erickson | University of Colorado Boulder, accessed October 29, 2025, [https://www.colorado.edu/faculty/erickson/textbook](https://www.colorado.edu/faculty/erickson/textbook)  
21. Fundamentals of Power Electronics \- Robert W. Erickson, Dragan Maksimovic \- Google Books, accessed October 29, 2025, [https://books.google.com/books/about/Fundamentals\_of\_Power\_Electronics.html?id=B4XhBwAAQBAJ](https://books.google.com/books/about/Fundamentals_of_Power_Electronics.html?id=B4XhBwAAQBAJ)  
22. Fundamentals of Power Electronics, accessed October 29, 2025, [https://fmipa.umri.ac.id/wp-content/uploads/2016/03/R.\_Erickson\_Fundamentals\_of\_Power\_Electronics\_pBookZZ.org\_.pdf](https://fmipa.umri.ac.id/wp-content/uploads/2016/03/R._Erickson_Fundamentals_of_Power_Electronics_pBookZZ.org_.pdf)  
23. Switch-Mode Power Converter Compensation ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/seclit/ml/slup341/slup341.pdf](https://www.ti.com/seclit/ml/slup341/slup341.pdf)  
24. APPLICATION NOTE ANP22 Filter Design in Continuous Conduction Mode \- MaxLinear, accessed October 29, 2025, [https://www.maxlinear.com/appnote/anp-22\_filterdesign\_b\_010407.pdf](https://www.maxlinear.com/appnote/anp-22_filterdesign_b_010407.pdf)  
25. Chapter 8\. Converter Transfer Functions, accessed October 29, 2025, [https://imserv.org/MFKForum/Datasheets/Fundamentals%20of%20power%20electronics/ecee.colorado.edu/copec/book/slides/Ch8slide.pdf](https://imserv.org/MFKForum/Datasheets/Fundamentals%20of%20power%20electronics/ecee.colorado.edu/copec/book/slides/Ch8slide.pdf)  
26. Engineers note: Capacitors are key to voltage ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/snoa842](https://www.ti.com/lit/snoa842)  
27. RHPZ in converter transfering the energy in a two steps approach \-\> mathematical model \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/529121/rhpz-in-converter-transfering-the-energy-in-a-two-steps-approach-mathematical](https://electronics.stackexchange.com/questions/529121/rhpz-in-converter-transfering-the-energy-in-a-two-steps-approach-mathematical)  
28. The Right−Half –Plane Zero, a Two-Way Control Path, accessed October 29, 2025, [https://powersimtof.com/Downloads/Papers/RHPZ,%20a%20two%20way%20control%20path.pdf](https://powersimtof.com/Downloads/Papers/RHPZ,%20a%20two%20way%20control%20path.pdf)  
29. (PDF) A novel modulation for four‐switch Buck‐boost converter to eliminate the right half plane zero point \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/381773957\_A\_novel\_modulation\_for\_four-switch\_Buck-boost\_converter\_to\_eliminate\_the\_right\_half\_plane\_zero\_point](https://www.researchgate.net/publication/381773957_A_novel_modulation_for_four-switch_Buck-boost_converter_to_eliminate_the_right_half_plane_zero_point)  
30. Buck-Boost and the RHPZ story \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=zxxEHAp6jBc](https://www.youtube.com/watch?v=zxxEHAp6jBc)  
31. AN-1319: Compensator Design for a Battery Charge/Discharge Unit Using the AD8450 or the AD8451 | Analog Devices, accessed October 29, 2025, [https://www.analog.com/en/resources/app-notes/an-1319.html](https://www.analog.com/en/resources/app-notes/an-1319.html)  
32. AN-149: Modeling and Loop Compensation Design of Switching ..., accessed October 29, 2025, [https://www.analog.com/en/resources/app-notes/an-149.html](https://www.analog.com/en/resources/app-notes/an-149.html)  
33. Demystifying Type II and Type III Compensators Using Op Amp and OTA for DC/DC Converters \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slva662](https://www.ti.com/lit/pdf/slva662)  
34. What is an ESR zero in a power converter's output filter?, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/447964/what-is-an-esr-zero-in-a-power-converters-output-filter](https://electronics.stackexchange.com/questions/447964/what-is-an-esr-zero-in-a-power-converters-output-filter)  
35. Compensator design procedure for buck converter with voltage-mode error-amplifier \- Infineon Technologies, accessed October 29, 2025, [https://www.infineon.com/dgdl/an-1162.pdf?fileId=5546d462533600a40153559a8e17111a](https://www.infineon.com/dgdl/an-1162.pdf?fileId=5546d462533600a40153559a8e17111a)  
36. Seminar 500 DRA \- The Right-Half-Plane Zero \- A ... \- TI E2E, accessed October 29, 2025, [https://e2e.ti.com/cfs-file/\_\_key/communityserver-discussions-components-files/196/slup084.pdf](https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/196/slup084.pdf)  
37. The Right Half-Plane Zero and Its Effect on Stability \- Technical Articles \- All About Circuits, accessed October 29, 2025, [https://www.allaboutcircuits.com/technical-articles/the-right-half-plane-zero-and-its-effect-on-stability/](https://www.allaboutcircuits.com/technical-articles/the-right-half-plane-zero-and-its-effect-on-stability/)  
38. Understanding the Right-Half-Plane Zero | Electronic Design, accessed October 29, 2025, [https://www.electronicdesign.com/technologies/power/article/21190993/understanding-the-right-half-plane-zero](https://www.electronicdesign.com/technologies/power/article/21190993/understanding-the-right-half-plane-zero)  
39. Switch-mode power converter compensatin made easy \- TI E2E, accessed October 29, 2025, [https://e2e.ti.com/cfs-file/\_\_key/communityserver-discussions-components-files/196/0412.slup340.pdf](https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/196/0412.slup340.pdf)  
40. Understanding Bode plots | Rohde & Schwarz, accessed October 29, 2025, [https://www.rohde-schwarz.com/uk/products/test-and-measurement/essentials-test-equipment/digital-oscilloscopes/understanding-bode-plots\_254514.html](https://www.rohde-schwarz.com/uk/products/test-and-measurement/essentials-test-equipment/digital-oscilloscopes/understanding-bode-plots_254514.html)  
41. Loop Stability Analysis of Voltage Mode Buck ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slva301](https://www.ti.com/lit/pdf/slva301)  
42. Understand Power Supply Loop Stability and Loop Compensation \- Part 1: Basic Concepts and Tools | Analog Devices, accessed October 29, 2025, [https://www.analog.com/en/resources/technical-articles/power-supply-loop-stability-loop-compensation.html](https://www.analog.com/en/resources/technical-articles/power-supply-loop-stability-loop-compensation.html)  
43. Understanding Bode plots | Rohde & Schwarz, accessed October 29, 2025, [https://www.rohde-schwarz.com/us/products/test-and-measurement/essentials-test-equipment/digital-oscilloscopes/understanding-bode-plots\_254514.html](https://www.rohde-schwarz.com/us/products/test-and-measurement/essentials-test-equipment/digital-oscilloscopes/understanding-bode-plots_254514.html)  
44. Understanding Power Supply Loop Stability and Compensation \- Part 2: Unusual or Problematic Bode Plots | Analog Devices, accessed October 29, 2025, [https://www.analog.com/en/resources/technical-articles/understanding-power-supply-loop-stability-and-compensation-part-2.html](https://www.analog.com/en/resources/technical-articles/understanding-power-supply-loop-stability-and-compensation-part-2.html)  
45. accessed October 29, 2025, [https://www.mathworks.com/help/control/ref/dynamicsystem.margin.html\#:\~:text=In%20other%20words%2C%20the%20gain,frequency%20or%20gain%20crossover%20frequency.](https://www.mathworks.com/help/control/ref/dynamicsystem.margin.html#:~:text=In%20other%20words%2C%20the%20gain,frequency%20or%20gain%20crossover%20frequency.)  
46. Gain margin, phase margin, and crossover frequencies \- MATLAB \- MathWorks, accessed October 29, 2025, [https://www.mathworks.com/help/control/ref/dynamicsystem.margin.html](https://www.mathworks.com/help/control/ref/dynamicsystem.margin.html)  
47. Understand Power Supply Loop Stability and Loop Compensation ..., accessed October 29, 2025, [https://www.analog.com/en/resources/technical-articles/power-supply-loop-stability-compensation-part-3.html](https://www.analog.com/en/resources/technical-articles/power-supply-loop-stability-compensation-part-3.html)  
48. Simplifying Stability Checks (Rev. B) \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slva381](https://www.ti.com/lit/pdf/slva381)  
49. Key Concepts of Gain Margin to Know for Control Theory, accessed October 29, 2025, [https://fiveable.me/lists/key-concepts-of-gain-margin](https://fiveable.me/lists/key-concepts-of-gain-margin)  
50. Systems Analysis and Control \- Lecture 21: Stability Margins and Closing the Loop, accessed October 29, 2025, [https://control.asu.edu/Classes/MAE318/318Lecture21.pdf](https://control.asu.edu/Classes/MAE318/318Lecture21.pdf)  
51. Step-by-Step Process to Calculate a DC-to-DC Compensation Network | Analog Devices, accessed October 29, 2025, [https://www.analog.com/en/resources/analog-dialogue/articles/step-by-step-process-to-calculate-a-dc-to-dc-compensation-network.html](https://www.analog.com/en/resources/analog-dialogue/articles/step-by-step-process-to-calculate-a-dc-to-dc-compensation-network.html)  
52. Type 2 and Type 3 Compensator Analysis for Power Supplies \- Plexim, accessed October 29, 2025, [https://www.plexim.com/support/application-examples/1026](https://www.plexim.com/support/application-examples/1026)  
53. How phase margin impacts the transient response of a power supply \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=991noseh1S0](https://www.youtube.com/watch?v=991noseh1S0)  
54. Larger phase margin means less overshoot? \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/615720/larger-phase-margin-means-less-overshoot](https://electronics.stackexchange.com/questions/615720/larger-phase-margin-means-less-overshoot)  
55. What Is a Control System and How To Design a Control Loop for a DC-to-DC Converter | Analog Devices, accessed October 29, 2025, [https://www.analog.com/en/resources/technical-articles/how-to-design-a-control-loop-for-a-dc-dc-converter.html](https://www.analog.com/en/resources/technical-articles/how-to-design-a-control-loop-for-a-dc-dc-converter.html)  
56. An 1162 | PDF | Capacitor | Power Electronics \- Scribd, accessed October 29, 2025, [https://www.scribd.com/document/74636716/an-1162](https://www.scribd.com/document/74636716/an-1162)  
57. Type III Compensator Design for Power Converters \- TI E2E, accessed October 29, 2025, [https://e2e.ti.com/cfs-file/\_\_key/communityserver-discussions-components-files/234/Type3CompensatorDesign.pdf](https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/234/Type3CompensatorDesign.pdf)  
58. Type III Compensator Design for Power Converters, accessed October 29, 2025, [https://www.electronicdesign.com/technologies/power/power-supply/regulators/article/21192885/type-iii-compensator-design-for-power-converters](https://www.electronicdesign.com/technologies/power/power-supply/regulators/article/21192885/type-iii-compensator-design-for-power-converters)  
59. Lecture 51 Tailoring Dynamic Response with Compensation A. Compensation Networks 1\. Overview of Gc (Alterations and Tailoring) a, accessed October 29, 2025, [https://www.engr.colostate.edu/ECE562/98lectures/New%20LECTURE%2051.pdf](https://www.engr.colostate.edu/ECE562/98lectures/New%20LECTURE%2051.pdf)  
60. Chapter 8\. Converter Transfer Functions \- IEEE Long Island, accessed October 29, 2025, [https://ieee.li/pdf/introduction\_to\_power\_electronics/chapter\_08.pdf](https://ieee.li/pdf/introduction_to_power_electronics/chapter_08.pdf)  
61. Stability Analysis of Power Supplies \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=0kZ0G7sNuik](https://www.youtube.com/watch?v=0kZ0G7sNuik)  
62. Measuring Power Supply Control Loop Response with Bode Plot II \- Siglent, accessed October 29, 2025, [https://www.siglenteu.com/application-note/power-supply-loop-response-bodeii/](https://www.siglenteu.com/application-note/power-supply-loop-response-bodeii/)  
63. Power Supply Analysis with the Bode 100 | OMICRON Lab, accessed October 29, 2025, [https://www.omicron-lab.com/applications/vector-network-analysis/power-supply-analysis](https://www.omicron-lab.com/applications/vector-network-analysis/power-supply-analysis)  
64. AN-1889 How to Measure the Loop Transfer Function of Power Supplies \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/an/snva364a/snva364a.pdf](https://www.ti.com/lit/an/snva364a/snva364a.pdf)  
65. Understanding a Circuit Transfer Function from a Bode Plot, accessed October 29, 2025, [https://resources.pcb.cadence.com/blog/2021-understanding-a-circuit-transfer-function-from-a-bode-plot](https://resources.pcb.cadence.com/blog/2021-understanding-a-circuit-transfer-function-from-a-bode-plot)  
66. Modeling and Control for a Current-Mode Buck Converter with a Secondary LC Filter, accessed October 29, 2025, [https://www.analog.com/en/resources/analog-dialogue/articles/modeling-and-control-for-current-mode-buck-converter-with-a-secondary-lc-filter.html](https://www.analog.com/en/resources/analog-dialogue/articles/modeling-and-control-for-current-mode-buck-converter-with-a-secondary-lc-filter.html)