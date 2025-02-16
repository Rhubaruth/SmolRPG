extends Node
class_name SceneHandler

var mainMenuScene = preload("res://scenes/ui/main_menu.tscn")
@export var mainMenu: MainMenu

func _ready():
	pass 


func start_new_game():
	#for child in get_children():
		#child.queue_free()
	if mainMenu:
		mainMenu.queue_free()
	var game_scene = load("res://scenes/game_scene.tscn").instantiate()
	add_child(game_scene)
	pass


func quit_game():
	get_tree().quit()
	pass
