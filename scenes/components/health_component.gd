extends Node
class_name HealthComponent

@export var MAX_HEALTH: int = 30
@onready var health: float = float(self.MAX_HEALTH)

signal on_hit
signal on_hp_zero

func take_dmg(amount: float, dmg_type: Types.DAMAGE = Types.DAMAGE.BULLET):
	health -= amount
	on_hit.emit()
	print(health)
	if health <= 0: 
		on_hp_zero.emit()
