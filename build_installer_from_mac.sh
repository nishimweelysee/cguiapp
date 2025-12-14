#!/bin/bash
# Build Windows installer .exe from macOS using GitHub Actions
# This creates a single installer .exe that installs everything automatically

echo "=========================================="
echo "Build Windows Installer from macOS"
echo "=========================================="
echo ""
echo "This will create a single installer .exe that:"
echo "  - Installs all dependencies automatically"
echo "  - Installs the application"
echo "  - Runs the app after installation"
echo "  - Users just double-click and everything works!"
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit - ready for Windows build"
    echo ""
    echo "Git repository initialized."
    echo ""
fi

# Check if GitHub remote exists
if ! git remote | grep -q origin; then
    echo "=========================================="
    echo "GitHub Setup Required"
    echo "=========================================="
    echo ""
    echo "To build the installer, you need to push to GitHub."
    echo ""
    echo "Steps:"
    echo "1. Create a new repository on GitHub:"
    echo "   https://github.com/new"
    echo ""
    echo "2. Copy the repository URL (e.g., https://github.com/username/repo.git)"
    echo ""
    read -p "Enter GitHub repository URL (or press Enter to skip): " repo_url
    
    if [ -n "$repo_url" ]; then
        git remote add origin "$repo_url"
        echo "Remote added: $repo_url"
    else
        echo ""
        echo "You can add the remote later with:"
        echo "  git remote add origin https://github.com/yourusername/repo.git"
        echo ""
    fi
fi

# Check if workflow file exists
if [ ! -f .github/workflows/build-windows.yml ]; then
    echo "[ERROR] GitHub Actions workflow not found!"
    echo "Please ensure .github/workflows/build-windows.yml exists"
    exit 1
fi

echo "=========================================="
echo "Ready to Build!"
echo "=========================================="
echo ""
echo "The GitHub Actions workflow will:"
echo "  1. Build the application"
echo "  2. Bundle all DLLs"
echo "  3. Create installer .exe"
echo ""
echo "To start the build:"
echo ""
echo "1. Push to GitHub:"
echo "   git add ."
echo "   git commit -m 'Build Windows installer'"
echo "   git push origin main"
echo ""
echo "2. Go to GitHub → Actions tab"
echo ""
echo "3. Wait for build to complete (~5-10 minutes)"
echo ""
echo "4. Download installer from Artifacts:"
echo "   GitHub → Actions → Latest workflow → Artifacts"
echo "   Download: StockManagement-Installer"
echo ""
echo "5. You'll get: StockManagement_Installer.exe"
echo "   This single file installs everything and runs the app!"
echo ""

read -p "Do you want to push to GitHub now? (y/n): " push_now

if [ "$push_now" = "y" ] || [ "$push_now" = "Y" ]; then
    echo ""
    echo "Pushing to GitHub..."
    git add .
    git commit -m "Build Windows installer" 2>/dev/null || git commit --amend -m "Build Windows installer"
    
    if git remote | grep -q origin; then
        git push origin main 2>/dev/null || git push origin master 2>/dev/null || {
            echo ""
            echo "Push failed. Please check your remote:"
            echo "  git remote -v"
            echo ""
            echo "Or set it up manually:"
            echo "  git remote add origin https://github.com/yourusername/repo.git"
            echo "  git push -u origin main"
        }
    else
        echo ""
        echo "No remote configured. Add it with:"
        echo "  git remote add origin https://github.com/yourusername/repo.git"
        echo "  git push -u origin main"
    fi
    
    echo ""
    echo "=========================================="
    echo "Build Started!"
    echo "=========================================="
    echo ""
    echo "Go to: https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/actions"
    echo ""
    echo "The installer will be ready in ~5-10 minutes!"
    echo ""
else
    echo ""
    echo "You can push later with:"
    echo "  git push origin main"
    echo ""
fi

echo "=========================================="
echo "What Users Will Do"
echo "=========================================="
echo ""
echo "1. Double-click: StockManagement_Installer.exe"
echo "2. Click 'Next' through installation wizard"
echo "3. App installs and runs automatically!"
echo ""
echo "No scripts, no manual steps - just double-click! ✅"
echo ""
