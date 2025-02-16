extends Node2D

@onready var ui: UserInterface = $UI
@onready var spawner: EnemySpawner = $Spawner
@export var map_node: MapNode

var in_build_mode: bool
var build_valid: bool
var build_location: Vector2
var turret_scene


func _ready():
	for node in get_tree().get_nodes_in_group("BuildButton"):
		if node is BuildButton:
			var loaded_scene = load(node.stats.TURRET_SCENE)
			node.on_choose_turret.connect(initiate_build_mode.bind(loaded_scene))
	
	ui.on_user_start_wave.connect(user_starts_wave)
	

func _process(_delta):
	if in_build_mode:
		update_tower_preview()
	pass

#region Tower Build mode
func _unhandled_input(event):
	if (event.is_action_released("ui_cancel") 
			and in_build_mode):
		cancel_build_mode()
	elif (event.is_action_released("ui_accept")
			and in_build_mode 
			and build_valid):
		verify_and_build()
		cancel_build_mode()


func initiate_build_mode(turret):
	if in_build_mode:
		cancel_build_mode()
	self.turret_scene = turret
	in_build_mode = true
	ui.set_tower_preview(turret, get_global_mouse_position())
	pass


func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var curret_tile_coords = map_node.global_to_coords(mouse_position)
	var curret_tile_pos = map_node.coords_to_global(curret_tile_coords)
	
	build_location = curret_tile_pos
	build_valid = map_node.is_tile_empty(curret_tile_coords)
	ui.update_tower_preview(build_location, build_valid)


func cancel_build_mode():
	in_build_mode = false
	build_location = Vector2.ZERO
	turret_scene = null
	build_valid = false
	ui.disable_preview()
	

func verify_and_build():
	if not build_valid:
		return
	
	var new_tower: Turret = turret_scene.instantiate()
	new_tower.position = build_location
	map_node.add_new_turret(new_tower)
	pass
#endregion

func user_starts_wave():
	spawner.start_next_wave()
	ui.set_play_disabled(true)
	pass

func _on_spawner_wave_end():
	ui.set_play_disabled(false)
	pass # Replace with function body.
