

for ddd in `find . -type d`
do
i=0
 
for i in  {1..5}
 do 
rm "$ddd/$i.xml"

done 
done

