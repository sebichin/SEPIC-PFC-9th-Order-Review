

# **Expert Analysis of Harmonic Control Standards: IEC 61000-3-2, IEEE 519, and Power Factor Correction Engineering**

## **Foundational Concepts in Power Quality and Harmonic Distortion**

### **The Problem: Non-Linear Loads and Harmonic Current Generation**

The ideal alternating current (AC) power system delivers a pure, single-frequency sinusoidal voltage, typically at 50 Hz or 60 Hz.1 However, the proliferation of modern electronic devices—such as personal computers, LED lighting, variable-speed motor drives, and the switch-mode power supplies (SMPSs) that power nearly all consumer electronics—has fundamentally altered the load characteristics of the grid.1

These devices are classified as **non-linear loads**. Unlike traditional linear loads (e.g., resistive heaters, incandescent bulbs) that draw a current proportional to the voltage, non-linear loads draw current in a non-sinusoidal fashion.5 The most common culprit is the simple rectifier-capacitor front-end, which draws current only in short, high-amplitude pulses at the peak of the voltage waveform to charge a capacitor.2

Per Fourier's theorem, any periodic, non-sinusoidal waveform can be decomposed into a sum of sine waves: the "fundamental" frequency (50/60 Hz) and a series of "harmonics," which are integer multiples of the fundamental (e.g., 3rd harmonic \= 150/180 Hz, 5th \= 250/300 Hz, etc.).1

These harmonic currents are a form of "electrical noise" 7 or "mains pollution" 2 injected back into the power grid. They are the root cause of numerous power quality problems, including:

* **Inefficiency and Losses:** Harmonic currents do not contribute to real power transfer but increase total RMS current, leading to higher $I^2R$ (resistive) losses and reduced transmission efficiency.2  
* **Equipment Overheating:** Harmonics can cause excessive heating and premature failure in neutral conductors, motors, and transformers.7  
* **Voltage Waveform Distortion:** The flow of harmonic currents through the grid's natural impedance distorts the voltage waveform, potentially causing misoperation or damage to other sensitive electronic equipment connected to the same supply.2  
* **Reduced Equipment Life:** The cumulative thermal and voltage stresses caused by harmonics can significantly reduce the operational lifespan of electrical equipment.8

### **Core Terminology and Metrics (Per IEEE Std 1459-2010)**

To quantify and regulate these phenomena, standards bodies, particularly the IEEE, have developed precise definitions for power quantities under non-sinusoidal conditions, as codified in standards like **IEEE Std 1459-2010**.11

#### **Total Harmonic Distortion (THD)**

Total Harmonic Distortion (THD) is the most common metric used to quantify the "purity" of a waveform. It is formally defined as the ratio of the root-mean-square (RMS) value of all harmonic components (from the 2nd order upward) to the RMS value of the fundamental component.1

* **Voltage THD ($THD\_v$):** $THD\_v \= \\frac{\\sqrt{\\sum\_{h=2}^{\\infty} V\_h^2}}{V\_1}$ 12  
* **Current THD ($THD\_i$):** $THD\_i \= \\frac{\\sqrt{\\sum\_{h=2}^{\\infty} I\_h^2}}{I\_1}$ 12

A critical, and often misunderstood, causal relationship exists between these two metrics. Harmonics *originate* as **current harmonics ($THD\_i$)** injected by the non-linear loads.10 This distorted current (I) then flows from the equipment back through the power system's inherent source and line impedances (Z).10

According to Ohm's Law for each harmonic ($V\_h \= I\_h \\times Z\_h$), this harmonic current flow creates a corresponding harmonic *voltage drop* across the impedance.10 The superposition of these harmonic voltage drops at a connection point results in the **voltage distortion ($THD\_v$)** that is seen by *all* equipment on that part of the grid.10 This cause-and-effect chain—where $THD\_i$ is the *cause* and $THD\_v$ is the *symptom*—is the entire basis for the regulatory strategies of both the IEC and IEEE.

#### **Total Demand Distortion (TDD)**

Total Demand Distortion (TDD) is a metric specific to the IEEE 519 standard. It is defined as the ratio of the RMS value of all harmonic current components to the **maximum demand load current ($I\_L$)**.15 This $I\_L$ is a specific value, calculated as the average of the peak demand currents over the previous 12 months.15

* **TDD Formula:** $TDD \= \\frac{\\sqrt{\\sum\_{h=2}^{\\infty} I\_h^2}}{I\_L}$ 18

The distinction between TDD and $THD\_i$ lies entirely in the denominator. $THD\_i$ is normalized to the *instantaneous* fundamental current ($I\_1$) 20, while TDD is normalized to a *fixed, long-term maximum* ($I\_L$).20

This difference is crucial for system-level regulation. At 100% load, $I\_1$ is equal to $I\_L$, and thus $TDD \= THD\_i$.20 However, at light loads, the fundamental current ($I\_1$) becomes very small, which can cause the $THD\_i$ ratio to become misleadingly large.8 A facility's $THD\_i$ might measure 30% at full load but 80% at 10% load, even though the *actual* harmonic current (in Amperes) is lower.

Utilities cannot regulate a system based on this highly variable $THD\_i$ index.18 TDD solves this by providing a stable metric. It assesses the facility's harmonic contribution relative to its *maximum size* as a load on the grid, not its transient operational state. This prevents a facility from being penalized for non-compliance simply for operating at a light load.

#### **Total Power Factor (PF)**

In a non-sinusoidal system, the "Total Power Factor" (also known as "True Power Factor") is the ratio of Real Power (P, in Watts) to the total Apparent Power (S, in Volt-Amperes).5 This single metric is a product of two distinct components: displacement and distortion.

* **1\. Displacement Power Factor (DPF):** This is the "traditional" power factor, defined as the cosine of the phase angle ($\\phi\_1$) between the *fundamental* voltage and the *fundamental* current: $DPF \= \\cos(\\phi\_1)$.22 This component *only* accounts for phase shift, the problem associated with linear reactive loads like induction motors.23  
* **2\. Distortion Power Factor:** This component quantifies the power factor reduction caused by harmonic distortion alone. It is defined as the ratio of the RMS fundamental current to the RMS *total* current: $PF\_{Distortion} \= \\frac{I\_{1,rms}}{I\_{total,rms}}$.24 This can be expressed mathematically in terms of current THD: $PF\_{Distortion} \= \\frac{1}{\\sqrt{1 \+ THD\_i^2}}$.24

The Unifying Formula that connects these components is:  
Total PF \= Displacement PF $\\times$ Distortion PF 25  
This formula is a powerful diagnostic tool. It reveals that a low Total PF can be caused by two separate problems: a low DPF (phase-shifted current) or a low Distortion PF (high $THD\_i$). These two problems require completely different solutions.

1. A low DPF (e.g., from an induction motor) is corrected with passive PFC, such as capacitor banks, to supply reactive power.5  
2. A low Distortion PF (e.g., from an SMPS) is corrected with Active PFC (APFC) or harmonic filters to mitigate the harmonic currents.5

Critically, applying the wrong solution can be disastrous. Adding a capacitor bank (a fix for DPF) to a system dominated by non-linear loads (high $THD\_i$) does nothing to fix the Distortion PF and can create a new parallel resonant circuit with the system's inductance, which can *amplify* specific harmonics and lead to catastrophic equipment failure.9

#### **Historical Context: Budeanu vs. Fryze Power Theories**

The difficulty in defining these terms for non-sinusoidal systems is not new. In 1927, Constantin Budeanu proposed a power theory that decomposed apparent power into $S^2 \= P^2 \+ Q^2 \+ D^2$, where 'D' was a new "distortion power".28 While influential, this theory was later shown to be physically flawed, as the 'D' term does not actually represent the power associated with distortion.29

In 1931, Stanisław Fryze proposed a time-domain theory that decomposed the load current into an "active" component and a "reactive" component, which is more physically sound.28 This long-standing academic debate underscores the importance of modern, unambiguous standards like IEEE 1459, which provide the clear definitions necessary for engineering and regulation.32

## **IEC 61000-3-2: Equipment-Level Harmonic Current Emission Limits (≤16A)**

### **Scope and Objective of the Standard**

**IEC 61000-3-2: "Electromagnetic compatibility (EMC) – Part 3-2: Limits – Limits for harmonic current emissions"** is a foundational international standard.2

* **Scope:** The standard applies to electrical and electronic equipment intended to be connected to **public low-voltage distribution systems**, with a **rated input current up to and including 16 A per phase**.33 It specifies the maximum permissible current for each harmonic from the 2nd up to and including the 40th order.2  
* **Key Scope Clarification:** Recent editions (e.g., IEC 61000-3-2:2018+A1:2020) have updated the scope from "input current $\\le$ 16 A" to "**rated** input current $\\le$ 16 A".33 This is a crucial technical clarification that bases the equipment's classification on its permanent nameplate rating, not on a variable current that might be measured during operation.  
* **Objective:** The standard's philosophy is a "bottom-up" approach to power quality. The objective is to limit the harmonic current "pollution" from individual pieces of equipment.7 The underlying principle is that if all individual devices comply with these emission limits, the *aggregate* harmonic distortion on the public grid will remain below the "compatibility levels" defined in the companion standard, **IEC 61000-2-2**.38  
* **Test Method:** The compliance tests defined by this standard are "type tests".34 This means a representative sample of a product is tested under specified laboratory conditions, rather than testing every unit sold or performing measurements in the field.

### **Equipment Classifications (Class A, B, C, D)**

A central feature of IEC 61000-3-2 is that it does not apply one set of limits to all equipment. Instead, it categorizes equipment into one of four classes (A, B, C, or D) based on its characteristics, power consumption, and usage patterns (e.g., simultaneity of use, duration of use).41

* **Class A:** This is the "default" or "catch-all" class for any equipment that does not fall into B, C, or D.41 It includes:  
  * Balanced three-phase equipment.  
  * Household appliances, *excluding* those identified as Class D (e.g., refrigerators, washing machines).  
  * Tools that are *not* portable tools.  
  * Dimmers for incandescent lamps.  
  * Audio equipment.42  
* **Class B:** This class is for transient, mobile equipment:  
  * Portable tools.42  
  * Arc welding equipment that is *not* intended for professional use.38  
* **Class C:** This class is dedicated to:  
  * Lighting equipment.42  
  * This class has specific sub-rules. The main limits apply to lighting with an active input power \> 25 W.44 Recent standard revisions (e.g., 2018+A1:2020) introduced a significant exemption: all lighting equipment with a rated power **$\\le$ 5 W** is now exempt from harmonic limits.34 A separate set of rules applies for equipment between 5 W and 25 W.45  
* **Class D:** This is the most stringent and impactful class. It applies to equipment that has an input current with a "special wave shape" 44 (the pulsed waveform characteristic of a rectifier-capacitor supply 2) *and* has a fundamental active input power **between 75 W and 600 W**.41  
  * This class specifically targets high-volume consumer electronics: **Personal Computers (PCs), personal computer monitors, and television receivers**.41  
  * This class exists because these devices are (a) extremely numerous and (b) have a high "simultaneity of use" (e.g., millions are on at the same time in offices and homes).42 The strict, power-relative limits (in mA/W) for Class D are practically impossible to meet with a simple, non-correcting power supply (which has a poor power factor around 0.7 2). Therefore, **Class D is the primary regulatory driver that forces manufacturers to include Active Power Factor Correction (APFC) circuits** in all modern PCs, monitors, and TVs.

### **Harmonic Current Limits and Test Conditions**

The standard defines specific numerical limits for each harmonic order, which vary by the equipment's class.

#### **Table II.1: Harmonic Current Limits for Class A Equipment**

Class A limits are absolute maximum values in Amperes. They serve as a baseline for other classes.

| Harmonic (n) | Max Current (A) | Harmonic (n) | Max Current (A) |
| :---- | :---- | :---- | :---- |
| **Odd Harmonics** |  | **Even Harmonics** |  |
| 3 | 2.30 | 2 | 1.08 |
| 5 | 1.14 | 4 | 0.43 |
| 7 | 0.77 | 6 | 0.30 |
| 9 | 0.40 | 8 | 0.23 |
| 11 | 0.33 | 10 | 0.18 |
| 13 | 0.21 | 8 $\\le$ n $\\le$ 40 | 0.23 $\\times$ (8/n) |
| 15 $\\le$ n $\\le$ 39 | 0.15 $\\times$ (15/n) |  |  |
| Source: 35 |  |  |  |

#### **Table II.2: Harmonic Current Limits for Class B Equipment**

The limits for Class B (portable tools) are a simple multiple of Class A.

* **Limit:** **1.5 $\\times$ (Class A Limits)** 43

This 50% allowance for higher pollution from portable tools is a pragmatic concession based on the classification criteria.42 A portable drill (Class B) is used intermittently for short durations. A refrigerator (Class A) runs continuously. The standard allows a higher *instantaneous* harmonic current from Class B devices because their "duration of use" and "simultaneity of use" are very low, resulting in a low *average* impact on the grid.

#### **Table II.3: Harmonic Current Limits for Class C Equipment**

For Class C (lighting equipment, P \> 25 W), the limits are *relative* (a percentage of the fundamental current), not absolute. This scales the allowed distortion with the actual power draw, which is logical for variable-power devices like dimmers.

| Harmonic (n) | Max Current (% of Fundamental) |
| :---- | :---- |
| 2 | 2% |
| 3 | 30% $\\times$ $\\lambda$ (where $\\lambda$ is Power Factor) |
| 5 | 10% |
| 7 | 7% |
| 9 | 5% |
| 11 $\\le$ n $\\le$ 39 (odd) | 3% |
| Source: 47 |  |

For lighting equipment between 5 W and 25 W, one path to compliance is to meet THD-based limits: THD $\\le$ 70%, 3rd harmonic $\\le$ 35% of fundamental, 5th $\\le$ 25%, etc..45

#### **Table II.4: Harmonic Current Limits for Class D Equipment**

These are the strictest limits, expressed in milliamperes per Watt (mA/W), with an absolute cap set by the Class A limits.43

| Harmonic (n) (Odd only) | Max Current (mA/W) | Max Current (A) (Absolute Cap) |
| :---- | :---- | :---- |
| 3 | 3.4 | 2.30 |
| 5 | 1.9 | 1.14 |
| 7 | 1.0 | 0.77 |
| 9 | 0.5 | 0.40 |
| 11 | 0.35 | 0.33 |
| 13 $\\le$ n $\\le$ 39 | 3.85 / n | (Class A limit) |
| Source: 43 |  |  |

This mA/W metric is the "PFC-forcing" mechanism. It directly links the allowed harmonic *current* to the *real power* being consumed. A "dumb" rectifier-capacitor supply draws a high harmonic current regardless of its actual power load, causing it to fail this ratio test. An Active PFC circuit explicitly shapes the current to be proportional to the power, allowing it to pass.

#### **Test Conditions**

To ensure reproducibility, the standard mandates strict test conditions. The equipment must be operated in a mode that produces the *maximum* total harmonic current consistent with normal operation.43 The AC test source must be highly stable (e.g., voltage accuracy $\\pm$2.0%, frequency $\\pm$0.5%) with very low background voltage distortion.43 Measurements are performed according to **IEC 61000-4-7**, which specifies using a Discrete Fourier Transform (DFT) over a precise time window (e.g., 10 cycles for a 50 Hz system).37

## **IEEE 519: System-Level Harmonic Control**

### **Standard Philosophy: "Shared Responsibility"**

**IEEE 519: "IEEE Standard for Harmonic Control in Electric Power Systems"** takes a fundamentally different, "top-down" approach.6

A significant change occurred with the 2022 edition: the title was changed from "Recommended Practice and Requirements" to "Standard".48 This change is not merely semantic; it elevates the document from a set of guidelines to a more binding standard, reflecting its critical importance in modern grid management.

The core philosophy of IEEE 519 is one of **"shared responsibility"** between the power supplier (utility) and the power user (customer) 6:

1. **The Utility's Responsibility:** The utility is responsible for controlling its system impedance and delivering a "clean" *voltage* waveform to the customer's connection point.6  
2. **The User's Responsibility:** The user is responsible for limiting the amount of harmonic *current* (distortion) they inject back into the utility's grid.6

### **The Point of Common Coupling (PCC)**

This "shared responsibility" is enforced at a single, critical location: the **Point of Common Coupling (PCC)**.6

* **Definition:** The PCC is the physical demarcation point on the public power system where the utility's grid connects to the customer's private installation.15 This is typically the electric power revenue meter or the primary of the service transformer.6  
* **Significance:** All IEEE 519 limits, for *both* voltage and current, are measured and applied at this single point.48

This is the most important distinction from IEC 61000-3-2. IEEE 519 does *not* apply to individual pieces of equipment within a facility.52 It applies to the *aggregate performance of the entire installation* as seen from the grid's perspective at the PCC.48

This means a user is free to operate "dirty" non-linear loads *within* their plant, provided they also have enough "clean" linear loads (e.g., resistive heating, motors) to "dilute" the harmonics, or if they install a central harmonic filter. As long as the *net* distortion at the PCC remains within the limits, the facility is compliant.

### **Utility Responsibility: Voltage Distortion Limits**

The utility's "promise" to the customer is codified in Table III.1, which specifies the maximum voltage distortion (THDv) they are allowed to deliver to the PCC. This defines the electromagnetic environment the user's equipment must be able to withstand.8

#### **Table III.1: IEEE 519 Voltage Distortion (THDv) Limits**

The limits are tiered by system voltage, becoming stricter for higher-voltage "backbone" systems.

| Bus Voltage at PCC | Individual Harmonic (%) | Total Voltage Distortion (THDv) (%) |
| :---- | :---- | :---- |
| V $\\le$ 1.0 kV | 5.0 | **8.0** |
| 1.0 kV $\<$ V $\\le$ 69 kV | 3.0 | **5.0** |
| 69 kV $\<$ V $\\le$ 161 kV | 1.5 | **2.5** |
| V $\>$ 161 kV | 1.0 | **1.5** |
| Source: 8 |  |  |

For the vast majority of commercial and industrial facilities (e.g., at 480V, 13.8kV), the governing limits are **3.0% for any individual harmonic** and **5.0% for Total Voltage Distortion (THDv)**.

### **User Responsibility: Current Distortion Limits (TDD)**

The user's "bill" for polluting the grid is detailed in Table III.2. The user must limit their injected harmonic current, measured in TDD, based on the "stiffness" of the grid at their connection point.8 This stiffness is quantified by the ratio of the maximum short-circuit current ($I\_{sc}$) to the maximum demand load current ($I\_L$).

* **$I\_{sc}$ (Short-Circuit Current):** A measure of the grid's "strength" or "stiffness".19 A high $I\_{sc}$ indicates a very strong, low-impedance grid.  
* **$I\_L$ (Maximum Demand Load Current):** A measure of the customer's "size" or maximum load.19

The **$I\_{sc} / I\_L$ ratio** is an elegant engineering compromise. It quantifies how much *impact* a user's harmonic current ($I\_h$) will have on the system's voltage ($V\_h$).

* A **low $I\_{sc} / I\_L$ ratio** (e.g., \<20) signifies a "weak grid".55 The customer's load ($I\_L$) is large relative to the grid's strength ($I\_{sc}$). In this low-impedance environment, any harmonic current ($I\_h$) injected by the user will produce a large, problematic voltage distortion ($V\_h$). Therefore, the user must be *very clean* and is held to the strictest TDD limit of **5.0%**.56  
* A **high $I\_{sc} / I\_L$ ratio** (e.g., \>1000) signifies a "strong grid".55 The customer is a "small fish in a big pond." Their harmonic currents are insignificant compared to the grid's capacity and are easily absorbed. Therefore, they are allowed to inject more distortion, with a TDD limit of **20.0%**.56

#### **Table III.2: IEEE 519 Current Distortion (TDD) Limits (Systems 120V \- 69kV)**

This table defines the "sliding scale" of TDD limits based on the user's $I\_{sc} / I\_L$ ratio.

| Isc​/IL​ | 2 ≤ h \< 11 | 11 ≤ h \< 17 | 17 ≤ h \< 23 | 23 ≤ h \< 35 | 35 ≤ h ≤ 50 | TDD (%) |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| $\<$ 20 (Weak Grid) | 4.0% | 2.0% | 1.5% | 0.6% | 0.3% | **5.0%** |
| 20 $\<$ 50 | 7.0% | 3.5% | 2.5% | 1.0% | 0.5% | **8.0%** |
| 50 $\<$ 100 | 10.0% | 4.5% | 4.0% | 1.5% | 0.7% | **12.0%** |
| 100 $\<$ 1000 | 12.0% | 5.5% | 5.0% | 2.0% | 1.0% | **15.0%** |
| $\>$ 1000 (Strong Grid) | 15.0% | 7.0% | 6.0% | 2.5% | 1.4% | **20.0%** |
| Source: 20 |  |  |  |  |  |  |
| Note: Even harmonics are further restricted, often to 25% of the odd harmonic limits.19 |  |  |  |  |  |  |

## **Reconciling Equipment and System Standards (IEC vs. IEEE)**

### **Complementary Philosophies: Bottom-Up vs. Top-Down**

The IEC 61000-3-2 and IEEE 519 standards are not contradictory; they are complementary, addressing the harmonic problem from two different perspectives.

* **IEC 61000-3-2 is an Equipment Emission Standard**.39  
  * **Analogy:** It is the emissions test ("smog check") for an *individual car*.  
  * **Application:** It is a "type test" performed in a laboratory on a product before it can be sold.34  
  * **Goal:** To ensure individual *products* are designed to be "clean".40  
* **IEEE 519 is a System Compatibility Standard**.39  
  * **Analogy:** It is the air quality measurement for an *entire city*.  
  * **Application:** It is measured in the field at the "city limits" (the PCC).57  
  * **Goal:** To ensure the *total facility* does not pollute the shared resource (the grid).40

These standards work together. A facility engineer designs a large installation to meet its **IEEE 519** TDD limits (the "city" goal) by specifying and procuring equipment that complies with **IEC 61000-3-2** (the "car" standard).40 IEC compliance is the *means* by which IEEE compliance is achieved.

### **The "Tragedy of the Commons": A Gap in the Standards**

A significant gap exists in this regulatory framework, often described as a "tragedy of the commons".58

The IEC 61000-3-2 standard includes exemptions for equipment deemed to have a low individual impact. A key exemption is for equipment with a rated power of 75 W or less (excluding lighting).58 A single \<75 W device, such as a laptop power supply or a phone charger, is therefore exempt from *any* harmonic limits and can be a "dirty" polluter.

While the impact of one such device is negligible, a modern office building may install *thousands* of these individually-exempt chargers and power supplies.58 The *aggregate* harmonic current from these thousands of "legal" polluters flows to the PCC. The building *as a system* can then easily fail its IEEE 519 TDD limits.58

This demonstrates the critical flaw of relying *only* on equipment-level standards and highlights the absolute necessity of a *system-level* standard like IEEE 519 to manage the cumulative impact of many small, unregulated harmonic sources.

### **The Broader Standards Ecosystem**

These two standards are the most prominent, but they exist within a larger ecosystem of related documents:

* **IEC 61000-3-12:** This standard is the "big brother" to 61000-3-2. It applies to equipment with a rated current \> 16 A and $\\le$ 75 A per phase.35  
* **IEC 61000-2-2:** This is the *compatibility* standard that defines the "target" for the public low-voltage grid. It sets the maximum THDv (e.g., 8%) that the grid should ever experience.38 The IEC 61000-3-2 emission limits are calculated to ensure the grid stays below this 61000-2-2 ceiling.  
* **IEEE 1547:** A modern standard governing the interconnection of Distributed Energy Resources (DERs) like solar inverters and battery storage.62 This standard *also* mandates power quality and PFC functions, requiring inverters to support the grid by regulating voltage (e.g., Volt-VAR mode) and maintaining a constant power factor.62 This shows the modern trend of requiring all new grid-connected power electronics to be "grid-supportive" by default.

## **Engineering for Compliance: Power Factor Correction (PFC) Converters**

### **The Necessity of Active PFC**

A simple, non-correcting power supply (diode bridge \+ bulk capacitor) is a classic Class D load.44 It has a high $THD\_i$ and a poor Total PF of approximately 0.7.2 This design *cannot* pass the strict mA/W limits of IEC 61000-3-2 Class D.4

To solve this, engineers must implement Power Factor Correction.

* **Passive PFC:** This method uses large, heavy, and expensive low-frequency inductors and capacitors to filter harmonics.47 It is simple but inefficient, not effective for wide input voltage ranges (e.g., universal 90V-265V), and does not produce a truly sinusoidal input current.47  
* **Active PFC (APFC):** This is the industry-standard solution and the *only* viable method for Class D compliance.27 An APFC is a high-frequency switching converter—a "pre-regulator"—inserted after the bridge rectifier but before the main power supply.3

### **APFC Topologies and Design Goals**

The APFC stage serves two simultaneous engineering goals, one for regulatory compliance and one for system performance.

1. **Regulatory Goal:** The APFC controller actively modulates a switch (typically a MOSFET) at high frequency. It senses the input voltage sine wave and forces the input *current* draw to follow that sine wave in both shape and phase.27 This achieves a near-perfect Total Power Factor (\>0.99) 66 and a very low $THD\_i$ (\<10%) 67, easily passing all IEC 61000-3-2 limits.  
2. **Engineering Goal:** The most common APFC topology is the **Boost Converter**.68 A boost converter is a "step-up" topology; its output voltage *must* be higher than its input. To handle a "universal" AC input (which peaks at $\\approx$ 375V from a 265V line), the APFC boost stage is designed to generate a stable, high-voltage DC bus, typically **\>380 V**.69 This high-voltage rail *greatly simplifies* the design of the main downstream (isolated) DC-DC converter, which can now be optimized for a single, stable, narrow-range input rather than the chaotic 90V-265V AC input.69

### **Common APFC Topologies**

* **1\. The Boost Converter:** This is the workhorse of the industry.68 When operated in Continuous Conduction Mode (CCM), it has a continuous input current, which is ideal for "shaping" into a sine wave using average current-mode control.66  
* **2\. Interleaved Boost Converter:** This advanced topology uses two or more boost converters in parallel, operating 180 degrees out of phase.68 The high-frequency ripple currents from each stage, being out of phase, *cancel each other out* at the input.68 This dramatically reduces the input ripple, which in turn reduces the size of the required EMI filter and inductors, reduces stress on capacitors, and enables much higher power density (W/in³).66  
* **3\. Bridgeless PFC:** To push efficiencies to 98% and higher, modern designs eliminate the input diode bridge.70 The bridge itself causes significant conduction losses, as the full input current must always flow through two diodes.70 Bridgeless topologies use the PFC's own switches to perform the rectification, eliminating this loss and helping to meet stringent modern energy efficiency standards.66

### **APFC Control Methods**

* **Critical Conduction Mode (CrCM):** Also known as Transition Mode (TM), this is an extremely popular control method for low-to-medium power APFC.69  
* **Operation:** The controller turns the switch on. When the switch turns off, the inductor current begins to fall. The controller waits for the exact moment the inductor current reaches zero, and then *immediately* turns the switch back on.69  
* **Benefits:** This method is simple, achieves a high power factor, and naturally enables "zero-voltage switching" (ZVS) or "valley switching," which dramatically reduces switching losses and improves efficiency.66

The development of these advanced PFC converters relies on standards from bodies like the **IEEE Power Electronics Society (PELS)**, whose technical committees (such as the ETTC) develop the standards for the high-frequency magnetic components and transformers that are the core building blocks of these systems.71

#### **Works cited**

1. Why Is It Important to Understand Total Harmonic Distortion (THD) ? | HIOKI, accessed October 29, 2025, [https://www.hioki.com/us-en/learning/electricity/thd.html](https://www.hioki.com/us-en/learning/electricity/thd.html)  
2. IEC 61000-3-2 \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/IEC\_61000-3-2](https://en.wikipedia.org/wiki/IEC_61000-3-2)  
3. A review on Buck topology-based PFC Conversion Techniques \- International Journal of Engineering and Designing Innovation, accessed October 29, 2025, [http://jedi.researchculturesociety.org/wp-content/uploads/IJEDI202001005.pdf](http://jedi.researchculturesociety.org/wp-content/uploads/IJEDI202001005.pdf)  
4. State-of-the-Art Power Factor Correction: An Industry Perspective \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/2673-8392/4/3/87](https://www.mdpi.com/2673-8392/4/3/87)  
5. Power factor \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Power\_factor](https://en.wikipedia.org/wiki/Power_factor)  
6. IEEE 519-2022: Harmonic Control In Electric Power Systems \- The ANSI Blog, accessed October 29, 2025, [https://blog.ansi.org/ansi/ieee-519-2022-harmonic-control-power-systems/](https://blog.ansi.org/ansi/ieee-519-2022-harmonic-control-power-systems/)  
7. Understanding IEC/EN 61000-3-2: A Complete Guide \- Compliance Testing, accessed October 29, 2025, [https://compliancetesting.com/iec-en-61000-3-2/](https://compliancetesting.com/iec-en-61000-3-2/)  
8. Application of IEEE Std 519-1992 harmonic limits \- Eaton, accessed October 29, 2025, [https://www.eaton.com/content/dam/eaton/products/backup-power-ups-surge-it-power-distribution/power-conditioners/harmonic-correction-unit/IEEE-std-519-1992-harmonic-limits.pdf](https://www.eaton.com/content/dam/eaton/products/backup-power-ups-surge-it-power-distribution/power-conditioners/harmonic-correction-unit/IEEE-std-519-1992-harmonic-limits.pdf)  
9. 33 \- How do harmonics relate to power factor and displacement power factor? \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=oV8XpcS\_lsc](https://www.youtube.com/watch?v=oV8XpcS_lsc)  
10. UNDERSTANDING CURRENT & VOLTAGE HARMONICS 31 \- NET, accessed October 29, 2025, [https://corpwebstorage.blob.core.windows.net/media/36814/understanding-current-voltage-harmonics.pdf](https://corpwebstorage.blob.core.windows.net/media/36814/understanding-current-voltage-harmonics.pdf)  
11. Redline : IEEE Standard Definitions for the Measurement of Electric Power Quantities Under Sinusoidal, Nonsinusoidal, Balanced, or Unbalanced Conditions \- the library catalog \- College of Charleston, accessed October 29, 2025, [https://pascal-cofc.library.cofc.edu/discovery/fulldisplay?docid=alma991010972796205613\&context=L\&vid=01PASCAL\_COFC:COFC\&lang=en\&adaptor=Local%20Search%20Engine\&tab=Books\_Articles\_and\_More\&query=sub%2Cexact%2C%20%20Circuits%20%2CAND\&mode=advanced\&offset=30](https://pascal-cofc.library.cofc.edu/discovery/fulldisplay?docid=alma991010972796205613&context=L&vid=01PASCAL_COFC:COFC&lang=en&adaptor=Local+Search+Engine&tab=Books_Articles_and_More&query=sub,exact,++Circuits+,AND&mode=advanced&offset=30)  
12. (PDF) The IEEE standard 1459: What and why? \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/224185058\_The\_IEEE\_standard\_1459\_What\_and\_why](https://www.researchgate.net/publication/224185058_The_IEEE_standard_1459_What_and_why)  
13. IEEE Standard Definitions for the Measurement of Electric Power Quantities Under Sinusoidal, Nonsinusoidal, Balanced, or Unbalanced Conditions \- Thece, accessed October 29, 2025, [https://thece.eu/wp-content/uploads/2020/07/1459-2010.pdf](https://thece.eu/wp-content/uploads/2020/07/1459-2010.pdf)  
14. Total harmonic distortion \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Total\_harmonic\_distortion](https://en.wikipedia.org/wiki/Total_harmonic_distortion)  
15. Understanding the IEEE 519 – 2014 standard for Harmonics \- Elspec LTD, accessed October 29, 2025, [https://www.elspec-ltd.com/ieee-519-2014-standard-for-harmonics/](https://www.elspec-ltd.com/ieee-519-2014-standard-for-harmonics/)  
16. Understanding, Calculating, and Measuring Total Harmonic Distortion (THD) \- Technical Articles \- All About Circuits, accessed October 29, 2025, [https://www.allaboutcircuits.com/technical-articles/the-importance-of-total-harmonic-distortion/](https://www.allaboutcircuits.com/technical-articles/the-importance-of-total-harmonic-distortion/)  
17. Developing Harmonic Power Analyzer based on IEEE 1459-2010 Standard \- IAENG, accessed October 29, 2025, [https://www.iaeng.org/publication/IMECS2012/IMECS2012\_pp948-951.pdf](https://www.iaeng.org/publication/IMECS2012/IMECS2012_pp948-951.pdf)  
18. Total Demand Distortion (TDD), accessed October 29, 2025, [https://mtecorp.com/wp-content/uploads/Total-Demand-Distortion-Tech-Bulletin-rev.1.pdf](https://mtecorp.com/wp-content/uploads/Total-Demand-Distortion-Tech-Bulletin-rev.1.pdf)  
19. Understanding the IEEE 519–2014 Standard for Harmonics, accessed October 29, 2025, [https://www.ytelect.com/blog/understanding-the-ieee-519-2014-standard-for-harmonics\_b200](https://www.ytelect.com/blog/understanding-the-ieee-519-2014-standard-for-harmonics_b200)  
20. Power quality – IEEE 519-2022 \- Comsys, accessed October 29, 2025, [https://comsys.se/en-us/our-adf-technology/power-quality-ieee-519-2022/](https://comsys.se/en-us/our-adf-technology/power-quality-ieee-519-2022/)  
21. Standard 1459-2000: A New Way to Measure Power | EC\&M, accessed October 29, 2025, [https://www.ecmweb.com/power-quality-magazine-archive/article/20885051/standard-1459-2000-a-new-way-to-measure-power](https://www.ecmweb.com/power-quality-magazine-archive/article/20885051/standard-1459-2000-a-new-way-to-measure-power)  
22. Power Factor Correction Solutions & Applications, accessed October 29, 2025, [https://ewh.ieee.org/soc/pes/newyork/Archive%20Docs/Power%20Factor%20Correction%20Solutions%20and%20Applications%20Eaton%20Crop%203-2016.pdf](https://ewh.ieee.org/soc/pes/newyork/Archive%20Docs/Power%20Factor%20Correction%20Solutions%20and%20Applications%20Eaton%20Crop%203-2016.pdf)  
23. Power Factor: Understanding the Difference Between DPF vs TPF \- PowerSight, accessed October 29, 2025, [https://powersight.com/power-factor-understanding-the-difference-between-dpf-vs-tpf/](https://powersight.com/power-factor-understanding-the-difference-between-dpf-vs-tpf/)  
24. Harmonic distortion indicators \- Power factor \- Electrical Installation Guide, accessed October 29, 2025, [https://www.electrical-installation.org/enwiki/Harmonic\_distortion\_indicators\_-\_Power\_factor](https://www.electrical-installation.org/enwiki/Harmonic_distortion_indicators_-_Power_factor)  
25. Total Harmonic Distortion (THD) and Power Factor Calculation, accessed October 29, 2025, [https://powerquality.blog/2024/05/07/total-harmonic-distortion-thd-and-power-factor-calculation/](https://powerquality.blog/2024/05/07/total-harmonic-distortion-thd-and-power-factor-calculation/)  
26. Distortion Factor as a function of total harmonic distortion \- EDN, accessed October 29, 2025, [https://www.edn.com/distortion-factor-as-a-function-of-total-harmonic-distortion/](https://www.edn.com/distortion-factor-as-a-function-of-total-harmonic-distortion/)  
27. Power Factor Correction (PFC) Explained | Article | MPS \- Monolithic Power Systems, accessed October 29, 2025, [https://www.monolithicpower.com/en/learning/resources/power-factor-correction](https://www.monolithicpower.com/en/learning/resources/power-factor-correction)  
28. Two frameworks for Interpreting Power Properties of Circuits with Nonsinusoidal Voltages and Currents \- Leszek S. Czarnecki, accessed October 29, 2025, [https://czarnecki.study/wp-content/uploads/2019/08/69-Budeanu-and-Fryze-Arch-1.pdf](https://czarnecki.study/wp-content/uploads/2019/08/69-Budeanu-and-Fryze-Arch-1.pdf)  
29. Budeanu's Distortion Power Components Based on CPC Theory in Three-Phase Four-Wire Systems Supplied by Symmetrical Nonsinusoidal Voltage Waveforms \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/17/5/1043](https://www.mdpi.com/1996-1073/17/5/1043)  
30. Extension and Correction of Budeanu Power Theory Based on Currents' Physical Components (CPC) Theory for Single-Phase Systems \- MDPI, accessed October 29, 2025, [https://www.mdpi.com/1996-1073/15/21/8321](https://www.mdpi.com/1996-1073/15/21/8321)  
31. Potential Use of Fryze's Approach-Based Power Theories in Waveform Distortion Contribution Assessment Uso potencial de las Teo \- Dialnet, accessed October 29, 2025, [https://dialnet.unirioja.es/descarga/articulo/9514687.pdf](https://dialnet.unirioja.es/descarga/articulo/9514687.pdf)  
32. Definitions of power quantities in the IEEE Std 1459-2010 \- Index Copernicus, accessed October 29, 2025, [https://journals.indexcopernicus.com/api/file/viewByFileId/1347251](https://journals.indexcopernicus.com/api/file/viewByFileId/1347251)  
33. IEC/EN 61000-3-2 \- Absolute EMC, accessed October 29, 2025, [https://absolute-emc.com/standard/International\_Test\_Standards/iec-en-61000-3-2](https://absolute-emc.com/standard/International_Test_Standards/iec-en-61000-3-2)  
34. IEC 61000-3-2:2018+AMD1:2020 CSV, accessed October 29, 2025, [https://webstore.iec.ch/en/publication/67329](https://webstore.iec.ch/en/publication/67329)  
35. The Accuracy of Evaluation of the Requirements of the Standards IEC 61000-3-2(12) with the Application of the Wideband Current Transducer, accessed October 29, 2025, [https://pmc.ncbi.nlm.nih.gov/articles/PMC11175187/](https://pmc.ncbi.nlm.nih.gov/articles/PMC11175187/)  
36. IEC 61000-3-2:2018, accessed October 29, 2025, [https://webstore.iec.ch/en/publication/28164](https://webstore.iec.ch/en/publication/28164)  
37. IEC 61000-3-2 2018 Harmonic Testing Standard Update Latest Edition, accessed October 29, 2025, [https://www.euttest.com/en/resources/iec-61000-3-2-2018.html](https://www.euttest.com/en/resources/iec-61000-3-2-2018.html)  
38. IEC 61000-3-2 Current Harmonic Emissions Testing Lab | Keystone Compliance, accessed October 29, 2025, [https://keystonecompliance.com/iec-61000-3-2/](https://keystonecompliance.com/iec-61000-3-2/)  
39. Harmonics standards \- Electrical Installation Guide, accessed October 29, 2025, [https://www.electrical-installation.org/enwiki/Harmonics\_standards](https://www.electrical-installation.org/enwiki/Harmonics_standards)  
40. Power Quality Standards, Problems and their Solutions, accessed October 29, 2025, [https://powerquality.blog/2022/02/02/power-quality-standards-problems-and-their-solutions/](https://powerquality.blog/2022/02/02/power-quality-standards-problems-and-their-solutions/)  
41. Harmonic Current in Power Supplies and IEC 61000-3-2 \- Industry Articles, accessed October 29, 2025, [https://www.allaboutcircuits.com/industry-articles/harmonic-current-in-power-supplies-and-iec-61000-3-2/](https://www.allaboutcircuits.com/industry-articles/harmonic-current-in-power-supplies-and-iec-61000-3-2/)  
42. IEC 61000-3-2 Harmonics Standards Overview \- EMC FastPass, accessed October 29, 2025, [https://www.emcfastpass.com/wp-content/uploads/2017/04/Class\_definitions.pdf](https://www.emcfastpass.com/wp-content/uploads/2017/04/Class_definitions.pdf)  
43. IEC/EN 61000-3-2 \- At a glance \- Reliant EMC, accessed October 29, 2025, [https://www.reliantemc.com/download/spitzenberger-and-spies/Spitzenberger-Spies-IEC-EN-61000-3-2-overview.pdf](https://www.reliantemc.com/download/spitzenberger-and-spies/Spitzenberger-Spies-IEC-EN-61000-3-2-overview.pdf)  
44. Electromagnetic Compatibility (EMC) Low-Frequency Standards Standards on Low-Frequency Emission: IEC 61000-3-2, accessed October 29, 2025, [https://site.fee.unicamp.br/sites/default/files/uploads/antenor/Giorgio/IEC.pdf](https://site.fee.unicamp.br/sites/default/files/uploads/antenor/Giorgio/IEC.pdf)  
45. Detailed Explanation of EN61000-3-2:2019 Limits for harmonic current emissions Standard, accessed October 29, 2025, [https://www.lisungroup.com/news/technology-news/detailed-explanation-of-en61000-3-22019-limits-for-harmonic-current-emissions-standard.html](https://www.lisungroup.com/news/technology-news/detailed-explanation-of-en61000-3-22019-limits-for-harmonic-current-emissions-standard.html)  
46. Tutorial on Harmonics, Flicker and Related Immunity \- Absolute EMC, accessed October 29, 2025, [https://absolute-emc.com/article/tutorial-on-harmonics-flicker-and-related-immunity](https://absolute-emc.com/article/tutorial-on-harmonics-flicker-and-related-immunity)  
47. Harmonic Current Emissions \- Guidelines to the standard EN 61000-3-2 \- EMC FastPass, accessed October 29, 2025, [https://emcfastpass.com/wp-content/uploads/2017/04/Applicability\_flow\_chart.pdf](https://emcfastpass.com/wp-content/uploads/2017/04/Applicability_flow_chart.pdf)  
48. IEEE 519-2022 Review What has changed from the previous 2014 version? \- ABB, accessed October 29, 2025, [https://library.e.abb.com/public/a7965e127ce44d089c1c2beace68aacd/Tech\_Note\_158\_IEEE\_519-2022+Review.pdf?x-sign=zoeBsqxVX1a1WQ9vQYQrE4QVCzmBlxU9j64YbBFzBlEyK3FfqtL6aBzK5ErAXQXD](https://library.e.abb.com/public/a7965e127ce44d089c1c2beace68aacd/Tech_Note_158_IEEE_519-2022+Review.pdf?x-sign=zoeBsqxVX1a1WQ9vQYQrE4QVCzmBlxU9j64YbBFzBlEyK3FfqtL6aBzK5ErAXQXD)  
49. IEEE 519-2022 \- IEEE SA, accessed October 29, 2025, [https://standards.ieee.org/ieee/519/10677/](https://standards.ieee.org/ieee/519/10677/)  
50. Understanding IEEE 519 Harmonic Standard: A Comprehensive Guide \- Enjoypowers, accessed October 29, 2025, [https://enjoypowers.com/understanding-ieee-519-harmonic-standard-a-comprehensive-guide/](https://enjoypowers.com/understanding-ieee-519-harmonic-standard-a-comprehensive-guide/)  
51. accessed October 29, 2025, [https://en.wikipedia.org/wiki/Point\_of\_common\_coupling\#:\~:text=In%20electric%20power%20distribution%20the,the%20customer's%20private%20electrical%20installation.](https://en.wikipedia.org/wiki/Point_of_common_coupling#:~:text=In%20electric%20power%20distribution%20the,the%20customer's%20private%20electrical%20installation.)  
52. 69 \- What is the point of common coupling (PCC)? \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=xt8cLkNMcMo](https://www.youtube.com/watch?v=xt8cLkNMcMo)  
53. Surpassing IEEE 519 Harmonics Recommendation for Unmatched Performance, accessed October 29, 2025, [https://smartd.tech/your-benefits/surpassing-ieee-519-harmonics-recommendation-for-unmatched-performance/](https://smartd.tech/your-benefits/surpassing-ieee-519-harmonics-recommendation-for-unmatched-performance/)  
54. Power Quality – IEEE 519-2022, accessed October 29, 2025, [https://powerquality.blog/2023/06/01/power-quality-ieee-519-2022/](https://powerquality.blog/2023/06/01/power-quality-ieee-519-2022/)  
55. Understanding Harmonics in Power Systems: IEEE 519 Guidelines Explained, accessed October 29, 2025, [https://www.rexpowermagnetics.com/knowledge-hub/understanding-harmonics-in-power-systems-ieee-519-guidelines-explained/](https://www.rexpowermagnetics.com/knowledge-hub/understanding-harmonics-in-power-systems-ieee-519-guidelines-explained/)  
56. Interpreting IEEE Std 519 and Meeting its Harmonic Limits in VFD Applications \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/profile/Mohamed-Mourad-Lafifi/post/what\_would\_be\_the\_limit\_of\_Total\_Harmonic\_Distortion\_according\_to\_the\_standard\_of\_IEEE/attachment/59d6408379197b807799cb44/AS%3A431297521819648%401479840750016/download/Interpreting-IEEE-Std-519-and-Meeting-Harmonic-Limits-VFDs-PCIC-2003-15.pdf](https://www.researchgate.net/profile/Mohamed-Mourad-Lafifi/post/what_would_be_the_limit_of_Total_Harmonic_Distortion_according_to_the_standard_of_IEEE/attachment/59d6408379197b807799cb44/AS%3A431297521819648%401479840750016/download/Interpreting-IEEE-Std-519-and-Meeting-Harmonic-Limits-VFDs-PCIC-2003-15.pdf)  
57. Why IEEE 519 Compliance is Essential in 2025 | Quality Energy, accessed October 29, 2025, [https://www.qualityenergy.com.au/ieee-519-compliance](https://www.qualityenergy.com.au/ieee-519-compliance)  
58. Mains harmonic current emissions are always bad \- It is risky to rely on the limits or exclusions in the standards, accessed October 29, 2025, [https://www.emcstandards.co.uk/mains-harmonic-current-emissions-are-always-bad](https://www.emcstandards.co.uk/mains-harmonic-current-emissions-are-always-bad)  
59. What is the difference between IEC 61000-3-12 and IEEE519 ? \- Schneider Electric Community, accessed October 29, 2025, [https://community.se.com/t5/Power-Distribution-and-Digital/What-is-the-difference-between-IEC-61000-3-12-and-IEEE519/td-p/386881](https://community.se.com/t5/Power-Distribution-and-Digital/What-is-the-difference-between-IEC-61000-3-12-and-IEEE519/td-p/386881)  
60. Comparison of harmonic limits and evaluation of the international standards \- MATEC Web of Conferences, accessed October 29, 2025, [https://www.matec-conferences.org/articles/matecconf/pdf/2019/26/matecconf\_jcmme2018\_03009.pdf](https://www.matec-conferences.org/articles/matecconf/pdf/2019/26/matecconf_jcmme2018_03009.pdf)  
61. Limits of harmonic distortion for fluctuating loads, accessed October 29, 2025, [https://www.neso.energy/document/11716/download](https://www.neso.energy/document/11716/download)  
62. IEEE 1547-2018 Guide: DER Interconnection Standards Explained \- Keentel Engineering, accessed October 29, 2025, [https://keentelengineering.com/ieee-1547-2018-der-interconnection-standards](https://keentelengineering.com/ieee-1547-2018-der-interconnection-standards)  
63. Revised IEEE 1547 Standard Will Aid Solar Integration | Department of Energy, accessed October 29, 2025, [https://www.energy.gov/eere/solar/articles/revised-ieee-1547-standard-will-aid-solar-integration](https://www.energy.gov/eere/solar/articles/revised-ieee-1547-standard-will-aid-solar-integration)  
64. Clause-by-Clause Summary of Requirements in IEEE Std 1547-2018 \- NREL, accessed October 29, 2025, [https://www.nrel.gov/grid/ieee-standard-1547/clause](https://www.nrel.gov/grid/ieee-standard-1547/clause)  
65. Research on Five-Level PFC Circuit Topology Based on Switch-Diode-Capacitor Network, accessed October 29, 2025, [https://www.mdpi.com/2079-9292/12/6/1286](https://www.mdpi.com/2079-9292/12/6/1286)  
66. A High-Frequency Power Factor Correction Stage with Low Output Voltage, accessed October 29, 2025, [https://per.mit.edu/wp-content/uploads/2023/10/Hanson\_JESTPE\_Mod-Boost-PFC-final-version.pdf](https://per.mit.edu/wp-content/uploads/2023/10/Hanson_JESTPE_Mod-Boost-PFC-final-version.pdf)  
67. An active PFC boost converter topology for power factor correction \- Semantic Scholar, accessed October 29, 2025, [https://www.semanticscholar.org/paper/An-active-PFC-boost-converter-topology-for-power-Mohanty-Panda/a8633b558f16c95d51f4742557822cc78b95a4e7](https://www.semanticscholar.org/paper/An-active-PFC-boost-converter-topology-for-power-Mohanty-Panda/a8633b558f16c95d51f4742557822cc78b95a4e7)  
68. Topic 5 An Interleaved PFC Preregulator for High-Power Converters \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/download/trng/docs/seminar/Topic5MO.pdf](https://www.ti.com/download/trng/docs/seminar/Topic5MO.pdf)  
69. Power Factor Correction (PFC) Circuit Basics \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/ml/zhcp224/zhcp224.pdf](https://www.ti.com/lit/ml/zhcp224/zhcp224.pdf)  
70. Power Factor Correction (PFC) Handbook \- onsemi, accessed October 29, 2025, [https://www.onsemi.com/pub/collateral/hbd853-d.pdf](https://www.onsemi.com/pub/collateral/hbd853-d.pdf)  
71. Standards Development \- IEEE Power Electronics Society, accessed October 29, 2025, [https://www.ieee-pels.org/technical-activities/standards/](https://www.ieee-pels.org/technical-activities/standards/)