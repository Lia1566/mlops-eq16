# Student-performance-ml-eq16
## Team 16

### Overview
Binary classification model to predict student entrance exam performance (High Performance vs Lower Performance) using machine learning and MLOps best practices.

**Dataset**: UCI Machine Learning Repository - Student Performance on Entrance Examination
**Link** - https://archive.ics.uci.edu/dataset/582/student+performance+on+an+entrance+examination

---

## Requirements Analysis
**Problem statement:** Predict whether a student’s entrance-exam performance is *High* or *Lower* using demographic and academic features to inform targeted support.

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
- **EDA notebook:** `notebooks/01_EDA.ipynb`  
- **Cleaning & validation:** `notebooks/02_Data_Preprocessing.ipynb`  
- Handled null/empty values, inconsistencies, outliers, invalid categories.  
- **Transformations for modeling:** type casting, encoding, scaling, train/test split.  
- **Metrics tracked:** row counts, duplicates removed, feature cardinalities, class balance.

---

## Data Exploration & Preprocessing
- **Descriptive statistics & visuals:** distributions, correlations, target balance (`reports/figures/`).  
- **Preprocessing techniques:**
  - Normalization/Standardization  
  - Categorical encoding (One-Hot / Ordinal)  
  - Dimensionality reduction (PCA if applicable)  
- **Artifacts:** `data/processed/` (DVC-tracked), `reports/figures/`

---
## Data Versioning (DVC)
- **Versioned items:** raw/interim/processed datasets, intermediate artifacts  
- **Pipeline:** `dvc.yaml` (`prepare → preprocess → train → evaluate`), `params.yaml` for hyperparams  
- **Remotes:** Google Drive / S3 / local remote (see `docs/DVC_SETUP.md`)  
- **Change log:** `dvc metrics show` and `dvc plots diff`; human-readable `CHANGELOG.md`
---
## Modeling, Tuning & Evaluation
- **Algorithms:** Logistic Regression, SVM, Random Forest, XGBoost, kNN, Baseline Majority  
- **Final baseline:** Linear SVM — Accuracy 71.2 %, Precision 67.3 %, Recall 67.3 %, F1 67.3 %, ROC-AUC 83.2 %  
- **Hyperparameter tuning:** Grid/Random search with cross-validation  
- **Selection criterion:** maximize Recall on “Lower” class, then AUC  
- **Outputs:** confusion matrix, PR/ROC curves, model card (`models/model_card.md`)
---
## GitHub Collaboration
**Expectations**
- Active contributions from all members (PRs, reviews)  
- Documented roles (DevOps, Software Engineer, Data Engineer, ML Engineer, Data Scientist)  
- Branching model: `main` (protected) → `dev` → `feature/<slug>`  
- Commit style: Conventional Commits (`feat:`, `fix:`, `docs:` …)  
- **CI (optional):** GitHub Actions for linting and `dvc pull` checks  
- Code style: Black + isort + Flake8 + pre-commit hooks  
---

### Team Members & Roles

| Role | Name | Responsibilities |
|------|------|-----------------|
| **DevOps** | Esteban Hidekel Solares Orozco | Git/DVC setup, infrastructure, CI/CD |
| **Software Engineer** | Jesús Antonio López Wayas | Code quality, documentation, integration |
| **Data Engineer** | Natalia Nevarez Tinoco | Data pipelines, storage, quality |
| **Data Scientist** | Data Scientist | EDA, feature engineering, analysis |
| **ML Engineer** | Roberto López Baldomero | Model training, tuning, deployment |

---

## Executive Presentation
- **File:** `docs/executive_presentation.pdf`  
- Summarizes problem → value → data → model → results → risks → ops plan  
- Highlights actionable insights and limitations  

### Project Structure
```
mlops-eq16/
├── data/
│   └── interim/
│   └── processed/
│   └── raw/
│   │   └── student_entry_performance_modified.csv
│   │   └── student_entry_performance_modified.csv.dvc
│   │   └── student_entry_performance_original.csv
│   │   └── student_entry_performance_original.csv.dvc
├── docs/
│   └── DATA_VERSIONING_SUMMARY.text
│   └── DVC_SETUP_COMMANDS.text
│   └── DVC_SETUO_INSTRUCTIONS.txt
│   └── ML_Canvas.pdf
│   └── PREPROCESSING_DOCUMENTATION.md
│   └── ROLE_INTERACTIONS_DOCUMENTATION.txt
├── mlops/
│   └── init.py
│   └── modeling/
│   │   └── init.py
├── models/
│   └── best_model_gradient_boosting.pkl
│   └── best_model_gradient_boosting.okl.dvc
│   └── scaler.pkl
│   └── scaler.pkl.dvc
├── notebooks/
│   └── phase1_team16.ipynb
├── references/
├── reports/
│   └── figures/
│   │   └── model_evaluation_results.png
└── src/
├── └── scripts/
│   │   └── init_dvc.sh
│   │   └── track_data_dvc.sh
├── README.md
├── .gitignore

```
## Quick Start

```bash
# 1. Clone Repository
git clone https://github.com/Lia1566/mlops-eq16.git
cd mlops-eq16

# 2. Install dependencies
pip install -r requirements.txt

# 3. Environment
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
pre-commit install

# 4.Pull Data with DVC
dvc pull

# 4.Run Notebooks
Execute notebooks in order:

- `01_EDA.ipynb` - Exploratory Data Analysis
- `02_Data_Preprocessing.ipynb` - Data cleaning and transformation
- `03_Data_Versioning.ipynb` - DVC implementation
- `04_Model_Building.ipynb` - Model training and evaluation

# 5. 5. Reproduce full pipeline
dvc repro

# 6. View metrics
dvc metrics show

# DVC Basics

dvc add data/raw/student_entry_performance_original.csv
git add data/raw/.gitignore student_entry_performance_original.csv.dvc
git commit -m "data: add raw student dataset"
dvc push

```

## Technologies Used

Language: Python 3.x
ML Libraries: scikit-learn, pandas, numpy
Version Control: Git, DVC
Development: Jupyter Notebooks
Visualization: matplotlib, seaborn

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

## Roles and Interactions

| From                   | To                   | Handoff                              |
| :--------------------- | :------------------- | :----------------------------------- |
| Data Engineer          | Data Scientist       | Processed dataset + data dictionary  |
| Data Scientist         | ML Engineer          | Feature spec + baseline metrics      |
| ML Engineer            | DevOps/Software Eng. | Containerized training + inference   |
| DevOps + Software Eng. | All                  | CI/CD, style checks, release process |

## Contributing

git checkout -b feature/<slug>
git commit -m "feat: add SVM grid search"
Open a PR → request review from role owner
Ensure checks pass and dvc pull works

## Ethics & Responsible AI

- Monitor fairness metrics across sensitive attributes (e.g., gender, caste, medium)
- Document limitations in models/model_card.md
- Implement feedback loop and periodic model review for drift

  
