

for ddd in `find . -type d`
do
i=0
for i in  {6..8}
 do 
rm "$ddd/$i.xml"

done 
done

