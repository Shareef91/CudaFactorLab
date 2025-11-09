# CudaFactorLab

Parallel factorization experiments (CUDA) — CSC 473 Parallel Processing, Assignment 4

Short description
-----------------
This small repository contains CUDA/C++ implementations for parallel factorization used for the CSC 473 assignment 4. It includes two CUDA source files and experiment output files.

Why this repo
--------------
- Demonstrates parallel algorithms implemented with CUDA (nvcc).
- Provides reproducible experiment outputs and build/run instructions.

Repository contents
-------------------
- `pfactor.cu` — CUDA implementation (primary file in workspace).
- `sfactor.cu` — Alternative implementation or serial version (if present).
- `*.exp` — Experiment/output files from runs (kept for grading/reproducibility).

Prerequisites
-------------
- NVIDIA GPU with CUDA toolkit installed (nvcc available).
- gcc/clang or MSVC (if building helper C/C++ files).

Build
-----
From the project root (PowerShell):

```powershell
cd 'c:\Users\ganam\OneDrive\Desktop\Fall Semester 2025\Parallel Processing CSC 473\assignment 4'
nvcc -O2 pfactor.cu -o pfactor
# or for the other file:
nvcc -O2 sfactor.cu -o sfactor
```

Run
---
After building, run the produced binary. Example (PowerShell):

```powershell
./pfactor <args>
# or
./sfactor <args>
```

Replace `<args>` with any input parameters your assignment expects (see comments at top of `pfactor.cu`).

Notes
-----
- The `.exp` files are stored for reproducibility and grading; regenerate them by running the binaries with the same inputs.
- If you rely on a Makefile or custom compilation flags, consider adding a `Makefile` or `build` script.

Contributing
------------
This repo is small and intended for course submission. If you want to extend it:

- Add a `Makefile` or CMake configuration for portability.
- Add a `tests/` folder with small input cases and expected outputs to quickly verify correctness.

Suggested next steps (to put on GitHub)
-------------------------------------
1. Initialize a local Git repo (already done in this workspace).
2. Create a new GitHub repository named `CudaFactorLab` (or pick one of the other suggested names below).
3. Add the GitHub remote and push your local branch:

```powershell
git remote add origin <GITHUB_REPO_URL>
git branch -M main
git push -u origin main
```

License
-------
If this is your assignment, keep the license as-is for school use; if you'd like a permissive license, add an `MIT` license file.

Contact
-------
If you want me to: create the GitHub repo for you, add a license, or expand the README with badges and CI instructions, tell me which option you want and (optionally) provide a GitHub personal access token or allow use of `gh` CLI.
