extends CanvasLayer


@onready var demons_left: Label = $Demons_left

signal demon_killed

func set_demon_label(num: int):
	demons_left.text = "Demons Left: "+str(num)
	
func update_demon_label():
	demons_left.emit()
