# 🚀 MedRAG — AI-Powered Medical Evidence Assistant

🏥 Real-time Evidence-Based Treatment Guidance using Live RAG

---

# 📖 Overview

MedRAG is a real-time AI-powered clinical research assistant that analyzes medical queries using trusted health sources like WHO, NHS, and Mayo Clinic.

Instead of giving generic AI answers, MedRAG performs:

🔎 Live medical search
📄 Extracts trusted clinical information
🧠 Uses semantic retrieval (RAG)
🤖 Generates evidence-based responses

It helps users and healthcare professionals make safer, research-backed decisions.

---

# 🧠 Tech Stack

| Layer            | Technology                    |
| ---------------- | ----------------------------- |
| Frontend         | Flutter / Web UI              |
| Backend          | FastAPI (Python)              |
| AI Reasoning     | LLaMA 3 via Groq API          |
| Embeddings       | Sentence Transformers (Local) |
| Retrieval        | Cosine Similarity             |
| Scraping         | BeautifulSoup                 |
| Search           | Serper API                    |
| Deployment Ready | AWS / Render                  |

---

# ✨ Features

## 🔎 Natural Language Medical Queries

Example:

> “Best treatment for migraine”

MedRAG responds with:

✔ Treatments
✔ Safety Notes
✔ Risk Level
✔ Evidence-backed explanation

---

## 🌐 Live Medical Research

Instead of static data:

MedRAG searches:

• WHO
• NHS
• Mayo Clinic

in real-time.

---

## 🧠 Retrieval-Augmented Generation (RAG)

Ensures:

✔ No hallucinations
✔ Evidence grounding
✔ Context-aware answers

---

## 🚦 Safety-Aware Responses

Outputs include:

• Risk Level (OTC / Consult Doctor / Emergency)
• Medical Safety Notes

---

## 🧩 Structured AI Output

Responses are UI-friendly:

```json
{
  "condition": "Migraine",
  "treatments": [],
  "risk_level": "Consult Doctor",
  "safety_note": "",
  "explanation": ""
}
```

---

# 🏗️ System Architecture

```text
User Query
   ↓
Intent Detection
   ↓
Live Medical Search
   ↓
Scraping
   ↓
Cleaning
   ↓
Local Embeddings
   ↓
Retriever
   ↓
Groq AI Reasoning
   ↓
Evidence-Based Answer
```

---

# 🌟 Use Cases

✔ Clinical decision support
✔ Treatment research
✔ Patient education
✔ Risk awareness

---

# 🛠️ Getting Started

## Backend Setup

```bash
git clone https://github.com/BHANJATANMAYA/med-reg-backend.git
cd med-reg-backend

pip install -r requirements.txt
uvicorn main:app --reload
```

---

## Environment Variables

Create `.env`

```
GROQ_API_KEY=your_key
SERPER_API_KEY=your_key
```

---

# ⚠️ Disclaimer

MedRAG is designed for educational and research support only.
It is not a substitute for professional medical advice.
