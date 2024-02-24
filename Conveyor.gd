extends Area2D

class_name Conveyor

var color_rect:ColorRect
var state:int
var direction:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	color_rect = get_node("ColorRect")
	direction = Vector2.ZERO
	color_rect.set_color(Color.PURPLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			change_state()

func change_state():
	state=(state+1)%3
	if(state==0):
		direction=Vector2.ZERO
		color_rect.set_color(Color.PURPLE)
		print("Null")
	elif(state==1):
		direction=Vector2.RIGHT
		color_rect.set_color(Color.BLUE)
		print("Right")
	elif (state==2):
		direction=Vector2.DOWN
		color_rect.set_color(Color.RED)
		print("Down")


func _on_body_entered(body: Node2D):
	if body is Product:
		print("Moving Product")
		print(body.product_name)
		body.move(state)
	else:
		print("Unknown Collision")


func _on_area_entered(area: Area2D):
	if area is Product:
		print("Moving Product")
		print(area.product_name)
		area.move(state)
	else:
		print("Unknown Collision")
