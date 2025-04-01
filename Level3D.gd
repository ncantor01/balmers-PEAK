class_name Level3D extends Node3D

@export var player:CharacterBody3D = null
@export var PC_level:ProgramWindow = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent() is Level:
		PC_level = get_parent().get_pc_level()
	if player != null and PC_level != null:
		player.set_current_pc(PC_level)
		player.set_current_3d_level(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
