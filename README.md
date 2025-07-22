# Time Series Foundation Models - Complete Repository

## 🎯 Quick Start

This repository contains a comprehensive collection of Time Series Foundation Models (TSFMs) with everything you need to get started across any device.

### One-Command Setup
```bash
# Clone and setup everything
git clone <your-repo-url>
cd tsfm
./manage_envs.sh setup --gpu  # or --cpu for CPU-only
```

## 📁 Repository Structure

```
tsfm/
├── 📄 README.md                    # This file
├── 📄 models.md                    # Detailed model comparison table
├── 📄 ENVIRONMENT_SETUP.md         # Complete environment guide
├── 🔧 manage_envs.sh               # Master environment management script
├── 🔧 setup_all_envs.sh           # Conda environment setup
├── 🔧 build_docker_images.sh      # Docker container builds
├── 📚 papers/                     # All research papers (PDF)
│   ├── TIME-MOE.pdf
│   ├── MOMENT.pdf
│   ├── Chronos.pdf
│   ├── Moirai.pdf
│   ├── UniTS.pdf
│   ├── TimesFM.pdf
│   ├── Lag-Llama.pdf
│   ├── PatchTST.pdf
│   └── README.md
├── 🤖 Time-MoE/                   # Mixture of Experts model
├── 🤖 chronos-forecasting/        # Language model for time series
├── 🤖 uni2ts/                     # Any-variate forecasting (Moirai)
├── 🤖 lag-llama/                  # Probabilistic forecasting
├── 🤖 UniTS/                      # Unified multi-task model
└── 🤖 PatchTST/                   # Patch-based transformer
```

## 🚀 Getting Started

### Method 1: Environment Manager (Recommended)
```bash
# Check status
./manage_envs.sh status

# Setup all environments
./manage_envs.sh setup

# Activate a specific model
./manage_envs.sh activate time-moe
conda activate time-moe
cd Time-MoE && python main.py --help

# Docker alternative
./manage_envs.sh docker-run chronos
```

### Method 2: Individual Setup
```bash
# Setup specific model
conda env create -f Time-MoE/environment.yml
conda activate time-moe
cd Time-MoE && python main.py --help
```

## 🔬 Model Quick Reference

| Model | Best For | Quick Start | Paper |
|-------|----------|-------------|-------|
| **TIME-MOE** | Large-scale, efficient forecasting | `conda activate time-moe && cd Time-MoE` | [PDF](papers/TIME-MOE.pdf) |
| **Chronos** | General forecasting with LLM approach | `conda activate chronos && cd chronos-forecasting` | [PDF](papers/Chronos.pdf) |
| **Moirai** | Multi-variate, frequency-aware | `conda activate uni2ts && cd uni2ts` | [PDF](papers/Moirai.pdf) |
| **MOMENT** | Multi-task (classification, anomaly, etc.) | Available on HuggingFace | [PDF](papers/MOMENT.pdf) |
| **UniTS** | Unified predictive & generative tasks | `conda activate units && cd UniTS` | [PDF](papers/UniTS.pdf) |
| **Lag-Llama** | Probabilistic forecasting | `conda activate lag-llama && cd lag-llama` | [PDF](papers/Lag-Llama.pdf) |
| **PatchTST** | Long-term forecasting baseline | `conda activate patchtst && cd PatchTST` | [PDF](papers/PatchTST.pdf) |

## 🌐 Cross-Device Synchronization

### Git-based (Recommended)
```bash
# Add environment files to version control
git add */environment.yml */Dockerfile papers/
git commit -m "Complete TSFM setup"
git push

# On new device
git clone <repo>
./manage_envs.sh setup
```

### Manual Export/Import
```bash
# Export environments for transfer
./manage_envs.sh export chronos --full
# Transfer the generated files to new device
```

### Docker Images
```bash
# Build and save images
./build_docker_images.sh
docker save chronos:latest | gzip > chronos-image.tar.gz
# Transfer and load on new device
```

## 📊 Usage Examples

### Forecasting with Chronos
```bash
conda activate chronos
cd chronos-forecasting
python -m chronos.scripts.training.train --help
```

### Multi-task with UniTS
```bash
conda activate units
cd UniTS
python run.py --help
```

### Probabilistic with Lag-Llama
```bash
conda activate lag-llama
cd lag-llama
python run.py --help
```

## 🛠 Environment Management

### List Available Environments
```bash
./manage_envs.sh list
```

### Update Environment
```bash
./manage_envs.sh update chronos
```

### Sync Across Devices
```bash
./manage_envs.sh sync
```

### Clean Up
```bash
./manage_envs.sh clean
```

## 📚 Documentation

- **[models.md](models.md)** - Comprehensive model comparison
- **[ENVIRONMENT_SETUP.md](ENVIRONMENT_SETUP.md)** - Detailed environment guide
- **[papers/README.md](papers/README.md)** - Paper collection overview
- **Individual model READMEs** - See each model's folder

## 🔧 Troubleshooting

### CUDA Issues
```bash
# Check CUDA availability
nvidia-smi

# Setup CPU-only environments
./manage_envs.sh setup --cpu
```

### Environment Conflicts
```bash
# Remove and recreate environment
./manage_envs.sh remove time-moe
./manage_envs.sh setup time-moe
```

### Docker Issues
```bash
# Rebuild images
./build_docker_images.sh --no-cache
```

## 🤝 Contributing

1. Add new models in their own folders
2. Create corresponding `environment.yml` and `Dockerfile`
3. Update `models.md` table
4. Add paper to `papers/` folder
5. Update this README

## 📖 Citation

If you use this repository or the models, please cite the individual papers. See [papers/README.md](papers/README.md) for citation information.

## 📄 License

Individual models have their own licenses. See each model's folder for details.

---

**🎯 Ready to start?** Run `./manage_envs.sh setup` and you'll have all time series foundation models ready to use!

*Repository structure optimized for research, development, and cross-device synchronization.*
