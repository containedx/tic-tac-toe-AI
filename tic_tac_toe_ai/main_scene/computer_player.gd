extends Control


func make_move(board : Array) -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	print("computer is making move")
	
	var blank_pieces : Array = []
	for row in board:
		for r in row:
			if r.status == -1:
				blank_pieces.append(r)
	
	if !blank_pieces : 
		return
	
	#pick random for now
	var rng = RandomNumberGenerator.new()
	var random_number = rng.randf_range(0, blank_pieces.size() - 1)
	var random_choice = blank_pieces[random_number]
	print("random ", random_number, random_choice)
	random_choice._on_button_pressed_up()
