extends RigidBody2D


var strength = 7000
var friction = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if Input.is_action_pressed("Left"):
		self.apply_force(Vector2.LEFT*self.strength)
	elif Input.is_action_pressed("Right"):
		self.apply_force(Vector2.RIGHT*self.strength)
	self.apply_force(Vector2(-self.linear_velocity.x*friction,0))

func death_sequence():
	$AudioStreamPlayer.play()
	self.queue_free()

func _on_body_entered(body):
#	if body.is_in_group("floors"):
#		print("Player hit an floor")
	pass
