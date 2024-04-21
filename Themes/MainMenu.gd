extends Control

var seconds
var minutes
@onready var timerLabel = %timerLabel
func _ready():
	Global.gameState = "MainMenu"
	%MainScreen.visible = true
	%TimerScreen.visible = true

func _process(_delta):
	#LET THE CURSOR NOT CHANGE IF THE BOOK IS OPEN:
	if %GuideBook.frame == 0:
		#HIDE CONTENTS OF PAGES
		%Controls.visible = false
		%Weapons.visible = false
		%Credits.visible = false
		#END OF HIDE
		#SHOW THE SHADOW WHEN THE BOOK IS CLOSED
		%BookShadow.visible = true
		#END OF SHOW
		
		%MouseBlocker.visible = false
		%MouseBlocker.z_index = 15
		%CloseBook.visible = false
		%CloseBook.disabled = true
		%PageTitle.text = ""
		
		
		%GuideBook.get_child(3).mouse_default_cursor_shape = Control.CURSOR_HELP
	else:
		%BookShadow.visible = false
		%MouseBlocker.visible = true
		%MouseBlocker.z_index = 1
		%CloseBook.visible = true
		%CloseBook.disabled = false
		match %GuideBook.frame:
			1:
				%PageTitle.text = "CONTROLS"
				%Controls.visible = true
				%Weapons.visible = false
				%Credits.visible = false
			2:
				%Controls.visible = false
				%Weapons.visible = true
				%Credits.visible = false
				%PageTitle.text = "WEAPONS"
			3:
				%Controls.visible = false
				%Weapons.visible = false
				%Credits.visible = true
				%PageTitle.text = "CREDITS"
		%GuideBook.get_child(3).mouse_default_cursor_shape = Control.CURSOR_ARROW
		
	
	if Input.is_action_just_pressed("moveLeft0"): #keyboard change skin player 1
		_on_player_one_previous_pressed()
	if Input.is_action_just_pressed("moveRight0"):  #keyboard change skin player 1
		_on_player_one_next_pressed()
	#print(skins[playerOneTexture])
	
	if Input.is_action_just_pressed("moveLeft1"):
		_on_player_two_previous_pressed()
	if Input.is_action_just_pressed("moveRight1"):
		_on_player_two_next_pressed()
		
	if Input.is_action_just_pressed("jump0") or Input.is_action_pressed("jump1"):
		_on_start_mouse_entered()
		_on_start_button_down()
	
	if Input.is_action_just_released("jump0") or Input.is_action_just_released("jump1"):
		_on_start_mouse_exited()
		_on_start_button_up()
		_on_start_pressed()
	
	updateTimerScreen()
	

func updateTimerScreen():
	seconds = int(Global.matchTime)
	if seconds >= 60:
		minutes = int(seconds / 60.00)
		seconds -= minutes * 60
	else:
		minutes = 0
		
	if seconds < 10:
		if minutes < 10:
			#print("0", minutes, ":0", seconds)
			timerLabel.text = "0" + str(minutes) + ":0" + str(seconds)
		else:
			#print(minutes, ":0", seconds)
			timerLabel.text = str(minutes) + ":0" + str(seconds)
	else:
		if minutes < 10:
			#print("0", minutes, ":", seconds)
			timerLabel.text = "0" + str(minutes) + ":" + str(seconds)
		else:
			#print(minutes, ":", seconds)
			timerLabel.text = str(minutes) + ":" + str(seconds)

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Test World/main.tscn")

func _on_quit_pressed():
	get_tree().quit()

#PLAYERR ONE SKIN CHANGER

func _on_player_one_next_pressed():
	if Global.playerOneTexture != 5:
		Global.playerOneTexture += 1
	else:
		Global.playerOneTexture = 0
	%Player1.set_texture(load("res://" + Global.skins[Global.playerOneTexture]+ ".png"))
	#print(skins[playerOneTexture])


func _on_player_one_previous_pressed():
	if Global.playerOneTexture != 0:
		Global.playerOneTexture -= 1
	else:
		Global.playerOneTexture = 5
	%Player1.set_texture(load("res://" + Global.skins[Global.playerOneTexture]+ ".png"))
	#print(skins[playerOneTexture])

#PLAYERR TWO SKIN CHANGER
func _on_player_two_previous_pressed():
	if Global.playerTwoTexture != 0:
		Global.playerTwoTexture -= 1
	else:
		Global.playerTwoTexture = 5
	%Player2.set_texture(load("res://" + Global.skins[Global.playerTwoTexture]+ ".png"))

func _on_player_two_next_pressed():
	if Global.playerTwoTexture != 5:
		Global.playerTwoTexture += 1
	else:
		Global.playerTwoTexture = 0
	%Player2.set_texture(load("res://" + Global.skins[Global.playerTwoTexture]+ ".png"))	

#-----------------------------------------
#QUIT BUTTON------------------------------

func _on_quit_button_down():
	%QUIT.frame = 1


func _on_quit_button_up():
	%QUIT.frame = 0


func _on_quit_mouse_entered():
	%QUIT.modulate = Color("d4d4d4")


func _on_quit_mouse_exited():
	%QUIT.modulate = Color.WHITE
#------------------------------------------
#START BUTTON------------------------------

func _on_start_mouse_entered():
	%START.modulate = Color("d4d4d4")


func _on_start_button_down():
	%START.frame = 1


func _on_start_button_up():
	%START.frame = 0


func _on_start_mouse_exited():
	%START.modulate = Color.WHITE
#------------------------------------------------
#GUIDE BOOK BUTTONS------------------------------

func _on_open_book_mouse_entered():
	if %GuideBook.frame == 0:
		%GuideBook.modulate = Color("d3d3d3")

func _on_open_book_mouse_exited():
	%GuideBook.modulate = Color.WHITE


func _on_open_book_pressed():
	if %GuideBook.frame == 0:

		%GuideBook.frame = 1
		%GuideBook.position = Vector2(960, 540)
		%GuideBook.z_index = 12
		%GuideBook.scale *= 2 
	
func _on_page_1_pressed():
	%GuideBook.frame = 1


func _on_page_2_pressed():
	%GuideBook.frame = 2


func _on_page_3_pressed():
	%GuideBook.frame = 3



#RETURNING THE BOOK WHEN CLOSED:

func _on_close_book_pressed():
	%GuideBook.frame = 0
	%GuideBook.position = Vector2(212, 829)
	%GuideBook.z_index = 0
	%GuideBook.scale = Vector2(4,4)

#----TIMER BUTTONS----
func _on_increase_pressed():
	Global.matchTime += 10


func _on_decrease_pressed():
	if Global.matchTime != 10:
		Global.matchTime -= 10


func _on_increase_button_down():
	%Increase.get_child(0).frame = 1
func _on_increase_button_up():
	%Increase.get_child(0).frame = 0


func _on_decrease_button_down():
	%Decrease.get_child(0).frame = 1


func _on_decrease_button_up():
	%Decrease.get_child(0).frame = 0
