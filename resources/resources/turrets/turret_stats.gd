extends Resource
class_name TurretStats


@export_file("*.png") var SPRITE_PATH: String = ""

@export var DAMAGE: int = 10
@export var DAMAGE_TYPE: Types.DAMAGE = Types.DAMAGE.BULLET
@export var FIRE_DELAY: float = 1 
@export var ROTATION_SPEED: int = 50
@export var RANGE: float = 3.5*64  # Range for 3 tiles
