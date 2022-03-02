extends TextureRect

var status : int = -1  # -1 == blank, 1 == x, 0 == o


func _on_button_pressed_up() -> void:
	status = GameConfig.current
	print("PRESSED ", status)
	var current_texture = GameConfig.get_current_texture()
	change_texture(current_texture)
	make_not_interactive()
	get_parent().get_parent().get_parent().move()


func change_texture(texture_path : String) -> void: 
	texture = load(texture_path)


func reset() -> void:
	status = -1
	change_texture("res://assets/blank.png")
	$button.visible = true


func make_not_interactive() -> void:
	$button.visible = false
