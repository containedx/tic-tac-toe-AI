extends Control


func make_move(board : Array) -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	print("computer is making move")
	
	var temp_board = copy_board(board)
	var avaiable = get_first_avaiable(board)
	if !avaiable : 
		return
	
	
	#pick random for now
	#var rng = RandomNumberGenerator.new()
	#var random_number = rng.randf_range(0, avaiable.size() - 1)
	#var random_choice = avaiable[random_number]
	#print("random ", random_number, random_choice)
	avaiable._on_button_pressed_up()



func get_first_avaiable(board : Array):
	for row in board:
		for r in row:
			if r.status == -1:
				return r


func copy_board(board : Array) -> Array :
	var copied_board : Array = board.duplicate(true)
	for i in range(3):
		for j in range(3):
			copied_board[i][j] = board[i][j].status
	
	return copied_board
