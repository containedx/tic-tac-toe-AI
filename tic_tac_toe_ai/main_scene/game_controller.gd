extends Control

var board : Array

var moves = 0

var game_over : bool = false

func _ready() -> void:
	_initiate_board()
	
	if GameConfig.who_starts == 'computer':
		_on_restart(0)
		move()
	else :
		print(GameConfig.current)
		_on_restart(0)

func _input(event):
	if Input.is_action_pressed("escape"):
		get_tree().change_scene("res://menu/menu.tscn")

func reset() -> void:
	$restart.visible = true
	for row in board :
		for piece in row : 
			piece.make_not_interactive()
	

func _initiate_board() -> void:
	var rows = $board.get_children()
	for row in rows:
		var row_childs = row.get_children()
		board.append(row_childs)
	

func move() -> void:
	if game_over:
		return
	moves += 1
	var result = check_win(board)
	update_label(result)
	print("RESULT ", result)
	if GameConfig.current == false && moves != 9 && result == -1: # if O
		print("computer going")
		computer_turn()

func computer_turn() -> void:
	$computer.make_move(board)


func update_label(result : int) -> void:
	var word
	if result == -1 : 
		word = "turn"
		GameConfig.move()
	else :
		word = "WON!!"
		game_over = true
		reset()

	match GameConfig.current : 
		true :  
			$label.text = "X " + word
		false :
			$label.text = "O " + word
	
	if moves == 9 :
		$label.text = "NO ONE WON"
		reset()

#return -1, 0 or 1 (none, o, x)
func check_win(board : Array) -> int:
	var result = -1
	#check rows
	for row in board: 
		if row[0].status > -1 :
			if row[0].status == row[1].status && row[1].status == row[2].status:
				result = row[0].status
	
	#check columns
	for i in range(3):
		var temp = board[0][i].status
		if temp > -1:
			if board[1][i].status == temp && board[2][i].status == temp:
				result = board[1][i].status
	
	#check diagonal
	if board[1][1].status > -1:
		if board[0][0].status == board[1][1].status && board[2][2].status == board[1][1].status:
			result = board[0][0].status
		if board[0][2].status == board[1][1].status && board[1][1].status == board[2][0].status:
			result = board[1][1].status
	
	return result

func _on_restart(who : bool) -> void:
	$restart.visible = false
	for row in board :
		for piece in row : 
			piece.reset()
	game_over = false
	moves = 0
	GameConfig.current = who
	print(GameConfig.current)
	update_label(-1)


func _on_restart_button_down():
	get_tree().change_scene("res://menu/menu.tscn")
