FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-devel

WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    "torch>=2.1,<2.5" \
    "lightning>=2.0" \
    "gluonts~=0.14.3" \
    "numpy~=1.26.0" \
    "scipy~=1.11.3" \
    "einops==0.7.*" \
    "jaxtyping~=0.2.24" \
    "python-dotenv==1.0.0" \
    "hydra-core==1.3" \
    orjson \
    tensorboard \
    multiprocess \
    "huggingface_hub>=0.23.0" \
    safetensors \
    "datasets~=2.17.1" \
    "jax[cpu]"

# Copy the model code
COPY . .

# Install the package
RUN pip install -e .

# Set environment variables
ENV PYTHONPATH=/workspace:$PYTHONPATH

CMD ["python", "-m", "cli.train", "--help"]
