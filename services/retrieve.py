import numpy as np
from sentence_transformers import SentenceTransformer

model = SentenceTransformer('all-MiniLM-L6-v2')

def cosine_similarity(a, b):
    return np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b))

async def retrieve_relevant(query, embedded_data):

    query_embedding = model.encode(query)

    scored = []

    for item in embedded_data:
        score = cosine_similarity(query_embedding, item["embedding"])
        scored.append((score, item))

    scored.sort(reverse=True, key=lambda x: x[0])

    top_results = [
    {
        "url": item["url"],
        "content": item["content"]
    }
    for score, item in scored[:3]
]

    return top_results