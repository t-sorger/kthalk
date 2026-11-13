#import "@preview/kthalk:0.1.0": *

// Everything deck-wide is set once here; the slides below pick it up automatically.
#show: kthalk.with(
  title: [Presentation title],
  subtitle: [Name Surname, Department, KTH],
  date: datetime.today(), // footer left
  slide-numbers: true, // footer right; the footer centre shows the title
  // bg: (title: kth.navy, chapter: kth.navy, comparison: kth.navy),
)

// kth-campus is the KTH campus photo.
// Replace it with your own picture, e.g. image("photo.jpg").
#let photo = kth-campus

#title-slide()

#chapter-slide(title: [Introduction], subtitle: [Optional subheading])

#slide(title: [Headline and content], notes: [Speaker notes go here.])[
  - First level
    - Second level
      - Third level
  #pause
  - Appears on the next click
]

#two-parts(title: [Two parts], headings: ([Before], [After]))[
  - Left column
][
  - Right column
]

#text-image(title: [Text and image], photo)[
  - The image is cropped to fill the right half
]

#comparison(title: [Comparison], heading: [Other side])[
  - Left half
][
  - Right half
]

#image-slide(title: [Images], captions: ([First], [Second]), photo, photo)

#logo-slide()
