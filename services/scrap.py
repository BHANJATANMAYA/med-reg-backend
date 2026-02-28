import requests
from bs4 import BeautifulSoup

def scrape_content(urls):

    contents = []

    for url in urls:
        try:
            res = requests.get(url, timeout=5)
            soup = BeautifulSoup(res.text, "lxml")

            paragraphs = soup.find_all("p")
            text = " ".join([p.get_text() for p in paragraphs[:10]])

            contents.append({
                "url": url,
                "content": text
            })

        except:
            continue

    return contents