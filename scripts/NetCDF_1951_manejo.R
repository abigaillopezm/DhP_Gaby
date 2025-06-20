#script par aabrir un archivo netcdf con datos de precipitación
library(terra)
library(ggplot2)
library(RColorBrewer)


# Rutas
setwd("C:\\Users\\alumnos8\\Documents\\001_DhPGaby_v2\\dhp_gaby-1")
nc <- rast("data/clipped51/prcp51.nc")

# Verifica el contenido del netCDF
nc
#Para plotear con ggplot, se tiene que convertir a un dataframe
r_d01 <- as.data.frame(nc[[31]], xy = TRUE) #seleccionar un día y convertirlo a dataframe
colnames(r_d01)[3] <- "precip"

# Plotea simple un día (por ejemplo, el primero)
#plot(nc[[60]])
ggplot(r_d01) +
  geom_raster(aes(x = x, y = y, fill = precip)) +
  #scale_fill_viridis_c(limits = c(0,25)) +
  scale_fill_distiller(palette = "Blues", direction = -1, limits = c(0, 25), oob = scales::squish) +
  coord_equal()
