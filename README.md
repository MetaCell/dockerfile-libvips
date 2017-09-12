# [Dockerfile](https://registry.hub.docker.com/u/marcbachmann/libvips/) for libvips

Installs libvips on Ubuntu 14.04 as base image.

This modified version builds openslide from github source and then builds libvips from source mostly following [this procedure](https://github.com/DigitalSlideArchive/digital_slide_archive/wiki/VIPS-and-OpenSlide-Installation).

This dockerfile can then be used to run libvips with OpenSlide directly from the command-line (see cookbook below for examples):

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

## Useful resources

* [OpenSlide and VIPS](https://github.com/openslide/openslide/wiki/OpenSlideAndVIPS)
* [OpenSlide on Aperio format](http://openslide.org/formats/aperio/)
* [libvips issue about checking if OpenSlide is working](https://github.com/jcupitt/libvips/issues/127)
* [building libvips + openslide](https://github.com/DigitalSlideArchive/digital_slide_archive/wiki/VIPS-and-OpenSlide-Installation)

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

In this command, we have enabled progress reporting.  We are making sure that the input path AND the output path includes /home as otherwise the resulting file will not get saved on the local system.

```bash
sudo docker run -e OPENSLIDE_DEBUG=detection -e G_MESSAGES_DEBUG=VIPS -v ${PWD}:/home metacell/libvips vips --vips-progress dzsave /home/HM_0597_Myelin_FLIPPED\ HORIZONTALLY.tiff /home/HM_0597_Myelin_FLIPPED_HORIZONTALLY_DZ_tif

```

## Coverting TIFs to PNGs (using ImageMagic & a different container)

```bash
sudo docker run -v /home/dockerx/test2/PEELED\ FIXED:/images --rm -it v4tech/imagemagick convert -monitor /images/HM\ BRAIN\ PEELED\ CEREBELLUM\ AND\ OCCIPTAL\ RULER.TIF /images/HM\ BRAIN\ PEELED\ CEREBELLUM\ AND\ OCCIPTAL\ RULER.png
```


## License

Licensed under [MIT](http://opensource.org/licenses/mit-license.html)
