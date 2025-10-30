# PAPER ANALYSIS: VINUKUMAR-LUCKOSE-ICCE2022
# Circuit Topology Extraction for System Order Verification

**Analysis Date:** October 28, 2025  
**Purpose:** Extract circuit topology details to verify 9th-order system claim

---

## CIRCUIT TOPOLOGY FROM PAPER (Fig. 3)

### Component List - Proposed Two-Stage, Two Phase Bridgeless Interleaved SEPIC

**From Paper Description (Section III):**

#### Phase 1 Components:
- **Input Inductors:** L2, L3
- **Capacitors:** C1, C2
- **Diodes:** D1, D2
- **Switch:** S1 (MOSFET)
- **Output Inductor:** L5

#### Phase 2 Components:
- **Input Inductors:** L1, L4
- **Capacitors:** C3, C4
- **Diodes:** D3, D4
- **Switch:** S2 (MOSFET)
- **Output Inductor:** L6

#### Common Components:
- **Output Capacitor:** C0 (DC link capacitor)
- **EMI Diodes:** D5, D6 (connect AC input to ground)
- **Output Diodes:** D7, D8 (mentioned in mode descriptions)

---

## ENERGY STORAGE ELEMENT COUNT

### Inductors (6 total):
1. **L1** - Phase 2 input inductor (negative cycle primary)
2. **L2** - Phase 1 input inductor (positive cycle primary)
3. **L3** - Phase 1 input inductor (negative cycle)
4. **L4** - Phase 2 input inductor (positive cycle)
5. **L5** - Phase 1 output inductor
6. **L6** - Phase 2 output inductor

### Capacitors (3 equivalent):
1. **C1, C2** - Phase 1 capacitors (can be modeled as C12 = C1||C2)
2. **C3, C4** - Phase 2 capacitors (can be modeled as C34 = C3||C4)
3. **C0** - Output DC link capacitor

---

## SYSTEM ORDER DETERMINATION

**Independent Energy Storage Elements:**
- Inductor currents: iL1, iL2, iL3, iL4, iL5, iL6 = **6 states**
- Capacitor voltages: vC12, vC34, vC0 = **3 states**

**TOTAL: 9 states → 9th-order system** ✅

---

## COMPARISON: PAPER vs. CODE vs. DOCUMENTATION

| Aspect | Paper (Fig. 3) | Current Code | Documentation Claim | Status |
|--------|----------------|--------------|---------------------|--------|
| **Inductors** | L1, L2, L3, L4, L5, L6 | L1a, L2a, L1b, L2b | L1, L2, L3, L4, L5, L6 | ⚠️ CODE MISSING L5, L6 |
| **Capacitors** | C1, C2, C3, C4, C0 | Csa, Csb, Cbus | C12, C34, C0 | ⚠️ NAMING MISMATCH |
| **System Order** | **9th** (6+3) | **7th** (4+3) | **9th** (6+3) | ❌ CODE WRONG |

---

## DESIGN PARAMETERS FROM PAPER (Table 1)

```
Input inductors (L1, L2, L3, L4): 1200 μH
Input capacitors (C1, C2, C3, C4): 0.5 μF
Output inductors (L5, L6): 1.2 H (!!!)
Output capacitor (C0): 500 μF
Input voltage: 70-230 Vrms
Output voltage: 100-320 V
Power: 500 W
Switching frequency: 50 kHz
```

**CRITICAL FINDING:** 
- **L5, L6 = 1.2 H** - These are VERY LARGE inductors (1000× larger than L1-L4)
- This confirms L5, L6 are OUTPUT FILTER INDUCTORS with significant energy storage
- **L5 and L6 CANNOT be neglected** - they are independent states

---

## MAPPING: PAPER NOTATION → DOCUMENTATION NOTATION

### Current Code (7th-order) Uses:
```
Phase A: iL1a, iL2a, vCsa
Phase B: iL1b, iL2b, vCsb
Common: vbus
```

### Correct 9th-order Mapping Should Be:

**Positive Half-Cycle Operation (Mode 1 & 2):**
- L2 charges → iL2 (Phase 1, positive input)
- L1 charges → iL1 (Phase 2, positive input)
- C1||C2 → vC12 (Phase 1 capacitor)
- C3||C4 → vC34 (Phase 2 capacitor)

**Negative Half-Cycle Operation (Mode 3 & 4):**
- L3 charges → iL3 (Phase 1, negative input)
- L4 charges → iL4 (Phase 2, negative input)

**Output Stage (Both Cycles):**
- L5 → iL5 (Phase 1 output inductor)
- L6 → iL6 (Phase 2 output inductor)
- C0 → vC0 (DC link capacitor)

**CORRECT STATE VECTOR (9th-order):**
```
x = [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vC0]ᵀ
```

---

## MODE OF OPERATION ANALYSIS

### Mode 1: Positive Half-Cycle, S1 and S2 ON (Fig. 4)

**From Paper:**
- L1 charges positive, L2 charges negative
- D1, D3 forward biased
- C1, C3 charge
- D7, D8 reverse biased (L5, L6 voltages reverse)

**Key Finding:** L5 and L6 are **ISOLATED** in this mode (no current path)
- This explains why diL5/dt = 0 and diL6/dt = 0 in Topology 11

---

### Mode 2: Positive Half-Cycle, S1 and S2 OFF (Fig. 5)

**From Paper:**
- L1, L2 discharge
- D7, D8 forward biased → voltage appears at output
- D1, D3 turn OFF
- D5 provides return path

**Key Finding:** L5 and L6 now **CONDUCT** and transfer energy to C0
- diL5/dt ≠ 0, diL6/dt ≠ 0 in this mode

---

### Mode 3: Negative Half-Cycle, S1 and S2 ON (Fig. 6)

**From Paper:**
- L3, L4 charge in negative cycle
- D2, D4 ON
- C2, C4 charge
- D7, D8 reverse biased

**Key Finding:** Similar to Mode 1, L5 and L6 **ISOLATED**

---

### Mode 4: Negative Half-Cycle, S1 and S2 OFF (Fig. 7)

**From Paper:**
- L3, L4 discharge
- D7, D8 forward biased
- Voltage at output through C0

**Key Finding:** L5 and L6 **CONDUCT** and transfer energy

---

## CRITICAL INSIGHT: WHY L5 AND L6 ARE INDEPENDENT STATES

### Physical Role:
1. **L5 and L6 are OUTPUT INDUCTORS** (1.2 H each)
2. They provide **low-frequency filtering** at DC output
3. They are in the **POWER DELIVERY PATH** to load

### Dynamic Behavior:
- **Mode 1 & 3 (Switches ON):** L5, L6 isolated → diL5/dt = 0, diL6/dt = 0
- **Mode 2 & 4 (Switches OFF):** L5, L6 conduct → diL5/dt ≠ 0, diL6/dt ≠ 0

### Why Not Lumpable with L1-L4:
1. **Different voltage dynamics** - L5/L6 see DC bus voltage, L1-L4 see AC input
2. **Different current paths** - L5/L6 feed load, L1-L4 charge capacitors
3. **Different time constants** - L5/L6 are 1000× larger inductance
4. **Cannot be eliminated by CCM assumption** - They actively store/release energy

**CONCLUSION:** L5 and L6 MUST be modeled as independent states → **9th-order is correct**

---

## VERIFICATION OF DOCUMENTATION CLAIMS

### README.md Claim: "9th-order system"
**Status:** ✅ **CORRECT** based on paper circuit topology

### MATLAB Code: "7th-order implementation"
**Status:** ❌ **INCORRECT** - Missing L5 and L6 states

### Issue Description: "36 equations (4 topologies × 9 states)"
**Status:** ✅ **CORRECT** expectation

---

## RECOMMENDED STATE VARIABLE NAMING

To align with paper and avoid confusion:

**Option 1: Paper Notation (Direct)**
```
x = [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vC0]ᵀ

Where:
- iL1: Phase 2, positive/negative cycle input inductor
- iL2: Phase 1, positive cycle input inductor
- iL3: Phase 1, negative cycle input inductor
- iL4: Phase 2, positive/negative cycle input inductor
- iL5: Phase 1 output inductor
- iL6: Phase 2 output inductor
- vC12: Phase 1 capacitor voltage (C1||C2)
- vC34: Phase 2 capacitor voltage (C3||C4)
- vC0: DC link voltage
```

**Option 2: Symmetric Phase Notation**
```
x = [iL1a_in, iL1a_out, vCa, iL1b_in, iL1b_out, vCb, iL2a_in, iL2a_out, vbus]ᵀ
```

**Recommendation:** Use **Option 1** to match paper directly

---

## NEXT STEPS FOR CODE UPDATE

### Required Changes to build_per_topology_matrices.m:

1. **Add symbolic variables:**
```matlab
syms L1 L2 L3 L4 L5 L6 C12 C34 C0 real
```

2. **Expand state vector to 9:**
```matlab
% State vector: x = [iL1, iL2, iL3, iL4, iL5, iL6, vC12, vC34, vC0]'
```

3. **Define 9×9 matrices for each topology:**
```matlab
A11 = sym(zeros(9,9));
A10 = sym(zeros(9,9));
A00 = sym(zeros(9,9));
A01 = sym(zeros(9,9));
```

4. **Derive all 36 equations** from circuit analysis

---

## CONCLUSION

**DEFINITIVE ANSWER:** The paper describes a **9th-order system** with:
- 6 inductors (L1, L2, L3, L4, L5, L6)
- 3 capacitor groups (C1||C2, C3||C4, C0)

**L5 and L6 are critical output filter inductors that:**
- Store significant energy (1.2 H each)
- Have independent dynamics
- Cannot be lumped with input inductors
- Are essential for proper converter operation

**Current MATLAB code is INCOMPLETE** - it implements only 4 of 6 inductor states

**Required Action:** Rewrite MATLAB code to full 9th-order implementation

---

END OF PAPER ANALYSIS
