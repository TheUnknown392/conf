import re
import json
import requests
from pathlib import Path

# Put handle "@handle" in each line on INPUT_FILE
INPUT_FILE = "channels.txt"
# Output of generated el file for initializing rss list
OUTPUT_FILE = "../feeds.el"

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
            html,
            flags=re.DOTALL
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


def escape_elisp_string(s: str) -> str:
    # Escape backslashes and double quotes for Elisp strings
    return s.replace("\\", "\\\\").replace('"', '\\"')


def main():
    input_path = Path(INPUT_FILE)
    output_path = Path(OUTPUT_FILE)

    channels = [
        line.strip()
        for line in input_path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]

    feed_entries = []

    for channel in channels:
        print(f"Processing: {channel}")

        rss_url = get_rss_url(channel)

        if rss_url:
            print(f"  -> {rss_url}")
            # channel[1:] to strip leading '@' for the label
            label = channel[1:] if channel.startswith("@") else channel
            label_escaped = escape_elisp_string(label)
            url_escaped = escape_elisp_string(rss_url)

            feed_entries.append(
                f'        ("{url_escaped}" youtube {label_escaped})'
            )

    # Build the Elisp code
    elisp_lines = [
        "(setq elfeed-feeds",
        "  '(",
    ]

    elisp_lines.extend(feed_entries)

    elisp_lines.extend([
        "      ))",
    ])

    output_path.write_text(
        "\n".join(elisp_lines) + "\n",
        encoding="utf-8"
    )

    print()
    print(f"Saved RSS URLs to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
