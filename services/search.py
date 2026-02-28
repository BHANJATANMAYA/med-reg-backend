import os
import requests
from dotenv import load_dotenv

load_dotenv()

SERPER_API_KEY = os.getenv("SERPER_API_KEY")

def medical_search(query):

    url = "https://google.serper.dev/search"

    payload = {
        "q": f"{query} site:who.int OR site:mayoclinic.org OR site:nhs.uk"
    }

    headers = {
        "X-API-KEY": SERPER_API_KEY,
        "Content-Type": "application/json"
    }

    response = requests.post(url, json=payload, headers=headers)
    results = response.json()

    links = []

    for item in results.get("organic", []):
        links.append(item.get("link"))

    return links[:5]