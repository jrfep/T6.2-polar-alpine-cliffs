## this is not working correctly
conda deactivate
cd $WORKDIR
grass --text -c $GISDATA/soil/circumpolar_permafrost/nhipa.tif ${GISDB}/raw/CA_permafrost

r.in.gdal input=$GISDATA/soil/circumpolar_permafrost/nhipa.tif output=Permafrost
r.colors map=Permafrost color=random
r.null map=Permafrost setnull=0

## same info as raster file
v.in.ogr -o input=$GISDATA/soil/circumpolar_permafrost/permaice.shp output=permaice

## tree line
 v.in.ogr -o input=$GISDATA/soil/circumpolar_permafrost/treeline.shp output=treeline
## not sure?
v.in.ogr -o input=$GISDATA/soil/circumpolar_permafrost/subsea.shp output=subsea

d.mon start=wx0
d.rast Permafrost
d.vect treeline
d.vect permaice
d.vect subsea
d.mon stop=wx0
