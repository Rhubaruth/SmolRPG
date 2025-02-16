extends Node2D
class_name Turret

@onready var RANGE_AREA: Area2D = $Range
@export var GUN_COMPONENT: GunComponent
@onready var ray: RayCast2D = $RayCast2D
@export var stats: TurretStats

var DAMAGE: int
var DAMAGE_TYPE: Types.DAMAGE
var FIRE_DELAY: float
var ROTATION_SPEED: int
var RANGE: float

var enemies_in_range = []

func _ready():
	if stats != null:
		GUN_COMPONENT.load_stats(stats)
		
		RANGE = stats.RANGE
		RANGE_AREA.get_node("CollisionShape2D").get_shape().radius = RANGE


func _physics_process(delta):
	if not enemies_in_range:
		return
	var enemy := select_enemy(enemies_in_range)
	if enemy:
		GUN_COMPONENT.turn_to_enemy(enemy, delta)
		GUN_COMPONENT.shoot_enemy(enemy)


func sort_furthest(a: Enemy, b: Enemy) -> bool:
	return a.progress_ratio >= b.progress_ratio


func select_enemy(enemies: Array) -> Enemy:
	enemies.sort_custom(sort_furthest)
	for e in enemies:
		var dir = e.global_position - global_position
		ray.set_target_position(dir)
		ray.force_raycast_update()
		var coll = ray.get_collider()
		if coll == null:
			return e
	return null


func _on_range_entered(area: Area2D):
	var parent: Enemy = area.get_parent()
	self.enemies_in_range.append(parent)


func _on_range_exited(area: Area2D):
	var parent: Enemy = area.get_parent()
	if parent not in enemies_in_range:
		return
	self.enemies_in_range.erase(parent)
	
