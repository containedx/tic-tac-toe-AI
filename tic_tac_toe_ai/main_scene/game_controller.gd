extends Control

var board : Array

var moves = 0

func _ready() -> void:
	_on_restart()
	_initiate_board()

func reset() -> void:
	moves = 0
	$result.visible = true
	for row in board :
		for piece in row : 
			piece.reset()

func _initiate_board() -> void:
	var rows = $board.get_children()
	for row in rows:
		var row_childs = row.get_children()
		board.append(row_childs)


func move() -> void:
	moves += 1
	var result = check_win()
	print(result)
	update_label(result)
	GameConfig.move()


func check_win() -> bool:
	var result = false
	#check rows
	print(board)
	for row in board: 
		if row[0].status > -1 :
			if row[0].status == row[1].status && row[1].status == row[2].status:
				result = true
	
	#check columns
	for i in range(3):
		var temp = board[0][i].status
		if temp != -1:
			if board[1][i].status == temp && board[2][i].status == temp:
				result = true
	
	#check diagonal
	if board[1][1].status != -1:
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
		true :
			word = "WON!!"
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
