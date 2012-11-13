# usage: cat sample.tsv | ./parse.sh
#
# quick and dirty parser to slice the dump and store time series data into CSV files with the following naming scheme: s_[source]_[doi].csv, e.g.
#
# 	./series/wikipedia/journal.pone.0043486.csv
#
# [source] is the ALM source, e.g. 'wikipedia', 'twitter', etc.
# [doi] is the prefix-less DOI of the article
#
sed '1d;s/"//g' | gawk -F, '!($4$1$2 in q){q[$4$1$2]; a=substr($4,9,30); f="s_"$1"_"a".csv"; print $2","$3 > f}'
