# Time Series Foundation Models - Environment Setup Guide

This repository contains multiple time series foundation models, each with its own environment requirements. Here are the best practices for setting up environments that work across devices.

## 🚀 Quick Setup

### Option 1: Individual Conda Environments (Recommended)

Each model has its own `environment.yml` file. To create all environments:

```bash
# Navigate to the main directory
cd /Users/agrim/tsfm

# Create all environments
./setup_all_envs.sh

# Or create individual environments
conda env create -f Time-MoE/environment.yml
conda env create -f chronos-forecasting/environment.yml
conda env create -f uni2ts/environment.yml
conda env create -f lag-llama/environment.yml
conda env create -f UniTS/environment.yml
conda env create -f PatchTST/environment.yml
```

### Option 2: Docker Containers (For Production/Deployment)

```bash
# Build all Docker images
./build_docker_images.sh

# Or build individual images
docker build -f Time-MoE/Dockerfile -t time-moe:latest ./Time-MoE
docker build -f chronos-forecasting/Dockerfile -t chronos:latest ./chronos-forecasting
```

## 📋 Environment Overview

| Model | Environment Name | Python | PyTorch | Key Dependencies |
|-------|------------------|--------|---------|-----------------|
| TIME-MOE | `time-moe` | 3.10 | 2.1.* | transformers, accelerate |
| Chronos | `chronos` | 3.10 | 2.2.* | gluonts, transformers |
| Moirai (uni2ts) | `uni2ts` | 3.10 | 2.3.* | lightning, gluonts |
| Lag-Llama | `lag-llama` | 3.10 | 2.1.* | gluonts[torch] |
| UniTS | `units` | 3.10 | 2.1.* | einops, sktime |
| PatchTST | `patchtst` | 3.10 | 1.11.* | basic ML stack |

## 🔧 Usage

### Activating Environments

```bash
# Activate specific environment
conda activate time-moe
python Time-MoE/main.py --config configs/your_config.yaml

# Switch to another model
conda activate chronos
python chronos-forecasting/scripts/training/train.py

# Deactivate
conda deactivate
```

### Using Docker

```bash
# Run TIME-MOE
docker run --gpus all -v $(pwd)/data:/workspace/data time-moe:latest python main.py

# Run Chronos
docker run --gpus all -v $(pwd)/data:/workspace/data chronos:latest python scripts/training/train.py
```

## 🌐 Cross-Device Synchronization

### Method 1: Version Control (Git)
```bash
# Add environment files to git
git add */environment.yml
git add */Dockerfile
git commit -m "Add standardized environments"
git push

# On other devices
git pull
./setup_all_envs.sh
```

### Method 2: Cloud Storage
```bash
# Export environments
conda env export -n time-moe > Time-MoE/environment-full.yml
# Upload to cloud storage (Google Drive, Dropbox, etc.)

# On other devices, download and create
conda env create -f environment-full.yml
```

### Method 3: Container Registry
```bash
# Push to registry
docker tag time-moe:latest your-registry.com/time-moe:latest
docker push your-registry.com/time-moe:latest

# Pull on other devices
docker pull your-registry.com/time-moe:latest
```

## 🛠 Troubleshooting

### Common Issues

1. **CUDA Version Mismatch**: Update the `pytorch-cuda` version in environment.yml
2. **Package Conflicts**: Use the specific versions in environment.yml
3. **Memory Issues**: Reduce batch sizes in model configs

### GPU Support

For GPU support, ensure CUDA is installed and modify environment files:
```yaml
dependencies:
  - pytorch-cuda=12.1  # Match your CUDA version
```

For CPU-only:
```yaml
dependencies:
  - cpuonly  # Replace pytorch-cuda line
```

## 📚 Additional Resources

- [Conda Environment Management](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)
- [Docker Best Practices](https://docs.docker.com/develop/best-practices/)
- [Individual Model Documentation](./models.md)

## 🔄 Environment Updates

When dependencies change:
```bash
# Update environment file
conda env update -f environment.yml

# Or recreate environment
conda env remove -n time-moe
conda env create -f Time-MoE/environment.yml
```
