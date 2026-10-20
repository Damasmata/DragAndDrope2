class_name cliente
extends Resource

@export var name:String
@export var orden:Resource
@export var sprite:Texture2D
@export var calificando: Texture2D
@export var esperando: Texture2D
@export var mal: Texture2D
@export var bien: Texture2D
@export var maso:Texture2D
@export var ordenando: Texture2D


#func check():
	#self.get_property_list()
