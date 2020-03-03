# GLIMS Glacier database
Global Land Ice Measurements from Space initiative (GLIMS)

[Webpage](http://glims.colorado.edu/glacierdata/)

#### Citation

> GLIMS and NSIDC (2005, updated 2018): Global Land Ice Measurements
from Space glacier database.  Compiled and made available by the
international GLIMS community and the National Snow and Ice Data Center,
Boulder CO, U.S.A.  DOI:10.7265/N5V98602

> Raup, B.H.; A. Racoviteanu; S.J.S. Khalsa; C. Helm; R. Armstrong; Y.
   Arnaud (2007).  "The GLIMS Geospatial Glacier Database: a New Tool for
   Studying Glacier Change".  Global and Planetary Change 56:101--110.
   (doi:10.1016/j.gloplacha.2006.07.018)

#### Data access

http://www.glims.org/download/

#### Data download and preparation

```sh
mkdir -p $GISDATA/inventories/GLIMS_2019
cd $GISDATA/inventories/GLIMS_2019
wget --continue http://www.glims.org/download/glims_db_20191217.zip
```


We import this dataset in postgis for further data preparation and selection

```sh
mkdir -p $WORKDIR/GLIMS
cd $WORKDIR/GLIMS
unzip $GISDATA/inventories/GLIMS_2019/glims_db_20191217.zip
 cd $WORKDIR/GLIMS/glims_download*

psql gisdata jferrer -c "CREATE SCHEMA glims"
for SHPFILE in images lines polygons points
do
   ogr2ogr -f "PostgreSQL" PG:"host=localhost user=jferrer dbname=gisdata" -lco SCHEMA=glims -nlt PROMOTE_TO_MULTI  glims_$SHPFILE.shp glims_$SHPFILE -nln $SHPFILE
 done
cd $WORKDIR
rm -r $WORKDIR/GLIMS

```

This way we can summarize information according to documented variables, for example, just `psql gisdata` and:

```sql
 select line_type,count(*) from glims.polygons group by line_type;
select count(distinct glac_id),count(*) from glims.polygons;

select glac_stat,rec_status, count(distinct glac_id) from glims.polygons group by glac_stat,rec_status;


```

We now extract some features to a new table (in `psql gisdata`). This will create a list with the most recent glacier outlines

```sql

-- order by anlys_time
-- filter by rec_status = "okay" & glac_stat = "exists"
CREATE table glims.valid_glaciers AS(
WITH summary AS (
   SELECT p.glac_id,
          p.glac_name,
          p.wkb_geometry,
          ROW_NUMBER() OVER(PARTITION BY p.glac_id
                                ORDER BY p.anlys_time DESC) AS rk
     FROM glims.polygons p
     WHERE rec_status = 'okay' AND glac_stat = 'exists' AND line_type = 'glac_bound'
     )
SELECT s.*
 FROM summary s
WHERE s.rk = 1);
-- 319732 records
```

This will create a list of points with the centroid of the features labeled as "internal rock"

```sql

CREATE table glims.valid_nunataks AS(
   SELECT p.glac_id,
          p.glac_name,
          st_centroid(p.wkb_geometry) AS wkb_geometry
     FROM glims.polygons p
     WHERE rec_status = 'okay' AND glac_stat = 'exists' AND line_type = 'intrnl_rock'
     );
-- 447 records
```
