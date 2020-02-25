conda deactivate
cd $WORKDIR
grass --text -c $GISDATA/vegetation/CAVM/raster_cavm_v1.tif ${GISDB}/raw/CAVM

r.in.gdal input=$GISDATA/vegetation/CAVM/raster_cavm_v1.tif output=CAVM_v1
r.colors map=CAVM_v1 color=random
r.null map=CAVM_v1 setnull=99,92

d.mon start=wx0
d.rast CAVM_v1
d.mon stop=wx0
