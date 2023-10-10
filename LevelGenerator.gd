@tool
extends Node2D

@export var playableAreaSize:Vector2 = Vector2(10000, 10000)
@export var levelSpacing: int = 2000
var generating: bool = false
const floor_scene = preload("res://Floor/floor_level.tscn")
var current_level = 0

signal scored(int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func update_score(n:Node2D, score:int):
	scored.emit(score)
	
func emit_and_move():
	var new_floor = floor_scene.instantiate()
	new_floor.update_score = update_score
	new_floor.initialise(self.current_level, self.position)
	self.get_parent().add_child(new_floor)
	self.translate(Vector2.DOWN*levelSpacing)
	self.current_level += 1
	
func begin_generation():
	while self.position.y < playableAreaSize.y:
		emit_and_move()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_area_2d_area_entered(area):
	if area.is_in_group("GameArea"):
		emit_and_move()
	# If we've just entered the bottom of the camera, we had better generate and move again

