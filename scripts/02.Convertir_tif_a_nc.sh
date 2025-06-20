mkdir data/nc_files51
for file in data/1951/*.tif; do
  name=$(basename "$file" .tif)
  gdal_translate -of netCDF "$file" "data/nc_files51/${name}.nc"
done