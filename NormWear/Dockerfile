FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-devel

# Set working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY dependencies.txt .
COPY config_env.sh .

# Install Python packages
RUN pip install --upgrade pip && \
    pip install pandas tabulate scipy scikit-learn && \
    pip install timm transformers pytorch_pretrained_vit && \
    pip install tqdm datasets accelerate einops

# Install chronos for baseline comparisons
RUN pip install chronos-forecasting[torch]

# Copy the source code
COPY . .

# Set environment variables
ENV PYTHONPATH=/workspace:$PYTHONPATH

# Default command
CMD ["bash"]
