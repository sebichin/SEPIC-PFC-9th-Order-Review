

# **An Exhaustive Analysis of Interleaved DC-DC Converter Topologies: Theory, Control, and Design Benefits**

## **Section 1: Fundamental Concepts and Topologies of Multi-Phase Converters**

### **1.1 Standard Terminology and Definitions**

The terminology surrounding interleaved converters is precise. A "multi-phase converter" defines the *architecture*—a system utilizing multiple converter stages in parallel, often called "phases" or "channels".1 An "interleaved converter" refers to the *operation* of this multi-phase architecture, wherein the switching control signals for each phase are intentionally phase-shifted in time relative to one another.3 While the terms are often used interchangeably, it is the *interleaving* (the time-shifted control) that enables the critical performance benefits of the multi-phase topology.3

This architecture is formally defined as a system using multiple switching converter stages connected in parallel to a common input and/or output bus.4 The flexibility of this parallel structure permits several topological classifications based on power flow:

* **Single-Input Multiple-Output (SIMO):** This is one of the most common configurations. A single DC power source, such as a battery or front-end rectifier, feeds multiple parallel converter stages. These stages may power a single shared load or multiple independent loads, such as different voltage rails on a motherboard.1  
* **Multiple-Input Single-Output (MISO):** This topology is the inverse of SIMO and is used for power aggregation. Multiple, often independent, power sources (e.g., separate battery packs in an electric vehicle, or a solar panel and a battery) are connected to parallel converter stages that feed a single, shared output bus or load.5  
* **Multiple-Input Multiple-Output (MIMO):** This is the most complex topology, often found in advanced systems like renewable energy grids. It allows multiple sources to be interleaved, with the power from their respective stages dynamically routed to multiple independent loads.5 For example, a solar array and a wind turbine (multiple inputs) could simultaneously charge a battery bank and power a grid-tied inverter (multiple outputs).

### **1.2 The Core Principle of Interleaving Operation**

The fundamental concept of interleaving is based on the principle of superposition.6 In an $N$-phase converter, the total current at the input or output bus is the algebraic sum of the individual currents from the $N$ parallel phases. Each of these phases is operated at an identical switching frequency, $f\_{sw}$, but the (Pulse Width Modulated) PWM drive signal for each phase is time-delayed by a fixed period.

In a standard symmetric interleaving scheme, this phase shift, $\\alpha$, is uniform, with each successive phase $k$ delayed by $(k-1) \\times T\_{sw}/N$, where $T\_{sw}$ is the switching period ($1/f\_{sw}$).3 For example, in a two-phase converter ($N=2$), the phases are operated $180^{\\circ}$ apart.7

This phase-shifted summation is the primary mechanism for nearly all benefits associated with interleaving. It results in a "frequency multiplication effect," whereby the *effective* fundamental frequency of the *total* (summed) ripple current at the input and output nodes becomes $N \\times f\_{sw}$.8 While the individual components (switches, inductors) still operate at $f\_{sw}$, the combined waveform seen by the input and output capacitors has a fundamental frequency $N$ times higher. As will be explored, this multiplication is the *direct physical mechanism* that enables input and output ripple cancellation, leading to a dramatic reduction in passive component (inductor and capacitor) sizing, component stress, and electromagnetic interference (EMI).

## **Section 2: The Theory and Analysis of Ripple Cancellation**

The most significant advantage of interleaving is the cancellation of AC ripple currents. This phenomenon occurs at both the input and output, and its effectiveness is a predictable function of the number of phases ($N$) and the converter's duty cycle ($D$).

### **2.1 Mathematical Modeling of Input Current Ripple Cancellation**

A conventional single-phase switching converter, such as a boost or buck, draws a pulsed current from the input source. This high-amplitude, high-frequency ripple current is a primary source of conducted EMI and places significant stress on input capacitors.10

Interleaving directly mitigates this problem. By phase-shifting the $N$ converter stages, the input current pulses drawn by each phase are staggered in time. Instead of one large current pulse, the source sees $N$ smaller, overlapping pulses. This creates a much smoother total input current profile with a dramatically reduced peak-to-peak ripple amplitude.12

The degree of cancellation can be mathematically quantified. For a two-phase ($N=2$) interleaved boost converter operating in Continuous Conduction Mode (CCM), the reduction in the total input ripple current ($\\Delta I\_{IN}$) relative to the ripple of a single phase's inductor ($\\Delta I\_{L1}$) is a function of the duty cycle $D$. This ripple reduction ratio, $K(D) \= \\Delta I\_{IN} / \\Delta I\_{L1}$, is given as 12:

* For $D \\le 0.5$: $K(D) \= (1 \- 2D) / 1$  
* For $D \> 0.5$: $K(D) \= (2D \- 1\) / D$

Note: The denominator for $D \\le 0.5$ is often cited as $1-D$. However, the provided source 12 indicates a denominator of 1, which implies $K(D)$ is a ratio of $\\Delta I\_{IN}$ to the maximum possible inductor ripple.

Analyzing this relationship reveals "sweet spots" for cancellation. For a two-phase system, *perfect* input ripple cancellation ($K(D) \= 0$) occurs at precisely $D \= 0.5$.12 As the duty cycle moves away from 0.5 and toward 0 or 1.0, the cancellation benefit degrades significantly.

This concept generalizes for $N$ phases: theoretically "zero-ripple" input current operation is achievable at $N-1$ critical duty cycle points, $D\_{crit}$, defined by the relation:

$$D\_{crit} \= \\frac{i}{N} \\quad \\text{for} \\quad i \= 1, 2, \\dots, N-1$$  
13

This mathematical reality introduces a critical, and often overlooked, design constraint. The *choice of the number of phases ($N$)* should be directly influenced by the *application's expected steady-state operating duty cycle*. For example:

* A 12V to 5V buck converter ($D \\approx 0.42$) would be an excellent candidate for $N=2$, as its operating point is near the $D=0.5$ cancellation node.  
* A 12V to 3.3V buck converter ($D \\approx 0.28$) would see minimal input ripple benefit from $N=2$. However, a 4-phase converter ($N=4$) would be an exceptional choice, as its $D\_{crit} \= 1/4 \= 0.25$ node is very close to the 0.28 operating point.13

### **2.2 Output Voltage and Inductor Current Ripple Analysis**

A similar cancellation effect occurs at the output. The $N$ phase-shifted inductor ripple currents are summed at the common output capacitor node.14 Because the individual ripple waveforms are out of phase, they destructively interfere.

This summation provides three distinct benefits:

1. **Reduced Output Voltage Ripple ($\\Delta V\_{OUT}$):** The output voltage ripple is, to a first order, the product of the total AC ripple current flowing into the capacitor ($I\_{COUT}$) and the capacitor's Equivalent Series Resistance (ESR). By drastically reducing the magnitude of $I\_{COUT}$, interleaving proportionally reduces the output voltage ripple.14 For example, a 4-phase converter can have a total output current ripple that is *four times smaller* than its single-phase equivalent.9  
2. **Reduced Capacitor Thermal Stress:** Ripple current is a primary driver of component failure in electrolytic and polymer capacitors. This current generates heat via the capacitor's ESR, following the $P\_{loss} \= I\_{COUT, RMS}^2 \\times ESR$ relationship.15 Interleaving is "well known as an effective method to reduce the capacitor ripple current".17 This reduction in RMS current stress lowers the capacitor's self-heating, allowing for the use of smaller, lower-cost capacitors or significantly extending the operational lifetime of the components.8  
3. **Reduced Capacitance Requirement:** As established, the *effective frequency* of the total output ripple current is $N \\times f\_{sw}$.8 The capacitance ($C$) required to achieve a given output voltage ripple ($\\Delta V\_{OUT}$) is inversely proportional to this effective frequency. By multiplying the frequency by $N$, the designer can achieve the same $\\Delta V\_{OUT}$ specification with a proportionally smaller output capacitance, saving cost and board space.8

### **2.3 Advanced Ripple Cancellation: Coupled Inductors (CL)**

A more advanced implementation of interleaving replaces the $N$ *discrete inductors* (DLs) with $N$ windings on a *common magnetic core*, creating a *coupled inductor* (CL).14

This leads to a non-intuitive outcome: the *total output current ripple*—the summed current of all phases flowing into the output capacitor—is *exactly the same* for both CL and DL configurations.14 The coupling does not change the net ripple seen by the load.

The true benefit of coupling is not at the output node, but *within the individual phases*. The mutual inductance ($L\_m$) in the coupled core causes the ripple-canceling effect to "propagate upstream" from the output node into the phase currents themselves.14 While the *sum* is the same, the *individual phase ripple* is dramatically reduced.

This provides three profound advantages:

1. **Reduced Component Stress:** CLs exhibit a "significant advantage in terms of current ripple cancellation... *inside each coupled phase*".14 A simulation comparing CL to DL systems showed a 4-fold reduction in the individual phase ripple current amplitude (from 30.6 A to 7.7 A).14 This significantly lowers the peak and RMS currents seen by the switching (MOSFET) devices and inductor windings, which in turn reduces $I^2R$ conduction losses.18  
2. **Faster Transient Response:** Because the *phase* ripple is now much smaller for a given inductance value ($L$), the designer is free to *reduce the inductance value* significantly while maintaining the same phase ripple as a comparable DL system. As will be discussed in Section 4.1, a smaller inductance value is the key to a faster transient response.14  
3. **Higher Efficiency:** The combination of lower $I^2R$ losses (from lower phase ripple) and the potential to reduce $f\_{sw}$ (due to the smaller $L$ required) can lead to notable improvements in overall converter efficiency.14

## **Section 3: Analysis of Phase Shift Control Strategies**

The generation and management of the phase-shifted control signals are central to the converter's operation. Control strategies range from simple, static phase-shifting to complex, dynamic optimization algorithms.

### **3.1 Symmetric Interleaving: The $360^{\\circ}/N$ Standard**

For an $N$-phase converter, the theoretically optimal phase shift for achieving maximum ripple cancellation is a uniform, symmetric angular displacement between adjacent phases.19 This standard phase shift, $\\alpha$, is given by:

$$\\alpha \= \\frac{360^{\\circ}}{N} \\quad (\\text{or} \\quad \\frac{2\\pi}{N} \\text{ radians})$$  
21

This is the *de facto* standard implementation for interleaved control:

* **N \= 2 phases:** $\\alpha \= 180^{\\circ}$ 7  
* **N \= 3 phases:** $\\alpha \= 120^{\\circ}$ 21  
* **N \= 4 phases:** $\\alpha \= 90^{\\circ}$ 22

This symmetric, static-phase-angle approach is simple to implement and provides the maximum theoretical ripple cancellation *if, and only if*, all $N$ phases are perfectly balanced (i.e., all inductors, switches, and PCB parasitics are identical).19

### **3.2 Asymmetric and Optimized Phase Shifting**

In practice, component tolerances (e.g., inductor values $\\pm$7%) 23, $R\_{DS(on)}$ variations, and unequal PCB trace impedances are *never* identical. This "physical parameters degradation" leads to current imbalance among the phases.24 When phases are non-identical, "the symmetrical interleaved mode ceases to be the optimum mode".24

This reality has led to the development of *asymmetric interleaving*, an advanced control method that treats the phase shift angles as *active control variables* rather than fixed parameters.3 This is typically implemented with a digital controller.

The performance goals of such a strategy are twofold:

1. **Compensate for Mismatch:** A digital "supervising system" can sense the current in each non-identical phase and apply *asymmetrical* phase shifts to actively minimize the total ripple or harmonic content, forcing the unbalanced system to behave as an ideal one.24  
2. **Optimize for Efficiency:** Beyond simple compensation, the phase angles and even the duty cycles of individual phases can be actively "mismatched" to achieve a specific optimization target. An "Interleaved Modulation Scheme with Optimized Phase Shifting (IMOPS)" can introduce both a duty cycle offset and a non-uniform phase angle. This strategy can *simultaneously* minimize the inductor average current (reducing $I^2R$ conduction losses) and the inductor ripple current (reducing core losses and AC-related switching losses), leading to significantly enhanced conversion efficiency across various operating points.25

This marks a significant conceptual evolution, moving from a *static* hardware design (picking $N$ and $360^{\\circ}/N$) to *dynamic optimization*, where the controller actively "hunts" for the set of phase angles that results in the lowest total system loss or lowest EMI signature.

### **3.3 Distributed Interleaving Control**

A separate, decentralized control philosophy was proposed by Perreault and Kassakian (1997) in their foundational paper, "Distributed Interleaving of Paralleled Power Converters".26 This approach is designed for high-reliability, modular systems and requires *no centralized master controller*.26

The mechanism is as follows:

1. Each converter cell (phase) is autonomous and generates its own clock signal, typically from a Voltage-Controlled Oscillator (VCO).  
2. All cells are connected by a single, non-critical "interleaving bus" (often a single wire).26  
3. Each cell senses the aggregate signal voltage on the bus, subtracts its own contribution, and then uses a phase detector to adjust its local VCO. The control loop's goal is to drive the local oscillator to be *180 degrees out of phase* with the aggregate signal of all *other* cells.26

This elegant, analog-based system is inherently robust and modular:

* **Self-Aligning:** The system *automatically* settles into a stable, symmetric 360$^{\\circ}$/N phase shift. For example, three cells will naturally lock 120$^{\\circ}$ apart.26  
* **Modular:** The system "automatically accommodates varying numbers of converter cells".26 If one cell is removed or fails, the remaining $N-1$ cells *automatically* re-lock to a 360$^{\\circ}$/(N-1) shift, with no change in control logic required.26  
* **Fault-Tolerant:** A failure of the interconnecting bus *only inhibits the interleaving function*. The cells revert to independent clocking, but the system *does not fail*.26

This architecture provides an extremely resilient method for achieving the benefits of interleaving, making it ideal for applications in aerospace, military, and high-availability datacenters where fault tolerance and modularity are paramount.

## **Section 4: System-Level Benefits of Multi-Phase Operation**

The consequences of ripple cancellation and current-splitting extend far beyond the passive components, resulting in profound, system-wide improvements in performance, power density, and thermal management.

### **4.1 Enhancement of Dynamic and Transient Response**

The *primary driver* for the adoption of multi-phase converters in high-performance computing is their superior transient response.27 Applications such as microprocessors (CPUs, GPUs) and ASICs present extremely challenging loads: they operate at very low voltages (e.g., 0.9 V \- 1.2 V) and can demand massive, near-instantaneous steps in current (e.g., 150 A load steps with slew rates exceeding 100 A/$\\mu$s).27 During these events, the converter must maintain the output voltage within a tight regulation band (e.g., $\\pm$5% or less).27

Interleaving provides the physical mechanism to meet this demand. During a high-slew-rate load transient, an optimal controller will *override* the interleaved phase-shifting. For a sudden load *step-up*, the controller turns *all* high-side FETs on *simultaneously*. For a load *step-down*, it turns *all* low-side FETs on *simultaneously*.28

This simultaneous action effectively places all $N$ phase inductors in parallel *during the transient event*. Therefore, the *equivalent transient inductance* ($L\_{EQ}$) seen by the output capacitor is:

$$L\_{EQ} \= \\frac{L\_{phase}}{N}$$  
28

The converter's current slew rate ($di/dt$), which is its ability to change its current output, is governed by $V \= L(di/dt)$. By reducing the effective inductance by a factor of $N$, the converter's maximum $di/dt$ is *multiplied by N*.28 For a step-up transient in a buck converter, the slew rate becomes:

$$\\frac{di}{dt} \= \\frac{(V\_{IN} \- V\_{OUT})}{L\_{EQ}} \= \\frac{(V\_{IN} \- V\_{OUT}) \\times N}{L\_{phase}}$$  
28

This faster $di/dt$ is the critical factor.31 It allows the converter's current output to match the load's new demand (or lack thereof) much more quickly. This minimizes the "unbalanced charge"—the deficit or surplus of charge—that must be supplied by or dumped into the output capacitors. This, in turn, *directly minimizes the output voltage undershoot and overshoot* ($\\Delta V\_{OUT(AC)}$), enabling the design to meet aggressive transient specifications.27

The performance of this technique is well-documented:

* A 4-phase TI reference design (TIDT445) for an automotive application can handle a load step from **21 A to 86 A** with a slew rate of 65 A/$\\mu$s, with the output voltage deviating only **$\\pm$8.3%**.32  
* An RST-controlled Interleaved Boost Converter (IBC) demonstrated transient **settling times below 40 ms** and **overshoot limited to $\\pm$2%**.33

### **4.2 Reduction of Component Stress and Sizing**

Beyond transient response, interleaving fundamentally reduces the stress on individual components.

* **Current Division:** The total output current $I\_{OUT}$ is divided among the $N$ phases. Each phase's switches and inductor only need to be rated to process $I\_{OUT} / N$ (plus ripple).34 This is a simple but profound benefit for high-current applications, moving the design from large, exotic, and expensive high-current components to multiple, smaller, commodity components.  
* **Reduced Conduction Losses:** This current division has a non-linear benefit on efficiency. Conduction losses are proportional to $I^2R$.  
  * For a single-phase converter: $P\_{loss} \= (I\_{OUT})^2 \\times R\_{sw}$  
  * For an $N$-phase converter: $P\_{loss} \= N \\times (I\_{OUT} / N)^2 \\times R\_{sw} \= \\frac{(I\_{OUT})^2 \\times R\_{sw}}{N}$  
    This demonstrates that for the same total output current, the total conduction loss across all switches is reduced by a factor of N.18  
* **Reduced Passive Component Size:** As detailed in Section 2, the $N \\times f\_{sw}$ effective ripple frequency is a primary benefit. This higher effective frequency *directly* enables the use of smaller, lighter, and lower-cost inductors and capacitors to meet a given ripple specification.8  
* **Reduced Switch Voltage Stress:** In certain non-isolated topologies, such as interleaved stacked or multilevel converters, increasing the number of cells can also reduce the blocking voltage stress ($V\_{DS}$) that individual switching devices must withstand.40

### **4.3 Improvements in Power Density and Thermal Management**

The reduction in component size and stress translates directly to system-level gains in power density and thermal performance.

* **Power Density:** The combination of smaller inductors, smaller capacitors, and (as follows) smaller heat sinks results in a dramatic increase in volumetric power density (measured in kW/L or W/in³).41  
* **Thermal Management:** This is one of the most significant practical advantages.  
  * **The Problem:** A single-phase converter processing a high load concentrates *all* of its power loss in one switch and one inductor. This creates a single, intense "hot spot" that is very difficult to cool, often requiring large, heavy, or active (forced-air) thermal management solutions.27  
  * **The Solution:** Interleaving "spread\[s\] components and dissipated power over the PCB area".9 The total power loss is distributed over $N$ phases, "which simplifies the design for thermal management considerably".42 Instead of one 50 W hot spot, the designer manages four 12.5 W spots, which can often be cooled passively by the PCB itself.

A powerful synergy exists between interleaving and the adoption of Wide-Bandgap (WBG) devices like Silicon Carbide (SiC) and Gallium Nitride (GaN).18 WBG devices can switch at very high frequencies ($\>1$ MHz) with low loss, enabling smaller passives. Interleaving *multiplies* this benefit. A designer can achieve a 600 kHz effective ripple frequency (for small passives) in two ways:

1. **Single-Phase WBG:** $f\_{sw} \= 600$ kHz. (High switching losses).  
2. **Two-Phase WBG:** $f\_{sw} \= 300$ kHz, $N=2$. (Effective freq. \= $2 \\times 300 \= 600$ kHz).

Option (2) achieves the *exact same* ripple reduction and passive component sizing as Option (1), but with *half* the switching losses. This combination of WBG and interleaving is a key enabler for next-generation power density, maximizing efficiency while minimizing the size of both passive components and thermal hardware.42

### **4.4 Electromagnetic Interference (EMI) Mitigation**

Interleaving is a powerful EMI mitigation technique that attacks the noise source in two ways:

1. **Amplitude Reduction:** As shown in Section 2.1, the cancellation of ripple current at the input and output directly reduces the *magnitude* of the fundamental noise source.45  
2. **Frequency Shifting:** The $N \\times f\_{sw}$ effective frequency *shifts* the fundamental EMI noise component (and its primary harmonics) to a much higher frequency.45

This frequency-shifting benefit is substantial. EMI filters are passive low-pass filters designed to attenuate noise at and above the switching frequency. By pushing this fundamental noise component higher (e.g., from 100 kHz to 400 kHz), the filter's required "corner frequency" is also pushed higher. A filter designed to attenuate noise above 400 kHz is *significantly smaller, lighter, and cheaper* than one designed to attenuate at 100 kHz for the same level of performance.37

## **Section 5: Key Design Trade-offs and Mitigation Strategies**

Despite its significant advantages, the interleaved architecture is not a panacea. It introduces specific trade-offs, primarily in cost, complexity, and, most critically, light-load efficiency.

### **5.1 The Light-Load Efficiency Challenge**

The core trade-off of any switching converter is between conduction and switching losses.13

* **Conduction Losses:** $I^2R$ losses in the MOSFETs and inductors. These are proportional to the *square* of the load current and *dominate* at heavy loads.48  
* **Switching Losses:** Losses from charging/discharging the FET's gate ($Q\_g$) and output capacitance ($C\_{oss}$), and from reverse recovery ($Q\_{rr}$). These are proportional to $f\_{sw}$ and are largely *independent* of the load current. They *dominate* at light loads.13

Interleaving exploits this. At *high load*, it reduces total conduction loss by a factor of $N$ (as shown in Sec 4.2), resulting in *higher* efficiency than a single-phase design.49

However, at *light load*, the conduction losses become negligible, and the switching losses dominate. An $N$-phase converter has $N$ sets of switches, $N$ sets of drivers, and $N$ inductors. At light load, all $N$ phases are still switching, *each one* incurring its own fixed switching losses.49

The result is a fundamental trade-off: **"compared with a single-phase converter, the interleaved multiphase converter has a higher efficiency at heavy load; there's a penalty at light load"**.49

Other significant trade-offs include:

* **Complexity and Cost:** The system is inherently more complex and costly, requiring $N$ sets of switches, drivers, and inductors, plus a sophisticated controller capable of generating $N$ precision phase-shifted drive signals.38  
* **Current Sharing:** Ensuring that all $N$ phases precisely share the load current ($I\_{OUT}/N$) is a "troublesome issue".49 Component mismatches can lead to "dramatic phase-current imbalance".49 This imbalance negates the benefits of ripple cancellation, reduces efficiency, and causes thermal stress on the over-loaded phases.27 This necessitates active current-sharing control loops, further increasing complexity.

### **5.2 Mitigation Strategy: Dynamic Phase Shedding (DPS)**

To solve the critical light-load efficiency problem, modern controllers implement *Dynamic Phase Shedding* (DPS), also known as "load adaptive control" or "phase management".27

The concept is simple: as the load current decreases, the controller actively *disables* (sheds) phases.50 For example, a 4-phase converter may drop to 2 phases at 30% load, and to 1 phase at 5% load.

The mechanism is highly effective. By turning off 3 of the 4 phases, the switching losses associated with those 3 phases are *completely eliminated*.49 The single active phase then handles the entire light load, operating at a much more efficient point on its own performance curve. This technique dramatically flattens the converter's efficiency curve across the entire load range.

The measured performance improvement is unambiguous:

* A TI reference design (TIDT445) for a 4-phase buck converter utilizes DPS to achieve **81% efficiency at an exceptionally light 15 mA load**.32  
* A 2-phase boost converter demonstrated **92% efficiency at 3 A** (both phases active) and retained **90% efficiency at 2 mA** (one phase shed).52

This solution, however, introduces its own trade-offs.

1. **Increased Ripple/EMI:** When phases are shed (e.g., $N=4$ becomes $N=1$), the ripple cancellation and frequency multiplication benefits are *completely lost*. This "will result in the EMI noise increase".45 The designer must accept a trade-off: high light-load efficiency for high light-load ripple.  
2. **Transient Response:** A converter operating with shed phases is vulnerable. If the load suddenly steps from 5% to 100%, the converter's transient response will be that of a single phase ($L\_{EQ} \= L\_{phase}$), not the fast $L\_{EQ} \= L\_{phase}/N$ response. To solve this, advanced controllers must "quickly add or remove phases" 27 and implement an "inrush" or "Global Wake-up" (Gwu) signal that *instantly* reactivates all phases upon detecting a high-slew-rate load step, bypassing the shedding logic to ensure system stability.53

### **5.3 Design Case Study: Component Selection and Loss Calculation**

The design of a multi-phase converter is an exercise in multi-variable optimization. Authoritative application notes 27 and academic methodologies 13 provide a clear design flow.

A typical design procedure for a high-current multi-phase buck converter (e.g., 12V input, 0.9V output, 240A max current) follows these steps 27:

1. **Define Targets:** $V\_{IN}$ (12 V), $V\_{OUT}$ (0.9 V), $I\_{MAX}$ (240 A), $I\_{TDC}$ (Thermal Design Current, 200 A), $I\_{STEP}$ (150 A), and the maximum allowable transient voltage deviation $\\Delta V\_{OUT(AC)}$ (e.g., $\\pm$5% or 45 mV).  
2. **Select Phase Count ($N$):** Based on a manageable maximum current per phase (typically 30 A \- 40 A). For $I\_{MAX} \= 240$ A, $N=6$ phases is a logical choice, yielding 40 A/phase at max load.  
3. **Select Switching Frequency ($f\_{sw}$):** This is a primary trade-off. A low $f\_{sw}$ (e.g., 300 kHz) gives high efficiency but slower transient response. A high $f\_{sw}$ (e.g., 1 MHz) gives fast transient response but high switching losses. A balanced choice (e.g., 600 kHz) is often selected.  
4. **Select Inductance ($L$):** Based on a target ripple current per phase (e.g., 25% of the max phase current).  
5. **Select Power Stage (FETs):** Based on $V\_{DS}$ rating, $R\_{DS(on)}$ (for conduction loss), $Q\_g$ and $Q\_{rr}$ (for switching loss), and thermal performance.  
6. **Select Input Capacitors:** Sized to handle the *interleaved* input ripple current (RMS) and meet the $\\Delta V\_{IN(DC)}$ specification.  
7. **Select Output Capacitors:** This is almost *always* the most critical step. The capacitance is sized not to meet the steady-state $\\Delta V\_{OUT(DC)}$ (which is already very low due to interleaving), but to meet the *transient voltage deviation* ($\\Delta V\_{OUT(AC)}$) during the $I\_{STEP}$ load transient.27

To perform this optimization, a detailed loss budget is required, as summarized in Table 1\.

Table 1: Power Loss Calculation Dependencies for Optimized Design  
(Based on 13\)

| Loss Mechanism | Key Dependencies & Variables |
| :---- | :---- |
| **FET Conduction Losses** | $N \\times (I\_{phase,RMS})^2 \\times R\_{DS(on)}$ (Duty cycle dependent) |
| **FET Switching Losses** | $N \\times f\_{sw} \\times (P\_{turn-on} \+ P\_{turn-off})$. Highly dependent on $V\_{IN}$, $I\_{phase}$, $Q\_{rr}$ (reverse recovery), $Q\_g$ (gate charge). |
| **Body Diode Losses** | $N \\times V\_f \\times I\_{L} \\times t\_{dt}$ (where $t\_{dt}$ \= dead time). |
| **Gate Charge Losses** | $N \\times Q\_g \\times V\_{drive} \\times f\_{sw}$ |
| **Inductor Conduction Loss** | $N \\times (I\_{phase,RMS})^2 \\times DCR$ (DC Resistance of inductor). |
| **Inductor Core Loss** | Function of $f\_{sw}$, $\\Delta B$ (flux density ripple), and core material properties. |
| **Capacitor Losses (Input/Output)** | $(I\_{cap,RMS})^2 \\times ESR$ |

The complete system trade-off between a single-phase and multi-phase design is synthesized in Table 2\.

**Table 2: Single-Phase vs. N-Phase Interleaved Converter Trade-off Summary**

| Performance Metric | Single-Phase Converter | N-Phase Interleaved Converter |
| :---- | :---- | :---- |
| **Input Current Ripple** | High | Low (Cancellation at $D=i/N$) 12 |
| **Output Voltage Ripple** | High | Low (Cancellation, $N \\times f\_{sw}$) 9 |
| **Effective Ripple Frequency** | $f\_{sw}$ | $N \\times f\_{sw}$ 8 |
| **Transient Response (Slew Rate)** | Slow ($di/dt \\propto 1/L$) | **Fast** ($di/dt \\propto N/L$) 28 |
| **Passive Component Size** | Large | **Small** 18 |
| **Current/Thermal Stress** | Concentrated ("Hot Spot") 27 | **Distributed** 28 |
| **Heavy-Load Efficiency** | Baseline (High $I^2R$ loss) | **Higher** (Conduction loss reduced by $N$) 49 |
| **Light-Load Efficiency** | Baseline (Low switching loss) | **Lower** ($N \\times$ switching loss) 49 |
| **...with Phase Shedding** | N/A | **Higher** (Switching losses eliminated) 32 |
| **Control Complexity & Cost** | Low / Simple | High / Complex 39 |
| **EMI Filter Size** | Large | **Small** 43 |

## **Section 6: Authoritative Sources and Foundational Research**

The principles of interleaved converter design are built upon a foundation of seminal textbooks, extensive journal-level research, and system-level performance standards.

### **6.1 Seminal Textbooks in Power Electronics**

* **Mohan, Undeland, and Robbins, *Power Electronics: Converters, Applications, and Design***: This is a cornerstone text for the entire field of power electronics, providing a "cohesive presentation of power electronics fundamentals".54 While a review of the 3rd Edition's table of contents does not show a chapter dedicated exclusively to "Interleaving" 54, the principles are direct applications of the fundamentals covered in **Chapter 7 (dc-dc Switch-Mode Converters)** and **Chapter 10 (Switching dc Power Supplies)**. The book provides the essential, rigorous treatment of magnetic design (Chapter 30), thermal management (Chapter 29), and switch physics (Part 6\) required to successfully analyze and design any advanced converter, including multi-phase architectures.  
* **Erickson and Maksimovic, *Fundamentals of Power Electronics***: (Not explicitly in the provided material, but equally foundational). This text is renowned for its in-depth, rigorous treatment of converter modeling, control, and state-space averaging. The analysis of ripple cancellation and dynamic behavior in interleaved converters is a direct extension of the modeling techniques presented in this text.

### **6.2 Key IEEE Journals and Standards**

* **Journals:**  
  * ***IEEE Transactions on Power Electronics (TPEL)***: This is the preeminent, peer-reviewed journal for publishing new research in power electronics.58 It is the primary "authoritative source" for the latest advancements in interleaved control strategies, magnetic integration, optimization techniques, and novel multi-phase topologies.  
* **Standards:**  
  * A critical finding is that there is *no* single IEEE or IEC standard document titled "Design of Multi-Phase DC-DC Converters".13 The design of an interleaved converter is an *optimization methodology* 13 used to *meet* other standards, not a standardized process itself.  
  * Instead, standards apply at the *system level*, defining the *requirements* the converter must satisfy. The designer then *uses* interleaving as a tool to meet these standards. Key examples include:  
    * **IEC 60571 / EN 50155:** Covers electronic equipment used on railway vehicles, specifying strict operating temperature classes and requirements for handling voltage interruptions and fluctuations.62  
    * **IEC 62477-2:** Specifies safety and testing requirements for Power Electronic Converter Systems (PECS) up to 54 kV DC.63  
    * **IEC 62909-1:** Defines terminology, performance, and system architecture for bi-directional grid-connected power converters (GCPCs), many of which utilize multi-phase architectures.64

### **6.3 Foundational Research Papers (Annotated)**

A vast body of literature exists, but the following papers are foundational to the development and application of interleaved converters:

* Perreault, D.J., and Kassakian, J.G. “Distributed Interleaving of Paralleled Power Converters.” *IEEE Transactions on Circuits and Systems I: Fundamental Theory and Applications*. 44, no. 8 (1997): 728–734..26  
  * *Significance:* This seminal work established the theory of decentralized, self-aligning, and fault-tolerant interleaving. As detailed in Section 3.3, it provides an elegant, robust control method that requires no master controller, which is critical for high-reliability systems.  
* Balogh, L., and Redl, R. “Power-factor correction with interleaved boost converters in continuous-inductor-current mode.” *Proc. 8th Annu. IEEE APEC*, 1993, pp. 168-174..65  
  * *Significance:* This is one of the key papers that demonstrated the application of interleaving to Power Factor Correction (PFC) boost converters. This is now a standard industry practice for high-power AC-DC power supplies to reduce input harmonic distortion and mitigate input filter size.  
* Panov, Y. and Jovanovic, M.M. “Design Considerations for 12-V/1.5-V, 50A Voltage Regulator Modules.” *IEEE Trans. Power Electron.*, vol. 16, no. 6, pp. 776-783, Nov, 2001..66  
  * *Significance:* This paper is part of the body of research that solidified the multi-phase interleaved buck converter as the dominant solution for Voltage Regulator Modules (VRMs) powering high-current, low-voltage microprocessors. It analyzed the design considerations necessary to meet the extreme transient demands, driving the development detailed in Section 4.1.  
* Poon, N.K., Liu, J.C.P., Tse, C.K., and Pong, M.H. "Techniques for Input Ripple Current Cancellation." *IEEE Trans. Power Electron.*, vol. 15, no. 6, 2000\. (Referenced from 11).  
  * *Significance:* This work provides a systematic classification and analysis of various active and passive ripple cancellation methods.10 It places interleaving within the broader engineering context of EMI mitigation, comparing it to other techniques and providing a clear framework for its application.

## **Section 7: Conclusions**

The analysis of interleaved DC-DC converters reveals a sophisticated system-level architecture whose core principle—the time-phased operation of parallel converter stages—provides a cascade of compounding benefits. The primary physical mechanism of effective frequency multiplication ($N \\times f\_{sw}$) directly enables the reduction of input and output ripple, which in turn allows for a significant reduction in the size, cost, and stress of passive filter components.

This architectural approach has two primary, and transformative, applications:

1. **For High-Power Systems (PFC, EV, Renewables):** Interleaving allows for a distributed thermal and current load. By dividing a high-power load ($\>1$ kW) among $N$ smaller, more efficient, and more manageable phases, the architecture "spreads the heat" and dramatically simplifies thermal management. This, combined with the reduction in EMI filter size, makes it a default topology for high-density, high-power conversion.  
2. **For High-Current, Low-Voltage Systems (VRMs):** The "killer application" for interleaving is its ability to provide unparalleled transient response. The $L\_{EQ} \= L\_{phase}/N$ equivalent transient model is the key to meeting the high-slew-rate current demands of modern microprocessors—a challenge that single-phase converters are physically incapable of addressing efficiently.

The architecture's primary weakness—poor light-load efficiency due to $N$-times the switching losses—has been effectively mitigated by the ubiquitous adoption of Dynamic Phase Shedding (DPS). This control strategy, combined with the performance of advanced digital controllers, delivers high efficiency at both heavy-load (via $1/N$ conduction loss) and light-load (via phase shedding) operating points.

The future of interleaved converters lies in the continued exploitation of dynamic, asymmetric control to compensate for real-world component imperfections, and in its powerful synergy with wide-bandgap (GaN and SiC) devices. This combination allows designers to push effective frequencies into the multi-megahertz range, unlocking new frontiers in power density and performance.

#### **Works cited**

1. DC-to-DC converter \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/DC-to-DC\_converter](https://en.wikipedia.org/wiki/DC-to-DC_converter)  
2. Analysis of a multi-phase interleaved bidirectional DC/DC power converter with coupled inductor \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/322565643\_Analysis\_of\_a\_multi-phase\_interleaved\_bidirectional\_DCDC\_power\_converter\_with\_coupled\_inductor](https://www.researchgate.net/publication/322565643_Analysis_of_a_multi-phase_interleaved_bidirectional_DCDC_power_converter_with_coupled_inductor)  
3. An Overview of Asymmetric Interleaving in Power Converters \- Cadence System Analysis, accessed October 29, 2025, [https://resources.system-analysis.cadence.com/blog/msa2021-an-overview-of-asymmetric-interleaving-in-power-converters](https://resources.system-analysis.cadence.com/blog/msa2021-an-overview-of-asymmetric-interleaving-in-power-converters)  
4. accessed October 29, 2025, [https://octopart.com/pulse/p/do-you-need-an-interleaved-dc-dc-converter\#:\~:text=An%20interleaved%20DC%2DDC%20converter%20uses%20multiple%20switching%20converter%20stages,of%20interleaved%20DC%2DDC%20converter.](https://octopart.com/pulse/p/do-you-need-an-interleaved-dc-dc-converter#:~:text=An%20interleaved%20DC%2DDC%20converter%20uses%20multiple%20switching%20converter%20stages,of%20interleaved%20DC%2DDC%20converter.)  
5. Do You Need an Interleaved DC-DC Converter? \- Octopart, accessed October 29, 2025, [https://octopart.com/pulse/p/do-you-need-an-interleaved-dc-dc-converter](https://octopart.com/pulse/p/do-you-need-an-interleaved-dc-dc-converter)  
6. Interleaving Converters \- Brady Salz, accessed October 29, 2025, [https://www.bradysalz.com/technical/interleaving/](https://www.bradysalz.com/technical/interleaving/)  
7. Experimenting with Magnetic Components \#3: Interleaved Boost Converter for PV System, accessed October 29, 2025, [https://community.element14.com/challenges-projects/design-challenges/experimenting-with-magnetic-components/b/blog/posts/experimenting-with-magnetic-components-3-interleaved-boost-converter-for-pv-system](https://community.element14.com/challenges-projects/design-challenges/experimenting-with-magnetic-components/b/blog/posts/experimenting-with-magnetic-components-3-interleaved-boost-converter-for-pv-system)  
8. AN-1820 LM5032 Interleaved Boost Converter ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/an/snva335a/snva335a.pdf](https://www.ti.com/lit/an/snva335a/snva335a.pdf)  
9. Designing a Multi-Phase Buck Converter with Digital Controllers \- Monolithic Power Systems, accessed October 29, 2025, [http://www.monolithicpower.com/learning/resources/designing-a-multi-phase-buck-converter-with-digital-controllers](http://www.monolithicpower.com/learning/resources/designing-a-multi-phase-buck-converter-with-digital-controllers)  
10. Techniques for input ripple current cancellation: classification and implementation \- Power Electronics, IEEE Transactions on \- CORE, accessed October 29, 2025, [https://core.ac.uk/download/pdf/37882183.pdf](https://core.ac.uk/download/pdf/37882183.pdf)  
11. Techniques for Input Ripple Current Cancellation: Classification and Implementation, accessed October 29, 2025, [https://u.dianyuan.com/bbs/u/18/1088131455.pdf](https://u.dianyuan.com/bbs/u/18/1088131455.pdf)  
12. An Interleaved PFC Preregulator for High-Power Converters \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/slua746](https://www.ti.com/lit/slua746)  
13. Design Considerations of Multi-Phase Buck DC-DC Converter \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2076-3417/13/19/11064](https://www.mdpi.com/2076-3417/13/19/11064)  
14. Considerations for the Output Current and Voltage Ripple in a ..., accessed October 29, 2025, [https://www.analog.com/en/resources/analog-dialogue/articles/output-current-and-volt-ripple-in-multiphase-buck.html](https://www.analog.com/en/resources/analog-dialogue/articles/output-current-and-volt-ripple-in-multiphase-buck.html)  
15. Ripple (electrical) \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Ripple\_(electrical)](https://en.wikipedia.org/wiki/Ripple_\(electrical\))  
16. Ripple Current in Capacitors – Complete Guide for OEMs and Bulk Buyers. \- Edzeal, accessed October 29, 2025, [https://edzeal.in/ripple-current-in-electrolytic-capacitors-a-crucial-guide-for-circuit-designers-oems/](https://edzeal.in/ripple-current-in-electrolytic-capacitors-a-crucial-guide-for-circuit-designers-oems/)  
17. Capacitor Ripple Current in an Interleaved PFC Converter \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/224504609\_Capacitor\_Ripple\_Current\_in\_an\_Interleaved\_PFC\_Converter](https://www.researchgate.net/publication/224504609_Capacitor_Ripple_Current_in_an_Interleaved_PFC_Converter)  
18. Soft-Switching, Interleaved Inverter for High Density Applications \- VTechWorks, accessed October 29, 2025, [https://vtechworks.lib.vt.edu/bitstream/handle/10919/73584/Born\_RG\_T\_2016.pdf](https://vtechworks.lib.vt.edu/bitstream/handle/10919/73584/Born_RG_T_2016.pdf)  
19. (PDF) Interleaved Switching of DC/DC Converters \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/308886975\_Interleaved\_Switching\_of\_DCDC\_Converters](https://www.researchgate.net/publication/308886975_Interleaved_Switching_of_DCDC_Converters)  
20. Performance Improvement of Voltage-mode Controlled Interleaved Buck Converters \- Journal of Power Electronics (JPE), accessed October 29, 2025, [https://jpels.org/digital-library/manuscript/file/17333/JPE%205-2-3.pdf](https://jpels.org/digital-library/manuscript/file/17333/JPE%205-2-3.pdf)  
21. Basic Design and Review of Two Phase and Three ... \- Prime Scholars, accessed October 29, 2025, [https://www.primescholars.com/articles/basic-design-and-review-of-two-phase-and-three-phase-interleaved-boost-converter-for-renewable-energy-systems.pdf](https://www.primescholars.com/articles/basic-design-and-review-of-two-phase-and-three-phase-interleaved-boost-converter-for-renewable-energy-systems.pdf)  
22. Power Stacked Structure Multi-Phase Interleaved Resonant Converter Based on Y-Connection Transformer \- Aalborg Universitets forskningsportal, accessed October 29, 2025, [https://vbn.aau.dk/files/699840257/Power\_Stacked\_Structure\_Multi-Phase\_Interleaved\_Resonant\_Converter\_Based\_on\_Y-Connection\_Transformer.pdf](https://vbn.aau.dk/files/699840257/Power_Stacked_Structure_Multi-Phase_Interleaved_Resonant_Converter_Based_on_Y-Connection_Transformer.pdf)  
23. Characterization of Steady-State Current Ripple in Interleaved Power Converters Under Inductance Mismatches, accessed October 29, 2025, [https://ri.conicet.gov.ar/bitstream/handle/11336/34728/CONICET\_Digital\_Nro.217b407c-26f9-463e-acc4-4379a83aed3e\_A.pdf?sequence=2\&isAllowed=y](https://ri.conicet.gov.ar/bitstream/handle/11336/34728/CONICET_Digital_Nro.217b407c-26f9-463e-acc4-4379a83aed3e_A.pdf?sequence=2&isAllowed=y)  
24. Optimized Ripple Prelearning Process for Phase-Shift Control of Interleaved Multiphase DC–DC Converters \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/383824404\_Optimized\_Ripple\_Prelearning\_Process\_for\_Phase-Shift\_Control\_of\_Interleaved\_Multiphase\_DC-DC\_Converters](https://www.researchgate.net/publication/383824404_Optimized_Ripple_Prelearning_Process_for_Phase-Shift_Control_of_Interleaved_Multiphase_DC-DC_Converters)  
25. (PDF) Interleaved Modulation Scheme With Optimized Phase ..., accessed October 29, 2025, [https://www.researchgate.net/publication/350704551\_Interleaved\_Modulation\_Scheme\_With\_Optimized\_Phase\_Shifting\_for\_Double-Switch\_Buck-Boost\_Converter](https://www.researchgate.net/publication/350704551_Interleaved_Modulation_Scheme_With_Optimized_Phase_Shifting_for_Double-Switch_Buck-Boost_Converter)  
26. Distributed Interleaving Of Paralleled Power ... \- DSpace@MIT, accessed October 29, 2025, [https://dspace.mit.edu/bitstream/handle/1721.1/86986/Perreault%20distributed%20interleaving.pdf?sequence=1\&isAllowed=y](https://dspace.mit.edu/bitstream/handle/1721.1/86986/Perreault%20distributed%20interleaving.pdf?sequence=1&isAllowed=y)  
27. Multiphase Buck Design From Start to Finish (Part 1\) \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/an/slva882b/slva882b.pdf](https://www.ti.com/lit/an/slva882b/slva882b.pdf)  
28. Optimal design for an interleaved synchronous ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slyt139](https://www.ti.com/lit/pdf/slyt139)  
29. A Multi-phase Series Capacitor Trans-inductor Voltage Regulator with High Switching Frequency and Fast Dynamic Response \- Haoyu Wang, accessed October 29, 2025, [https://pearl.shanghaitech.edu.cn/pdf/wangl20230606.pdf](https://pearl.shanghaitech.edu.cn/pdf/wangl20230606.pdf)  
30. Investigation of Multiphase Coupled-Inductor Buck Converters in Point-of-Load Applications \- VTechWorks, accessed October 29, 2025, [https://vtechworks.lib.vt.edu/bitstream/handle/10919/28469/ETD\_final\_Rev2.pdf](https://vtechworks.lib.vt.edu/bitstream/handle/10919/28469/ETD_final_Rev2.pdf)  
31. Performance Improvements of Multi-Channel Interleaving Voltage Regulator Modules with Integrated Coupling Inductors \- VTechWorks, accessed October 29, 2025, [https://vtechworks.lib.vt.edu/bitstreams/a6d8e227-bf0b-4853-bc6b-191d6f1b872a/download](https://vtechworks.lib.vt.edu/bitstreams/a6d8e227-bf0b-4853-bc6b-191d6f1b872a/download)  
32. 450W Four-Phase Interleave Buck Converter ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/tidt445](https://www.ti.com/lit/pdf/tidt445)  
33. RST-Controlled Interleaved Boost Converters for Enhanced Stability in CPL-Dominated DC Microgrids \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2073-8994/17/10/1585](https://www.mdpi.com/2073-8994/17/10/1585)  
34. (PDF) State-Space Derivation of Two Phase DC-DC Interleaved Boost Converter, accessed October 29, 2025, [https://www.researchgate.net/publication/340818658\_State-Space\_Derivation\_of\_Two\_Phase\_DC-DC\_Interleaved\_Boost\_Converter](https://www.researchgate.net/publication/340818658_State-Space_Derivation_of_Two_Phase_DC-DC_Interleaved_Boost_Converter)  
35. Multi-Phase Interleaved Bidirectional DC/DC Converter with Coupled Inductor for Electrified-Vehicle Applications | Request PDF \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/343561254\_Multi-Phase\_Interleaved\_Bidirectional\_DCDC\_Converter\_with\_Coupled\_Inductor\_for\_Electrified-Vehicle\_Applications](https://www.researchgate.net/publication/343561254_Multi-Phase_Interleaved_Bidirectional_DCDC_Converter_with_Coupled_Inductor_for_Electrified-Vehicle_Applications)  
36. Study of the Effects of Current Imbalance in a Multiphase Buck Converter for Electric Vehicles \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2032-6653/13/5/88](https://www.mdpi.com/2032-6653/13/5/88)  
37. Interleaving Impact on AC Passive Components of Paralleled Three-Phase Voltage-Source Converters | Request PDF \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/224343953\_Interleaving\_Impact\_on\_AC\_Passive\_Components\_of\_Paralleled\_Three-Phase\_Voltage-Source\_Converters](https://www.researchgate.net/publication/224343953_Interleaving_Impact_on_AC_Passive_Components_of_Paralleled_Three-Phase_Voltage-Source_Converters)  
38. interleaved vs multiphase buck \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/658493/interleaved-vs-multiphase-buck](https://electronics.stackexchange.com/questions/658493/interleaved-vs-multiphase-buck)  
39. Efficiency comparison between the interleaved boost converters with and without using the proposed ZVT cell \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/figure/Efficiency-comparison-between-the-interleaved-boost-converters-with-and-without-using-the\_fig10\_340141138](https://www.researchgate.net/figure/Efficiency-comparison-between-the-interleaved-boost-converters-with-and-without-using-the_fig10_340141138)  
40. A High-Conversion Ratio Multiphase Converter Realized with Generic Modular Cells \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2076-3417/15/12/6818](https://www.mdpi.com/2076-3417/15/12/6818)  
41. Analysis, design, and minimum phase selection of high power ..., accessed October 29, 2025, [https://www.researchgate.net/publication/363310873\_Analysis\_design\_and\_minimum\_phase\_selection\_of\_high\_power\_interleaved\_DC-DC\_converter](https://www.researchgate.net/publication/363310873_Analysis_design_and_minimum_phase_selection_of_high_power_interleaved_DC-DC_converter)  
42. An Interleaved Multi-Phase Boost Converter with Coupled Inductors for High Power Density, accessed October 29, 2025, [https://www.researchgate.net/publication/365903850\_An\_Interleaved\_Multi-Phase\_Boost\_Converter\_with\_Coupled\_Inductors\_for\_High\_Power\_Density](https://www.researchgate.net/publication/365903850_An_Interleaved_Multi-Phase_Boost_Converter_with_Coupled_Inductors_for_High_Power_Density)  
43. A Comparative Study for Interleaved Boost Converter with Coupled/Uncoupled Inductors, accessed October 29, 2025, [http://www.eleco.org.tr/ELECO2023/eleco2023-papers/211.pdf](http://www.eleco.org.tr/ELECO2023/eleco2023-papers/211.pdf)  
44. Flattened Power Converter Design with Improved Thermal Performance for High-Power-Density Energy Conversion \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/18/13/3416](https://www.mdpi.com/1996-1073/18/13/3416)  
45. Investigation on Interleaved Boost Converters and Applications \- VTechWorks, accessed October 29, 2025, [https://vtechworks.lib.vt.edu/bitstream/handle/10919/28635/ETD\_CWang\_Final08252009.pdf](https://vtechworks.lib.vt.edu/bitstream/handle/10919/28635/ETD_CWang_Final08252009.pdf)  
46. Coupled Inductor Design for Interleaved Three- level Active Neutral Point Clamped Inverters Considering EMI Noise Reduction \- OSTI.gov, accessed October 29, 2025, [https://www.osti.gov/servlets/purl/1559618](https://www.osti.gov/servlets/purl/1559618)  
47. Impact of Interleaving on AC Passive Components of Paralleled Three-Phase Voltage-Source Converters | Semantic Scholar, accessed October 29, 2025, [https://www.semanticscholar.org/paper/Impact-of-Interleaving-on-AC-Passive-Components-of-Zhang-Wang/cd959c7701d8e8a336be20e4d3670198767f3e92](https://www.semanticscholar.org/paper/Impact-of-Interleaving-on-AC-Passive-Components-of-Zhang-Wang/cd959c7701d8e8a336be20e4d3670198767f3e92)  
48. Proposal of Phase Shedding Control System for Multiphase PFC Converter, accessed October 29, 2025, [https://www.aisan-ind.co.jp/en/innovation/journal/2025/pdf/aisan-technical-journal2025\_No8-en\_24-27.pdf](https://www.aisan-ind.co.jp/en/innovation/journal/2025/pdf/aisan-technical-journal2025_No8-en_24-27.pdf)  
49. Improving the interleaved DC/DC converter \- EE Times, accessed October 29, 2025, [https://www.eetimes.com/improving-the-interleaved-dc-dc-converter/](https://www.eetimes.com/improving-the-interleaved-dc-dc-converter/)  
50. (PDF) Phase-Shedding Control in Two Parallel Interleaved Three ..., accessed October 29, 2025, [https://www.researchgate.net/publication/372641245\_Phase-Shedding\_Control\_in\_Two\_Parallel\_Interleaved\_Three-Phase\_ZVS\_Inverters\_for\_Improved\_Light\_Load\_Efficiency\#:\~:text=A%20phase%2Dshedding%20control%20method,legs%20at%20a%20light%20load.](https://www.researchgate.net/publication/372641245_Phase-Shedding_Control_in_Two_Parallel_Interleaved_Three-Phase_ZVS_Inverters_for_Improved_Light_Load_Efficiency#:~:text=A%20phase%2Dshedding%20control%20method,legs%20at%20a%20light%20load.)  
51. Analysis And Design Optimization Of Multiphase Converter \- CORE, accessed October 29, 2025, [https://core.ac.uk/download/pdf/236296934.pdf](https://core.ac.uk/download/pdf/236296934.pdf)  
52. What is phase shedding in a multiphase boost converter, and why is it important? \- Integrated Circuits (ICs) \- DigiKey TechForum \- An Electronic Component and Engineering Solution Forum, accessed October 29, 2025, [https://forum.digikey.com/t/what-is-phase-shedding-in-a-multiphase-boost-converter-and-why-is-it-important/56030](https://forum.digikey.com/t/what-is-phase-shedding-in-a-multiphase-boost-converter-and-why-is-it-important/56030)  
53. Decentralized Phase Shedding with Low Power Mode for Multiphase Converter \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/14/20/6748](https://www.mdpi.com/1996-1073/14/20/6748)  
54. Power Electronics: Converters, Applications, and Design, 3rd Edition ..., accessed October 29, 2025, [https://www.wiley.com/en-us/Power+Electronics%3A+Converters%2C+Applications%2C+and+Design%2C+3rd+Edition-p-9780471226932](https://www.wiley.com/en-us/Power+Electronics%3A+Converters%2C+Applications%2C+and+Design%2C+3rd+Edition-p-9780471226932)  
55. Power Electronics, accessed October 29, 2025, [https://uodiyala.edu.iq/uploads/PDF%20ELIBRARY%20UODIYALA/EL23/Mohan\_-\_Power\_Electronics.pdf](https://uodiyala.edu.iq/uploads/PDF%20ELIBRARY%20UODIYALA/EL23/Mohan_-_Power_Electronics.pdf)  
56. Power Electronics: Converters, Applications, and Design \- Ned ..., accessed October 29, 2025, [https://books.google.com/books/about/Power\_Electronics.html?id=jRV0CgAAQBAJ](https://books.google.com/books/about/Power_Electronics.html?id=jRV0CgAAQBAJ)  
57. Power Electronics: Converters, Applications, and Design, 2nd Edition \- Goodreads, accessed October 29, 2025, [https://www.goodreads.com/book/show/4250697](https://www.goodreads.com/book/show/4250697)  
58. IEEE Transactions on Power Electronics, accessed October 29, 2025, [https://www.ieee-pels.org/publications/transactions-on-power-electronics/](https://www.ieee-pels.org/publications/transactions-on-power-electronics/)  
59. Design of multi-phase DC-DC converter with averaged current sharing control, accessed October 29, 2025, [https://www.researchgate.net/publication/4060346\_Design\_of\_multi-phase\_DC-DC\_converter\_with\_averaged\_current\_sharing\_control](https://www.researchgate.net/publication/4060346_Design_of_multi-phase_DC-DC_converter_with_averaged_current_sharing_control)  
60. (PDF) Design Considerations of Multi-Phase Buck DC-DC Converter \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/374562541\_Design\_Considerations\_of\_Multi-Phase\_Buck\_DC-DC\_Converter](https://www.researchgate.net/publication/374562541_Design_Considerations_of_Multi-Phase_Buck_DC-DC_Converter)  
61. Design of multi-phase DC-DC converter with master-slave current sharing control, accessed October 29, 2025, [https://www.semanticscholar.org/paper/Design-of-multi-phase-DC-DC-converter-with-current-Guoyong-Bingxue/61b3a6caa1dff266f0410ad067f98e423287b9d4](https://www.semanticscholar.org/paper/Design-of-multi-phase-DC-DC-converter-with-current-Guoyong-Bingxue/61b3a6caa1dff266f0410ad067f98e423287b9d4)  
62. DC-DC Converter compliant to Railway Standard IEC 60571 \- Intrexis AG, accessed October 29, 2025, [https://www.intrexis.ch/en/standards/railway-standard-iec-60571-2012](https://www.intrexis.ch/en/standards/railway-standard-iec-60571-2012)  
63. IEC 62477-2:2018, accessed October 29, 2025, [https://webstore.iec.ch/en/publication/31546](https://webstore.iec.ch/en/publication/31546)  
64. IEC 62909-1:2017 \- INTERNATIONAL STANDARD NORME INTERNATIONALE, accessed October 29, 2025, [https://cdn.standards.iteh.ai/samples/21397/aefea6d0c52e42e1baa15dcf995cf03a/IEC-62909-1-2017.pdf](https://cdn.standards.iteh.ai/samples/21397/aefea6d0c52e42e1baa15dcf995cf03a/IEC-62909-1-2017.pdf)  
65. Design Guidelines for Interleaved Single-Phase Boost PFC Circuits \- Conferences \- ETH Zürich, accessed October 29, 2025, [https://www.pes-publications.ee.ethz.ch/uploads/tx\_ethpublications/04814667.pdf](https://www.pes-publications.ee.ethz.ch/uploads/tx_ethpublications/04814667.pdf)  
66. Quantification Analysis of the Input Current in the Multiphase Buck Converter and Its Application | Zhang \- Praise Worthy Prize, accessed October 29, 2025, [https://www.praiseworthyprize.org/jsm/index.php?journal=irea\&page=article\&op=view\&path%5B%5D=12046](https://www.praiseworthyprize.org/jsm/index.php?journal=irea&page=article&op=view&path%5B%5D=12046)