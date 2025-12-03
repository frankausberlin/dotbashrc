# Dotbashrc: Modular Bash Configuration for AI/ML Development

## Project Description

Dotbashrc is a modular bash configuration framework designed specifically for AI/ML development environments. It provides a comprehensive set of aliases, functions, and settings that streamline workflow for machine learning engineers, data scientists, and AI developers. The configuration is organized into separate files for easy maintenance and customization, with built-in support for popular AI/ML tools, Python environments (Conda/Mamba), GPU acceleration (CUDA), and development workflows.

Key highlights include automated environment management, one-click launching of AI applications (Stable Diffusion, ComfyUI, Jupyter Lab, etc.), and intelligent error handling with AI-powered explanations.

## Installation

To install Dotbashrc, follow these steps:

1. Clone or download this repository to your local machine.
2. Copy the configuration files to your home directory:
   ```bash
   cp .bashrc ~/.bashrc
   cp .bash_aliases ~/.bash_aliases
   cp .bash_lib ~/.bash_lib
   ```
3. Source the new bash configuration:
   ```bash
   source ~/.bashrc
   ```
4. (Optional) Run the install script if it contains additional setup commands:
   ```bash
   ./install.sh
   ```

**Note:** The current install.sh script is empty. Manual installation as described above is recommended.

## Key Features

### Environment Management
- **Conda/Mamba Integration**: Automatic initialization and activation of Python environments
- **Virtual Environment Support**: Seamless switching between Conda environments and local .venv directories
- **Path Management**: Intelligent PATH and LD_LIBRARY_PATH configuration for CUDA, Android SDK, Go, and custom binaries

### AI/ML Tool Aliases
- **Jupyter Lab**: `jl` - Launch Jupyter Lab with Colab integration
- **Stable Diffusion WebUI**: `a11` - One-click launch with environment activation
- **ComfyUI**: `comfy` - Direct launch of ComfyUI interface
- **AI Assistants**: `ex` (ShellGPT), `what` (AI error explanation), `gem` (Gemini)
- **ML Workspaces**: `ml` - GPU-enabled ML workspace container
- **LLM Interfaces**: `anyllm`, `lmstudio`, `librechat`, `dify`, `spur`, `flow`, `n8`
- **Development Tools**: `cursor`, `pc` (PyCharm), `kc` (KiloCode)

### System Utilities
- **Update Management**: `suu` - System update with apt, flatpak, and snap
- **Docker Control**: `stop` - Stop all running containers
- **Navigation**: Quick directory aliases (`l`, `g`, `d`, `t`)
- **Remote Access**: SSH aliases for mobile devices (`doogee`, `redmi`, `teci`)

### Functions
- **nxx**: Enhanced nnn file manager with cd-on-quit functionality
- **jl**: Jupyter Lab launcher with custom configuration
- **adx**: Android Debug Bridge helper for device connections and package management
- **exportadd**: Safe path addition to environment variables
- **exportfolder**: Batch export of environment variables from config files

### Settings and Behaviors
- **History Management**: Configured to ignore duplicates and append history
- **Prompt Customization**: Colored prompt with user/host/directory info
- **Error Trapping**: Automatic error logging with AI-powered analysis
- **FZF Integration**: Fuzzy finder keybindings for enhanced navigation
- **Color Support**: Enabled for ls, grep, and other commands

## Customization Guide

Dotbashrc is designed for easy customization. Here's how to modify and extend it:

### Adding Aliases
Edit `~/.bash_aliases` to add new aliases:
```bash
alias myalias='command --options'
```

### Adding Functions
Add custom functions to `~/.bash_lib`:
```bash
myfunction() {
    # Your function code here
    echo "Hello from myfunction"
}
```

### Environment Variables
- Use `exportadd` function for safe PATH additions
- Place custom exports in `~/.config/_exports/` files (one file per variable)
- Modify exports directly in `~/.bashrc` for global settings

### Conditional Loading
The configuration includes conditional loading based on:
- Terminal type (VSCode detection)
- Presence of `.venv` directories
- Available tools and paths

### Reloading Configuration
Use `rlb` alias to reload the bash configuration without restarting the terminal.

## Troubleshooting

### Common Issues

1. **Conda/Mamba not initializing**
   - Ensure Miniconda/Miniforge is installed
   - Check paths in `~/.bashrc` match your installation
   - Run `rlb` to reload configuration

2. **CUDA/GPU tools not found**
   - Verify CUDA installation and paths
   - Check `LD_LIBRARY_PATH` configuration
   - Ensure GPU drivers are installed

3. **Aliases not working**
   - Confirm `~/.bash_aliases` is sourced in `~/.bashrc`
   - Check for syntax errors in alias definitions
   - Reload with `source ~/.bashrc`

4. **Jupyter Lab connection issues**
   - Verify port 8888 is available
   - Check firewall settings for Colab integration
   - Ensure Python environment has Jupyter installed

5. **Error trapping not working**
   - Check write permissions for `~/.lasterror`
   - Verify `what` alias has required dependencies (ShellGPT)

### Debug Tips
- Use `rlb` to test configuration changes
- Check `~/.lasterror` for trapped command errors
- Enable verbose output by modifying trap commands
- Test individual components by sourcing files separately

### Getting Help
- Use `what` (german for 'What the fuck!') alias for AI-powered error analysis
- Check system logs for startup issues
- Verify all required dependencies are installed

## Contribution Guidelines

We welcome contributions to improve Dotbashrc! Here's how to get involved:

### Development Setup
1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/dotbashrc.git`
3. Make changes in your local copy
4. Test thoroughly in your environment
5. Submit a pull request with detailed description

### Code Standards
- **Modularity**: Keep related functionality grouped in appropriate files
- **Documentation**: Comment complex functions and aliases
- **Compatibility**: Test on multiple systems (Ubuntu, Debian, etc.)
- **Security**: Avoid hardcoded sensitive information

### File Organization
- `.bashrc`: Main configuration and sourcing
- `.bash_aliases`: User aliases and shortcuts
- `.bash_lib`: Custom functions and utilities
- `install.sh`: Installation automation (currently empty)

### Testing
- Test all aliases and functions
- Verify environment variable handling
- Check compatibility with different shell versions
- Ensure no conflicts with existing configurations

### Reporting Issues
- Use GitHub issues for bug reports
- Include your system information (OS, shell version)
- Provide steps to reproduce issues
- Suggest improvements with clear use cases

### Feature Requests
- Open issues with "enhancement" label
- Describe the problem and proposed solution
- Consider backward compatibility
- Provide examples when possible

Thank you for contributing to making AI/ML development more efficient!

PS

```shell
#                 (re)create a data science environment with all the goodies and activate it
# _______________________________________________________________________________________________________________________
py=3.12 && ENV_NAME="ds${py: -2}" && mamba deactivate && mamba remove -y -n $ENV_NAME --all 2>/dev/null 
mamba   create -y -n $ENV_NAME python=$py google-colab uv pytorch torchvision torchaudio tensorflow scikit-learn jax \
        numba -c pytorch -c conda-forge && mamba activate $ENV_NAME
uv pip  install -U jupyterlab jupyter_http_over_ws jupyter-ai[all] jupyterlab-github xeus-python shell-gpt llama-index \
        langchain langchain-ollama langchain-openai langchain-community transformers[torch] evaluate accelerate \
        google-genai nltk tf-keras rouge_score huggingface-hub datasets unstructured[all-docs] jupytext hrid fastai \
        opencv-python soundfile librosa nbdev ollama setuptools wheel graphviz mcp PyPDF2 vllm \
        ipywidgets==7.7.1 click==8.1.3
jupyter labextension enable jupyter_http_over_ws && echo $ENV_NAME > ~/.startenv
python  -m ipykernel install --user --name $ENV_NAME --display-name $ENV_NAME
# _________________________insert_in_.bashrc_and_use_'act'_instead_of_'mamba_activate'___________________________________
# mamba activate $(cat ~/.startenv)
# act() { [ "$#" -ne 0 ] && echo $1 > .startenv && mamba activate $1; }
```



