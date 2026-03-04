extends MarginContainer

@export var starting_cash := 100
@onready var label: Label = $Label

var demons_killed : int = 0

		
var cash :int:
	set(csh):
		cash = max(0, csh)
		label.text = str(cash)
		
func _ready() -> void:
	cash = starting_cash
