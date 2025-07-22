#!/bin/bash

# Docker build script for all Time Series Foundation Models
# Usage: ./build_docker_images.sh [--no-cache] [model_name]

set -e

echo "🐳 Building Docker images for Time Series Foundation Models..."

# Parse arguments
NO_CACHE=""
SPECIFIC_MODEL=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --no-cache)
      NO_CACHE="--no-cache"
      shift
      ;;
    time-moe|chronos|uni2ts|lag-llama|units|patchtst|normwear)
      SPECIFIC_MODEL="$1"
      shift
      ;;
    *)
      echo "Unknown option $1"
      echo "Usage: ./build_docker_images.sh [--no-cache] [model_name]"
      echo "Available models: time-moe, chronos, uni2ts, lag-llama, units, patchtst, normwear"
      exit 1
      ;;
  esac
done

# Array of models and their build contexts
declare -a models=(
    "time-moe:Time-MoE:Time-MoE"
    "chronos:chronos-forecasting:chronos-forecasting"
    "uni2ts:uni2ts:uni2ts"
    "lag-llama:lag-llama:lag-llama"
    "units:UniTS:UniTS"
    "patchtst:PatchTST:PatchTST"
    "normwear:NormWear:NormWear"
)

# Function to build a single Docker image
build_image() {
    local image_name=$1
    local dockerfile_dir=$2
    local context_dir=$3
    
    echo ""
    echo "🔨 Building $image_name..."
    
    if [ -f "$dockerfile_dir/Dockerfile" ]; then
        docker build $NO_CACHE \
            -f "$dockerfile_dir/Dockerfile" \
            -t "$image_name:latest" \
            "$context_dir"
        
        echo "  ✅ Successfully built $image_name:latest"
        
        # Also tag with date
        local date_tag=$(date +%Y%m%d)
        docker tag "$image_name:latest" "$image_name:$date_tag"
        echo "  🏷️  Tagged as $image_name:$date_tag"
    else
        echo "  ❌ Dockerfile not found: $dockerfile_dir/Dockerfile"
        return 1
    fi
}

# Build images
for model_info in "${models[@]}"; do
    IFS=':' read -r image_name dockerfile_dir context_dir <<< "$model_info"
    
    # If specific model requested, only build that one
    if [ -n "$SPECIFIC_MODEL" ] && [ "$SPECIFIC_MODEL" != "$image_name" ]; then
        continue
    fi
    
    build_image "$image_name" "$dockerfile_dir" "$context_dir"
done

echo ""
echo "🎉 Docker build complete!"
echo ""
echo "📋 Available images:"
docker images | grep -E "(time-moe|chronos|uni2ts|lag-llama|units|patchtst)" | head -20
echo ""
echo "🚀 Usage examples:"
echo "  docker run --gpus all -v \$(pwd)/data:/workspace/data time-moe:latest"
echo "  docker run --gpus all -v \$(pwd)/data:/workspace/data chronos:latest"
echo ""
echo "💾 To save images for transfer:"
echo "  docker save time-moe:latest | gzip > time-moe.tar.gz"
echo ""
echo "📚 See ENVIRONMENT_SETUP.md for detailed documentation"
