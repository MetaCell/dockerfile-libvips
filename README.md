# [Dockerfile](https://registry.hub.docker.com/u/marcbachmann/libvips/) for libvips

Installs libvips on Ubuntu 14.04 as base image.


## Supported tags

- [`7.40`](https://github.com/marcbachmann/dockerfile-libvips/tree/master)
- [`7.42`](https://github.com/marcbachmann/dockerfile-libvips/tree/7.42.3)
- [`8.0.2`](https://github.com/marcbachmann/dockerfile-libvips/tree/8.0.2)
- [`8.1.0`](https://github.com/marcbachmann/dockerfile-libvips/tree/8.1.0)
- [`8.2.3`](https://github.com/marcbachmann/dockerfile-libvips/tree/8.2.3)
- [`8.4.1`, `latest`](https://github.com/marcbachmann/dockerfile-libvips/tree/8.4.1)

## How to use

Download the image using:

```bash
$ docker pull marcbachmann/libvips
# .... pulling down image
```

# Cookbook for important commands

## Tests to confirm that OpenSlide is installed correctly using VIPS

NOTE: we have to map the volume into the container and prepend the path with '/home' or vips can't find the file.  This is accomplished by the '-v' flag in the example.

```bash
#Grab a small test SVS from the OpenSlide site
wget http://openslide.cs.cmu.edu/download/openslide-testdata/Aperio/CMU-1-Small-Region.svs
sudo docker run -e OPENSLIDE_DEBUG=detection -e G_MESSAGES_DEBUG=VIPS -v ${PWD}:/home metacell/libvips vips openslideload --associated thumbnail /home/HM_0597_Myelin_TO\ BE\ FLIPPED\ HORIZONTALLY.svs test
```

## flip

```bash
sudo docker run -e OPENSLIDE_DEBUG=detection -e G_MESSAGES_DEBUG=VIPS -v ${PWD}:/home metacell/libvips vips --vips-progress flip /home/HM_0597_Myelin_TO\ BE\ FLIPPED\ HORIZONTALLY.svs /home/HM_0597_Myelin_FLIPPED\ HORIZONTALLY.tiff horizontal
```

## Deep Zoom

[dzsave documentation](https://jcupitt.github.io/libvips/API/current/Making-image-pyramids.md.html)

In this command, we have enabled progress reporting, we are using a .zip extension with dzsave to indicate we want a zip file out the other end instead of just a set of directories (because a ton of files get created and we don't want to unpack this until the absolute last second).

```bash
sudo docker run -e OPENSLIDE_DEBUG=detection -e G_MESSAGES_DEBUG=VIPS -v ${PWD}:/home metacell/libvips vips --vips-progress dzsave /home/HM_0597_Myelin_FLIPPED\ HORIZONTALLY.tiff /home/HM_0597_Myelin_FLIPPED\ HORIZONTALLY.zip
```


## License

Licensed under [MIT](http://opensource.org/licenses/mit-license.html)
