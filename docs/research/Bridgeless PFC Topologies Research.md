

# **A Comprehensive Analysis of Bridgeless Power Factor Correction Topologies: Efficiency, Conduction Loss, and Foundational Research**

## **I. Foundational Concepts in Active Power Factor Correction**

To analyze the merits of specific power converter topologies, a shared understanding of foundational principles and terminology is essential. This section establishes the definitions for power factor, harmonic distortion, and the loss mechanisms that govern converter efficiency.

### **Defining Power Factor (PF) and Power Factor Correction (PFC)**

In an AC power system, the **Power Factor (PF)** is a metric that measures how effectively electrical power is being used.1 It is formally defined as the ratio of working power (measured in kilowatts, kW) to apparent power (measured in kilovolt-amperes, kVA).1 A high power factor (approaching 1.0) signals efficient power utilization, while a low power factor indicates poor utilization.2

Simple AC-DC power supplies, which use a diode bridge and a large "bulk" capacitor, draw current from the AC line only in short, high-amplitude pulses.3 This creates a highly distorted current waveform that is out of phase with the line voltage, resulting in a very poor power factor and high harmonic content.

**Power Factor Correction (PFC)** is the technique used to counteract this effect. Modern power supplies employ **active PFC**, which is a switching power converter (a "pre-regulator") placed at the front end of the system. The function of this circuit is to "intentionally shape the input current to be in phase with the instantaneous line voltage".4

### **Regulatory Context (The "Why" of PFC)**

Active PFC is not merely an optional feature for efficiency; it is a mandatory requirement for most electronic equipment, enforced by international standards such-as IEC 61000-3-2.7 These regulations set strict limits on the harmonic currents that equipment can inject back into the power grid.

The primary metric for quantifying this distortion is **Total Harmonic Distortion (THD)**, which is defined as "the ratio of the sum of the powers of all harmonic components to the power of the fundamental frequency".9 The IEEE 519-2022 standard provides a comprehensive framework for harmonic control in power systems, also utilizing the related metric of Total Demand Distortion (TDD).9 Active PFC circuits are the primary means of complying with these harmonic limits.4

### **A Taxonomy of Power Losses**

The efficiency of any power converter is determined by its total power losses, which are the sum of all losses in the system.14 These losses are dominated by two primary mechanisms: conduction loss and switching loss.

* **Conduction Loss:** This is the power dissipated as heat when current flows through the non-zero resistance of components.15  
  * In a MOSFET, this loss is defined by its drain-to-source on-resistance ($R\_{DS(on)}$) and the Root Mean Square (RMS) current flowing through it: $P\_{cond} \= I\_{RMS}^2 \\times R\_{DS(on)}$.15  
  * In a diode, this loss is defined by its forward voltage drop ($V\_f$) and the average (AVG) current: $P\_{cond} \\approx I\_{AVG} \\times V\_f$.16  
  * As this report will detail, bridgeless topologies are fundamentally designed to minimize this specific loss mechanism.18  
* **Switching Loss:** This is the power dissipated during the finite time of switching transitions (turn-on and turn-off).15 During these brief moments, the switching device (e.g., a MOSFET) simultaneously experiences both high voltage across it and high current through it, leading to a significant, instantaneous power loss ($P \= V \\times I$).18 This loss is an energy loss per switching cycle, and thus the total switching loss is directly proportional to the switching frequency ($f\_{sw}$).23

A central challenge in power electronics design is that these two losses are often in a trade-off. For example, a larger MOSFET may have a lower $R\_{DS(on)}$ (reducing conduction loss) but higher parasitic capacitances (increasing switching loss). The viability of any PFC topology, including bridgeless, depends on its ability to manage the *total* sum of these losses 7, as well as the management of critical switching phenomena like reverse-recovery.29

## **II. The Conventional Boost PFC: Operational Principles and Inherent Efficiency Limitations**

To understand the innovation of bridgeless PFC, one must first analyze the "baseline" topology it was designed to replace: the conventional single-phase boost PFC.

### **Circuit Operation**

The conventional active PFC stage is composed of two distinct functional blocks:

1. A **full-wave diode bridge rectifier (DBR)** at the AC input, typically composed of four diodes.16  
2. A cascaded **DC-DC boost converter**.4

The DBR's function is to convert the sinusoidal AC input voltage into a full-wave rectified, pulsating DC voltage.7 Immediately following the DBR, a very small capacitor (often 1 $\\mu$F or less) is used. Unlike the large "bulk" capacitor in a non-PFC supply, this small capacitor is only intended to provide a low-impedance path at the high switching frequency of the converter; it is intentionally small so as not to store significant energy at the line frequency (100/120 Hz), which would destroy the power factor.7 This rectified voltage then feeds the boost converter, which switches at a high frequency (e.g., 50-150 kHz) to draw a sinusoidal current from the line.4

### **Identifying the Primary Loss Source**

The simplicity of the DBR is also its greatest weakness. The bridge is a major source of inefficiency in the entire power supply chain.8 This inefficiency stems directly from the "high conduction loss in the input rectifier-bridge".35

### **Conduction Path Analysis (The Core Problem)**

A detailed analysis of the current path reveals a fundamental limitation of the conventional topology. At any point in the AC cycle (positive or negative) and during any part of the switching cycle (switch ON or switch OFF), the main line current must flow through *three* semiconductor devices in series.

* **During the Switch ON state:** Current flows from the AC line, through **one** bridge diode, through the boost inductor, through the active boost switch (MOSFET), and back through a **second** bridge diode to the AC neutral. The path includes **two bridge diodes and one MOSFET**.  
* **During the Switch OFF state:** Current flows from the AC line, through **one** bridge diode, through the boost inductor, through the fast-recovery **boost diode** to the DC-link capacitor, and back through a **second** bridge diode to the AC neutral. The path includes **two bridge diodes and one boost diode**.

Authoritative analyses confirm this "three-device path," summarizing the components in the conduction path as "2 slow diode, 1 MOSFET" (during the ON state) and "2 slow diode, 1 fast diode" (during the OFF state).35 Each conducting semiconductor, particularly the diodes with their significant forward voltage drop ($V\_f$), contributes to the conduction loss.

This constant three-junction-drop is the primary thermal and efficiency bottleneck. For example, in a 1200 W converter, the average input current at 85 V can be 12.71 A. The power loss from the bridge alone, assuming a $V\_f$ of 1.0 V per diode, is $P\_{bridge} \= 2 \\times I\_{average} \\times V\_{f,bridge} \= 2 \\times 12.71 A \\times 1 V \= 25.4 W$.16 This 25.4 W of power is not just a 2.1% efficiency loss ($25.4/1200$); it is 25.4 W of waste heat concentrated on a single component, necessitating a large, dedicated heat sink.16 In an industry driven by "miniaturization" and "high power density" 34, this thermally-dense, inefficient component is a primary target for elimination.

## **III. Quantifying the Diode Bridge Rectifier Power Loss (The "2-3%" Claim)**

The user query specifically requests quantification of the efficiency improvement, which begins with quantifying the loss of the component being eliminated.

### **Authoritative Citing of the "2-3%" Figure**

Industry analysis from leading semiconductor manufacturers converges on a consistent figure for the DBR's impact.

* An application note from Texas Instruments states: "The bridge rectifier can easily consume 2% to 3% of the output power at low line voltages and at full load".34  
* An ON Semiconductor handbook concurs: "...the diode bridge at the front-end of any PFC typically contributes 2% power losses at full load, low line".7

### **Analytical Justification (Why "Low Line" and "Full Load"?)**

This qualification—"low line" and "full load"—is critical and reveals the nuance of the claim.

1. Bridge conduction loss is primarily a function of the average current and the diode forward voltage: $P\_{bridge} \\approx 2 \\times V\_f \\times I\_{avg}$.16  
2. The diode forward voltage ($V\_f$) is relatively constant, around 1.0 V for standard bridge rectifiers.16  
3. To deliver a constant output power ($P\_o$), the converter must draw more current ($I\_{ac}$) as the input voltage ($V\_{ac}$) decreases. The average input current is given by $I\_{avg} \= \\frac{2 \\sqrt{2}}{\\pi} \\times \\frac{P\_o}{V\_{ac,min}}$.16  
4. Therefore, the *absolute power loss* in the bridge (in Watts) is *maximized* at "low line" (e.g., 85-90 Vac) because the input current is at its highest.  
5. Consequently, the *percentage loss* ($P\_{bridge} / P\_o$) is also maximized at this worst-case operating point. This is the origin of the "2% to 3%" claim.

### **Reconciling the "1%" Figure**

While the DBR *component loss* is 2-3%, numerous peer-reviewed papers and application notes cite a more conservative *net system gain* of "around 1%".8

This is not a contradiction. The 2-3% figure represents the *gross power loss* of the *component being eliminated* (the DBR) at its worst-case operating point.7 The 1% figure represents the *net system-level efficiency gain* achieved by the complete bridgeless topology.35

Bridgeless topologies, while eliminating the DBR, introduce their own conduction path (e.g., through a MOSFET's body diode or a synchronous switch) which has its own losses.35 The net gain is the *difference* between the two. For instance, eliminating a 2% DBR loss and replacing it with a 1% loss from the new current path yields a 1% net improvement. The 2005 APEC paper by Lu, Brown, and Soldano provided one of the first *experimental validations* of this, measuring an "around 1% \[efficiency improvement\] for the whole power range" over the conventional topology.35

## **IV. The Bridgeless PFC Paradigm: Eliminating the Rectifier Bridge**

The "bridgeless" paradigm is a direct architectural response to the DBR's inefficiency.

### **Topological Definition**

A bridgeless PFC is a topology that "does not include a rectifier diode bridge at its input".33 The fundamental design principle is to integrate the rectification function into the switching stage, thereby reducing the "number of semiconductor components in the line-current path".8

### **Fundamental Conduction Path Improvement**

By removing the DBR, bridgeless topologies restructure the circuit to reduce the "three-device path" of the conventional boost to a "two-device path".35 This change "can improve efficiency by eliminating the voltage drop of one diode in the line-current path".34

The comparison in Table 1, derived from analysis in Lu et al. (2005) 35, illustrates this fundamental advantage. In the conventional topology, there are always *three* devices in the path. In the bridgeless topology, there are only *two*. This removal of one full semiconductor drop (typically a diode $V\_f$) from the main power-flow path is the primary source of the conduction loss savings and the resulting 1-2% efficiency gain.

**Table 1\. Conduction Path Device Count Comparison (Conventional vs. Classic Bridgeless)**

| Topology | Switching State | Conducting Devices in Series | Device Count |
| :---- | :---- | :---- | :---- |
| **Conventional Boost PFC** | Switch (MOSFET) ON | 2x Bridge Diodes, 1x MOSFET | **3 Devices** |
|  | Switch (MOSFET) OFF | 2x Bridge Diodes, 1x Boost Diode | **3 Devices** |
| **Classic Bridgeless PFC** | Switch (MOSFET) ON | 1x MOSFET, 1x Return Diode (Body Diode) | **2 Devices** |
|  | Switch (MOSFET) OFF | 1x Boost Diode, 1x Return Diode (Body Diode) | **2 Devices** |
| (Based on analysis in 34) |  |  |  |

## **V. Comparative Analysis of Dominant Bridgeless PFC Topologies**

The "bridgeless" concept is not a single circuit but a *family* of topologies. The evolution from the conventional boost to the modern totem-pole PFC reveals a clear progression of designs, each solving the critical flaws of the previous generation.

### **V.A. The Classic "Dual Boost" Bridgeless Rectifier**

This topology is the first-generation bridgeless design. It consists of two identical boost converters: one (Q1, L1, D1) operates during the positive AC half-cycle, and the other (Q2, L2, D2) operates during the negative half-cycle.3 The boost inductors are moved from the DC side to the AC side.34

* **Advantages:** It is conceptually simple, achieves the "two-device" conduction path, and can often be driven by a single PFC controller, as both switches can share a gate signal in some implementations.7  
* **Critical Disadvantages:** This topology solves the conduction loss problem but creates two new, often unacceptable, issues:  
  1. **Common-Mode (CM) EMI:** This design suffers from severe CM EMI noise.35 The "output-voltage ground is always floating relative to the AC line input".34 This lack of a stable ground reference creates a large, high-frequency voltage that couples through parasitic capacitances, generating significant noise that is difficult and expensive to filter.35  
  2. **Current Sensing:** Control is "complicated".34 A simple shunt resistor in the DC return path is no longer possible because the return path changes every half-cycle and is not common. Sensing on the AC side is also complicated by the body diode of the inactive MOSFET, which can divert return current and corrupt the measurement.35

### **V.B. The Semi-Bridgeless (SBBC) Topologies**

This family of topologies 32, also known as the "pseudo totem-pole" or "dual boost" 8, represents the second-generation bridgeless design. It is an evolution of the classic topology, specifically engineered to solve the critical CM EMI problem.

* **Operation:** The SBBC is also built from two boost converters but adds components, such as "clamped diodes" (D3, D4 in 32), to the circuit.32  
* **Advantages:** The primary advantage of the SBBC is its "low Common-Mode (CM) and Differential-Mode (DM) noises in comparison with the conventional PFC BBC topology".32 The clamped diodes provide a firm connection between the output ground and the AC supply, "prevent\[ing\] the coupling between ground and the power supply" and solving the "floating ground" issue of the classic topology.32  
* **Disadvantages:** It has a higher component count than the classic bridgeless design and is more complex.32

### **V.C. The Totem-Pole Bridgeless PFC (TBPFC)**

The totem-pole is the most advanced and highest-performance topology, representing the current state-of-the-art in single-phase PFC design. It uses four active switches in a single "totem-pole" leg structure.39

#### **Operation: The "Fast Leg" and "Slow Leg"**

The key to the TBPFC's operation is the separation of switching functions:

1. **Fast Leg:** Two switches (e.g., S1, S2) operate at a *high switching frequency* (e.g., 65-150 kHz). These devices perform the actual boost conversion.39  
2. **Slow Leg:** Two switches (e.g., S3, S4) operate at the *line frequency* (50/60 Hz). They function as the line rectifier, steering the AC flow. Because they switch so infrequently, their switching losses are negligible.30

This operation is highly efficient. During the **positive AC half-cycle**, S4 (slow leg) is turned ON continuously, providing a solid ground return path. S3 (slow leg) is OFF. The fast leg (S1, S2) now operates as a synchronous boost converter: S2 is the main boost switch (which pulses at high frequency), and S1 acts as a "synchronous rectifier," turning on to carry the freewheeling current instead of a diode.39 During the **negative AC half-cycle**, the roles are reversed.39

#### **Advantages**

* **Highest Efficiency:** By replacing all diodes in the main conduction path with low-resistance MOSFETs ($R\_{DS(on)}$), this topology virtually eliminates diode $V\_f$ losses. It is widely considered the "superior topology for titanium efficiency".48  
* **Bidirectional Capability:** The structure is inherently symmetrical. This allows power to flow not only from the grid to the load (Grid-to-Vehicle, G2V) but also from the load back to the grid (Vehicle-to-Grid, V2G).47

#### **The Critical Challenge: Reverse Recovery ($Q\_{rr}$)**

The TBPFC, while theoretically superior, was "once considered impractical" when built with standard Silicon (Si) MOSFETs.29 The reason is a catastrophic "hard-switching" problem related to the MOSFET body diode.

In the fast leg's synchronous boost operation (e.g., S2 switching, S1 freewheeling), the current flows through the *body diode* of S1. When S2 turns back ON, it must force this body diode to turn off. A Si MOSFET has a "poor reverse recovery" body diode, which is slow and stores significant charge ($Q\_{rr}$).29 This results in a massive current spike as S2 effectively short-circuits the output to clear this charge. This reverse-recovery spike causes "very high switching loss," extreme EMI, and potential device failure.29

#### **The Solution: Wide Band-Gap (WBG) Devices**

The modern success of the TBPFC is *causally and entirely* dependent on the commercial availability of **Wide Band-Gap (WBG) devices**, namely Silicon Carbide (SiC) MOSFETs and Gallium Nitride (GaN) HEMTs.29

These WBG devices have "excellent reverse recovery performance".29 SiC MOSFETs have a very low $Q\_{rr}$, and GaN HEMTs, due to their device physics, have *zero* $Q\_{rr}$. These devices *solve* the reverse-recovery problem, eliminating the catastrophic switching loss and unlocking the topology's full efficiency potential.

As a practical case study, a Texas Instruments reference design (TIDUE54B) for a 6.6-kW TBPFC using GaN devices achieves **98.6% efficiency** at 240 V input and full load, with a peak efficiency of 98.86%.31

## **VI. In-Depth Review of Seminal Peer-Reviewed Literature**

The user query requested peer-reviewed papers on bridgeless topologies. The development of this field has been wel-documented in IEEE publications, with a few key papers shaping its trajectory.

### **VI.A. Foundational Performance Analysis: Huber, Jang, and Jovanovic (2008)**

* **Paper:** Huber, L., Jang, Y., and Jovanovic, M.M. (2008) "Performance Evaluation of Bridgeless PFC Boost Rectifiers." *IEEE Transactions on Power Electronics*, vol. 23, no. 3, pp. 1381–1390, May 2008..52  
* **Contribution:** This is one of the most-cited papers on the topic, providing a systematic review and detailed loss analysis of the (then-emerging) bridgeless topologies against the conventional boost.57  
* **Key Insight & Analysis:** The paper's most critical contribution was to add nuance. It demonstrated that the efficiency benefit of bridgeless PFC is *not* automatic. The authors' detailed loss analysis (presented in their Fig. 9\) concluded that the efficiency improvement is "predominantly limited by the on-resistance of \[the\] MOSFET".57 They showed that if high-$R\_{DS(on)}$ MOSFETs were used, the conventional boost PFC could actually be *more efficient* at high power levels.56 The bridgeless topology only showed a clear advantage across the entire power range when *low-$R\_{DS(on)}$* MOSFETs were employed. This paper shifted the discussion from a simple "bridgeless is better" to a more precise "bridgeless is better *under specific component conditions*."

### **VI.B. Early Practical Implementation: Lu, Brown, and Soldano (2005)**

* **Paper:** Lu, B., Brown, R., and Soldano, M. (2005) "Bridgeless PFC implementation using one cycle control technique." *IEEE Applied Power Electronics (APEC) Conf. Proc.*, pp. 812-817, Mar. 2005..35  
* **Contribution:** This paper is significant for providing one of the first detailed *practical* implementations with *experimental validation* of the classic bridgeless topology.  
* **Key Insight & Analysis:** Its primary contribution was the experimental proof that validated the theory. The authors built and tested a prototype that measured an "around 1% \[efficiency improvement\] for the whole power range" over a conventional PFC 35, confirming the conduction loss savings. However, its second contribution was just as important: it was one of the first papers to *formally identify* the key practical drawbacks that would define the next decade of research, namely the "issues such as voltage sensing, current sensing and EMI noise".35 This paper simultaneously proved the *benefit* (1% gain) and defined the *problems* (EMI, sensing) for the classic topology.

### **VI.C. Broader Landscape (Review and Interleaving Papers)**

The field is supported by numerous other review papers that provide a "critical review of single-phase non-isolated bridgeless power factor converter topologies".8 These papers are essential for mapping the full family of bridgeless converters, which are derived not only from the boost but also from buck, buck-boost, SEPIC, and Cuk topologies.8

It is also important to note the parallel development of *interleaved* topologies 31, first analyzed in detail by papers such as Jang & Jovanovic (2007).8 Interleaving—using multiple PFC stages in parallel—is a separate technique to reduce ripple and component stress. This technique is now *frequently combined* with bridgeless designs to create very-high-power, high-efficiency solutions, such as the "interleaved totem-pole PFC," which is common in high-wattage EV charging applications.31

## **VII. Synthesis and Expert Recommendations**

### **Summary of Findings**

The analysis of bridgeless PFC topologies reveals a clear and logical progression in power electronics design.

1. **The Driver:** The conventional boost PFC's DBR is a significant thermal and efficiency bottleneck, responsible for 2-3% of power loss at low-line, full-load conditions.7  
2. **The Mechanism:** Bridgeless topologies eliminate this DBR by reducing the main conduction path from three series semiconductors to two.34  
3. **The Result:** This architectural change yields a validated *net* system efficiency gain of "around 1%" 8 to over 2%, depending on the specific topology and components.  
4. **The Evolution:** A clear evolutionary path is evident:  
   * **Gen 1 (Conventional):** Inefficient due to DBR.  
   * **Gen 2 (Classic Bridgeless):** Proves the efficiency gain but introduces severe CM EMI flaws.34  
   * **Gen 3 (Semi-Bridgeless):** Fixes the CM EMI flaw but adds component count and complexity.32  
   * **Gen 4 (Totem-Pole):** Provides the highest possible efficiency and bidirectional capability, but was impractical until WBG (SiC/GaN) devices became available to solve its $Q\_{rr}$ (switching loss) problem.29

The performance characteristics of these topologies are summarized in Table 2\.

**Table 2\. Performance and Application Matrix of PFC Topologies**

| Topology | Typical Peak Efficiency | Conduction Path | CM EMI Noise | Control Complexity | Bidirectional Capable | Key Challenge |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| **Conventional \+ DBR** | 96-97% | 3 Devices 35 | Low | Low | No | Bridge Conduction Loss 34 |
| **Classic "Dual Boost"** | 97-98% | 2 Devices 35 | Very High 34 | Low | No | CM EMI & Sensing 34 |
| **Semi-Bridgeless (SBBC)** | 97.5-98.5% | 2 Devices 32 | Medium 32 | Medium | No | Component Count 32 |
| **Totem-Pole (TBPFC) w/ SiC/GaN** | **\>98.5%** 47 | 2 Devices (All-FET) 39 | High (Manageable) | High 30 | **Yes** 47 | Requires WBG (SiC/GaN) 29 |

### **Expert Recommendations**

Based on this comprehensive analysis, the following recommendations are provided for topology selection in modern power supply design:

1. **For Ultra-High-Efficiency (\>98%) and High-Power (\>1kW) Applications:** The **Totem-Pole (TBPFC) topology, implemented with SiC or GaN (WBG) devices, is the indisputably superior solution.** Its ability to achieve efficiencies \>98.5% 47, combined with high power density and inherent bidirectional capability 47, makes it the definitive standard for next-generation applications. This includes EV on-board chargers (G2V/V2G), high-end telecom rectifiers, and server power supplies targeting "Titanium" efficiency.29 Designers must, however, be prepared to manage the complex, high-frequency control 68 and WBG-specific layout challenges.  
2. **For Cost-Sensitive, Mid-Power Applications (sub-1kW):** The **Semi-Bridgeless (SBBC) topology offers the best compromise.** It successfully achieves the primary goal of eliminating the DBR's conduction loss 32 while, crucially, avoiding the "show-stopping" CM EMI problems of the classic bridgeless design.32 This makes it a robust and efficient choice where the absolute highest performance (or bidirectional flow) of a WBG-based TBPFC is not required.  
3. **On the "Classic" Bridgeless Topology:** This topology is **not recommended for new designs.** While conceptually simple, its severe CM EMI 34 and current-sensing 35 challenges represent a "false economy." The cost, volume, and complexity of the external CM filters required to make the design compliant will almost certainly negate any savings from eliminating the DBR, resulting in a design that is neither cheap nor power-dense.

#### **Works cited**

1. Power factor correction: A guide for the plant engineer \- Eaton, accessed October 29, 2025, [https://www.eaton.com/content/dam/eaton/products/low-voltage-power-distribution-controls-systems/power-factor-corrections/portfolio/eaton-pfc-guide-plant-engineer-SA02607001E.pdf](https://www.eaton.com/content/dam/eaton/products/low-voltage-power-distribution-controls-systems/power-factor-corrections/portfolio/eaton-pfc-guide-plant-engineer-SA02607001E.pdf)  
2. Power Factor Correction \- Electronics Tutorials, accessed October 29, 2025, [https://www.electronics-tutorials.ws/accircuits/power-factor-correction.html](https://www.electronics-tutorials.ws/accircuits/power-factor-correction.html)  
3. Power Factor Correction (PFC) Circuits \- Toshiba America Electronic Components, accessed October 29, 2025, [https://toshiba.semicon-storage.com/info/docget.jsp?did=68570](https://toshiba.semicon-storage.com/info/docget.jsp?did=68570)  
4. Power Factor Correction (PFC) Circuit Basics \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/ml/zhcp224/zhcp224.pdf](https://www.ti.com/lit/ml/zhcp224/zhcp224.pdf)  
5. Power Electronics Course: Part 18 \- Power Factor Correction Circuits, accessed October 29, 2025, [https://www.powerelectronicsnews.com/power-electronics-course-part-18-power-factor-correction-circuits/](https://www.powerelectronicsnews.com/power-electronics-course-part-18-power-factor-correction-circuits/)  
6. Practical Power Factor Correction | Power Factor | Electronics Textbook \- All About Circuits, accessed October 29, 2025, [https://www.allaboutcircuits.com/textbook/alternating-current/chpt-11/practical-power-factor-correction/](https://www.allaboutcircuits.com/textbook/alternating-current/chpt-11/practical-power-factor-correction/)  
7. Power Factor Correction (PFC) Handbook \- onsemi, accessed October 29, 2025, [https://www.onsemi.com/pub/collateral/hbd853-d.pdf](https://www.onsemi.com/pub/collateral/hbd853-d.pdf)  
8. A Comprehensive Review of Non-isolated Bridgeless Power Factor ..., accessed October 29, 2025, [https://deepblue.lib.umich.edu/bitstream/handle/2027.42/167457/cds212046\_am.pdf?sequence=1](https://deepblue.lib.umich.edu/bitstream/handle/2027.42/167457/cds212046_am.pdf?sequence=1)  
9. Total harmonic distortion \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Total\_harmonic\_distortion](https://en.wikipedia.org/wiki/Total_harmonic_distortion)  
10. What is Total Harmonic Distortion (THD)? \- PowerSight, accessed October 29, 2025, [https://powersight.com/what-is-total-harmonic-distortion-thd/](https://powersight.com/what-is-total-harmonic-distortion-thd/)  
11. Total Harmonic Distortion (THD) and Total Demand Distortion (TDD) | Circuitenergy, accessed October 29, 2025, [https://circuitenergy.ca/total-harmonic-distortion-thd-and-total-demand-distortion-tdd/](https://circuitenergy.ca/total-harmonic-distortion-thd-and-total-demand-distortion-tdd/)  
12. Understanding the IEEE 519 – 2014 standard for Harmonics \- Elspec LTD, accessed October 29, 2025, [https://www.elspec-ltd.com/ieee-519-2014-standard-for-harmonics/](https://www.elspec-ltd.com/ieee-519-2014-standard-for-harmonics/)  
13. Application of IEEE Std 519-1992 harmonic limits \- Eaton, accessed October 29, 2025, [https://www.eaton.com/content/dam/eaton/products/backup-power-ups-surge-it-power-distribution/power-conditioners/harmonic-correction-unit/IEEE-std-519-1992-harmonic-limits.pdf](https://www.eaton.com/content/dam/eaton/products/backup-power-ups-surge-it-power-distribution/power-conditioners/harmonic-correction-unit/IEEE-std-519-1992-harmonic-limits.pdf)  
14. NYSR00011-00-BD01 \- IEEE Standard Terminology for Power and Distribution Transformers, IEEE Std C57.12.80TM-2 \- Nuclear Regulatory Commission, accessed October 29, 2025, [https://www.nrc.gov/docs/ml1233/ml12334a510.pdf](https://www.nrc.gov/docs/ml1233/ml12334a510.pdf)  
15. Introduction to MOSFET Switching Losses \- Technical Articles \- All About Circuits, accessed October 29, 2025, [https://www.allaboutcircuits.com/technical-articles/introduction-to-mosfet-switching-losses/](https://www.allaboutcircuits.com/technical-articles/introduction-to-mosfet-switching-losses/)  
16. Design guide PFC CCM boost converter \- Infineon Technologies, accessed October 29, 2025, [https://www.infineon.com/assets/row/public/documents/24/42/infineon-applicationnote-pfcccmboostconverterdesignguide-applicationnotes-en.pdf](https://www.infineon.com/assets/row/public/documents/24/42/infineon-applicationnote-pfcccmboostconverterdesignguide-applicationnotes-en.pdf)  
17. How to Calculate Power Losses in Gen 5 Diodes | Vishay, accessed October 29, 2025, [https://www.vishay.com/docs/98280/howtocalculatepowerlossesingen5diodes.pdf](https://www.vishay.com/docs/98280/howtocalculatepowerlossesingen5diodes.pdf)  
18. MOSFET power losses and how they affect power-supply efficiency \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slyt664](https://www.ti.com/lit/pdf/slyt664)  
19. POWER ELECTRONICS HANDBOOK, accessed October 29, 2025, [https://eopcw.com/assets/stores/Industrial%20electronics%20and%20applications/lecturenote\_881570161RASHID\_Power\_Electronics\_Handbook.pdf](https://eopcw.com/assets/stores/Industrial%20electronics%20and%20applications/lecturenote_881570161RASHID_Power_Electronics_Handbook.pdf)  
20. Power Electronics Devices, Circuits & Applications 4/E \- ElCoM, accessed October 29, 2025, [https://elcom-team.com/Subjects/power%20electronics/%D8%A7%D9%84%D9%83%D8%AA%D8%A8%20%D9%88%20%D8%A7%D9%84%D8%AD%D9%84%D9%88%D9%84/power-electro-reference-book-(4th-ed).pdf](https://elcom-team.com/Subjects/power%20electronics/%D8%A7%D9%84%D9%83%D8%AA%D8%A8%20%D9%88%20%D8%A7%D9%84%D8%AD%D9%84%D9%88%D9%84/power-electro-reference-book-\(4th-ed\).pdf)  
21. First Course on Power Electronics, accessed October 29, 2025, [http://103.203.175.90:81/fdScript/RootOfEBooks/E%20Book%20collection%20-%202020%20-%20A/ECE/PowerElectronicsAFirstCoursebyMohan-1.pdf](http://103.203.175.90:81/fdScript/RootOfEBooks/E%20Book%20collection%20-%202020%20-%20A/ECE/PowerElectronicsAFirstCoursebyMohan-1.pdf)  
22. Power Electronics, accessed October 29, 2025, [http://tole.intelektual.org/wp-content/uploads/2020/09/pe-umanand.pdf](http://tole.intelektual.org/wp-content/uploads/2020/09/pe-umanand.pdf)  
23. Chapter 4\. Switch Realization, accessed October 29, 2025, [https://ieee.li/pdf/introduction\_to\_power\_electronics/chapter\_04.pdf](https://ieee.li/pdf/introduction_to_power_electronics/chapter_04.pdf)  
24. PRD-03043: Measuring Switching and Conduction Losses in LTspice® Simulation Software | Wolfspeed, accessed October 29, 2025, [https://assets.wolfspeed.com/uploads/2024/01/Wolfspeed\_PRD-03043\_Measuring\_Switching\_and\_Conduction\_Losses\_in\_LTspice\_Simulation\_Software.pdf](https://assets.wolfspeed.com/uploads/2024/01/Wolfspeed_PRD-03043_Measuring_Switching_and_Conduction_Losses_in_LTspice_Simulation_Software.pdf)  
25. Switching Loss Model for SiC MOSFETs Based on Datasheet Parameters Enabling Virtual Junction Temperature Estimation \- NIH, accessed October 29, 2025, [https://pmc.ncbi.nlm.nih.gov/articles/PMC12197205/](https://pmc.ncbi.nlm.nih.gov/articles/PMC12197205/)  
26. Hard-Switching Losses in Power FETs: the Role of Output Capacitance \- Infoscience, accessed October 29, 2025, [https://infoscience.epfl.ch/bitstreams/d058a419-0338-4a11-997e-ea1e68e1165b/download](https://infoscience.epfl.ch/bitstreams/d058a419-0338-4a11-997e-ea1e68e1165b/download)  
27. Comparative Evaluation of the Loss and Thermal Performance of Advanced Three Level Inverter Topologies \- DTU Orbit, accessed October 29, 2025, [https://orbit.dtu.dk/files/127818903/IAS\_2016\_SECSC\_0351.R2\_reference\_copy.pdf](https://orbit.dtu.dk/files/127818903/IAS_2016_SECSC_0351.R2_reference_copy.pdf)  
28. Overview of Power Electronic Switches: A Summary of the Past, State-of-the-Art and Illumination of the Future \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2072-666X/11/12/1116](https://www.mdpi.com/2072-666X/11/12/1116)  
29. Revolution of Electric Vehicle Charging Technologies Accelerated by Wide Bandgap Devices \- Chris Mi, accessed October 29, 2025, [https://chrismi.sdsu.edu/publications/195.pdf](https://chrismi.sdsu.edu/publications/195.pdf)  
30. Efficiency and PF Improving Techniques with a Digital Control for Totem-Pole Bridgeless CRM Boost PFC Converters \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/17/2/369](https://www.mdpi.com/1996-1073/17/2/369)  
31. Review of Different Power Factor Correction (PFC) Topologies' Gate Driver Needs \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/sluaau2](https://www.ti.com/lit/pdf/sluaau2)  
32. PFC Single-Phase AC/DC Boost Converters: Bridge, Semi ... \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2076-3417/11/16/7651](https://www.mdpi.com/2076-3417/11/16/7651)  
33. Bridgeless PFC Topology Simplification and Design for Performance Benchmarking \- Aalborg Universitets forskningsportal, accessed October 29, 2025, [https://vbn.aau.dk/files/379404228/Bridgeless\_PFC\_Topology\_Simplification\_and\_Design\_for\_Performance\_Benchmarking\_PE\_2020\_2nd\_author.pdf](https://vbn.aau.dk/files/379404228/Bridgeless_PFC_Topology_Simplification_and_Design_for_Performance_Benchmarking_PE_2020_2nd_author.pdf)  
34. A comparative analysis of topologies for a ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slyt750](https://www.ti.com/lit/pdf/slyt750)  
35. Bridgeless PFC Implementation Using One Cycle Control Technique, accessed October 29, 2025, [https://www.infineon.com/dgdl/blbapec2005.pdf?fileId=5546d462533600a40153574033603ed3](https://www.infineon.com/dgdl/blbapec2005.pdf?fileId=5546d462533600a40153574033603ed3)  
36. Efficiency Analysis of Bridgeless PFC Boost Converter with the Conventional Method, accessed October 29, 2025, [https://www.semanticscholar.org/paper/Efficiency-Analysis-of-Bridgeless-PFC-Boost-with-Gopinath-Yogeetha/fdcfb7af150d803ec0f150a0f78fc7574d393a1f](https://www.semanticscholar.org/paper/Efficiency-Analysis-of-Bridgeless-PFC-Boost-with-Gopinath-Yogeetha/fdcfb7af150d803ec0f150a0f78fc7574d393a1f)  
37. Conduction Losses and Common Mode EMI Analysis on Bridgeless Power Factor Correction \- DTU Orbit, accessed October 29, 2025, [https://orbit.dtu.dk/files/4593912/Li.pdf](https://orbit.dtu.dk/files/4593912/Li.pdf)  
38. Aalborg Universitet Single-phase Bridgeless PFC Topology Derivation and Performance Benchmarking Chen, Zhengge, accessed October 29, 2025, [https://vbn.aau.dk/files/404450382/bridgeless\_boost\_PFC.pdf](https://vbn.aau.dk/files/404450382/bridgeless_boost_PFC.pdf)  
39. CoolSiC™ totem-pole PFC design guide and power loss modeling, accessed October 29, 2025, [https://www.infineon.com/dgdl/Infineon-Application\_note\_CoolSiC\_Totem\_Pole\_PFC\_Design\_and\_Power\_Loss\_Modeling-ApplicationNotes-v01\_00-EN.pdf?fileId=8ac78c8c85ecb34701865a064ec24076](https://www.infineon.com/dgdl/Infineon-Application_note_CoolSiC_Totem_Pole_PFC_Design_and_Power_Loss_Modeling-ApplicationNotes-v01_00-EN.pdf?fileId=8ac78c8c85ecb34701865a064ec24076)  
40. Performance Evaluation of Bridgeless PFC Boost Rectifiers \- SciSpace, accessed October 29, 2025, [https://scispace.com/pdf/performance-evaluation-of-bridgeless-pfc-boost-rectifiers-5e5u6azkja.pdf](https://scispace.com/pdf/performance-evaluation-of-bridgeless-pfc-boost-rectifiers-5e5u6azkja.pdf)  
41. UCC28070 Implement Bridgeless PFC Pre-Regulator Design \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/slua517](https://www.ti.com/lit/pdf/slua517)  
42. Common Mode EMI Noise Suppression for Bridgeless PFC Converters \- GitHub Pages, accessed October 29, 2025, [https://peeprlgator.github.io/Shuo.Wang/publicationattachments/Common%20mode%20EMI%20noise%20suppression%20for%20bridgeless%20PFC%20converters.pdf](https://peeprlgator.github.io/Shuo.Wang/publicationattachments/Common%20mode%20EMI%20noise%20suppression%20for%20bridgeless%20PFC%20converters.pdf)  
43. PFC Single-Phase AC/DC Boost Converters: Bridge, Semi-Bridgeless, and Bridgeless Topologies \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/354039935\_PFC\_Single-Phase\_ACDC\_Boost\_Converters\_Bridge\_Semi-Bridgeless\_and\_Bridgeless\_Topologies](https://www.researchgate.net/publication/354039935_PFC_Single-Phase_ACDC_Boost_Converters_Bridge_Semi-Bridgeless_and_Bridgeless_Topologies)  
44. Optimal Sliding-Mode Control of Semi-Bridgeless Boost Converters Considering Power Factor Corrections \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/16/17/6282](https://www.mdpi.com/1996-1073/16/17/6282)  
45. accessed October 29, 2025, [https://www.ti.com/lit/pdf/slyt750\#:\~:text=A%20totem%2Dpole%20bridgeless%2Dboost%20PFC%20topology\&text=During%20the%20positive%20half%2D%20line%20cycle%2C%20the%20AC%20input%20connects,the%20output%20ground%20through%20D2.](https://www.ti.com/lit/pdf/slyt750#:~:text=A%20totem%2Dpole%20bridgeless%2Dboost%20PFC%20topology&text=During%20the%20positive%20half%2D%20line%20cycle%2C%20the%20AC%20input%20connects,the%20output%20ground%20through%20D2.)  
46. Digitalized Control Algorithm of Bridgeless Totem-Pole PFC with a Simple Control Structure Based on the Phase Angle, accessed October 29, 2025, [https://scholarworks.bwise.kr/hanyang/bitstream/2021.sw.hanyang/196233/1/Digitalized%20Control%20Algorithm%20of%20Bridgeless%20Totem-Pole%20PFC%20with%20a%20Simple%20Control%20Structure%20Based%20on%20the%20Phase%20Angle.pdf](https://scholarworks.bwise.kr/hanyang/bitstream/2021.sw.hanyang/196233/1/Digitalized%20Control%20Algorithm%20of%20Bridgeless%20Totem-Pole%20PFC%20with%20a%20Simple%20Control%20Structure%20Based%20on%20the%20Phase%20Angle.pdf)  
47. 98.6% Efficiency, 6.6-kW Totem-Pole PFC Ref ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/ug/tidue54b/tidue54b.pdf](https://www.ti.com/lit/ug/tidue54b/tidue54b.pdf)  
48. Design and Verification of a Bridgeless Totem-Pole Power Factor Corrector \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2079-9292/14/2/226](https://www.mdpi.com/2079-9292/14/2/226)  
49. Interleaved Boost vs. Totem-Pole PFC Topologies | Article \- Monolithic Power Systems, accessed October 29, 2025, [https://www.monolithicpower.com/en/learning/resources/comparative-study-of-pfc-topologies-interleaved-boost-vs-totem-pole-pfc-topologies](https://www.monolithicpower.com/en/learning/resources/comparative-study-of-pfc-topologies-interleaved-boost-vs-totem-pole-pfc-topologies)  
50. High-Voltage PFC: Understanding Bridgeless Power Factor Correction featuring the MPF32010 Controller \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=nwm1puMD2wY](https://www.youtube.com/watch?v=nwm1puMD2wY)  
51. 4-kW, Single-Phase Totem Pole PFC Reference Design With C2000 and GaN \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/pdf/tiduez3](https://www.ti.com/lit/pdf/tiduez3)  
52. Characterization and Application of Wide-Band- Gap Devices for High Frequency Power Conversion \- VTechWorks, accessed October 29, 2025, [https://vtechworks.lib.vt.edu/bitstream/handle/10919/77959/Liu\_Z\_D\_2017.pdf?sequence=1\&isAllowed=y](https://vtechworks.lib.vt.edu/bitstream/handle/10919/77959/Liu_Z_D_2017.pdf?sequence=1&isAllowed=y)  
53. MIT Open Access Articles A high frequency power factor correction converter with soft switching, accessed October 29, 2025, [https://dspace.mit.edu/bitstream/handle/1721.1/123501/Hanson-MIT\_APEC18\_Submit.pdf?sequence=2](https://dspace.mit.edu/bitstream/handle/1721.1/123501/Hanson-MIT_APEC18_Submit.pdf?sequence=2)  
54. Figure 10 from Performance Evaluation of Bridgeless PFC Boost Rectifiers, accessed October 29, 2025, [https://www.semanticscholar.org/paper/Performance-Evaluation-of-Bridgeless-PFC-Boost-Huber-Jang/b292b4eac33dc537068a7e700b9e61d0505c4c2e/figure/1](https://www.semanticscholar.org/paper/Performance-Evaluation-of-Bridgeless-PFC-Boost-Huber-Jang/b292b4eac33dc537068a7e700b9e61d0505c4c2e/figure/1)  
55. Huber, L., Jang, Y. and Jovanovic, M.M. (2008) Performance Evaluation of Bridgeless PFC Boost Rectifiers. IEEE Transactions on Power Electronics, 23, 1381-1390. \- References \- Scirp.org., accessed October 29, 2025, [https://www.scirp.org/reference/referencespapers?referenceid=1833588](https://www.scirp.org/reference/referencespapers?referenceid=1833588)  
56. Performance Evaluation of Bridgeless PFC Boost Rec | PDF | Rectifier \- Scribd, accessed October 29, 2025, [https://www.scribd.com/document/803736972/Performance-Evaluation-of-Bridgeless-PFC-Boost-Rec](https://www.scribd.com/document/803736972/Performance-Evaluation-of-Bridgeless-PFC-Boost-Rec)  
57. (PDF) Performance Evaluation of Bridgeless PFC Boost Rectifiers, accessed October 29, 2025, [https://www.researchgate.net/publication/3281480\_Performance\_Evaluation\_of\_Bridgeless\_PFC\_Boost\_Rectifiers](https://www.researchgate.net/publication/3281480_Performance_Evaluation_of_Bridgeless_PFC_Boost_Rectifiers)  
58. Loss breakdown for conventional boost PFC and DBPFC. \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/figure/Loss-breakdown-for-conventional-boost-PFC-and-DBPFC\_fig3\_251937028](https://www.researchgate.net/figure/Loss-breakdown-for-conventional-boost-PFC-and-DBPFC_fig3_251937028)  
59. Bridgeless CUK power factor correction rectifier with reduced conduction losses \- IET Digital Library, accessed October 29, 2025, [https://digital-library.theiet.org/doi/abs/10.1049/iet-pel.2011.0302](https://digital-library.theiet.org/doi/abs/10.1049/iet-pel.2011.0302)  
60. Efficiency Enhancement of Bridgeless Buck-Boost PFC Converter with Unity PF and DC Split to Reduce Voltage Stresses \- Semantic Scholar, accessed October 29, 2025, [https://www.semanticscholar.org/paper/Efficiency-Enhancement-of-Bridgeless-Buck-Boost-PFC-Chen-Liu/d7e21ef6545057aef70c06b51541bcdc8d9dc600](https://www.semanticscholar.org/paper/Efficiency-Enhancement-of-Bridgeless-Buck-Boost-PFC-Chen-Liu/d7e21ef6545057aef70c06b51541bcdc8d9dc600)  
61. (PDF) Single-Phase Bridgeless PFC Topology Derivation and Performance Benchmarking, accessed October 29, 2025, [https://www.researchgate.net/publication/339019131\_Single-Phase\_Bridgeless\_PFC\_Topology\_Derivation\_and\_Performance\_Benchmarking](https://www.researchgate.net/publication/339019131_Single-Phase_Bridgeless_PFC_Topology_Derivation_and_Performance_Benchmarking)  
62. Interleaved Boost Converter With Intrinsic Voltage-Doubler Characteristic for Universal-Line PFC Front End | Request PDF \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/3281198\_Interleaved\_Boost\_Converter\_With\_Intrinsic\_Voltage-Doubler\_Characteristic\_for\_Universal-Line\_PFC\_Front\_End](https://www.researchgate.net/publication/3281198_Interleaved_Boost_Converter_With_Intrinsic_Voltage-Doubler_Characteristic_for_Universal-Line_PFC_Front_End)  
63. Interleaved Boost Converter With Intrinsic Voltage-Doubler Characteristic for Universal-Line PFC Front End \- Semantic Scholar, accessed October 29, 2025, [https://www.semanticscholar.org/paper/Interleaved-Boost-Converter-With-Intrinsic-for-PFC-Jang-Jovanovic/0247b66a62292739585422b7e3b782e9537afbb5](https://www.semanticscholar.org/paper/Interleaved-Boost-Converter-With-Intrinsic-for-PFC-Jang-Jovanovic/0247b66a62292739585422b7e3b782e9537afbb5)  
64. ‪Yungtaek Jang‬ \- ‪Google Scholar‬, accessed October 29, 2025, [https://scholar.google.com/citations?user=segm7AkAAAAJ\&hl=en](https://scholar.google.com/citations?user=segm7AkAAAAJ&hl=en)  
65. A High Voltage Ratio and Low Ripple Interleaved DC-DC Converter for Fuel Cell Applications \- PMC \- NIH, accessed October 29, 2025, [https://pmc.ncbi.nlm.nih.gov/articles/PMC3540761/](https://pmc.ncbi.nlm.nih.gov/articles/PMC3540761/)  
66. Design of novel DC-DC interleaved boost converter for BLDC application \- PMC \- NIH, accessed October 29, 2025, [https://pmc.ncbi.nlm.nih.gov/articles/PMC11693905/](https://pmc.ncbi.nlm.nih.gov/articles/PMC11693905/)  
67. High-Efficiency Interleaved Totem-Pole PFC Converter With Voltage Follower Characteristics | Request PDF \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/366477603\_High\_Efficiency\_Interleaved\_Totem-Pole\_PFC\_Converter\_with\_Voltage\_Follower\_Characteristics](https://www.researchgate.net/publication/366477603_High_Efficiency_Interleaved_Totem-Pole_PFC_Converter_with_Voltage_Follower_Characteristics)  
68. Effortless Totem-Pole Converter Control Using a Power Factor Correction Peak Current-Mode Controller \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1424-8220/24/15/4910](https://www.mdpi.com/1424-8220/24/15/4910)