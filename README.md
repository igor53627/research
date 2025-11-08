# Research

Independent research projects carried out by LLM tools - primarily Claude Code. Each directory in this repo represents a separate investigation where **every single line of text and code was written by an LLM**.

## About this repository

This collection demonstrates AI-assisted technical research across diverse domains. Each project includes complete implementations, analysis, benchmarks, and findings - all generated through iterative collaboration with Claude Code.

The goal is to explore how LLMs can conduct rigorous technical research: proposing hypotheses, implementing experiments, collecting metrics, and drawing evidence-based conclusions.

## Methodology

Projects follow a structured research workflow:

1. **Define research question** - Human provides direction and scope
2. **LLM explores and implements** - Claude Code researches, codes, tests
3. **Collect data and metrics** - Benchmarks, comparisons, measurements
4. **Document findings** - Complete writeups with reproducible results
5. **Commit with transparency** - Links to prompts and transcripts when available

Each project includes:
- Research question and hypothesis
- Working code implementations
- Test suites and benchmarks
- Metrics and analysis
- Clear conclusions
- Setup scripts for reproducibility

## Projects

<!--[[[cog
import subprocess
from pathlib import Path
from datetime import datetime

def get_creation_date(dir_path):
    """Get the creation date of a directory from git log"""
    try:
        result = subprocess.run(
            ['git', 'log', '--diff-filter=A', '--follow', '--format=%aI',
             '--reverse', '--', str(dir_path)],
            capture_output=True,
            text=True,
            check=True
        )
        if result.stdout.strip():
            # Get first commit date
            date_str = result.stdout.strip().split('\n')[0]
            return datetime.fromisoformat(date_str).date()
    except:
        pass
    return datetime.now().date()

def read_summary(project_dir):
    """Read _summary.md if it exists"""
    summary_file = project_dir / '_summary.md'
    if summary_file.exists():
        content = summary_file.read_text().strip()
        # Remove the "# Summary: [title]" heading if present
        lines = content.split('\n')
        if lines and lines[0].startswith('# Summary:'):
            return '\n'.join(lines[2:]).strip()  # Skip heading and blank line
        return content
    return None

def read_readme_first_section(project_dir):
    """Extract research question and key info from project README"""
    readme_file = project_dir / 'README.md'
    if not readme_file.exists():
        return None, None, None

    content = readme_file.read_text()
    lines = content.split('\n')

    # Extract title
    title = None
    for line in lines:
        if line.startswith('# '):
            title = line[2:].strip()
            break

    # Extract research question
    research_question = None
    for i, line in enumerate(lines):
        if 'Research Question' in line or 'research question' in line.lower():
            if i + 1 < len(lines):
                research_question = lines[i + 1].strip().lstrip('*-: ')
            break

    # Extract status
    status = "Active"
    for line in lines:
        if 'Status:' in line or '**Status**' in line:
            status = line.split(':')[-1].strip().strip('*')
            break

    return title, research_question, status

# Get GitHub repo URL
try:
    result = subprocess.run(
        ['git', 'remote', 'get-url', 'origin'],
        capture_output=True,
        text=True,
        check=True
    )
    github_url = result.stdout.strip()
    # Convert SSH to HTTPS if needed
    if github_url.startswith('git@github.com:'):
        github_url = github_url.replace('git@github.com:', 'https://github.com/')
    if github_url.endswith('.git'):
        github_url = github_url[:-4]
except:
    github_url = "https://github.com/igor53627/research"

# Get all project directories (excluding hidden dirs and .github)
research_dir = Path('.')
projects = []

for d in research_dir.iterdir():
    if (d.is_dir() and
        not d.name.startswith('.') and
        d.name not in ['.github']):

        creation_date = get_creation_date(d)
        projects.append((d, creation_date))

# Sort by date (newest first)
projects.sort(key=lambda x: x[1], reverse=True)

# Generate listings for projects
for project_dir, creation_date in projects:
    title, research_question, status = read_readme_first_section(project_dir)
    summary = read_summary(project_dir)

    if not title:
        title = project_dir.name.replace('-', ' ').title()

    print(f"### [{title}]({github_url}/tree/main/{project_dir.name}) ({creation_date})")
    print()

    if summary:
        print(summary)
    else:
        if research_question:
            print(f"Investigating: {research_question}")
        else:
            print(f"Technical research exploring {title.lower()}.")

    print()

if not projects:
    print("*Projects will appear here as they are added to the repository.*")
    print()

]]]-->
### [Claude Code Sub-Agent Collective as a Research Methodology](https://github.com/igor53627/research/tree/main/collective-as-research-tool) (2025-11-08)

**Research Focus**: Evaluating the claude-code-sub-agent-collective framework as a structured methodology for technical research, comparing it to traditional single-agent AI assistance.

**Key Question**: Does the collective's hub-and-spoke coordination, TDD enforcement, and Context7 integration provide measurably better research outcomes?

**Methodology**: Comparative analysis running parallel experiments using both traditional and collective approaches, measuring efficiency, quality, accuracy, and reproducibility.

**Status**: Research framework established, experiments planned but not yet executed.

**Interesting Aspect**: Meta-research project - using the collective to study the collective's effectiveness for research!

<!--[[[end]]]-->

## Creating new research projects

Each project should be self-contained in its own directory with:

- `README.md` - Research question, methodology, findings
- `_summary.md` - Brief summary for auto-generated listings (optional)
- `setup.sh` - Reproducible setup script
- `src/` - Implementation code
- `tests/` - Test suites and benchmarks
- `findings/` - Metrics, data, analysis

The main README automatically updates via GitHub Actions using [Cog](https://nedbatchelder.com/code/cog/). Project summaries are either read from `_summary.md` or extracted from the project README.

## Tools and frameworks

Projects in this repository leverage:

- **Claude Code** - Primary LLM for research and implementation
- **Task Master AI** - Project planning and task orchestration
- **Claude Code Sub-Agent Collective** - Multi-agent coordination framework
- **Context7** - Real-time library documentation lookup
- Various testing, benchmarking, and analysis tools per project

## Philosophy

This repository embraces LLM-generated research as a legitimate methodology for technical exploration. By documenting everything - code, findings, metrics, reasoning - it demonstrates what AI-assisted research looks like when done rigorously.

Key principles:
- **Transparency** - Show the process, not just results
- **Reproducibility** - Complete setup instructions and scripts
- **Rigor** - Real benchmarks, tests, and measurements
- **Honesty** - Document limitations and failures, not just successes

---

*Automated technical research, conducted by AI, documented for humans.*
