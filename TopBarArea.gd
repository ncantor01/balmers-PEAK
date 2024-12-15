class_name TopBarArea extends WindowArea

const SPEED:int = 50

var is_moving:bool = false;
var past_mouse_pos:Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func do(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			is_moving = true
			print("FREE ME FROM THESE CHAINS")
		if !event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			is_moving = false
	if event is InputEventMouseMotion:
		print("MOUSE MOTION")
		if is_moving == true:
			get_parent().global_position += event.relative
	pass	
