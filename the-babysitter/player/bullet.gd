extends Area3D


@export var speed := 30.0
var direction: Vector3 = Vector3.ZERO
	
func _physics_process(delta: float) -> void:
	if direction == Vector3.ZERO:
		return
	global_position += direction * speed * delta

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("damage_area"):
		var enemy = area.get_parent()
		print("meow")
		if enemy and enemy.has_method("take_damage"):
			enemy.take_damage(25)
		queue_free()
		return
