# file-processing-guide

**file-processing-guide** is a companion library designed to showcase practical examples of the `file-processing` suite. This guide includes example notebooks demonstrating key functionalities from each library in the suite, covering file processing, OCR, transcription, and analytics. These examples help users understand how to utilize and integrate the capabilities of `file-processing` and its plugins effectively.

---

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Example Notebooks](#example-notebooks)
- [Getting Started](#getting-started)

---

## Overview

The `file-processing` suite enables handling, analyzing, and extending the processing of diverse file types. This guide contains examples for:

- **Core File Processing**: Working with various file types and extracting metadata.
- **OCR**: Using OCR to extract text from images.
- **Transcription**: Transcribing audio and video files to text.
- **Analytics**: Aggregating metadata from multiple files into a structured CSV format.

Each example notebook focuses on specific functionalities to demonstrate practical usage.

---

## Installation

To install all dependencies for running the examples, use the provided `requirements.txt` file:

```bash
pip install -r requirements.txt
```

This will install `file-processing`, `file-processing-ocr`, `file-processing-transcription`, and `file-processing-analytics` along with their necessary Python dependencies.

For Tesseract OCR and FFmpeg, which are required for OCR and transcription functionalities, please refer to the README files of the respective libraries:

- **Tesseract OCR**: Refer to the [file-processing-ocr](https://github.com/hc-sc-ocdo-bdpd/file-processing-ocr) README for installation instructions.
- **FFmpeg**: Refer to the [file-processing-transcription](https://github.com/hc-sc-ocdo-bdpd/file-processing-transcription) README for installation instructions.

---

## Example Notebooks

Each example notebook is located in the `examples` directory and covers a specific aspect of the `file-processing` suite:

1. **file_processing_demo.ipynb**  
   Demonstrates core file processing capabilities, extracting metadata and text content from a PDF and CSV file.

2. **file_processing_ocr_demo.ipynb**  
   Shows how to use the OCR plugin to extract text from images (`Charter_of_Rights_and_Freedoms.jpg` and `Health_Canada_logo.png`). The `OCRDecorator` plugin wraps file objects, storing extracted OCR text in the `metadata` dictionary.

3. **file_processing_transcription_demo.ipynb**  
   Explains how to transcribe audio and video files (`rights-and-responsibilities.mp3` and `phac_food_safety.mp4`) using the transcription plugin. Transcribed text and detected language are stored in the `metadata` dictionary.

4. **file_processing_analytics_demo.ipynb**  
   Illustrates metadata extraction for multiple files using `file-processing-analytics`. Processes a collection of sample files and saves metadata, including any errors encountered, in a CSV.

Each notebook is designed to be self-contained, providing clear instructions and code snippets.

---

These notebooks serve as practical guides, enabling hands-on experimentation with the `file-processing` suite.