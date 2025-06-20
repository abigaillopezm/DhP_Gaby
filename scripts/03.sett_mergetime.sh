i=0
for file in precip1951*.nc; do
  date=$(date -d "1951-01-01 +$i days" +%Y-%m-%d)
  cdo settaxis,${date},00:00:00,1day "$file" "fixed_$file"
  ((i++))
done