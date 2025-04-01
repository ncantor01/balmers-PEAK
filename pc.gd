class_name PC_asset extends InteractableParent

@export var WindowDisplayer:SubViewport

func interact(player:CharacterBody3D):
	print("here")
	player.enter_pc()

func uninteract(player:CharacterBody3D):
	print("here2")
	set_new_displayed_window(player.get_current_pc())
	player.exit_pc()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_content():
	return $SubViewportContainer/SubViewport/Window

func set_new_displayed_window(window:ProgramWindow):
	print("Flushing Display")
	if WindowDisplayer.get_child_count() > 0:
		for i in WindowDisplayer.get_children():
			WindowDisplayer.remove_child(i)
			i.queue_free()
	var copy:ProgramWindow = window.duplicate()
	copy.visible=true
	WindowDisplayer.add_child(copy)
	
