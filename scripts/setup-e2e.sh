#!/usr/bin/env bash
# Böngészős (E2E) tesztek előkészítése: Playwright + Chromium egy helyi .venv-be.
# Egyszer kell lefuttatni, a workshop elején (0. lépés). Az alkalmazás kódja továbbra is
# csak a Python standard libraryt használja; a Playwright kizárólag a teszteké.
set -euo pipefail
cd "$(dirname "$0")/.."

PLAYWRIGHT_VERSION="1.48.0"

echo "▶ 1/5 Python virtuális környezet (.venv)"
if ! python3 -c "import ensurepip" >/dev/null 2>&1; then
  echo "❌ Hiányzik a python3-venv csomag. Telepítsd, majd futtasd újra ezt a szkriptet:"
  echo "   sudo apt install -y python3-venv"
  exit 1
fi
[ -d .venv ] || python3 -m venv .venv

echo "▶ 2/5 Playwright telepítése (pip, ${PLAYWRIGHT_VERSION})"
.venv/bin/python -m pip install --quiet --upgrade pip
.venv/bin/python -m pip install --quiet "playwright==${PLAYWRIGHT_VERSION}"

echo "▶ 3/5 Chromium letöltése (kb. 150 MB)"
.venv/bin/python -m playwright install chromium

echo "▶ 4/5 Rendszerkönyvtárak a Chromiumhoz (sudo jelszót kérhet)"
sudo .venv/bin/python -m playwright install-deps chromium

echo "▶ 5/5 Próbafuttatás"
.venv/bin/python scripts/check_e2e.py
