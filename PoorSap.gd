class_name Player extends CharacterBody3D

@export_range(1, 35, 1) var speed: float = 10 # m/s
@export_range(10, 400, 1) var acceleration: float = 100 # m/s^2

@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1

var jumping: bool = false
var mouse_captured: bool = false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var move_dir: Vector2 # Input direction for movement
var look_dir: Vector2 # Input direction for look/aim

var walk_vel: Vector3 # Walking velocity 
var grav_vel: Vector3 # Gravity velocity 
var jump_vel: Vector3 # Jumping velocity

var interactable: Interactable = null
var current_2d_level : ProgramWindow = null
var current_3d_level : Level3D = null

var interactRay: RayCast3D

@onready var camera: Camera3D = $Camera

func _ready() -> void:
	interactRay = $Camera/InteractRay
	capture_mouse()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		if mouse_captured: _rotate_camera()
	elif event.is_action("interact"):
		print(interactable)
		if interactable != null:
			interactable.interact(self)
	elif event.is_action("uninteract"):
		print("uninteract")
		print(interactable)
		if interactable != null:
			interactable.uninteract(self)
	if Input.is_action_just_pressed(&"exit"): get_tree().quit()

func _physics_process(delta: float) -> void:
	if interactRay.get_collider() is Interactable:
		interactable = interactRay.get_collider()
	if Input.is_action_just_pressed(&"jump"): jumping = true
	velocity = _walk(delta) + _gravity(delta)
	move_and_slide()

func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _rotate_camera(sens_mod: float = 1.0) -> void:
	camera.rotation.y -= look_dir.x * camera_sens * sens_mod
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)

func _walk(delta: float) -> Vector3:
	move_dir = Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backwards")
	var _forward: Vector3 = camera.global_transform.basis * Vector3(move_dir.x, 0, move_dir.y)
	var walk_dir: Vector3 = Vector3(_forward.x, 0, _forward.z).normalized()
	walk_vel = walk_vel.move_toward(walk_dir * speed * move_dir.length(), acceleration * delta)
	return walk_vel

func _gravity(delta: float) -> Vector3:
	grav_vel = Vector3.ZERO if is_on_floor() else grav_vel.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta)
	return grav_vel

func enter_pc():
	print("EnteringPC")
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	if current_2d_level != null and current_3d_level != null:
		current_2d_level.visible = true
		current_3d_level.visible = false

func exit_pc():
	print("ExitingPC")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if current_2d_level != null and current_3d_level != null:
		current_2d_level.visible = false
		current_3d_level.visible = true
	

func set_current_pc(pc:ProgramWindow):
	current_2d_level = pc

func get_current_pc():
	return current_2d_level
	
func set_current_3d_level(level:Level3D):
	current_3d_level = level
	
