extends Area2D

class_name Product

var speed = 20
var product_name = "0"
var velocity = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity*speed*delta

func move(state):
	print("move called on")
	print(product_name)
	if state==0:
		velocity = Vector2.ZERO
	if state==1:
		velocity = Vector2.RIGHT
	if state==2:
		velocity = Vector2.DOWN
	if state==3:
		velocity = Vector2.LEFT
	if state==4:
		velocity = Vector2.UP
	
