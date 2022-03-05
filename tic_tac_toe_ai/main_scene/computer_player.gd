extends Control

	
func make_move(board : Array) -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	
	#board with tatus values only
	var test_board = copy_board(board)
	
	var best_score = -10000
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
				test_board[i][j] = -1
				if score > best_score:
					best_score = score
					move_coordinates.x = i
					move_coordinates.y = j
	
	
	#make move
	board[move_coordinates.x][move_coordinates.y]._on_button_pressed_up()


func minimax(board : Array, depth, is_max) -> int:
	var result = check_win(board)
	if result != -1 : # => someone won
		#print("won " , result, "   ", board)
		return count_score(result)
	
	if is_max : #calculating computer best move
		var best_score = -100000
		
		for i in range(3):
			for j in range(3):
				if board[i][j] == -1: #if avaiable
					board[i][j] = 0 #computer ai move
					var score = minimax(board, depth + 1, false)
					board[i][j] = -1
					if score > best_score :
						best_score = score
		
		return best_score
	
	else : #calculating worst senario for human
		var worst_score = 10000
		
		for i in range(3):
			for j in range(3):
				if board[i][j] == -1: #if avaiable
					board[i][j] = 1 #human move
					var score = minimax(board, depth + 1, true)
					board[i][j] = -1
					if score < worst_score :
						worst_score = score
		
		return worst_score


func count_score(result : int) -> int :
	match result:
		1: # x won
			return -10
		0: # o won
			return 10
	return 0


func copy_board(board : Array) -> Array :
	var copied_board : Array = board.duplicate(true)
	for i in range(3):
		for j in range(3):
			copied_board[i][j] = board[i][j].status
			
	return copied_board


#return -1, 0 or 1 (none, o, x), 2 if TIE
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
	
	# check if TIE
	if result == -1:
		var count_avaiable = 0
		for row in board:
			for r in row:
				if r == -1:
					count_avaiable += 1
		if count_avaiable == 0:
			result = 2
	
	
	return result
