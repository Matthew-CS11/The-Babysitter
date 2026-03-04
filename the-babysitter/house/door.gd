extends Area3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bank = get_tree().get_first_node_in_group("money")

@export var cost_to_open: int = 2500

var player_in_area: Player = null
var door_open := false

func _process(_delta: float) -> void:
	if player_in_area == null:
		return
	if Input.is_action_just_pressed("interact"):
		if player_in_area and bank.cash >= cost_to_open:
			toggle_door()
		else:
			print("no money")

func toggle_door() -> void:
	door_open = !door_open
	if door_open:
		animation_player.play("open_door")
	else:
		animation_player.play("close_door")

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		player_in_area = body


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		player_in_area = null
