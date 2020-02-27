conda deactivate
grass ${GISDB}/ecosphere/earth/cryogenic
g.mapsets IndicativeMaps

g.region n=90 s=-90 e=180 w=-180 res=0.008333333333333



r.stats -can GMBA_climatic_belts,CLC1km_Barren output=ThermalBelts_Barren.tab

R CMD BATCH $SCRIPTDIR/inc/R/summary-needleleaf-thermalbelt.R
 cat ThermalBelts_Needleleaf_summary.tab


## This is a preliminary version
r.mapcalc --overwrite expression='T6.2_preliminary=if(GMBA_climatic_belts<3,CLC1km_Barren,null())'

## overlap with indicative map: ?
## Antarctic is still missing
