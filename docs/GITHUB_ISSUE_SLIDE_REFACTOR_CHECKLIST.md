# Checklist: Comprehensive Refactor of Presentation Slides and Derivations

This document outlines the full scope of work required to correct, enhance, and expand the presentation slides (11-15 and new additions) and their underlying source documents. The goal is to create a pedagogically sound and technically accurate educational resource for an undergraduate electrical engineering student.

---

## Part 1: Core Document Corrections (`COMPLETE_36_EQUATION_DERIVATION.md`)

**Priority:** This must be done first, as the slides depend on this document for accuracy.

-   [ ] **Topology 11:**
    -   [ ] Correct Equation 7: `dvC1/dt` should be `(-iL5) / C1`.
    -   [ ] Correct Equation 8: `dvC3/dt` should be `(-iL6) / C3`.
    -   [ ] Update `TOPOLOGY 11 SUMMARY` to reflect these changes.
    -   [ ] Replace `TOPOLOGY 11 MATRIX (A11)` with the fully corrected 9x9 matrix.

-   [ ] **Topology 10:**
    -   [ ] Correct Equation 8: `dvC3/dt` should be `iL1 / C3`.
    -   [ ] Correct Equation 9: `dvC0/dt` should be `(iL1 + iL6 - P/vC0) / C0`.
    -   [ ] Update `TOPOLOGY 10 SUMMARY` to reflect these changes.
    -   [ ] Replace `TOPOLOGY 10 MATRIX (A10)` with the fully corrected 9x9 matrix.

-   [ ] **Topology 01:**
    -   [ ] Correct Equation 7: `dvC1/dt` should be `iL2 / C1`.
    -   [ ] Correct Equation 9: `dvC0/dt` should be `(iL2 + iL5 - P/vC0) / C0`.
    -   [ ] Update `TOPOLOGY 01 SUMMARY` to reflect these changes.
    -   [ ] Replace `TOPOLOGY 01 MATRIX (A01)` with the fully corrected 9x9 matrix.

-   [ ] **Topology 00:**
    -   [ ] Correct Equation 7: `dvC1/dt` should be `iL2 / C1`.
    -   [ ] Correct Equation 8: `dvC3/dt` should be `iL1 / C3`.
    -   [ ] Update `TOPOLOGY 00 SUMMARY` to reflect these changes.
    -   [ ] Replace `TOPOLOGY 00 MATRIX (A00)` with the fully corrected 9x9 matrix.

---

## Part 2: Slide Restructuring and New Slide Creation

-   [ ] **Create New Slide 3: "Topology 11 (Switches ON)"**
    -   [ ] Present the corrected `A11`, `B11`, and `f_CPL` matrices.
    -   [ ] Include a simplified circuit diagram showing current paths for this topology.
    -   [ ] Add a clear explanation of the physical behavior (energy storage, reverse charging).

-   [ ] **Create New Slide 4: "Topology 10 (S1 ON, S2 OFF)"**
    -   [ ] Present the corrected `A10`, `B10`, and `f_CPL` matrices.
    -   [ ] Include a simplified circuit diagram for this topology.
    -   [ ] Explain the physical behavior.

-   [ ] **Create New Slide 5: "Topology 01 (S1 OFF, S2 ON)"**
    -   [ ] Present the corrected `A01`, `B01`, and `f_CPL` matrices.
    -   [ ] Include a simplified circuit diagram for this topology.
    -   [ ] Explain the physical behavior.

-   [ ] **Create New Slide 6: "Topology 00 (Switches OFF)"**
    -   [ ] Present the corrected `A00`, `B00`, and `f_CPL` matrices.
    -   [ ] Include a simplified circuit diagram for this topology.
    -   [ ] Explain the physical behavior.

-   [ ] **Create New Slide 7: "Summary of Per-Topology Matrices"**
    -   [ ] Create a summary table or view that shows all four `A_k` matrices side-by-side (or in a compact form) to highlight the differences between them.
    -   [ ] Explain that these individual models are the building blocks for the final averaged model.

---

## Part 3: Existing Slide Corrections and Enhancements

-   [ ] **Update `slide_11_state_space_form.html`:**
    -   [ ] **Title:** Change "Level 1 → Level 2" to "From Circuit Analysis to State-Space". Add text explaining that "Level 1" refers to basic KVL/KCL analysis on the circuit diagram, and "Level 2" is the process of organizing those equations into a structured matrix format.
    -   [ ] **Equation Correction:** Correct the explanatory text for `dvC1/dt`. Explicitly state that for Topology 11, `iC1 = -iL5`, leading to `dvC1/dt = (-iL5)/C1`.
    -   [ ] **Matrix Removal:** Remove the `A11` and `B11` matrix display from this slide, as it will now live on the new Slide 3.
    -   [ ] **Add Explanatory Content:** Add a new section titled "How an Equation Becomes a Matrix Row". Use the corrected `dvC1/dt` equation as an example to show how the coefficients of the state variables (`iL1`, `iL2`, etc.) in the equation directly map to the entries in the corresponding row of the state matrix `A`.

-   [ ] **Update `slide_12_averaging_methodology.html`:**
    -   [ ] **Elaborate on Introduction:** Expand the text "Each topology k has duration weight w..." to fully define `k` (as the index for topologies {11, 10, 01, 00}), explain that "duration weight" (`w_k`) is the fraction of the total switching period (`T_s`) that the system spends in that specific topology, and clarify that the constraint `Σw_k = 1` means the system must be in one of the four states at all times.
    -   [ ] **Explain Timing Diagrams:** Add a detailed explanation for the timing diagrams. Describe what the axes represent and how the intervals `d1*Ts`, `(1-d2)*Ts`, etc., are derived from the switch timings.
    -   [ ] **Derive Weight Equations:** Add a section that provides a logical derivation for the `w_k` formulas for both non-overlapping and overlapping cases, based on the timing diagrams.
    -   [ ] **Explain the 's' Variable:** Add a clear explanation for `s = sign(Vin)`. State that since the converter is a PFC rectifier, it must handle both positive and negative half-cycles of the AC input voltage. The `s` variable ensures the input voltage term `B_in,avg * V_in` contributes correctly regardless of `V_in`'s polarity.
    -   [ ] **Formatting:**
        -   Move the "Overlapping case" timing diagram and its description to a new line.
        -   Move the "Overlapping case" weight equations to a new line.
        -   Move the `B_in,avg` equation to a new line, separate from the `A_avg` equation.

---
