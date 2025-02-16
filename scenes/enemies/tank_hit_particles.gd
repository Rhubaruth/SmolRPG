extends GPUParticles2D

@export var SPAWN_RECT: Rect2

func _ready():
	emitting = true
	await self.finished
	queue_free()
