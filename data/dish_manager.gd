class_name dishManager
extends Node2D

var dish_on_second_screen:bool
var dish_on_third_screen:bool
var drink_on_screen:bool

var counters_in_level:Array[Node2D] = []


func empty_counters() -> bool:
	for counter in counters_in_level:
		if !counter.ocupado:
			return true
			break
	return false
