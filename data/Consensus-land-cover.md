# Global 1-km Consensus Land Cover

[Webpage](http://www.earthenv.org/L)

#### Citation
> Tuanmu, M.-N. and W. Jetz. 2014. A global 1-km consensus land-cover product for biodiversity and ecosystem modeling. Global Ecology and Biogeography 23(9): 1031-1045.

#### Data access

Data available on-line at http://www.earthenv.org/

#### Data download and preparation


```sh
mkdir -p $GISDATA/landcover/CLC1km
cd $GISDATA/landcover/CLC1km
##wget https://www.earthenv.org/landcover

export VERSION=without_DISCover
export PREFIX=Consensus_reduced
mkdir -p $GISDATA/landcover/CLC1km/$VERSION
cd $GISDATA/landcover/CLC1km/$VERSION
for CLASS in $(seq 1 12)
do
   wget --continue https://data.earthenv.org/consensus_landcover/${VERSION}/${PREFIX}_class_${CLASS}.tif
done

export VERSION=with_DISCover
export PREFIX=consensus_full
mkdir -p $GISDATA/landcover/CLC1km/$VERSION
cd $GISDATA/landcover/CLC1km/$VERSION
for CLASS in $(seq 1 12)
do
   wget --continue https://data.earthenv.org/consensus_landcover/${VERSION}/${PREFIX}_class_${CLASS}.tif
done

```


|Class nr|desc|EFGs|
|---|---|---|
|1|Evergreen/Deciduous Needleleaf Trees|T2.1|
|2|Evergreen Broadleaf Trees||
|3|Deciduous Broadleaf Trees||
|4|Mixed/Other Trees||
|5|Shrubs||
|6|Herbaceous Vegetation||
|7|Cultivated and Managed Vegetation|T7.1,T7.3|
|8|Regularly Flooded Vegetation|TF1.?|
|9|Urban/Built-up|T7.4|
|10|Snow/Ice|T6.1,T6.2|
|11|Barren|T5.*,T6.2?|
|12|Open Water|F1.?,F2.?|
