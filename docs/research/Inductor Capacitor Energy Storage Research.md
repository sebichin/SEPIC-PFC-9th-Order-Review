

# **Energy Storage, Transient Response, and Modeling of Reactive Circuits**

## **I. Fundamental Principles of Energy Storage in Reactive Components**

In circuit analysis, resistors are defined by their dissipation of energy. Capacitors and inductors, conversely, are defined as passive, reactive components capable of storing energy and releasing it back to the circuit. The location and mechanism of this energy storage define the fundamental behavior of these components.

### **A. Energy Storage in the Electric Field: The Capacitor ($W\_C \= \\frac{1}{2}CV^2$)**

A capacitor stores energy by separating electric charge, which establishes an electrostatic field between its conductive plates.1 The energy is not stored in the charges themselves, but rather as electrostatic potential energy within the volume of this electric field.3

This energy ($W\_C$) is equal to the total work ($W$) that must be done by an external source to move charge from one plate to the other, building up the potential difference. This derivation must be performed incrementally.

1. **Work Calculation:** The potential difference (voltage) $v$ across a capacitor is a direct function of the charge $q$ that has already accumulated on its plates, given by the definition of capacitance, $C$: $v(q) \= q/C$.6  
2. **Differential Work:** The differential amount of work, $dW$, required to move the next small packet of charge $dq$ against this existing voltage is $dW \= v(q) dq$. Substituting the definition of voltage gives $dW \= (q/C) dq$.6  
3. Integral: To find the total work $W$ done in charging the capacitor from $q=0$ to a final total charge $Q$, we integrate this expression:

   $$W \= \\int\_{0}^{Q} dW \= \\int\_{0}^{Q} \\frac{q}{C} dq \= \\frac{1}{C} \\left\[ \\frac{1}{2}q^2 \\right\]\_{0}^{Q}$$  
4. Result: This integration yields the primary formula for stored energy:

   $$W\_C \= \\frac{1}{2}\\frac{Q^2}{C}$$  
   7

From this primary equation, two more common forms are derived using the relation $Q \= CV$:

* $W\_C \= \\frac{1}{2}\\frac{(CV)^2}{C} \= \\frac{1}{2}CV^2$ 7  
* $W\_C \= \\frac{1}{2}Q \\left( \\frac{Q}{C} \\right) \= \\frac{1}{2}QV$ 7

A common point of confusion is the $\\frac{1}{2}$ factor; it is often mistaken that the work should be $W \= QV$. This would only be true if the full voltage $V$ were present for the entire charging process. In reality, the first charge $dq$ is moved at $V=0$, and the last $dq$ is moved at $V=V\_{final}$. The *average* voltage experienced by the total charge $Q$ during this linear charging process is $V\_{final}/2$. Therefore, the total work is $W \= Q \\times V\_{avg} \= Q(V\_{final}/2)$, which confirms the derived formulas.7

This energy is physically stored within the electric field. For a parallel-plate capacitor ($C \= \\epsilon A/d$ and $V \= Ed$), the total energy can be rewritten in terms of the field itself:

$$W\_C \= \\frac{1}{2}CV^2 \= \\frac{1}{2} \\left( \\frac{\\epsilon A}{d} \\right) (Ed)^2 \= \\frac{1}{2}\\epsilon E^2 (Ad)$$

The term $Ad$ is the volume of the dielectric between the plates. This reveals the universal formula for the energy density (energy per unit volume) of an electric field: $u\_E \= \\frac{1}{2}\\epsilon E^2$.3

### **B. Energy Storage in the Magnetic Field: The Inductor ($W\_L \= \\frac{1}{2}LI^2$)**

An inductor stores energy in the magnetic field created by an electric current flowing through its windings.11 To establish this current, a source must do work against the inductor's "back electromotive force (EMF)," a voltage $v\_L \= L \\frac{di}{dt}$ that, according to Lenz's Law, opposes any change in current.14 The energy transferred by this work is stored in the magnetic field.

1. **Power Calculation:** The instantaneous power $P$ that the source must deliver to the inductor to overcome the back-EMF and increase the current $i$ is $P \= v\_L i$.  
2. Differential Work: Substituting the inductor's voltage definition, the power is $P \= \\left( L \\frac{di}{dt} \\right) i$.14 The total work $W$ (energy) is the integral of this power over the time it takes to ramp the current from $i=0$ to a final current $I$:

   $$W \= \\int\_{0}^{t} P dt' \= \\int\_{0}^{t} \\left( L \\frac{di}{dt'} i \\right) dt'$$  
3. Integral: Using a change of variables from $dt'$ to $di$, the integral simplifies:

   $$W \= L \\int\_{0}^{I} i di \= L \\left\[ \\frac{1}{2}i^2 \\right\]\_{0}^{I}$$  
   14  
4. Result: This yields the definitive formula for energy stored in an inductor:

   $$W\_L \= \\frac{1}{2}LI^2$$  
   17

This energy is physically stored within the magnetic field. For a long ideal solenoid ($L \= \\mu n^2 A l$ and $B \= \\mu n I$), the total energy can be expressed in terms of the $B$-field:

$$W\_L \= \\frac{1}{2}LI^2 \= \\frac{1}{2} \\left( \\mu n^2 A l \\right) \\left( \\frac{B}{\\mu n} \\right)^2 \= \\frac{1}{2}\\frac{B^2}{\\mu} (Al)$$

The term $Al$ is the internal volume of the solenoid. This reveals the universal formula for the energy density of a magnetic field: $u\_B \= \\frac{1}{2}\\frac{B^2}{\\mu}$.20

### **C. The Duality of Inductors and Capacitors**

The energy formulas $W\_L \= \\frac{1}{2}LI^2$ and $W\_C \= \\frac{1}{2}CV^2$ are not just similar; they are mathematically dual. This duality extends to a direct analogy with mechanical systems, which provides a powerful physical intuition for circuit behavior.21

* **Inductor as Mass:** The inductor's energy $W\_L \= \\frac{1}{2}LI^2$ is analogous to kinetic energy, $KE \= \\frac{1}{2}mv^2$.21  
  * Inductance ($L$) is analogous to mass ($m$), or mechanical inertia.  
  * Current ($I$) is analogous to velocity ($v$).  
    This analogy is physically deep: Mass resists a change in velocity (requires a force, $F=ma$). An inductor resists a change in current (induces a voltage, $v=Ldi/dt$). Both store energy in "motion"—the motion of mass or the motion of charge.  
* **Capacitor as Spring:** The capacitor's energy $W\_C \= \\frac{1}{2}\\frac{Q^2}{C}$ is analogous to a spring's potential energy, $PE \= \\frac{1}{2}kx^2$.  
  * Capacitance ($C$) is analogous to mechanical *compliance* (the inverse of spring stiffness, $1/k$).  
  * Charge ($Q$) is analogous to displacement ($x$).  
    This analogy is also robust: A spring stores potential energy by being displaced from equilibrium. A capacitor stores potential energy by having its charge displaced from equilibrium (zero), creating a voltage.

This duality is the fundamental reason for oscillation in RLC circuits. An ideal LC circuit is a perfect electrical resonator, or "tank circuit," precisely because it is the electrical analog of a frictionless mass-spring system.23 The total energy of the system remains constant, oscillating between the inductor's magnetic (kinetic) field and the capacitor's electric (potential) field.

## **II. Transient Response: Time Constants and Damping in Reactive Circuits**

The transient response of a circuit describes its behavior in the interval between an initial state and a final steady state, typically after a switch is thrown or a source changes.

### **A. First-Order Circuits: The Definition of Time Constant ($\\tau$)**

A first-order circuit (containing only one reactive component, $R$ and $C$ or $R$ and $L$) has a response governed by a first-order differential equation. Its transient behavior is characterized by a single value, the **time constant ($\\tau$)**.

The time constant is formally defined as the time required for the circuit's step response (voltage or current) to reach $1 \- 1/e$ (approximately 63.2%) of its final steady-state value as it "charges," or to decay to $1/e$ (approximately 36.8%) of its initial value as it "discharges".24 After five time constants ($5\\tau$), the transient response is considered to be complete, as the value is $\>99.3\\%$ of its final steady-state value.24

**The Series RC Circuit ($\\tau \= RC$)**

* **Formula:** $\\tau \= R \\times C$.30  
* Derivation (Charging): Applying Kirchhoff's Voltage Law (KVL) to a series RC circuit with a DC source $\\mathcal{E}$ yields $\\mathcal{E} \- V\_R \- V\_C \= 0$, or $\\mathcal{E} \- (dq/dt)R \- q/C \= 0$.32 The solution to this ODE for the capacitor voltage is:

  $$v\_C(t) \= \\mathcal{E}(1 \- e^{-t/RC})$$  
  24  
  At time $t \= \\tau \= RC$, the voltage is $v\_C(\\tau) \= \\mathcal{E}(1 \- e^{-1}) \\approx 0.632\\mathcal{E}$.

**The Series RL Circuit ($\\tau \= L/R$)**

* **Formula:** $\\tau \= L / R$.26  
* Derivation (Charging): KVL for a series RL circuit yields $\\mathcal{E} \- V\_R \- V\_L \= 0$, or $\\mathcal{E} \- IR \- L(dI/dt) \= 0$.29 The solution for the current is:

  $$I(t) \= \\frac{\\mathcal{E}}{R}(1 \- e^{-t/(L/R)})$$  
  28  
  At time $t \= \\tau \= L/R$, the current is $I(\\tau) \= I\_{final}(1 \- e^{-1}) \\approx 0.632 I\_{final}$.

The opposing forms of these two time constants ($RC$ vs. $L/R$) reveal a critical difference in how resistance affects them.34 The time constant represents the time required to dissipate the transient energy and reach a new steady state.

* In an **RC circuit**, the capacitor stores energy in a voltage. To change this voltage, charge must flow as current $I$. This current dissipates energy in the resistor ($P \= I^2R$). A *low* resistance $R$ allows a *high* current, which dissipates energy and changes the voltage *faster*. Thus, a smaller $R$ gives a shorter $\\tau$, and $\\tau$ is proportional to $R$.  
* In an **RL circuit**, the inductor stores energy in a current. This current creates a voltage drop across the resistor ($V\_R \= IR$) which dissipates power ($P \= V\_R^2/R$). To change the current *faster* (i.e., dissipate the stored magnetic energy faster), a *high* resistance $R$ is needed, as it will dissipate more power for a given current. Thus, a larger $R$ gives a shorter $\\tau$, and $\\tau$ is inversely proportional to $R$.34

### **B. Second-Order Circuits: Resonance and Natural Response**

When a circuit contains both an inductor and a capacitor, it is a second-order system described by a second-order differential equation.

The Ideal LC Circuit (Undamped)  
An ideal circuit with only $L$ and $C$ has no resistive element, and thus no mechanism for energy dissipation.23 Based on the mass-spring duality, the energy simply oscillates perpetually between the capacitor's E-field ($U\_C$) and the inductor's B-field ($U\_L$). This system does not have a time constant of decay; its defining characteristic is its undamped natural resonant frequency, $\\omega\_0$:

$$\\omega\_0 \= \\frac{1}{\\sqrt{LC}}$$  
23

The Source-Free Series RLC Circuit (Damped)  
In a real circuit, the presence of resistance $R$ (from a resistor or parasitic resistance in the wires and components) dissipates energy, causing the oscillations to decay. This decay is known as damping. The analysis of this circuit's natural response (its behavior with no external source, excited only by initially stored energy) is foundational.

1. Derivation: Applying KVL to the source-free series RLC circuit gives $V\_R \+ V\_L \+ V\_C \= 0$.

   $$Ri(t) \+ L\\frac{di}{dt} \+ \\frac{1}{C}\\int i(t)dt \= 0$$

   To remove the integral, the equation is differentiated with respect to time:

   $$L\\frac{d^2i}{dt^2} \+ R\\frac{di}{dt} \+ \\frac{1}{C}i \= 0$$

   Dividing by $L$ produces the standard form of a second-order homogeneous ODE 37:

   $$\\frac{d^2 i}{dt^2} \+ \\frac{R}{L} \\frac{di}{dt} \+ \\frac{1}{LC} i \= 0$$  
2. **Key Parameters:** This equation's behavior is defined by two key parameters derived from its coefficients 37:  
   * **Undamped Resonant Frequency ($\\omega\_0$):** $\\omega\_0 \= 1/\\sqrt{LC}$. This is the frequency at which the circuit would oscillate if $R=0$.  
   * **Neper Frequency ($\\alpha$):** $\\alpha \= R/(2L)$. This is the damping factor, which defines the *rate of decay* of the response.  
3. Characteristic Equation: Assuming a solution of the form $i(t) \= Ae^{st}$, we find the characteristic equation: $s^2 \+ (R/L)s \+ 1/LC \= 0$, or:

   $$s^2 \+ 2\\alpha s \+ \\omega\_0^2 \= 0$$  
   37  
   The roots of this equation, $s\_{1,2} \= \-\\alpha \\pm \\sqrt{\\alpha^2 \- \\omega\_0^2}$, are the circuit's natural frequencies and dictate its entire transient behavior.36  
4. **Analysis of Natural Response Regimes:** The three possible solution forms depend on the value of the discriminant $\\alpha^2 \- \\omega\_0^2$.  
   * **Case 1: Overdamped ($\\alpha \> \\omega\_0$)**  
     * **Condition:** The damping factor is greater than the resonant frequency. This occurs when $R \> 2\\sqrt{L/C}$. The resistance is large.  
     * **Roots:** The discriminant is positive, yielding two distinct, real, negative roots ($s\_1$, $s\_2$).36  
     * **Solution Form:** $i(t) \= A\_1e^{s\_1t} \+ A\_2e^{s\_2t}$.37 The response is a slow, non-oscillatory decay to zero, analogous to a car suspension that is too stiff.38  
   * **Case 2: Critically Damped ($\\alpha \= \\omega\_0$)**  
     * **Condition:** The damping factor is exactly equal to the resonant frequency. This occurs at the precise value $R \= 2\\sqrt{L/C}$.  
     * **Roots:** The discriminant is zero, yielding one real, negative, repeated root $s\_{1,2} \= \-\\alpha$.36  
     * **Solution Form:** $i(t) \= (A\_1 \+ A\_2t)e^{-\\alpha t}$.37 This response represents the *fastest possible return to zero without any oscillation*.38  
   * **Case 3: Underdamped ($\\alpha \< \\omega\_0$)**  
     * **Condition:** The damping factor is less than the resonant frequency. This occurs when $R \< 2\\sqrt{L/C}$. The resistance is small.  
     * **Roots:** The discriminant is negative, yielding a pair of complex conjugate roots $s\_{1,2} \= \-\\alpha \\pm j\\omega\_d$.36  
     * **Solution Form:** $i(t) \= e^{-\\alpha t} (B\_1 \\cos(\\omega\_d t) \+ B\_2 \\sin(\\omega\_d t))$.37 The response is a sinusoidal oscillation at the **damped resonant frequency** ($\\omega\_d \= \\sqrt{\\omega\_0^2 \- \\alpha^2}$), which is always lower than $\\omega\_0$. The amplitude of this oscillation decays exponentially according to the envelope $e^{-\\alpha t}$.38

The **Quality Factor ($Q$)** of the circuit is an alternative and common way to express this damping. It is defined as $Q \= \\omega\_0 / (2\\alpha)$.42

* For a **series** RLC circuit, $Q \= \\frac{\\omega\_0 L}{R} \= \\frac{1}{R}\\sqrt{\\frac{L}{C}}$.42  
* For a **parallel** RLC circuit, $\\alpha \= 1/(2RC)$, so $Q \= \\omega\_0 RC \= R\\sqrt{\\frac{C}{L}}$.42

A **high-Q** circuit has a very small $\\alpha$ (low damping), is highly **underdamped**, and will oscillate or "ring" for a long time.44 A **low-Q** circuit ($Q \< 1/2$) is **overdamped**.45

## **III. The Lumped-Element Model: Abstraction and Application**

The entirety of basic circuit theory, including KVL and KCL, is built upon the **lumped-element model** (also called the lumped-parameter abstraction). This model is not a fundamental law but rather a simplifying abstraction that is valid only when specific conditions are met.

### **A. Core Assumptions of the Lumped-Parameter Abstraction**

As articulated in standard engineering textbooks such as Nilsson & Riedel, the lumped-element model relies on three fundamental assumptions 46:

1. **Instantaneous Propagation:** The electrical effects (voltage and current waves) are assumed to propagate instantaneously throughout the entire circuit. This means the physical dimensions of the circuit are negligible compared to the signal wavelength.  
2. **Zero Net Charge:** The net charge on every component in the system is always zero. Components cannot accumulate a net excess of charge (though capacitors, by definition, hold equal and opposite separated charges).  
3. **No Inter-Component Coupling:** There is no magnetic coupling *between* components. Magnetic coupling *within* a component (like a transformer or inductor) is permissible, as it is part of that component's lumped definition.

When these assumptions hold, complex electromagnetic field problems are simplified to the algebraic and differential equations of circuit theory.

### **B. Lumping Ideal Components in Series and Parallel (Uncoupled)**

When components are uncoupled (Assumption 3 holds), they can be combined into single equivalent components. The rules for inductors and capacitors are, notably, an inverse of each other.47

**Capacitors in Parallel**

* **Formula:** $C\_{eq} \= C\_1 \+ C\_2 \+ C\_3 \+ \\dots$ 47  
* **Derivation:** Components in parallel share the same voltage $V$. The total charge stored is the sum of the individual charges: $Q\_{total} \= Q\_1 \+ Q\_2 \+ \\dots$.50 Substituting $Q=CV$ gives $C\_{eq}V \= C\_1V \+ C\_2V \+ \\dots$. Canceling the common $V$ term yields the formula.48  
* **Physical Basis:** Connecting capacitors in parallel is physically equivalent to summing their plate areas, which directly increases capacitance.47

**Capacitors in Series**

* **Formula:** $\\frac{1}{C\_{eq}} \= \\frac{1}{C\_1} \+ \\frac{1}{C\_2} \+ \\frac{1}{C\_3} \+ \\dots$ 48  
* **Derivation:** Components in series must all store the same charge $Q$ (due to conservation of charge on the isolated internal plates).53 The total voltage is the sum of the individual voltages: $V\_{total} \= V\_1 \+ V\_2 \+ \\dots$.50 Substituting $V=Q/C$ gives $Q/C\_{eq} \= Q/C\_1 \+ Q/C\_2 \+ \\dots$. Canceling the common $Q$ term yields the formula.49  
* **Physical Basis:** Connecting capacitors in series is physically equivalent to summing their dielectric thicknesses (plate spacing), which directly decreases capacitance.47

**Inductors in Series (Uncoupled)**

* **Formula:** $L\_{eq} \= L\_1 \+ L\_2 \+ L\_3 \+ \\dots$ 54  
* **Derivation:** Components in series share the same current $I$ and thus the same rate of change of current, $di/dt$. The total voltage is the sum of the individual voltages: $V\_{total} \= V\_1 \+ V\_2 \+ \\dots \= L\_1\\frac{di}{dt} \+ L\_2\\frac{di}{dt} \+ \\dots \= (L\_1+L\_2+\\dots)\\frac{di}{dt}$. Therefore, $L\_{eq} \= L\_1 \+ L\_2 \+ \\dots$.55

**Inductors in Parallel (Uncoupled)**

* **Formula:** $\\frac{1}{L\_{eq}} \= \\frac{1}{L\_1} \+ \\frac{1}{L\_2} \+ \\frac{1}{L\_3} \+ \\dots$ 54  
* **Derivation:** Components in parallel share the same voltage $V$. The total current is the sum of the individual currents, $I\_{total} \= I\_1 \+ I\_2 \+ \\dots$, so $\\frac{di\_{total}}{dt} \= \\frac{di\_1}{dt} \+ \\frac{di\_2}{dt} \+ \\dots$. Substituting $\\frac{di}{dt} \= V/L$ gives $\\frac{di\_{total}}{dt} \= \\frac{V}{L\_1} \+ \\frac{V}{L\_2} \+ \\dots \= V(\\frac{1}{L\_1}+\\frac{1}{L\_2}+\\dots)$. Since $\\frac{di\_{total}}{dt} \= V/L\_{eq}$, the formula is derived.55

### **C. Modeling Coupled Components: Mutual Inductance**

The simple lumping formulas fail when Assumption 3 is violated, i.e., when the magnetic field (flux) from one inductor links the coils of another.57 This effect is quantified by the **mutual inductance, $M$**.58

The Dot Convention  
To account for the polarity of mutually-induced voltages, the dot convention is used. A dot is placed on one terminal of each coupled coil.57

* **Rule:** A current *entering* the dotted terminal of one coil induces a voltage in the second coil that is *positive* at the dotted terminal of the second coil.60  
* **Conversely:** A current *leaving* a dotted terminal induces a voltage in the second coil that is *negative* at its dotted terminal.61

Lumping Series-Coupled Inductors  
When mutually-coupled inductors are in series, the mutual voltage $M(di/dt)$ either adds to or subtracts from the self-inductance $L(di/dt)$.

1. Series-Aiding: The series current enters (or leaves) both dotted terminals. The self-induced and mutually-induced fluxes add.57 The total induced voltage is $V \= (L\_1 \+ M)\\frac{di}{dt} \+ (L\_2 \+ M)\\frac{di}{dt}$.

   $$L\_{eq} \= L\_1 \+ L\_2 \+ 2M$$  
   57  
2. Series-Opposing: The current enters one dotted terminal and leaves the other. The fluxes oppose each other.63 The total induced voltage is $V \= (L\_1 \- M)\\frac{di}{dt} \+ (L\_2 \- M)\\frac{di}{dt}$.

   $$L\_{eq} \= L\_1 \+ L\_2 \- 2M$$  
   57

Lumping Parallel-Coupled Inductors  
The equivalent inductance for parallel-coupled coils is more complex 60:

1. **Parallel-Aiding** (Dots on the same side): $L\_{eq} \= \\frac{L\_1L\_2 \- M^2}{L\_1 \+ L\_2 \- 2M}$ 60  
2. **Parallel-Opposing** (Dots on opposite sides): $L\_{eq} \= \\frac{L\_1L\_2 \- M^2}{L\_1 \+ L\_2 \+ 2M}$ 60

In these cases, the components *cannot* be modeled independently. Their mutual interaction $M$ is a critical, non-negligible part of the lumped model.

## **IV. Failure of the Lumped-Element Model: When Components Must Be Modeled Independently**

The question of when components can be "lumped" versus when they "must be modeled independently" is a question of model validity. The simple lumped-element model fails at high frequencies. This failure occurs in a hierarchy of stages, from the non-ideality of a single component to the failure of the abstraction itself.

### **A. Stage 1: Component Non-Ideality (Parasitics)**

At high frequencies, an ideal component model ($C$ or $L$) is no longer accurate. Any real component is, in fact, a complex RLC network due to its physical construction.67

The Real Capacitor Model  
A real capacitor is modeled as an ideal capacitor $C$ in series with two parasitic elements 69:

* **Equivalent Series Resistance (ESR, or $R\_S$):** The resistance of the capacitor's leads and plates.67 This is a critical parameter in power supplies, as it causes $I^2R$ power loss (heat) from ripple currents.70  
* **Equivalent Series Inductance (ESL, or $L\_S$):** The self-inductance of the capacitor's physical structure, including its leads and internal plates.69 At high frequencies, this inductance becomes the dominant source of impedance.70

The Real Inductor Model  
A real inductor is modeled as an ideal inductor $L$ in series with an ESR (representing the winding resistance), with this entire series branch in parallel with 73:

* **Equivalent Parallel Capacitance (EPC, or $C\_P$):** Also known as parasitic or stray capacitance, this is the unavoidable capacitance that exists *between the turns* of the inductor's winding.74

### **B. The Consequence of Parasitics: Self-Resonant Frequency (SRF)**

The combination of a component's ideal property and its primary parasitic ($C$ with ESL, $L$ with EPC) creates a built-in resonant circuit. The frequency at which this resonance occurs is the **Self-Resonant Frequency (SRF)**, and it marks the boundary of the component's intended operation.

**Capacitor SRF**

* **Mechanism:** The ideal capacitance $C$ and the parasitic $ESL$ form a *series RLC circuit*.68  
* **Frequency:** $f\_{SRF} \= 1 / (2\\pi\\sqrt{ESL \\times C})$.68  
* **Impedance Behavior:** A capacitor's impedance plot versus frequency is a characteristic "V" shape.72  
  * **Below SRF:** The impedance is dominated by the capacitance ($Z \\approx X\_C \= 1/\\omega C$). The component *acts as a capacitor*.  
  * **At SRF:** The capacitive reactance $X\_C$ and inductive reactance $X\_L$ cancel each other. The impedance is at its **absolute minimum**, $Z \= ESR$.70 This is exploited in decoupling, where a capacitor is chosen with an SRF at the noise frequency it needs to shunt to ground.  
  * **Above SRF:** The impedance is dominated by the ESL ($Z \\approx X\_L \= \\omega \\times ESL$). The component *acts as an inductor*.68

**Inductor SRF**

* **Mechanism:** The ideal inductance $L$ and the parasitic $EPC$ form a *parallel RLC circuit* (a tank circuit).73  
* **Frequency:** $f\_{SRF} \= 1 / (2\\pi\\sqrt{L \\times EPC})$.73  
* **Impedance Behavior:** An inductor's impedance plot is an "A" or inverted-V shape.  
  * **Below SRF:** The impedance is dominated by the inductance ($Z \\approx X\_L \= \\omega L$). The component *acts as an inductor*.  
  * **At SRF:** The parallel $LC$ tank circuit resonates, and the impedance is at its **absolute maximum**.77 This is exploited in EMI filtering, where an inductor (or ferrite bead) is chosen with an SRF at the frequency it needs to *block*.  
  * **Above SRF:** The impedance is dominated by the EPC ($Z \\approx X\_C \= 1/\\omega \\times EPC$). The component *acts as a capacitor*.75

**Modeling Implication:** This is the primary answer to when components must be modeled independently. A lumped $C\_{eq} \= C\_1 \+ C\_2$ model is physically meaningless if the operating frequency is above the SRF of $C\_1$, because $C\_1$ is behaving as an inductor. In high-frequency design, components *must* be modeled independently using their full parasitic (R-L-C) equivalent circuits.

### **C. Stage 2: Physical Conductor Limitations**

Even below SRF, the simple $R$ and $L$ values used in lumped models become inaccurate because they are frequency-dependent.

* **Skin Effect:** At high frequencies, AC current flows in a thin "skin" on the conductor's surface, abandoning the center. This reduces the effective cross-sectional area and *increases* the AC resistance $R(f)$.84  
* **Proximity Effect:** In a coil or near another conductor, the magnetic field of the neighboring wire forces the current to crowd into an even smaller area. This further *increases* the AC resistance.84

**Modeling Implication:** The parameters $\\alpha \= R/(2L)$ and $\\tau \= L/R$ are no longer constants. The resistance $R$ is now $R(f)$, a function of frequency. This greatly complicates transient and AC analysis and requires more advanced modeling, often using R-L ladder circuits to approximate the frequency-dependent behavior.87

### **D. Stage 3: Failure of the Lumped-Element Abstraction Itself**

The ultimate failure occurs when the model's core assumption (Assumption 1: instantaneous propagation) is violated.46

* **The Wavelength Boundary:** Electrical signals do not propagate instantaneously. They travel at the speed of light in the medium, $v \= c/\\sqrt{\\epsilon\_r}$, which is a finite velocity.88 This means a signal has a physical wavelength, $\\lambda \= v/f$.89  
* **The Rule of Thumb:** The lumped-element model (and KVL/KCL) is valid only as long as the circuit's largest physical dimension $d$ is *much smaller* than the signal's wavelength $\\lambda$. The model fails when $d$ becomes a significant fraction of $\\lambda$.88  
  * **The $\\lambda/10$ Rule:** A common industry rule of thumb is that the lumped-element model breaks down when $d \> \\lambda/10$.91  
  * **Example:** A 1-meter-long wire has a propagation delay of roughly 3.3 ns. At a frequency of $f \\approx 300$ MHz, the wavelength is $\\lambda \\approx 1$ m. KVL, which assumes the voltage at both ends of the wire is the same at the same instant, is now invalid. The wire must be modeled as a transmission line.88  
* **The Alternative: Distributed-Element Model:** When $d \> \\lambda/10$, the lumped-element abstraction must be abandoned entirely. The circuit must be modeled as a **distributed element** (e.g., a transmission line, microstrip, or waveguide).92  
  * In this model, $L$ and $C$ are not single components but are properties *distributed* per unit length (e.g., Henries/meter, Farads/meter).  
  * The governing equations cease to be Ordinary Differential Equations (ODEs) and become Partial Differential Equations (PDEs), known as the Telegrapher's Equations, because voltage and current are functions of both *space and time*: $V(x, t)$ and $I(x, t)$.89

In summary, components must be modeled independently (using their parasitic models) when $f \\to f\_{SRF}$, and the entire lumped-element *model* must be abandoned for a distributed-element model when $d \\to \\lambda/10$.

## **V. Authoritative Definitions and Reference Data**

For precise engineering, formal definitions from standards bodies and citable material property data are essential.

### **A. Table 1: Authoritative Definitions (IEC/IEEE)**

| Term | Standard | Definition |
| :---- | :---- | :---- |
| **Capacitance ($C$)** | **IEC 60050, IEV 131-12-13** | "for a capacitive two-terminal element... quotient of the electric charge $q\_{AB}$ on the terminals by the voltage $u\_{AB}$ between them. $C \= q\_{AB} / u\_{AB}$".95 Note: A capacitance cannot be negative. |
| **Inductance ($L$)** | **IEC 60050, IEV 131-12-19** | "for an inductive two-terminal element... quotient of the total flux $\\Psi\_{AB}$ between the terminals by the electric current $i$ in the element. $L \= \\Psi\_{AB} / i$".96 Note: An inductance cannot be negative. |
| **Time Constant ($\\tau$)** | **General (Physics/Eng.)** | The time required for a system's step response to reach $1 \- 1/e$ (approximately 63.2%) of its final (asymptotic) value, or to decay to $1/e$ (approx. 36.8%) of its initial value.97 |
| **Lumped-Parameter System** | **Nilsson & Riedel (Textbook Standard)** | A system in which "the electrical effects occur instantaneously throughout the system." This assumption is met when the physical dimensions of the system are very small compared to the signal wavelength.46 |

### **B. Table 2: Relative Permittivity ($\\epsilon\_r$, or $k$) of Common Dielectrics**

The relative permittivity (dielectric constant) $\\epsilon\_r$ is the ratio of a material's permittivity to the vacuum permittivity $\\epsilon\_0$. It is the primary material property governing capacitance.

| Material | Dielectric Constant (ϵr​=k) | Source(s) |
| :---- | :---- | :---- |
| Vacuum | 1.0 (by definition) | 98 |
| Air (1 atm) | 1.00059 | 98 |
| Teflon (PTFE) | 2.1 | 98 |
| Polyethylene | 2.25 | 98 |
| Mylar (Polyester) | 3.1 – 3.2 | 98 |
| Glass | 5 – 10 | 98 |
| Mica | 3 – 8 | 98 |
| Ceramic (Alumina, Al$\_2$O$\_3$) | 8.8 – 10.0 | 99 |
| Tantalum Pentoxide (Ta$\_2$O$\_5$) | 22 – 25 (Amorphous) | 101 |
| Water (20°C) | 80.4 | 98 |
| Strontium Titanate | 310 | 98 |

### **C. Table 3: Relative Permeability ($\\mu\_r$) of Common Core Materials**

The relative permeability $\\mu\_r$ is the ratio of a material's permeability to the vacuum permeability $\\mu\_0$. It is the primary material property governing inductance. The choice of material involves a critical trade-off between achieving high permeability and operability at high frequencies.

| Core Material | Typical Relative Permeability (μr​) | Typical Frequency Range | Source(s) |
| :---- | :---- | :---- | :---- |
| Air/Vacuum | 1 (by definition) | N/A |  |
| Iron Powder | 15 – 200 | Low-to-Mid (DC – \~100s kHz) | 105 |
| Molypermalloy Powder (MPP) | 14 – 550 | Mid (DC – \~500 kHz) | 107 |
| **NiZn Ferrite** (Nickel-Zinc) | 40 – 2,000 | **High** (1 MHz – \>100s MHz) | 106 |
| **MnZn Ferrite** (Manganese-Zinc) | 1,000 – 20,000 | **Low** (10 kHz – \~5 MHz) | 106 |
| Electrical Steel | 2,000 – 38,000 | Very Low (50/60 Hz) | 107 |
| Iron (99.8% pure) | \~5,000 | Very Low (DC) | 107 |

#### **Works cited**

1. accessed October 29, 2025, [https://phys.libretexts.org/Bookshelves/University\_Physics/University\_Physics\_(OpenStax)/University\_Physics\_II\_-\_Thermodynamics\_Electricity\_and\_Magnetism\_(OpenStax)/08%3A\_Capacitance/8.04%3A\_Energy\_Stored\_in\_a\_Capacitor\#:\~:text=The%20energy%20stored%20in%20a%20capacitor%20is%20electrostatic%20potential%20energy,the%20electrical%20field%20builds%20up.](https://phys.libretexts.org/Bookshelves/University_Physics/University_Physics_\(OpenStax\)/University_Physics_II_-_Thermodynamics_Electricity_and_Magnetism_\(OpenStax\)/08%3A_Capacitance/8.04%3A_Energy_Stored_in_a_Capacitor#:~:text=The%20energy%20stored%20in%20a%20capacitor%20is%20electrostatic%20potential%20energy,the%20electrical%20field%20builds%20up.)  
2. Capacitor \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Capacitor](https://en.wikipedia.org/wiki/Capacitor)  
3. 8.4: Energy Stored in a Capacitor \- Physics LibreTexts, accessed October 29, 2025, [https://phys.libretexts.org/Bookshelves/University\_Physics/University\_Physics\_(OpenStax)/University\_Physics\_II\_-\_Thermodynamics\_Electricity\_and\_Magnetism\_(OpenStax)/08%3A\_Capacitance/8.04%3A\_Energy\_Stored\_in\_a\_Capacitor](https://phys.libretexts.org/Bookshelves/University_Physics/University_Physics_\(OpenStax\)/University_Physics_II_-_Thermodynamics_Electricity_and_Magnetism_\(OpenStax\)/08%3A_Capacitance/8.04%3A_Energy_Stored_in_a_Capacitor)  
4. Energy Stored on a Capacitor \- HyperPhysics, accessed October 29, 2025, [http://hyperphysics.phy-astr.gsu.edu/hbase/electric/capeng.html](http://hyperphysics.phy-astr.gsu.edu/hbase/electric/capeng.html)  
5. How is energy "stored in an electric field"? \[duplicate\] \- Physics Stack Exchange, accessed October 29, 2025, [https://physics.stackexchange.com/questions/714872/how-is-energy-stored-in-an-electric-field](https://physics.stackexchange.com/questions/714872/how-is-energy-stored-in-an-electric-field)  
6. Energy of a capacitor derivation, and energy of a capacitor formulas: 1/2CV^2, 1/2Q^2/C, 1/2QV. \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=pNrDXCXWD\_4](https://www.youtube.com/watch?v=pNrDXCXWD_4)  
7. Energy Stored in Capacitors | Physics \- Lumen Learning, accessed October 29, 2025, [https://courses.lumenlearning.com/suny-physics/chapter/19-7-energy-stored-in-capacitors/](https://courses.lumenlearning.com/suny-physics/chapter/19-7-energy-stored-in-capacitors/)  
8. Energy Stored in a Capacitor | CK-12 Foundation, accessed October 29, 2025, [https://flexbooks.ck12.org/cbook/ck-12-cbse-physics-class-12/section/2.13/primary/lesson/energy-stored-in-a-capacitor/](https://flexbooks.ck12.org/cbook/ck-12-cbse-physics-class-12/section/2.13/primary/lesson/energy-stored-in-a-capacitor/)  
9. E \= 1/2 cv^2 \- (Intro to Electrical Engineering) \- Vocab, Definition, Explanations | Fiveable, accessed October 29, 2025, [https://fiveable.me/key-terms/introduction-electrical-systems-engineering-devices/e-=-12-cv%5E2](https://fiveable.me/key-terms/introduction-electrical-systems-engineering-devices/e-=-12-cv%5E2)  
10. Need help with understanding W=1/2CV^2 : r/AskPhysics \- Reddit, accessed October 29, 2025, [https://www.reddit.com/r/AskPhysics/comments/gi4hia/need\_help\_with\_understanding\_w12cv2/](https://www.reddit.com/r/AskPhysics/comments/gi4hia/need_help_with_understanding_w12cv2/)  
11. Energy Stored in an Inductor \- HyperPhysics Concepts, accessed October 29, 2025, [http://hyperphysics.phy-astr.gsu.edu/hbase/electric/indeng.html](http://hyperphysics.phy-astr.gsu.edu/hbase/electric/indeng.html)  
12. Magnetic Fields and Inductance | Inductors | Electronics Textbook \- All About Circuits, accessed October 29, 2025, [https://www.allaboutcircuits.com/textbook/direct-current/chpt-15/magnetic-fields-and-inductance/](https://www.allaboutcircuits.com/textbook/direct-current/chpt-15/magnetic-fields-and-inductance/)  
13. accessed October 29, 2025, [https://www.ersaelectronics.com/blog/how-inductors-store-energy\#:\~:text=The%20basic%20principle%20behind%20the,the%20form%20of%20magnetic%20flux.](https://www.ersaelectronics.com/blog/how-inductors-store-energy#:~:text=The%20basic%20principle%20behind%20the,the%20form%20of%20magnetic%20flux.)  
14. Energy Stored in an Inductor \- Richard Fitzpatrick, accessed October 29, 2025, [https://farside.ph.utexas.edu/teaching/316/lectures/node103.html](https://farside.ph.utexas.edu/teaching/316/lectures/node103.html)  
15. Inductor \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Inductor](https://en.wikipedia.org/wiki/Inductor)  
16. Inductance \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Inductance](https://en.wikipedia.org/wiki/Inductance)  
17. 14.4: Energy in a Magnetic Field \- Physics LibreTexts, accessed October 29, 2025, [https://phys.libretexts.org/Bookshelves/University\_Physics/University\_Physics\_(OpenStax)/University\_Physics\_II\_-\_Thermodynamics\_Electricity\_and\_Magnetism\_(OpenStax)/14%3A\_Inductance/14.04%3A\_Energy\_in\_a\_Magnetic\_Field](https://phys.libretexts.org/Bookshelves/University_Physics/University_Physics_\(OpenStax\)/University_Physics_II_-_Thermodynamics_Electricity_and_Magnetism_\(OpenStax\)/14%3A_Inductance/14.04%3A_Energy_in_a_Magnetic_Field)  
18. Energy in a Magnetic Field \- Electronics Tutorials, accessed October 29, 2025, [https://www.electronics-tutorials.ws/electromagnetism/energy-in-a-magnetic-field.html](https://www.electronics-tutorials.ws/electromagnetism/energy-in-a-magnetic-field.html)  
19. Derivation of energy stored in a inductor connected across ac \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=qV9Cb0w1Sis](https://www.youtube.com/watch?v=qV9Cb0w1Sis)  
20. 22.4: Magnetic Fields and Maxwell Revisited \- Physics LibreTexts, accessed October 29, 2025, [https://phys.libretexts.org/Bookshelves/University\_Physics/Physics\_(Boundless)/22%3A\_Induction\_AC\_Circuits\_and\_Electrical\_Technologies/22.4%3A\_Magnetic\_Fields\_and\_Maxwell\_Revisited](https://phys.libretexts.org/Bookshelves/University_Physics/Physics_\(Boundless\)/22%3A_Induction_AC_Circuits_and_Electrical_Technologies/22.4%3A_Magnetic_Fields_and_Maxwell_Revisited)  
21. accessed October 29, 2025, [https://www.khanacademy.org/science/in-in-class-12th-physics-india/in-in-electromagnetic-induction/x51bd77206da864f3:self-inductance/v/energy-stored-in-inductor-1-2-li-2\#:\~:text=An%20inductor%20carrying%20current%20is,1%2F2%20Li%5E2.](https://www.khanacademy.org/science/in-in-class-12th-physics-india/in-in-electromagnetic-induction/x51bd77206da864f3:self-inductance/v/energy-stored-in-inductor-1-2-li-2#:~:text=An%20inductor%20carrying%20current%20is,1%2F2%20Li%5E2.)  
22. Energy stored in inductor (1/2 Li^2) | Electromagnetic induction | Physics | Khan Academy, accessed October 29, 2025, [https://www.youtube.com/watch?v=aBrUYUO09uM](https://www.youtube.com/watch?v=aBrUYUO09uM)  
23. LC circuit \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/LC\_circuit](https://en.wikipedia.org/wiki/LC_circuit)  
24. Understanding RC Circuit Operation and Time Constant \- Technical Articles \- EEPower, accessed October 29, 2025, [https://eepower.com/technical-articles/understanding-rc-circuit-operation-and-time-constant/](https://eepower.com/technical-articles/understanding-rc-circuit-operation-and-time-constant/)  
25. Tau \- The Time Constant of an RC Circuit \- Electronics Tutorials, accessed October 29, 2025, [https://www.electronics-tutorials.ws/rc/time-constant.html](https://www.electronics-tutorials.ws/rc/time-constant.html)  
26. The Art of Calculating Time Constants in RC and RL Circuits \- Used Keysight Equipment, accessed October 29, 2025, [https://www.keysight.com/used/us/en/knowledge/formulas/time-constant-formula](https://www.keysight.com/used/us/en/knowledge/formulas/time-constant-formula)  
27. \[Solved\] The time constant of R-L series circuit may be defined as th \- Testbook, accessed October 29, 2025, [https://testbook.com/question-answer/the-time-constant-of-r-l-series-circuit-may-be-def--622850506132a6e37a27dbbd](https://testbook.com/question-answer/the-time-constant-of-r-l-series-circuit-may-be-def--622850506132a6e37a27dbbd)  
28. 23.1: RL Circuits \- Physics LibreTexts, accessed October 29, 2025, [https://phys.libretexts.org/Bookshelves/College\_Physics/College\_Physics\_1e\_(OpenStax)/23%3A\_Electromagnetic\_Induction\_AC\_Circuits\_and\_Electrical\_Technologies/23.01%3A\_RL\_Circuits](https://phys.libretexts.org/Bookshelves/College_Physics/College_Physics_1e_\(OpenStax\)/23%3A_Electromagnetic_Induction_AC_Circuits_and_Electrical_Technologies/23.01%3A_RL_Circuits)  
29. Understanding RL Circuit Operation and Time Constant \- Technical Articles \- EEPower, accessed October 29, 2025, [https://eepower.com/technical-articles/understanding-rl-circuit-operation-and-time-constant/](https://eepower.com/technical-articles/understanding-rl-circuit-operation-and-time-constant/)  
30. accessed October 29, 2025, [https://www.allaboutcircuits.com/textbook/direct-current/chpt-16/voltage-current-calculations/\#:\~:text=In%20a%20series%20RC%20circuit,the%20total%20resistance%20in%20ohms.](https://www.allaboutcircuits.com/textbook/direct-current/chpt-16/voltage-current-calculations/#:~:text=In%20a%20series%20RC%20circuit,the%20total%20resistance%20in%20ohms.)  
31. RC time constant \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/RC\_time\_constant](https://en.wikipedia.org/wiki/RC_time_constant)  
32. 10.6: RC Circuits \- Physics LibreTexts, accessed October 29, 2025, [https://phys.libretexts.org/Bookshelves/University\_Physics/University\_Physics\_(OpenStax)/University\_Physics\_II\_-\_Thermodynamics\_Electricity\_and\_Magnetism\_(OpenStax)/10%3A\_Direct-Current\_Circuits/10.06%3A\_RC\_Circuits](https://phys.libretexts.org/Bookshelves/University_Physics/University_Physics_\(OpenStax\)/University_Physics_II_-_Thermodynamics_Electricity_and_Magnetism_\(OpenStax\)/10%3A_Direct-Current_Circuits/10.06%3A_RC_Circuits)  
33. accessed October 29, 2025, [https://www.keysight.com/used/us/en/knowledge/formulas/time-constant-formula\#:\~:text=For%20an%20RL%20(Resistor%2DInductor,responds%20to%20changes%20in%20input.](https://www.keysight.com/used/us/en/knowledge/formulas/time-constant-formula#:~:text=For%20an%20RL%20\(Resistor%2DInductor,responds%20to%20changes%20in%20input.)  
34. Why L/R and not LR? | RC and L/R Time Constants | Electronics Textbook, accessed October 29, 2025, [https://www.allaboutcircuits.com/textbook/direct-current/chpt-16/why-l-r-and-not-lr/](https://www.allaboutcircuits.com/textbook/direct-current/chpt-16/why-l-r-and-not-lr/)  
35. Resonance Frequency Formula: The Comprehensive Guide for Engineers \- Keysight, accessed October 29, 2025, [https://www.keysight.com/used/us/en/knowledge/formulas/resonance-frequency-formula](https://www.keysight.com/used/us/en/knowledge/formulas/resonance-frequency-formula)  
36. RLC natural response \- variations (article) \- Khan Academy, accessed October 29, 2025, [https://www.khanacademy.org/science/electrical-engineering/ee-circuit-analysis-topic/ee-natural-and-forced-response/a/ee-rlc-natural-response-variations](https://www.khanacademy.org/science/electrical-engineering/ee-circuit-analysis-topic/ee-natural-and-forced-response/a/ee-rlc-natural-response-variations)  
37. Alexander-Sadiku, accessed October 29, 2025, [http://doctord.webhop.net/courses/Textbooks/Alexander-Sadiku/AlexanderCh08finalR1.pdf](http://doctord.webhop.net/courses/Textbooks/Alexander-Sadiku/AlexanderCh08finalR1.pdf)  
38. Overdamped, Critically Damped, and Underdamped Responses | Electrical Circuits and Systems I Class Notes | Fiveable, accessed October 29, 2025, [https://fiveable.me/electrical-circuits-systems-i/unit-8/overdamped-critically-damped-underdamped-responses/study-guide/3Kut6OoBfBICRbvX](https://fiveable.me/electrical-circuits-systems-i/unit-8/overdamped-critically-damped-underdamped-responses/study-guide/3Kut6OoBfBICRbvX)  
39. Underdamped, Overdamped, and Critically Damped Spring Mass Damper System \- Mitchal Dichter, accessed October 29, 2025, [https://mitchaldichter.com/under\_over\_critically\_damped.html](https://mitchaldichter.com/under_over_critically_damped.html)  
40. 14.10.2: Second-order Differential Equations \- Engineering LibreTexts, accessed October 29, 2025, [https://eng.libretexts.org/Bookshelves/Introductory\_Engineering/EGR\_1010%3A\_Introduction\_to\_Engineering\_for\_Engineers\_and\_Scientists/14%3A\_Fundamentals\_of\_Engineering/14.10%3A\_Differential\_equations/14.10.02%3A\_Second-order\_Differential\_Equations](https://eng.libretexts.org/Bookshelves/Introductory_Engineering/EGR_1010%3A_Introduction_to_Engineering_for_Engineers_and_Scientists/14%3A_Fundamentals_of_Engineering/14.10%3A_Differential_equations/14.10.02%3A_Second-order_Differential_Equations)  
41. 18.03SCF11 text: Under, Over and Critical Damping \- MIT OpenCourseWare, accessed October 29, 2025, [https://ocw.mit.edu/courses/18-03sc-differential-equations-fall-2011/7e212064ad281d00e1dac893b1f722a7\_MIT18\_03SCF11\_s13\_2text.pdf](https://ocw.mit.edu/courses/18-03sc-differential-equations-fall-2011/7e212064ad281d00e1dac893b1f722a7_MIT18_03SCF11_s13_2text.pdf)  
42. Circuit Theory/RLC Circuits \- Wikibooks, open books for an open world, accessed October 29, 2025, [https://en.wikibooks.org/wiki/Circuit\_Theory/RLC\_Circuits](https://en.wikibooks.org/wiki/Circuit_Theory/RLC_Circuits)  
43. What is time constant in LC circuit? \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/321156/what-is-time-constant-in-lc-circuit](https://electronics.stackexchange.com/questions/321156/what-is-time-constant-in-lc-circuit)  
44. RLC circuit \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/RLC\_circuit](https://en.wikipedia.org/wiki/RLC_circuit)  
45. Q Factor and its Relevance in Electrical Circuits \- Electronics For You, accessed October 29, 2025, [https://www.electronicsforu.com/technology-trends/learn-electronics/q-factor-relevance-electrical-circuits](https://www.electronicsforu.com/technology-trends/learn-electronics/q-factor-relevance-electrical-circuits)  
46. James W. Nilsson, Susan Riedel-Electric Circuits-Prentice Hall (2014).pdf, accessed October 29, 2025, [https://wp.kntu.ac.ir/dfard/ebook/ec/James%20W.%20Nilsson,%20Susan%20Riedel-Electric%20Circuits-Prentice%20Hall%20(2014).pdf](https://wp.kntu.ac.ir/dfard/ebook/ec/James%20W.%20Nilsson,%20Susan%20Riedel-Electric%20Circuits-Prentice%20Hall%20\(2014\).pdf)  
47. Series and Parallel Capacitors | Capacitors | Electronics Textbook, accessed October 29, 2025, [https://www.allaboutcircuits.com/textbook/direct-current/chpt-13/series-and-parallel-capacitors/](https://www.allaboutcircuits.com/textbook/direct-current/chpt-13/series-and-parallel-capacitors/)  
48. Capacitors in Series and Parallel | Physics \- Lumen Learning, accessed October 29, 2025, [https://courses.lumenlearning.com/suny-physics/chapter/19-6-capacitors-in-series-and-parallel/](https://courses.lumenlearning.com/suny-physics/chapter/19-6-capacitors-in-series-and-parallel/)  
49. 8.2 Capacitors in Series and in Parallel – University Physics Volume 2 \- UCF Pressbooks, accessed October 29, 2025, [https://pressbooks.online.ucf.edu/osuniversityphysics2/chapter/capacitors-in-series-and-in-parallel/](https://pressbooks.online.ucf.edu/osuniversityphysics2/chapter/capacitors-in-series-and-in-parallel/)  
50. Capacitors in Series & Parallel (Cambridge (CIE) A Level Physics): Revision Note, accessed October 29, 2025, [https://www.savemyexams.com/a-level/physics/cie/25/revision-notes/19-capacitance/19-1-capacitors-and-capacitance/derivation-of-c-equals-qv/](https://www.savemyexams.com/a-level/physics/cie/25/revision-notes/19-capacitance/19-1-capacitors-and-capacitance/derivation-of-c-equals-qv/)  
51. 8.3: Capacitors in Series and in Parallel \- Physics LibreTexts, accessed October 29, 2025, [https://phys.libretexts.org/Bookshelves/University\_Physics/University\_Physics\_(OpenStax)/University\_Physics\_II\_-\_Thermodynamics\_Electricity\_and\_Magnetism\_(OpenStax)/08%3A\_Capacitance/8.03%3A\_Capacitors\_in\_Series\_and\_in\_Parallel](https://phys.libretexts.org/Bookshelves/University_Physics/University_Physics_\(OpenStax\)/University_Physics_II_-_Thermodynamics_Electricity_and_Magnetism_\(OpenStax\)/08%3A_Capacitance/8.03%3A_Capacitors_in_Series_and_in_Parallel)  
52. Chapter 5 Capacitance and Dielectrics, accessed October 29, 2025, [https://www2.tntech.edu/leap/murdock/books/v4chap5.pdf](https://www2.tntech.edu/leap/murdock/books/v4chap5.pdf)  
53. Capacitors in Series and in Parallel \- University Physics Volume 2, accessed October 29, 2025, [https://www.theexpertta.com/book-files/OpenStaxUniversityPhysicsVol2/UP2\_8.2.%20Capacitors%20in%20Series%20and%20in%20Parallel\_pg355-361.pdf](https://www.theexpertta.com/book-files/OpenStaxUniversityPhysicsVol2/UP2_8.2.%20Capacitors%20in%20Series%20and%20in%20Parallel_pg355-361.pdf)  
54. Series-Parallel Combinations of Capacitors and Inductors \- Engineering | USU \- Utah State University, accessed October 29, 2025, [https://engineering.usu.edu/students/tutoring/topics/electric-circuits/seriesparallel-combinations-of-capacitors-and-inductors](https://engineering.usu.edu/students/tutoring/topics/electric-circuits/seriesparallel-combinations-of-capacitors-and-inductors)  
55. Series and Parallel Inductors | Inductors | Electronics Textbook, accessed October 29, 2025, [https://www.allaboutcircuits.com/textbook/direct-current/chpt-15/series-and-parallel-inductors/](https://www.allaboutcircuits.com/textbook/direct-current/chpt-15/series-and-parallel-inductors/)  
56. Inductance Formula: Know its Definition, Formula, Solved Examples \- Testbook, accessed October 29, 2025, [https://testbook.com/physics-formulas/inductance-formula](https://testbook.com/physics-formulas/inductance-formula)  
57. Lectures notes Mutually coupled inductors.pdf, accessed October 29, 2025, [https://www.uni-ruse.bg/disciplines/TE/Lecture%20notes/Lectures%20notes%20Mutually%20coupled%20inductors.pdf](https://www.uni-ruse.bg/disciplines/TE/Lecture%20notes/Lectures%20notes%20Mutually%20coupled%20inductors.pdf)  
58. Series and Parallel Inductor \- GeeksforGeeks, accessed October 29, 2025, [https://www.geeksforgeeks.org/electronics-engineering/series-and-parallel-inductor/](https://www.geeksforgeeks.org/electronics-engineering/series-and-parallel-inductor/)  
59. Inductors in Parallel \- Electronics Tutorials, accessed October 29, 2025, [https://www.electronics-tutorials.ws/inductor/parallel-inductors.html](https://www.electronics-tutorials.ws/inductor/parallel-inductors.html)  
60. Dot Convention \- The Black Book \- Obsidian Publish, accessed October 29, 2025, [https://publish.obsidian.md/cynixia/Dot+Convention](https://publish.obsidian.md/cynixia/Dot+Convention)  
61. Mutual Inductance \- Electric Circuits II, accessed October 29, 2025, [https://www.philadelphia.edu.jo/academics/fobeidat/uploads/Electric%20Circuits%20II%20Course2/14%20Magnetically%20Coupled%20Circuits.pdf](https://www.philadelphia.edu.jo/academics/fobeidat/uploads/Electric%20Circuits%20II%20Course2/14%20Magnetically%20Coupled%20Circuits.pdf)  
62. Network Theory \- Coupled Circuits \- Tutorials Point, accessed October 29, 2025, [https://www.tutorialspoint.com/network\_theory/network\_theory\_coupled\_circuits.htm](https://www.tutorialspoint.com/network_theory/network_theory_coupled_circuits.htm)  
63. Inductors in Series and Series Inductor Circuits \- Electronics Tutorials, accessed October 29, 2025, [https://www.electronics-tutorials.ws/inductor/series-inductors.html](https://www.electronics-tutorials.ws/inductor/series-inductors.html)  
64. \[Solved\] The equivalent inductance L of two series-connected inductor \- Testbook, accessed October 29, 2025, [https://testbook.com/question-answer/the-equivalent-inductance-l-of-two-series-connecte--5f8931927696009cbd9666a4](https://testbook.com/question-answer/the-equivalent-inductance-l-of-two-series-connecte--5f8931927696009cbd9666a4)  
65. Mutual inductance dot convention \- Electrical Engineering Stack Exchange, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/597247/mutual-inductance-dot-convention](https://electronics.stackexchange.com/questions/597247/mutual-inductance-dot-convention)  
66. \[Solved\] The equivalent inductance of the circuit between terminals P \- Testbook, accessed October 29, 2025, [https://testbook.com/question-answer/the-equivalent-inductance-of-the-circuit-between-t--606367109276f50a14744b64](https://testbook.com/question-answer/the-equivalent-inductance-of-the-circuit-between-t--606367109276f50a14744b64)  
67. Equivalent series resistance \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Equivalent\_series\_resistance](https://en.wikipedia.org/wiki/Equivalent_series_resistance)  
68. Capacitor Self-resonant Frequency and Signal Integrity | Advanced PCB Design Blog, accessed October 29, 2025, [https://resources.pcb.cadence.com/blog/2019-capacitor-self-resonant-frequency-and-signal-integrity](https://resources.pcb.cadence.com/blog/2019-capacitor-self-resonant-frequency-and-signal-integrity)  
69. Capacitance and Capacitors | Analog Devices, accessed October 29, 2025, [https://www.analog.com/en/resources/analog-dialogue/articles/capacitance-and-capacitors.html](https://www.analog.com/en/resources/analog-dialogue/articles/capacitance-and-capacitors.html)  
70. Capacitor Impedance Explained: Guide on ESR, ESL, and Reactance | AIC tech Inc., accessed October 29, 2025, [https://www.aictech-inc.com/en/valuable-articles/capacitor\_foundation04.html](https://www.aictech-inc.com/en/valuable-articles/capacitor_foundation04.html)  
71. How to Read the ESR Curve of Capacitors \- Effective Return Loss (ERL): What is ERL and How is it Computed?, accessed October 29, 2025, [https://blog.samtec.com/wp-content/uploads/2021/08/08\_19\_2021\_how\_to\_read\_capacitor\_ESR.pdf](https://blog.samtec.com/wp-content/uploads/2021/08/08_19_2021_how_to_read_capacitor_ESR.pdf)  
72. ESR and ESL in Capacitors: Understanding Their Impact on Circuit Performance \- ALLPCB, accessed October 29, 2025, [https://www.allpcb.com/blog/pcb-assembly/esr-and-esl-in-capacitors-understanding-their-impact-on-circuit-performance.html](https://www.allpcb.com/blog/pcb-assembly/esr-and-esl-in-capacitors-understanding-their-impact-on-circuit-performance.html)  
73. What Is the Parasitic Capacitance of an Inductor? | Systems Analysis ..., accessed October 29, 2025, [https://resources.system-analysis.cadence.com/blog/msa2021-what-is-the-parasitic-capacitance-of-an-inductor](https://resources.system-analysis.cadence.com/blog/msa2021-what-is-the-parasitic-capacitance-of-an-inductor)  
74. Parasitic capacitance \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Parasitic\_capacitance](https://en.wikipedia.org/wiki/Parasitic_capacitance)  
75. Why is parasitic capacitance in inductor said to be in parallel? \- Physics Stack Exchange, accessed October 29, 2025, [https://physics.stackexchange.com/questions/122038/why-is-parasitic-capacitance-in-inductor-said-to-be-in-parallel](https://physics.stackexchange.com/questions/122038/why-is-parasitic-capacitance-in-inductor-said-to-be-in-parallel)  
76. Inductor, accessed October 29, 2025, [https://www.engr.colostate.edu/ECE562/lecture\_supplements/inductor\_esr.pdf](https://www.engr.colostate.edu/ECE562/lecture_supplements/inductor_esr.pdf)  
77. Self Resonant Frequency \- Microwave Encyclopedia, accessed October 29, 2025, [https://www.microwaves101.com/encyclopedias/self-resonant-frequency](https://www.microwaves101.com/encyclopedias/self-resonant-frequency)  
78. Understanding ESR and ESL in Capacitors \- Circuit Digest, accessed October 29, 2025, [https://circuitdigest.com/tutorial/understanding-esr-and-esl-in-capacitors](https://circuitdigest.com/tutorial/understanding-esr-and-esl-in-capacitors)  
79. What are impedance/ ESR frequency characteristics in capacitors? \- Murata Manufacturing, accessed October 29, 2025, [https://article.murata.com/en-us/article/impedance-esr-frequency-characteristics-in-capacitors](https://article.murata.com/en-us/article/impedance-esr-frequency-characteristics-in-capacitors)  
80. SRF & PRF in RF Capacitors | Frequency Behavior Explained \- Johanson Technology, accessed October 29, 2025, [https://www.johansontechnology.com/tech-notes/srf-prf-for-rf-capacitors/](https://www.johansontechnology.com/tech-notes/srf-prf-for-rf-capacitors/)  
81. Measuring the self resonant frequency of an inductor? \- EEVblog, accessed October 29, 2025, [https://www.eevblog.com/forum/beginners/measuring-the-self-resonant-frequency-of-an-inductor/50/](https://www.eevblog.com/forum/beginners/measuring-the-self-resonant-frequency-of-an-inductor/50/)  
82. What is Self Resonant Frequency? \- everything RF, accessed October 29, 2025, [https://www.everythingrf.com/community/what-is-self-resonant-frequency](https://www.everythingrf.com/community/what-is-self-resonant-frequency)  
83. Measuring Self Resonant Frequency \- Coilcraft, accessed October 29, 2025, [https://www.coilcraft.com/en-us/resources/application-notes/measuring-self-resonant-frequency/](https://www.coilcraft.com/en-us/resources/application-notes/measuring-self-resonant-frequency/)  
84. Skin effect \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Skin\_effect](https://en.wikipedia.org/wiki/Skin_effect)  
85. Skin Effect and Proximity Effect Losses in Litz Wires | Rubadue Wire, accessed October 29, 2025, [https://rubadue.com/knowledge-base/skin-effect-and-proximity-effect-losses-in-litz-wires/](https://rubadue.com/knowledge-base/skin-effect-and-proximity-effect-losses-in-litz-wires/)  
86. How do skin-effect and proximity-effect behave for flat-conductor power inductors?, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/586278/how-do-skin-effect-and-proximity-effect-behave-for-flat-conductor-power-inductor](https://electronics.stackexchange.com/questions/586278/how-do-skin-effect-and-proximity-effect-behave-for-flat-conductor-power-inductor)  
87. Compact Equivalent Circuit Models for the Skin Effect \- University of Texas at Austin, accessed October 29, 2025, [http://www.weewave.mer.utexas.edu/MED\_files/MED\_research/Intrcncts/Skin\_Effect\_Ldr/MTT\_96\_poster/MMT\_96\_skn\_crct\_pstr.pdf](http://www.weewave.mer.utexas.edu/MED_files/MED_research/Intrcncts/Skin_Effect_Ldr/MTT_96_poster/MMT_96_skn_crct_pstr.pdf)  
88. 6.200 Lecture Notes: Lumped-Element Abstraction, accessed October 29, 2025, [https://circuits.mit.edu/\_static/S23/handouts/lec01a/lecture01a.pdf](https://circuits.mit.edu/_static/S23/handouts/lec01a/lecture01a.pdf)  
89. 19ECE213 Transmission Lines and Radiating Systems Lumped and Distributed Circuit, accessed October 29, 2025, [https://webfiles.amrita.edu/2025/02/transmission-lines-introduction-lumped-distributed-circuit.pdf](https://webfiles.amrita.edu/2025/02/transmission-lines-introduction-lumped-distributed-circuit.pdf)  
90. Lumped-element model \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Lumped-element\_model](https://en.wikipedia.org/wiki/Lumped-element_model)  
91. Lumped Elements \- Microwaves101, accessed October 29, 2025, [https://www.microwaves101.com/encyclopedias/lumped-elements](https://www.microwaves101.com/encyclopedias/lumped-elements)  
92. Questions and confusions on transmission line theory and lumped element model, accessed October 29, 2025, [https://electronics.stackexchange.com/questions/263506/questions-and-confusions-on-transmission-line-theory-and-lumped-element-model](https://electronics.stackexchange.com/questions/263506/questions-and-confusions-on-transmission-line-theory-and-lumped-element-model)  
93. The Difference Between Lumped and Distributed Elements in Microwave Circuits, accessed October 29, 2025, [https://resources.system-analysis.cadence.com/blog/msa2021-the-difference-between-lumped-and-distributed-elements-in-microwave-circuits](https://resources.system-analysis.cadence.com/blog/msa2021-the-difference-between-lumped-and-distributed-elements-in-microwave-circuits)  
94. How to understand Lumped-parameter and Distribution-parameter? \- UIY, accessed October 29, 2025, [https://www.uiy.com/News/How\_to\_understand\_Lumped\_parameter\_and\_Distribution\_parameter/](https://www.uiy.com/News/How_to_understand_Lumped_parameter_and_Distribution_parameter/)  
95. IEC 60050 \- International Electrotechnical Vocabulary \- Electropedia, accessed October 29, 2025, [https://electropedia.org/iev/iev.nsf/IEVref\_xref/en:131-12-13](https://electropedia.org/iev/iev.nsf/IEVref_xref/en:131-12-13)  
96. IEC 60050 \- International Electrotechnical Vocabulary \- Details for ..., accessed October 29, 2025, [https://electropedia.org/iev/iev.nsf/display?openform\&ievref=131-12-19](https://electropedia.org/iev/iev.nsf/display?openform&ievref=131-12-19)  
97. Time constant \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Time\_constant](https://en.wikipedia.org/wiki/Time_constant)  
98. Dielectric Constants, accessed October 29, 2025, [http://hyperphysics.phy-astr.gsu.edu/hbase/Tables/diel.html](http://hyperphysics.phy-astr.gsu.edu/hbase/Tables/diel.html)  
99. Dielectric Constant, Strength, & Loss Tangent \- RF Cafe, accessed October 29, 2025, [https://www.rfcafe.com/references/electrical/dielectric-constants-strengths.htm](https://www.rfcafe.com/references/electrical/dielectric-constants-strengths.htm)  
100. Material Notes and Tables \- Opcomm History, accessed October 29, 2025, [https://descanso.jpl.nasa.gov/SciTechBook/series3/07Chapter6MatlNotesTables.pdf](https://descanso.jpl.nasa.gov/SciTechBook/series3/07Chapter6MatlNotesTables.pdf)  
101. accessed October 29, 2025, [https://www.ossila.com/products/tantalum-v-oxide-powder\#:\~:text=Tantalum%20(V)%20oxide%20(CAS,in%20the%20production%20of%20capacitors.](https://www.ossila.com/products/tantalum-v-oxide-powder#:~:text=Tantalum%20\(V\)%20oxide%20\(CAS,in%20the%20production%20of%20capacitors.)  
102. Tantalum pentoxide \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Tantalum\_pentoxide](https://en.wikipedia.org/wiki/Tantalum_pentoxide)  
103. Preparation and properties of tantalum pentoxide (Ta2O5) thin films for ultra large scale integrated circuits (ULSIs) application, accessed October 29, 2025, [https://ir.lib.nycu.edu.tw/bitstream/11536/31493/1/000079946300003.pdf](https://ir.lib.nycu.edu.tw/bitstream/11536/31493/1/000079946300003.pdf)  
104. Relative permittivity \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Relative\_permittivity](https://en.wikipedia.org/wiki/Relative_permittivity)  
105. "Magnetics Design 2 \- Magnetic Core ... \- Texas Instruments, accessed October 29, 2025, [https://www.ti.com/lit/ml/slup124/slup124.pdf](https://www.ti.com/lit/ml/slup124/slup124.pdf)  
106. Core Materials, Permeability and Their Losses \- passive-components.eu, accessed October 29, 2025, [https://passive-components.eu/inductors-core-materials-and-their-losses/](https://passive-components.eu/inductors-core-materials-and-their-losses/)  
107. Permeability (electromagnetism) \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Permeability\_(electromagnetism)](https://en.wikipedia.org/wiki/Permeability_\(electromagnetism\))  
108. Inductor Core Material and Shape Choices \- Magnetics, accessed October 29, 2025, [https://www.mag-inc.com/design/design-guides/inductor-cores-material-and-shape-choices](https://www.mag-inc.com/design/design-guides/inductor-cores-material-and-shape-choices)  
109. Ferrite Materials Explained: NiZn vs MnZn for EMI Suppression \- Blikai, accessed October 29, 2025, [https://www.blikai.com/blog/components-parts/ferrite-materials-explained-nizn-vs-mnzn-for-emi-suppression](https://www.blikai.com/blog/components-parts/ferrite-materials-explained-nizn-vs-mnzn-for-emi-suppression)  
110. The Difference About NiZn Material Ferrite Core and MnZn Material Ferrite Core, accessed October 29, 2025, [http://www.ming-ci.com/en/news\_3\_23.html](http://www.ming-ci.com/en/news_3_23.html)