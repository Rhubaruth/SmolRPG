extends CanvasLayer
class_name UserInterface

var towerPreview: Control
const VALID_COLOR := Color("64f38fdc")
const INVALID_COLOR := Color("ffaf9bdc")
var was_valid: bool

const RANGE_INDICATOR_SIZE := 600.0
var RANGE_INDICATOR_TEXTURE := preload("res://assets/ui/range_overlay.png")

signal on_user_start_wave
@export var PLAY_BUTTON: TextureButton
@export var FAST_BUTTON: TextureButton

func set_tower_preview(turret_scene, position: Vector2 = Vector2.ZERO):
	var drag_tower: Turret = turret_scene.instantiate()
	drag_tower.set_name("DragTower")
	
	towerPreview = Control.new()
	towerPreview.set_name("TowerPreview")
	towerPreview.add_child(drag_tower)
	towerPreview.position = position
	towerPreview.modulate = INVALID_COLOR
	was_valid = false
	
	var range_texture = Sprite2D.new()
	var scaling = 2 * drag_tower.stats.RANGE / RANGE_INDICATOR_SIZE
	range_texture.scale = Vector2(scaling, scaling)
	range_texture.texture = RANGE_INDICATOR_TEXTURE
	towerPreview.add_child(range_texture)
	
	add_child(towerPreview)

func update_tower_preview(position: Vector2, is_valid: bool):
	towerPreview.position = position
	if was_valid != is_valid:
		towerPreview.modulate = (
			VALID_COLOR if is_valid
			else INVALID_COLOR)
	was_valid = is_valid
	pass

func disable_preview():
	if towerPreview == null:
		return
	towerPreview.queue_free()


func _on_play_pressed():
	on_user_start_wave.emit()
	pass # Replace with function body.

func set_play_disabled(value: bool):
	PLAY_BUTTON.disabled = value
	pass

func _on_fast_toggled(toggled_on):
	Engine.time_scale = 2.0 if toggled_on else 1.0
	FAST_BUTTON.modulate = Color("ecd900") if not toggled_on else Color.WHITE
	
