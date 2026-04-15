extends Area2D

class_name Product

enum directions { ZERO=10, RIGHT=1, DOWN=2, LEFT=3, UP=4}
enum state {STRAIGHT, START_CURVE, IN_CURVE}

var speed = 32
var product_name = "0"
var velocity = Vector2.RIGHT
var t = 0.0

var currentDirection: directions = directions.RIGHT
var newDirection: directions = directions.RIGHT
var currentState: state = state.STRAIGHT

#interpolation start point 
var p0: Vector2
#interpolation middle point. a bit after the middle (think quarter circle)
var p1: Vector2
#interpolation end point
var p2: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t+=delta*0.5 
	move()

func move():
	if currentDirection!=newDirection:
		if(currentState==state.STRAIGHT):
			currentState=state.START_CURVE
		if currentState==state.START_CURVE:
			if((currentDirection-newDirection)%2==0):
				currentDirection=newDirection
				print("180 Turnaround")
				currentState=state.STRAIGHT
			else:
				calculateCurve(currentDirection, newDirection)
				print("Starting Curve")
				currentState=state.IN_CURVE
		elif currentState==state.IN_CURVE:
			if t<1.0:
				position = _quadratic_bezier(p0,p1,p2,t)
				print("Following curve:")
				print(position)
			else:
				print("Ending Curve")
				position = _quadratic_bezier(p0,p1,p2,1)
				t=0.0
				straightVelocity()
				currentDirection=newDirection
				currentState=state.STRAIGHT
	else:
		straightVelocity()
		position += velocity*speed*t
		t=0.0
		

func calculateCurve(oldDir: directions, newDir: directions):
	p0 = position
	if oldDir==directions.RIGHT:
		if newDir==directions.UP:
			p2=Vector2(p0.x+32,p0.y-32)
			p1=Vector2(p0.x+32,p0.y)
			print("Curve Right->Up")
			print(p0)
			print(p1)
			print(p2)
		else:
			p2=Vector2(p0.x+32,p0.y+32)
			p1=Vector2(p0.x+32,p0.y)
			print("Curve Right->Down")
			print(p0)
			print(p1)
			print(p2)
	elif oldDir==directions.LEFT:
		if newDir==directions.UP:
			p2=Vector2(p0.x-32,p0.y-32)
			p1=Vector2(p0.x-32,p0.y)
			print("Curve Right->Up")
			print(p0)
			print(p1)
			print(p2)
		else:
			p2=Vector2(p0.x-32,p0.y+32)
			p1=Vector2(p0.x-32,p0.y)
			print("Curve Right->Down")
			print(p0)
			print(p1)
			print(p2)
	elif oldDir==directions.DOWN:
		if newDir==directions.RIGHT:
			p2=Vector2(p0.x+32,p0.y+32)
			p1=Vector2(p0.x,p0.y+32)
			print("Curve Right->Up")
			print(p0)
			print(p1)
			print(p2)
		else:
			p2=Vector2(p0.x-32,p0.y+32)
			p1=Vector2(p0.x,p0.y+32)
			print("Curve Right->Down")
			print(p0)
			print(p1)
			print(p2)
	elif oldDir==directions.UP:
		if newDir==directions.RIGHT:
			p2=Vector2(p0.x+32,p0.y-32)
			p1=Vector2(p0.x,p0.y-32)
			print("Curve Right->Up")
			print(p0)
			print(p1)
			print(p2)
		else:
			p2=Vector2(p0.x-32,p0.y-32)
			p1=Vector2(p0.x,p0.y-32)
			print("Curve Right->Down")
			print(p0)
			print(p1)
			print(p2)
	

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r

func setNewDirection(newMoveDirection: int):
	print("move called on")
	print(product_name)
	if(currentState==state.IN_CURVE):
		print("Ending Curve due to new tile")
		position = _quadratic_bezier(p0,p1,p2,1)
		t=0.0
		straightVelocity()
		currentDirection=newDirection
		currentState=state.STRAIGHT
	if newMoveDirection==0:
		newDirection = directions.ZERO
	if newMoveDirection==1:
		newDirection = directions.RIGHT
	if newMoveDirection==2:
		newDirection = directions.DOWN
	if newMoveDirection==3:
		newDirection = directions.LEFT
	if newMoveDirection==4:
		newDirection = directions.UP
	t=0.0
	move()
	
func straightVelocity():
	if currentDirection==directions.ZERO:
		velocity = Vector2.ZERO
	if currentDirection==directions.RIGHT:
		velocity = Vector2.RIGHT
	if currentDirection==directions.DOWN:
		velocity = Vector2.DOWN
	if currentDirection==directions.LEFT:
		velocity = Vector2.LEFT
	if currentDirection==directions.UP:
		velocity = Vector2.UP
