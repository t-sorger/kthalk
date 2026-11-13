#import "@preview/kthalk:0.1.0": *

// Everything deck-wide is set once here; the slides below pick it up automatically.
#show: kthalk.with(
  title: [Presentation title], // title slide, footer centre and PDF title
  subtitle: [Name Surname, Department, KTH], // title slide
  date: datetime.today(), // footer left; any text works too, e.g. [Jane Doe]
  slide-numbers: true, // footer right
  // footer: [Other text], // footer centre; the default is the title and none hides it

  // Default background per slide type; leave out what you don't want to change.
  // bg: (
  //   title: kth.blue, // kth.blue (default), kth.navy, kth-campus or image("photo.jpg")
  //   chapter: kth.light-blue, // kth.light-blue (default), kth.sand, kth.blue or kth.navy
  //   slide: white, // white (default), kth.light-blue or kth.sand
  //   comparison: kth.light-blue, // kth.light-blue (default), kth.sand, kth.blue, kth.navy, kth.light-green, kth.light-turquoise, kth.light-brick or kth.light-yellow
  //   end: kth.blue, // kth.blue or kth.navy; the default is the title colour
  // ),

  // lines: kth.sky, // line art on content slides: none, kth.sky, kth.sand or white; by default only light blue and sand slides have it
  // config-common(handout: true), // no click steps, one page per slide (for sharing)
)

// Every slide function also takes bg (overrides the default above for one slide) and notes: [..] (speaker notes).

// kth-campus is the KTH campus photo.
// Replace it with your own picture, e.g. image("photo.jpg").
#let photo = kth-campus

// title and subtitle come from the top; pass them to change them for this slide.
// bg: kth.blue, kth.navy, kth-campus or image("photo.jpg").
#title-slide()

// bg: kth.light-blue, kth.sand, kth.blue or kth.navy.
// photo: a picture on the right half, e.g. photo: kth-campus.
#chapter-slide(title: [Introduction], subtitle: [Optional subheading])

// bg: white, kth.light-blue or kth.sand.
// lines: none, kth.sky, kth.sand or white.
// top: true puts the headline next to the logo, which leaves more room for content.
// title: none leaves out the headline.
#slide(title: [Headline and content], notes: [Speaker notes go here.])[
  - First level
    - Second level
      - Third level
  #pause
  - Appears on the next click
]

// headings: one subheader per column; leave it out for two plain columns.
#two-parts(title: [Two parts], headings: ([Before], [After]))[
  - Left column
][
  - Right column
]

// The picture fills the right half.
#text-image(title: [Text and image], photo)[
  - The image is cropped to fill the right half
]

// heading: the title of the right half.
// bg (right half): kth.light-blue, kth.sand, kth.blue, kth.navy, kth.light-green, kth.light-turquoise, kth.light-brick or kth.light-yellow.
#comparison(title: [Comparison], heading: [Other side])[
  - Left half
][
  - Right half
]

// 1 to 4 pictures; captions are optional, one per picture.
#image-slide(title: [Images], captions: ([First], [Second]), photo, photo)

// bg: kth.blue or kth.navy.
#logo-slide()
