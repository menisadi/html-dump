#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

files=()
for f in *.html; do
  [[ "$f" == "index.html" ]] && continue
  [[ -e "$f" ]] || continue
  files+=("$f")
done

{
  cat <<'HEAD'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>html-dump</title>
<style>
  :root { color-scheme: light dark; }
  body { font-family: system-ui, sans-serif; max-width: 40rem; margin: 2rem auto; padding: 0 1rem; }
  h1 { font-size: 1.4rem; }
  .count { color: #888; font-size: 0.9rem; margin-top: -0.5rem; }
  ul { list-style: none; padding: 0; }
  li { padding: 0.5rem 0; border-bottom: 1px solid #8884; display: flex; justify-content: space-between; gap: 1rem; }
  a { text-decoration: none; }
  a:hover { text-decoration: underline; }
  .date { color: #888; font-size: 0.85rem; white-space: nowrap; }
</style>
</head>
<body>
<h1>html-dump</h1>
HEAD

  printf '<p class="count">%d entries</p>\n' "${#files[@]}"
  echo "<ul>"

  if [[ ${#files[@]} -eq 0 ]]; then
    echo "<li>No files yet.</li>"
  else
    for f in "${files[@]}"; do
      mod=$(date -r "$f" "+%Y-%m-%d")
      printf '<li><a href="%s">%s</a><span class="date">%s</span></li>\n' "$f" "$f" "$mod"
    done
  fi

  cat <<'TAIL'
</ul>
</body>
</html>
TAIL
} > index.html
