# Configuration file for the Sphinx documentation builder.

import os
import sys
from datetime import datetime

# -- Project information -----------------------------------------------------
project = 'File Processing Suite of Libraries'
author = 'Office of the Chief Data Officer (OCDO) - Health Canada'
copyright = f'{datetime.now().year}, Health Canada'
release = '1.0'

# -- General configuration ---------------------------------------------------

# Determine the directory containing conf.py
conf_dir = os.path.dirname(os.path.abspath(__file__))

# The temp_repos directory is relative to conf.py
temp_repos_dir = os.path.abspath(os.path.join(conf_dir, '..', 'temp_repos'))

# Add paths to the sys.path
sys.path.insert(0, os.path.join(temp_repos_dir, 'file-processing'))
sys.path.insert(0, os.path.join(temp_repos_dir, 'file-processing-ocr'))
sys.path.insert(0, os.path.join(temp_repos_dir, 'file-processing-transcription'))
sys.path.insert(0, os.path.join(temp_repos_dir, 'file-processing-analytics'))
sys.path.insert(0, os.path.join(temp_repos_dir, 'file-processing-test-data'))

extensions = [
    'sphinx.ext.autodoc',           # Automatically documents modules
    'sphinx.ext.napoleon',          # Supports Google and NumPy-style docstrings
    'sphinx.ext.viewcode',          # Adds links to source code
    'sphinx.ext.autodoc.typehints', # Shows type hints in docs
    'myst_parser',                  # Optional: Markdown support
]

# Only keep intersphinx mapping for Python
intersphinx_mapping = {
    'python': ('https://docs.python.org/3', None),
}

# Napoleon settings to format Google/NumPy style docstrings
napoleon_google_docstring = True
napoleon_numpy_docstring = True

# Exclude unnecessary files or directories (like tests or setup scripts)
exclude_patterns = ['**/tests/**', '**/setup.py', '**/setup.rst', '**/conf.py', '**/build/**', '**/temp_repos/**']

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# -- Options for HTML output -------------------------------------------------

# Use the Read the Docs theme for HTML output
html_theme = 'sphinx_rtd_theme'

# Paths for static files (like custom CSS)
html_static_path = ['_static']

# Additional theme options
html_theme_options = {
    'navigation_depth': 3,
}

# Custom CSS (optional)
html_css_files = ['custom.css']

# -- Options for Extensions --------------------------------------------------

# Autodoc settings
autodoc_member_order = 'bysource'  # Order members by source order in code files
autodoc_typehints = 'description'  # Show type hints in the description

# MyST configuration (if you want to support Markdown files)
myst_enable_extensions = [
    "deflist",  # Enables definition lists
]
