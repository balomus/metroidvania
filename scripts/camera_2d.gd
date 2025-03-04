extends Camera2D


@onready var player: CharacterBody2D = $"../Player"

const camWidth: int = 576
const camHeight: int = 324

func _repositionCamera():
	
	if player.position.x > position.x + camWidth:
		print('player exited right off screen')
		position.x += camWidth
		player.updateOriginalCoords(player.position)
	elif player.position.x < position.x:
		print('player exited left off screen')
		position.x -= camWidth
		player.updateOriginalCoords(player.position)
	elif player.position.y > position.y + camHeight:
		print('player exited down off screen')
		position.y += camHeight
		player.updateOriginalCoords(player.position)
	elif player.position.y < position.y:
		print('player exited up off screen')
		position.y -= camHeight
		player.updateOriginalCoords(player.position)
		player.applyUpwardForceFromRoomChange()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_repositionCamera()
