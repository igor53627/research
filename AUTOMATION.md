# Research Repository Automation

This document explains the automated systems in this research repository.

## Overview

The repository uses **GitHub Actions** and **Cogapp** to automatically maintain an up-to-date project listing in the main README.md.

## How It Works

### 1. Cog-Based README Generation

The main README.md contains embedded Python code that generates project listings:

```markdown
## Projects

<!--[[[cog
# Python code to discover and list projects
]]]-->
Generated project listings appear here
<!--[[[end]]]-->
```

### 2. GitHub Actions Workflow

On every push to `main`:
1. GitHub Actions checks out the repository
2. Installs Python and cogapp
3. Runs `cog -r -P README.md`
4. Commits updated README if changed

### 3. Project Discovery

The Python code automatically:
- Scans all directories in the repository root
- Filters out hidden directories (`.git`, `.github`, etc.)
- Reads `_summary.md` and `README.md` from each project
- Extracts metadata (research question, status, creation date)
- Generates formatted listings sorted by date

## Creating New Research Projects

### Quick Start

```bash
# 1. Create project directory
mkdir my-research-project
cd my-research-project

# 2. Create summary file
cat > _summary.md << 'EOF'
# Summary: My Research Project

**Research Focus**: Investigating X vs Y performance characteristics

**Key Question**: Which approach is more efficient?

**Methodology**: Comparative benchmarking with standardized tests

**Status**: Initial exploration phase

**Interesting Aspect**: First study to compare these specific approaches
EOF

# 3. Create main README
cat > README.md << 'EOF'
# My Research Project

## Research Question
Which approach is more efficient for [specific task]?

**Status**: Active Investigation

## Approach
[Describe methodology]

## Findings
[Document results]
EOF

# 4. Add code, tests, etc.
mkdir -p src tests findings
touch setup.sh

# 5. Commit and push
git add .
git commit -m "Research: Initial setup for my-research-project"
git push
```

The README will automatically update within minutes!

### Required Files

**Minimal Setup**:
- `README.md` - Must include research question
- `_summary.md` - Short summary for listings (optional)

**Recommended**:
- `setup.sh` - Reproducible setup script
- `src/` - Implementation code
- `tests/` - Test suites
- `findings/` - Metrics and analysis

### Summary File Format

Create `_summary.md` with this structure:

```markdown
# Summary: [Project Name]

**Research Focus**: [One sentence - what you're studying]

**Key Question**: [Main research question]

**Methodology**: [How you're investigating]

**Status**: [Current state - e.g., "Active", "Completed", "Planning"]

**Interesting Aspect**: [What makes this unique]
```

## Manual Updates

### Local Testing

Before pushing, test the README generation locally:

```bash
# Install cogapp
pip install -r requirements.txt

# Generate updated README
python -m cogapp -r -P README.md

# Review changes
git diff README.md
```

### Force Regeneration

To force GitHub Actions to regenerate:

```bash
# Make a small change and push
git commit --allow-empty -m "Trigger README update"
git push
```

Or use manual workflow dispatch in GitHub Actions UI.

## Project Metadata

### Extracted from README.md

The automation looks for:

**Title**: First `# Heading` in README.md

**Research Question**: Line after "Research Question" or similar heading

**Status**: Value after "Status:" or "**Status**"

Example:
```markdown
# My Research Title

## Research Question
Can we improve performance by 50% using method X?

**Status**: Active Investigation
```

### Creation Date

Extracted from Git history:
```bash
git log --diff-filter=A --follow --format=%aI --reverse -- project-dir/
```

Uses the date of the first commit that added the directory.

## Customization

### Modify Listing Format

Edit the Python code in README.md between `<!--[[[cog` and `]]]-->`:

```python
# Example: Add tags to projects
print(f"**Tags**: {', '.join(project_tags)}")
```

### Change Sort Order

Modify the sort key:
```python
# Sort alphabetically instead of by date
projects.sort(key=lambda x: x[0].name)
```

### Filter Projects

Add conditions to exclude certain directories:
```python
if (d.is_dir() and
    not d.name.startswith('.') and
    d.name != 'templates'):  # Skip templates dir
```

## Troubleshooting

### README Not Updating

**Check workflow status**:
1. Go to GitHub → Actions tab
2. Look for "Update README with project listings" workflow
3. Check for errors

**Common issues**:
- Cog markers missing or malformed
- Python syntax error in cog block
- Project directory is hidden (starts with `.`)
- No `_summary.md` or `README.md` in project

**Test locally**:
```bash
python -m cogapp -r -P README.md
# If this fails, fix the Python code in the cog block
```

### Project Not Appearing

**Checklist**:
- [ ] Directory is in repository root
- [ ] Directory doesn't start with `.`
- [ ] Directory contains `README.md` or `_summary.md`
- [ ] Changes committed and pushed to `main` branch
- [ ] GitHub Actions workflow completed successfully

**Debug**:
```bash
# Check what directories exist
ls -la

# Check git history for directory
git log --follow -- project-name/

# Test cog locally
python -m cogapp -r -P README.md
```

### Workflow Permission Errors

If GitHub Actions can't commit:
1. Go to Settings → Actions → General
2. Scroll to "Workflow permissions"
3. Select "Read and write permissions"
4. Click "Save"

## Advanced Usage

### Multiple READMEs

To generate listings in multiple files:

```bash
# Update all markdown files with cog blocks
cog -r -P README.md
cog -r -P docs/index.md
```

### Custom Scripts

Create `.github/scripts/generate_listings.py`:

```python
#!/usr/bin/env python3
# Custom project discovery and formatting
```

Update workflow to use it:
```yaml
- name: Generate listings
  run: python .github/scripts/generate_listings.py
```

### Scheduled Updates

Add schedule trigger to workflow:

```yaml
on:
  push:
    branches: [main]
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sunday
```

## See Also

- [GitHub Actions Documentation](.github/README.md)
- [Cogapp Documentation](https://nedbatchelder.com/code/cog/)
- [Main README](README.md)
- [Example Project](collective-as-research-tool/README.md)

---

*Automation makes research scalable. Focus on discoveries, not documentation!*
