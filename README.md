# docker-aurbuilder
[![](https://images.microbadger.com/badges/image/eyenx/aurbuilder.svg)](https://microbadger.com/images/eyenx/aurbuilder "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/eyenx/aurbuilder.svg)](https://microbadger.com/images/eyenx/aurbuilder "Get your own version badge on microbadger.com")
[![Circle CI](https://circleci.com/gh/eyenx/docker-aurbuilder.svg?style=svg)](https://circleci.com/gh/eyenx/docker-aurbuilder)

Build your AUR Packages in a container and update your custom repo with repo-add

Accomplished with [auracle-git](https://aur.archlinux.org/packages/auracle-git/)

This is mainly used for [my personal user repository](https://aur.eyenx.ch)

## Volumes

```
/export # for exporting the *.pkg.tar.xz
```

## Variables

```
AUR_BASE=https://aur.archlinux.org/cgit/aur.git/snapshot
EXPORT=/export # export path
ADD_GPG_KEYS="" # additional GPG-Keys to load
REPONAME=aur # reponame, used for generation of reponame.db.tar.gz, repo-add is run if this is set
```

## TODO

* clean up old pkgs
* custom gpg signing of built pkgs
