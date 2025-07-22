FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel

WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    numpy \
    matplotlib \
    pandas \
    scikit-learn \
    torch==1.11.0

# Copy the model code
COPY . .

# Set environment variables
ENV PYTHONPATH=/workspace:$PYTHONPATH

WORKDIR /workspace/PatchTST_supervised

CMD ["python", "run_longExp.py", "--help"]
