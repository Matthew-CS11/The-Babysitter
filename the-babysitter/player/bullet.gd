extends Node3D

@export var speed := 80.0
@export var lifetime := 0.12
@export var pitch_offset_degrees := 90.0

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	await get_tree().create_timer(lifetime).timeout
	queue_free()
	
func _process(delta: float) -> void:
	if direction == Vector3.ZERO:
		return
		
	global_position += direction * speed * delta
	
	var aim_basis = Basis.looking_at(direction.normalized(), Vector3.UP)
	var offset_basis = Basis.from_euler(Vector3(deg_to_rad(pitch_offset_degrees), 0.0, 0.0))
	
	global_transform.basis = aim_basis * offset_basis
