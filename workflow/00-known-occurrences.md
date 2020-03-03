## Known occurrences and distribution

### Geographical names
Glaciers, ice caps, ice sheets and permanent snowfields are prominent geographical features. We imported data from [Geonames](../data/GeoNames.md) and considered some of the following features:


|codes|names|description|
|---|---|---|
|CAPG | icecap | a dome-shaped mass of glacial ice covering an area of mountain summits or other high lands; smaller than an ice sheet|
|DOMG | icecap dome | a comparatively elevated area on an icecap|
|DPRG | icecap depression | a comparatively depressed area on an icecap|
|GLCR | glacier(s) | a mass of ice, usually at high latitudes or high elevations, with sufficient thickness to flow away from the source area in lobes, tongues, or masses|
|RDGG | icecap ridge | a linear elevation on an icecap|
|SNOW | snowfield | an area of permanent snow and ice forming the accumulation area of a glacier|
|NTK | nunatak | a rock or mountain peak protruding through glacial ice|
|NTKS | nunataks | rocks or mountain peaks protruding through glacial ice|
|FJD | fjord | a long, narrow, steep-walled, deep-water arm of the sea at high latitudes, usually along mountainous coasts|
|FJDS | fjords | long, narrow, steep-walled, deep-water arms of the sea at high latitudes, usually along mountainous coasts|



We ran the following query in sql `psql gisdata`:

```sql
SELECT fclass,fcode,count(*) FROM geonames.geoname where fcode IN ('CAPG', 'DOMG', 'DPRG',  'GLCR', 'RDGG', 'SNOW', 'NTK', 'NTKS', 'FJD', 'FJDS' ) GROUP BY fclass,fcode;
```

And found over 1400 Nunatak(s) features.

### Glacier inventories




Within the [GLIMS database](../data/Global-land-ice-measurements.md) (updated to 2019) there are some features labeled "intrnl rock":

```sql
select line_type, count(distinct glac_id) as n_id, count(distinct wgms_id) as n_wgms,count(*) as n_features from glims.polygons group by line_type;

```

These are all very small features (< 2 sqkm):

```sql
  select  anlys_id,glac_id,wgms_id ,local_id,glac_name, area,db_area, ST_AREA(wkb_geometry::geography)/1000000 as sqkm  from glims.polygons WHERE line_type='intrnl_rock' ORDER BY sqkm DESC limit 40;
 ```
