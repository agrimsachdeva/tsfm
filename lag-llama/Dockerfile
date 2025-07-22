FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-devel

WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    "gluonts[torch]<=0.14.4" \
    "numpy>=1.23.5" \
    "torch>=2.0.0" \
    wandb \
    scipy \
    pandas \
    "huggingface_hub[cli]" \
    matplotlib

# Copy the model code
COPY . .

# Install the package
RUN pip install -e .

# Set environment variables
ENV PYTHONPATH=/workspace:$PYTHONPATH

CMD ["python", "run.py", "--help"]
