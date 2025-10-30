

# **Analysis of Multi-Time-Scale Systems in Power Electronics: Time-Scale Separation, Independent Modeling, and Singular Perturbation Theory**

## **The Theoretical Challenge of Disparate Time Constants in Power Converter Modeling**

### **Introduction: The Stiffness Problem in Power Electronics Simulation**

Power electronic converters are inherently complex dynamical systems. Their modeling is complicated by the presence of multiple, interacting physical processes that evolve on fundamentally different time scales. A typical power system may involve dynamics spanning from the microseconds of switching transients to the seconds or minutes of thermal effects and load changes.1

The user query specifies a scenario with inductors whose values differ by a 1000-to-1 ratio. This vast disparity in component values creates time constants (e.g., $\\tau \= L/R$) that are similarly separated by orders of magnitude. In numerical analysis, such a system is defined as mathematically "stiff."

A stiff system poses a severe computational challenge. A numerical solver, such as in a SPICE or MATLAB/Simulink environment, must constrain its time step to be small enough to accurately capture the fastest dynamic (e.g., a high-frequency parasitic oscillation). This infinitesimal step size must then be used to simulate a "slow" phenomenon, such as the settling of a DC-bus voltage, which may take seconds or longer. The result is a prohibitive and often unnecessary computational burden.2

This, however, is not merely a simulation artifact; it is a fundamental modeling problem. A single, high-order, "full" model that attempts to capture all dynamics simultaneously often fails to provide meaningful design insight. The dominant, low-frequency behavior of the system is obscured by the high-frequency, low-energy "ripple" of the fast states. To overcome this, a formal method for "independent modeling" is required, which is enabled by, rather than hindered by, the large separation of time scales.

### **Defining Multi-Time-Scale Systems in Power Electronics**

A **Multi-Time-Scale System** is a dynamic system whose state variables evolve at rates so different that they can be partitioned into distinct temporal groups.3 This separation is often an intentional and *desirable design property* in power electronics, as it allows for the separation of system eigenvalues, leading to stable, non-oscillatory responses.5

The physical origins of these disparate time scales can be categorized as follows:

1. **Fast Time-Scale ($t\_f$):** This scale typically ranges from nanoseconds (ns) to milliseconds (ms). It is associated with the high-frequency dynamics of the converter.  
   * **Switching Dynamics:** The inductor current ripple and capacitor voltage ripple occurring at the switching frequency, $\\omega\_s$.6  
   * **Parasitic Resonances:** High-frequency oscillations caused by the interaction of parasitic elements, such as transformer leakage inductance and the stray capacitance of semiconductor switches.7  
   * **Fast Control Loops:** The dynamics of inner control loops, such as instantaneous current control.4  
2. **Slow Time-Scale ($t\_s$):** This scale typically ranges from milliseconds (ms) to many seconds (s). It is associated with the bulk energy storage, power balance, and slower control functions.  
   * **Energy Storage Dynamics:** The average voltage on large DC-link capacitors or the average current in large DC-side inductors.6  
   * **Slow Control Loops:** The dynamics of outer control loops, such as DC voltage regulation, Phase-Locked Loops (PLLs) for grid synchronization 4, or maximum power point tracking (MPPT).1  
3. **Very Slow Time-Scale ($t\_{vs}$):** This scale ranges from minutes to hours and is often related to the converter's operating environment.  
   * **Environmental Dynamics:** Changes in solar irradiance or ambient temperature.1  
   * **Thermal Dynamics:** The heating and cooling time constants of the converter's heat sinks and magnetic components.

The designation of "fast" and "slow" is relative and hierarchical. For instance, a current control loop (ms) is "fast" relative to its "slow" outer voltage loop (tens of ms).4 That same voltage loop, however, is "fast" relative to the "slow" change in solar irradiance (minutes).1 Therefore, "independent modeling" is a recursive process where the engineer must first define the time scale of interest.

### **The Need for Independent Modeling**

A unified, full-order model is analytically intractable for control design. It is impossible to design a single controller that effectively manages state variables evolving at both 1 $\\mu$s and 1 s.

The 1000x ratio specified by the user is the *enabling condition* that allows for model decomposition. The core idea is that from the perspective of the slow-moving states (e.g., a large DC-link capacitor voltage), the fast-moving states (e.g., an inductor's switching ripple) are moving so quickly that they appear to be in a "quasi-steady-state".8

This allows engineers to decompose the system:

1. First, model the **fast subsystem** (e.g., inductor current) while assuming the slow states (e.g., DC-link voltage) are constant parameters.  
2. Next, model the **slow subsystem** by replacing the fast-varying states with their *average* (or steady-state) values, which are now expressed as an algebraic function of the slow states.

This decomposition is the theoretical basis for the ubiquitous **cascaded control architecture** in power electronics.8 A fast inner-loop (e.g., current control) is designed independently of the slow outer-loop (e.g., voltage or speed control). A rigorous mathematical framework is required to perform this decomposition formally and to guarantee the stability of the full, interconnected system. That framework is **Singular Perturbation Theory (SPT)**.9

## **Formal Analysis of Multi-Time-Scale Systems: Singular Perturbation Theory (SPT)**

Singular Perturbation Theory (SPT) is the primary analytical tool used to formalize the intuitive "fast" and "slow" decomposition. It provides a rigorous method for model order reduction and stability analysis in systems with widely separated time scales.10

### **Standard Terminology and Definitions**

The foundation of SPT lies in mathematically separating the system's time scales.

* **Time-Scale Separation Parameter ($\\epsilon$):** A small, positive, dimensionless scalar $\\epsilon$ (where $0 \< \\epsilon \\ll 1$) is defined as the **perturbation parameter**. It quantifies the ratio of the time scales.8 It is often defined as $\\epsilon \= t\_{fast} / t\_{slow}$. The user's "1000x ratio" implies $\\epsilon \\approx 0.001$.  
* **Time Scales:** The standard "slow" time scale is denoted by $t$. A "fast" time scale $\\tau$ is then defined as $\\tau \= t/\\epsilon$.8  
* **Derivatives:** The derivatives with respect to these two time scales are related by the chain rule: $d/dt \= (d\\tau/dt) \\cdot (d/d\\tau) \= (1/\\epsilon) \\cdot (d/d\\tau)$.12 This mathematical relationship is the core of the singular perturbation. As $\\epsilon \\rightarrow 0$, the dynamics in the $\\tau$ time scale become infinitely fast.

In physical power electronic circuits, $\\epsilon$ is not just an abstract parameter; it is directly related to component values.

* **Example 1: Flying Capacitor Multilevel (FCML) Converter:** In an FCML converter, the separation is between the slow flying capacitor voltage dynamics and the fast inductor current ripple. Here, $\\epsilon$ can be defined as $\\epsilon \= 1/\\omega\_s$, where $\\omega\_s$ is the switching frequency.6  
* **Example 2: Grid-Forming Inverter:** In designing a current controller, $\\epsilon\_I \= L\_f / \\omega\_0$ (the per-unit filter inductance normalized by the fundamental frequency) can be selected as the perturbation parameter, directly linking the physical inductor $L\_f$ to $\\epsilon$.8

### **The Standard Singular Perturbation Form**

To apply SPT, a system's state equations must be partitioned into slow and fast states. Let the state vector be partitioned into $x$ (the slow state variables) and $z$ (the fast state variables).13

As presented by Kimball and Krein (2008) and others, the **extended standard form** for a singularly perturbed system, including control inputs $u$ and disturbance inputs $w$, is 13:

1. **Slow Subsystem:** $\\dot{x} \= f(x, z, u, w, \\epsilon)$  
2. **Fast Subsystem:** $\\epsilon\\dot{z} \= g(x, z, u, w, \\epsilon)$

Here, $x$ typically represents states like capacitor voltages or PLL angle integrators, while $z$ represents states like inductor currents or parasitic states.6 The small parameter $\\epsilon$ multiplying the derivative $\\dot{z}$ is the "singular" part; it signifies that the $z$ dynamics are much faster than the $x$ dynamics.

### **System Decomposition via SPT**

SPT provides a formal method to decompose this full-order system into two simpler, lower-order subsystems, which can be analyzed independently.3

#### **1\. The Reduced-Order Model (ROM) or "Slow Subsystem"**

The ROM captures the dominant, slow dynamics of the system. It is derived by setting the perturbation parameter $\\epsilon \\rightarrow 0$.8 This effectively assumes the fast dynamics are infinitely fast and have reached their steady state.

Setting $\\epsilon \= 0$ in the fast subsystem equation converts it from a differential equation to an algebraic constraint:

$$0 \= g(x, z, u, w, 0)$$  
Assuming this equation can be solved for $z$, we find the quasi-steady-state manifold (also known as the integral manifold), which expresses the fast states as an algebraic function of the slow states:

$$z \= h(x, u, w)$$  
6

Substituting this algebraic relationship back into the slow equation eliminates $z$ and yields the final Reduced-Order Model (ROM):

$$\\dot{x} \= f(x, h(x, u, w), u, w, 0)$$  
This resulting ROM is, in effect, the **averaged model** of the power converter.13

#### **2\. The Boundary Layer Model (BLM) or "Fast Subsystem"**

The ROM describes the system's behavior *on* the manifold, but it does not describe the fast transient *to* the manifold (e.g., from an initial condition).10 This transient is captured by the **Boundary Layer Model (BLM)**, which is analyzed in the fast time scale $\\tau \= t/\\epsilon$.

In this fast time scale, the slow state $x$ is treated as a constant parameter because it barely changes.13 The BLM is defined as:

$$d(z)/d\\tau \= g(x\_{const}, z(\\tau), u\_{const}, w\_{const}, 0)$$  
8

**Tikhonov's Theorem**, a cornerstone of SPT, provides the formal justification for this decomposition. It states that the stability of the full, singularly perturbed system is guaranteed *if* both the ROM and the BLM are asymptotically stable.8

This leads to a critical and often-overlooked failure mode. Many control designs are based only on the stability of the *averaged model* (the ROM). However, Tikhonov's theorem reveals that the *fast subsystem* (the BLM) must also be stable. A converter can have a perfectly stable averaged model but be unstable in practice due to oscillations in the fast dynamics (e.g., subharmonic oscillation or chaotic behavior) that the averaged model, by definition, cannot see. The large 1000x separation ratio makes the $\\epsilon\\dot{z}$ dynamics extremely energetic, meaning BLM instability is a critical design risk that only SPT can formally analyze.

## **Modeling Techniques for Dynamic Order Reduction (MOR)**

The decomposition described by SPT is a formal type of Model Order Reduction (MOR). The goal of MOR is to reduce the complexity of system models while preserving their essential characteristics.15

### **The Purpose and Benefits of Model Order Reduction**

Analyzing a full-order model of a complex converter is often impractical. MOR techniques provide a systematic way to simplify these models.

* **Computational Efficiency:** Reduced-order models (ROMs) are computationally simpler, drastically reducing simulation time. One study on spacecraft electrical systems demonstrated that an SPT-based ROM saved 50% of the simulation time with "almost no degradation in the simulation accuracy".2  
* **Tractability of Controller Design:** As noted in 17, "it is easier to design a control system for a reduced-order system than for a full-order system." This simplification is the primary enabler for designing complex, high-performance controllers.8  
* **Preservation of Properties:** A well-derived ROM conserves the key properties of the full-order model, such as stability, passivity, and input-output behavior, within its defined bandwidth.16

While numerical MOR methods like Balanced Truncation 17 or Proper Orthogonal Decomposition (POD) 20 exist, SPT is an *analytical* MOR method. Its advantage is that the resulting reduced-order states retain their physical meaning (e.g., "DC-link voltage"), providing far greater design insight than the mathematical abstractions of numerical methods.

### **The Foundation: State-Space Averaging (SSA) and its Limitations**

The most well-known MOR technique in power electronics is the **State-Space Averaging (SSA)** method, developed by Middlebrook and Ćuk in 1976\. SSA is a heuristic method that derives the ROM for Pulse-Width Modulated (PWM) converters by averaging the state equations over one switching cycle.

However, SSA's validity rests on the "small ripple condition".21 This assumption holds that the state variable ripple (e.g., inductor current ripple) is small enough to be neglected. In many modern converters, such as resonant converters or the Dual Active Bridge, the AC ripple is *not* small; in fact, it is the primary mechanism of energy transfer. In these cases, SSA fails.

### **Seminal Frameworks: Rigorous Averaging Theory**

The limitations of heuristic SSA led to the development of more formal and powerful averaging theories in the late 1980s and early 1990s, effectively connecting averaging to the rigorous mathematics of SPT.

#### **1\. Krein, Bentsman, Bass, & Lesieutre (1990)**

This paper provided the first rigorous mathematical justification for the averaging methods that power electronics engineers had been using heuristically.

* **Source:** P. T. Krein, J. Bentsman, R. M. Bass, and B. L. Lesieutre, "On the Use of Averaging for the Analysis of Power Electronic Systems," *IEEE Transactions on Power Electronics*, Vol. 5, No. 2, pp. 182-190, Apr. 1990\.23  
* **Key Contribution:** The authors introduced averaging theory as a "rigorous framework for evaluating, refining, and extending" the heuristic models.23 It formally proved *why* and *when* averaging works.  
* **Core Principle:** The paper demonstrated that averaging theory is not just an approximation but a formal tool that can also be used to "recover oscillatory effects such as ripple from the averaged model," thereby bridging the gap between the ROM (the average) and the BLM (the ripple).23

#### **2\. Sanders, Noworolski, Liu, & Verghese (1991)**

This work directly addressed the limitations of SSA by creating a tool for systems that *do not* satisfy the small ripple condition.

* **Source:** S. R. Sanders, J. M. Noworolski, X. Z. Liu, and G. C. Verghese, "Generalized Averaging Method for Power Conversion Circuits," *IEEE Transactions on Power Electronics*, Vol. 6, No. 2, pp. 251-259, Apr. 1991\.26  
* **Key Contribution:** The paper introduced the **Generalized Averaging Method (GAM)**, a "more general averaging procedure" applicable to circuits like resonant converters where the state variables have significant AC components.21  
* Method: The core idea of GAM is to represent the state variables not just by their DC average, but by a full Fourier series expansion, where the coefficients (phasors) are allowed to vary slowly over time.27 The state variable $x(\\tau)$ is expressed as:

  $$x(\\tau) \= \\sum\_{k=-\\infty}^{\\infty} \\langle x \\rangle\_k(t) e^{jk\\omega\_s\\tau}$$  
  30

This approach represents a clear evolution in modeling. Standard State-Space Averaging (SSA) is simply the $k=0$ (DC) term of the GAM expansion. GAM, by contrast, can create a dynamic model for the $k=0$ (DC) term, the $k=1$ (fundamental) term, and higher-order harmonics simultaneously. This is precisely the tool required for multi-time-scale systems where both the "fast" and "slow" dynamics may be AC, as demonstrated in the following case study.

## **Case Study: The $L\_m$ vs. $L\_k$ Dichotomy in Integrated Magnetics (1000x Ratio)**

The "1000x ratio" specified in the query is perfectly exemplified by the integrated magnetics in a **Dual Active Bridge (DAB)** or **Triple Active Bridge (TAB)** converter. This case study reveals how a failure to correctly partition time scales leads to critical design flaws.

### **The System: Dual Active Bridge (DAB) Converters**

The DAB converter is a widely used topology for bidirectional, isolated DC-DC power transfer.31 It consists of two H-bridges (active rectifiers) linked by a high-frequency transformer. Power flow is controlled by phase-shifting the square-wave voltages generated by the two bridges.32

The transformer is the central component, and its non-ideal properties are critical. It possesses:

1. **Magnetizing Inductance ($L\_m$):** The large inductance representing the magnetic core.  
2. **Leakage Inductance ($L\_k$):** The small inductance representing imperfect magnetic coupling, caused by flux that does not link both windings.

### **The Flawed Assumption: The Common Reduced-Order Model**

The most common "independent modeling" simplification for the DAB converter is to separate the $L\_m$ and $L\_k$ dynamics entirely.

**The Assumption:** It is "assumed a much larger magnetizing inductance compared with the leakage inductance, thus the magnetizing branch can be considered an open circuit".33 This is the $L\_m \\rightarrow \\infty$ assumption.

**The Resulting ROM:** In this simplified model, the **leakage inductance ($L\_k$) is used as the *main* energy storage and transfer element**.32 The converter dynamics are reduced to a simple first-order system, and its behavior is often further simplified using a **Fundamental Harmonic Approximation (FHA)**.7

### **Decomposing the Dynamics: $L\_k$ vs. $L\_m$**

This common ROM is dangerously flawed because it misclassifies the system's time scales. A formal analysis reveals a more complex, three-time-scale problem.

#### **1\. The "Fastest" Dynamic: Leakage Inductance ($L\_k$) and Parasitics**

While $L\_k$ does facilitate power transfer, it also creates a very fast, parasitic dynamic. The leakage inductance interacts with the *equivalent system capacitance* (e.g., switch output capacitance, $C\_{oss}$, and cable capacitance).

This $L\_k$-$C\_{parasitic}$ resonant tank is part of the **Boundary Layer Model (BLM)**. Its impact is to create "high voltage oscillation ($dV/dt$)" and "voltage spikes" on the semiconductor switches during turn-off.7 If this fast dynamic is not properly damped, the resulting $dV/dt$ stress can destroy the devices.

#### **2\. The "Medium" Dynamic: Magnetizing Inductance ($L\_m$)**

The critical error in the common ROM is the assumption that $L\_m$ is "infinitely slow" (i.e., an open circuit). In reality, the "ratio between the equivalent leakage and magnetizing inductance is **not neglectable**".36

The magnetizing inductance ($L\_m$) governs the magnetizing current, which, while smaller than the load current, is fundamentally responsible for setting the conditions for **Zero Voltage Switching (ZVS)**.

**The Failure of the ROM:** Ignoring $L\_m$ (or using FHA) leads to "incorrect ZVS region and current stress estimation".34 Studies show that FHA-based models can have "an error in the predicted AC port peak currents as high as 20% in certain operating regions," which directly "results in an inaccurate estimation of ZVS boundaries".34

This means a converter *designed* using the simple ROM (which ignores $L\_m$) will *fail* to achieve ZVS, especially at light loads. This failure results in catastrophic switching losses, dramatically reduced efficiency, and thermal failure. The $L\_m$ dynamic is not an "infinitely slow" DC phenomenon; it is a "medium" AC dynamic, slower than the $L\_k$ ringing but much faster than the DC power balance.

### **Numerical Analysis: Quantifying the 1000x Ratio**

The disparate inductor values found in research literature validate the 1000x premise of the query. The $L\_m/L\_k$ ratio is typically in the hundreds-to-thousands.

**Table 1: Comparative Analysis of Magnetizing vs. Leakage Inductance in DAB/TAB Case Studies**

| Source (Citation) | Converter / Case Study | Magnetizing Inductance (Lm​) | Leakage Inductance (Lk​) | Ratio (Lm​/Lk​) | Key Finding (Cited) |
| :---- | :---- | :---- | :---- | :---- | :---- |
| 37 | 4 kW, 50 kHz Planar Transformer | $48.02 \\mu H$ (at rated voltage) | $0.128 \\mu H$ (primary-side) | **$\\approx 375 \\times$** | This high ratio is typical. The $L\_m$ value is also highly nonlinear and dependent on operating voltage. |
| 33 | Solid-State Transformer (SST) Topology (I) | "Much larger" (Assumed $\\infty$) | $3.01 mH$ | N/A (Ignored) | The standard simplification explicitly follows the flawed assumption that $L\_m$ is an open circuit.33 |
| 36 | DAB SPS Modulation Analysis | $L\_m \= M \\cdot L\_{s1}$ | $L\_{s1}$ (primary leakage) | $M$ (variable) | The ratio $M$ is defined as a critical parameter that is "not neglectable" and must be included in modulation strategies.36 |
| 34 | TAB Converter Analysis | (Not specified) | (Not specified) | (Not specified) | "Omission of magnetizing inductance can lead to incorrect ZVS region and current stress estimation".34 |

This case study reveals that the "independent modeling" required for a DAB is not a single, simple separation. It is a **three-time-scale system**:

1. **Fastest ($\\tau\_1$):** $L\_k$-$C\_{parasitic}$ ringing (BLM stability problem).7  
2. **Medium ($\\tau\_2$):** $L\_m$-related dynamics (ZVS, AC current stress).34  
3. **Slowest ($t$):** DC-link voltage and power balance (ROM).7

The critical modeling error is misplacing the $L\_m$ dynamic. It is not part of the "slow" ($t$) model. Because it is an AC dynamic, it must be modeled using a tool that can capture the fundamental ($k=1$) harmonic behavior, such as the **Generalized Averaging Method (GAM)**.34

## **Multi-Time-Scale Modeling in Practice: Broad Applications and Standards**

The principles of SPT and time-scale separation are not niche concepts; they are the universal language of power electronics, applied at every level from component design to grid-scale simulation.

### **Classic Example: Flying Capacitor Multilevel (FCML) Converters**

The FCML converter is a textbook example of a system with natural, *physical* time-scale separation.

* **The System:** The converter's operation relies on two distinct energy storage elements.  
* **Slow Dynamics ($x$):** The **flying capacitor voltage dynamics**. These large capacitors store energy over many cycles and should remain balanced at a stable DC value.6  
* **Fast Dynamics ($z$):** The **inductor current ripple**. This is the switching-frequency dynamic used to transfer charge between the capacitors.6  
* **The Condition:** For the SPT-based averaged model (the ROM) to be valid, the time constant of the fast (inductor) dynamic, $\\tau\_{fast} \= L/R\_s$, *must* be "significantly smaller than the time constants of all modes participating in the capacitor voltage dynamics".6 This is the explicit mathematical condition justifying the 1000x separation.

### **Application in Control Design: Nested Loops in Grid-Forming Inverters**

SPT is not just an analysis tool; it is a *design* tool used to "enforce timescale separation... to obtain closed-form solutions of control gains".8

* **The System:** A modern grid-forming (GFM) inverter uses a cascaded control structure.8  
* **Fast Subsystem ($z$):** The **inner current control loop**.4 This loop must be very fast to reject high-frequency disturbances and shape the output current.  
* **Slow Subsystem ($x$):** The **outer voltage control loop** and the **Phase-Locked Loop (PLL)**.4 These loops manage the slower power balance and grid synchronization.  
* **Design via SPT:** Engineers first design the fast current loop ($z$) *while treating the slow voltage state ($x$) as a constant*. Once the inner loop is closed, its dynamics are very fast and can be approximated by its ROM (which is often a simple algebraic gain). The engineer then designs the slow voltage loop ($x$) using this *reduced-order model* of the fast subsystem.8 This "partitioning the system into multiple timescales" 8 is a direct, practical application of SPT.

### **Codification in Industry Standards (IEC/IEEE)**

This modeling philosophy is so fundamental that it is embedded in the international standards used for large-scale power system stability analysis.

* **The Standards:** Documents like **IEC 61400-27-1** define generic, dynamic models for wind turbines 38, and standards like IEEE 519 govern harmonics.40  
* **The Application of SPT:** These standard models are explicitly intended for *power system stability analysis* on a time scale of "a few seconds".41 They are "not intended for investigation of sub-synchronous phenomena" 42 or fast switching harmonics.  
* **The Key Fact:** To create these simplified, computationally efficient ROMs, the standards writers explicitly apply SPT. In deriving the dynamic models for solar and wind, "longer-term variables, such as solar radiation and the maximum power point, are assumed to be constant... following the **time-scale separation principle** based on the **singular perturbation theory**".1

This demonstrates the true scalability of the concept. The same mathematical theory is used by a component designer to validate $L/R$ constants in an FCML 6, a control engineer to decouple loops in an inverter 8, and a grid operator to run a stability simulation of a multi-gigawatt wind farm.1

## **Conclusions**

The challenge of modeling power electronic systems with vastly different inductor values (a 1000x ratio) is at the heart of modern power electronics. This analysis yields several key conclusions:

1. **Separation is a Feature, Not a Bug:** A large (e.g., 1000x) separation in time constants is not just a "stiffness" problem for simulation. It is a desirable design feature that enables **"independent modeling"** and the use of modular, cascaded control.  
2. **SPT is the Formal Framework:** **Singular Perturbation Theory (SPT)** provides the rigorous mathematical framework for this independent modeling. It allows a full-order system to be formally decomposed into:  
   * A **Reduced-Order Model (ROM)**, or "slow subsystem" ($\\dot{x} \= f(...)$), which represents the averaged dynamics.  
   * A **Boundary Layer Model (BLM)**, or "fast subsystem" ($\\epsilon\\dot{z} \= g(...)$), which represents the fast transients and ripple.  
3. **Averaged Stability is Insufficient:** The stability of the full system depends on the stability of *both* the ROM and the BLM (Tikhonov's Theorem). A common engineering failure is to design for a stable averaged model (ROM) while neglecting an unstable fast dynamic (BLM), which can lead to catastrophic subharmonic or parasitic oscillations.  
4. **Modeling Must Evolve Beyond SSA:** Simple **State-Space Averaging (SSA)** is a heuristic ROM that fails in systems without "small ripple." The **Generalized Averaging Method (GAM)**, developed by Sanders et al. (1991), is the rigorous, SPT-based tool for these systems. By using a Fourier expansion, it can model the dynamics of AC components (e.g., the $k=1$ fundamental) independently from the DC ($k=0$) components.27  
5. **The $L\_m/L\_k$ Case Study Demonstrates Misapplication:** The Dual Active Bridge (DAB) converter, with its $L\_m/L\_k$ ratio often exceeding 300x 37, is a prime example. The common practice of ignoring $L\_m$ (assuming it is infinitely slow) is a critical modeling error.33 This mistake misclassifies $L\_m$ as a "slow" DC state when it is, in fact, a "medium" AC dynamic. This failure leads directly to incorrect ZVS and current stress estimation, resulting in failed designs.34 This system requires a tool like GAM that can model its multi-time-scale AC dynamics.

Ultimately, the "independent modeling" of multi-time-scale systems is the universal language of power electronics, scaling from a single component's physics to the control of the entire grid.1 The ability to correctly identify and partition a system's dynamics into its constituent "fast" ($z$) and "slow" ($x$) states is arguably the most critical and consequential modeling skill for a power electronics engineer.

#### **Works cited**

1. (PDF) Dynamic Modeling and Control for Assessment of Large ..., accessed October 29, 2025, [https://www.researchgate.net/publication/344636884\_Dynamic\_Modeling\_and\_Control\_for\_Assessment\_of\_Large-Scale\_Wind\_and\_Solar\_Integration\_in\_Power\_Systems](https://www.researchgate.net/publication/344636884_Dynamic_Modeling_and_Control_for_Assessment_of_Large-Scale_Wind_and_Solar_Integration_in_Power_Systems)  
2. Model Reduction Method for Spacecraft Electrical System Based on Singular Perturbation Theory \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2079-9292/13/21/4291](https://www.mdpi.com/2079-9292/13/21/4291)  
3. Techniques of singular perturbation for system applications, accessed October 29, 2025, [https://trace.tennessee.edu/cgi/viewcontent.cgi?article=15459\&context=utk\_gradthes](https://trace.tennessee.edu/cgi/viewcontent.cgi?article=15459&context=utk_gradthes)  
4. Transient Synchronization Stability in Grid-Following Converters: Mechanistic Insights and Technological Prospects—A Review \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/18/8/1975](https://www.mdpi.com/1996-1073/18/8/1975)  
5. Sliding-mode control on slow manifolds of DC-to-DC power converters, accessed October 29, 2025, [https://www.tandfonline.com/doi/pdf/10.1080/00207178808906099](https://www.tandfonline.com/doi/pdf/10.1080/00207178808906099)  
6. Dynamical Modeling and Control of the Flying Capacitor Multilevel Converter \- Berkeley EECS, accessed October 29, 2025, [https://www2.eecs.berkeley.edu/Pubs/TechRpts/2025/EECS-2025-105.pdf](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2025/EECS-2025-105.pdf)  
7. Power Electronics Converters for Electric Vehicle Auxiliaries: State ..., accessed October 29, 2025, [https://www.mdpi.com/1996-1073/16/4/1753?type=check\_update\&version=2](https://www.mdpi.com/1996-1073/16/4/1753?type=check_update&version=2)  
8. Singular-perturbation-based Control Design of Single-phase Grid ..., accessed October 29, 2025, [https://johnsonlab.ece.utexas.edu/wp-content/uploads/2024/08/ECCE\_Full\_Paper\_2024\_20240731.pdf](https://johnsonlab.ece.utexas.edu/wp-content/uploads/2024/08/ECCE_Full_Paper_2024_20240731.pdf)  
9. Three-Time-Scale Singular Perturbation Stability Analysis of Three-Phase Power Converters | Request PDF \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/259535655\_Three-Time-Scale\_Singular\_Perturbation\_Stability\_Analysis\_of\_Three-Phase\_Power\_Converters](https://www.researchgate.net/publication/259535655_Three-Time-Scale_Singular_Perturbation_Stability_Analysis_of_Three-Phase_Power_Converters)  
10. Singular Perturbation-Based Large-Signal Order Reduction of Microgrids for Stability and Accuracy Synthesis With Control, accessed October 29, 2025, [https://wzy.ece.iastate.edu/CV/c217.pdf](https://wzy.ece.iastate.edu/CV/c217.pdf)  
11. arXiv:2310.07966v3 \[eess.SY\] 4 Sep 2024, accessed October 29, 2025, [https://arxiv.org/pdf/2310.07966](https://arxiv.org/pdf/2310.07966)  
12. Adaptive Control for Non-Minimum Phase Systems Via Time Scale Separation \- Texas A\&M University, accessed October 29, 2025, [https://vscl.tamu.edu/wp-content/uploads/sites/134/2024/03/Adaptive-Control-for-Non-Minimum-Phase-Systems-Via-Time-Scale-Separation.pdf](https://vscl.tamu.edu/wp-content/uploads/sites/134/2024/03/Adaptive-Control-for-Non-Minimum-Phase-Systems-Via-Time-Scale-Separation.pdf)  
13. (PDF) Singular Perturbation Theory for DC–DC Converters and ..., accessed October 29, 2025, [https://www.researchgate.net/publication/224359680\_Singular\_Perturbation\_Theory\_for\_DC-DC\_Converters\_and\_Application\_to\_PFC\_Converters](https://www.researchgate.net/publication/224359680_Singular_Perturbation_Theory_for_DC-DC_Converters_and_Application_to_PFC_Converters)  
14. Modeling Electronic Power Converters in Smart DC Microgrids \- An Overview | Request PDF, accessed October 29, 2025, [https://www.researchgate.net/publication/317133783\_Modeling\_Electronic\_Power\_Converters\_in\_Smart\_DC\_Microgrids\_-\_An\_Overview](https://www.researchgate.net/publication/317133783_Modeling_Electronic_Power_Converters_in_Smart_DC_Microgrids_-_An_Overview)  
15. MODEL ORDER REDUCTION TECHNIQUES IN CONTROLLER DESIGN FOR LINEAR DYNAMIC SYSTEMS \- INSPIRA, accessed October 29, 2025, [https://www.inspirajournals.com/uploads/Issues/1780101632.pdf](https://www.inspirajournals.com/uploads/Issues/1780101632.pdf)  
16. Model order reduction \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Model\_order\_reduction](https://en.wikipedia.org/wiki/Model_order_reduction)  
17. A dynamic condensation method using algebraic substructuring | Request PDF, accessed October 29, 2025, [https://www.researchgate.net/publication/306025403\_A\_dynamic\_condensation\_method\_using\_algebraic\_substructuring](https://www.researchgate.net/publication/306025403_A_dynamic_condensation_method_using_algebraic_substructuring)  
18. Model Reduction for Control System Design \- NASA Technical Reports Server (NTRS), accessed October 29, 2025, [https://ntrs.nasa.gov/citations/19850014087](https://ntrs.nasa.gov/citations/19850014087)  
19. Thermal Model | PDF \- Scribd, accessed October 29, 2025, [https://de.scribd.com/document/697823076/Thermal-Model](https://de.scribd.com/document/697823076/Thermal-Model)  
20. Research, Application and Future Prospect of Mode Decomposition in Fluid Mechanics, accessed October 29, 2025, [https://www.mdpi.com/2073-8994/16/2/155](https://www.mdpi.com/2073-8994/16/2/155)  
21. IEEE TRANSACTIONS ON POWER ELECTRONICS. VOL. 6, NO. 2\. APRIL 1991 \- Generalized Averaging Method for Power Conversion Circuits, accessed October 29, 2025, [https://power.eecs.berkeley.edu/publications/sanders\_noworolski\_liu\_verghese.pdf](https://power.eecs.berkeley.edu/publications/sanders_noworolski_liu_verghese.pdf)  
22. Generalized Averaging Method for Power Electronics Modeling from DC to above Half the Switching Frequency | Request PDF \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/381771011\_Generalized\_Averaging\_Method\_for\_Power\_Electronics\_Modeling\_from\_DC\_to\_above\_Half\_the\_Switching\_Frequency](https://www.researchgate.net/publication/381771011_Generalized_Averaging_Method_for_Power_Electronics_Modeling_from_DC_to_above_Half_the_Switching_Frequency)  
23. On the Use of Averaging for the Analysis of Power Electronic ..., accessed October 29, 2025, [https://experts.illinois.edu/en/publications/on-the-use-of-averaging-for-the-analysis-of-power-electronic-syst](https://experts.illinois.edu/en/publications/on-the-use-of-averaging-for-the-analysis-of-power-electronic-syst)  
24. Joseph Bentsman | Electrical & Computer Engineering | Illinois, accessed October 29, 2025, [https://ece.illinois.edu/about/directory/faculty/jbentsma](https://ece.illinois.edu/about/directory/faculty/jbentsma)  
25. Singular Perturbation Theory for PWM AC/DC Converters: Cascade Nonlinear Control Design and Stability Analysis \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/354961397\_Singular\_Perturbation\_Theory\_for\_PWM\_ACDC\_Converters\_Cascade\_Nonlinear\_Control\_Design\_and\_Stability\_Analysis](https://www.researchgate.net/publication/354961397_Singular_Perturbation_Theory_for_PWM_ACDC_Converters_Cascade_Nonlinear_Control_Design_and_Stability_Analysis)  
26. ‪George Verghese‬ \- ‪Google Scholar‬, accessed October 29, 2025, [https://scholar.google.co.uk/citations?user=ALGiEhQAAAAJ\&hl=ja](https://scholar.google.co.uk/citations?user=ALGiEhQAAAAJ&hl=ja)  
27. Aalborg Universitet An Enhanced Generalized Average Modeling of ..., accessed October 29, 2025, [https://vbn.aau.dk/files/379588154/An\_Enhanced\_Generalized\_Average\_Modeling\_of\_Dual\_Active\_Bridge\_Converters\_APEC\_2020.pdf](https://vbn.aau.dk/files/379588154/An_Enhanced_Generalized_Average_Modeling_of_Dual_Active_Bridge_Converters_APEC_2020.pdf)  
28. (PDF) Small – Signal Model of Series – Parallel Resonant DC-DC Converter with Capacitive Output Filter \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/241123869\_Small\_-\_Signal\_Model\_of\_Series\_-\_Parallel\_Resonant\_DC-DC\_Converter\_with\_Capacitive\_Output\_Filter](https://www.researchgate.net/publication/241123869_Small_-_Signal_Model_of_Series_-_Parallel_Resonant_DC-DC_Converter_with_Capacitive_Output_Filter)  
29. Simulation of Switched-Mode Power Conversion Circuits With Extended Impedance Method \- METAL@ShanghaiTech, accessed October 29, 2025, [https://metal.shanghaitech.edu.cn/publication/J50.pdf](https://metal.shanghaitech.edu.cn/publication/J50.pdf)  
30. Partially Rated Power Flow Control Converter Modeling for Low Voltage DC Grids \- TU Delft Research Portal, accessed October 29, 2025, [https://research.tudelft.nl/files/73437550/08708241.pdf](https://research.tudelft.nl/files/73437550/08708241.pdf)  
31. Harmonic modelling and control of dual active bridge converter for ..., accessed October 29, 2025, [https://www.researchgate.net/publication/381551086\_Harmonic\_modelling\_and\_control\_of\_dual\_active\_bridge\_converter\_for\_DC\_microgrid\_applications](https://www.researchgate.net/publication/381551086_Harmonic_modelling_and_control_of_dual_active_bridge_converter_for_DC_microgrid_applications)  
32. Dual active bridge converters in solid state transformers \- CORE, accessed October 29, 2025, [https://core.ac.uk/download/pdf/229270429.pdf](https://core.ac.uk/download/pdf/229270429.pdf)  
33. High-Frequency Transformer Design for Solid-State Transformers in ..., accessed October 29, 2025, [https://scholarworks.uark.edu/context/etd/article/2381/viewcontent/Garcia\_uark\_0011O\_11920.pdf](https://scholarworks.uark.edu/context/etd/article/2381/viewcontent/Garcia_uark_0011O_11920.pdf)  
34. (PDF) A Unified Modeling Approach for Steady-state and ZVS ..., accessed October 29, 2025, [https://www.researchgate.net/publication/377739969\_A\_Unified\_Modeling\_Approach\_for\_Steady-state\_and\_ZVS\_Analysis\_of\_a\_Triple\_Active\_Bridge\_Converter](https://www.researchgate.net/publication/377739969_A_Unified_Modeling_Approach_for_Steady-state_and_ZVS_Analysis_of_a_Triple_Active_Bridge_Converter)  
35. Extended configuration of dual active bridge DC–DC converter with reduced number of switches | Request PDF \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/276841240\_Extended\_configuration\_of\_dual\_active\_bridge\_DC-DC\_converter\_with\_reduced\_number\_of\_switches](https://www.researchgate.net/publication/276841240_Extended_configuration_of_dual_active_bridge_DC-DC_converter_with_reduced_number_of_switches)  
36. Advanced modular modulation, control and magnetic integration of ..., accessed October 29, 2025, [https://research.nottingham.edu.cn/files/1688961302/Final\_thesis.pdf](https://research.nottingham.edu.cn/files/1688961302/Final_thesis.pdf)  
37. (PDF) Magnetic Integration for a Dual Active Bridge Converter ..., accessed October 29, 2025, [https://www.researchgate.net/publication/383078129\_Magnetic\_Integration\_for\_a\_Dual\_Active\_Bridge\_Converter\_Planar\_Transformer\_with\_Accurate\_Leakage\_Inductances\_Estimation](https://www.researchgate.net/publication/383078129_Magnetic_Integration_for_a_Dual_Active_Bridge_Converter_Planar_Transformer_with_Accurate_Leakage_Inductances_Estimation)  
38. Implementation of Electrical Simulation Model for IEC Standard Type-3A Generator, accessed October 29, 2025, [https://www.researchgate.net/publication/262236040\_Implementation\_of\_Electrical\_Simulation\_Model\_for\_IEC\_Standard\_Type-3A\_Generator](https://www.researchgate.net/publication/262236040_Implementation_of_Electrical_Simulation_Model_for_IEC_Standard_Type-3A_Generator)  
39. Implementation of IEC 61400-27-1 Type 3 Model: Performance Analysis under Different Modeling Approaches \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/12/14/2690](https://www.mdpi.com/1996-1073/12/14/2690)  
40. Assessment and Compensation of Dynamic Instabilities in Voltage Source Converters Connected to Weak AC Grids and Microgrids \- SFU Library Thesis Template, accessed October 29, 2025, [https://summit.sfu.ca/\_flysystem/fedora/2022-11/etd22153.pdf](https://summit.sfu.ca/_flysystem/fedora/2022-11/etd22153.pdf)  
41. Dynamic modelling and control for assessment of large-scale wind and solar integration in power systems \- IET Digital Library, accessed October 29, 2025, [https://digital-library.theiet.org/doi/pdf/10.1049/iet-rpg.2020.0458?download=true](https://digital-library.theiet.org/doi/pdf/10.1049/iet-rpg.2020.0458?download=true)  
42. Extensive Model Validation for Generic IEC 61400-27-1 Wind Turbine Models \- DTU Research Database, accessed October 29, 2025, [https://orbit.dtu.dk/files/336963425/Raquel\_Villena.pdf](https://orbit.dtu.dk/files/336963425/Raquel_Villena.pdf)