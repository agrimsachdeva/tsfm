#!/bin/zsh

# TSFM Environment Manager
# Comprehensive script for managing Time Series Foundation Model environments
# Usage: ./manage_envs.sh [command] [options]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODELS=(time-moe chronos uni2ts lag-llama units patchtst normwear)

# Helper functions
print_header() {
    echo -e "${BLUE}$1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to show usage
show_usage() {
    cat << EOF
🔧 TSFM Environment Manager

USAGE:
    ./manage_envs.sh <command> [options]

COMMANDS:
    setup [--gpu|--cpu] [model]     Setup environments (all or specific model)
    list                            List all available environments
    activate <model>                Show activation command for model
    status                          Show status of all environments
    update <model>                  Update specific environment
    remove <model>                  Remove specific environment
    export <model> [--full]         Export environment to file
    sync                            Sync environments across devices
    docker-build [model]            Build Docker images
    docker-run <model> [command]    Run model in Docker container
    clean                           Clean up unused environments
    help                            Show this help message

MODELS:
    time-moe, chronos, uni2ts, lag-llama, units, patchtst

EXAMPLES:
    ./manage_envs.sh setup --gpu
    ./manage_envs.sh setup chronos
    ./manage_envs.sh activate time-moe
    ./manage_envs.sh docker-run chronos python scripts/training/train.py
    ./manage_envs.sh export chronos --full
EOF
}

# Function to check if conda is available
check_conda() {
    if ! command -v conda &> /dev/null; then
        print_error "Conda is not installed or not in PATH"
        echo "Please install Miniconda/Anaconda: https://docs.conda.io/en/latest/miniconda.html"
        exit 1
    fi
}

# Function to list environments
list_envs() {
    print_header "📋 Available TSFM Environments:"
    echo ""
    
    for model in "${MODELS[@]}"; do
        if conda env list | grep -q "^$model "; then
            env_path=$(conda env list | grep "^$model " | awk '{print $2}')
            print_success "$model ($(basename $env_path))"
        else
            echo "  $model (not installed)"
        fi
    done
    echo ""
}

# Function to show environment status
show_status() {
    print_header "📊 Environment Status:"
    echo ""
    
    for model in "${MODELS[@]}"; do
        local env_file=""
        case $model in
            time-moe) env_file="Time-MoE/environment.yml" ;;
            chronos) env_file="chronos-forecasting/environment.yml" ;;
            uni2ts) env_file="uni2ts/environment.yml" ;;
            lag-llama) env_file="lag-llama/environment.yml" ;;
            units) env_file="UniTS/environment.yml" ;;
            patchtst) env_file="PatchTST/environment.yml" ;;
        esac
        
        printf "%-12s " "$model:"
        
        if [ -f "$env_file" ]; then
            if conda env list | grep -q "^$model "; then
                print_success "✓ Installed"
            else
                echo "❌ Not installed (environment.yml available)"
            fi
        else
            echo "❓ Environment file missing"
        fi
    done
    echo ""
}

# Function to activate environment
show_activate() {
    local model=$1
    if [[ ! " ${MODELS[@]} " =~ " ${model} " ]]; then
        print_error "Unknown model: $model"
        echo "Available models: ${MODELS[*]}"
        exit 1
    fi
    
    if conda env list | grep -q "^$model "; then
        print_header "🚀 To activate $model environment:"
        echo ""
        echo "conda activate $model"
        echo ""
        print_header "💡 Quick start commands:"
        case $model in
            time-moe)
                echo "cd Time-MoE && python main.py --help"
                ;;
            chronos)
                echo "cd chronos-forecasting && python -m chronos.scripts.training.train --help"
                ;;
            uni2ts)
                echo "cd uni2ts && python -m cli.train --help"
                ;;
            lag-llama)
                echo "cd lag-llama && python run.py --help"
                ;;
            units)
                echo "cd UniTS && python run.py --help"
                ;;
            patchtst)
                echo "cd PatchTST/PatchTST_supervised && python run_longExp.py --help"
                ;;
        esac
    else
        print_error "Environment '$model' is not installed"
        echo "Run: ./manage_envs.sh setup $model"
    fi
}

# Function to export environment
export_env() {
    local model=$1
    local full_export=$2
    
    if [[ ! " ${MODELS[@]} " =~ " ${model} " ]]; then
        print_error "Unknown model: $model"
        exit 1
    fi
    
    if ! conda env list | grep -q "^$model "; then
        print_error "Environment '$model' is not installed"
        exit 1
    fi
    
    local output_file="${model}-environment-$(date +%Y%m%d).yml"
    
    if [ "$full_export" == "--full" ]; then
        print_header "📤 Exporting full environment for $model..."
        conda env export -n "$model" > "$output_file"
    else
        print_header "📤 Exporting minimal environment for $model..."
        conda env export -n "$model" --from-history > "$output_file"
    fi
    
    print_success "Environment exported to: $output_file"
    echo "Transfer this file to other devices and run:"
    echo "conda env create -f $output_file"
}

# Function to sync environments
sync_envs() {
    print_header "🔄 Syncing environments..."
    
    # Check if we're in a git repository
    if git rev-parse --git-dir > /dev/null 2>&1; then
        print_header "📡 Git sync mode"
        
        # Add environment files to git
        git add */environment.yml
        git add */Dockerfile
        
        if git diff --cached --quiet; then
            print_warning "No changes to commit"
        else
            git commit -m "Update environment configurations $(date +%Y-%m-%d)"
            print_success "Environment files committed to git"
            
            read -p "Push to remote repository? (y/n): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                git push
                print_success "Changes pushed to remote repository"
            fi
        fi
    else
        print_header "💾 Local export mode"
        
        # Export all environments
        for model in "${MODELS[@]}"; do
            if conda env list | grep -q "^$model "; then
                export_env "$model" "--full"
            fi
        done
    fi
}

# Function to run Docker container
docker_run() {
    local model=$1
    shift
    local command="$@"
    
    if [[ ! " ${MODELS[@]} " =~ " ${model} " ]]; then
        print_error "Unknown model: $model"
        exit 1
    fi
    
    # Check if Docker image exists
    if ! docker images | grep -q "^$model "; then
        print_warning "Docker image '$model' not found. Building..."
        ./build_docker_images.sh "$model"
    fi
    
    # Set up GPU support if available
    local gpu_args=""
    if command -v nvidia-smi &> /dev/null; then
        gpu_args="--gpus all"
    fi
    
    print_header "🐳 Running $model in Docker..."
    
    if [ -z "$command" ]; then
        # Interactive mode
        docker run -it $gpu_args \
            -v "$(pwd):/workspace/host" \
            -v "$HOME/.cache:/root/.cache" \
            "$model:latest" \
            /bin/bash
    else
        # Run specific command
        docker run $gpu_args \
            -v "$(pwd):/workspace/host" \
            -v "$HOME/.cache:/root/.cache" \
            "$model:latest" \
            $command
    fi
}

# Main command processing
case "${1:-help}" in
    setup)
        shift
        exec "$SCRIPT_DIR/setup_all_envs.sh" "$@"
        ;;
    list)
        check_conda
        list_envs
        ;;
    activate)
        check_conda
        show_activate "$2"
        ;;
    status)
        check_conda
        show_status
        ;;
    update)
        check_conda
        if [ -z "$2" ]; then
            print_error "Model name required"
            exit 1
        fi
        model=$2
        env_file=""
        case $model in
            time-moe) env_file="Time-MoE/environment.yml" ;;
            chronos) env_file="chronos-forecasting/environment.yml" ;;
            uni2ts) env_file="uni2ts/environment.yml" ;;
            lag-llama) env_file="lag-llama/environment.yml" ;;
            units) env_file="UniTS/environment.yml" ;;
            patchtst) env_file="PatchTST/environment.yml" ;;
            *)
                print_error "Unknown model: $model"
                exit 1
                ;;
        esac
        
        if [ -f "$env_file" ]; then
            print_header "🔄 Updating $model environment..."
            conda env update -f "$env_file" --prune
            print_success "Environment updated"
        else
            print_error "Environment file not found: $env_file"
        fi
        ;;
    remove)
        check_conda
        if [ -z "$2" ]; then
            print_error "Model name required"
            exit 1
        fi
        read -p "Remove environment '$2'? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            conda env remove -n "$2"
            print_success "Environment '$2' removed"
        fi
        ;;
    export)
        check_conda
        if [ -z "$2" ]; then
            print_error "Model name required"
            exit 1
        fi
        export_env "$2" "$3"
        ;;
    sync)
        sync_envs
        ;;
    docker-build)
        exec "$SCRIPT_DIR/build_docker_images.sh" "$2"
        ;;
    docker-run)
        if [ -z "$2" ]; then
            print_error "Model name required"
            exit 1
        fi
        shift 2
        docker_run "$model" "$@"
        ;;
    clean)
        check_conda
        print_header "🧹 Cleaning unused environments..."
        conda clean --all -y
        print_success "Cleanup complete"
        ;;
    help)
        show_usage
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac
