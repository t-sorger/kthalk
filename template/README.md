# My talk

Slides made with [kthalk](https://github.com/t-sorger/kthalk).
Write them in `main.typ`; the comments there list all options.
Run all commands in this folder.

## Write

Create the PDF, open it, and update it every time you save `main.typ`:

```sh
typst compile main.typ && open main.pdf
typst watch main.typ
```

## Cite

`@key` or `#cite(<a>, <b>)` cites entries of `refs.bib`; each slide lists the entries it cites at the bottom.
To use another `.bib` file, e.g. the one of your paper, change `bib: path("refs.bib")` in `main.typ`, e.g. to `bib: path("../paper/refs.bib")`.
If the file is outside this folder, add `--root ..` to every `typst` command below, e.g.:

```sh
typst watch --root .. main.typ
```

## Present

Create the PDF and the speaker notes, then start the presentation:

```sh
typst compile main.typ
typst eval 'query(<pdfpc-file>).first().value' --in main.typ > main.pdfpc
pdfpc main.pdf
```

In pdfpc, the audience sees the slides and your screen shows the notes and the next slide.
This needs a second screen (projector or monitor), set to "Use as Extended display" in System Settings → Displays, not mirrored.

Keys for pointing at the slide while presenting:

- `2`: laser pointer, a red dot that follows your mouse over the current slide in your view and shows on the audience screen.
  Drag with the mouse to dim everything outside an area, and press `z` to zoom into it (`Escape` zooms out).
- `5`: spotlight, which darkens everything except a circle around the mouse.
- `+` / `-`: make the pointer or spotlight bigger or smaller.
- `1`: back to normal, pointer off.

If the slides and the notes are on the wrong screens, swap them:

```sh
pdfpc -s main.pdf
```

To rehearse on one screen, open both views as normal windows:

```sh
pdfpc -w both main.pdf
```

## Share

Create a PDF without click steps, with one page per slide:

```sh
typst compile --input handout=true main.typ handout.pdf
```
