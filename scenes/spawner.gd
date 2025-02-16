extends Node
class_name EnemySpawner

var current_wave = 0
var enemies_left = 0

var BLUE_TANK = preload("res://scenes/enemies/blue_tank.tscn")
var Path: Path2D

signal wave_end

func _ready():
	Path = get_tree().get_first_node_in_group("EnemyPath")


func start_next_wave():
	current_wave += 1
	var wave_data = get_wave_data(current_wave)
	enemies_left = len(wave_data)
	await get_tree().create_timer(0.05).timeout
	spawn_enemies(wave_data)

func get_wave_data(_wave: int):
	return [
		[BLUE_TANK, 0.2], 
		[BLUE_TANK, 0.2],
		[BLUE_TANK, 0.2],
		[BLUE_TANK, 0.2],
		[BLUE_TANK, 1.0],
		[BLUE_TANK, 0.4],
		[BLUE_TANK, 0.4],
		[BLUE_TANK, 0.4],
		]

func spawn_enemies(wave):
	for i in wave:
		var new_enemy: Enemy = i[0].instantiate()
		Path.add_child(new_enemy)
		new_enemy.tree_exited.connect(enemy_died.bind(new_enemy))
		await get_tree().create_timer(i[1]).timeout


func end_wave():
	pass


func enemy_died(_enemy: Enemy):
	enemies_left -= 1
	
	if enemies_left == 0:
		wave_end.emit()
		pass
	pass
