# Godot Export

This repository contains tools and scripts to export your Godot games.
We provide configuration templates for two continuous integration
services (TravisCI and AppVeyor). Both can be used to automatically
export your games whenever you push or create a tag in your GitHub repositories.
You can also use the provided Docker image by itself.

## Dockerfile

Use this Dockerfile to automatically export your game.

Set `EXPORT_NAME` to your template's name and `OUTPUT_FILENAME` accordingly.
Add two volumes, one from your repository to `/build/src` and another to
`/build/output` where the product will be stored.

E.g. inside your game's main folder (find the product in `/tmp/output`):

```bash
docker run \
	-e EXPORT_NAME="HTML5" \
	-e OUTPUT_FILENAME="index.html" \
	-v $(pwd):/build/src -v /tmp/output:/build/output gamedrivendesign/godot-export
```

## Travis Integration

We provide a fairly well documented template `.travis.yml` file
for you to copy into your own repository. The build is using
the docker image also provided in here. The TravisCI configuration
supports:

1. Exporting the Linux/Windows/Mac versions of the game whenever
   a git tag is created and adding them to the GitHub Releases.
2. Exporting the HTML5 version of the game and pushing it to GitHub Pages.

## AppVeyor Integration

We provide a fairly well documented template `appveyor.yml` file
for you to copy into your own repository. The AppVeyor configuration
supports:

1. Exporting the Linux/Windows/Mac versions of the game whenever
   a git tag is created and adding them to the GitHub Releases.

It does _not_ support pushing to GitHub Pages.

## Contributing

If you have any issues, comments or improvements, feel free to
open a pull request or an issue!
