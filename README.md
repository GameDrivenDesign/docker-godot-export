# Godot Export Dockerfile

Use this Dockerfile to automatically export your game.

Set EXPORT_NAME to your template's name and OUTPUT_FILENAME accordingly.
Add two volumes, one from your repository to /build/src and another to
/build/output where the product will be stored.

E.g. inside your game's main folder (find the product in /tmp/output):

```bash
docker run \
	-e EXPORT_NAME="HTML5" \
	-e OUTPUT_FILENAME="index.html" \
	-v $(pwd):/build/src -v /tmp/output:/build/output gamedrivendesign/godot-export
```
