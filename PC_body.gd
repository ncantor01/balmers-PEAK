class_name PC_body extends Interactable

func interact(player:CharacterBody3D):
	print(get_parent())
	if get_parent() is InteractableParent:
		get_parent().interact(player)
		
func uninteract(player:CharacterBody3D):
	if get_parent() is InteractableParent:
		get_parent().uninteract(player)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
