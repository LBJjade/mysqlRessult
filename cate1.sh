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
oid=`cat cate2.json | jq ".[${i}]".objectId`
ojid=`cat cate2.json | jq ".[${i}]".objectId | tr -d '"'`
echo ${ojid}
pObjectId=`cat cate2.json | jq ".[${tmp}].objectId"`
for((k=0;k<${a};k++))
do 
kid=`cat cate2.json | jq ".[${k}].id"`
if((${kid}==${tmp}))
then
parentOid=`cat cate2.json | jq ".[${k}].objectId"`
else
continue
fi
done
echo ${parentOid}
echo "id:${id}"
echo "oid:${oid}"
echo "pid:${pObjectId}"
curl -X PUT \
  -H "X-Parse-Application-Id: bec" \
  -H "Content-Type: application/json" \
  -d '{"pointerCategory": {
				"__type": "Pointer",
				"className": "Category",
				"objectId": '"${parentOid}"'
			}}' \
http://localhost:1337/parse/classes/Category/"${ojid}"
fi
done
