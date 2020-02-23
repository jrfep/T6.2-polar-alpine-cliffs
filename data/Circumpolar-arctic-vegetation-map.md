# Raster Circumpolar Arctic Vegetation Map

> Abstract: Land cover maps are the basic data layer required for understanding and modeling ecological patterns and processes. The Circumpolar Arctic Vegetation Map (CAVM), produced in 2003, has been widely used as a base map for studies in the arctic tundra biome. However, the relatively coarse resolution and vector format of the map were not compatible with many other data sets. We present a new version of the CAVM, building on the strengths of the original map, while providing a finer spatial resolution, raster format, and improved mapping. The Raster CAVM uses the legend, extent and projection of the original CAVM. The legend has 16 vegetation types, glacier, saline water, freshwater, and non-arctic land. The Raster CAVM divides the original rock-water-vegetation complex map unit that mapped the Canadian Shield into two map units, distinguishing between areas with lichen- and shrub-dominated vegetation. In contrast to the original hand-drawn CAVM, the new map is based on unsupervised classifications of seventeen geographic/floristic sub-sections of the Arctic, using AVHRR and MODIS data (reflectance and NDVI) and elevation data. The units resulting from the classification were modeled to the CAVM types using a wide variety of ancillary data. The map was reviewed by experts familiar with their particular region, including many of the original authors of the CAVM from Canada, Greenland (Denmark), Iceland, Norway (including Svalbard), Russia, and the U.S. The analysis presented here summarizes the area, geographical distribution, elevation, summer temperatures, and NDVI of the map units. The greater spatial resolution of the Raster CAVM allowed more detailed mapping of water-bodies and mountainous areas. It portrays coastal-inland gradients, and better reflects the heterogeneity of vegetation type distribution than the original CAVM. Accuracy assessment of random 1-km pixels interpreted from 6 Landsat scenes showed an average of 70% accuracy, up from 39% for the original CAVM. The distribution of shrub-dominated types changed the most, with more prostrate shrub tundra mapped in mountainous areas, and less low shrub tundra in lowland areas. This improved mapping is important for quantifying existing and potential changes to land cover, a key environmental indicator for modeling and monitoring ecosystems.

(Webpage)[http://www.geobotany.uaf.edu] (was not working on Feb 2020).

#### Citation
> Martha K. Raynolds, Donald A. Walker, Andrew Balser, Christian Bay, Mitch Campbell, Mikhail M. Cherosov, Fred J.A. Daniëls, Pernille Bronken Eidesen, Ksenia A. Ermokhina, Gerald V. Frost, Birgit Jedrzejek, M. Torre Jorgenson, Blair E. Kennedy, Sergei S. Kholod, Igor A. Lavrinenko, Olga V. Lavrinenko, Borgþór Magnússon, Nadezhda V. Matveyeva, Sigmar Metúsalemsson, Lennart Nilsen, Ian Olthof, Igor N. Pospelov, Elena B. Pospelova, Darren Pouliot, Vladimir Razzhivin, Gabriela Schaepman-Strub, Jozef Šibík, Mikhail Yu. Telyatnikov, Elena Troeva (2019) *A raster version of the Circumpolar Arctic Vegetation Map (CAVM)* **Remote Sensing of Environment** 232: 111297, https://doi.org/10.1016/j.rse.2019.111297.

#### Data access

> Raynolds, Martha; Walker, Donald (2019), “Raster Circumpolar Arctic Vegetation Map”, Mendeley Data, v1 http://dx.doi.org/10.17632/c4xj5rv6kv.1

#### Data download and preparation

```sh
mkdir -p $GISDATA/vegetation/CAVM/
cd $GISDATA/vegetation/CAVM/
mv ~/Downloads/*CAVM.zip $GISDATA/vegetation/CAVM/
```

Legend (matching total area with suppl info from the original publication)


**B**: Barrens and barren complexes: Areas with predominantly barren soils or bedrock, or covered by biological soil crusts but lacking much cover of vascular plants, mainly in bioclimate subzones A, B, and C and recently deglaciated areas.

**G**: Graminoid tundras: Areas with tundra vegetation dominated by graminoid plants (sedges, grasses and rushes), mainly in mesic areas of bioclimate subzone C and D, and ice-rich permafrost areas of bioclimate subzone E.

**S** Erect-shrub tundras: Areas with tundra vegetation dominated by erect dwarf shrubs (< 40 cm tall) or low shrubs (40–200 cm tall) and mosses mainly in mesic areas of bioclimate subzones D and E.

**W** Wetland complexes. Areas with predominantly wet tundra, often with many lakes and ponds, and patterned ground associated with periglacial landforms, such as ice-wedge polygons, palsas, and strangmoor.

|map value|class|description|EFGs|area|
|---|---|---|---|---|
|1|B1|Cryptogam, herb barren|T6.3,T6.2|636673|
|2|B2a|Cryptogam, barren complex|T6.2|484609|
|3|B4|Carbonate mountain complex|T6.2|41070|
|4|B3|Noncarbonate mountain complex|T6.2|183752|
|5|B2b|Cryptogam, barren, dwarf-shrub complex|T6.2,T6.3|124479|
|21|G1|Graminoid, forb, cryptogam tundra|T6.3|109023|
|22|G2|Graminoid, prostrate dwarf-shrub, forb, moss tundra|T6.3|273077|
|23|G3|Non-tussock sedge, dwarf-shrub, moss tundra|T6.3|716021|
|24|G4|Tussock- sedge, dwarf-shrub, moss tundra|T6.3|372269|
|31|P1|Prostrate dwarf-shrub, herb, lichen tundra|T6.3|523673|
|32|P2|Prostrate / hemi-prostrate dwarf-shrub, lichen tundra|T6.3|179431|
|33|S1|Erect dwarf-shrub, moss tundra|T6.3|687594|
|34|S2|Low-shrub, moss tundra|T6.3|118021|
|41|W1|Sedge/grass, moss wetland complex|T6.3,TF1.7,TF1.6|18095|
|42|W2|Sedge, moss, dwarf-shrub wetland complex|TF1.7,T6.3|109220|
|43|W3|Sedge, moss, low-shrub wetland complex|TF1.6,TF1.7,T6.3|137806|
|91|lakes||F2.4?|277618|
|92|ocean|open waters||42479597|
|93|glaciers||T6.1|2045974|
|99|non-arctic|non arctic land||42115685|
