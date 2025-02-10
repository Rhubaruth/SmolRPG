extends Control
class_name MainMenu

@onready var startButton = $Margin/Buttons/NewGameButton
@onready var quitButton = $Margin/Buttons/QuitButton


func _ready():
	var sceneHandler: SceneHandler = get_tree().get_first_node_in_group("SceneHandler")
	startButton.pressed.connect(sceneHandler.start_new_game)
	quitButton.pressed.connect(sceneHandler.quit_game)
