# PMSM Control using PI, MPC and ANN

## Overview

This repository presents a comparative study of **Permanent Magnet Synchronous Motor (PMSM)** control using:

* PI Controller
* Model Predictive Control (MPC)
* Artificial Neural Network (ANN)

The ANN model is trained using MPC-generated data to achieve similar performance with reduced computational effort.

---

## Comparative Study (Results & Data)

You can access the detailed comparative analysis, datasets, and observations here:
👉 https://docs.google.com/spreadsheets/d/1q4yJP4M1a96L_BiE_g8MZV8wghypp5aciNdSNgYPM5k/edit?usp=sharing

The study evaluates:

* Speed tracking performance
* Dynamic response
* Controller accuracy
* Switching losses

Such comparative analyses are essential in PMSM research to evaluate performance across different control strategies under identical conditions ([SeoulTech][1]).

---

## Repository Structure

```
PMSM_Control/
│
├── ANN Controller/
├── Comparitive Study PI and MPC/
├── Comparitive Study/
├── Minimizing_Switching_Losses/
├── References/
```

---

## Methodology

* **PI Controller**: Baseline conventional control
* **MPC**: Predictive control with improved dynamic response
* **ANN**:

  * Trained using MPC data
  * Inputs: Id, Iq, Id_ref, Iq_ref, rotor angle (θ), electrical speed (We)
  * Mimics MPC behavior

---

## Key Insights

* MPC outperforms PI in transient response
* ANN closely replicates MPC performance
* ANN reduces computational complexity
* Switching optimization improves efficiency

---

## Requirements

* MATLAB / Simulink
* Control System Toolbox
* Neural Network Toolbox

---

## How to Run

1. Open MATLAB
2. Navigate to required folder
3. Run simulation files
4. Use comparative study scripts for analysis

---

## Author

Anugrah Gupta

---

## License

For academic and research purposes only.

[1]: https://pure.seoultech.ac.kr/en/publications/model-predictive-torque-control-of-pmsm-for-ev-drives-a-comparati/?utm_source=chatgpt.com "Model predictive torque control of PMSM for EV drives: A comparative study of finite control set and predictive dead-beat control schemes - Seoul National University of Science & Technology"
