extends Node2D

@export var product_scene: PackedScene

var spawning = false
var number = 1
var product_group

# Called when the node enters the scene tree for the first time.
func _ready():
	var product_spawn_timer = get_node("ProductSpawnTimer")
	product_spawn_timer.timeout.connect(spawn_product)
	var spawner_toggle = get_node("SpawnerToggle")
	spawner_toggle.pressed.connect(toggle_spawning)
	product_group = get_node("ProductGroup")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

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
