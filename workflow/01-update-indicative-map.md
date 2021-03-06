
In Grass follow these:

```sh
g.region n=90 s=-90 e=180 w=-180 res=0.008333333333333

v.in.ogr input="PG:host=localhost dbname=gisdata user=jferrer" layer=glims.valid_nunataks output=GLIMS_rocks
v.to.rast --overwrite input=GLIMS_rocks@cryogenic output=GLIMS_rocks use=val val=1

v.in.ogr input="PG:host=localhost dbname=gisdata user=jferrer"  where="fcode IN ( 'NTK', 'NTKS')" layer=geonames.geoname output=Geonames_rocks
v.to.rast --overwrite input=Geonames_rocks@cryogenic output=GN_rocks use=val val=1

r.mapcalc --overwrite "ALC2000_rocks=if(ALC2000==3,1,null())"

r.mapcalc --overwrite "CLC1km_Snow_rocks=if((if(CLC1km_Snow>0,1,0)+if(CLC1km_Barren>0,1,0)+if(CLC1km_Snow+CLC1km_Snow>50,1,0))==3,1,null())"
r.mapcalc --overwrite "CAVM_rocks=if(CAVM_v1<6,1,null())"
r.mapcalc --overwrite "GLCCDB_rocks=if(GLCCDB_v2==23,1,null())"

```

Then we can assemble a map using:

```sh
r.mapcalc --overwrite "T6_2_known=max(if(isnull(GLIMS_rocks),0,1),if(isnull(GN_rocks),0,1),if(isnull(ALC2000_rocks),0,1))"
##r.null map=T6_2_known setnull=0

r.mapcalc --overwrite "T6_2_preliminary=max(if(isnull(GLCCDB_rocks),0,1),if(isnull(CLC1km_Snow_rocks),0,1),if(isnull(CAVM_rocks),0,1),if(isnull(GLIMS_rocks),0,1),if(isnull(GN_rocks),0,1),if(isnull(ALC2000_rocks),0,1))"
##r.null map=T6_2_preliminary setnull=0

 g.region -p
 g.region -p res=0:30:00

 r.resamp.stats --overwrite input=T6_2_preliminary output=T6_2_minor_hd method=sum
 r.resamp.stats --overwrite input=T6_2_known output=T6_2_major_hd method=sum
## maximum is 3600
r.info T6_2_minor_hd
r.mapcalc --overwrite "T6.2.IM.v2=if(T6_2_major_hd>0,1,if(T6_2_minor_hd>100,2,0))"
r.null map=T6.2.IM.v2 setnull=0
echo "
1 254:0:0
2 255:255:1
" > indicativeMapColors.txt
r.colors map=T6.2.IM.v2 rules=indicativeMapColors.txt

```

Insert map metadata in database `psql iucn_ecos`:
```sql

INSERT INTO ref_list(ref_code,ref_cite) values ('Tuanmu et al. 2014','Tuanmu, M.-N. and W. Jetz. 2014. A global 1-km consensus land-cover product for biodiversity and ecosystem modeling. Global Ecology and Biogeography 23(9): 1031-1045.'),('GeoNames 2020','GeoNames (2020) The GeoNames geographical database. https://www.geonames.org [Accessed in Feb 2020]'),('Raup et al 2007','Raup, B.H.; A. Racoviteanu; S.J.S. Khalsa; C. Helm; R. Armstrong; Y. Arnaud (2007).  "The GLIMS Geospatial Glacier Database: a New Tool for Studying Glacier Change".  Global and Planetary Change 56:101--110. (doi:10.1016/j.gloplacha.2006.07.018)'),('GLIMS and NSIDC 2005-2018','GLIMS and NSIDC (2005, updated 2018): Global Land Ice Measurements from Space glacier database.  Compiled and made available by the international GLIMS community and the National Snow and Ice Data Center, Boulder CO, U.S.A.  DOI:10.7265/N5V98602'),('Hui et al. 2017','Hui, F., J. Kang, Y. Liu, X. Cheng, P. Gong, F. Wang, Z. Li, Y. Ye, and Z. Guo. 2017. *AntarcticaLC2000: The new Antarctic land cover database for the year 2000.* **SCIENCE CHINA Earth Sciences** 60: 686-696. doi: 10.1007/s11430-016-0029-2.'),('Raynolds et al. 2019','Martha K. Raynolds, Donald A. Walker, Andrew Balser, Christian Bay, Mitch Campbell, Mikhail M. Cherosov, Fred J.A. Daniëls, Pernille Bronken Eidesen, Ksenia A. Ermokhina, Gerald V. Frost, Birgit Jedrzejek, M. Torre Jorgenson, Blair E. Kennedy, Sergei S. Kholod, Igor A. Lavrinenko, Olga V. Lavrinenko, Borgþór Magnússon, Nadezhda V. Matveyeva, Sigmar Metúsalemsson, Lennart Nilsen, Ian Olthof, Igor N. Pospelov, Elena B. Pospelova, Darren Pouliot, Vladimir Razzhivin, Gabriela Schaepman-Strub, Jozef Šibík, Mikhail Yu. Telyatnikov, Elena Troeva (2019) *A raster version of the Circumpolar Arctic Vegetation Map (CAVM)* **Remote Sensing of Environment** 232: 111297, https://doi.org/10.1016/j.rse.2019.111297.'),('Loveland et al. 2000',' Loveland, T.R., Reed, B.C., Brown, J.F., Ohlen, D.O., Zhu, J, Yang, L., and Merchant, J.W., 2000, Development of a Global Land Cover Characteristics Database and IGBP DISCover from 1-km AVHRR Data: International Journal of Remote Sensing, v. 21, no. 6/7, p. 1303-1330.') ON CONFLICT DO NOTHING;



INSERT INTO map_metadata values('T6.2.IM.v2','T6.2','v1.0','v2.0','Known locations of prominent ice-free rock in glacial and alpine environments where selected from global geographical gazeteers (GeoNames 2020), glacier inventories (Raup et al 2007; GLIMS and NSIDC 2005-2018) and the Antarctic Land Cover map for 2000 (Hui et al. 2017). Further areas with mixed occurrence of barren and snow/ice cover were identified from the Circumpolar Arctic Vegetation Map (Raynolds et al. 2019), the USGS EROS LandCover GLCCDB, version 2 (Loveland et al. 2000)  and a 1km consensus land-cover map (Tuanmu et al. 2014). A composite map was created at 30 seconds spatial resolution in geographic projection, occurrences were then aggregated to half degree spatial resolution and reclassified as major occurrences (cells with at least one known occurrence) and minor occurrences (cells with > 2.5% occurrence of snow/ice cover).',NULL,'{"JR Ferrer-Paris","DA Keith"}') ON CONFLICT ON CONSTRAINT map_metadata_pkey DO UPDATE SET map_source = EXCLUDED.map_source;

INSERT INTO map_references values('T6.2.IM.v2','v2.0','Tuanmu et al. 2014'),('T6.2.IM.v2','v2.0','Raup et al 2007'),('T6.2.IM.v2','v2.0','GLIMS and NSIDC 2005-2018'),('T6.2.IM.v2','v2.0','Hui et al. 2017'),('T6.2.IM.v2','v2.0','Raynolds et al. 2019'),('T6.2.IM.v2','v2.0','GeoNames 2020'),('T6.2.IM.v2','v2.0','Loveland et al. 2000') ON CONFLICT DO NOTHING;
 \x
 select * from map_metadata where code='T6.2';

```

Export the resulting file as a [Cloud optimized Geotiff](https://www.cogeo.org/). Following recommended steps for [Creation of a cloud optimized GeoTIFF](https://trac.osgeo.org/gdal/wiki/CloudOptimizedGeoTIFF#HowtogenerateitwithGDAL):

```sh
export TARGETDIR=cogs

export SRCMAP=T6.2.IM.v2

g.region n=90 s=-90 e=180 w=-180 res=0.008333333333333

for SRCMAP in T6.2.IM.v2 T2.5.IM.v2
do
   r.out.gdal --overwrite input=$SRCMAP output=tmp.tif
   source $SCRIPTDIR/inc/grass/export-cloud-optimized-geotiff.sh
done
```

Create a PNG file for the online profile:

```sh
export SCRIPTDIR=/home/jferrer/proyectos/UNSW/T6.2-polar-alpine-cliffs
export TARGETDIR=/home/jferrer/proyectos/UNSW/Ecosystem-profiles-comments/assets/maps/
export SRCDIR=eck4

export TARGETARCH=T6.2.png
export SRCMAP=T6.2.IM.v2

export TARGETARCH=T2.5.png
export SRCMAP=T2.5.IM.v2

source $SCRIPTDIR/inc/grass/prepare-profile-map.sh
## Rscript --vanilla file.R SRCDIR SRCMAP TARGETDIR TARGETARCH
Rscript --vanilla $SCRIPTDIR/inc/R/output-profile-map.R $SRCDIR $SRCMAP $TARGETDIR $TARGETARCH

```
