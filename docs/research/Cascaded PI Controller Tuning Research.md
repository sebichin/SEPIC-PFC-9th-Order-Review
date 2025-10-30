

# **PI Controller Design for Cascaded Systems: A Report on Bandwidth Separation and Crossover Frequency Selection**

## **I. Foundations of Cascaded PI Control Architecture**

### **A. The Cascade Control Philosophy and Standard Terminology**

Cascade control is a hierarchical strategy in process control that utilizes a nested arrangement of two or more control loops.1 This architecture is not a universal solution but is implemented specifically to improve disturbance rejection for processes with significant time delays or complex dynamics.

The architecture is defined by a standard, interchangeable terminology 3:

* The **Outer Loop** is referred to as the **Primary** or **Master** loop. It controls the main process variable of interest (e.g., final temperature, product composition).1  
* The **Inner Loop** is referred to as the **Secondary** or **Slave** loop. It controls an auxiliary, faster-responding variable (e.g., flow rate, pressure) that has a direct and rapid influence on the primary variable.1

The signal flow in a standard two-loop cascade system is its defining characteristic.6 A Primary PI Controller (C1) compares the primary setpoint (SP1) to the primary process variable (PV1). The controller's output (CO1) is not sent to the final control element (FCE). Instead, this output becomes the **setpoint for the secondary loop (SP2)**.1 The Secondary PI Controller (C2) then compares this requested setpoint (SP2) to the secondary process variable (PV2). The output of C2 (CO2) is the signal that manipulates the FCE, such as a valve.7

The primary justification for this added complexity is **local disturbance rejection**.11 The inner loop is designed to identify and correct for disturbances (D2) that affect the secondary variable *before* they can propagate through the slow primary process (P1) and impact the main variable (PV1).1

A canonical example is a heat exchanger, where the goal is to control the outlet temperature (PV1) of a liquid by manipulating steam flow.1

* **Primary Loop (Outer):** C1 is a temperature controller. PV1 is the outlet temperature (slow to respond).  
* **Secondary Loop (Inner):** C2 is a flow controller. PV2 is the steam flow rate (fast to respond).  
* **Disturbance (D2):** Fluctuations in steam supply pressure.

In a single-loop system, if steam pressure drops, flow decreases, and the primary controller (C1) would only detect this problem *after* the outlet temperature (PV1) has already dropped significantly. In a cascade system, the secondary controller (C2) *immediately* detects the drop in PV2 (flow) and opens the valve further (CO2) to compensate, maintaining the flow rate (PV2) at the setpoint (SP2) requested by C1. The primary variable (PV1) remains stable, often never registering that a disturbance occurred.1

This architecture fundamentally alters and simplifies the task of the primary controller. The inner loop's function is to robustly force the secondary variable (PV2) to track its setpoint (SP2), absorbing nonlinearities (like valve stiction) and fast disturbances.6 From the perspective of the primary controller (C1), the "process" it manipulates is no longer a slow, non-linear, disturbance-prone heat exchanger. The "process" C1 sees is the *entire closed inner loop*.9 This new effective process is, by design, faster, more linear, and more robust, dramatically simplifying the tuning of C1.

### **B. The "Fast Inner Loop" Imperative: Dynamic Prerequisites**

The entire cascade strategy hinges on a non-negotiable dynamic prerequisite: the secondary process (P2) must respond significantly faster to the FCE than the primary process (P1).1

Quantitatively, a common heuristic is that the secondary process must react at least **three to four times faster** than the primary process.4 Authoritative process control texts, such as those by Seborg, Edgar, and Mellichamp, state this as a firm condition. If the inner loop is *not* at least **three times faster** than the outer loop, the marginal improvement in control performance typically does not justify the added complexity, cost of the extra sensor, and controller configuration.13

Violating this prerequisite invalidates the control strategy. If the inner loop is as slow or slower than the outer loop, it cannot correct for disturbances before they affect the primary variable.16 Worse, this configuration leads to controller "fighting," oscillation, and potential instability.17

This instability arises from uncompensated phase lag. The outer loop controller (C1) calculates an error and issues a corrective command (SP2). It operates on the fundamental assumption that this command is executed (i.e., PV2 reaches SP2) *long before* the outer loop's own dynamics (PV1) have time to react. If the inner loop is slow, this assumption is violated. C1 sends a command, but the effect on PV1 is now delayed by the sum of the inner loop's lag *and* the primary process's lag. This additional, unmodeled delay introduces significant phase lag at the outer loop's gain crossover frequency, eroding its phase margin. The outer loop's corrections arrive "out of phase," amplifying oscillations rather than damping them.18

The archetypal example of a perfect "fast inner loop" is a **valve positioner**.5 In this common setup, a primary flow controller (C1) outputs a desired valve position (e.g., "75% open") as its setpoint (SP2). The positioner (a high-gain inner-loop controller, C2) measures the actual valve stem position (PV2) and applies aggressive force to overcome stiction and hysteresis (D2) until PV2 matches SP2. This ensures the primary loop's assumption (that 75% command *equals* 75% open) is valid, effectively linearizing the FCE.5

## **II. The Principle of Time-Scale Separation and Bandwidth**

The qualitative requirement of a "fast" inner loop and "slow" outer loop is quantified in control design using the frequency-domain concepts of bandwidth and crossover frequency.

### **A. From "Process Speed" to "Bandwidth": A Formal Definition**

The "speed" of a control loop is formally dictated by its **closed-loop bandwidth ($\\omega\_{bw}$)**. This is defined as the frequency at which the closed-loop system's gain drops to $-3\\text{dB}$ (or $1/\\sqrt{2}$) of its low-frequency value.19 A higher bandwidth corresponds to a faster response time.20

While $\\omega\_{bw}$ is the goal, it is difficult to design for directly. Instead, control engineers design by specifying the **open-loop gain crossover frequency ($\\omega\_{gc}$)**. This is the frequency at which the magnitude of the open-loop transfer function $L(s) \= C(s)P(s)$ is equal to 1 (or $0\\text{dB}$).21

A critical "rule of thumb" in frequency-domain design is that for a standard system with an adequate phase margin (e.g., $PM \> 60^\\circ$), the closed-loop bandwidth is approximately equal to the open-loop gain crossover frequency ($\\omega\_{gc} \\approx \\omega\_{bw}$).23

Therefore, $\\omega\_{gc}$ becomes the primary design specification, not merely a result of tuning. The engineering design process involves *choosing* a target $\\omega\_{gc}$ to achieve the desired response speed and a target Phase Margin (PM) to ensure robustness. The PI controller parameters, Proportional Gain ($K\_p$) and Integral Time ($T\_i$), are then *calculated* as the values required to force the open-loop response to meet these two specifications simultaneously.20

### **B. Analysis of Bandwidth Separation Ratios ($\\omega\_{gc, inner}$ vs. $\\omega\_{gc, outer}$)**

The core principle of cascade design, $\\omega\_{gc, inner} \\gg \\omega\_{gc, outer}$, is implemented using a variety of heuristics.17 The required separation factor is a subject of debate and depends heavily on the application and the tuning aggressiveness.

Table 1 consolidates the range of separation ratios found in control literature and practice.

| Table 1: Analysis of Bandwidth Separation Heuristics for Cascaded Loops |  |  |
| :---- | :---- | :---- |
| **Ratio ($\\omega\_{gc, inner} : \\omega\_{gc, outer}$)** | **Source / Context** | **Design Implication & Analysis** |
| 3:1 | Process Control; cited by Seborg et al. 4 | **Minimum threshold for benefit.** At this proximity, the loops are strongly coupled. The inner loop's phase lag significantly impacts the outer loop's stability. Tuning is difficult and the system is sensitive. |
| 5:1 | Common industrial rule; Attitude control 26 | **Practical minimum.** This ratio provides sufficient separation to break the worst of the dynamic coupling, making the system tunable with standard PI algorithms, though interaction is still present. |
| 10:1 ("A Decade") | "Classic" heuristic; Motor control 28 | **Standard for design simplicity.** At this separation, the inner loop is considered "infinitely fast." This allows the designer to *decouple* the problem: tune C2, then tune C1 as if the inner loop is a simple $G(s)=1$ block.18 |
| 20:1 | Conservative process control 32 | **Highly conservative.** Used when the inner loop has significant non-linearities or uncertainty, and the designer must guarantee zero dynamic interaction. |
| 100:1 (or more) | Power electronics; Motor control 28 | **Physical reality.** This is less a design choice and more a reflection of the physics. An inner current loop (kHz range) is naturally separated by orders of magnitude from an outer speed loop (1-10 Hz range).28 |

The choice of this ratio represents a critical engineering trade-off between **design simplicity and achievable system performance**.

The 10:1 "decade" rule is popular because it makes the design mathematics trivial by allowing for a fully decoupled, sequential design.28 However, this simplicity comes at a high performance cost. As noted by Skogestad, imposing a large separation ratio at each level of a multi-layer cascade "eats up the available time window".33

For example, in a four-layer cascade (e.g., Composition \-\> Temperature \-\> Flow \-\> Valve), if each loop *insists* on a 10:1 separation:

1. Inner-most (Valve/Flow) $\\tau\_c \= 10\\text{ s}$  
2. Temperature Loop $\\tau\_c \= 10 \\times 10\\text{ s} \= 100\\text{ s}$  
3. Composition Loop $\\tau\_c \= 10 \\times 100\\text{ s} \= 1000\\text{ s}$  
4. Outer-most Loop $\\tau\_c \= 10 \\times 1000\\text{ s} \= 10000\\text{ s}$ ($\\approx 2.7\\text{ hours}$)

The 10:1 heuristic *forced* the outer loop to be 1000 times slower than the innermost loop. This may be stable, but the primary process variable may now be unacceptably slow for the plant's operational goals.33 The 10:1 ratio is a "heuristic crutch" that wastes available bandwidth in exchange for simplified design.

## **III. Sequential Tuning Methodology for Cascaded PI Controllers**

### **A. The Standard Sequential Tuning Algorithm**

The practical implementation of time-scale separation is achieved through a universal, sequential tuning procedure. The loops *must* be tuned from the **inside out**.8

Table 2 outlines the standard protocol for field-tuning a cascade system.

| Table 2: Sequential Tuning Protocol for Cascade Systems |  |  |  |  |
| :---- | :---- | :---- | :---- | :---- |
| **Step** | **Controller** | **Mode** | **Tuning Objective** | **Action & Rationale** |
| 1 | Outer (Primary) C1 | **MANUAL** | Isolate Inner Loop | Place C1 in Manual to break the cascade. This stops C1 from sending commands (SP2), allowing C2 to be tuned as an independent loop.9 |
| 2 | Inner (Secondary) C2 | **AUTO** (during test) | Fast Disturbance Rejection | Tune C2 for a fast, aggressive, stable response. The goal is to maximize $\\omega\_{gc, inner}$ to reject D2 quickly.9 |
| 3 | Inner (Secondary) C2 | **AUTO** | Close Inner Loop | Place C2 in Automatic with its new tuning. These parameters are now "locked" and should not be changed. |
| 4 | Outer (Primary) C1 | **MANUAL** | Identify Outer "Process" | The "process" from C1's view is now $G\_{new}(s) \= P\_1(s) \\times G\_{cl,inner}(s)$.10 Perform a new "bump test" by stepping C1's *output* (which is SP2) and measuring the response of *PV1*.9 |
| 5 | Outer (Primary) C1 | **AUTO** (during test) | Smooth Setpoint Tracking | Using the model from Step 4, tune C1. This tuning is typically slower (less aggressive) than C2, establishing the low $\\omega\_{gc, outer}$ and ensuring it does not fight the inner loop.8 |
| 6 | Both C1 and C2 | **AUTO** | Commission System | Place C1 in Automatic. The system is now in full cascade operation.8 |

This sequential procedure is the physical embodiment of the time-scale separation philosophy. Step 2, "Tune C2 for fast disturbance rejection," is the practical act of *establishing* the high bandwidth ($\\omega\_{gc, inner}$).9 Step 5, "Tune C1 for smooth setpoint tracking," is the act of *establishing* the low bandwidth ($\\omega\_{gc, outer}$).37 By performing these steps in sequence, the designer *enforces* the time-scale decomposition that makes the system stable and designable.28

### **B. Integration of Authoritative Tuning Rules (Seborg, Åström)**

The "tuning" in Steps 2 and 5 of the protocol is typically performed using one of two industry-standard methodologies:

1. **Seborg, Edgar & Mellichamp (Process Model Approach):** This methodology, prominent in chemical engineering and process control, is based on empirical modeling.13 The "bump tests" from the tuning table 36 involve applying a step change to the controller output (CO2 in Step 2, SP2 in Step 4\) and recording the process variable (PV2 or PV1). This response is then approximated by a **First-Order-Plus-Dead-Time (FOPDT)** model.9 Once the FOPDT parameters (process gain, time constant, and dead time) are identified, PI parameters are calculated using standard formulae (e.g., Ziegler-Nichols, Cohen-Coon, or Internal Model Control (IMC)).8  
2. **Åström & Hägglund (PID Theory Approach):** This methodology, detailed in *PID Controllers: Theory, Design and Tuning*, is based on identifying the plant's frequency response.42 It most famously uses the **Relay Autotuning** method.46 In this method, the PI controller is temporarily replaced by a simple relay, which forces the loop into a stable oscillation (a limit cycle). By measuring the amplitude and frequency of this oscillation, the method automatically and precisely identifies the process's **ultimate gain ($K\_u$)** and **ultimate period ($T\_u$)**. These two parameters, which define the plant's stability boundary, are then used in tuning rules (like Ziegler-Nichols) to calculate the PI parameters. This relay feedback test can be applied sequentially 45—first to the inner loop (Step 2\) and then to the *entire closed inner loop* (Step 4\) to tune the outer loop.

## **IV. Crossover Frequency Selection and Loop-Shaping Design**

Modern control design moves beyond simple tuning rules (which *produce* a $\\omega\_{gc}$) to the formal, frequency-domain process of "loop shaping" (which *selects* a $\\omega\_{gc}$ as a target).

### **A. Crossover Frequency as the Primary Performance Specification**

As established, the gain crossover frequency ($\\omega\_{gc}$) is the primary design choice that dictates the controller's speed and bandwidth.20 The designer's goal is to select the *highest possible $\\omega\_{gc}$* that the system can physically tolerate while maintaining a robust **Phase Margin (PM)** (e.g., $PM\_{target} \\geq 60^\\circ$).21

The maximum achievable $\\omega\_{gc}$ is constrained by the plant's physical limitations:

1. **Time Delays:** Any "dead time" in the process introduces phase lag that increases with frequency ($\\phi \= \-\\omega \\theta$). This places a hard upper limit on $\\omega\_{gc}$ before the phase margin is completely eroded.49  
2. **Non-Minimum Phase (RHP) Zeros:** These also introduce phase lag and limit the achievable bandwidth.49  
3. **Switching Frequencies:** In power electronics, the $\\omega\_{gc}$ must be kept well below the converter's switching frequency ($f\_{sw}$) to avoid amplifying switching noise. A common heuristic is to limit $\\omega\_{gc}$ to **1/10th to 1/5th of $f\_{sw}$**.20

### **B. Loop Shaping for a Single PI Controller**

**"Loop shaping"** is the formal process of designing the controller $C(s)$ to "shape" the open-loop frequency response $L(s) \= C(s)P(s)$ to meet performance specifications (e.g., target $\\omega\_{gc}$ and PM).22

The PI controller, with transfer function $C(s) \= K\_p(1 \+ \\frac{1}{T\_i s}) \= \\frac{K\_p(s \+ 1/T\_i)}{s}$, is a powerful loop-shaping tool 51:

* **Integral Term ($1/s$):** This provides theoretically infinite gain at $0\\text{ rad/s}$, which is what drives steady-state error to zero. It adds a constant $-90^\\circ$ of phase lag.  
* **Proportional Term ($K\_p$) and Zero ($1/T\_i$):** The $K\_p$ term shifts the entire magnitude plot up or down. The controller "zero" at $s \= \-1/T\_i$ adds \+90° of phase *lead* at frequencies above $1/T\_i$.

The design procedure involves placing this phase-lead "boost" in the region of the desired $\\omega\_{gc}$ to counteract the plant's phase lag and achieve the target PM.

1. Obtain the plant's frequency response $P(s)$ (its Bode plot), often from experimental data.52  
2. Select a target $\\omega\_{gc}$ (for speed) and a target $PM\_{target}$ (for robustness).  
3. At the target $\\omega\_{gc}$, read the plant's gain $|P(j\\omega\_{gc})|$ and phase $\\angle P(j\\omega\_{gc})$.  
4. The controller parameters $K\_p$ and $T\_i$ are then calculated to "fix" the loop at that frequency:  
   * $K\_p$ is set to force the total gain to $0\\text{dB}$: $|C(j\\omega\_{gc})| \= 1 / |P(j\\omega\_{gc})|$.  
   * $T\_i$ is set to provide the required phase boost: $\\angle C(j\\omega\_{gc}) \= PM\_{target} \- (180^\\circ \+ \\angle P(j\\omega\_{gc}))$.

### **C. Sequential Loop Shaping for Cascade Systems**

This formal process is the advanced-design equivalent of the sequential tuning algorithm. It treats the cascade design as a **frequency-domain decomposition**.53 The two controllers are designed as complementary filters that "hand off" control authority at a designated "switching frequency".53

This decomposition recognizes that C1 and C2 have different jobs:

* **C2 (Inner Loop):** Responsible for high-frequency disturbance rejection.  
* **C1 (Outer Loop):** Responsible for low-frequency setpoint tracking.

The design procedure 53 is:

1. **Design C2 (Inner):** The inner loop $L\_2(s) \= C\_2(s)P\_2(s)$ is shaped first. It is designed to be "in charge of the high frequencies" by giving it a high $\\omega\_{gc,2}$ to reject D2.53  
2. **Design C1 (Outer):** The outer loop $L\_1(s) \= C\_1(s) \\times \[G\_{cl,inner}(s)\] \\times P\_1(s)$ is shaped second. It is designed to be "in charge of the low frequencies".53 C1 is given a high integral gain for low-frequency tracking, but its crossover frequency $\\omega\_{gc,1}$ is deliberately placed *below* $\\omega\_{gc,2}$.

At frequencies $\\omega \< \\omega\_{gc,1}$ (low frequencies), C1 is dominant. At frequencies $\\omega \> \\omega\_{gc,1}$ (high frequencies), C1's gain has rolled off, but C2's gain is still high (up to $\\omega\_{gc,2}$). This ensures C1 handles the slow tracking while C2 handles the fast disturbances, and the "bandwidth separation" is what ensures this "hand-off" is stable.

## **V. Advanced Synthesis and Robustness Considerations**

### **A. Minimizing the Bandwidth Ratio: Beyond the 10:1 Rule**

The 10:1 heuristic, while simple, is often overly conservative and leads to sluggish outer-loop performance.33 Modern tuning and robust control methods allow for significantly smaller separation ratios by *accounting for* the inner loop's dynamics rather than *ignoring* them.

Research has shown that the need for large separation (5:1 or 10:1) is often an artifact of using *aggressive* tuning rules (like classic Ziegler-Nichols or Cohen-Coon), which tune the loops close to their stability limits.32

If **non-aggressive tuning rules** are used, the system is inherently more stable and can tolerate much smaller separation. Examples of such rules include 32:

* **Lambda / IMC (Internal Model Control) Tuning:** This method allows the designer to directly specify the desired closed-loop time constant (i.e., the "speed"), resulting in a very stable response.  
* **Modified Cohen-Coon:** The standard C-C parameters are calculated, but the final controller gain ($K\_p$) is **divided by a factor of two or more**.

By using these "detuned" or non-aggressive methods, a substantial improvement in loop stability is achieved. This allows for stable cascade control with outer-to-inner response time ratios as low as **2:1 or even 1.1:1**.32

The most advanced approach, **Robust Control (e.g., $H\_\\infty$)**, discards heuristics entirely.29 It uses numerical methods to *optimally select* the bandwidth ratio. This framework seeks to find the **"numerically closest bandwidths"** of the two loops that still guarantee stability, thus *minimizing* the ratio.29

These advanced methods work because they do not rely on the 10:1 "crutch" to ignore the inner loop. A robust, model-based tuning algorithm *explicitly* includes the inner closed-loop transfer function ($G\_{cl,inner}$) as part of the "plant" that the outer controller (C1) must manage. Because the tuning algorithm *knows* about the inner loop's dynamics (its gain peak and phase lag), it can *actively compensate* for them. This eliminates the need for the heuristic separation and reclaims the high performance "eaten" by the conservative rule.29

### **B. Authoritative Synthesis**

The complete design of a cascaded PI control system integrates three distinct schools of thought, each represented by an authority cited in the research:

1. **Seborg, Edgar & Mellichamp (The Process Control View):** This perspective provides the *economic and physical justification* for the architecture. As detailed in *Process Dynamics and Control*, cascade should only be used if a fast secondary variable is available (at least 3x faster) and a significant local disturbance exists that warrants the added cost.13 The tuning is based on empirical FOPDT models from step tests.9  
2. **Åström & Hägglund (The PID Theory View):** This perspective provides the *rigorous tuning methodology*. As detailed in *PID Controllers: Theory, Design and Tuning*, the relay autotuner provides a robust and practical method for executing the sequential tuning procedure, yielding the precise ultimate gain ($K\_u$) and ultimate period ($T\_u$) for each loop.42  
3. **Skogestad (The Advanced Control Design View):** This perspective provides the *high-level design critique*. Time-scale separation is the fundamental principle of decomposition, but it is a *design choice* with a direct *performance cost* (the "eaten time window").33 This view frames the 10:1 ratio not as a rigid rule, but as a trade-off between design simplicity and outer-loop performance.

A successful, modern cascade control design synthesizes all three: using the **Seborg** criteria to justify *if* and *where* to build the cascade, using the **Åström & Hägglund** methods for *how* to robustly tune the individual PI blocks, and using the **Skogestad** framework to *understand* the performance trade-offs of the chosen bandwidth separation.

#### **Works cited**

1. Cascade Control — Dynamics and Control \- APMonitor, accessed October 29, 2025, [https://apmonitor.com/pdc/index.php/Main/CascadeControl](https://apmonitor.com/pdc/index.php/Main/CascadeControl)  
2. Understanding Nested Control Loops in Process Automation \- Just Measure it, accessed October 29, 2025, [https://zeroinstrument.com/understanding-nested-control-loops-in-process-automation/](https://zeroinstrument.com/understanding-nested-control-loops-in-process-automation/)  
3. Enhanced Single-Loop Control Strategies 1\. Cascade control 2 ..., accessed October 29, 2025, [https://sites.chemengr.ucsb.edu/\~ceweb/faculty/seborg/teaching/SEM\_2\_slides/Ch16\_1\_27\_05.pdf](https://sites.chemengr.ucsb.edu/~ceweb/faculty/seborg/teaching/SEM_2_slides/Ch16_1_27_05.pdf)  
4. Fundamentals of cascade control \- Control Engineering, accessed October 29, 2025, [https://www.controleng.com/fundamentals-of-cascade-control/](https://www.controleng.com/fundamentals-of-cascade-control/)  
5. Cascade Control | Basic Process Control Strategies and Control System Configurations | Textbook, accessed October 29, 2025, [https://control.com/textbook/basic-process-control-strategies/cascade-control/](https://control.com/textbook/basic-process-control-strategies/cascade-control/)  
6. Quick Primer On Cascade Control \- Athena Controls, accessed October 29, 2025, [https://www.athenacontrols.com/quick-primer-on-cascade-control/](https://www.athenacontrols.com/quick-primer-on-cascade-control/)  
7. The Cascade Control Architecture \- Control Guru, accessed October 29, 2025, [https://controlguru.com/the-cascade-control-architecture/](https://controlguru.com/the-cascade-control-architecture/)  
8. 11.3: Cascade Control \- Engineering LibreTexts, accessed October 29, 2025, [https://eng.libretexts.org/Bookshelves/Industrial\_and\_Systems\_Engineering/Chemical\_Process\_Dynamics\_and\_Controls\_(Woolf)/11%3A\_Control\_Architectures/11.03%3A\_Cascade\_control-\_What\_is\_it\_When\_useful\_When\_not\_Common\_usage.](https://eng.libretexts.org/Bookshelves/Industrial_and_Systems_Engineering/Chemical_Process_Dynamics_and_Controls_\(Woolf\)/11%3A_Control_Architectures/11.03%3A_Cascade_control-_What_is_it_When_useful_When_not_Common_usage.)  
9. An Implementation Recipe for Cascade Control \- Control Guru, accessed October 29, 2025, [https://controlguru.com/an-implementation-recipe-for-cascade-control/](https://controlguru.com/an-implementation-recipe-for-cascade-control/)  
10. Designing Cascade Control System with PI Controllers \- MATLAB & Simulink \- MathWorks, accessed October 29, 2025, [https://www.mathworks.com/help/control/ug/designing-cascade-control-system-with-pi-controllers.html](https://www.mathworks.com/help/control/ug/designing-cascade-control-system-with-pi-controllers.html)  
11. Tuning Multiloop Control Systems \- MATLAB & Simulink \- MathWorks, accessed October 29, 2025, [https://www.mathworks.com/help/control/ug/tuning-multi-loop-control-systems.html](https://www.mathworks.com/help/control/ug/tuning-multi-loop-control-systems.html)  
12. Tuning Cascade Loops \- ControlSoft, Inc, accessed October 29, 2025, [https://www.controlsoftinc.com/tuning-cascade-loops-2/](https://www.controlsoftinc.com/tuning-cascade-loops-2/)  
13. Thesis Template (single-sided) \- Afe Babalola University ePortal, accessed October 29, 2025, [https://portal.abuad.edu.ng/Assignments/1552903230Cascade\_Control\_Term\_Paper.pdf](https://portal.abuad.edu.ng/Assignments/1552903230Cascade_Control_Term_Paper.pdf)  
14. Sensorless Temperature Control in a Metal Forming Process \- PURE Montanuniversität Leoben, accessed October 29, 2025, [https://pure.unileoben.ac.at/files/7824079/AC16362049.pdf](https://pure.unileoben.ac.at/files/7824079/AC16362049.pdf)  
15. Control of a Ball-Balancing Robot \- Projekter.aau.dk, accessed October 29, 2025, [https://projekter.aau.dk/projekter/files/335931888/MCE4\_1027.pdf](https://projekter.aau.dk/projekter/files/335931888/MCE4_1027.pdf)  
16. More Cascade Control \- APMonitor, accessed October 29, 2025, [https://apmonitor.com/che436/uploads/Main/Lecture36\_notes.pdf](https://apmonitor.com/che436/uploads/Main/Lecture36_notes.pdf)  
17. What would determine whether cascade or parallel control loop closure makes more sense for your system? \- Reddit, accessed October 29, 2025, [https://www.reddit.com/r/ControlTheory/comments/oh139z/what\_would\_determine\_whether\_cascade\_or\_parallel/](https://www.reddit.com/r/ControlTheory/comments/oh139z/what_would_determine_whether_cascade_or_parallel/)  
18. Why in a cascade controller architecture that contains two or more control loops, the transfer function of the inner loop must always have a higher cutoff frequency than the outer one and vice versa? \- Quora, accessed October 29, 2025, [https://www.quora.com/Why-in-a-cascade-controller-architecture-that-contains-two-or-more-control-loops-the-transfer-function-of-the-inner-loop-must-always-have-a-higher-cutoff-frequency-than-the-outer-one-and-vice-versa](https://www.quora.com/Why-in-a-cascade-controller-architecture-that-contains-two-or-more-control-loops-the-transfer-function-of-the-inner-loop-must-always-have-a-higher-cutoff-frequency-than-the-outer-one-and-vice-versa)  
19. Systems Analysis and Control \- Lecture 21: Stability Margins and Closing the Loop, accessed October 29, 2025, [https://control.asu.edu/Classes/MAE318/318Lecture21.pdf](https://control.asu.edu/Classes/MAE318/318Lecture21.pdf)  
20. How to select crossover frequency of a PI controller? \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/post/How-to-select-crossover-frequency-of-a-PI-controller](https://www.researchgate.net/post/How-to-select-crossover-frequency-of-a-PI-controller)  
21. pidtune \- PID tuning algorithm for linear plant model \- MATLAB \- MathWorks, accessed October 29, 2025, [https://www.mathworks.com/help/control/ref/dynamicsystem.pidtune.html](https://www.mathworks.com/help/control/ref/dynamicsystem.pidtune.html)  
22. Chapter Eleven \- Frequency Domain Design \- Graduate Degree in Control \+ Dynamical Systems, accessed October 29, 2025, [http://www.cds.caltech.edu/\~murray/books/AM05/pdf/am08-loopsyn\_28Sep12.pdf](http://www.cds.caltech.edu/~murray/books/AM05/pdf/am08-loopsyn_28Sep12.pdf)  
23. Intro to Control Design in the Frequency Domain, accessed October 29, 2025, [http://davepagurek.github.io/SE-Notes/se380/09%20frequency%20domain%20control%20design.html](http://davepagurek.github.io/SE-Notes/se380/09%20frequency%20domain%20control%20design.html)  
24. Relation between crossover frequency of loop gain and closed loop's corner frequency when feedback is not unity \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/360208/relation-between-crossover-frequency-of-loop-gain-and-closed-loops-corner-frequ](https://electronics.stackexchange.com/questions/360208/relation-between-crossover-frequency-of-loop-gain-and-closed-loops-corner-frequ)  
25. How to design a PI/PID controller with a given bandwidth and phase margin \- Quora, accessed October 29, 2025, [https://www.quora.com/How-do-you-design-a-PI-PID-controller-with-a-given-bandwidth-and-phase-margin-See-comment-for-details](https://www.quora.com/How-do-you-design-a-PI-PID-controller-with-a-given-bandwidth-and-phase-margin-See-comment-for-details)  
26. Aalborg Universitet Attitude stabilization of Marine Satellite Tracking ..., accessed October 29, 2025, [https://vbn.aau.dk/ws/files/484191918/ifacwc2.pdf](https://vbn.aau.dk/ws/files/484191918/ifacwc2.pdf)  
27. What Is Cascade Control? How Is Cascade Control Configured? \- Control Station, accessed October 29, 2025, [https://controlstation.com/cascade-control-cascade-control-configured/](https://controlstation.com/cascade-control-cascade-control-configured/)  
28. Theory of cascaded control : r/ControlTheory \- Reddit, accessed October 29, 2025, [https://www.reddit.com/r/ControlTheory/comments/1l6obqc/theory\_of\_cascaded\_control/](https://www.reddit.com/r/ControlTheory/comments/1l6obqc/theory_of_cascaded_control/)  
29. (PDF) Robust Control Approaches for Minimizing the Bandwidth ..., accessed October 29, 2025, [https://www.researchgate.net/publication/359310018\_Robust\_Control\_Approaches\_for\_Minimizing\_the\_Bandwidth\_Ratio\_in\_Multi-Loop\_Control](https://www.researchgate.net/publication/359310018_Robust_Control_Approaches_for_Minimizing_the_Bandwidth_Ratio_in_Multi-Loop_Control)  
30. How to design PI controllers for two cascaded control loops?, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/603856/how-to-design-pi-controllers-for-two-cascaded-control-loops](https://electronics.stackexchange.com/questions/603856/how-to-design-pi-controllers-for-two-cascaded-control-loops)  
31. Stability of cascade control : r/ControlTheory \- Reddit, accessed October 29, 2025, [https://www.reddit.com/r/ControlTheory/comments/3v9el0/stability\_of\_cascade\_control/](https://www.reddit.com/r/ControlTheory/comments/3v9el0/stability_of_cascade_control/)  
32. A New Perspective on the Tuning, Stability, and ... \- OptiControls, accessed October 29, 2025, [https://www.opticontrols.com/files/documents/cascade\_control\_perspective.pdf](https://www.opticontrols.com/files/documents/cascade_control_perspective.pdf)  
33. Advanced control using decomposition and ... \- Sigurd Skogestad, accessed October 29, 2025, [https://skoge.folk.ntnu.no/presentation/ARC-tutorial-aug23/powerpoint/jarap100903%20(4).pdf](https://skoge.folk.ntnu.no/presentation/ARC-tutorial-aug23/powerpoint/jarap100903%20\(4\).pdf)  
34. PID loop tuning parameters and control fundamentals, accessed October 29, 2025, [https://www.controleng.com/pid-loop-tuning-parameters-and-control-fundamentals-2/](https://www.controleng.com/pid-loop-tuning-parameters-and-control-fundamentals-2/)  
35. Cascaded PI tuning : r/ControlTheory \- Reddit, accessed October 29, 2025, [https://www.reddit.com/r/ControlTheory/comments/1haag0g/cascaded\_pi\_tuning/](https://www.reddit.com/r/ControlTheory/comments/1haag0g/cascaded_pi_tuning/)  
36. Optimal PID tuning for Cascade loops \- Incatools blog, accessed October 29, 2025, [https://blog.incatools.com/optimal-pid-tuning-cascade-loops](https://blog.incatools.com/optimal-pid-tuning-cascade-loops)  
37. Class34(Cascade Control).pdf \- BYU Engineering, accessed October 29, 2025, [https://www.et.byu.edu/\~tom/classes/436/ClassNotes/Class34(Cascade%20Control).pdf](https://www.et.byu.edu/~tom/classes/436/ClassNotes/Class34\(Cascade%20Control\).pdf)  
38. Improving performance using cascade control and a Smith predictor \- Sci-Hub, accessed October 29, 2025, [https://2024.sci-hub.box/407/a4d44de0b90279afeb3493c4b9dd78ad/kaya2001.pdf](https://2024.sci-hub.box/407/a4d44de0b90279afeb3493c4b9dd78ad/kaya2001.pdf)  
39. be, electronics and instrumentation engineering \- Annamalai University, accessed October 29, 2025, [https://annamalaiuniversity.ac.in/studport/download/Handbook/2019-20/Engg/B.E%20(Electronics%20and%20instrumentation)%20-%202019.pdf](https://annamalaiuniversity.ac.in/studport/download/Handbook/2019-20/Engg/B.E%20\(Electronics%20and%20instrumentation\)%20-%202019.pdf)  
40. UNIVERSITY OF CALCUTTA Instrumentation Engineering Department of Applied Physics 1 Course structure for 4-Year 8-Semester B. Tec, accessed October 29, 2025, [https://www.caluniv.ac.in/academic/INS-ENGG-APHYS/4year-Btech.pdf](https://www.caluniv.ac.in/academic/INS-ENGG-APHYS/4year-Btech.pdf)  
41. (PDF) Procedure for Cascade Control Systems Design: Choice of Suitable PID Tunings, accessed October 29, 2025, [https://www.researchgate.net/publication/242074646\_Procedure\_for\_Cascade\_Control\_Systems\_Design\_Choice\_of\_Suitable\_PID\_Tunings](https://www.researchgate.net/publication/242074646_Procedure_for_Cascade_Control_Systems_Design_Choice_of_Suitable_PID_Tunings)  
42. Analysis and Comparison of Cooperative Control Architectures applied in Landing a Small Fixed-Wing Aircraft on a Mobile Platform, accessed October 29, 2025, [https://elib.dlr.de/132437/1/Wilson%20de%20Sa%20Marques%20-%20Bachelor%27s%20Thesis%20-%20PRINT%20VERSION.pdf](https://elib.dlr.de/132437/1/Wilson%20de%20Sa%20Marques%20-%20Bachelor%27s%20Thesis%20-%20PRINT%20VERSION.pdf)  
43. Fractional PID Controller Tuned by Genetic Algorithms for a Three DOF\`s Robot System Driven by DC motors \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/343725352\_Fractional\_PID\_Controller\_Tuned\_by\_Genetic\_Algorithms\_for\_a\_Three\_DOFs\_Robot\_System\_Driven\_by\_DC\_motors](https://www.researchgate.net/publication/343725352_Fractional_PID_Controller_Tuned_by_Genetic_Algorithms_for_a_Three_DOFs_Robot_System_Driven_by_DC_motors)  
44. Relay Autotuning for Identification and Control \- Cambridge University Press & Assessment, accessed October 29, 2025, [https://www.cambridge.org/core/books/relay-autotuning-for-identification-and-control/B512F7A2CB765853D008693A12F2BB56](https://www.cambridge.org/core/books/relay-autotuning-for-identification-and-control/B512F7A2CB765853D008693A12F2BB56)  
45. Autotuning of PID Controllers \- National Academic Digital Library of ..., accessed October 29, 2025, [http://ndl.ethernet.edu.et/bitstream/123456789/37690/1/10071.pdf](http://ndl.ethernet.edu.et/bitstream/123456789/37690/1/10071.pdf)  
46. Relay feedback auto-tuning of process controllers — a tutorial review \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/222514888\_Relay\_feedback\_auto-tuning\_of\_process\_controllers\_-\_a\_tutorial\_review](https://www.researchgate.net/publication/222514888_Relay_feedback_auto-tuning_of_process_controllers_-_a_tutorial_review)  
47. Autotuning of Parallel Cascade Control using Setpoint Relay \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/272864015\_Autotuning\_of\_Parallel\_Cascade\_Control\_using\_Setpoint\_Relay](https://www.researchgate.net/publication/272864015_Autotuning_of_Parallel_Cascade_Control_using_Setpoint_Relay)  
48. Frequency domain design of a PI controller for a first order system with transport delay, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/605881/frequency-domain-design-of-a-pi-controller-for-a-first-order-system-with-transpo](https://electronics.stackexchange.com/questions/605881/frequency-domain-design-of-a-pi-controller-for-a-first-order-system-with-transpo)  
49. Design of PID Controllers Satisfying Gain Margin and Sensitivity Constraints on a Set of Plants \- e-Publications@Marquette, accessed October 29, 2025, [https://epublications.marquette.edu/cgi/viewcontent.cgi?article=1149\&context=mechengin\_fac](https://epublications.marquette.edu/cgi/viewcontent.cgi?article=1149&context=mechengin_fac)  
50. Multivariable Feedback Control \- Analysis and design, accessed October 29, 2025, [http://www2.peq.coppe.ufrj.br/Pessoal/Professores/Arge/COQ892/Referencias/multivariable\_feedback\_control\_-\_analysis\_and\_design.pdf](http://www2.peq.coppe.ufrj.br/Pessoal/Professores/Arge/COQ892/Referencias/multivariable_feedback_control_-_analysis_and_design.pdf)  
51. Controller to increase phase or gain margin \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/330474/controller-to-increase-phase-or-gain-margin](https://electronics.stackexchange.com/questions/330474/controller-to-increase-phase-or-gain-margin)  
52. Controller design from frequency analysis : r/AskEngineers \- Reddit, accessed October 29, 2025, [https://www.reddit.com/r/AskEngineers/comments/b646g5/controller\_design\_from\_frequency\_analysis/](https://www.reddit.com/r/AskEngineers/comments/b646g5/controller_design_from_frequency_analysis/)  
53. Robust Cascade Control inside a New Model-Matching Architecture ..., accessed October 29, 2025, [https://www.mdpi.com/2227-7390/11/11/2523](https://www.mdpi.com/2227-7390/11/11/2523)  
54. Loop Shaping-Based Attitude Controller Design and Flight Validation for a Fixed-Wing UAV, accessed October 29, 2025, [https://www.mdpi.com/2504-446X/9/10/697](https://www.mdpi.com/2504-446X/9/10/697)  
55. Advanced control using decomposition and simple elements \- Sigurd Skogestad, accessed October 29, 2025, [https://skoge.folk.ntnu.no/publications/2023/skogestad-advanced-regulatory-control\_arc/other/other-old/old-Advanced\_regulatory\_control-Annual\_reviews\_in\_Control%20(41).pdf](https://skoge.folk.ntnu.no/publications/2023/skogestad-advanced-regulatory-control_arc/other/other-old/old-Advanced_regulatory_control-Annual_reviews_in_Control%20\(41\).pdf)