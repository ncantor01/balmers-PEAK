class_name PC_asset extends InteractableParent

func interact(player:CharacterBody3D):
	print("here")
	player.enter_pc()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_content():
	return $SubViewportContainer/SubViewport/Window
