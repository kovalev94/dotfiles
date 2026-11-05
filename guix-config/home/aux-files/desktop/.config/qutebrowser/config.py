#!/usr/bin/env python3

import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()
config.set("url.searchengines", {"DEFAULT": "https://google.com/search?q={}"})
config.set("url.start_pages", ["https://google.com"])
config.set("scrolling.smooth", True)

dracula.draw.blood(c, {"spacing": {"vertical": 6, "horizontal": 8}})
