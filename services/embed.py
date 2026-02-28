from sentence_transformers import SentenceTransformer

model = SentenceTransformer('all-MiniLM-L6-v2')

async def embed_content(clean_data):

    embeddings = []

    for item in clean_data:

        text = item["content"]

        vector = model.encode(text).tolist()

        embeddings.append({
            "url": item["url"],
            "content": text,
            "embedding": vector
        })

    return embeddings