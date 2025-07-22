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



Here's a detailed explanation of the papers you've listed, focusing on their core ideas, architectures, datasets, and performance, drawing directly from the provided sources:

    • TIME-MOE
        ○ Title: Time-MoE: Billion-Scale Time Series Foundation Models with Mixture of Experts
        ○ Authors: Shi et al.
        ○ Year: 2025
        ○ arXiv ID: 2409.16040
        ○ Core Idea & Contribution: TIME-MOE introduces a scalable and unified architecture for time series foundation models that leverages a sparse Mixture-of-Experts (MoE) design to enhance computational efficiency without compromising model capacity. This is the first work to scale time series foundation models up to 2.4 billion parameters. It aims to address challenges in scaling time series forecasting models, particularly the computational intensity of dense layers and the heterogeneity of time series data.
        ○ Model Architecture: TIME-MOE utilizes a universal decoder-only Transformer architecture with a sparse mixture-of-experts (MoE) design. This allows for scaling up model size with a fixed inference budget while giving better performance compared to dense models. The model dynamically activates different experts across various datasets, with each expert specializing in distinct knowledge, leading to diverse activation patterns and strong generalization capabilities.
        ○ Dataset: A significant contribution is Time-300B, which is the largest open-access, high-quality time series data collection to date, comprising over 300 billion time points. This diverse dataset includes publicly available data from domains such as energy, retail, healthcare, weather, finance, transportation, and web, augmented with synthetic data. A streamlined data-cleaning pipeline was developed to mitigate issues like missing values and invalid observations, crucial for large-scale pre-training stability.
        ○ Scaling & Efficiency: TIME-MOE models are designed for significant scale, with TIME-MOEultra reaching 2.4 billion total parameters (1.1 billion activated). Smaller versions like TIME-MOEbase (50M activated parameters) and TIME-MOElarge (200M activated parameters) are also available for faster inference on CPUs. The training process utilizes BF16 precision, FlashAttention, and sequence packing for improved batch processing and memory efficiency.
        ○ Performance: TIME-MOE consistently outperforms state-of-the-art forecasting foundation models by large margins across six well-established benchmarks. It achieves superior performance in both zero-shot (on unseen datasets) and in-domain/full-shot forecasting scenarios, demonstrating enhanced efficiency and forecasting precision.
    • MOMENT
        ○ Title: MOMENT: A Family of Open Time-series Foundation Models
        ○ Authors: Goswami et al.
        ○ Year: 2024
        ○ arXiv ID: 2402.03885
        ○ Core Idea & Contribution: MOMENT introduces a family of open-source foundation models for general-purpose time series analysis. It aims to address key challenges in time series foundation model development, including the absence of a large and cohesive public time series repository and the difficulties of multi-dataset training due to diverse time series characteristics.
        ○ Model Architecture: MOMENT consists of high-capacity transformer models. The models are pre-trained using a masked time series prediction task, where special embeddings are used to mask time series patches instead of zeros.
        ○ Dataset: A major contribution is the compilation of The Time Series Pile, a large and diverse collection of publicly available time series data from various domains like healthcare, engineering, and finance. This corpus comprises over 5 public time series databases, including the Monash archive, UCR/UEA classification archive, and TSB-UAD anomaly benchmark, totaling 7,965 different univariate time series and around 352 million data windows (tokens) for pre-training. Careful train-test splitting is used to minimize data contamination.
        ○ Evaluation & Performance: MOMENT is evaluated on a holistic benchmark across five time series modeling tasks: short- and long-horizon forecasting, classification, anomaly detection, and imputation. It specifically focuses on limited supervision settings, such as zero-shot imputation and linear probing for forecasting and classification. Experiments demonstrate the effectiveness of MOMENT's pre-trained models with minimal data and task-specific fine-tuning. In zero-shot settings, Lag-Llama achieves comparable performance to baselines, and with fine-tuning, it significantly improves, achieving state-of-the-art performance in multiple datasets.
        ○ Open-source Initiative: MOMENT-1-large and The Time Series Pile are publicly available on Huggingface, promoting open science.
    • Chronos
        ○ Title: Chronos: Learning the Language of Time Series
        ○ Authors: Ansari et al.
        ○ Year: 2024
        ○ arXiv ID: 2403.07815
        ○ Core Idea & Contribution: Chronos is a framework that adapts existing language model architectures and training procedures to probabilistic time series forecasting. It pursues the idea of developing "foundation models" for time series by directly training language models from scratch on time series data, which is tokenized via scaling and quantization, effectively treating time series as a "language". A key contribution is showing that existing language model architectures are capable of performing forecasting without time-series-specific customizations.
        ○ Model Architecture: Chronos utilizes language model architectures like T5 (encoder-decoder) and GPT-2 (decoder-only) as its backbone, making minimal changes to adapt them for time series data.
        ○ Dataset: To address the scarcity and quality of public time series data compared to NLP, Chronos collected a wide variety of publicly available datasets spanning domains like energy, transport, healthcare, retail, web, weather, and finance. The collection comprises 55 datasets (28 used for training) with about 890K univariate time series and approximately 84 billion observations (tokens) in total. Data augmentation techniques, including mixup augmentations and synthetic data generation via KernelSynth (a Gaussian process-based method), were employed to enhance diversity.
        ○ Evaluation & Performance: Chronos models were evaluated in both in-domain (Benchmark I: 15 datasets also included in training) and zero-shot (Benchmark II: 27 unseen datasets) settings against a variety of baselines, including statistical, neural forecasting, and other pretrained models. Chronos models significantly outperform classical statistical baselines, task-specific deep learning models, and other pretrained models on in-domain datasets. For zero-shot datasets, Chronos models comfortably outperform statistical baselines and other pretrained models, while performing on par with the best deep learning models trained on those tasks. With inexpensive fine-tuning, Chronos-T5 (Small) achieved top performance on Benchmark II.
        ○ Practical Implications: The strong performance suggests that large pretrained language models can greatly simplify forecasting pipelines without sacrificing accuracy, offering an inference-only alternative to conventional task-specific model training.
    • Moirai
        ○ Title: Unified Training of Universal Time Series Forecasting Transformers
        ○ Authors: Woo et al.
        ○ Year: 2024
        ○ arXiv ID: 2402.02592
        ○ Core Idea & Contribution: MOIRAI introduces a masked encoder-based universal time series forecasting Transformer aimed at alleviating issues in the universal forecasting paradigm. It focuses on enabling any-variate probabilistic forecasting and supporting a flexible distribution of predictions.
        ○ Model Architecture: MOIRAI uses a novel Transformer architecture designed to support the requirements of universal forecasting, extending beyond masked encoders. It is capable of modeling flexible probabilistic distributions, including a Student’s t-distribution for general time series, a negative binomial distribution for positive count data, a log-normal distribution for right-skewed data, and a low variance normal distribution for high confidence predictions.
        ○ Dataset: A key aspect is the introduction of LOTSA (Large-scale Open Time Series Archive), a new large-scale collection of open time series datasets designed to empower pre-training of Large Time series Models (LTMs). LOTSA addresses the limitation of previous datasets being constrained in size by consolidating time series from diverse sources and domains into a unified storage format (Arrow). It spans nine domains with a total of 27.6 billion observations.
        ○ Performance: MOIRAI is evaluated on both in-distribution (Monash benchmark) and out-of-distribution settings, demonstrating its capability for probabilistic and long-sequence forecasting. As a zero-shot forecaster, MOIRAI achieves competitive or superior performance compared to full-shot models. It also exhibits the desired property of continuously improving performance with increasing context lengths, a challenge for conventional Transformer-based forecasters.
        ○ Open-source Initiative: LOTSA, the model weights, and the UNI2TS library for unified training are planned to be fully open-sourced.
    • UniTS
        ○ Title: UniTS: A Unified Multi-Task Time Series Model
        ○ Authors: Gao et al.
        ○ Year: 2024
        ○ arXiv ID: 2403.00131
        ○ Core Idea & Contribution: UniTS is a unified multi-task time series model capable of handling a broad spectrum of time series tasks, including forecasting, classification, anomaly detection, and imputation. It achieves generalizability without post-hoc architectural modifications by employing task tokenization and a unified time series architecture.
        ○ Model Design: 
            § Task Tokenization: UniTS encodes task specifications into a unified token representation using three distinct token types: sample tokens (tokenized time series input), prompt tokens (learnable embeddings providing task-specific context), and task tokens (GEN for generative tasks like forecasting/imputation/anomaly detection, CLS for classification).
            § Unified Time Series Architecture: The model processes heterogeneous time series data with varying numbers of variables and sequence lengths without altering its network structure. It employs self-attention across time and variable dimensions, a dynamic linear operator, and a module to reduce interference in heterogeneous data's feature space.
            § Support for Generative and Predictive Tasks: Achieved through a unified masked reconstruction pre-training scheme that leverages both prompt and CLS token semantics. This allows UniTS to be jointly optimized for both generative and predictive capabilities and enables prompt and zero-shot learning over a frozen pre-trained model.
        ○ Datasets: UniTS was trained and evaluated on a comprehensive collection of 38 datasets for multi-task learning (20 forecasting, 18 classification). Additional collections (6 classification, 9 forecasting, 6 imputation, 5 anomaly detection) were used for few-shot learning. The combined training set comprises over 35 million timesteps and 6,000 variables.
        ○ Performance: UniTS outperforms task-specific models and reprogrammed LLMs across the 38 multi-domain and multi-task datasets. It demonstrates strong few-shot and prompt-based performance and can generalize to new domains and tasks. The use of prompt tokens notably improves performance in both forecasting and classification tasks.
    • TimesFM
        ○ Title: A decoder-only foundation model for time-series forecasting
        ○ Authors: Das et al.
        ○ Year: 2024
        ○ arXiv ID: 2310.10688
        ○ Core Idea & Contribution: TimesFM is presented as a single decoder-only foundation model for time series forecasting that achieves close to state-of-the-art zero-shot accuracy across a variety of previously-unseen forecasting datasets from different domains. It can adapt to varying forecasting history lengths, prediction lengths, and time granularities at inference time.
        ○ Model Architecture: The model utilizes a decoder-only attention architecture with input patching for efficient pre-training.
        ○ Dataset: The pre-training corpus for TimesFM is built using a massive volume of data from three main sources: Google Trends, Wiki Pageview statistics (around 300 billion time-points aggregated hourly, daily, weekly, and monthly), and synthetic time-series data (3 million synthetic series generated from ARMA processes, seasonal patterns, trends, and step functions). Additional public datasets like M4, Electricity, and Traffic are also included in the pre-training corpus.
        ○ Performance: TimesFM demonstrates superior zero-shot performance at a tiny fraction of the size of large language models (LLMs) used for time series. It performs close to or surpasses the accuracy of baselines, even when those baselines are specially trained or tuned for specific tasks, across held-out datasets from the Darts, Monash, and Informer (ETT) archives. TimesFM also shows utility in downstream tasks through fine-tuning, outperforming baselines even when fine-tuned on a small fraction (10%) of the original datasets.
        ○ Transparency: The authors plan an open weights release and provide exact details of the datasets used, along with computation requirements for transparency and community analysis.
    • Lag-Llama
        ○ Title: Lag-Llama: Towards Foundation Models for Probabilistic Time Series Forecasting
        ○ Authors: Rasul et al.
        ○ Year: 2024
        ○ arXiv ID: 2310.08278
        ○ Core Idea & Contribution: Lag-Llama presents a foundation model specifically for probabilistic time series forecasting, trained on a large collection of open time series data and evaluated on unseen datasets. It is notable as the first open-source foundation model for probabilistic forecasting.
        ○ Model Architecture: Lag-Llama is a decoder-only model that is designed to work for any downstream prediction length. Its architecture is based on the LLaMA design, incorporating lagged time series features.
        ○ Dataset: The model is pre-trained on a diverse corpus of 27 time series datasets from six semantically grouped domains: energy, transportation, economics, nature, air quality, and cloud operations. This corpus comprises a total of 7,965 different univariate time series, amounting to approximately 352 million data windows (tokens). A portion of datasets from each domain, and entirely different domains, are explicitly held out for testing few-shot generalization and performance on completely new data. The diversity of the pre-training corpus is quantified using "catch22 features" and Principal Component Analysis (PCA).
        ○ Performance: In zero-shot settings, Lag-Llama achieves comparable performance to state-of-the-art dataset-specific models. With fine-tuning, Lag-Llama achieves state-of-the-art performance in multiple datasets, significantly outperforming supervised models in average rank, suggesting its strength as a foundation model without prior data knowledge. The paper also investigates neural scaling laws, describing how the model's performance scales with the amount of pre-training data.
        ○ Probabilistic Forecasting: A key focus is its ability to provide probabilistic forecasts, endowing decision-makers with a notion of uncertainty, essential for practical applications.
    • PatchTST
        ○ Title: A Time Series is Worth 64 Words: Long-term Forecasting with Transformers
        ○ Authors: Nie et al.
        ○ Year: 2023
        ○ arXiv ID: 2211.14730
        ○ Core Idea & Contribution: PatchTST proposes an efficient design of Transformer-based models for multivariate time series forecasting and self-supervised representation learning. It introduces two key components to leverage the power of Transformers for time series, building on foundational concepts for the field.
        ○ Key Components: 
            § (i) Segmentation into Subseries-level Patches: Time series are segmented into subseries-level patches, which serve as input tokens to the Transformer. This design retains local semantic information, quadratically reduces computation and memory usage of attention maps, and allows the model to attend to longer history. This concept is inspired by patching in NLP (subword tokenization) and CV (Vision Transformer).
            § (ii) Channel-independence: Each channel (representing a single univariate time series) shares the same embedding and Transformer weights across all series. This design significantly contributes to improved forecasting performance.
        ○ Performance: PatchTST significantly improves long-term forecasting accuracy when compared with state-of-the-art Transformer-based models. It also achieves state-of-the-art self-supervised representation learning and transfer learning performance, outperforming supervised training on large datasets. The model is shown to be robust to different random seeds.
        ○ Datasets: Evaluated on 8 popular multivariate datasets, including Weather, Traffic, Electricity, ILI, and four ETT datasets (ETTh1, ETTh2, ETTm1, ETTm2), for both forecasting and representation learning tasks.
