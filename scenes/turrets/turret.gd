extends Node2D
class_name Turret

@onready var TURRET = $Top

@export var ROTATION_SPEED: float = 50


func _physics_process(delta):
	var enemy_pos = get_global_mouse_position()
	turn_to(enemy_pos, delta)
	pass


func turn_to(target_pos: Vector2, delta: float):
	var direction = target_pos - self.global_position
	var new_angle = direction.angle()
	TURRET.rotation = lerp_angle(TURRET.rotation, new_angle, delta * ROTATION_SPEED)
	#var tween = get_tree().create_tween()
	#tween.tween_property(TURRET, "rotation", new_angle, 1)
	#TURRET.rotation = new_angle
