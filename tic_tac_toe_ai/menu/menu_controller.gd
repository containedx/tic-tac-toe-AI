extends Control




func _on_computer_button_down():
	start_game('computer')


func _on_human_button_down():
	start_game('human')


func start_game(who : String) -> void:
	GameConfig.who_starts = who 
	get_tree().change_scene("res://main_scene/game_scene.tscn")
