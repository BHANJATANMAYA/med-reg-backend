from services.embed import gemini_client
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from services.generate import generate_answer
from services.intent import detect_intent
from services.search import medical_search
from services.scrap import scrape_content
from services.clean import clean_content
from services.embed import embed_content
from services.vector_store import store_embeddings, retrieve_from_pinecone

app = FastAPI()

# CORS — allow frontend dev server
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class QueryRequest(BaseModel):
    query: str

@app.post("/ask-medical")
async def ask_medical(req: QueryRequest):

    intent = await detect_intent(req.query)

    links = medical_search(req.query)

    raw_content = scrape_content(links)

    clean_data = clean_content(raw_content)

    embedded_data = await embed_content(clean_data)

    await store_embeddings(embedded_data)

    query_embed = gemini_client.models.embed_content(
    model="gemini-embedding-001",
    contents=req.query
)
    query_embedding = query_embed.embeddings[0].values
    relevant_chunks = await retrieve_from_pinecone(query_embedding)

    final_answer = await generate_answer(req.query, relevant_chunks)

    return {
    "query": req.query,
    "intent": intent,
    "answer": final_answer,
    "sources": [c["url"] for c in relevant_chunks]
}