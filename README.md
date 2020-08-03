# imagemagick-docker

[ImageMagick](https://www.imagemagick.org) 7.0.10 inside alpine container with enabled [`HEIC`](https://en.wikipedia.org/wiki/High_Efficiency_Image_File_Format).

## MENU <!-- omit in toc -->

* [Requirements](#requirements)
* [Usage](#usage)
* [Style guide for contributors](#style-guide-for-contributors)

## Requirements

* `Docker` 19.03+

## Usage

1. Build image

```bash
docker build -t imagemagick .
```

2. Run

```bash
docker run imagemagick:latest
```

## Style guide for contributors

For better experience, we recommend using [VS Code](https://code.visualstudio.com/download) - we have a list of recommended extensions to prevent many common errors, improve code and save time.

We use [.editorconfig](https://editorconfig.org/). It fixes basic mistakes on every file saving.

And please install [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform#how-to-install) with all its dependencies. It checks all changed files when you run `git commit` for more complex problems and tries to fix them for you.
