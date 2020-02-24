# AntarcticaLC2000: The new Antarctic land cover database for the year 2000

(Webpage)[]

Based on Landsat Enhanced Thematic Mapper Plus (ETM+)  2000 and Moderate Resolution Imaging Spectrometer (MODIS) images from the austral summer of 2003/2004.  1:100,000 scale

Correspondence between land cover types and Ecosystem Functional Groups:
 * ice-free rocks (T6.2),
 * blue ice  (T6.1),
 * and snow/firn (T6.1).

#### Citation
> Hui, F., J. Kang, Y. Liu, X. Cheng, P. Gong, F. Wang, Z. Li, Y. Ye, and Z. Guo. 2017. *AntarcticaLC2000: The new Antarctic land cover database for the year 2000.* **SCIENCE CHINA Earth Sciences** 60: 686-696. doi: 10.1007/s11430-016-0029-2.

#### Data access

> Hui, FengMing, Kang, Jing, Liu, Yan, Cheng, Xiao, Gong, Peng, Wang, Fang, … Guo, ZiQi. (2017). *AntarcticaLC2000: The new Antarctic land cover database for the year 2000* [Data set]. **Zenodo**. http://doi.org/10.5281/zenodo.826032

#### Data download and preparation


```sh
mkdir -p $GISDATA/landcover/Antarctica-LC2000
cd $GISDATA/landcover/Antarctica-LC2000
wget --continue -O AntarcticaLC2000_release_online.rar https://zenodo.org/record/826032/files/AntarcticaLC2000%20release%20online.rar?download=1

## uncompress in working directory
cd $WORKDIR
unrar e $GISDATA/landcover/Antarctica-LC2000/AntarcticaLC2000_release_online.rar

## check projection information
ogrinfo -al -so ice_freerocks.shp
 dbfdump ice_freerocks.dbf 

```

#### Notes:
Check following resources:

An automated methodology for differentiating rock from snow, clouds and sea in Antarctica from Landsat 8 imagery: a new rock outcrop map and area estimation for the entire Antarctic continent", published in The Cryosphere 01 August 2016 ([external resource]). doi:10.5194/tc-10-1665-2016

Bliss, A., R. Hock and J. G. Cogley, 2013. A new inventory of mountain glaciers and ice caps for the Antarctic periphery. Ann. Glaciol.,
54(63), 191-199, doi:10.3189/2013AoG63A377

Hannes Grobe/AWI - Data: Quantarctica 2, Norwegian Polar Institute, 2014, http://www.quantarctica.org

Blue ice citation: Hui, F.M., T.Y. Ci, X. Cheng, T.A. Scambos, Y. Liu, Y.M. Zhang, Z.H. Chi, H.B. Huang, X.W. Wang, F. Wang, C. Zhao and Z.Y. Jin 2014. Mapping blue ice areas in Antarctica using ETM+ and MODIS data. Annals of Glaciology, 55(66): 129-137, https://doi.org/10.3189/2014AoG66A069.

Antarctic Digital Database (ADD) Version 6.0., http://www.add.scar.org

Arndt, J. E., et al. (2013), The International Bathymetric Chart of the Southern Ocean (IBCSO) Version 1.0—A new bathymetric compilation covering circum-Antarctic waters, Geophys. Res. Lett., 40, 3111–3117, https://doi.org/10.1002/grl.50413. Mapping tool: QGIS 2.18, http://www.qgis.org
