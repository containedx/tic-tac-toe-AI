extends Node

var x : String = "res://assets/x.png"
var o : String = "res://assets/o.png"

var current : bool = 1  # 0 == o , 1 == x

func get_current_texture() -> String:
	if current : 
		return x
	return o

func change_current() -> void:
	current = !current

func move() -> void:
	GameConfig.change_current()
