extends Node2D
class_name GunComponent

@onready var Sprite: Sprite2D = $Top
var DAMAGE: int
var DAMAGE_TYPE: Types.DAMAGE
var FIRE_DELAY: float
var RANGE: float

var is_reloading: bool = false

signal on_shoot


func load_stats(stats: TurretStats):
	DAMAGE = stats.DAMAGE
	DAMAGE_TYPE = stats.DAMAGE_TYPE
	FIRE_DELAY = stats.FIRE_DELAY
	
	Sprite.texture = load(stats.SPRITE_PATH)


func turn_to_enemy(enemy: Enemy, _delta: float):
	Sprite.look_at(enemy.global_position)
	pass 


func shoot_enemy(enemy: Enemy):
	if self.is_reloading:
		return
	
	self.is_reloading = true
	self._shoot_enemy(enemy)
	await get_tree().create_timer(FIRE_DELAY).timeout
	is_reloading = false

func _shoot_enemy(enemy: Enemy):
	push_error(self.name, " Function Shoot(Enemy) not implemented")
