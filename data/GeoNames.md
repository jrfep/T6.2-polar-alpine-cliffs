# GeoNames

Webpage at http://www.geonames.org/


#### Data access

Data is available at https://download.geonames.org/export/dump/

#### Data download and preparation

```sh
mkdir -p $GISDATA/gazeteer/GeoNames
cd  $GISDATA/gazeteer/GeoNames

wget --continue https://download.geonames.org/export/dump/allCountries.zip
wget --continue https://download.geonames.org/export/dump/shapes_simplified_low.json.zip
wget http://download.geonames.org/export/dump/alternateNames.zip
wget http://download.geonames.org/export/dump/countryInfo.txt
wget http://download.geonames.org/export/dump/iso-languagecodes.txt


unzip -u allCountries.zip
unzip -u alternateNames.zip
tail -n +52 countryInfo.txt > countryInfo


```

#### Importing to postGIS

Following instructions in [**GeoNames import to Postgres** by @coleman](https://github.com/colemanm/gazetteer/blob/master/docs/geonames_postgis_import.md):

##### Create the schema and table

```sh

psql gisdata jferrer -c "CREATE SCHEMA geonames"

```

Then go into the client: `psql gisdata`

```sql

create table geonames.geoname (
	geonameid	int,
	name varchar(200),
	asciiname varchar(200),
	alternatenames text,
	latitude float,
	longitude float,
	fclass char(1),
	fcode varchar(10),
	country varchar(2),
	cc2 text,
	admin1 varchar(20),
	admin2 varchar(80),
	admin3 varchar(20),
	admin4 varchar(20),
	population bigint,
	elevation int,
	gtopo30 int,
	timezone varchar(40),
	moddate date
 );

create table geonames.alternatename (
	alternatenameId int,
	geonameid int,
	isoLanguage varchar(7),
	alternateName varchar(200),
	isPreferredName boolean,
	isShortName boolean,
	isColloquial boolean,
	isHistoric boolean
 );

create table geonames.countryinfo (
	iso_alpha2 char(2),
	iso_alpha3 char(3),
	iso_numeric integer,
	fips_code varchar(3),
	name varchar(200),
	capital varchar(200),
	areainsqkm double precision,
	population integer,
	continent varchar(2),
	tld varchar(10),
	currencycode varchar(3),
	currencyname varchar(20),
	phone varchar(20),
	postalcode varchar(100),
	postalcoderegex varchar(200),
  languages varchar(200),
  geonameId int,
	neighbors varchar(50),
	equivfipscode varchar(3)
);
```

##### Insert data into the table
Again in the client: `psql gisdata`

```sql
\copy geonames.geoname (geonameid,name,asciiname,alternatenames,latitude,longitude,fclass,fcode,country,cc2,admin1,admin2,admin3,admin4,population,elevation,gtopo30,timezone,moddate) from 'allCountries.txt' null as '';
\copy geonames.alternatename  (alternatenameid,geonameid,isolanguage,alternatename,ispreferredname,isshortname,iscolloquial,ishistoric) from 'alternateNames.txt' null as '';
\copy geonames.countryinfo (iso_alpha2,iso_alpha3,iso_numeric,fips_code,name,capital,areainsqkm,population,continent,tld,currencycode,currencyname,phone,postalcode,postalcoderegex,languages,geonameid,neighbors,equivfipscode) from 'countryInfo' null as '';
```

##### Add key and constraints
Again in the client: `psql gisdata`

```sql
ALTER TABLE ONLY geonames.alternatename
      ADD CONSTRAINT pk_alternatenameid PRIMARY KEY (alternatenameid);
ALTER TABLE ONLY geonames.geoname
      ADD CONSTRAINT pk_geonameid PRIMARY KEY (geonameid);
ALTER TABLE ONLY geonames.countryinfo
      ADD CONSTRAINT pk_iso_alpha2 PRIMARY KEY (iso_alpha2);

ALTER TABLE ONLY geonames.countryinfo
      ADD CONSTRAINT fk_geonameid FOREIGN KEY (geonameid) REFERENCES geonames.geoname(geonameid);
ALTER TABLE ONLY geonames.alternatename
      ADD CONSTRAINT fk_geonameid FOREIGN KEY (geonameid) REFERENCES geonames.geoname(geonameid);
-- ERROR:  insert or update on table "alternatename" violates foreign key constraint "fk_geonameid"
-- DETAIL:  Key (geonameid)=(12129349) is not present in table "geoname".
```

##### Geometry column
Again in the client: `psql gisdata`

```sql
SELECT AddGeometryColumn ('geonames','geoname','the_geom',4326,'POINT',2);

UPDATE geonames.geoname SET the_geom = ST_PointFromText('POINT(' || longitude || ' ' || latitude || ')', 4326);

CREATE INDEX idx_geoname_the_geom ON geonames.geoname USING gist(the_geom);
```


#### Notes
* [Readme file](http://download.geonames.org/export/dump/readme.txt)
* [Table of feature codes](http://www.geonames.org/export/codes.html), there are many useful categories for fjords, ice caps, caves, etc.
