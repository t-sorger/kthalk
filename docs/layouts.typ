// Every layout of the official KTH PowerPoint template, in order.
// Each slide's title is the PowerPoint layout name and the slide shows the Typst call that produces it.
#import "@preview/kthalk:0.1.0": *

// Everything deck-wide is set once here: title-slide() and the footer (date | title | number) pick it up automatically.
// Deck-wide backgrounds go here too, e.g. bg: (title: kth.navy, chapter: kth.navy, comparison: kth.navy).
// This catalogue sets bg on every slide, which overrides the deck setting.
#show: kthalk.with(
  title: [kthalk],
  subtitle: [All layouts of the official KTH template],
  date: datetime.today(),
  slide-numbers: true,
)

#let photo = kth-campus // or your own: image("photo.jpg")
#let body(call) = [
  - #raw(call)
  - Another first level point that is long enough to wrap onto a second line
    - Second level
      - Third level
  + Numbered, *bold*, _italic_, #link("https://www.kth.se")[link], $e^(i pi) + 1 = 0$
]

// Title
#title-slide() // title and subtitle come from kthalk(..) above
#title-slide(title: [Title, navy blue], subtitle: raw("bg: kth.navy"), bg: kth.navy)
#title-slide(title: [Title, image], subtitle: raw("bg: kth-campus"), bg: kth-campus)

// Title/chapter
#for (name, bg) in (("light blue", "light-blue"), ("sand", "sand"), ("KTH blue", "blue"), ("navy blue", "navy")) {
  chapter-slide(title: [Title/chapter, #name], subtitle: raw("chapter-slide(bg: kth." + bg + ")"), bg: kth.at(bg))
  chapter-slide(title: [Title/chapter, image, #name], subtitle: raw("photo: image(..)"), bg: kth.at(bg), photo: photo)
}

// Headline and content
#slide(title: [Headline and content], body("slide(title: [..])[..]"))
#slide(title: [Headline and content, blue lines], lines: kth.sky, body("lines: kth.sky"))
#slide(title: [Headline and content, sand lines], lines: kth.sand, body("lines: kth.sand"))
#slide(title: [Headline and content, light blue], bg: kth.light-blue, body("bg: kth.light-blue"))
#slide(title: [Headline and content, sand], bg: kth.sand, body("bg: kth.sand"))
#two-parts(title: [Two parts], body("two-parts(title: [..])[..][..]"), body("second column"))
#two-parts(title: [Two parts, subheader], headings: ([Subheader 1], [Subheader 2]),
  body("headings: ([..], [..])"), body("second column"))
#text-image(title: [Text and image], photo, body("text-image(title: [..], image(..))[..]"))

// Comparison
#for (name, bg) in (("light blue", "light-blue"), ("sand", "sand"), ("KTH blue", "blue"), ("navy blue", "navy"),
  ("green", "light-green"), ("teal", "light-turquoise"), ("red", "light-brick"), ("yellow", "light-yellow")) {
  comparison(title: [Comparison, #name], heading: [Heading], bg: kth.at(bg),
    body("comparison(heading: [..], bg: kth." + bg + ")"), body("right half"))
}

// Images
#let cap(call) = [Caption text below the image \ #raw(call)]
#image-slide(title: [Headline and 1 image], photo)
#image-slide(title: [Headline and 2 images], photo, photo)
#image-slide(title: [Headline and 2 images, text], captions: (cap("captions: ([..], [..])"), cap("")), photo, photo)
#image-slide(title: [Headline and 3 images], photo, photo, photo)
#image-slide(title: [Headline and 3 images, text], captions: (cap(""),) * 3, photo, photo, photo)
#image-slide(title: [Headline and 4 images], photo, photo, photo, photo)
#image-slide(title: [Headline and 4 images, text], captions: (cap(""),) * 4, photo, photo, photo, photo)

// Headline only
#slide(title: [Headline only])[]
#slide(title: [Headline only, light blue lines], lines: kth.sky)[]
#slide(title: [Headline only, sand lines], lines: kth.sand)[]
#slide(title: [Headline only, light blue], bg: kth.light-blue)[]
#slide(title: [Headline only, sand], bg: kth.sand)[]
#slide[] // Empty
#slide(title: [Headline and content, top], top: true, body("top: true"))
#slide(title: [Headline only, top], top: true)[]

// Logo
#logo-slide()
#logo-slide(bg: kth.navy)
