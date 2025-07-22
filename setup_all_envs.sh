#!/bin/zsh

# Script to set up conda environments for all TSFM models
# Usage: ./setup_all_envs.sh [--gpu|--cpu]

set -e

MODEL_ENVS=(
    "Time-MoE:Time-MoE/environment.yml"
    "chronos-forecasting:chronos-forecasting/environment.yml"
    "uni2ts:uni2ts/environment.yml"
    "lag-llama:lag-llama/environment.yml"
    "UniTS:UniTS/environment.yml"
    "PatchTST:PatchTST/environment.yml"
    "NormWear:NormWear/environment.yml"
)

echo "🚀 Setting up conda environments for all TSFM models..."

for model_info in "${MODEL_ENVS[@]}"; do
    IFS=":" read -r model_name env_file <<< "$model_info"
    echo ""
    echo "📦 Setting up $model_name environment from $env_file..."
    if [ -f "$env_file" ]; then
        env_name=$(grep "^name:" "$env_file" | cut -d' ' -f2)
        if conda env list | grep -q "^$env_name "; then
            echo "  ⚠️  Environment '$env_name' already exists. Updating..."
            conda env update -f "$env_file" --prune
        else
            echo "  ✨ Creating new environment '$env_name'..."
            conda env create -f "$env_file"
        fi
        echo "  ✅ $model_name environment ready!"
    else
        echo "  ❌ Environment file not found: $env_file"
    fi
    
    # Optional: print activation command
    echo "  To activate: conda activate $env_name"
done

echo ""
echo "🎉 All environments setup complete!"
echo ""
echo "📋 Available environments:"
for model_info in "${MODEL_ENVS[@]}"; do
    IFS=":" read -r model_name env_file <<< "$model_info"
    env_name=$(grep "^name:" "$env_file" | cut -d' ' -f2)
    echo "  • $env_name      - conda activate $env_name"
done

echo ""
echo "📚 See ENVIRONMENT_SETUP.md for detailed documentation"
