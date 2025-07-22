FROM pytorch/pytorch:2.2.0-cuda12.1-cudnn8-devel

WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    "torch>=2.0,<3" \
    "transformers>=4.48,<5" \
    "accelerate>=0.32,<2" \
    "gluonts[pro]~=0.15" \
    "numpy~=1.21" \
    "datasets~=2.18" \
    typer \
    typer-config \
    joblib \
    scikit-learn \
    tensorboard

# Copy the model code
COPY . .

# Install the package
RUN pip install -e .

# Set environment variables
ENV PYTHONPATH=/workspace:$PYTHONPATH

CMD ["python", "-m", "chronos.scripts.training.train", "--help"]
