extends Control

var board : Array

var moves = 0

var game_over : bool = false

func _ready() -> void:
	_on_restart()
	_initiate_board()

func reset() -> void:
	$result.visible = true
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
	var result = check_win()
	update_label(result)
	if GameConfig.current == false : # if O
		computer_turn()

func computer_turn() -> void:
	$computer.make_move(board)

func check_win() -> bool:
	var result = false
	#check rows
	for row in board: 
		if row[0].status > -1 :
			if row[0].status == row[1].status && row[1].status == row[2].status:
				result = true
	
	#check columns
	for i in range(3):
		var temp = board[0][i].status
		if temp > -1:
			if board[1][i].status == temp && board[2][i].status == temp:
				result = true
	
	#check diagonal
	if board[1][1].status > -1:
		if board[0][0].status == board[1][1].status && board[2][2].status == board[1][1].status:
			result = true
		if board[0][2].status == board[1][1].status && board[1][1].status == board[2][0].status:
			result = true
	
	return result


func update_label(result : bool) -> void:
	var word
	match result : 
		false : 
			word = "turn"
			GameConfig.move()
		true :
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


func _on_restart() -> void:
	$result.visible = false
	for row in board :
		for piece in row : 
			piece.reset()
	game_over = false
	moves = 0
	GameConfig.current = 0
	update_label(false)
