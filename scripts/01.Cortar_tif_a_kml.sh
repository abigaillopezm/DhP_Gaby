#mkdir data/clipped51
for file in data/nc_files51/*.nc; do
  cdo -f nc sellonlatbox,-98,95,17,20 "$file" "data/clipped51/$(basename $file)"
done