mkdir $TARGETDIR
## created tiled geotiff
gdal_translate  tmp.tif tiled.tif -co TILED=YES -co COMPRESS=DEFLATE
## add overviews
gdaladdo -r average  tiled.tif 2 4 8 16 32
## cloud optimizing
gdal_translate tiled.tif $TARGETDIR/${SRCMAP}.tif -co TILED=YES -co COMPRESS=DEFLATE -co COPY_SRC_OVERVIEWS=YES
## OR COMPRESS=JPEG is only for PhotometricInterpretation?

rm tmp.tif tiled.tif
