// kthalk: an unofficial replica of the KTH PowerPoint template ("KTH PPT template 251203.potx").
// All positions/sizes are copied from the .potx layouts.
// Usage: see README.md.
// Images are passed as content, e.g. `image("photo.jpg")`; they are cover-cropped to fit.

#let kth = (
  // primary
  blue: rgb("#004791"), navy: rgb("#000061"), sky: rgb("#6298D2"),
  light-blue: rgb("#DEF0FF"), sand: rgb("#EBE5E0"), digital-blue: rgb("#0029ED"),
  // secondary
  green: rgb("#4DA060"), turquoise: rgb("#339C9C"), brick: rgb("#E86A58"),
  yellow: rgb("#FFBE00"), grey: rgb("#A5A5A5"),
  dark-green: rgb("#0D4A21"), dark-turquoise: rgb("#1C434C"), dark-brick: rgb("#78001A"),
  dark-yellow: rgb("#A65900"), dark-grey: rgb("#323232"),
  light-green: rgb("#C7EBBA"), light-turquoise: rgb("#B2E0E0"), light-brick: rgb("#FFCCC4"),
  light-yellow: rgb("#FFF0B0"), light-grey: rgb("#E6E6E6"),
)

// The campus photo of the official "Title, image" layout (© KTH).
#let kth-campus = image("assets/campus.jpg")

// Backgrounds the official layouts exist for, per slide type (first = default).
#let _allowed = (
  title: (kth.blue, kth.navy), // or an image
  chapter: (kth.light-blue, kth.sand, kth.blue, kth.navy),
  slide: (white, kth.light-blue, kth.sand),
  comparison: (kth.light-blue, kth.sand, kth.blue, kth.navy,
    kth.light-green, kth.light-turquoise, kth.light-brick, kth.light-yellow),
  end: (kth.blue, kth.navy),
)

#let _cfg = state("kthalk", none)
#let _title-inset = (x: 0.254cm, top: 0.3cm, bottom: 0.127cm)
#let _marker(fill) = box(width: 0.635cm, align(left, text(font: ("Arial", "Figtree"), fill: fill, "•")))

// Background for a slide of `kind`: the slide's own `bg`, else the deck setting.
// Needs context.
#let _bg(kind, bg) = {
  let bg = if bg == auto { _cfg.get().bg.at(kind) } else { bg }
  if kind != "title" or type(bg) == color {
    let name(c) = if c == white { "white" } else { "kth." + kth.keys().find(k => kth.at(k) == c) }
    assert(bg in _allowed.at(kind), message: "kthalk: no official " + kind + " layout with background "
      + (if bg == white or bg in kth.values() { name(bg) } else { repr(bg) })
      + "; use " + _allowed.at(kind).map(name).join(", ", last: " or "))
  }
  bg
}

// A PowerPoint text placeholder: box at (x, y) with size (w, h).
#let _box(x, y, w, h, anchor: top + left, inset: (x: 0.254cm, y: 0.127cm), body) = place(
  dx: x, dy: y, box(width: w, height: h, inset: inset, align(anchor, body)),
)

#let _title(body, x: 1.667cm, y: 3.043cm, w: 30.528cm, h: 1.579cm, size: 36pt, fill: kth.navy, anchor: top + left) = {
  if body != none { _box(x, y, w, h, anchor: anchor, inset: _title-inset, text(size, weight: "bold", fill: fill, body)) }
}

#let _logo(white: false, small: false) = place(
  dx: if small { 0.51cm } else { 0.538cm }, dy: 0.457cm,
  image(if white { "assets/logo-white.svg" } else { "assets/logo-blue.svg" }, width: if small { 1.80cm } else { 1.984cm }),
)

#let _cover(w, h, img) = box(width: w, height: h, clip: true, {
  set image(width: w, height: h, fit: "cover")
  img
})

#let _footer(fill) = context {
  let c = _cfg.get()
  set text(7pt, fill: fill)
  let cell(x, w, a, body) = _box(x, 17.98cm, w, 0.263cm, anchor: a + horizon, inset: (x: 0.254cm), body)
  cell(1.667cm, 7.62cm, left, c.date)
  cell(11.216cm, 11.43cm, center, c.footer)
  if c.numbers { cell(24.58cm, 7.62cm, right, counter(page).display()) }
}

#let _page(fill: white, footer: kth.sky, body) = page(
  fill: fill, foreground: if footer != none { _footer(footer) }, body,
)

// Line art of the title and logo slides (KTH blue or navy variant).
#let _title-deco(bg) = {
  let v = if bg == kth.navy { "navy" } else { "blue" }
  place(image("assets/title-" + v + "-tl.svg", width: 8.827cm))
  place(dx: 25.46cm, dy: 13.86cm, image("assets/title-" + v + "-br.svg", width: 8.40cm))
}

// ---------------------------------------------------------------------------------------------
// Document setup (everything is set once here; slides pick it up automatically)
//
//   title, subtitle: used by title-slide() and as the PDF title
//   footer:          footer text, centre of every slide; auto = title, none = hidden
//   date:            footer left; a datetime (e.g. datetime.today()) or any content
//   slide-numbers:   footer right
//   bg:              deck-wide backgrounds, any subset of (title: .., chapter: .., slide: .., comparison: .., end: ..)
//                    end defaults to the title color.
//                    Allowed values: see _allowed above.
//   lines:           deck-wide default for slide(lines: ..)

#let kthalk(
  title: none, subtitle: none, footer: auto, date: none, slide-numbers: false,
  lang: "en", bg: (:), lines: auto, body,
) = {
  for k in bg.keys() { assert(k in _allowed, message: "kthalk: unknown bg key '" + k + "'; use " + _allowed.keys().join(", ")) }
  let given = bg
  let bg = _allowed.keys().map(k => (k, _allowed.at(k).first())).to-dict() + given
  if "end" not in given { bg.end = if type(bg.title) == color { bg.title } else { kth.blue } }
  let footer = if footer == auto { title } else { footer }
  let date = if type(date) == datetime { date.display() } else { date }

  set document(title: title) if title != none
  set page(width: 33.867cm, height: 19.05cm, margin: 0pt)
  // PowerPoint's 90 % line spacing: baseline pitch = 0.9 × (ascender + descender) of Figtree.
  set text(font: "Figtree", size: 20pt, lang: lang, hyphenate: false, top-edge: 0.855em, bottom-edge: -0.225em)
  set par(leading: 0pt, spacing: 10pt)
  set block(spacing: 10pt)
  set list(indent: 0pt, body-indent: 0pt, spacing: 10pt, marker: _marker(kth.blue))
  set enum(indent: 0pt, body-indent: 0.3em, spacing: 10pt, numbering: n => text(fill: kth.blue)[#n.])
  // Nested levels: 2 pt smaller each (20/18/16/14/12), 5 pt spacing, bullets 1.27 cm further in.
  show selector.or(list, enum): it => context {
    let size = calc.max(text.size - 2pt, 12pt)
    show selector.or(list, enum): set text(size: size)
    show selector.or(list, enum): set block(spacing: 5pt)
    show list: set list(indent: 0.635cm, spacing: 5pt)
    show enum: set enum(indent: 0.635cm, spacing: 5pt)
    it
  }
  show link: set text(fill: rgb("#3878C2"))
  show link: underline
  _cfg.update((title: title, subtitle: subtitle, footer: footer, date: date, numbers: slide-numbers, bg: bg, lines: lines))
  body
}

// ---------------------------------------------------------------------------------------------
// Slides
// `bg: auto` uses the deck setting from kthalk(bg: ..); pass a color to override.

// Layouts "Title, KTH blue / navy blue / image": bg is kth.blue, kth.navy, or an image.
// title/subtitle default to the deck's kthalk(title: .., subtitle: ..).
#let title-slide(title: auto, subtitle: auto, bg: auto) = context {
  let bg = _bg("title", bg)
  let c = _cfg.get()
  let title = if title == auto { c.title } else { title }
  let subtitle = if subtitle == auto { c.subtitle } else { subtitle }
  let photo = type(bg) != color
  _page(fill: if photo { black } else { bg }, footer: none, {
    if photo {
      place(_cover(100%, 100%, bg))
      place(rect(width: 100%, height: 100%, fill: black.transparentize(70%)))
    } else { _title-deco(bg) }
    place(dx: 14.48cm, dy: 2.77cm, image("assets/logo-white.svg", width: 4.90cm))
    _title(title, x: 4.71cm, y: 9.92cm, w: 24.44cm, h: 4.59cm, size: 48pt, fill: white, anchor: center + horizon)
    if subtitle != none {
      _box(5.92cm, 16.05cm, 22.02cm, 1.28cm, anchor: center + top,
        text(fill: if bg == kth.navy { kth.sky } else { white }, subtitle))
    }
  })
}

// Layouts "Title/chapter": bg is kth.light-blue, kth.sand, kth.blue or kth.navy; optional photo on the right half.
#let chapter-slide(title: none, subtitle: none, bg: auto, photo: none) = context {
  let bg = _bg("chapter", bg)
  let dark = bg in (kth.blue, kth.navy)
  let w = if photo == none { 20.05cm } else { 14.76cm }
  _page(fill: bg, footer: if bg == kth.blue { white } else { kth.sky }, {
    if photo == none {
      let deco = if bg in (kth.light-blue, kth.blue) { "sky" } else { "digital" }
      place(image("assets/chapter-" + deco + ".svg", width: 100%))
    } else { place(dx: 16.93cm, _cover(16.94cm, 100%, photo)) }
    _logo(white: dark, small: dark)
    _title(title, y: 6.16cm, w: w, h: 7.92cm, size: if photo == none { 60pt } else { 54pt },
      fill: if dark { white } else { kth.navy }, anchor: bottom + left)
    if subtitle != none {
      _box(1.667cm, 14.52cm, w, 2.40cm, text(
        size: if photo == none { 24pt } else { 20pt },
        fill: if bg == kth.blue { white } else if bg == kth.navy { kth.sky } else { kth.blue },
        subtitle,
      ))
    }
  })
}

// Layouts "Headline and content" / "Headline only" / "Empty".
//   bg:    white, kth.light-blue or kth.sand
//   lines: line art bottom right: none, kth.sky, kth.sand or white (auto: as in the official layouts)
//   top:   headline next to the logo, more room for content ("..., top" layouts)
#let slide(title: none, bg: auto, lines: auto, top: false, body) = context {
  let bg = _bg("slide", bg)
  let lines = if lines != auto { lines } else { _cfg.get().lines }
  let lines = if lines != auto { lines } else if bg == kth.light-blue { kth.sky } else if bg == kth.sand { white }
  _page(fill: bg, {
    if lines != none {
      let v = if lines == kth.sand { "sand" } else if lines == white { "white" } else { "sky" }
      place(dx: 23.93cm, dy: 5.33cm, image("assets/lines-" + v + ".svg", width: 9.93cm))
    }
    _logo()
    if top {
      _title(title, x: 2.80cm, y: 0.91cm, w: 29.40cm, h: 1.64cm, size: 32pt, anchor: left + horizon)
      _box(1.667cm, 3.80cm, 30.528cm, 13.78cm, body)
    } else if lines != none {
      _title(title)
      _box(1.667cm, 4.99cm, 24.46cm, 12.58cm, body)
    } else {
      _title(title)
      _box(1.667cm, 5.201cm, 30.528cm, 12.372cm, body)
    }
  })
}

// Layouts "Two parts" and "Two parts, subheader" (pass headings: ([..], [..])).
#let two-parts(title: none, headings: none, first, second) = _page({
  _logo()
  _title(title)
  for (i, body) in (first, second).enumerate() {
    let x = (1.667cm, 17.43cm).at(i)
    if headings == none {
      _box(x, 4.99cm, 14.76cm, 12.59cm, body)
    } else {
      _box(x, 4.99cm, 14.76cm, 0.89cm, anchor: bottom + left,
        text(18pt, weight: "bold", fill: kth.blue, headings.at(i)))
      _box(x, 6.05cm, 14.76cm, 11.52cm, body)
    }
  }
})

// Layout "Text and image": photo fills the right half.
#let text-image(title: none, photo, body) = _page({
  place(dx: 16.93cm, _cover(16.94cm, 100%, photo))
  _logo()
  _title(title, w: 13.69cm, h: 2.72cm)
  _box(1.667cm, 6.34cm, 13.69cm, 11.24cm, body)
})

// Layouts "Comparison": white left half, colored right half with its own heading.
//   bg: kth.light-blue, kth.sand, kth.blue, kth.navy, kth.light-green, kth.light-turquoise, kth.light-brick or kth.light-yellow
#let comparison(title: none, heading: none, bg: auto, first, second) = context {
  let bg = _bg("comparison", bg)
  let dark = bg in (kth.blue, kth.navy)
  _page(fill: bg, {
    place(rect(width: 16.93cm, height: 100%, fill: white))
    _logo()
    _title(title, w: 13.69cm, h: 2.72cm)
    _box(1.667cm, 6.34cm, 13.69cm, 11.24cm, first)
    _title(heading, x: 18.50cm, w: 13.69cm, h: 2.72cm, fill: if dark { white } else { kth.navy })
    _box(18.51cm, 6.34cm, 13.69cm, 11.24cm, {
      set text(fill: white) if dark
      set list(marker: _marker(white)) if dark
      second
    })
  })
}

// Layouts "Headline and 1–4 images", optionally with a caption under each image.
#let image-slide(title: none, captions: none, ..images) = _page({
  let imgs = images.pos()
  let n = imgs.len()
  assert(n >= 1 and n <= 4, message: "image-slide takes 1 to 4 images")
  let w = (30.528cm, 14.76cm, 9.51cm, 6.81cm).at(n - 1)
  let gap = if n > 1 { (30.528cm - n * w) / (n - 1) } else { 0cm }
  _logo()
  _title(title)
  for (i, img) in imgs.enumerate() {
    let x = 1.667cm + i * (w + gap)
    place(dx: x, dy: 5.33cm, _cover(w, if captions == none { 12.25cm } else { 8.59cm }, img))
    if captions != none { _box(x, 14.52cm, w, 3.06cm, captions.at(i, default: none)) }
  }
})

// Layouts "Logo" / "Logo, navy blue" (closing slide): bg is kth.blue or kth.navy.
#let logo-slide(bg: auto) = context {
  let bg = _bg("end", bg)
  _page(fill: bg, footer: none, {
    _title-deco(bg)
    place(dx: 13.35cm, dy: 4.73cm, image("assets/logo-white.svg", width: 7.18cm))
  })
}
