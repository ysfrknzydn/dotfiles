---
name: markitdown
description: Convert a targeted PDF file to Markdown using the markitdown CLI, writing the result to output.md. Use when the user asks to convert a PDF to markdown with markitdown.
---

# Markitdown: Convert a PDF to Markdown

Convert the PDF the user points to into an `output.md` file using the `markitdown` CLI.

## Steps

1. Identify the target PDF from the user's request. If a path was given, use it; otherwise ask which PDF to convert.
2. Verify the file exists and ends in `.pdf`.
3. Run the conversion:

   ```bash
   markitdown "{path/to/file.pdf}" -o output.md
   ```

   Write `output.md` to the same directory as the source PDF unless the user specifies a different location.

4. Confirm the output file was created and report its path and size.

## Notes

- `markitdown` is installed via `uv tool install "markitdown[pdf]"` at `~/.local/bin/markitdown` (on PATH; runs in its own isolated Python). If the command is missing, reinstall with `uv tool install "markitdown[pdf]"`.
- If the conversion fails (e.g., scanned/image-only PDF with no extractable text), report the error to the user rather than attempting OCR workarounds.
