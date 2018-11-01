

for ddd in `find . -type d`
do
i=0
mv "$ddd/stroke.xml" "$ddd/8.xml"
for i in  {1..7}
 do 
mv "$ddd/stroke.xml.~$i~" "$ddd/$i.xml"

done 
done

