# KA-Computer-Vision-Courses
This is the base repo for all computer vision courses for KAUST Academy.


# LaTeX Project Build Script

This repository contains a Bash script to compile LaTeX (`.tex`) files into PDFs using `latexmk`. It supports building either all LaTeX files in the project or a specific one, and moving the output to a designated directory.

## 📁 Project Structure

```

project-root/
│
├── build.sh           # The build script
├── Lectures/          # (Default) Output directory for generated PDFs
└── LaTeX/             # Directory containing .tex source files
    ├── file1.tex
    ├── file2.tex
    └── ...

```

## 🛠️ Requirements

- `latexmk`
- A working LaTeX distribution (e.g., TeX Live or MiKTeX)
- Bash shell

## 🚀 Usage

From the root directory, run the build script:

### Compile All `.tex` Files

```bash
./build.sh
````

This compiles **all** `.tex` files in the `LaTeX/` directory and moves the resulting PDFs to the `Lectures/` folder.

### Compile a Specific File

```bash
./build.sh --file filename.tex
```

Replace `filename.tex` with the name of the LaTeX file (located inside the `LaTeX/` directory) you want to compile.

### Specify an Output Directory

```bash
./build.sh --output CustomOutputDir
```

You can combine this with the `--file` flag:

```bash
./build.sh --file filename.tex --output CustomOutputDir
```

## 🧹 Cleanup

The script automatically cleans up auxiliary files generated during the build process, such as `.aux`, `.log`, `.toc`, etc.

## ❗ Notes

* All LaTeX source files **must be located in the `LaTeX/` directory**.
* If the specified file does not exist, the script will exit with an error.
* If no `--file` is provided, the script will default to building all `.tex` files.

## 📄 License

This project is licensed under the GPL-3.0 License - see the LICENSE file for details. 


