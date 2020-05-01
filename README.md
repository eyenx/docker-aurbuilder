# docker-aurbuilder
[![Circle CI](https://circleci.com/gh/eyenx/docker-aurbuilder.svg?style=svg)](https://circleci.com/gh/eyenx/docker-aurbuilder)

Build your AUR Packages in a container and update your custom repo with repo-add

Accomplished with [auracle-git](https://aur.archlinux.org/packages/auracle-git/)

## Volumes

```
/export # for exporting the *.pkg.tar.xz
```

## Variables

```
AUR_BASE=https://aur.archlinux.org/cgit/aur.git/snapshot
EXPORT=/export # export path
GPG-KEYS="" # additional GPG-Keys to load
```

## TODO

* clean up old pkgs
* custom gpg signing of built pkgs
