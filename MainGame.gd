extends Node2D

@export var product_scene: PackedScene
@export var conveyor_scene: PackedScene

var spawning = false
var number = 1
var product_group
var conveyor_group

# Called when the node enters the scene tree for the first time.
func _ready():
	var product_spawn_timer = get_node("ProductSpawnTimer")
	product_spawn_timer.timeout.connect(spawn_product)
	var spawner_toggle = get_node("SpawnerToggle")
	spawner_toggle.pressed.connect(toggle_spawning)
	product_group = get_node("ProductGroup")
	conveyor_group = get_node("ConveyorGroup")
	spawn_conveyors(20,20)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func spawn_conveyors(width: int, height: int):
	for y in range(0,height-1):
		for x in range(0, width-1):
			var conveyor: Conveyor = conveyor_scene.instantiate()
			conveyor.position = Vector2(x*64,y*64)
			conveyor_group.add_child(conveyor)
			print("Spawned Conveyor at:")
			print(conveyor.position)

func spawn_product():
	if not spawning:
		return
	var product: Product = product_scene.instantiate()
	product.position = Vector2(10,10)
	product.product_name = number
	number +=1
	product_group.add_child(product)
	print("Spawn Product")
	print(product.position)


func toggle_spawning():
	spawning = not spawning
