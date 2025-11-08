#!/bin/bash

# Setup script for "Collective as Research Tool" project
# This demonstrates reproducible research setup

set -e

echo "🔬 Setting up Collective Research Methodology Project..."

# Check prerequisites
echo "📋 Checking prerequisites..."

if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required but not installed"
    exit 1
fi

if ! command -v npx &> /dev/null; then
    echo "❌ npx is required but not installed"
    exit 1
fi

echo "✅ Prerequisites satisfied"

# Check if collective is already initialized
if [ -d "../.claude-collective" ]; then
    echo "✅ Claude Code Collective already initialized in parent directory"
else
    echo "📦 Installing Claude Code Collective..."
    echo "Run this in the parent directory: npx claude-code-collective init"
    echo "Then re-run this setup script"
    exit 1
fi

# Check Task Master
if [ -d "../.taskmaster" ]; then
    echo "✅ Task Master already initialized"
else
    echo "📦 Task Master not found. To use Task Master for this research:"
    echo "  1. cd .."
    echo "  2. task-master init"
    echo "  3. task-master parse-prd collective-as-research-tool/research-plan.md"
fi

# Create directory structure
echo "📁 Creating project structure..."

mkdir -p src/experiments
mkdir -p src/benchmarks
mkdir -p tests
mkdir -p findings
mkdir -p docs

# Create template files
echo "📝 Creating template files..."

# Metrics template
cat > findings/metrics-template.json << 'EOF'
{
  "experiment_name": "",
  "date": "",
  "method": "traditional|collective",
  "time_to_complete_hours": 0,
  "code_quality": {
    "test_coverage_percent": 0,
    "documentation_completeness": 0,
    "lines_of_code": 0,
    "complexity_score": 0
  },
  "accuracy": {
    "documentation_errors": 0,
    "hallucinations": 0,
    "verified_claims_percent": 0
  },
  "reproducibility": {
    "setup_steps": 0,
    "dependencies_count": 0,
    "reproduction_success": false
  },
  "findings": [],
  "notes": ""
}
EOF

# Example experiment template
cat > src/experiments/experiment-template.py << 'EOF'
"""
Experiment Template

Research Question: [Your question here]
Hypothesis: [Your hypothesis]
Method: Traditional / Collective
"""

def setup():
    """Setup experiment environment"""
    pass

def run_experiment():
    """Execute the experiment"""
    pass

def collect_metrics():
    """Collect quantitative data"""
    pass

def analyze_results():
    """Analyze and interpret results"""
    pass

if __name__ == "__main__":
    setup()
    run_experiment()
    results = collect_metrics()
    analyze_results()
EOF

# Test template
cat > tests/test-template.py << 'EOF'
"""
Test Template for Research Experiments

Following TDD methodology for research code
"""

import pytest

def test_experiment_setup():
    """Verify experiment environment is correct"""
    pass

def test_experiment_execution():
    """Verify experiment runs successfully"""
    pass

def test_metrics_collection():
    """Verify metrics are collected correctly"""
    pass

def test_results_reproducibility():
    """Verify results can be reproduced"""
    pass
EOF

# README for findings
cat > findings/README.md << 'EOF'
# Research Findings

This directory contains collected metrics, analysis, and conclusions from experiments.

## Files

- `metrics-*.json` - Quantitative metrics from each experiment
- `analysis-*.md` - Detailed analysis and interpretation
- `comparison.md` - Cross-experiment comparisons

## Metrics Collection

Use the metrics template to ensure consistent data collection across experiments.

## Analysis Guidelines

1. Record raw data first
2. Calculate derived metrics
3. Interpret results
4. Compare across methods
5. Draw conclusions
6. Document limitations
EOF

echo "✅ Project structure created"

# Install Python dependencies (if needed)
if [ -f "requirements.txt" ]; then
    echo "📦 Installing Python dependencies..."
    if command -v pip &> /dev/null; then
        pip install -r requirements.txt
    else
        echo "⚠️  pip not found, skipping Python dependencies"
    fi
fi

echo ""
echo "✨ Setup complete!"
echo ""
echo "📚 Next steps:"
echo "  1. Review README.md for research overview"
echo "  2. Review research-plan.md for detailed methodology"
echo "  3. Start experiments: cd src/experiments"
echo "  4. Use collective: /van \"Research [topic]\""
echo "  5. Track with Task Master: task-master parse-prd research-plan.md"
echo ""
echo "🔬 Happy researching!"
