##########################################
# ABRIR UN SOLO ARCHIVO PARA EXPLORAR
#____________________________________________________________

#Cargar librerias
library(terra)
library(ggplot2)

#abrir el tif
prcp_510101 <- rast("./data/1951/precip19510101.tif")
print(prcp_510101)
plot(prcp_510101)

#para desplegar variables en ggplot, deben estar en formato de dataframe
prcp_df <- as.data.frame(prcp_510101, xy = TRUE)
names(prcp_df)[3] <- "precip" #cambia nombre columna valores

#plotear con ggplot
ggplot(prcp_df, aes(x = x, y = y, fill = precip)) +
  geom_raster() +
  coord_equal() +
  scale_fill_viridis_c(option = "C") +  # Escala de colores bonita y clara
  labs(title = "Precipitación del 1 de enero de 1951",
       fill = "mm") +
  theme_minimal()
ggsave("outputs/prcp2021-01-01.png", width = 8, height = 6, dpi = 300)
