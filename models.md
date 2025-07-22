# Time Series Foundation Models Overview

| Paper | Code | Author | Year | Model Name | Category | Primary Application | Core Architecture | Key Innovation/Adaptation | Pre-training Data Scale & Type | Handles Irregularity/Missing Data? | Univariate/Multivariate | Heterogeneous |
|-------|------|--------|------|------------|----------|-------------------|------------------|---------------------------|------------------------------|----------------------------------|------------------------|---------------|
| [arXiv:2409.16040](https://arxiv.org/abs/2409.16040) • [PDF](papers/TIME-MOE.pdf) | [GitHub](https://github.com/Time-MoE/Time-MoE) | Shi et al. | 2025 | TIME-MOE | General TSFM | General Time Series Forecasting | Decoder-only Transformer | Sparse Mixture-of-Experts (MoE) architecture to improve computational efficiency by activating only a subset of network parameters for any given prediction. | Time-300B: A collection of public and synthetic datasets containing over 300 billion time points across 9 domains. | No | Univariate, Multivariate (via channel independence) | Yes (via MoE and pre-training on 9 diverse domains) |
| [arXiv:2402.03885](https://arxiv.org/abs/2402.03885) • [PDF](papers/MOMENT.pdf) | [HuggingFace](https://huggingface.co/AutonLab) | Goswami et al. | 2024 | MOMENT (Family) | General TSFM | General Time Series Analysis (e.g., forecasting, classification, anomaly detection, imputation) | Transformer Encoder (T5-based) | A masked time series prediction pre-training task using patches on a large, compiled corpus. | The Time Series Pile: A large collection from public repositories (Monash, UCR/UEA, etc.) with over 1.23 billion timestamps. | No (handles variations by padding/sub-sampling to a fixed length) | Univariate, Multivariate (via channel independence) | Yes (Pre-trained on diverse corpus) |
| [arXiv:2403.07815](https://arxiv.org/abs/2403.07815) • [PDF](papers/Chronos.pdf) | [GitHub](https://github.com/amazon-science/chronos-forecasting) | Ansari et al. | 2024 | Chronos | General TSFM | General Probabilistic Forecasting | Transformer-based language models (T5 family, GPT-2) | Tokenizes time series values into a fixed vocabulary via scaling and quantization, enabling off-the-shelf language model architectures to be trained directly on time series using a standard cross-entropy loss | Large public collection + 1M GP-synthetic series across 42 datasets (exact points N/A) | No | Univariate | Yes (Pre-trained on diverse corpus) |
| [arXiv:2402.02592](https://arxiv.org/abs/2402.02592) • [PDF](papers/Moirai.pdf) | [GitHub](https://github.com/SalesforceAIResearch/uni2ts) | Woo et al. | 2024 | Moirai | General TSFM | General Time Series Forecasting | Encoder-only Transformer | Designed for "any-variate" forecasting (from univariate to multivariate). Uses multiple resolution-specific input/output projection layers to handle different patch sizes, which correspond to different time series frequencies, enabling specialization. | LOTSA: A dataset with over 27 billion observations across nine domains. | No (The model's specialization is based on frequency, which implies regular sampling intervals) | Univariate, Multivariate | Yes (Pre-trained on diverse corpus) |
| [UniTS Project](https://zitniklab.hms.harvard.edu/projects/UniTS/) • [PDF](papers/UniTS.pdf) | [GitHub](https://github.com/mims-harvard/UniTS) | Gao et al. | 2024 | UniTS | General TSFM | General Multi-Task Time Series | Modified Transformer | Task tokenization for unified predictive & generative tasks | Heterogeneous, multi-domain datasets | Yes (Designed for heterogeneous data representations) | - | - |
| [arXiv:2310.10688](https://arxiv.org/abs/2310.10688) • [PDF](papers/TimesFM.pdf) | Code unavailable | Das et al. | 2024 | TimesFM | General TSFM | General Time Series Forecasting | Decoder-only Transformer | Patching; Pre-trained on 100B real-world time points for zero-shot forecasting | 100B time points (Google/Wikimedia traffic, etc.) | Limited (Requires regularly sampled data) | - | - |
| [arXiv:2310.08278](https://arxiv.org/abs/2310.08278) • [PDF](papers/Lag-Llama.pdf) | [GitHub](https://github.com/time-series-foundation-models/lag-llama) | Rasul et al. | 2024 | Lag-Llama | General TSFM | General Probabilistic Forecasting | Decoder-only Transformer (Llama) | First open-source foundation model for probabilistic forecasting | Large, diverse public time series datasets | Limited (Requires regularly sampled data) | - | - |
| [arXiv:2412.09758](https://arxiv.org/abs/2412.09758) • [PDF](papers/NormWear_2025.pdf) | [GitHub](https://github.com/Mobile-Sensing-and-UbiComp-Laboratory/NormWear) | Liu et al. | 2025 | NormWear | Specialized TSFM | Wearable Physiological Signal Analysis | Transformer-based Foundation Model | Designed specifically for multivariate wearable sensing of physiological signals (PPG, ECG, EEG, GSR, IMU). Features representation-alignment-match method for zero-shot inference and text-embedding alignment. | Large-scale physiological signals from public resources across multiple modalities | Yes (Designed for heterogeneous wearable sensing configurations) | Multivariate | Yes (Pre-trained on diverse physiological signal domains) |
| [arXiv:2211.14730](https://arxiv.org/abs/2211.14730) • [PDF](papers/PatchTST.pdf) | [GitHub](https://github.com/yuqinie98/PatchTST) | Nie et al. | 2023 | PatchTST | Standard Transformer | Long-Term Time Series Forecasting | Encoder-only Transformer | Treats time series subseries-level patches as input tokens for a Transformer. This simplifies the model and is more efficient than point-wise tokenization. Also introduces channel independence, where each variate of a multivariate series is treated as a separate univariate series. | N/A (Supervised model trained on individual datasets) | No | Univariate, Multivariate (via channel independence) | No (Trained on individual datasets) |

## Summary

This table provides an overview of recent Time Series Foundation Models (TSFMs) and related architectures, showcasing the evolution from standard transformers to specialized foundation models designed for time series analysis. 

📚 **All papers are available locally in the [`papers/`](papers/) folder for offline reading.** 

### Key Trends

- **Architecture Evolution**: Movement from encoder-only to decoder-only transformers and specialized architectures like MoE
- **Scale**: Increasing pre-training data scales (from billions to hundreds of billions of time points)
- **Versatility**: Growing support for multiple tasks and heterogeneous data
- **Innovation**: Novel approaches like tokenization, patching, and mixture-of-experts

### Model Categories

1. **General TSFMs**: TIME-MOE, MOMENT, Chronos, Moirai, UniTS, TimesFM, Lag-Llama
2. **Specialized TSFMs**: NormWear (wearable physiological signals)
3. **Standard Transformers**: PatchTST

### Data Handling Capabilities

- **Irregularity/Missing Data**: Limited support across most models, with UniTS being a notable exception
- **Multivariate Support**: Most models support both univariate and multivariate time series
- **Heterogeneous Data**: Increasing focus on handling diverse data types and domains
