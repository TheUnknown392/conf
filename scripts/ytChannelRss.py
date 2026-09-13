import re
import json
import requests
from pathlib import Path

INPUT_FILE = "channels.txt"
OUTPUT_FILE = "rss_urls.txt"

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/140.0.0.0 Safari/537.36"
    )
}


def get_rss_url(channel):
    # Allow either @handle or complete YouTube URL
    if channel.startswith("@"):
        url = f"https://www.youtube.com/{channel}"
    else:
        url = channel

    try:
        response = requests.get(
            url,
            headers=HEADERS,
            timeout=15
        )
        response.raise_for_status()

        html = response.text

        # Find ytInitialData
        match = re.search(
            r"var ytInitialData\s*=\s*(\{.*?\});",
            html
        )

        if not match:
            print(f"[ERROR] ytInitialData not found: {channel}")
            return None

        data = json.loads(match.group(1))

        rss_url = (
            data
            .get("metadata", {})
            .get("channelMetadataRenderer", {})
            .get("rssUrl")
        )

        if rss_url:
            return rss_url

        print(f"[ERROR] RSS URL not found: {channel}")

    except requests.RequestException as e:
        print(f"[ERROR] {channel}: {e}")

    except json.JSONDecodeError as e:
        print(f"[ERROR] JSON parsing failed for {channel}: {e}")

    return None


def main():
    input_path = Path(INPUT_FILE)
    output_path = Path(OUTPUT_FILE)

    channels = [
        line.strip()
        for line in input_path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]

    rss_urls = []

    for channel in channels:
        print(f"Processing: {channel}")

        rss_url = get_rss_url(channel)

        if rss_url:
            print(f"  -> {rss_url}")
            rss_urls.append(rss_url + " ;;" + channel)

    output_path.write_text(
        "\n".join(rss_urls) + "\n",
        encoding="utf-8"
    )

    print()
    print(f"Saved {len(rss_urls)} RSS URLs to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
