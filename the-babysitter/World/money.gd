extends MarginContainer

@export var starting_cash := 100
@onready var label: Label = $Label

var gold :int:
	set(gld):
		gold = max(0, gld)
		label.text = str(gold)
		
func _ready() -> void:
	gold = starting_cash
