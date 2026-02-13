extends CharacterBody3D
class_name Player

const SPEED = 10.0
const JUMP_VELOCITY = 4.5
const SPRINT_VELOCITY = 1.5
# Head bobbing intensity/speed
const BOB_WALK_SPEED = 14.0
const BOB_SPRINT_SPEED = 22.0
const BOB_INTENSITY = .5

@onready var neck: Node3D = $Neck
@onready var camera_3d: Camera3D = $Neck/Camera3D

var head_bob_vector = Vector2.ZERO
var head_bob_index = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * .01)
			camera_3d.rotate_x(-event.relative.y * .01)
			camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forawrd", "backward")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_VELOCITY * 2)
	var bob_speed = BOB_WALK_SPEED

	head_bob_index += bob_speed * delta
	
	var new_y = sin(head_bob_index) * BOB_INTENSITY
	var new_x = cos(head_bob_index * 0.5) * BOB_INTENSITY
		
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		camera_3d.position.y = lerp(camera_3d.position.y, camera_3d.position.y + new_y, 0.1)
		camera_3d.position.x = lerp(camera_3d.position.x, 0.0 + new_x, 0.1)
		
		#checking for sprint
		if Input.is_action_pressed("sprint"):
			velocity.z *= SPRINT_VELOCITY
			velocity.x *= SPRINT_VELOCITY
			#headbob
			bob_speed = BOB_SPRINT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		camera_3d.position.y = lerp(camera_3d.position.y, 0.0, 0.1)
		camera_3d.position.x = lerp(camera_3d.position.x, 0.0, 0.1)

	move_and_slide()
