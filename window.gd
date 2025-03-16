class_name ProgramWindow extends Node2D

var mouse_inside:WindowArea = null; 
@export var selected_area:WindowArea;
var mouse_locked:bool = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_children())
	for i in get_children():
		if (i is WindowArea):
			i.mouse_entered.connect(set_mouse_inside.bind(i))
			i.mouse_exited.connect(unset_mouse_inside.bind(i))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_working_area_mouse_entered():
	mouse_inside = $WorkingArea
	pass 

func _input(event):
	if event is InputEventMouse:
		if event is InputEventMouseButton:
			if event.is_pressed():
				mouse_locked = true
			if !event.is_pressed():
				mouse_locked = false
		if mouse_inside != null:
			mouse_inside.do(event)
	if event is InputEventKey:
		selected_area.do(event)

func set_mouse_inside(target:WindowArea):
	print("here inside")
	if !mouse_locked:
		mouse_inside = target

func unset_mouse_inside(target:WindowArea):
	if mouse_inside == target and !mouse_locked:
		mouse_inside = null
