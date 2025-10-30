# Analysis of Standard SEPIC DC-DC Converter in Continuous Conduction Mode (CCM)

This document provides a detailed technical explanation of the operation and state-space modeling of a standard Single-Ended Primary Inductor Converter (SEPIC) operating in Continuous Conduction Mode (CCM). The analysis is based on principles found in standard power electronics textbooks, such as "Fundamentals of Power Electronics" by Erickson and Maksimovic [1].

## 1. Standard SEPIC Converter Circuit Diagram

The SEPIC converter is a DC-DC converter that allows the output voltage to be greater than, less than, or equal to the input voltage. It provides a positive output voltage from a positive input voltage, which is a key advantage over other buck-boost topologies like the Cuk converter. It also features a non-pulsating input current, which is beneficial for power factor correction applications.

For our analysis, we will use the following standard SEPIC converter circuit diagram:


**Figure 1: Standard SEPIC Converter Circuit Diagram**

**Component Labels:**
*   **Input Voltage Source:** *V<sub>in</sub>*
*   **Input Inductor:** *L<sub>1</sub>*
*   **Coupling Capacitor:** *C<sub>1</sub>*
*   **Power Switch (MOSFET):** S
*   **Diode:** D
*   **Output Inductor:** *L<sub>2</sub>*
*   **Output Capacitor:** *C<sub>out</sub>*
*   **Load Resistor:** R
*   **Output Voltage:** *V<sub>out</sub>*

## 2. Definition of State Variables

In state-space modeling, the state variables are the minimum set of variables that completely describe the dynamic state of the system at any given time. For a converter, these are typically the inductor currents and capacitor voltages, as these are the energy storage elements whose values cannot change instantaneously.

For the standard SEPIC converter shown in Figure 1, we have two inductors (*L<sub>1</sub>* and *L<sub>2</sub>*) and two capacitors (*C<sub>1</sub>* and *C<sub>out</sub>*). Therefore, we will have four state variables:

*   **Current through Input Inductor *L<sub>1</sub>***: *i<sub>L1</sub>(t)*
*   **Voltage across Coupling Capacitor *C<sub>1</sub>***: *v<sub>C1</sub>(t)*
*   **Current through Output Inductor *L<sub>2</sub>***: *i<sub>L2</sub>(t)*
*   **Voltage across Output Capacitor *C<sub>out</sub>***: *v<sub>out</sub>(t)* (which is also *v<sub>Cout</sub>(t)*)

These state variables are assembled into a column matrix, known as the state vector **x**(t):

```
      [ i_L1(t) ]
      [ v_C1(t) ]
x(t) = [ i_L2(t) ]
      [ v_out(t) ]
```

## 3. Analysis of Subinterval 1: Switch S is ON (0 < t < DTs)

In Continuous Conduction Mode (CCM), the inductor currents (*i<sub>L1</sub>* and *i<sub>L2</sub>*) never fall to zero during a switching period. The operation of the SEPIC converter in CCM can be divided into two subintervals based on the state of the power switch S.

### 3.1. Equivalent Circuit Diagram: Switch S is ON

When the power switch S (MOSFET) is turned ON, it acts as a short circuit. Consequently, the voltage across the diode D becomes negative (reverse-biased), causing the diode to turn OFF and act as an open circuit. The equivalent circuit for this subinterval is shown below:


**Figure 2: Equivalent Circuit of SEPIC Converter when Switch S is ON**

### 3.2. Derivation of State Equations: Switch S is ON

Using the equivalent circuit from Figure 2, we can derive the differential equations for each state variable:

**1. Input Inductor *L<sub>1</sub>* Current (*i<sub>L1</sub>*):**
*   **Law Used:** Kirchhoff's Voltage Law (KVL)
*   **Loop Analysis:** Consider the loop formed by *V<sub>in</sub>*, *L<sub>1</sub>*, and the ON switch S. The voltage across *L<sub>1</sub>* is equal to the input voltage *V<sub>in</sub>*.
*   *V<sub>in</sub> = L<sub>1</sub> (di<sub>L1</sub>/dt)*
*   Therefore:
    `di_L1/dt = V_in / L_1`

**2. Coupling Capacitor *C<sub>1</sub>* Voltage (*v<sub>C1</sub>*):**
*   **Law Used:** Kirchhoff's Current Law (KCL)
*   **Node Analysis:** Consider the node between *L<sub>1</sub>*, *C<sub>1</sub>*, and the switch S. When S is ON, the current flowing through *C<sub>1</sub>* is the current flowing through *L<sub>2</sub>* (since the diode D is OFF, *i<sub>L2</sub>* flows through *C<sub>1</sub>* and the switch S).
*   The current through *C<sub>1</sub>* is *i<sub>C1</sub> = C<sub>1</sub> (dv<sub>C1</sub>/dt)*.
*   From the circuit, the current *i<sub>C1</sub>* is equal to *-i<sub>L2</sub>* (current leaving the top plate of *C<sub>1</sub>* and entering the top of *L<sub>2</sub>*).
*   Therefore:
    `dv_C1/dt = -i_L2 / C_1`

**3. Output Inductor *L<sub>2</sub>* Current (*i<sub>L2</sub>*):**
*   **Law Used:** Kirchhoff's Voltage Law (KVL)
*   **Loop Analysis:** Consider the loop formed by *C<sub>1</sub>*, *L<sub>2</sub>*, and the ON switch S. The voltage across *L<sub>2</sub>* is equal to the voltage across *C<sub>1</sub>*.
*   *v<sub>C1</sub> = L<sub>2</sub> (di<sub>L2</sub>/dt)*
*   Therefore:
    `di_L2/dt = v_C1 / L_2`

**4. Output Capacitor *C<sub>out</sub>* Voltage (*v<sub>out</sub>*):**
*   **Law Used:** Kirchhoff's Current Law (KCL)
*   **Node Analysis:** Consider the output node where *L<sub>2</sub>*, *C<sub>out</sub>*, and *R* are connected. When the diode D is OFF, no current flows from *L<sub>2</sub>* to *C<sub>out</sub>* and *R*. The output capacitor *C<sub>out</sub>* is only discharging through the load resistor *R*.
*   The current leaving the node through *R* is *i<sub>R</sub> = v<sub>out</sub> / R*.
*   Therefore:
    `dv_out/dt = -v_out / (R * C_out)`

### 3.3. State-Space Representation (A₁ and B₁ matrices): Switch S is ON

Now, we assemble the derived differential equations into the standard state-space matrix form: **x' = A₁x + B₁u**.

Recall our state vector: **x**(t) and input vector: **u** = [*V<sub>in</sub>*]

The individual equations are:
*   `di_L1/dt = (1/L_1)*V_in + 0*i_L2 + 0*v_C1 + 0*v_out`
*   `dv_C1/dt = 0*i_L1 - (1/C_1)*i_L2 + 0*v_C1 + 0*v_out`
*   `di_L2/dt = 0*i_L1 + 0*i_L2 + (1/L_2)*v_C1 + 0*v_out`
*   `dv_out/dt = 0*i_L1 + 0*v_C1 + 0*i_L2 - (1/(R*C_out))*v_out`

Assembling these into matrix form:
```
[di_L1/dt]   [ 0    0      -1/C_1      0    ] [i_L1]   [1/L_1]
[dv_C1/dt] = [ 0    0      -1/C_1      0    ] [v_C1] + [  0  ] [V_in]
[di_L2/dt]   [ 0   1/L_2      0         0    ] [i_L2]   [  0  ]
[dv_out/dt]  [ 0    0         0    -1/(RC_out)] [v_out]  [  0  ]
```
Thus, the **A₁** and **B₁** matrices for Subinterval 1 (Switch S is ON) are:
```
      [ 0    0      -1/C_1      0    ]
A_1 = [ 0    0      -1/C_1      0    ]
      [ 0   1/L_2      0         0    ]
      [ 0    0         0    -1/(RC_out)]

      [1/L_1]
B_1 = [  0  ]
      [  0  ]
      [  0  ]
```

## 4. Analysis of Subinterval 2: Switch S is OFF (DTs < t < Ts)

When the power switch S (MOSFET) is turned OFF, it acts as an open circuit. The energy stored in the inductors *L<sub>1</sub>* and *L<sub>2</sub>* forces the diode D to become forward-biased (ON), acting as a short circuit. This allows current to flow to the output.

### 4.1. Equivalent Circuit Diagram: Switch S is OFF

The equivalent circuit for this subinterval is shown below:

**Figure 3: Equivalent Circuit of SEPIC Converter when Switch S is OFF**

### 4.2. Derivation of State Equations: Switch S is OFF

Using the equivalent circuit from Figure 3, we can derive the differential equations for each state variable:

**1. Input Inductor *L<sub>1</sub>* Current (*i<sub>L1</sub>*):**
*   **Law Used:** Kirchhoff's Voltage Law (KVL)
*   **Loop Analysis:** Consider the loop formed by *V<sub>in</sub>*, *L<sub>1</sub>*, *C<sub>1</sub>*, and *C<sub>out</sub>* (through the diode D). The voltage across *L<sub>1</sub>* is *V<sub>in</sub> - v<sub>C1</sub> - v<sub>out</sub>*.
*   *V<sub>in</sub> - v<sub>C1</sub> - v<sub>out</sub> = L<sub>1</sub> (di<sub>L1</sub>/dt)*
*   Therefore:
    `di_L1/dt = (V_in - v_C1 - v_out) / L_1`

**2. Coupling Capacitor *C<sub>1</sub>* Voltage (*v<sub>C1</sub>*):**
*   **Law Used:** Kirchhoff's Current Law (KCL)
*   **Node Analysis:** Consider the node between *L<sub>1</sub>*, *C<sub>1</sub>*, and the diode D. When D is ON, the current flowing through *C<sub>1</sub>* is *i<sub>L1</sub>*.
*   Therefore:
    `dv_C1/dt = i_L1 / C_1`

**3. Output Inductor *L<sub>2</sub>* Current (*i<sub>L2</sub>*):**
*   **Law Used:** Kirchhoff's Voltage Law (KVL)
*   **Loop Analysis:** Consider the loop formed by *L<sub>2</sub>*, *C<sub>out</sub>*, and the diode D. The voltage across *L<sub>2</sub>* is *v<sub>out</sub>*.
*   *v<sub>out</sub> = L<sub>2</sub> (di<sub>L2</sub>/dt)*
*   Therefore:
    `di_L2/dt = v_out / L_2`

**4. Output Capacitor *C<sub>out</sub>* Voltage (*v<sub>out</sub>*):**
*   **Law Used:** Kirchhoff's Current Law (KCL)
*   **Node Analysis:** Consider the output node. Current *i<sub>L1</sub>* and *i<sub>L2</sub>* flow into the output node. This current splits between *C<sub>out</sub>* and *R*.
*   *i<sub>L1</sub> + i<sub>L2</sub> = i<sub>Cout</sub> + i<sub>R</sub> = C<sub>out</sub>(dv<sub>out</sub>/dt) + v<sub>out</sub>/R*
*   Therefore:
    `dv_out/dt = (i_L1 + i_L2) / C_out - v_out / (R * C_out)`

### 4.3. State-Space Representation (A₂ and B₂ matrices): Switch S is OFF

Now, we assemble the derived differential equations into the standard state-space matrix form: **x' = A₂x + B₂u**.

The individual equations are:
*   `di_L1/dt = -(1/L_1)*v_C1 - (1/L_1)*v_out + (1/L_1)*V_in`
*   `dv_C1/dt = (1/C_1)*i_L1`
*   `di_L2/dt = (1/L_2)*v_out`
*   `dv_out/dt = (1/C_out)*i_L1 + (1/C_out)*i_L2 - (1/(R*C_out))*v_out`

Assembling these into matrix form:
```
[di_L1/dt]   [  0   -1/L_1   0    -1/L_1   ] [i_L1]   [1/L_1]
[dv_C1/dt] = [1/C_1    0     0       0     ] [v_C1] + [  0  ] [V_in]
[di_L2/dt]   [  0      0     0     1/L_2   ] [i_L2]   [  0  ]
[dv_out/dt]  [1/C_out  0   1/C_out -1/(RC_out)] [v_out]  [  0  ]
```
Thus, the **A₂** and **B₂** matrices for Subinterval 2 (Switch S is OFF) are:
```
      [  0   -1/L_1   0    -1/L_1   ]
A_2 = [1/C_1    0     0       0     ]
      [  0      0     0     1/L_2   ]
      [1/C_out  0   1/C_out -1/(RC_out)]

      [1/L_1]
B_2 = [  0  ]
      [  0  ]
      [  0  ]
```

## 5. State-Space Averaging

**Feynman Method Explanation:**
Imagine you have a light switch that you flip ON for a certain amount of time and then OFF for the rest of the time, repeating this very quickly. If you look at the light over a longer period, it doesn't just blink ON and OFF; it appears to have a steady brightness somewhere between fully ON and fully OFF. This steady brightness is like the *average* behavior of the light. In our SEPIC converter, the switch is flipping ON and OFF very rapidly. The inductor currents and capacitor voltages are constantly changing, but if we look at them over a full switching cycle, they have an *average* value. State-space averaging is like finding that average brightness for all the components in our circuit. Instead of looking at the rapid ON-OFF changes, we create a single, simplified model that describes the circuit's behavior based on these average values, weighted by how long the switch is ON (duty cycle) and OFF.

**Nuanced Engineering Explanation:**
State-space averaging is a powerful technique used to model the low-frequency (or average) behavior of switching converters. It effectively transforms a periodically switched linear system into a time-invariant linear system. This is achieved by averaging the state equations over one switching period (T<sub>s</sub>), assuming that the switching frequency (f<sub>s</sub> = 1/T<sub>s</sub>) is much higher than the natural frequencies of the converter. This assumption allows us to neglect the high-frequency ripple components and focus on the slower dynamics relevant for control design.

The fundamental principle of state-space averaging is to take a weighted average of the state matrices from each subinterval. For a converter operating in CCM with two subintervals (Switch ON and Switch OFF), the averaged state-space model is given by:

`dx/dt = Ax + Bu`

Where the averaged matrices **A** and **B** are calculated as:

`A = D*A₁ + (1 - D)*A₂`
`B = D*B₁ + (1 - D)*B₂`

Here, *D* is the steady-state duty cycle (the fraction of the switching period when the switch S is ON), and (1 – *D*) is the fraction of the switching period when the switch S is OFF. **A₁**, **B₁** are the matrices from Subinterval 1 (Switch ON), and **A₂**, **B₂** are the matrices from Subinterval 2 (Switch OFF).

### 5.1. Derivation of Averaged A Matrix

We substitute the previously derived **A₁** and **A₂** matrices into the averaging formula. Performing the matrix multiplication and addition yields:

```
      [ 0  -(1-D)/L_1  -D/C_1  -(1-D)/L_1 ]
      [   (1-D)/C_1       0         0          0     ]
A =   [      0            0         0       (1-D)/L_2 ]
      [   (1-D)/C_out     0     (1-D)/C_out -1/(RC_out)]
```

### 5.2. Derivation of Averaged B Matrix

Similarly, we substitute the previously derived **B₁** and **B₂** matrices into the averaging formula:

`B = D*[1/L₁; 0; 0; 0] + (1-D)*[1/L₁; 0; 0; 0]`

Performing the matrix multiplication and addition:

`B = [D/L₁ + (1-D)/L₁; 0; 0; 0] = [1/L₁; 0; 0; 0]`

### 5.3. Final Averaged State-Space Model

The averaged state-space model for the SEPIC converter in CCM is:

`d/dt [x] = A * [x] + B * [V_in]`

where A and B are the averaged matrices derived above.

**Why It Is Critical for This Project:**
This averaged model is crucial because it provides a simplified, linear representation of the converter's dynamics. Instead of dealing with the complex, rapidly switching behavior, we now have a continuous-time model that describes the average behavior of the converter. This model is the foundation for:

1.  **Small-Signal Analysis:** The next step, linearization, directly uses this averaged model to derive transfer functions, which are essential for control system design.
2.  **Control System Design:** Control engineers design controllers based on these averaged models, as they capture the dominant dynamics of the converter at frequencies much lower than the switching frequency.
3.  **Simulation and Analysis:** It allows for faster and more stable simulations compared to detailed switching models, enabling efficient analysis of converter performance and stability.

## 6. Small-Signal Linearization and Transfer Function Derivation

**Feynman Method Explanation:**
Imagine you have a perfectly still pond. If you drop a tiny pebble into it, you create small ripples. These ripples tell you something about the pond itself – how deep it is, how quickly the water moves. Small-signal linearization is like dropping a tiny, imaginary pebble into our averaged SEPIC converter model. We assume that the input voltage, the duty cycle, and all the inductor currents and capacitor voltages are made up of a large, steady part (the DC operating point) and a very, very small, rapidly changing part (the AC perturbation). By only looking at how these tiny changes affect each other, we can simplify our complex equations into a set of linear equations. These linear equations then allow us to understand how the converter will respond to small disturbances, which is crucial for designing a stable control system.

**Nuanced Engineering Explanation:**
While the averaged state-space model (Section 5) describes the large-signal, steady-state behavior of the converter, it is still a nonlinear model due to the presence of the duty cycle *D* as a variable within the **A** and **B** matrices. For control system design, we typically need a linear model that describes the converter's dynamic response to small perturbations around a specific DC operating point. This is achieved through small-signal linearization.

### 6.1. Small-Signal Perturbation

We assume that each variable in the system consists of a large DC (quiescent) component and a small AC (perturbation) component. The DC components represent the steady-state operating point, while the AC components represent small deviations from this operating point. We denote DC components with uppercase letters and AC components with a hat (^).

*   **State Variables:** `x(t) = X + x̂(t)`
    *   `i_L1(t) = I_L1 + î_L1(t)`
    *   `v_C1(t) = V_C1 + v̂_C1(t)`
    *   `i_L2(t) = I_L2 + î_L2(t)`
    *   `v_out(t) = V_out + v̂_out(t)`
*   **Input Voltage:** `v_in(t) = V_in + v̂_in(t)`
*   **Duty Cycle:** `d(t) = D + d̂(t)`

### 6.2. Applying Perturbation to the Averaged Model

We substitute these perturbed variables into the averaged state-space equation:
`d(X + x̂)/dt = A(D + d̂)(X + x̂) + B(D + d̂)(V_in + v̂_in)`

Since **X** is a DC value, `dX/dt = 0`. The left side becomes `dx̂/dt`.
On the right side, we expand the terms using a first-order Taylor series expansion and ignore products of small-signal terms.

### 6.3. Linearized State-Space Model

After expanding and subtracting the DC steady-state equation `0 = A(D)X + B(D)V_in`, we are left with the linearized AC small-signal model:

`dx̂/dt = A(D)x̂ + [(∂A/∂D)X + (∂B/∂D)V_in]d̂ + B(D)v̂_in`

This can be written in the standard form:
`dx̂/dt = A_linear * x̂ + B_d * d̂ + B_in * v̂_in`

Where:
*   **A<sub>linear</sub>** = **A**(D) (the averaged A matrix evaluated at the DC operating point D)
*   **B<sub>d</sub>** = (∂**A**/∂D) **X** + (∂**B**/∂D) *V<sub>in</sub>*
*   **B<sub>in</sub>** = **B**(D) (the averaged B matrix evaluated at the DC operating point D)

To calculate **B<sub>d</sub>**, we need the partial derivatives of **A** and **B** with respect to D, and the DC steady-state values of the state variables, **X**.

For a SEPIC converter in CCM, the DC relationships are:
*   `V_out = V_in * (D / (1-D))`
*   `I_L1 = I_in = I_out * (D / (1-D)) = (V_out / R) * (D / (1-D))`
*   `I_L2 = I_out = V_out / R`
*   `V_C1 = V_in`

After calculating the partial derivatives and substituting the DC values, we get the final linearized small-signal state-space model with constant matrices **A<sub>linear</sub>**, **B<sub>d</sub>**, and **B<sub>in</sub>**.

### 6.4. Deriving Transfer Functions

From the linearized state-space model, we can derive various transfer functions using the general formula:

`G(s) = C * (sI - A_linear)⁻¹ * B_input + E_input`

Where:
*   *s* is the complex frequency variable.
*   **I** is the identity matrix.
*   **A<sub>linear</sub>** is the system matrix from the linearized model.
*   **B<sub>input</sub>** is the input matrix corresponding to the input for which the transfer function is being derived (e.g., **B<sub>d</sub>** for control-to-output, **B<sub>in</sub>** for input-to-output).
*   **C** is the output matrix that selects the desired output variable (e.g., for output voltage, **C** = `[0 0 0 1]`).

Let's derive the two most common transfer functions:

1.  **Control-to-Output Voltage Transfer Function (G<sub>v,d</sub>(s))**: This describes how the output voltage changes with respect to small changes in the duty cycle.
    *   Output: `v̂_out(s)`
    *   Input: `d̂(s)`
    *   Output Matrix: **C** = `[0 0 0 1]`
    *   Input Matrix: **B<sub>input</sub>** = **B<sub>d</sub>**

2.  **Input-to-Output Voltage Transfer Function (G<sub>v,g</sub>(s))**: This describes how the output voltage changes with respect to small changes in the input voltage.
    *   Output: `v̂_out(s)`
    *   Input: `v̂_in(s)`
    *   Output Matrix: **C** = `[0 0 0 1]`
    *   Input Matrix: **B<sub>input</sub>** = **B<sub>in</sub>**

**Computational Complexity:**
For a 4th-order system like the SEPIC converter, manually calculating the inverse of `(sI - A_linear)` can be very tedious. Computational tools like MATLAB, Python (with NumPy and SymPy), or specialized circuit simulators are typically used for this step.

**Why It Is Critical for This Project:**
Deriving these transfer functions is the ultimate goal of the small-signal modeling process. They are the mathematical representations of the converter's dynamic behavior and are absolutely critical for:

1.  **Control System Design:** The transfer functions act as the plant model for designing feedback controllers.
2.  **Stability Analysis:** The poles of these transfer functions directly indicate the stability of the converter.
3.  **Performance Prediction:** Transfer functions allow engineers to predict the converter's dynamic performance, such as its transient response, bandwidth, and disturbance rejection.
4.  **Optimization:** By analyzing the transfer functions, designers can identify areas for optimization, such as improving efficiency or enhancing transient response.

This completes the small-signal linearization and transfer function derivation for the standard SEPIC converter in CCM. These models form the basis for designing effective control systems.

---

### References
[1] R. W. Erickson and D. Maksimovic, *Fundamentals of Power Electronics*, Third Edition. Springer, 2020.