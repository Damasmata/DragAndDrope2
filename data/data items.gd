class_name item #nombre
extends Resource #es un recurso

@export var cooking_time:float #segundos en float
@export var itemtexture:Texture2D #la textura del item
@export var name:String #su nombre
@export var raw_color:Color #color
@export var cooked_color:Color #color
@export var group:String #a que grupo puede ser asignado 
@export var order_int:int

var cooked_time:float 
var extras_en_platillo:Array[Resource] = []
var estado_de_coccion:Array[int]=[0,1,2,3,4]
var coccion:Array[String]= ["Crudo","Suave","Dorado","Crujiente","Quemado"]



@export var sprites:Array[Texture2D] = []

func agregar_extra(nuevo_extra:Resource):
	if !extras_en_platillo.has(nuevo_extra):
		extras_en_platillo.append(nuevo_extra)
	
