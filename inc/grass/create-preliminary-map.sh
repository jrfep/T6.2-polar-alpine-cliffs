conda deactivate
grass ${GISDB}/ecosphere/earth/PERMANENT
g.mapset -c cryogenic
g.mapsets IndicativeMaps

gdalinfo ${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_1.tif
g.region n=90 s=-90 e=180 w=-180 res=0.008333333333333

r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_10.tif output=CLC1km_Snow
r.in.gdal -a -r --overwrite input=${GISDATA}/landcover/CLC1km/with_DISCover/consensus_full_class_11.tif output=CLC1km_Barren
r.null CLC1km_Snow  setnull=0
r.null CLC1km_Barren  setnull=0
r.colors CLC1km_Snow color=viridis
r.colors CLC1km_Barren color=viridis

## import Antarctic Landcover 2000
r.proj input=ALC2000_1k dbase=${GISDB}/raw location=AntarcticLC2000 mapset=PERMANENT output=ALC2000

r.in.gdal -a -r input=${WORKDIR}/GMBA_climatic_belts_V1.1.tif output=GMBA_climatic_belts

r.stats -can GMBA_climatic_belts,CLC1km_Barren output=ThermalBelts_Barren.tab

R CMD BATCH $SCRIPTDIR/inc/R/summary-needleleaf-thermalbelt.R
 cat ThermalBelts_Needleleaf_summary.tab


## This is a preliminary version
r.mapcalc --overwrite expression='T6.2_preliminary=if(GMBA_climatic_belts<3,CLC1km_Barren,null())'

## overlap with indicative map: ?
## Antarctic is still missing
