

# **Linearization and Small-Signal Analysis of Nonlinear Systems**

## **1\. Analysis of Nonlinear Systems and Equilibrium**

### **1.1 The Challenge of Nonlinearity: Failure of Superposition**

The vast majority of physical systems—from mechanical pendulums and robotic arms to electronic circuits and chemical processes—are fundamentally nonlinear.1 A system is defined as nonlinear if it does not adhere to the principle of superposition. This principle, which forms the bedrock of linear system theory, states that the response to a weighted sum of inputs is equal to the weighted sum of the individual responses. Nonlinear systems violate this, meaning their behavior is often complex, coupled, and non-intuitive.2

This mathematical distinction is the source of "essentially nonlinear phenomena," which are behaviors that linear systems are fundamentally incapable of producing.3 A prime example is the existence of multiple *isolated* equilibrium points. A linear system $\\dot{x} \= Ax$ can have a single isolated equilibrium at $x=0$ (if $A$ is nonsingular) or a continuum of equilibria (if $A$ is singular), but it cannot have multiple isolated equilibria. If $x\_a$ and $x\_b$ are two distinct equilibria for a linear system, the principle of superposition dictates that any point on the line connecting them, $\\alpha x\_a \+ (1 \- \\alpha) x\_b$, must also be an equilibrium point.3 In contrast, a simple nonlinear system like a damped pendulum has an infinite number of isolated equilibria (e.g., at angles $n\\pi$ for $n \= 0, \\pm 1, \\pm 2, \\dots$).3

The decision to linearize a system is therefore a conscious engineering tradeoff. We sacrifice the ability to predict or analyze these "global" and complex nonlinear phenomena in exchange for the mathematical tractability of linear analysis tools, which are valid only in a "local" neighborhood of a specific operating condition.3

### **1.2 Defining the Equilibrium (Operating) Point**

Analysis of a nonlinear system must begin by defining a steady-state condition, or "operating point," around which to analyze the system's dynamic behavior.

* **Formal Definition (Autonomous Systems):** For an autonomous (time-invariant) system described by the state equation $\\dot{x} \= f(x)$, the equilibrium points $x^\*$ are the real solutions to the algebraic equation $f(x) \= 0$.2 If the system's state starts at an equilibrium point, $x(t\_0) \= x^\*$, it will remain at that point for all future time, $x(t) \\equiv x^\*$ for $t \\geq t\_0$.2  
* **Formal Definition (Systems with Inputs):** For a system with inputs, $\\dot{x} \= f(x, u)$, an equilibrium point (also called a *stationary point*) is a pair $(x\_0, u\_0)$ such that a constant input $u(t) \= u\_0$ results in a constant state $x(t) \= x\_0$. This requires that the state time-derivative is zero, so the pair $(x\_0, u\_0)$ must satisfy the equation $f(x\_0, u\_0) \= 0$.4

### **1.3 The Rationale for Linearization**

Most mathematical models derived from first principles, such as Newton's laws or mass balance, are nonlinear.1 However, the most powerful and widely used tools for system analysis and controller design—including pole placement, frequency-domain loop shaping, and PID tuning—are overwhelmingly based on linear system theory.7

Linearization is the "first step" 2 and a "common engineering practice" 3 that serves as the essential bridge between the complex nonlinear reality and the powerful linear toolkit. It involves approximating the nonlinear system with a linear model that is valid *locally* in the vicinity of a chosen operating point.

### **Table 1: Comparison of Linear vs. Nonlinear System Phenomena**

| Phenomenon | Linear Systems | Nonlinear Systems (The Reality) | Sources |
| :---- | :---- | :---- | :---- |
| **Superposition** | Holds. | Does *not* hold. | 2 |
| **Equilibrium Points** | Can have a single isolated point (if $A$ is nonsingular) or a continuum (if $A$ is singular). | Can have **multiple isolated** equilibrium points. | 3 |
| **Oscillations** | Can exhibit forced oscillations or (if undamped) simple harmonic motion. | Can exhibit **limit cycles** (stable, self-sustaining oscillations), **chaos**, and sub/super-harmonic oscillations. | 3 |
| **Stability** | Stability is a global property (e.g., if stable, it's stable everywhere). | Stability is often local. Can have multiple modes of behavior. | 3 |
| **Finite Escape Time** | Cannot occur (for LTI systems). | Solutions can go to infinity in finite time. | 3 |

## **2\. The Mathematical Foundation: Taylor Series Approximation**

### **2.1 Taylor's Theorem: The Principle of Approximation**

The mathematical tool that enables linearization is Taylor's theorem. This theorem provides a method for approximating a $k$-times differentiable function around a given point using a polynomial of degree $k$.12 The *first-order Taylor polynomial* is, by definition, the *linear approximation* of the function.12 This first-order approximation is the formal mathematical basis for the linearization techniques used in control theory and engineering.1

### **2.2 Single-Variable Linearization**

Consider a smooth, single-variable nonlinear function $f(x)$. The Taylor series expansion of $f(x)$ around an operating point $x\_0$ is given by:

$$f(x) \= f(x\_0) \+ \\left. \\frac{df(x)}{dx} \\right|\_{x=x\_0}(x-x\_0) \+ \\left. \\frac{1}{2\!}\\frac{d^2f(x)}{dx^2} \\right|\_{x=x\_0}(x-x\_0)^2 \+ \\dots \+ \\text{H.O.T.}$$  
where H.O.T. represents the higher-order terms.1

**The Linear Approximation** is obtained by truncating all second-order and higher terms:

$$f(x) \\approx f(x\_0) \+ \\left. \\frac{df(x)}{dx} \\right|\_{x=x\_0}(x-x\_0)$$  
1

Graphically, this approximation represents the equation of the *tangent line* to the function $f(x)$ at the operating point $x\_0$.15

The "local" limitation of linearization is a direct mathematical consequence of this truncation. The approximation is only valid when the deviation $(x-x\_0)$ is "small".13 This is because the approximation relies on the assumption that the neglected H.O.T., which are proportional to $(x-x\_0)^2$ and higher powers, are negligible. The range of validity is therefore dictated by the "curvature" of the function (i.e., its second derivative); a highly nonlinear function will have a much smaller valid neighborhood.

To formalize this, we define "small-signal" or "deviation" variables:

* $\\delta x \= x \- x\_0$ (the deviation in $x$ from the operating point) 15  
* $\\delta f \= f(x) \- f(x\_0)$ (the corresponding deviation in the function's output)

Substituting these definitions into the linear approximation yields the linearized model in deviation variables:

$$\\delta f \\approx \\left\[ \\left. \\frac{df}{dx} \\right|\_{x\_0} \\right\] \\delta x$$  
15

The term $k \= \\left. \\frac{df}{dx} \\right|\_{x\_0}$ is a *constant* (a scalar value, not a function) that represents the local "gain" of the function at the specific point $x\_0$.

### **2.3 Multivariate Taylor Series Expansion (The Vector Case)**

This concept extends directly to vector functions, $f(x)$, where $x$ is a state vector $x \= \[x\_1, \\dots, x\_n\]^T$. The Taylor expansion around a vector operating point $x\_0$ is:

$$f(x) \\approx f(x\_0) \+ Df(x\_0)(x-x\_0) \+ \\text{H.O.T.}$$  
In this multivariate case, the first-order derivative is no longer a single scalar but a matrix of partial derivatives. This matrix, $Df(x\_0)$, is the **Jacobian Matrix**.16 This expansion is the mathematical mechanism used to derive the standard $A, B, C, D$ state-space matrices.16

## **3\. State-Space Linearization and the Jacobian**

The central procedure of linearization involves applying the multivariate Taylor series to a general nonlinear state-space model to derive an equivalent linear model.

### **3.1 The General Nonlinear State-Space Model**

A wide class of nonlinear dynamical systems can be represented in state-space form 2:

* **State Equation:** $\\dot{x} \= f(x, u)$  
* **Output Equation:** $y \= g(x, u)$

Here, $x \\in \\mathbb{R}^n$ is the state vector, $u \\in \\mathbb{R}^p$ is the input vector, and $y \\in \\mathbb{R}^q$ is the output vector. The functions $f$ and $g$ are nonlinear vector functions that describe the system's dynamics and its measurement, respectively.4

### **3.2 Derivation of the Linearized Model (A, B, C, D)**

The derivation follows a systematic process 4:

Step 1: Determine the Stationary (Equilibrium) Point $(x\_0, u\_0)$  
As defined in Section 1.2, we find a constant state $x\_0$ and constant input $u\_0$ that satisfy the equilibrium condition $\\dot{x}\_0 \= 0$, which implies $f(x\_0, u\_0) \= 0$. The corresponding nominal output is $y\_0 \= g(x\_0, u\_0)$.4  
Step 2: Define Deviation Variables  
We define new variables that represent small perturbations around this operating point:

* $\\Delta x(t) \= x(t) \- x\_0$  
* $\\Delta u(t) \= u(t) \- u\_0$  
* $\\Delta y(t) \= y(t) \- y\_0$ 4

Step 3: Linearize the State Equation $\\dot{x} \= f(x, u)$  
We expand the nonlinear function $f(x, u)$ using a multivariate Taylor series around the point $(x\_0, u\_0)$ and truncate the H.O.T.:

$$f(x, u) \\approx f(x\_0, u\_0) \+ \\left. \\frac{\\partial f}{\\partial x} \\right|\_{(x\_0, u\_0)}(x \- x\_0) \+ \\left. \\frac{\\partial f}{\\partial u} \\right|\_{(x\_0, u\_0)}(u \- u\_0)$$  
4

Next, we substitute our definitions and knowns into this approximation:

* The left-hand side (LHS) is the time-derivative of the state: $\\dot{x} \= \\frac{d}{dt}(x\_0 \+ \\Delta x) \= \\dot{x}\_0 \+ \\Delta\\dot{x}$. Since $x\_0$ is a constant vector, $\\dot{x}\_0 \= 0$, leaving $\\dot{x} \= \\Delta\\dot{x}$.4  
* On the right-hand side (RHS), $f(x\_0, u\_0) \= 0$ (from Step 1). The terms $(x \- x\_0)$ and $(u \- u\_0)$ are, by definition, $\\Delta x$ and $\\Delta u$.4

The state equation simplifies to:

$$\\Delta\\dot{x} \\approx \\left\[ \\left. \\frac{\\partial f}{\\partial x} \\right|\_{(x\_0, u\_0)} \\right\] \\Delta x \+ \\left\[ \\left. \\frac{\\partial f}{\\partial u} \\right|\_{(x\_0, u\_0)} \\right\] \\Delta u$$  
4

Step 4: Define the Jacobian Matrices A and B  
We define the constant matrices $A$ and $B$ as the Jacobian matrices (the matrices of all first-order partial derivatives) evaluated at the specific operating point $(x\_0, u\_0)$ 4:

* State Matrix (A):

  $$A \\equiv \\left. \\frac{\\partial f}{\\partial x} \\right|\_{(x\_0, u\_0)} \= \\left. \\begin{bmatrix} \\frac{\\partial f\_1}{\\partial x\_1} & \\cdots & \\frac{\\partial f\_1}{\\partial x\_n} \\\\ \\vdots & \\ddots & \\vdots \\\\ \\frac{\\partial f\_n}{\\partial x\_1} & \\cdots & \\frac{\\partial f\_n}{\\partial x\_n} \\end{bmatrix} \\right|\_{(x\_0, u\_0)}$$  
* Input Matrix (B):

  $$B \\equiv \\left. \\frac{\\partial f}{\\partial u} \\right|\_{(x\_0, u\_0)} \= \\left. \\begin{bmatrix} \\frac{\\partial f\_1}{\\partial u\_1} & \\cdots & \\frac{\\partial f\_1}{\\partial u\_p} \\\\ \\vdots & \\ddots & \\vdots \\\\ \\frac{\\partial f\_n}{\\partial u\_1} & \\cdots & \\frac{\\partial f\_n}{\\partial u\_p} \\end{bmatrix} \\right|\_{(x\_0, u\_0)}$$

Step 5: Linearize the Output Equation $y \= g(x, u)$  
The exact same process is applied to the output function $g(x, u)$:

$$y \= y\_0 \+ \\Delta y \\approx g(x\_0, u\_0) \+ \\left. \\frac{\\partial g}{\\partial x} \\right|\_{(x\_0, u\_0)}(x \- x\_0) \+ \\left. \\frac{\\partial g}{\\partial u} \\right|\_{(x\_0, u\_0)}(u \- u\_0)$$Since $y\_0 \= g(x\_0, u\_0)$, this simplifies to:$$\\Delta y \\approx \\left\[ \\left. \\frac{\\partial g}{\\partial x} \\right|\_{(x\_0, u\_0)} \\right\] \\Delta x \+ \\left\[ \\left. \\frac{\\partial g}{\\partial u} \\right|\_{(x\_0, u\_0)} \\right\] \\Delta u$$  
4

**Step 6: Define Matrices C and D**

* **Output Matrix (C):** $C \\equiv \\left. \\frac{\\partial g}{\\partial x} \\right|\_{(x\_0, u\_0)}$ 4  
* **Feedthrough Matrix (D):** $D \\equiv \\left. \\frac{\\partial g}{\\partial u} \\right|\_{(x\_0, u\_0)}$ 4

### **3.3 The Final Linearized (Small-Signal) Model**

The result of this derivation is a standard Linear Time-Invariant (LTI) state-space system that describes the system's dynamics in terms of the *deviation variables*:

$$\\Delta\\dot{x} \= A\\Delta x \+ B\\Delta u$$  
$$\\Delta y \= C\\Delta x \+ D\\Delta u$$  
This LTI model describes the *small-signal dynamics* of the nonlinear system *around* the chosen operating point $(x\_0, u\_0)$.4

This derivation reveals a critical concept: the linearized model's properties are *local* to the operating point, not global. The matrices $A, B, C,$ and $D$ are the *result* of evaluating partial derivatives (which are functions of $x$ and $u$) at the *specific point* $(x\_0, u\_0)$.4 For a nonlinear system, the values of these partial derivatives will change as the operating point changes.

For example, the linearized aerodynamic model of a missile at (Mach 0.8, 2° angle of attack) will be represented by a completely different set of $A$ and $B$ matrices than the model at (Mach 2.0, 15° angle of attack).18 This fact is the fundamental motivation for **Gain Scheduling**, an advanced control technique where a *family* of linear models is pre-computed at various operating points, and the controller parameters are interpolated between them in real-time.19

## **4\. Small-Signal Modeling in Engineering Practice**

In engineering disciplines, particularly electronics and mechanics, this linearization process is known as **small-signal modeling**.

### **4.1 Conceptual Framework: The Quiescent Operating Point (Q-Point)**

In electronics, the equilibrium point $(x\_0, u\_0)$ is called the **Quiescent Operating Point**, or **Q-Point**.21 This point represents the steady-state, DC (Direct Current) bias condition of a circuit, established by DC voltage and current sources.22

The "small signals" are the AC (Alternating Current) or time-varying perturbations that are superimposed on top of this DC bias.22 A common notational convention is used to distinguish between these components:

* $V\_{BE}$: The DC Q-point value (e.g., 0.7 V)  
* $v\_{be}(t)$: The small, time-varying AC signal (e.g., $0.01 \\sin(\\omega t)$ V)  
* $v\_{BE}(t) \= V\_{BE} \+ v\_{be}(t)$: The total, instantaneous signal (e.g., $0.7 \+ 0.01 \\sin(\\omega t)$ V) 21

Small-signal analysis is the process of finding the linear model (the $A, B, C, D$ matrices, or equivalent circuit parameters) that describes the relationships between the small AC signals (e.g., $v\_{be}, i\_c, v\_{ce}$).22

### **4.2 Case Study 1: The Simple Pendulum**

This canonical example from mechanics perfectly illustrates how linearization at different equilibria yields fundamentally different dynamic models.

Nonlinear Model: From Newton's laws 6 or Lagrangian mechanics 5, the equation of motion for a damped pendulum with an input torque $u(t)$ is:

$$I\\ddot{\\theta} \+ b\\dot{\\theta} \+ mgl\\sin\\theta \= u(t)$$

where $I$ is the moment of inertia (e.g., $I \= ml^2$), $b$ is the damping coefficient, $l$ is the length, and $g$ is gravity.  
Nonlinear State-Space Form: We define the state vector $x \= \[x\_1, x\_2\]^T \= \[\\theta, \\dot{\\theta}\]^T$.6  
The state equations $\\dot{x} \= f(x, u)$ are:

$$\\dot{x}\_1 \= x\_2$$  
$$\\dot{x}\_2 \= \\ddot{\\theta} \= \-\\frac{mgl}{I}\\sin(x\_1) \- \\frac{b}{I}x\_2 \+ \\frac{1}{I}u(t)$$  
**Equilibrium Analysis:** We find the equilibria for a constant input $u\_0 \= 0$. This requires $f(x\_0, 0\) \= 0$:

1. $\\dot{x}\_{1,0} \= x\_{2,0} \= 0$  
2. $\\dot{x}\_{2,0} \= \-\\frac{mgl}{I}\\sin(x\_{1,0}) \= 0$  
   This implies that $x\_{2,0} \= 0$ and $x\_{1,0} \= n\\pi$ for $n \= 0, \\pm 1, \\pm 2, \\dots$ These are the multiple isolated equilibrium points characteristic of a nonlinear system.3

Linearization (Jacobian Computation): We compute the state matrix $A \= \\left. \\frac{\\partial f}{\\partial x} \\right|\_{(x\_0, 0)}$:

$$A \= \\begin{bmatrix} \\frac{\\partial f\_1}{\\partial x\_1} & \\frac{\\partial f\_1}{\\partial x\_2} \\\\ \\frac{\\partial f\_2}{\\partial x\_1} & \\frac{\\partial f\_2}{\\partial x\_2} \\end{bmatrix} \= \\begin{bmatrix} 0 & 1 \\\\ \-\\frac{mgl}{I}\\cos(x\_1) & \-\\frac{b}{I} \\end{bmatrix}$$  
Crucially, the $A$ matrix is a function of the state $x\_1$. Its value, and thus the system's local dynamics, depends *entirely* on which equilibrium point we linearize around.

* Case A: Stable Equilibrium ($x\_0 \= ^T$)  
  Linearizing around the stable "hanging down" position, we evaluate $A$ at $x\_{1,0} \= 0$. Since $\\cos(0) \= 1$:

  $$A\_A \= \\begin{bmatrix} 0 & 1 \\\\ \-mgl/I & \-b/I \\end{bmatrix}$$

  The characteristic equation is $\\lambda^2 \+ (b/I)\\lambda \+ (mgl/I) \= 0$. This is the standard equation for a stable, damped linear oscillator. This model is equivalent to using the "small angle approximation" $\\sin \\theta \\approx \\theta$.6  
* Case B: Unstable Equilibrium ($x\_0 \= \[\\pi, 0\]^T$)  
  Linearizing around the unstable "inverted pendulum" position, we evaluate $A$ at $x\_{1,0} \= \\pi$. Since $\\cos(\\pi) \= \-1$:

  $$A\_B \= \\begin{bmatrix} 0 & 1 \\\\ \+mgl/I & \-b/I \\end{bmatrix}$$

  The characteristic equation is $\\lambda^2 \+ (b/I)\\lambda \- (mgl/I) \= 0$. This equation has one positive real root ($\\lambda \> 0$), proving that this equilibrium point is unstable (a saddle point).10

This example proves that the *same* nonlinear system can generate *different* linear models with *opposite* stability properties, depending on the chosen operating point.

### **Table 2: Linearization of the Simple Pendulum**

| Parameter | Nonlinear Model | Linearization at x0​=T (Stable) | Linearization at x0​=\[π,0\]T (Unstable) |
| :---- | :---- | :---- | :---- |
| **Operating Point** | N/A | $x\_{1,0} \= 0$ (hanging down) | $x\_{1,0} \= \\pi$ (inverted) |
| **Nonlinear Term** | $\\sin(x\_1)$ | $\\sin(x\_1) \\approx x\_1$ | $\\sin(x\_1) \\approx \- (x\_1 \- \\pi)$ |
| **Jacobian Term ($A\_{21}$)** | $-\\frac{mgl}{I}\\cos(x\_1)$ | $A\_{21} \= \-\\frac{mgl}{I}$ | $A\_{21} \= \+\\frac{mgl}{I}$ |
| **Linearized Eq.** ($\\Delta x\_1 \= \\Delta\\theta$) | $\\ddot{\\theta} \+ \\frac{b}{I}\\dot{\\theta} \+ \\frac{mgl}{I}\\sin\\theta \= 0$ | $\\Delta\\ddot{\\theta} \+ \\frac{b}{I}\\Delta\\dot{\\theta} \+ \\frac{mgl}{I}\\Delta\\theta \= 0$ | $\\Delta\\ddot{\\theta} \+ \\frac{b}{I}\\Delta\\dot{\\theta} \- \\frac{mgl}{I}\\Delta\\theta \= 0$ |
| **Local Stability** | N/A | **Stable** (Node or Focus) | **Unstable** (Saddle Point) |

### **4.3 Case Study 2: The BJT Amplifier**

In electronics, the Bipolar Junction Transistor (BJT) is a highly nonlinear device.22 Its behavior is dominated by the exponential Ebers-Moll relationship between collector current $i\_C$ and base-emitter voltage $v\_{BE}$: $i\_C \\approx I\_S e^{v\_{BE} / V\_T}$.22

To use this device as an amplifier, a DC biasing circuit (using $V\_{CC}, R\_B, R\_C$) is designed to establish a specific Q-Point, $Q \= (I\_C, V\_{CE})$, in the "active region".21 For example, a Q-point might be set at $I\_C \= 22$ mA and $V\_{CE} \= 7$ V.24

Small-signal analysis is then used to derive a *linear equivalent circuit* that models the transistor's response to small AC signals. This is done by applying the single-variable linearization from Section 2.2 to the BJT's nonlinear $i$-$v$ characteristics at this Q-point.24 The resulting parameters form the **Hybrid-$\\pi$ model**.

* Parameter 1: Transconductance ($g\_m$)  
  This parameter is the "gain" of the device, relating the AC output current $i\_c$ to the AC input voltage $v\_{be}$. It is the slope of the $i\_C$-$v\_{BE}$ curve at the Q-point.

  $$g\_m \\equiv \\left. \\frac{\\partial i\_C}{\\partial v\_{BE}} \\right|\_Q \= \\left. \\frac{\\partial}{\\partial v\_{BE}} (I\_S e^{v\_{BE}/V\_T}) \\right|\_Q \= \\frac{1}{V\_T} (I\_S e^{V\_{BE}/V\_T}) \= \\frac{I\_C}{V\_T}$$

  where $I\_C$ is the DC bias current and $V\_T$ is the thermal voltage ($\\approx 25$ mV at room temperature).24  
* Parameter 2: Input Resistance ($r\_\\pi$)  
  This parameter relates the AC input current $i\_b$ to the AC input voltage $v\_{be}$. It is the slope of the $i\_B$-$v\_{BE}$ curve at the Q-point.

  $$r\_\\pi \\equiv \\left( \\left. \\frac{\\partial i\_B}{\\partial v\_{BE}} \\right|\_Q \\right)^{-1} \= \\left( \\left. \\frac{\\partial (i\_C / \\beta)}{\\partial v\_{BE}} \\right|\_Q \\right)^{-1} \= \\left( \\frac{1}{\\beta} \\left. \\frac{\\partial i\_C}{\\partial v\_{BE}} \\right|\_Q \\right)^{-1} \= \\left( \\frac{g\_m}{\\beta} \\right)^{-1} \= \\frac{\\beta}{g\_m}$$

  where $\\beta$ is the transistor's current gain.24  
* Parameter 3: Output Resistance ($r\_o$)  
  This parameter models the Early effect, a secondary nonlinearity where the collector-emitter voltage $v\_{CE}$ slightly affects the collector current $i\_C$.

  $$r\_o \\equiv \\left( \\left. \\frac{\\partial i\_C}{\\partial v\_{CE}} \\right|\_Q \\right)^{-1} \= \\left( \\frac{I\_C}{V\_A \+ V\_{CE}} \\right)^{-1} \= \\frac{V\_A \+ V\_{CE}}{I\_C}$$

  where $V\_A$ is the Early Voltage, a device parameter.24

For AC analysis, the complex nonlinear transistor is *replaced* entirely by a simple linear circuit (the Hybrid-$\\pi$ model) consisting of these three linear components: a resistor $r\_\\pi$, a resistor $r\_o$, and a voltage-controlled current source $g\_m v\_{be}$.24 This linearized model is the foundation of virtually all analog amplifier design.24

### **Table 3: BJT Small-Signal Model Parameters (Hybrid-$\\pi$)**

| Parameter | Symbol | Formula (at Q-Point) | Depends on... | Physical Meaning (AC Signals) | Source |
| :---- | :---- | :---- | :---- | :---- | :---- |
| **Transconductance** | $g\_m$ | $\\frac{I\_C}{n V\_T}$ | DC Collector Current $I\_C$ | $i\_c / v\_{be}$ (Voltage-controlled gain) | 24 |
| **Input Resistance** | $r\_\\pi$ | $\\frac{\\beta}{g\_m} \= \\frac{n V\_T \\beta}{I\_C}$ | DC Collector Current $I\_C$ | $v\_{be} / i\_b$ (AC input resistance) | 24 |
| **Output Resistance** | $r\_o$ | $\\frac{V\_A \+ V\_{CE}}{I\_C}$ | $I\_C$, $V\_{CE}$, and Early Voltage $V\_A$ | $v\_{ce} / i\_c$ (AC output resistance) | 24 |

## **5\. Control-Oriented Modeling**

The final part of the query concerns how these linearized models are *used* for controller design. This practice is known as **control-oriented modeling**.

### **5.1 Definition: Control-Oriented Modeling**

Control-oriented modeling is a pragmatic modeling philosophy, prominently featured in works by authors such as Åström and Murray.28 The objective is not to create a perfectly faithful, high-order model of a physical process, but rather to develop a model that is *just good enough* for its intended purpose: designing a feedback controller.29 This often involves significant simplification, order reduction, and linearization to capture only the dynamics relevant to the controller's action.29

Linearization is the essential translation layer that bridges the gap between the nonlinear real-world system and the powerful, systematic toolbox of linear control theory.8 It enables engineers to apply these mature, well-understood design methods to systems that are, in reality, nonlinear.

### **5.2 The Design Workflow: From Nonlinearity to Control**

The practical application of linearization for control follows a standard workflow:

1. **Model:** Start with the nonlinear state-space model of the system, $\\dot{x} \= f(x, u)$.30  
2. **Linearize:** Select a desired operating point $(x\_0, u\_0)$ and compute the Jacobian matrices $A, B, C, D$ to obtain the linear state-space model $\\Delta\\dot{x} \= A\\Delta x \+ B\\Delta u$.4  
3. **Convert:** Convert the LTI state-space model into a **Transfer Function** $G(s) \= C(sI-A)^{-1}B \+ D$. This $G(s)$ model linearly relates the *deviation* in input $\\Delta U(s)$ to the *deviation* in output $\\Delta Y(s)$ in the Laplace domain.  
4. **Design:** Use the linear model $G(s)$ (or the $A, B$ matrices) to design a standard linear controller $C(s)$ (e.g., a PID controller) to meet performance specifications.8  
5. **Implement:** Implement the resulting linear controller on the *original, full, nonlinear* system.

### **5.3 Application: PID Controller Design**

Proportional-Integral-Derivative (PID) control is the most common and widely deployed feedback control technique in engineering.8 The linearized model $G(s)$ is the tool used to *tune* the PID gains ($k\_p, k\_i, k\_d$).

Common design methods include:

* **Pole Placement:** The designer specifies the desired locations for the closed-loop system's poles (which determine the stability and response speed). The PID controller gains are then calculated algebraically to move the poles of the combined system $\\frac{C(s)G(s)}{1+C(s)G(s)}$ to these desired locations. This calculation is only possible if $G(s)$ is known.9  
* **Frequency-Domain Loop Shaping:** The Bode plot of the linearized model $G(s)$ is analyzed. The PID controller is then designed to "shape" the open-loop response $C(s)G(s)$ to achieve specified **gain margins** and **phase margins**, which guarantee robustness and stability.8  
* **Optimization-Based Tuning:** Modern software tools (e.g., in MATLAB) use the linearized model to numerically optimize the PID gains.31 The process, as described for the Control System Designer, involves:  
  1. Providing the linearized plant model to the tool.31  
  2. Specifying the controller parameters to be optimized ($P, I, D$).31  
  3. Defining graphical or numerical design requirements (e.g., "Phase Margin $\> 60$ deg", "Step response settling time $\< 2$ s", "Controller output bounds $\< 550$").31  
  4. An optimization algorithm (e.g., gradient descent) then numerically searches for the $P, I, D$ values that best meet all specified requirements.31

### **5.4 Extending the Model: Gain Scheduling**

A single linear model is only valid near *one* operating point. If a system (like an aircraft or a chemical reactor) must operate over a wide range of conditions, its dynamics change, and the $A, B$ matrices change with them.

**Gain Scheduling** is the practical solution to this problem.19 It is a nonlinear control strategy built from a "family" of linear models:

1. The system is linearized at *multiple* operating points across its operational envelope.  
2. A separate linear controller (e.g., a PID controller) is designed and tuned for *each* operating point.  
3. The resulting controller gains are stored in a lookup table, parameterized by the scheduling variables (e.g., altitude, Mach number).  
4. In real-time, the system measures its current operating point and interpolates the correct controller gains from the table.

In this way, gain scheduling creates a robust nonlinear controller by "patching together" a collection of locally valid linear controllers.20

## **6\. Limitations of Linearization and Local Stability**

While powerful, linearization is an approximation. A rigorous understanding of its limitations is essential to avoid critical design failures.

### **6.1 The Scope of Validity: Local vs. Global**

The primary limitation is that the linear model is *only* valid in a small neighborhood around the operating point.3 It can predict the *local* behavior but *cannot* predict "nonlocal" or "global" behavior.3 If the system's state or input perturbations are large, the truncated higher-order terms become significant, and the linear model's predictions will be inaccurate.

### **6.2 Formalizing the Limitation: Lyapunov's Linearization Method**

The relationship between the stability of the linear model and the stability of the original nonlinear system is formally described by **Lyapunov's Linearization Method** (related to the Hartman-Grobman Theorem).11

Let $x\_0$ be an equilibrium point and let $A \= \\left. \\frac{\\partial f}{\\partial x} \\right|\_{x\_0}$ be the Jacobian matrix at that point. The stability of the nonlinear system at $x\_0$ is related to the eigenvalues ($\\lambda\_i$) of $A$:

* Case 1: Asymptotic Stability (Trust the Model)  
  If all eigenvalues of $A$ have strictly negative real parts ($\\text{Re}(\\lambda\_i) \< 0$ for all $i$), then the equilibrium point $x\_0$ of the original nonlinear system is locally asymptotically stable.11  
* Case 2: Instability (Trust the Model)  
  If at least one eigenvalue of $A$ has a strictly positive real part ($\\text{Re}(\\lambda\_j) \> 0$), then the equilibrium point $x\_0$ of the original nonlinear system is unstable.11  
* Case 3: The Inconclusive Case (Do NOT Trust the Model)  
  If all eigenvalues of $A$ have non-positive real parts ($\\text{Re}(\\lambda\_i) \\leq 0$), but at least one eigenvalue lies exactly on the imaginary axis ($\\text{Re}(\\lambda\_k) \= 0$), then the linearization method is inconclusive.11 The linear model cannot determine the stability of the nonlinear system.

The inconclusive case (Case 3\) arises because the linearization $\\Delta\\dot{x} \= A\\Delta x$ is only "marginally stable" (its solutions, like pure sinusoids, neither decay to zero nor grow to infinity). In this "knife-edge" scenario, the system's true fate is determined by the *higher-order terms* that were truncated and discarded during the approximation. The linear model is, by definition, blind to these deciding factors.11

### **6.3 "Essentially Nonlinear Phenomena" Lost in Approximation**

By its very nature, a linear model is structurally incapable of predicting any phenomena that can only be produced by nonlinearity.3 A control engineer who relies exclusively on a linearized model will be completely blind to the following possibilities in the true system 3:

* **Multiple Isolated Equilibria:** The linear model only "sees" the single equilibrium point it was built around.  
* **Limit Cycles:** Stable, self-sustaining oscillations.  
* **Chaos:** Bounded, non-periodic, deterministic, and highly sensitive behavior.  
* **Finite Escape Time:** Solutions that diverge to infinity in a finite amount of time.  
* **Sub/Super-harmonic Oscillations:** A nonlinear system driven by a sine wave at frequency $\\omega$ can respond at frequencies $2\\omega$, $\\frac{1}{2}\\omega$, etc. A linear system can only respond at $\\omega$.

## **7\. Conclusion**

Linearization and small-signal analysis represent one of the most powerful and fundamental techniques in engineering. By approximating a complex, nonlinear system with a locally valid linear model, this method unlocks the entire-well-developed arsenal of linear systems theory for analysis and controller design. The process is mathematically rooted in the Taylor series expansion, with the Jacobian matrix providing the $A, B, C,$ and $D$ matrices of the resulting linear state-space model.

This approach is the enabling technology for the vast majority of practical control systems, from PID-controlled industrial processes to gain-scheduled aerospace vehicles and small-signal-modeled electronic amplifiers. However, its power is predicated on a rigorous understanding of its primary limitation: the model is an approximation, valid *only* in a "local" neighborhood of a specific operating point. It cannot, and must not, be used to predict the rich, complex, and often critical "global" behaviors that are the exclusive domain of the original nonlinear system.

#### **Works cited**

1. Part IV: Linearization, accessed October 29, 2025, [http://alvarestech.com/temp/smar/PID-MatLab-Simulink/ch04.pdf](http://alvarestech.com/temp/smar/PID-MatLab-Simulink/ch04.pdf)  
2. Nonlinear Systems \- Third Edition, accessed October 29, 2025, [https://dl.icdst.org/pdfs/files3/d83d2dc7280085b61da330c9a8ff5e13.pdf](https://dl.icdst.org/pdfs/files3/d83d2dc7280085b61da330c9a8ff5e13.pdf)  
3. Nonlinear Control Lecture \# 1 Introduction \- MSU College of ..., accessed October 29, 2025, [https://www.egr.msu.edu/\~khalil/NonlinearControl/Slides-Full/Lect\_1.pdf](https://www.egr.msu.edu/~khalil/NonlinearControl/Slides-Full/Lect_1.pdf)  
4. State Space Models, Linearization, Transfer Function \- Automatic ..., accessed October 29, 2025, [https://www.control.lth.se/fileadmin/control/Education/EngineeringProgram/FRTF05\_China/slides\_Lec2\_20191029.pdf](https://www.control.lth.se/fileadmin/control/Education/EngineeringProgram/FRTF05_China/slides_Lec2_20191029.pdf)  
5. 6.832 chapter 2, Nonlinear dynamics of the simple pendulum \- MIT ..., accessed October 29, 2025, [https://ocw.mit.edu/courses/6-832-underactuated-robotics-spring-2009/3cef43edc8819f9f3df4dd2d8c18abfa\_MIT6\_832s09\_read\_ch02.pdf](https://ocw.mit.edu/courses/6-832-underactuated-robotics-spring-2009/3cef43edc8819f9f3df4dd2d8c18abfa_MIT6_832s09_read_ch02.pdf)  
6. Systems Analysis and Control \- Lecture 3 ... \- Matthew M. Peet, accessed October 29, 2025, [https://control.asu.edu/Classes/MAE318/318Lecture03.pdf](https://control.asu.edu/Classes/MAE318/318Lecture03.pdf)  
7. Feedback Systems Karl JohanÅström Richard M. Murray, accessed October 29, 2025, [https://www.cds.caltech.edu/\~murray/books/AM08/pdf/fbs-author\_29Mar19.pdf](https://www.cds.caltech.edu/~murray/books/AM08/pdf/fbs-author_29Mar19.pdf)  
8. Feedback Systems: An Introduction for Scientists and Engineers \- Duke People, accessed October 29, 2025, [https://people.duke.edu/\~hpgavin/SystemID/References/Astrom-Feedback-2006.pdf](https://people.duke.edu/~hpgavin/SystemID/References/Astrom-Feedback-2006.pdf)  
9. Easy Pole Placement Method for PID Controller Design \- Control Engineering Tutorial 1, accessed October 29, 2025, [https://www.youtube.com/watch?v=CUtDKQvp8Pg](https://www.youtube.com/watch?v=CUtDKQvp8Pg)  
10. Nonlinear Systems and Control Lecture \# 4 Qualitative Behavior Near Equilibrium Points & Multiple Equilibria, accessed October 29, 2025, [https://www.egr.msu.edu/\~khalil/NonlinearSystems/Sample/Lect\_4.pdf](https://www.egr.msu.edu/~khalil/NonlinearSystems/Sample/Lect_4.pdf)  
11. Slotine • Li APPLIED NONLINEAR CONTROL \- F.L. Lewis, accessed October 29, 2025, [https://lewisgroup.uta.edu/ee5323/notes/Slotine%20and%20Li%20applied%20nonlinear%20control-%20bad%20quality.pdf](https://lewisgroup.uta.edu/ee5323/notes/Slotine%20and%20Li%20applied%20nonlinear%20control-%20bad%20quality.pdf)  
12. Taylor's theorem \- Wikipedia, accessed October 29, 2025, [https://en.wikipedia.org/wiki/Taylor%27s\_theorem](https://en.wikipedia.org/wiki/Taylor%27s_theorem)  
13. Linearization via Taylor Series \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=vpq2n-oj8Gc](https://www.youtube.com/watch?v=vpq2n-oj8Gc)  
14. Linear Approximation \- Linearization with Taylor Series \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=V1uvK4Ii\_ks](https://www.youtube.com/watch?v=V1uvK4Ii_ks)  
15. 1.7: Linearization of Nonlinear Models \- Engineering LibreTexts, accessed October 29, 2025, [https://eng.libretexts.org/Bookshelves/Industrial\_and\_Systems\_Engineering/Introduction\_to\_Control\_Systems\_(Iqbal)/01%3A\_Mathematical\_Models\_of\_Physical\_Systems/1.07%3A\_Linearization\_of\_Nonlinear\_Models](https://eng.libretexts.org/Bookshelves/Industrial_and_Systems_Engineering/Introduction_to_Control_Systems_\(Iqbal\)/01%3A_Mathematical_Models_of_Physical_Systems/1.07%3A_Linearization_of_Nonlinear_Models)  
16. Chapter 3 Nonlinear Systems \- Differential Equations \- UNCW, accessed October 29, 2025, [https://people.uncw.edu/hermanr/mat463/odebook/book/nonlinear.pdf](https://people.uncw.edu/hermanr/mat463/odebook/book/nonlinear.pdf)  
17. Matrices, Linearization, and the Jacobi matrix \- Theoretical Biology & Bioinformatics, accessed October 29, 2025, [https://tbb.bio.uu.nl/rdb/books/math.pdf](https://tbb.bio.uu.nl/rdb/books/math.pdf)  
18. 19 Jacobian Linearizations, equilibrium points \- Graduate Degree in Control \+ Dynamical Systems, accessed October 29, 2025, [http://www.cds.caltech.edu/\~murray/courses/cds101/fa02/caltech/pph02-ch19-23.pdf](http://www.cds.caltech.edu/~murray/courses/cds101/fa02/caltech/pph02-ch19-23.pdf)  
19. Nonlinear Systems, accessed October 29, 2025, [https://flyingv.ucsd.edu/krstic/files/Khalil-3rd.pdf](https://flyingv.ucsd.edu/krstic/files/Khalil-3rd.pdf)  
20. PID Control System Design and Automatic Tuning using MATLAB/Simulink, accessed October 29, 2025, [http://alvarestech.com/temp/smar/PID-MatLab-Simulink/PID-MatlabSimulink.pdf](http://alvarestech.com/temp/smar/PID-MatLab-Simulink/PID-MatlabSimulink.pdf)  
21. Chapter 13 Small-Signal Modeling and Linear Amplification \- Purdue College of Engineering, accessed October 29, 2025, [https://engineering.purdue.edu/\~ee255d3/files/MCD4thEdChap13%20\[Compatibility%20Mode\].pdf](https://engineering.purdue.edu/~ee255d3/files/MCD4thEdChap13%20[Compatibility%20Mode].pdf)  
22. ECE 255, BJT Small Signal Analysis \- Purdue Engineering, accessed October 29, 2025, [https://engineering.purdue.edu/wcchew/ece255s18/ece%20255%20s18%20latex%20pdf%20files/ece255Lecture\_12\_Feb22\_BJT\_Small\_Signals.pdf](https://engineering.purdue.edu/wcchew/ece255s18/ece%20255%20s18%20latex%20pdf%20files/ece255Lecture_12_Feb22_BJT_Small_Signals.pdf)  
23. Small Signal Modeling: Linearization \- UTK-EECS, accessed October 29, 2025, [https://web.eecs.utk.edu/\~dcostine/ECE481/Fall2024/lectures/L24\_out.pdf](https://web.eecs.utk.edu/~dcostine/ECE481/Fall2024/lectures/L24_out.pdf)  
24. IV. Transistors (Biasing & Small-Signal Model), accessed October 29, 2025, [http://web.eng.ucsd.edu/ece/groups/electromagnetics/Classes/ECE65Fall2010/FN-Notes/main/transistor-2.pdf](http://web.eng.ucsd.edu/ece/groups/electromagnetics/Classes/ECE65Fall2010/FN-Notes/main/transistor-2.pdf)  
25. How to linearize the nonlinear ODE for a simple pendulum \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=Lcadejv383M](https://www.youtube.com/watch?v=Lcadejv383M)  
26. 3.5: Nonlinear Pendulum \- Mathematics LibreTexts, accessed October 29, 2025, [https://math.libretexts.org/Bookshelves/Differential\_Equations/A\_Second\_Course\_in\_Ordinary\_Differential\_Equations%3A\_Dynamical\_Systems\_and\_Boundary\_Value\_Problems\_(Herman)/03%3A\_Nonlinear\_Systems/3.05%3A\_Nonlinear\_Pendulum](https://math.libretexts.org/Bookshelves/Differential_Equations/A_Second_Course_in_Ordinary_Differential_Equations%3A_Dynamical_Systems_and_Boundary_Value_Problems_\(Herman\)/03%3A_Nonlinear_Systems/3.05%3A_Nonlinear_Pendulum)  
27. Transistor Small Signal Analysis \- YouTube, accessed October 29, 2025, [https://www.youtube.com/watch?v=18x\_xFnq4-M](https://www.youtube.com/watch?v=18x_xFnq4-M)  
28. (PDF) Feedback Systems: An Introduction for Scientists and Engineers \- ResearchGate, accessed October 29, 2025, [https://www.researchgate.net/publication/36721090\_Feedback\_Systems\_An\_Introduction\_for\_Scientists\_and\_Engineers](https://www.researchgate.net/publication/36721090_Feedback_Systems_An_Introduction_for_Scientists_and_Engineers)  
29. Tools for Nonlinear Control Systems Analysis and Design for Aeroengines \- DTIC, accessed October 29, 2025, [https://apps.dtic.mil/sti/tr/pdf/ADA388233.pdf](https://apps.dtic.mil/sti/tr/pdf/ADA388233.pdf)  
30. Tuning of PID Controllers Using Reinforcement Learning for Nonlinear System Control, accessed October 29, 2025, [https://www.mdpi.com/2227-9717/13/3/735](https://www.mdpi.com/2227-9717/13/3/735)  
31. Design Optimization-Based PID Controller for Linearized Simulink ..., accessed October 29, 2025, [https://www.mathworks.com/help/sldo/gs/design-an-optimization-based-pid-controller-for-a-linearized-simulink-model.html](https://www.mathworks.com/help/sldo/gs/design-an-optimization-based-pid-controller-for-a-linearized-simulink-model.html)  
32. Applied Nonlinear Control, accessed October 29, 2025, [https://lewisgroup.uta.edu/ee5323/notes/slotine%20and%20Li-%20Applied%20Non-linear%20Control-%2060Mb.pdf](https://lewisgroup.uta.edu/ee5323/notes/slotine%20and%20Li-%20Applied%20Non-linear%20Control-%2060Mb.pdf)