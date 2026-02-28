import os
from openai import AsyncOpenAI
from dotenv import load_dotenv

load_dotenv()

client = AsyncOpenAI(
    api_key=os.getenv("GROQ_API_KEY"),
    base_url="https://api.groq.com/openai/v1"
)

async def detect_intent(query):

    prompt = f"""
    Classify this medical query into one category:
    - TREATMENT
    - SIDE_EFFECT
    - DRUG_SAFETY
    - GENERAL_INFO

    Query: {query}

    Return only category.
    """

    response = await client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": prompt}]
    )

    return response.choices[0].message.content.strip()