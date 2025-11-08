# GitHub Actions for Research Repository

## Auto-Update README Workflow

The `update-readme.yml` workflow automatically updates the main README.md with project listings whenever changes are pushed to the `main` branch.

### How It Works

1. **Trigger**: Runs on every push to `main` branch (or manual dispatch)
2. **Process**:
   - Checks out repository with full git history
   - Installs Python and cogapp
   - Runs `cog -r -P README.md` to regenerate project listings
   - Commits and pushes changes if README was modified

3. **Project Discovery**:
   - Scans all directories in the repository root
   - Excludes hidden directories (starting with `.`)
   - Reads `_summary.md` from each project directory
   - Extracts metadata from project README files
   - Sorts projects by creation date (newest first)

### Cog Integration

The README.md file contains Python code blocks delimited by cog markers:

```markdown
<!--[[[cog
# Python code to generate project listings
]]]-->
Generated content goes here
<!--[[[end]]]-->
```

When `cog -r -P README.md` runs:
- `-r`: Replace mode (update in place)
- `-P`: Print output to stdout as well

The Python code:
1. Discovers all project directories
2. Reads `_summary.md` files
3. Extracts research questions and status from READMEs
4. Generates formatted project listings
5. Sorts by creation date

### Creating New Projects

To add a new research project:

1. **Create project directory**:
   ```bash
   mkdir new-research-project
   cd new-research-project
   ```

2. **Add required files**:
   - `README.md` - Must include research question and status
   - `_summary.md` - Short summary for listings (optional but recommended)
   - `setup.sh` - Reproducible setup script
   - Source code, tests, findings

3. **Commit and push**:
   ```bash
   git add .
   git commit -m "Research: New project on [topic]"
   git push
   ```

4. **Automatic update**: GitHub Actions will automatically update the main README

### Manual Update

To manually update the README locally:

```bash
# Install cogapp
pip install cogapp

# Run cog
python -m cogapp -r -P README.md

# Or if cog is in PATH
cog -r -P README.md
```

### Project Summary Format

Create `_summary.md` in your project directory with this format:

```markdown
# Summary: [Project Name]

**Research Focus**: [One sentence description]

**Key Question**: [Main research question]

**Methodology**: [Brief description of approach]

**Status**: [Current state]

**Interesting Aspect**: [What makes this unique/notable]
```

The summary should be concise (3-5 paragraphs max) and highlight:
- What you're investigating
- How you're investigating it
- Current status
- Interesting findings or approaches

### Troubleshooting

**Workflow doesn't run**:
- Check `.github/workflows/update-readme.yml` exists
- Verify you pushed to `main` branch
- Check GitHub Actions tab for errors

**README not updating**:
- Verify cog markers are correct (`<!--[[[cog` and `<!--[[[end]]]-->`)
- Check Python code syntax in cog block
- Test locally with `python -m cogapp -r -P README.md`

**Project not appearing**:
- Ensure directory doesn't start with `.`
- Create `_summary.md` or `README.md` in project directory
- Check git log exists for the directory

### Dependencies

The workflow requires:
- Python 3.11
- cogapp (installed via requirements.txt)
- Git (for reading commit history)

All dependencies are automatically installed by the GitHub Action.
