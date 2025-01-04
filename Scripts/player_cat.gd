extends CharacterBody2D

@export var SPEED = 300.0
# const JUMP_VELOCITY = -400.0

# parameters/Walk/blend_position

@onready var animation_tree = $AnimationTree
@onready var state = animation_tree.get("parameters/playback")

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_direction := Vector2(Input.get_vector("move_left", "move_right", "move_up", "move_down"))
	
	update_animation(input_direction)
	velocity = input_direction*SPEED

	change_state()
	move_and_slide()
	
func update_animation(move_input: Vector2) -> void:
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		
func change_state() -> void:
	if (velocity != Vector2.ZERO):
		state.travel("Walk")
	else:
		state.travel("Idle")
	
