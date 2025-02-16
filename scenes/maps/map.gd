extends Node2D
class_name MapNode

@export var towerExclusion: TileMapLayer
@onready var turrets: Node2D = $Turrets
const TRANSPARENT_TILE_ID: int = 0

func add_new_turret(new_turret: Turret):
	turrets.add_child(new_turret)
	new_turret.RANGE_AREA.monitoring = true
	new_turret.process_mode = Node.PROCESS_MODE_INHERIT
	
	var coords = towerExclusion.local_to_map(new_turret.position)
	towerExclusion.set_cell(coords, TRANSPARENT_TILE_ID, Vector2i.ZERO)
	towerExclusion.update_internals()


func global_to_coords(global_pos: Vector2):
	var local_pos = to_local(global_pos)
	var tile_coords: Vector2i = towerExclusion.local_to_map(local_pos)
	return tile_coords

func coords_to_global(coords: Vector2i):
	var local_pos: Vector2 = towerExclusion.map_to_local(coords)
	return to_global(local_pos)

func is_tile_empty(coords: Vector2i):
	var cell_id = towerExclusion.get_cell_source_id(coords)
	return cell_id == -1
