extends Control


func _input(event):
	if Input.is_action_pressed("escape"):
		get_tree().change_scene("res://menu/menu.tscn")
