extends GunComponent

@export var MissileProjectile: PackedScene
@onready var M1 = $Top/M1

func _shoot_enemy(enemy: Enemy):
	#push_error(self.name, " Function Shoot(Enemy) not implemented")
	var missile: Projectile = MissileProjectile.instantiate()
	missile.position = M1.position
	missile.target = enemy
	missile.look_at(enemy.global_position)
	missile.DAMAGE = DAMAGE
	add_child(missile)
	move_child(missile, 0)
