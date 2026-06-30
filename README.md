# Building a Paul Graham Digital Twin: An R Web-Scraper & RAG Project

An automated data pipeline written in R to harvest over 200+ essays from Paul Graham's essay archives, compile them into a unified knowledge corpus, and deploy them into an LLM system (Google NotebookLM) to build a source-grounded digital twin persona.

## 🛠️ The Tech Stack
- **Language:** R
- **Packages:** `rvest` (Web Scraping), `tidyverse`/`dplyr` (Data Wrangling), `purrr` (Functional Loop Automation)
- **AI Architecture:** Retrieval-Augmented Generation (RAG) via Google NotebookLM

## 📂 Project Workflow

### 1. Web Scraping & Data Pipeline (`scripts/scraper.R`)
- **Index Traversal:** Programmatically mapped all article extensions ending in `.html` from the main archive.
- **Defensive Engineering:** Implemented a `tryCatch` error-handling wrapper to bypass broken links/non-essay nodes without halting the execution queue.
- **Polite Harvesting:** Enforced a 1-second operational latency (`Sys.sleep`) between server requests to ensure compliance with server traffic thresholds.

### 2. Persona Engineering & LLM Grounding
The unstructured text data was systematically joined using string manipulation techniques in R to produce a clean markdown/text matrix. This corpus was mapped into Google NotebookLM to isolate the AI's parameter boundaries, eliminating context drift and enforcing structural integrity based on PG's historical data.

## 🚀 How to Run the Scraper
1. Clone this repository.
2. Open RStudio and ensure `tidyverse` and `rvest` are installed.
3. Run `scripts/scraper.R` to generate your own text matrix.
