# imagemagick-docker

[ImageMagick](https://www.imagemagick.org) 7.0.10 inside alpine container with enabled [`HEIC`](https://en.wikipedia.org/wiki/High_Efficiency_Image_File_Format).

## MENU <!-- omit in toc -->

* [Requirements](#requirements)
* [Usage](#usage)
  * [Exiting Docker Image](#exiting-docker-image)
  * [Build from source](#build-from-source)
* [Style guide for contributors](#style-guide-for-contributors)

## Requirements

* `Docker` 19.03+

## Usage

### Exiting Docker Image

You can use exiting Docker image published to [Docker Hub](https://hub.docker.com/r/maxymvlasov/imagemagick-alpine).

```bash
docker run maxymvlasov/imagemagick-alpine
```

### Build from source

1. Clone this repo

```bash
git clone git@github.com:MaxymVlasov/imagemagick-docker.git
cd imagemagick-docker
```

2. Build image

```bash
docker build -t imagemagick .
```

3. Run

```bash
docker run imagemagick:latest
```

## Style guide for contributors

For better experience, we recommend using [VS Code](https://code.visualstudio.com/download) - we have a list of recommended extensions to prevent many common errors, improve code and save time.

We use [.editorconfig](https://editorconfig.org/). It fixes basic mistakes on every file saving.

And please install [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform#how-to-install) with all its dependencies. It checks all changed files when you run `git commit` for more complex problems and tries to fix them for you.
