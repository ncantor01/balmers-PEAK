class_name Level extends Node

@export var PC_level:ProgramWindow
@export var Office_level:Level3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var all_children = get_all_children(self)
	for n in all_children:
		if n is PC_asset:
			n.set_new_displayed_window(PC_level)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_pc_level():
	return PC_level

func get_all_children(node):	
	var nodes : Array = []
	for N in node.get_children():
		if N.get_child_count() > 0:
			nodes.append(N)
			nodes.append_array(get_all_children(N))
		else:
			nodes.append(N)
	return nodes
