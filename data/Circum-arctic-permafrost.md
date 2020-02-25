# Raster Circumpolar Arctic Permafrost and Ground Ice Conditions

#### Citation
> Brown, J., O. Ferrians, J. A. Heginbottom, and E. Melnikov. 2002. Circum-Arctic Map of Permafrost and Ground-Ice Conditions, Version 2. [Indicate subset used]. Boulder, Colorado USA. NSIDC: National Snow and Ice Data Center. doi: https://doi.org/. [Date Accessed].

Data Set ID: GGD318

#### Data access

>


Circum-Arctic Map of Permafrost and Ground-Ice Conditions, Version 2
https://nsidc.org/data/GGD318/versions/2
GLOBAL GEOCRYOLOGICAL DATA SYSTEM


#### Data download and preparation

FTP:
ftp://sidads.colorado.edu/pub/DATASETS/fgdc/ggd318_map_circumarctic/

```sh
mkdir -p $GISDATA/soil/circumpolar_permafrost
cd $GISDATA/soil/circumpolar_permafrost
wget ftp://sidads.colorado.edu/pub/DATASETS/fgdc/ggd318_map_circumarctic/ -O index
wget --continue -i index --force-html

```

Raster file projection is different as the vector files projection, let's try to match it:

```sh
ogrinfo -al -so  permaice.shp

## This one has better resolution:
gdalwarp nhipa.byte -s_srs "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +a=6371228.00000 +b=6371228.000 +units=m +no_defs" -t_srs treeline.prj nhipa.tif

##gdalwarp nlipa.byte -s_srs "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +a=6371228.00000 +b=6371228.000 +units=m +no_defs" -t_srs treeline.prj nlipa.tif

## This is coarse scale, geographical coordinates?
##gdalwarp llipa.byte -s_srs "+proj=laea +lat_0=90 +lon_0=0 +x_0=0 +y_0=0 +a=6371228.00000 +b=6371228.000 +units=m +no_defs" -t_srs treeline.prj llipa.tif

gdalinfo llipa.tif



```
