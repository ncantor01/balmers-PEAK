class_name TerminalArea extends WindowArea

@export var newline_position:Vector2 = Vector2.ZERO;
@export var font_size = 12;
@export var font:Font = SystemFont.new();
var current_line:RichTextLabel;
var all_lines:Array[RichTextLabel];
var shape:RectangleShape2D;
var buffer:String = "";

# Called when the node enters the scene tree for the first time.
func _ready():
	shape = $Shape.shape
	create_newline()
	current_line.add_text('> ')
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func do(event:InputEvent):
	if event is InputEventKey:
		if event.is_pressed():
			if event.is_action_pressed("ui_text_newline", true):
				print(create_newline())
				current_line.add_text('> ')
			elif event.is_action_pressed("ui_text_delete", true) or event.is_action_pressed("ui_text_backspace", true):
				print (current_line.get_parsed_text())
				var new_text = current_line.get_parsed_text().erase(current_line.get_parsed_text().length() - 1, 1)
				current_line.clear()
				prepare_font(current_line)
				current_line.add_text(new_text)
			elif event.ctrl_pressed:
				print("CTRL COMMAND")
			else:
				current_line.add_text(fix_punctuation(event))

func prepare_font(newline:RichTextLabel) -> void:
	pass
	#newline.push_font_size(font_size)
	
func create_newline() -> String:
	var command = ""
	if current_line != null:
		command = current_line.text
	var newline:RichTextLabel = RichTextLabel.new()
	add_child(newline)
	#Basic properties
	newline.visible = true
	newline.position = newline_position
	newline.selection_enabled = true 
	newline.scroll_active = false
	newline.size = shape.size
	newline.autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	prepare_font(newline)
	
	var newline_adjust = font_size
	if current_line != null:
		var textLine:TextLine = TextLine.new()
		textLine.add_string(current_line.get_parsed_text(), font, font_size)
		newline_adjust = (int(ceil(textLine.get_size().x / shape.size.x))) * textLine.get_size().y
	
	if newline_position.y >= shape.size.y:
		#Move up the line at the top and make it invisible
		for i in all_lines:
			i.position.y -= newline_adjust
		all_lines[0].visible = false
		all_lines.remove_at(0)
	else:
		newline_position += Vector2(0,newline_adjust)
	current_line = newline
	all_lines.append(newline)
	return command

func type_in_terminal(x:InputEventKey):
	pass
	

func fix_punctuation(x:InputEventKey) -> String:
	var keycode = x.keycode
	if !x.shift_pressed:
		match keycode:
			KEY_COMMA:
				return ','
			KEY_PERIOD:
				return '.'
			KEY_SLASH:
				return '/'
			KEY_SEMICOLON:
				return ';'
			KEY_APOSTROPHE:
				return '\''
			KEY_BRACKETLEFT:
				return '['
			KEY_BRACKETRIGHT:
				return ']'
			KEY_BACKSLASH:
				return '\\'
			KEY_MINUS:
				return '-'
			KEY_EQUAL:
				return '='
			KEY_QUOTELEFT:
				return '`'
			KEY_TAB:
				return '\t'
			KEY_SPACE:
				return ' '
			KEY_ALT, KEY_CAPSLOCK, KEY_SHIFT, KEY_CTRL:
				return ''
			KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7, KEY_F8, KEY_F9, KEY_F10:
				return ''
			_:
				return x.as_text_key_label().to_lower()
	if x.shift_pressed:
		match keycode:
			KEY_COMMA:
				return '<'
			KEY_PERIOD:
				return '>'
			KEY_SLASH:
				return '?'
			KEY_SEMICOLON:
				return ':'
			KEY_APOSTROPHE:
				return '"'
			KEY_BRACKETLEFT:
				return '{'
			KEY_BRACKETRIGHT:
				return '}'
			KEY_BACKSLASH:
				return '|'
			KEY_MINUS:
				return '_'
			KEY_EQUAL:
				return '+'
			KEY_QUOTELEFT:
				return '~'
			KEY_TAB:
				return '\t'
			KEY_SPACE:
				return ' '
			KEY_ALT, KEY_CAPSLOCK, KEY_SHIFT, KEY_CTRL:
				return ''
			KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7, KEY_F8, KEY_F9, KEY_F10:
				return ''
			_:
				return String.chr(keycode)
	return ""
	
