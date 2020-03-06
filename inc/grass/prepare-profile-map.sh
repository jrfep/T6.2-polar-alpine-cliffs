mkdir $SRCDIR
g.region n=90 s=-90 e=180 w=-180 res=0.008333333333333
if [ -e marco.json ]
then
   echo "marco.json"
else
   v.out.ogr format=GeoJSON input=marco output=marco.json
fi

r.mapcalc --overwrite expression="profile_map=if(isnull($SRCMAP),if(isnull(world),4,3),$SRCMAP)"

r.out.gdal --overwrite input=profile_map output=tmp.tif

rm $SRCDIR/$SRCMAP.tif
gdalwarp -t_srs '+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs' -crop_to_cutline -cutline marco.json tmp.tif $SRCDIR/$SRCMAP.tif

rm tmp.tif

g.remove -f name=profile_map type=rast
