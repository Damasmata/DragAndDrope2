class_name dishManager
extends Node2D

var dish_on_second_screen:bool
var dish_on_third_screen:bool
var drink_on_screen:bool

var counters_in_level:Array[Node2D] = []
var _counters_in_level:Array[Node2D] = []


func empty_counters() -> bool:
	if _counters_in_level.size() > 0:
			return true
	return false
