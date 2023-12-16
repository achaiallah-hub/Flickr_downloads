#Install and library pacakges
install.packages("pacman")

pacman::p_load(data.table,
               dplyr,
               sf)

pacman::p_load_gh("ropensci/photosearcher")

#read in the shapefile
auvergne_sf <- sf::read_sf(".\\Auvergne\\Auvergne.shp") #directory to your shape file 

#reprojcet to wgs84
crs_reproject <- "+proj=longlat +datum=WGS84 +no_defs" #new crs to project to
auvergne_sf <- sf::st_transform(auvergne_sf, crs_reproject) # project shapefile

#search for all images within the shapefile
flickr_out <- photosearcher::photo_search(mindate_taken = "2000-01-01",
                                          maxdate_taken = "2021-01-01",
                                          maxdate_uploaded = "2021-02-01",
                                          sf_layer = auvergne_sf)

#filter results of text
flickr_out$text <- paste(flickr_out$title,
                           flickr_out$tags,
                           flickr_out$description) #create a col with all text metadata


