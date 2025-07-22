#!/bin/bash

# TSFM Repository Verification Script
# Usage: ./verify_setup.sh

set -e

echo "🔍 Verifying TSFM Repository Setup..."
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

success_count=0
total_checks=0

check_item() {
    local description=$1
    local check_command=$2
    local optional=${3:-false}
    
    ((total_checks++))
    printf "%-50s " "$description:"
    
    if eval "$check_command" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC}"
        ((success_count++))
        return 0
    else
        if [ "$optional" = true ]; then
            echo -e "${YELLOW}⚠ (optional)${NC}"
            ((success_count++))
        else
            echo -e "${RED}✗${NC}"
        fi
        return 1
    fi
}

echo "📋 Repository Structure Checks:"
check_item "Main README.md exists" "[ -f README.md ]"
check_item "Models comparison table exists" "[ -f models.md ]"
check_item "Environment setup guide exists" "[ -f ENVIRONMENT_SETUP.md ]"
check_item "Management script exists" "[ -f manage_envs.sh ]"
check_item "Setup script exists" "[ -f setup_all_envs.sh ]"
check_item "Docker build script exists" "[ -f build_docker_images.sh ]"

echo ""
echo "📚 Papers Collection Checks:"
check_item "Papers folder exists" "[ -d papers ]"
check_item "Papers README exists" "[ -f papers/README.md ]"
check_item "TIME-MOE paper downloaded" "[ -f papers/TIME-MOE_2025.pdf ]"
check_item "NormWear paper downloaded" "[ -f papers/NormWear_2025.pdf ]"
check_item "MOMENT paper downloaded" "[ -f papers/MOMENT_2024.pdf ]"
check_item "Chronos paper downloaded" "[ -f papers/Chronos_2024.pdf ]"
check_item "Moirai paper downloaded" "[ -f papers/Moirai_2024.pdf ]"
check_item "UniTS paper downloaded" "[ -f papers/UniTS_2024.pdf ]"
check_item "TimesFM paper downloaded" "[ -f papers/TimesFM_2024.pdf ]"
check_item "Lag-Llama paper downloaded" "[ -f papers/Lag-Llama_2024.pdf ]"
check_item "PatchTST paper downloaded" "[ -f papers/PatchTST_2023.pdf ]"

echo ""
echo "🤖 Model Repositories Checks:"
check_item "TIME-MOE repository cloned" "[ -d Time-MoE ]"
check_item "NormWear repository cloned" "[ -d NormWear ]"
check_item "Chronos repository cloned" "[ -d chronos-forecasting ]"
check_item "Moirai (uni2ts) repository cloned" "[ -d uni2ts ]"
check_item "Lag-Llama repository cloned" "[ -d lag-llama ]"
check_item "UniTS repository cloned" "[ -d UniTS ]"
check_item "PatchTST repository cloned" "[ -d PatchTST ]"

echo ""
echo "⚙️ Environment Configuration Checks:"
check_item "TIME-MOE environment.yml exists" "[ -f Time-MoE/environment.yml ]"
check_item "Chronos environment.yml exists" "[ -f chronos-forecasting/environment.yml ]"
check_item "Moirai environment.yml exists" "[ -f uni2ts/environment.yml ]"
check_item "Lag-Llama environment.yml exists" "[ -f lag-llama/environment.yml ]"
check_item "UniTS environment.yml exists" "[ -f UniTS/environment.yml ]"
check_item "PatchTST environment.yml exists" "[ -f PatchTST/environment.yml ]"

echo ""
echo "🐳 Docker Configuration Checks:"
check_item "TIME-MOE Dockerfile exists" "[ -f Time-MoE/Dockerfile ]"
check_item "Chronos Dockerfile exists" "[ -f chronos-forecasting/Dockerfile ]"
check_item "Moirai Dockerfile exists" "[ -f uni2ts/Dockerfile ]"
check_item "Lag-Llama Dockerfile exists" "[ -f lag-llama/Dockerfile ]"
check_item "UniTS Dockerfile exists" "[ -f UniTS/Dockerfile ]"
check_item "PatchTST Dockerfile exists" "[ -f PatchTST/Dockerfile ]"

echo ""
echo "🔧 Tool Dependencies Checks:"
check_item "Conda available" "command -v conda"
check_item "Git available" "command -v git"
check_item "Docker available" "command -v docker" true
check_item "NVIDIA GPU available" "command -v nvidia-smi" true

echo ""
echo "📊 Summary:"
echo "─────────────────────────────────────────────────"
echo -e "Total checks: ${BLUE}$total_checks${NC}"
echo -e "Passed: ${GREEN}$success_count${NC}"
echo -e "Failed: ${RED}$((total_checks - success_count))${NC}"

if [ $success_count -eq $total_checks ]; then
    echo ""
    echo -e "${GREEN}🎉 All checks passed! Repository is ready to use.${NC}"
    echo ""
    echo "🚀 Next steps:"
    echo "  1. Run: ./manage_envs.sh setup"
    echo "  2. Activate an environment: conda activate chronos"
    echo "  3. Start experimenting with time series models!"
    echo ""
    echo "📚 Documentation:"
    echo "  • Overview: README.md"
    echo "  • Model comparison: models.md"
    echo "  • Environment guide: ENVIRONMENT_SETUP.md"
    echo "  • Papers: papers/README.md"
    exit 0
else
    echo ""
    echo -e "${YELLOW}⚠️  Some checks failed, but repository might still be usable.${NC}"
    echo ""
    echo "💡 Troubleshooting:"
    echo "  • Run: ./manage_envs.sh status"
    echo "  • Check: ENVIRONMENT_SETUP.md"
    echo "  • For help: ./manage_envs.sh help"
    exit 1
fi
