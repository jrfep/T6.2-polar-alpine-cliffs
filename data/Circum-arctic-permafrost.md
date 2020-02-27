# Raster Circumpolar Arctic Permafrost and Ground Ice Conditions

#### Citation
> Brown, J., O. Ferrians, J. A. Heginbottom, and E. Melnikov. 2002. Circum-Arctic Map of Permafrost and Ground-Ice Conditions, Version 2. [Indicate subset used]. Boulder, Colorado USA. NSIDC: National Snow and Ice Data Center. doi: https://doi.org/. [Date Accessed].


#### Data access

Circum-Arctic Map of Permafrost and Ground-Ice Conditions, Version 2
Data Set ID: GGD318
https://nsidc.org/data/GGD318/versions/2

FTP: ftp://sidads.colorado.edu/pub/DATASETS/fgdc/ggd318_map_circumarctic/

#### Data download and preparation


```sh
mkdir -p $GISDATA/soil/circumpolar_permafrost
cd $GISDATA/soil/circumpolar_permafrost
wget ftp://sidads.colorado.edu/pub/DATASETS/fgdc/ggd318_map_circumarctic/ -O index
wget --continue -i index --force-html

```

Raster file projection is different as the vector files projection. This approach allow to import all files in the same projection, but it gives some errors, and results are hopelessly wrong when transformed to *Plate Carrée*.

```sh
ogrinfo -al -so  permaice.shp

## This one has better resolution:
gdalwarp nhipa.byte -s_srs "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +a=6371228.00000 +b=6371228.000 +units=m +no_defs" -t_srs treeline.prj nhipa.tif
##gdalwarp nhipa.byte -s_srs treeline.prj nhipa.tif

##gdalwarp nlipa.byte -s_srs "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +a=6371228.00000 +b=6371228.000 +units=m +no_defs" -t_srs treeline.prj nlipa.tif

## This is coarse scale, geographical coordinates?
##gdalwarp llipa.byte -s_srs "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +a=6371228.00000 +b=6371228.000 +units=m +no_defs" -t_srs treeline.prj llipa.tif

gdalinfo nhipa.tif

```
