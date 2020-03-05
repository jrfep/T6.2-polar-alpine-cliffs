conda deactivate
grass ${GISDB}/ecosphere/earth/PERMANENT
g.mapset -c cryogenic

gdalinfo ${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_1.tif
g.region n=90 s=-90 e=180 w=-180 res=0.008333333333333

## data sources for cryogenic functional groups:

## climatologies
## from CHELSA
r.in.gdal -a -r --overwrite input=${GISDATA}/clima/CHELSA/bioclim/CHELSA_bio10_02.tif output=CHELSA_temp_drange
r.in.gdal -a -r --overwrite input=${GISDATA}/clima/CHELSA/bioclim/CHELSA_bio10_03.tif output=CHELSA_temp_isotherm
r.in.gdal -a -r --overwrite input=${GISDATA}/clima/CHELSA/bioclim/CHELSA_bio10_04.tif output=CHELSA_temp_season
r.in.gdal -a -r --overwrite input=${GISDATA}/clima/CHELSA/bioclim/CHELSA_bio10_11.tif output=CHELSA_temp_colq

## radiation
##UV-B
r.in.gdal -o -a -r --overwrite input=${GISDATA}/sensores/glUV/56459_UVB1_Annual_Mean_UV-B.asc output=UVB1_Annual_Mean

## climatic stratification:
## Global Environmetal Stratification, version 3
r.in.gdal -a -r --overwrite input=$GISDATA/clima/GEnS/GEnSv3/gens_v3.tif output=GEnSv3
## thermal climatic belts from GMBA, version 1.1
r.in.gdal -a -r --overwrite input=${WORKDIR}/GMBA_climatic_belts_V1.1.tif output=GMBA_climatic_belts
## Koeppen Geiger classification, Beck et al. version 1
r.in.gdal -o -a -r --overwrite input=Beck_KG_V1_present_0p0083.tif output=KoeppnGeiger_classes

## topography: mountain definition
r.in.gdal -a -r --overwrite input=${WORKDIR}/GMBA_mountain_definition_V1.1.tif output=GMBA_mountains

## landcover
## Near global consensus landcover
r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_1.tif output=CLC1km_Needleleaf
r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_2.tif output=CLC1km_Evergreen
r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_3.tif output=CLC1km_Deciduous
r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_4.tif output=CLC1km_MixedTrees

r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_6.tif output=CLC1km_Herbaceous
r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_5.tif output=CLC1km_Shrubs
r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_10.tif output=CLC1km_Snow
r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_11.tif output=CLC1km_Barren

for VAR in Snow Barren Shrubs Herbaceous Needleleaf Evergreen Deciduous MixedTrees
do
   r.null CLC1km_${VAR}  setnull=0
   r.colors CLC1km_${VAR} color=viridis
done

## USGS EROS Land Cover
r.in.gdal -o -a -r --overwrite input=${GISDATA}/landcover/USGS_EROS/data.nc output=GLCCDB_v2
r.colors map=GLCCDB_v2 color=random

## Antarctic landcover 2010
r.proj input=ALC2000_1k dbase=${GISDB}/raw location=AntarcticLC2000 mapset=PERMANENT output=ALC2000

## Circumpolar Arctic vegetation
r.proj input=CAVM_v1 dbase=${GISDB}/raw location=CAVM mapset=PERMANENT output=CAVM_v1
## Circumpolar Arctic permafrost layer
r.proj input=Permafrost dbase=${GISDB}/raw location=CA_permafrost mapset=PERMANENT output=CA_permafrost


## coastline types from the global coastal typology.
v.in.ogr typology_coastline.shp
##v.in.ogr -o input=typology_coastline.shp output=coastal_typology
v.in.ogr -o input=typology_catchments.shp output=coastal_typology columns=cat,AREA,PERIMETER,C_BASIN_,C_BASIN_ID,BASINID,RECORDNAME,BASINORDER,COLOR,SYMBOLFLD,BASINLENGT,BASINAREA,SUBCONTINE,ESRI,HYDRO,UP6,SEANAME,OCEANNAME,SEABASINNA,SEACODE,OCEANCODE,ARCTICCODE,SUBCONT,SEABASINCO,DBITEMS,FIN_TYP,MERGED_BAS,DATA_VOL,OCEAN_CODE,CONTINENT_

## d.vect map=coastal_typology@cryogenic where=FIN_TYP=4
v.to.rast --overwrite input=coastal_typology@cryogenic where=FIN_TYP=4 output=Fjord_basins use=val

##v.to.rast --overwrite input=coastal_typology@cryogenic output=Fjord_basins use=val FIN_TYP
v.to.rast --overwrite input=coastal_typology@cryogenic output=FIN_TYP_basin use=attr attr_column=FIN_TYP

r.colors FIN_TYP_basin color=random

r.grow.distance -m input=FIN_TYP_basin@cryogenic distance=FIN_TYP_distance value=FIN_TYP_value metric=geodesic
