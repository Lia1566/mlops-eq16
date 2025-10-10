# Student-performance-ml-eq16
## Team 16

### Overview
Binary classification model to predict student entrance exam performance (High Performance vs Lower Performance) using machine learning and MLOps best practices.

**Dataset**: UCI Machine Learning Repository - Student Performance on Entrance Examination
**Link** - https://archive.ics.uci.edu/dataset/582/student+performance+on+an+entrance+examination

---

## 1) Requirements Analysis
**Problem statement:** Predict whether a student’s entrance-exam performance is *High* or *Lower* using demographic and academic features to inform targeted support.

**Value proposition**
- **Students:** early identification for tutoring or program placement  
- **Institutions:** data-driven resource allocation and improved pass rates  
- **Stakeholders:** transparent, reproducible pipeline for ongoing policy and curriculum decisions  

**ML Canvas (summary)**
- **Users:** academic advisors, program directors  
- **Inputs:** cleaned tabular features from `student_entry_performance_original.csv`  
- **Output:** binary class + probability  
- **Decision/action:** flag “at-risk” students for intervention  
- **Risks:** bias across gender/caste/medium; drift as curricula change  
- **KPIs:** Recall on “Lower” class, Balanced Accuracy, AUC; operational KPI = intervention hit rate  

> Full canvas in `docs/ML_Canvas.md`

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

### Project Structure
```
mlops-eq16/
├── README.md
├── requirements.txt
├── .gitignore
├── .dvc/
├── data/
│   └── processed/
│       └── *.csv.dvc
├── notebooks/
│   ├── 01_EDA.ipynb
│   ├── 02_Data_Preprocessing.ipynb
│   ├── 03_Data_Versioning.ipynb
│   └── 04_Model_Building.ipynb
├── docs/
│   ├── ML_Canvas.md
│   └── ROLE_INTERACTIONS_DOCUMENTATION.txt
└── visualizations/
└── model_evaluation_results.png
```
### Quick Start

#### 1. Clone Repository
```bash
git clone https://github.com/Lia1566/mlops-eq16.git
cd mlops-eq16

#### 2. Install dependencies
pip install -r requirements.txt

#### 3.Pull Data with DVC
dvc pull

#### 4.Run Notebooks
Execute notebooks in order:

- `01_EDA.ipynb` - Exploratory Data Analysis
- `02_Data_Preprocessing.ipynb` - Data cleaning and transformation
- `03_Data_Versioning.ipynb` - DVC implementation
- `04_Model_Building.ipynb` - Model training and evaluation

Technologies Used

Language: Python 3.x
ML Libraries: scikit-learn, pandas, numpy
Version Control: Git, DVC
Development: Jupyter Notebooks
Visualization: matplotlib, seaborn

Model Performance
MetricScoreModelSVM (Linear Kernel)Test Accuracy71.2%Precision67.3%Recall67.3%F1-Score67.3%ROC-AUC83.2%

Project Pipeline

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

Documentation
Detailed documentation available in docs/ directory:

ML Canvas: Complete ML project canvas
Data Versioning: DVC implementation guide
Preprocessing: Step-by-step data transformation
Role Interactions: Team collaboration documentation

Contributing
This is an academic project for MLOps course. All team members contribute following:

Create feature branch: git checkout -b feature/your-feature
Commit changes: git commit -m "feat: your feature"
Push branch: git push origin feature/your-feature
Create Pull Request for review


