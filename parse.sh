# quick and dirty parser to slice the dump and generate CSV files with the following naming scheme: ./series/[source]/[doi].csv, e.g.
#
# 	./series/wikipedia/journal.pone.0043486.csv
# 
# each file holds comma separated lines: date,count, e.g.
# 	2012-10-12,0
# 	2012-10-13,1
#
sed '1d;s/"//g' | awk -F, '!($4$1$2 in q){q[$4$1$2]; a=substr($4,9,30); f="./series/"$1"/"a".csv"; print $2","$3 >> f}'
