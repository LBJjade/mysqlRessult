a=`cat cate2.json | jq '.|length'`
echo ${a}
for((i=0;i<${a};i++))
do
tmp=`cat cate2.json | jq ".[${i}].parentid"`
echo ${tmp}
if((${tmp}==0))
then
continue
else
id=`cat cate2.json | jq ".[${i}].id"`
oid=`cat cate2.json | jq ".[${i}].objectId"`
pObjectId=`cat cate2.json | jq ".[${id}].objectId"`
echo "id:${id}"
echo "oid:${oid}"
echo "pid:${pObjectId}"
sh curl -X PUT \-H "X-Parse-Application-Id: bec" \-H "Content-Type: application/json" \ -d "{"pointerCategory": {"__type": "Pointer","className": "Category","objectId": ${pObjectId}}}" \ http://localhost:1337/parse/classes/Category/"${id}"
fi
done
