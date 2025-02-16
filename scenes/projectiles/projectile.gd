extends Area2D
class_name Projectile

const SPEED = 250.0
var target: Enemy
var DAMAGE = 0

@onready var ExplosionArea: Area2D = $Area2D
@onready var Sprite: Sprite2D = $Bullet1
var is_exploding: bool = false

func _physics_process(delta):
	if is_exploding:
		return
	if target == null:
		queue_free()
		return
	
	look_at(target.global_position)
	var velocity = SPEED * Vector2.from_angle(self.rotation)
	position += velocity * delta

func explode():
	is_exploding = true
	Sprite.visible = false
	
	var areas = ExplosionArea.get_overlapping_areas()
	print(areas)
	if areas:
		for a in areas:
			var enemy: Enemy = a.get_parent()
			if not enemy.has_method("get_hit"):
				continue
			enemy.HEALTH_COMPONENT.take_dmg(DAMAGE, Types.DAMAGE.EXPLOSION)
		await get_tree().create_timer(0.3).timeout
		pass
	queue_free()


func _on_body_entered(body):
	explode()


func _on_area_entered(area):
	explode()
