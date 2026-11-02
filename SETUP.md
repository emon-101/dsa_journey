# One-time setup

```bash
# 1. Unzip, enter the folder
cd dsa-journey

# 2. Create an empty repo on GitHub named dsa-journey (no README), then:
git init
git add .
git commit -m "init: dsa journey starter"
git branch -M main
git remote add origin https://github.com/<your-username>/dsa-journey.git
git push -u origin main

# 3. Make scripts executable (Linux/macOS/Git Bash)
chmod +x scripts/*.sh
```

Windows: use Git Bash or WSL to run the `.sh` scripts.
Requires: `g++` (C++17), `git`, `python3`.
