class_name Level extends Node3D

@export var player:CharacterBody3D = null
@export var PC_level:ProgramWindow = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if player != null and PC_level != null:
		player.set_current_pc(PC_level)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
