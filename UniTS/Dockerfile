FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-devel

WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    unrar \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install torch (specific version)
RUN pip install torch==2.1.0

# Copy the model code
COPY . .

# Set environment variables
ENV PYTHONPATH=/workspace:$PYTHONPATH

CMD ["python", "run.py", "--help"]
