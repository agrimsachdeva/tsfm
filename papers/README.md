# Time Series Foundation Models - Papers Collection

This folder contains the research papers for all the time series foundation models in our repository. Each paper is named after its corresponding model for easy reference.

## 📚 Paper Collection

| Model | Paper File | Title | Year | arXiv ID | Authors |
|-------|-----------|-------|------|----------|---------|
| **TIME-MOE** | `TIME-MOE_2025.pdf` | Time-MoE: Billion-Scale Time Series Foundation Models with Mixture of Experts | 2025 | 2409.16040 | Shi et al. |
| **NormWear** | `NormWear_2025.pdf` | Toward Foundation Model for Multivariate Wearable Sensing of Physiological Signals | 2025 | 2412.09758 | Liu et al. |
| **MOMENT** | `MOMENT_2024.pdf` | MOMENT: A Family of Open Time-series Foundation Models | 2024 | 2402.03885 | Goswami et al. |
| **Chronos** | `Chronos_2024.pdf` | Chronos: Learning the Language of Time Series | 2024 | 2403.07815 | Ansari et al. |
| **Moirai** | `Moirai_2024.pdf` | Unified Training of Universal Time Series Forecasting Transformers | 2024 | 2402.02592 | Woo et al. |
| **UniTS** | `UniTS_2024.pdf` | UniTS: A Unified Multi-Task Time Series Model | 2024 | 2403.00131 | Gao et al. |
| **TimesFM** | `TimesFM_2024.pdf` | A decoder-only foundation model for time-series forecasting | 2024 | 2310.10688 | Das et al. |
| **Lag-Llama** | `Lag-Llama_2024.pdf` | Lag-Llama: Towards Foundation Models for Probabilistic Time Series Forecasting | 2024 | 2310.08278 | Rasul et al. |
| **PatchTST** | `PatchTST_2023.pdf` | A Time Series is Worth 64 Words: Long-term Forecasting with Transformers | 2023 | 2211.14730 | Nie et al. |

## 📊 Paper Summary by Categories

### General Time Series Foundation Models (TSFMs)
- **TIME-MOE** (2025): Introduces sparse Mixture-of-Experts (MoE) architecture for computational efficiency
- **MOMENT** (2024): Family of foundation models for multiple time series tasks using T5-based architecture
- **Chronos** (2024): Language model approach using tokenization of time series values
- **Moirai** (2024): "Any-variate" forecasting with frequency-specific specialization
- **UniTS** (2024): Unified model for both predictive and generative tasks with task tokenization
- **TimesFM** (2024): Google's decoder-only transformer for zero-shot forecasting
- **Lag-Llama** (2024): First open-source foundation model for probabilistic forecasting

### Specialized Foundation Models
- **NormWear** (2025): Foundation model specifically designed for multivariate wearable sensing of physiological signals (PPG, ECG, EEG, GSR, IMU)

### Standard Transformers
- **PatchTST** (2023): Pioneering work on patch-based tokenization for time series

## 🔬 Key Research Contributions

### Architectural Innovations
- **Mixture of Experts**: TIME-MOE introduces sparse MoE for scalable time series modeling
- **Task Tokenization**: UniTS enables unified task specification without architectural changes
- **Value Tokenization**: Chronos treats time series values as discrete tokens for language models
- **Patch-based Processing**: PatchTST and others use subseries patches as input tokens
- **Multi-resolution Handling**: Moirai specializes layers for different frequencies

### Scale and Data
- **TIME-MOE**: 300B+ time points across 9 domains
- **MOMENT**: 1.23B+ timestamps from public repositories
- **TimesFM**: 100B real-world time points
- **Moirai**: 27B+ observations across nine domains

### Task Diversity
- **Forecasting**: All models support time series prediction
- **Classification**: MOMENT, UniTS support classification tasks
- **Anomaly Detection**: MOMENT, UniTS handle anomaly detection
- **Imputation**: MOMENT, UniTS support missing data imputation
- **Zero-shot Learning**: Most foundation models support zero-shot transfer

## 📖 Reading Order Recommendations

### For Beginners
1. **PatchTST** - Foundational concepts of transformers for time series
2. **Chronos** - Clear introduction to foundation models for time series
3. **MOMENT** - Comprehensive overview of multi-task time series models

### For Foundation Model Researchers
1. **UniTS** - Most comprehensive unified approach
2. **TIME-MOE** - Latest scaling techniques with MoE
3. **Moirai** - Advanced frequency-aware architectures

### For Practitioners
1. **Chronos** - Practical tokenization approach
2. **Lag-Llama** - Open-source probabilistic forecasting
3. **TimesFM** - Industrial-scale zero-shot forecasting

## 🎯 Key Comparison Points

### Data Requirements
- **Foundation Models**: Pre-trained, minimal fine-tuning needed
- **Standard Models**: Require task-specific training

### Architecture Types
- **Encoder-only**: PatchTST, Moirai (frequency-aware)
- **Decoder-only**: TIME-MOE, TimesFM, Lag-Llama
- **Encoder-Decoder**: MOMENT (T5-based)
- **Modified Transformer**: UniTS (unified architecture)

### Specializations
- **Probabilistic**: Chronos, Lag-Llama (explicit probabilistic modeling)
- **Multi-task**: MOMENT, UniTS (classification, anomaly detection, etc.)
- **Scalable**: TIME-MOE (MoE architecture)
- **Zero-shot**: Most foundation models support zero-shot transfer

## 📝 Citation Information

All papers include proper citation information. When using these models or referencing the papers, please cite the original authors appropriately. BibTeX citations are available in each paper and in the corresponding model repositories.

## 🔗 Additional Resources

- **Model Implementations**: See the corresponding folders in the main repository
- **Environment Setup**: Refer to `../ENVIRONMENT_SETUP.md`
- **Model Comparison**: See `../models.md` for detailed comparison table

---

*Last updated: July 2025*  
*Papers downloaded from arXiv.org*
