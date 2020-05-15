# godot-ci

Docker image to export Godot games for continuous integration systems.

## Image tags
There are some different images:

* latest or the godot version number - headless godot and templates 
* android - headless godot, godot templates, openjdk and android sdk
* android-ndk - headless godot, godot templates, openjdk, android sdk, android ndk

## exporting on local machine
```
docker run -v "$(pwd):/project" -t rgpaul/godot-ci godot --path "/project" --export "Windows Desktop" "build/SampleGame.exe"
```

## creating docker images

### base image
```
docker build -t rgpaul/godot-ci .
```

### docker image for android (includes java and the android sdk for signing)
```
docker build -t rgpaul/godot-ci:android ./android
```

### docker image for android with ndk (includes java, the android sdk for signing and the android ndk)
```
docker build -t rgpaul/godot-ci:android-ndk ./android-ndk
```
