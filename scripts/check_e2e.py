"""Ellenőrzi, hogy a böngészős (E2E) tesztekhez szükséges Playwright és Chromium működik-e.

Futtatás: .venv/bin/python scripts/check_e2e.py
"""
import sys

try:
    from playwright.sync_api import sync_playwright
except ImportError:
    sys.exit("❌ Nincs telepítve a Playwright. Futtasd: bash scripts/setup-e2e.sh")

with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page()
    page.set_content("<h1>Kudos E2E OK</h1>")
    assert page.inner_text("h1") == "Kudos E2E OK"
    browser.close()

print("✅ A böngészős tesztek futtathatók (Playwright + Chromium, headless).")
