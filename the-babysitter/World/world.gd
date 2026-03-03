extends NavigationRegion3D

@onready var background_music: AudioStreamPlayer = $background_music
@onready var player: Player = $player
@onready var win_screen: Control = $Win_screen
@onready var ui: UI = $UI
@onready var cross: CanvasLayer = $cross

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_music.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_win_area_body_entered(body: Node3D) -> void:
	if body is Player:
		win()

func win():
	if win_screen:
		win_screen.visible = true
		win_screen.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if cross:
			cross.visible = false
		if ui:
			ui.visible = false
	else:
		get_tree().change_scene_to_file("res://UI/win_screen.tscn")
