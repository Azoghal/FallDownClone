extends Camera2D

@export var speed:float = 500
@export var target: Node2D # thing to at least keep up with
@export var buffer= 2000 # How many pixels below the camera center that the player can be
@export var move:bool = true
signal killed_player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# TODO: instead of two translates, do this in more of a nice springy fashhion?
	var move_target = self.position + Vector2.DOWN*self.speed*delta
	if target:
		var dif_y = target.position.y - move_target.y
		if dif_y > 0:
			# scale lerp factor linearly from 0 to 1 based on dif
			var lerp_factor = clamp(lerp(0,1,dif_y/buffer),0,1)
			move_target.y = lerp(move_target.y, target.position.y,lerp_factor)
	if move:
		self.position = move_target

func _on_death_zone_body_entered(body):
	if body.is_in_group("player"):
		print("The player has become dead")
		#body.queue_free()
		killed_player.emit()
		target = null
		


func _on_game_area_body_exited(body):
	if body.is_in_group("floors"):
		body.queue_free()
