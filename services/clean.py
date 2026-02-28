import re

def clean_content(scraped_data):

    cleaned = []

    for item in scraped_data:
        text = item["content"]

        # Remove extra whitespace
        text = re.sub(r'\s+', ' ', text)

        # Remove very short sentences
        sentences = text.split(".")
        sentences = [s.strip() for s in sentences if len(s) > 50]

        clean_text = ". ".join(sentences)

        cleaned.append({
            "url": item["url"],
            "content": clean_text
        })

    return cleaned