class_name  drink
extends  Resource

@export var nombre:String
@export var _fill_time:float
@export var sabores:Array[Texture2D]


@export var name:String
@export var colordrink:Color
@export var texture_ch:Texture2D
@export var texture_m:Texture2D
@export var texture_g:Texture2D

@export var textures:Dictionary = {"Jaimaica": ["textura_ch","textura_med","textura_gran"],"Horchata": [load("res://Sprites/bebidas/sabores/chico/Horchata_CH.png")]}
#textures["Jamaica"][0]
var fill_time:float
var act_fill_time:float
var sizes: Array[int]=[1,2,3]
