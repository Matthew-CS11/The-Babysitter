extends CharacterBody3D
class_name Enemy

@export var max_health := 50
@export var money := 50

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: Player = $"../player"
@onready var animation_player: AnimationPlayer = $demon/AnimationPlayer
@onready var bank = get_tree().get_first_node_in_group("money")
@onready var win_screen = get_tree().get_first_node_in_group("win")


var agro :float = false
var health : int


signal killed

func _ready() -> void:
	health = max_health
	
func take_damage(amt: int) -> void:
	health -= amt
	if health <= 0:
		killed.emit()
		bank.demons_killed +=1
		win_screen.set_tracker_label(bank.demons_killed)
		bank.cash += money
		queue_free()

func _process(_delta: float) -> void:
	navigation_agent_3d.set_target_position(player.global_position)


func _physics_process(_delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var direction = (destination - global_position).normalized()
	
	
	velocity = direction * 5.0
	animation_player.play("Demon|Run1")
	
	move_and_slide()

#func _on_agression_radius_body_entered(body: Node3D) -> void:
	#if "player" in body.get_groups():
		#agro = true
	
