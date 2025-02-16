extends VBoxContainer
class_name BuildButton

@export var stats: TurretShopStats

@onready var Icon := $Button/Icon
@onready var CostLabel = $Label

signal on_choose_turret

# Called when the node enters the scene tree for the first time.
func _ready():
	if stats == null: 
		return
	
	Icon.texture = load(stats.SHOP_ICON_PATH)
	CostLabel.text = str(stats.COST)


func _on_button_pressed():
	on_choose_turret.emit()
	pass # Replace with function body.
