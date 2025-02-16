extends PathFollow2D
class_name Enemy

@onready var HEALTH_COMPONENT: HealthComponent = $HealthComponent
@onready var HURTBOX: Area2D = $Hurtbox
@export var SPEED: float = 200

@onready var HIT_PARTICLES = preload("res://scenes/enemies/hit_particles.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	pass


func move(delta):
	progress += SPEED * delta
	pass

func get_hit():
	var particles = HIT_PARTICLES.instantiate()
	var x = randi_range(-8, 8)
	var y = randi_range(-8, 8)
	particles.global_position = global_position + Vector2(x, y)
	get_parent().add_child(particles)
	pass

func die():
	self.process_mode = Node.PROCESS_MODE_DISABLED
	HURTBOX.queue_free()
	await get_tree().create_timer(0.2).timeout
	queue_free()


func _on_screen_exited():
	# TODO damage player
	self.queue_free()
	pass # Replace with function body.


func _on_hit():
	get_hit()
	pass # Replace with function body.


func _on_hp_zero():
	die()
	pass
