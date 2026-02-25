extends Area3D

var direction := Vector3.MODEL_FRONT# + Vector3.MODEL_TOP
var player : Player
var weapon
@export var speed := 30.0

func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("weapons")
	#direction = 

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy_area"):
		area.get_parent().health -= 25
		queue_free()
