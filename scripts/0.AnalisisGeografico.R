#Primero, fijar el directorio de trabajo
setwd("~/001_DhPGaby_v2/dhp_gaby-1")

#cargar las librerias
library(sf)
library(ggplot2)
library(RColorBrewer)
library(ggnewscale)
library(colorspace)


#Ruta de los datos y definición de variables
path_climas <- "data/AnalisisGeografico/Climas_1mgw/clima1mgw.shp"
path_climhum <- "data/AnalisisGeografico/humed4mgw/humed4mgw.shp"
path_edafo <- "data/AnalisisGeografico/edafologoia_4mgw/edafo4mgw.shp"
path_rios <- "data/AnalisisGeografico/Regiones-hidrologicas_4mgw/hidro4mgw.shp"
path_hidro <- "data/AnalisisGeografico/Regiones-hidrologicas_250kgw/rh250kgw.shp"
path_suelo7 <- "data/AnalisisGeografico/usv250s7gw_INEGI_SERIE7/usv250s7gw.shp"
path_pico <- "data/z.AREA/Area_Metodo/Poligono_ANP_Pico.shp"
path_estat <- "data/AnalisisGeografico/DivisonEstatal_dest23gw/dest23gw.shp"
path_domKML <- "data/Dom_50km.kml"

climas <- st_read(path_climas)
climhum <- st_read(path_climhum)
edafo <- st_read(path_edafo)
rios <- st_read(path_rios)
hidro <- st_read(path_hidro)
suelo7 <- st_read(path_suelo7)
ANPpico <- st_read(path_pico)
estat <- st_read(path_estat)
#suelo7v2 <- st_make_valid(suelo7) #corrige error del shape de uso de suelo
#Errores por invalidez de datos
dominio<- st_read(path_domKML)

#ploteo de prueba
plot(edafo) #plotea todas las cosas

#####
##Recortar# el shape al área de estudio
#xmin <- -98.0
#xmax <- -94.0
#ymin <- 18.0
#ymax <- 22.0
#region <- st_polygon(list(matrix(c(xmin, ymin, xmax, ymin, xmax, ymax, xmin, ymax, xmin, ymin), ncol=2, byrow=TRUE)))
#region <- st_sfc(region, crs = st_crs(shape)) # Asegúrate de que tenga la misma proyección que el shapefile
#shape_picoarea <- shape[region, ]
#plot(st_geometry(shape))
#plot(st_geometry(region), add=TRUE, border="red", lwd=2)
#plot(st_geometry(shape_picoarea), add=TRUE, col="blue")
#######
# Recortar utilizando un kml (interseccionar)
climas_dom <- st_intersection(climas, dominio) #CLIMA_TIPO
climhum_dom <- st_intersection(climhum, dominio) #TIPO
edafo_dom <- st_intersection(edafo, dominio) #UNIDAD SUE
rios_dom <- st_intersection(rios, dominio) #NOMRES
hidro_dom <- st_intersection(hidro, dominio) #NOMBRE
estat_dom <- st_intersection(estat, dominio) #
#suelo7_dom <- st_intersection(suelo7, dominio) #corregir error de validez

#ploteo avanzado
#####
#CLIMAS
n_clases <- length(unique(climas_dom$CLIMA_TIPO))
colores <- qualitative_hcl(n_clases, palette = "Dark 3")
ggplot() +
  geom_sf(data = climas_dom, aes(fill = CLIMA_TIPO)) +
  geom_sf(data = ANPpico) +
  annotate("text", x = -97.28, y = 19.05, label = "ANP", size = 5) +
  scale_fill_manual(values = colores) +
  theme_light(base_size = 13) +
  ggtitle("Tipos de clima") + xlab("Longitud") + ylab("Latitud") +
  labs(fill = "Leyenda",
       caption = "Fuente: García (1998), CONABIO (2001).\nClimas de México, escala 1:1,000,000.") +
  theme(plot.caption = element_text(size = 7, color = "gray40", face = "italic", hjust = 1))

ggsave("outputs/00.CLIMAS.png", width = 11, height = 8, dpi = 300)

#####
# CLIMAS HUMEDAD
ggplot() +
  geom_sf(data = climhum_dom, aes(fill = TIPO))+ #nombre de la variable, se ve con head()
  geom_sf(data = ANPpico) +
  annotate("text", x = -97.28, y = 19.05, label = "ANP", size = 5) +
  scale_fill_brewer(palette = "BrBG") +
  #geom_contour(data = estat_dom, color = "white")
  theme_light(base_size = 13) +
  ggtitle("Tipos de clima por rango de humedad") + xlab("Longitud") + ylab("Latitud") +
  labs(fill = "Leyenda",
       caption = "Fuente: García (1990), Atlas Nacional de México.\nRangos de humedad, escala 1:4,000,000 (UNAM, IGg).") +
  theme(plot.caption = element_text(size = 7, color = "gray40", face = "italic", hjust = 1))
ggsave("outputs/00.CLIM_HUM.png", width = 11, height = 8, dpi = 300)

#####
# EDAFOLOGIA
ggplot() +
  geom_sf(data = edafo_dom, aes(fill = UNIDAD_SUE))+ #nombre de la variable, se ve con head()
  geom_sf(data = ANPpico) +
  annotate("text", x = -97.28, y = 19.05, label = "ANP", size = 5) +
  scale_fill_brewer(palette = "Set3") +
  #geom_contour(data = estat_dom, color = "white")
  theme_light(base_size = 13) +
  ggtitle("Edafología") + xlab("Longitud") + ylab("Latitud") +
  labs(fill = "Leyenda",
       caption = "Fuente: SEMARNAP (1998). Mapa de suelos dominantes de la República Mexicana.\nPrimera aproximación 1996, escala 1:4,000,000.") +
  theme(plot.caption = element_text(size = 7, color = "gray40", face = "italic", hjust = 1))
ggsave("outputs/00.EDAFO.png", width = 11, height = 8, dpi = 300)


#####
#CUENCAS y RIOS
ggplot() +
  geom_sf(data = hidro_dom, aes(fill = NOMBRE))+ #nombre de la variable, se ve con head()
  geom_sf(data = ANPpico) +
  annotate("text", x = -97.28, y = 19.05, label = "ANP", size = 5) +
  scale_fill_brewer(name = "Dark2")+
  geom_sf(data=rios_dom, color = "blue")+
  geom_sf_text(data = rios_dom, aes(label = NOMBRES), size = 3, color = "black") +
  theme_light(base_size = 13) +
  ggtitle("Cuencas hidrológicas y ríos") + xlab("Longitud") + ylab("Latitud") +
  labs(fill = "Leyenda", 
      caption = "Fuentes: CONAGUA (2009), Regiones Hidrológicas (escala 1:250,000).\nMaderey-R & Torres-Ruata (1998), Hidrografía, Atlas Nacional de México (escala 1:4,000,000).") +
  theme(plot.caption = element_text(size = 7, color = "gray40", face = "italic", hjust = 1))
ggsave("outputs/00.HIDRO.png", width = 11, height = 8, dpi = 300)

