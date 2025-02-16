extends GunComponent

@onready var Anim = $Anim


func _shoot_enemy(enemy: Enemy):
	Anim.play("MuzzleFlash")
	enemy.HEALTH_COMPONENT.take_dmg(DAMAGE)
