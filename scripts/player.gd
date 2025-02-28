extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -260.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite_2d.flip_h = true
	elif direction < 0:
		animated_sprite_2d.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _get_custom_tile_data(body_rid: RID, tilemap: Node2D, data_layer_name: String):
	if tilemap is TileMapLayer:
		
		var tile_cord = tilemap.get_coords_for_body_rid(body_rid)
		var tile: TileData = tilemap.get_cell_tile_data(tile_cord)
		
		return tile.get_custom_data(data_layer_name)
	else:
		return null

func _on_hurtbox_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	print('something collided the player')
	var tileType = _get_custom_tile_data(body_rid, body, "type")
	
	if tileType == "spike":
		print('player hit a spike')
		get_tree().call_deferred("reload_current_scene")
