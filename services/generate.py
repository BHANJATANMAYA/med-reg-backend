import os
import json
from openai import AsyncOpenAI
from dotenv import load_dotenv

load_dotenv()

client = AsyncOpenAI(
    api_key=os.getenv("GROQ_API_KEY"),
    base_url="https://api.groq.com/openai/v1"
)

async def generate_answer(query, context):

    combined_context = "\n\n".join([c["content"] for c in context])

    prompt = f"""
You are a medical assistant AI.

Use ONLY the context below to answer.

Context:
{combined_context}

Question:
{query}

Return response STRICTLY in JSON format like this:

{{
  "condition": "",
  "treatments": [],
  "safety_note": "",
  "risk_level": "",
  "explanation": ""
}}

Risk level must be one of:
- Safe OTC
- Consult Doctor
- Emergency

Do NOT return anything outside JSON.
"""

    response = await client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": prompt}]
    )

    raw = response.choices[0].message.content

    try:
       structured = json.loads(raw)
    except:
       structured = {
        "condition": "Unknown",
        "treatments": [],
        "safety_note": "",
        "risk_level": "Consult Doctor",
        "explanation": raw
    }

    return structured