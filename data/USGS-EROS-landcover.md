# USGS EROS LandCover GLCCDB V2p0 class

Land cover class from USGS EROS LandCover GLCCDB V2p0: Version 2.0.

#### Citation
> Loveland, T.R., Reed, B.C., Brown, J.F., Ohlen, D.O., Zhu, J, Yang, L., and Merchant, J.W., 2000, Development of a Global Land Cover Characteristics Database and IGBP DISCover from 1-km AVHRR Data: International Journal of Remote Sensing, v. 21, no. 6/7, p. 1303-1330.

#### Data access

http://iridl.ldeo.columbia.edu/SOURCES/.USGS/.EROS/.LandCover/.GLCCDB/.V2p0/.class/datafiles.html

#### Data download and preparation

```sh
mkdir -p $GISDATA/landcover/USGS_EROS
cd $GISDATA/landcover/USGS_EROS
wget --continue http://iridl.ldeo.columbia.edu/SOURCES/.USGS/.EROS/.LandCover/.GLCCDB/.V2p0/.class/data.nc
```

|Key | description | matching EFG | comments |
|---|---|---|---|
|1.0 | Urban and Built-Up Land| T7.4 |- |
|2.0 | Dryland Cropland and Pasture| - |- |
|3.0 | Irrigated Cropland and Pasture| - |- |
|4.0 | Mixed Dryland/Irrigated Cropland and Pasture| - | not mapped? |
|5.0 | Cropland/Grassland Mosaic| - |- |
|6.0 | Cropland/Woodland Mosaic| - |- |
|7.0 | Grassland| - |- |
|8.0 | Shrubland| - |- |
|9.0 | Mixed Shrubland/Grassland| - |- |
|10.0 | Savanna| - |- |
|11.0 | Deciduous Broadleaf Forest| - |- |
|12.0 | Deciduous Needleleaf Forest| - |- |
|13.0 | Evergreen Broadleaf Forest| - |- |
|14.0 | Evergreen Needleleaf Forest| T2.1 |- |
|15.0 | Mixed Forest| - |- |
|16.0 | Water Bodies| - |- |
|17.0 | Herbaceous Wetland| - |- |
|18.0 | Wooded Wetland| - |- |
|19.0 | Barren or Sparsely Vegetated| - |- |
|20.0 | Herbaceous Tundra| T6.3 | not mapped? |
|21.0 | Wooded Tundra| T6.3? or T2.1? |- |
|22.0 | Mixed Tundra| T6.3 |- |
|23.0 | Bare Ground Tundra| T6.2,T6.3 |- |
|24.0 | Snow or Ice| T6.1 |- |
|100 | ?| - | not in legend |
