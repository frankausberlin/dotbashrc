#!/bin/bash

# Bash configuration installer script
# This script installs .bashrc, .bash_aliases, and .bash_lib from the current directory to the user's home directory.
# It provides options for dry-run, force installation, and selective file installation.

set -euo pipefail

# Default values
DRY_RUN=false
FORCE=false
INSTALL_ALL=true
INSTALL_MAIN=false
INSTALL_ALIASES=false
INSTALL_LIB=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}INFO:${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}WARN:${NC} $1"
}

log_error() {
    echo -e "${RED}ERROR:${NC} $1" >&2
}

# Function to check if command exists
check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        log_error "Required command '$1' not found. Please install it and try again."
        exit 1
    fi
}

# Function to backup file
backup_file() {
    local file="$1"
    local backup_dir="$HOME/.bashrc_backups"
    local timestamp
    timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="${backup_dir}/${file##*/}_${timestamp}"

    if [[ ! -d "$backup_dir" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            log_info "Would create backup directory: $backup_dir"
        else
            mkdir -p "$backup_dir"
            log_info "Created backup directory: $backup_dir"
        fi
    fi

    if [[ "$DRY_RUN" == true ]]; then
        log_info "Would backup $file to $backup_file"
    else
        cp "$file" "$backup_file"
        log_info "Backed up $file to $backup_file"
    fi
}

# Function to confirm action
confirm() {
    local message="$1"
    if [[ "$FORCE" == true ]]; then
        return 0
    fi

    read -p "$message (y/N): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Function to install file
install_file() {
    local source_file="$1"
    local target_file="$2"

    if [[ ! -f "$source_file" ]]; then
        log_error "Source file $source_file does not exist"
        return 1
    fi

    if [[ -f "$target_file" ]]; then
        if ! confirm "File $target_file already exists. Overwrite?"; then
            log_info "Skipping $target_file"
            return 0
        fi
        backup_file "$target_file"
    fi

    if [[ "$DRY_RUN" == true ]]; then
        log_info "Would copy $source_file to $target_file"
    else
        cp "$source_file" "$target_file"
        log_info "Installed $source_file to $target_file"
    fi
}

# Function to show usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Install bash configuration files from current directory to home directory.

OPTIONS:
    --dry-run           Preview actions without making changes
    --force             Skip all confirmations
    --aliases-only      Install only .bash_aliases
    --lib-only          Install only .bash_lib
    --main-only         Install only .bashrc
    --help              Show this help message

If no installation options are specified, all files (.bashrc, .bash_aliases, .bash_lib) will be installed.

EXAMPLES:
    $0                    # Install all files with confirmations
    $0 --dry-run          # Preview installation
    $0 --force            # Install all without confirmations
    $0 --aliases-only     # Install only aliases

EOF
}

# Parse command line options
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --force)
            FORCE=true
            shift
            ;;
        --aliases-only)
            INSTALL_ALL=false
            INSTALL_ALIASES=true
            shift
            ;;
        --lib-only)
            INSTALL_ALL=false
            INSTALL_LIB=true
            shift
            ;;
        --main-only)
            INSTALL_ALL=false
            INSTALL_MAIN=true
            shift
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Check required commands
log_info "Checking required commands..."
check_command cp
check_command mkdir
check_command date

# Determine which files to install
files_to_install=()

if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_MAIN" == true ]]; then
    files_to_install+=(".bashrc")
fi

if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_ALIASES" == true ]]; then
    files_to_install+=(".bash_aliases")
fi

if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_LIB" == true ]]; then
    files_to_install+=(".bash_lib")
fi

if [[ ${#files_to_install[@]} -eq 0 ]]; then
    log_error "No files selected for installation"
    exit 1
fi

log_info "Files to install: ${files_to_install[*]}"

# Install files
for file in "${files_to_install[@]}"; do
    source_file="./$file"
    target_file="$HOME/$file"

    if ! install_file "$source_file" "$target_file"; then
        log_error "Failed to install $file"
        exit 1
    fi
done

log_info "Installation completed successfully!"
if [[ "$DRY_RUN" == true ]]; then
    log_info "This was a dry run. No files were actually modified."
fi