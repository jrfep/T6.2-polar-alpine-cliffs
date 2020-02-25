conda deactivate
cd $WORKDIR
grass --text -c ice_freerocks.shp ${GISDB}/raw/AntarcticLC2000

v.in.ogr input=ice_freerocks.shp output=ice_freerocks
v.in.ogr input=snow_firn.shp output=snow_firn
v.in.ogr input=blueice.shp output=blueice
g.region vect=snow_firn res=1000

d.mon start=wx0
d.vect snow_firn
d.vect blueice color=blue
d.vect ice_freerocks color=red
d.mon stop=wx0

g.region n=2532887.85857 s=-2484889.98363 w=-3922146.35876 e=4013149.75465 nsres=30

v.to.rast --overwrite input=blueice output=blueice use=val val=2
v.to.rast --overwrite input=ice_freerocks output=ice_freerocks use=val val=3
v.to.rast --overwrite input=snow_firn output=snow_firn use=val val=1


r.mapcalc --overwrite expression="ALC2000=if(isnull(ice_freerocks),0,3)+if(isnull(blueice),0,2)+if(isnull(snow_firn),0,1)"
r.null ALC2000 setnull=0
r.colors map=ALC2000 color=viridis

g.region res=1000 -ap
r.resamp.stats --overwrite input=ALC2000 output=ALC2000_1k method=maximum

d.mon start=wx1

d.rast ALC2000_1k
d.mon stop=wx1
