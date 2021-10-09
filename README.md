# android-docker
[![android-gradle](http://dockeri.co/image/silentnuke/android-docker)](https://hub.docker.com/r/silentnuke/android-docker/)

## Included
* OpenJDK 11
* Android SDK (android-30)
* Android Build-tools (30.0.2)
* Android Support Libraries
* Google Play Services

## Usage

### GitLab CI

```yaml
image: silentnuke/android-docker:main
stages:
  - build

build:
  stage: build
  script:
    - chmod +x gradlew
    - ./gradlew -Pci --console=plain build
  only:
    - master

```