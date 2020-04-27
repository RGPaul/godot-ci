# godot-ci

Docker image to export Godot games for continuous integration systems.

## run export on local machine
```
docker run -v "$(pwd):/project" -t rgpaul/godot-ci godot --path "/project" --export "Windows Desktop" "build/SampleGame.exe"
```
