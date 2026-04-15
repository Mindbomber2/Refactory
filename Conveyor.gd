extends Area2D

class_name Conveyor

var color_rect:ColorRect
var text_rect:TextureRect
var state:int
var direction:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect = get_node("ColorRect")
	text_rect = TextureRect.new()
	add_child(text_rect)
	direction = Vector2.ZERO
	color_rect.set_color(Color.DIM_GRAY)
	text_rect.set_visible(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			change_state()

func change_state():
	state=(state+1)%5
	if(state==0):
		direction=Vector2.ZERO
		color_rect.set_visible(true)
		text_rect.set_visible(false)
		print("Null")
	elif(state==1):
		direction=Vector2.RIGHT
		color_rect.set_visible(false)
		text_rect.set_visible(true)
		text_rect.texture = load("res://ConveyorRight.jpg")
		print("Right")
	elif (state==2):
		direction=Vector2.DOWN
		color_rect.set_visible(false)
		text_rect.set_visible(true)
		text_rect.texture = load("res://ConveyorDown.jpg")
		print("Down")
	elif (state==3):
		direction=Vector2.LEFT
		color_rect.set_visible(false)
		text_rect.set_visible(true)
		text_rect.texture = load("res://ConveyorLeft.jpg")
		print("Left")
	elif (state==4):
		direction=Vector2.UP
		color_rect.set_visible(false)
		text_rect.set_visible(true)
		text_rect.texture = load("res://ConveyorUp.jpg")
		print("Up")


func _on_body_entered(body: Node2D):
	if body is Product:
		print("Moving Product")
		print(body.product_name)
		print(body.position)
		body.setNewDirection(state)
		print("tile is:")
		print(position)
		print(state)
	else:
		print("Unknown Collision")


func _on_area_entered(area: Area2D):
	if area is Product:
		print("Moving Product")
		print(area.product_name)
		print(area.position)
		area.setNewDirection(state)
		print("tile is:")
		print(position)
		print(state)
	else:
		print("Unknown Collision")
