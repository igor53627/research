# Research Repository

**AI-Assisted Technical Research and Experimentation**

This repository serves as a collection of independent research projects, explorations, and technical investigations conducted with the assistance of AI tools (primarily Claude Code). Each project represents a focused inquiry into a specific technical question, tool, or methodology.

## Philosophy

This repository embraces **AI-assisted research** as a legitimate and powerful approach to technical exploration. The methodology combines:

- **Human curiosity and direction** - defining questions worth investigating
- **AI capabilities** - rapid prototyping, analysis, and documentation
- **Transparency** - all code, findings, and reasoning documented
- **Reproducibility** - complete implementations with setup instructions

Every piece of code and documentation in this repository is crafted through collaborative work with AI, demonstrating what's possible when human insight guides machine capability.

## Repository Structure

Each research project lives in its own directory:

```
research/
├── README.md (this file)
├── project-name-1/
│   ├── README.md          # Project overview and findings
│   ├── _summary.md        # Auto-generated summary
│   ├── setup.sh           # Setup/installation script
│   ├── src/               # Implementation code
│   ├── tests/             # Tests and benchmarks
│   └── findings.md        # Detailed analysis
├── project-name-2/
│   └── ...
└── .github/
    └── workflows/
        └── update-readme.yml
```

## How to Conduct Research

### 1. **Define Your Question**

Start with a clear, focused research question:
- "How does X compare to Y in terms of performance?"
- "Can we implement Z using approach A?"
- "What are the trade-offs between method 1 and method 2?"

### 2. **Create Project Directory**

```bash
mkdir -p [descriptive-project-name]
cd [descriptive-project-name]
```

### 3. **Explore and Document**

Use Claude Code to:
- Research existing approaches
- Implement prototypes
- Run experiments and benchmarks
- Collect data and metrics
- Document findings in real-time

### 4. **Structure Your Findings**

Each project should include:

**README.md** - Overview and key findings
```markdown
# [Project Name]

## Research Question
[What you set out to investigate]

## Approach
[How you investigated it]

## Key Findings
- Finding 1
- Finding 2
- Finding 3

## Conclusions
[What you learned]

## Setup
[How to reproduce]
```

**Code** - Working implementations
- Source code in `src/`
- Tests in `tests/`
- Scripts for setup/benchmarks

**Documentation** - Detailed analysis
- Performance metrics
- Comparison tables
- Insights and observations
- Links to relevant resources

### 5. **Commit and Share**

```bash
git add .
git commit -m "Research: [topic] - [key finding or milestone]"
git push
```

Include prompts or transcript links in commits when relevant to show the research process.

## Research Workflow with Claude Code

### Typical Session Flow

```bash
# Start in project directory
cd research/[project-name]

# Launch Claude Code
claude

# Example prompts for research:
# "Let's explore how [technology X] handles [scenario Y]"
# "Can you implement a benchmark comparing [A] vs [B]?"
# "Help me analyze the performance characteristics of [Z]"
# "Document what we learned about [topic] with code examples"
```

### Using Task Master for Complex Research

For multi-phase research projects:

```bash
# Create research plan
task-master parse-prd research-plan.md

# Work through research phases
task-master next
task-master show <id>

# Track findings as you go
task-master update-subtask --id=<id> --prompt="Found that X performs 2x better than Y when..."
```

## Example Research Topics

**Performance & Optimization:**
- Database query optimization techniques
- Algorithm comparison and benchmarking
- Memory usage patterns in different approaches

**Technology Exploration:**
- Evaluating new libraries or frameworks
- Comparing implementation strategies
- Testing edge cases and limitations

**Proof of Concept:**
- Novel algorithm implementations
- Integration experiments
- Tooling and automation improvements

**Analysis & Measurement:**
- Performance profiling
- Code quality metrics
- Security vulnerability research

## Research Quality Guidelines

### Good Research Projects Include:

✅ **Clear Question** - Specific, answerable inquiry
✅ **Reproducible Setup** - Installation and run instructions
✅ **Working Code** - Actual implementations, not just theory
✅ **Measurements** - Benchmarks, tests, metrics
✅ **Documentation** - Findings, insights, conclusions
✅ **Transparency** - Show your work and reasoning

### Avoid:

❌ Vague or overly broad questions
❌ Missing setup instructions
❌ Undocumented results
❌ Untested assumptions
❌ Cherry-picked data

## Automation

This repository uses GitHub Actions to automatically:
- Discover new research projects
- Generate project summaries
- Update the main README with project listings
- Maintain fresh documentation

See `.github/workflows/update-readme.yml` for implementation details.

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
        return summary_file.read_text().strip()
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

# Get all project directories (excluding hidden dirs and .github)
research_dir = Path('.')
projects = []

for d in research_dir.iterdir():
    if (d.is_dir() and
        not d.name.startswith('.') and
        d.name != '.github' and
        d.name != 'collective-as-research-tool'):  # Will add manually below

        creation_date = get_creation_date(d)
        projects.append((d, creation_date))

# Sort by date (newest first)
projects.sort(key=lambda x: x[1], reverse=True)

# Add our main project first manually
print("### 1. [Claude Code Sub-Agent Collective as Research Methodology](./collective-as-research-tool/)")
print()
print("**Research Question**: Can the claude-code-sub-agent-collective framework be used as a structured methodology for conducting technical research?")
print()
print("**Started**: 2025-11-08")
print("**Status**: Active Investigation")
print()
summary_path = Path('collective-as-research-tool/_summary.md')
if summary_path.exists():
    print(summary_path.read_text().strip())
else:
    print("**Summary**: Evaluating whether the collective's hub-and-spoke coordination, TDD enforcement, and Context7 integration provide measurably better research outcomes compared to traditional single-agent AI assistance. This meta-research project uses the collective to study the collective's effectiveness!")
    print()
    print("**Key Areas**:")
    print("- Comparative benchmarking (traditional vs collective methodology)")
    print("- Research workflow optimization")
    print("- TDD applicability to research code")
    print("- Reproducibility and quality metrics")
print()
print("[View Full Project →](./collective-as-research-tool/README.md)")
print()

# Generate listings for other projects
project_num = 2
for project_dir, creation_date in projects:
    title, research_question, status = read_readme_first_section(project_dir)
    summary = read_summary(project_dir)

    if not title:
        title = project_dir.name.replace('-', ' ').title()

    print(f"### {project_num}. [{title}](./{project_dir.name}/)")
    print()

    if research_question:
        print(f"**Research Question**: {research_question}")
        print()

    print(f"**Started**: {creation_date}")
    print(f"**Status**: {status}")
    print()

    if summary:
        print(summary)
    else:
        print(f"Research project exploring {title.lower()}.")

    print()
    print(f"[View Full Project →](./{project_dir.name}/README.md)")
    print()

    project_num += 1

if project_num == 2:
    # Only our main project exists
    pass

]]]-->
### 1. [Claude Code Sub-Agent Collective as Research Methodology](./collective-as-research-tool/)

**Research Question**: Can the claude-code-sub-agent-collective framework be used as a structured methodology for conducting technical research?

**Started**: 2025-11-08
**Status**: Active Investigation

# Summary: Collective as Research Tool

**Research Focus**: Evaluating the claude-code-sub-agent-collective framework as a structured methodology for technical research, comparing it to traditional single-agent AI assistance.

**Key Question**: Does the collective's hub-and-spoke coordination, TDD enforcement, and Context7 integration provide measurably better research outcomes?

**Methodology**: Comparative analysis running parallel experiments using both traditional and collective approaches, measuring efficiency, quality, accuracy, and reproducibility.

**Status**: Research framework established, experiments planned but not yet executed.

**Interesting Aspect**: Meta-research project - using the collective to study the collective's effectiveness for research!

[View Full Project →](./collective-as-research-tool/README.md)

<!--[[[end]]]-->

## Contributing

This is a personal research repository, but the methodology and structure can be adapted for your own use. Feel free to:
- Fork and adapt the structure
- Use the templates for your own research
- Share findings and improvements

## License

Research findings and code are shared for educational purposes. Refer to individual project directories for specific licensing information.

---

**Research Philosophy**: *"The best way to understand something is to build it, measure it, and explain it clearly."*

*Powered by Claude Code and human curiosity.*
