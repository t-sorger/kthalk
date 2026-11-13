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

## Present

Create the PDF and the speaker notes, then start the presentation:

```sh
typst compile main.typ
typst eval 'query(<pdfpc-file>).first().value' --in main.typ > main.pdfpc
pdfpc main.pdf
```

In pdfpc, the audience sees the slides and your screen shows the notes and the next slide.
This needs a second screen (projector or monitor), set to "Use as Extended display" in System Settings → Displays, not mirrored.

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
