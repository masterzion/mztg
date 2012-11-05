for f in *.txt ; do 
    iconv -f ISO8859-1 -t UTF-8 $f  | sort -u -o temp.txt
    cat temp.txt |  unaccent utf-8  > $f;
done

rm temp.txt
