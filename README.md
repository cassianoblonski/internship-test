# README

Endpoints:

**POST** /map

``` json
map:{
"name": "Halan Map", 
"point_connections": {"A":{"B":10, "C":20}, "B":{"D":15, "E":50}, "C":{"D":30}, "D":{"E":30}}
}
```



**GET** /cheaper_route/:map_name/:initial_point/:destination/:cost

```
map_name: => The name of your map. example: "Halan Map"
initial_point: string => a valid initial point, case sensitive. example: "A"
destination: string => a valid destination point, case sensitive. example: "D"
cost: number => The cost per km. example: 15
```

An example of a GET /cheaper_route URL:

​	http://localhost:3000/cheaper_route/Halan%20Map/A/D/10/

