#!/usr/bin/env bash
# Regenerate the downloadable resume PDF from resume/resume.html.
# The PDF lands in static/ so the site serves it at
#   /Resume - Leif Adamec Rydenfalk.pdf
# Keep resume/resume.html and static/Resume - Leif Adamec Rydenfalk.md in
# sync when updating the resume; then run this script and redeploy.
set -euo pipefail

cd "$(dirname "$0")"

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [ ! -x "$CHROME" ]; then
	CHROME="$(command -v google-chrome || command -v chromium || true)"
fi
if [ -z "$CHROME" ]; then
	echo "error: no Chrome/Chromium found" >&2
	exit 1
fi

"$CHROME" --headless --disable-gpu --no-pdf-header-footer \
	--print-to-pdf="../static/Resume - Leif Adamec Rydenfalk.pdf" \
	"$(pwd)/resume.html"

echo "wrote static/Resume - Leif Adamec Rydenfalk.pdf"
