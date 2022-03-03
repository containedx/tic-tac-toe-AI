extends Control


func make_move(board : Array) -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	print("computer is making move")
	
	#board with tatus values only
	var test_board = copy_board(board)
	print(test_board)
	
	var best_score = -INF
	var move_coordinates = {
		x = 0,
		y = 0
	}
	
	for i in range(3):
		for j in range(3):
			if test_board[i][j] == -1: #if avaiable
				#try to make move there on test board
				test_board[i][j] = 0 #because computer is o 
				var score = minimax(test_board, 0, false)
				print(score)
				if score > best_score:
					score = best_score
					move_coordinates.x = i
					move_coordinates.y = j
					print(i," ",j)
	
	
	#make move
	print(move_coordinates)
	board[move_coordinates.x][move_coordinates.y]._on_button_pressed_up()


func minimax(board : Array, depth, is_max) -> int:
	var result = check_win(board)
	if result != -1 : # => someone won
		return count_score(result)
	
	if is_max : #calculating computer best move
		var best_score = -INF
		
		for i in range(3):
			for j in range(3):
				if board[i][j] == -1: #if avaiable
					board[i][j] = 0 #computer ai move
					var score = minimax(board, depth + 1, false)
					board[i][j] = -1
					best_score = max(score, best_score)
		
		return best_score
	
	else : #calculating worst senario for human
		var worst_score = +INF
		
		for i in range(3):
			for j in range(3):
				if board[i][j] == -1: #if avaiable
					board[i][j] = 1 #human move
					var score = minimax(board, depth + 1, true)
					board[i][j] = -1
					worst_score = min(score, worst_score)
		
		return worst_score




func count_score(result : int) -> int :
	match result:
		1: # x won
			return -1
		0: # o won
			return 1
	return 0

func copy_board(board : Array) -> Array :
	var copied_board : Array = board.duplicate(true)
	for i in range(3):
		for j in range(3):
			copied_board[i][j] = board[i][j].status
	
	return copied_board


#return -1, 0 or 1 (none, o, x)
func check_win(board : Array) -> int:
	var result = -1
	#check rows
	for row in board: 
		if row[0] > -1 :
			if row[0] == row[1] && row[1] == row[2]:
				result = row[0]
	
	#check columns
	for i in range(3):
		var temp = board[0][i]
		if temp > -1:
			if board[1][i] == temp && board[2][i] == temp:
				result = board[1][i]
	
	#check diagonal
	if board[1][1] > -1:
		if board[0][0] == board[1][1] && board[2][2] == board[1][1]:
			result = board[0][0]
		if board[0][2] == board[1][1] && board[1][1] == board[2][0]:
			result = board[1][1]
	
	return result
