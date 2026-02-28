from fastapi import FastAPI
from pydantic import BaseModel
from services.generate import generate_answer
from services.intent import detect_intent
from services.search import medical_search
from services.scrap import scrape_content
from services.clean import clean_content
from services.embed import embed_content
from services.retrieve import retrieve_relevant
from services.generate import generate_answer

app = FastAPI()

class QueryRequest(BaseModel):
    query: str

@app.post("/ask-medical")
async def ask_medical(req: QueryRequest):

    intent = await detect_intent(req.query)

    links = medical_search(req.query)

    raw_content = scrape_content(links)

    clean_data = clean_content(raw_content)

    embedded_data = await embed_content(clean_data)

    relevant_chunks = await retrieve_relevant(req.query, embedded_data)

    final_answer = await generate_answer(req.query, relevant_chunks)

    return {
    "query": req.query,
    "intent": intent,
    "answer": final_answer,
    "sources": [c["url"] for c in relevant_chunks]
}