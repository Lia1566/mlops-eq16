# Student-performance-ml-eq16
## Team 16

### Overview
Binary classification model to predict student entrance exam performance (High Performance vs Lower Performance) using machine learning and MLOps best practices.

**Dataset**: UCI Machine Learning Repository - Student Performance on Entrance Examination
**Link** - https://archive.ics.uci.edu/dataset/582/student+performance+on+an+entrance+examination

---

## Requirements Analysis
**Problem statement:** Predict student performance using academic and demographic variables to enable early interventions and data-informed program decisions.

**Value proposition**
- **Students:** early identification for tutoring or program placement  
- **Institutions:** data-driven resource allocation and improved pass rates  
- **Stakeholders:** transparent, reproducible pipeline for ongoing policy and curriculum decisions  

**ML Canvas (summary)**
- **Users:** academic advisors, program directors  
- **Inputs:** cleaned tabular features from `data/raw/student_entry_performance_original.csv`  
- **Output:** binary class + probability  
- **Decision/action:** flag “at-risk” students for intervention  
- **Risks:** bias across gender/caste/medium; drift as curricula change  
- **KPIs:** Recall on “Lower” class, Balanced Accuracy, AUC; operational KPI = intervention hit rate  

> Full canvas in `docs/ML_Canvas.pdf`

---

## Data Manipulation & Preparation
All raw and processed data are DVC tracked under data/

| Stage                | Output                                                          | Description                             |
| -------------------- | --------------------------------------------------------------- | --------------------------------------- |
| **Raw Data**         | `data/raw/student_entry_performance_original.csv`               | Original dataset from UCI               |
| **Cleaned Data**     | `data/processed/student_performance_cleaned.csv`                | Duplicates removed, binary target added |
| **Encoded Data**     | `data/processed/student_performance_encoded.csv`                | Ordinal and one-hot encodings applied   |
| **Scaled Data**      | `data/processed/student_performance_binary_preprocessed.csv`    | Features scaled for modeling            |
| **Train/Test Split** | `student_performance_train.csv`, `student_performance_test.csv` | 80/20 stratified split                  |

---

## Data Exploration & Preprocessing
All analysis and visualization steps are documented in Jupyter notebooks and output to reports/figures/.
- Distribution plots, correlation heatmaps
- Class balance and categorical variable profiles
- Summary statistics and feature insights

---
## Data Versioning (DVC)

We implemented DVC to ensure reproducibility and collaboration across team members

```bash
# Initialize and configure
dvc init
git add .dvc .gitignore
git commit -m "Initialize DVC"

# Track processed datasets
dvc add data/processed/
git add data/processed.dvc
git commit -m "Track processed datasets"

# Reproduce pipeline
dvc repro

# Push artifacts
dvc push

```
**Documentation**
- Setuo instructions: `docs/DVC_SETUP_INSTRUCTIONS.txt`

Command reference: `docs/DVC_SETUP_COMMANDS.txt`

Change log summary: `docs/DATA_VERSIONING_SUMMARY.txt`

---
## Modeling, Tuning & Evaluation
- **Algorithms:** Logistic Regression, SVM, Random Forest, XGBoost, kNN, Baseline Majority  
- **Final baseline:** Linear SVM — Accuracy 71.2 %, Precision 67.3 %, Recall 67.3 %, F1 67.3 %, ROC-AUC 83.2 %  
- **Hyperparameter tuning:** Grid/Random search with cross-validation  
- **Selection criterion:** maximize Recall on “Lower” class, then AUC  

| Model | Accuracy | Precision | Recall | F1 | ROC-AUC |
|--------|-----------|-----------|--------|----------|
| Logistic Regression | 70.4% | 66.2% | 65.9% | 66.0% | 81.5% |
| Random Forest | 71.0% | 67.0% | 66.0% | 66.3% | 82.8% |
| Linear SVM (final) | 71.2% | 67.3% | 67.3% | 67.3% | 83.2% |

Artifacts:
- Confusion matrix and ROC curves: `reports/figures/model_evaluation_results.png`
- Model and scaler artifacts: `models/`
- Parameter definitions: `params.yaml`
- Pipeline: `dvc.yaml`
 
---
## GitHub Collaboration
- Active contributions from all members 
- Documented roles (DevOps, Software Engineer, Data Engineer, ML Engineer, Data Scientist)
- Roles were defined following MLOps best practices for clear ownership and reproducibility, 

### Team Members & Roles

| Role                  | Name                           | Responsibilities                                   |
| --------------------- | ------------------------------ | -------------------------------------------------- |
| **DevOps Engineer**   | Esteban Hidekel Solares Orozco | Git/DVC setup, CI/CD, pipeline orchestration       |
| **Software Engineer** | Jesús Antonio López Wayas      | Integration, documentation, and release versioning |
| **Data Engineer**     | Natalia Nevárez Tinoco         | Data ingestion, validation, and transformation     |
| **Data Scientist**    | Yander Alec Ortega Rosales     | Feature engineering, modeling, evaluation          |
| **ML Engineer**       | Roberto López Baldomero        | Model optimization, reproducibility, deployment    |

Detailed collaboration flow is available in `docs/ROLE_INTERACTIONS_DOCUMENTATION.txt`.
---

## Executive Presentation
- **File:** `docs/Fase1_equipo1.pdf`  
- Summarizes problem → value → data → model → results → risks → ops plan  
- Highlights actionable insights and limitations  

### Project Structure
```
mlops-eq16/
├── .dvc/
│   ├── config/
├── data/
│   ├── raw/
│       └── student_entry_performance_modified.csv
│       └── student_entry_performance_modified.csv.dvc
│       └── student_entry_performance_original.csv
│       └── student_entry_performance_original.csv.dvc
│   ├── interim/
│       └── student_entry_performance_eda.csv.dcv
│       └── student_entry_performance_binary_preprocessed.csv.dvc
│       └── student_entry_performance_cleaned.csv.dvc
│       └── student_entry_performance_encoded.csv.dvc
│       └── student_entry_preprocessed.csv.dvc
│       └── student_entry_test.csv.dvc
│       └── student_entry_train.csv.dvc
│   └── processed/
├── docs/
│   ├── DVC_SETUP_COMMANDS.txt
│   ├── DVC_SETUP_INSTRUCTIONS.txt
│   ├── PREPROCESSING_DOCUMENTATION.md
│   ├── ROLE_INTERACTIONS_DOCUMENTATION.txt
│   └── ML_Canvas.pdf
├── mlops/
│   ├── __init__.py
│   └── modeling/
│       └── __init__.py
├── models/
│   ├── best_model_gradient_boosting.pkl
│   ├── best_model_gradient_boosting.pkl.dvc
│   ├── scaler.pkl
│   └── scaler.pkl.dvc
├── notebooks/
│   └── phase1_team16 copy.ipynb
│   └── mlops-eq16_notebooks_phase1_team16.ipynb
│   └── mlops-eq16_notebooks_phase1_team16_out.ipynb
├── references/
├── reports/
│   └── figures/
│       └── model_evaluation_results.png
│       └── categorical_distributions_20251011_193439.png
│       └── correlation_heatmap_20251011_193711.png
│       └── parent_occupation_performance_20251011_193711.png
│       └── performance_analysis_20251011_193143.png
├── src/
│   ├── data/
│   ├── features/
│   ├── models/
│   └── visualization/
│   └── scripts/
│       └── init_dvc.sh
│       └── track_data_dvc.sh
├── .dvcignore
├── .gitignore
├── dvc.yaml
├── params.yaml
├── requirements.txt
└── README.md



```
## Quick Start

```bash
# Clone repository
git clone https://github.com/Lia1566/mlops-eq16.git
cd mlops-eq16

# Create and activate environment
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Pull data with DVC
dvc pull

# Run the full pipeline
dvc repro

# View metrics
dvc metrics show

```

## Technologies Used

Language: Python 3.x
ML Libraries: scikit-learn, pandas, numpy
Version Control: Git, DVC
Visualization: matplotlib, seaborn
Workflow: Jupyter Notebooks, papermill
Automation: Shell scripts under `/scripts`

## Project Pipeline

Raw Data (666 samples)
    ↓
Data Cleaning (remove 44 duplicates)
    ↓
Feature Engineering (binary target, encoding)
    ↓
Preprocessed Data (622 samples, 31 features)
    ↓
Train-Test Split (80/20)
    ↓
Model Training & Tuning (6 algorithms tested)
    ↓
Final Model: SVM (71.2% accuracy)


## Reproducibility

- Deterministic seeds in params.yaml
- All artifacts tracked via DVC
- Metrics + plots logged to reports/
- Exact steps encoded in dvc.yaml + notebooks


## Contributing

To contribute to this project, please follow the standard workflow below:
```bash
1. **Create a new branch**
git checkout -b feature/<short-descriptive-slug>
# example: git checkout -b feature/svm-grid-search

2. Stage and commit changes
git add .
git commit -m "feat: add SVM grid search pipeline"

3. Push your branch to the remote repository
git push origin feature/<short-descriptive-slug>

4. Open a Pull Request (PR)
- Assign the PR to the appropriate role owner (e.g., Data Scientist, ML Engineer).
- Request at least one teammate review before merging.
- Include a short summary of what changed and why.

5. Before merging
- Ensure all automated checks pass
- Verify DVC data and pipeline integrity
dvc pull && dvc repro

6. Merge
- Once approved, merge into the `main` brach
- Use squash merge to maintain clean, linear commit history

NOTES: Use clear and consistent branch names:
- feature/<feature-name> → new functionality
- fix/<issue-description> → bug fixes
- docs/<update-description> → documentation updates
- refactor/<component> → code restructuring without logic change
- experiment/<test-name> → model or parameter experiments

```

## Ethics & Responsible AI

- Monitor fairness metrics across sensitive attributes (e.g., gender, caste, medium)
- Implement feedback loop and periodic model review for drift

  
