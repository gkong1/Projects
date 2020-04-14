extends KinematicBody2D

signal start_convo(colliding_name)

onready var rayCast2D = get_node("RayCast2D") as RayCast2D

const SPEED = 350

enum {MOVE, INTERACT}
var state = MOVE
var velocity = Vector2.ZERO
var colliding_name

# warning-ignore:unused_argument
func _physics_process(delta) -> void:
	match state:
		MOVE:
			move_state()
		INTERACT:
			interact_state()

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("ui_interact"):
		state = INTERACT
	else:
		state = MOVE

func move_state() -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vector != Vector2.ZERO:
		#animationTree.set("", input_vector)
		#animationTree.set("", input_vector)
		#animationState.travel()
		velocity = input_vector.normalized() * SPEED
		rotate_face_dir(velocity)

	else:
		#animationState.travel("Idle")
		velocity = Vector2(0,0)
		
	move_and_slide(velocity)
	
func rotate_face_dir(point_direction: Vector2) -> void:
	var temp = rad2deg(atan2(point_direction.y, point_direction.x))
	rayCast2D.rotation_degrees = temp	

func interact_state() -> void:
	if rayCast2D.is_colliding():
		var colliding_body = rayCast2D.get_collider()
		if colliding_body.is_in_group("NPC"):
			colliding_name = colliding_body.get_name()
			var dialoguepanel = load("res://src/GUI/dialogue/DialoguePanel.tscn").instance()
			get_parent().get_node("CanvasLayer").add_child(dialoguepanel)
			dialoguepanel.char_name = colliding_name
			get_tree().paused = true
			get_parent().get_node("CanvasLayer/DialoguePanel").connect("convo_end", self, "_on_ConvoEnd")
		else:
			state = MOVE
	else:
		state = MOVE

func _on_ConvoEnd():
#	get_parent().get_node("CanvasLayer/DialoguePanel").queue_free()
	get_tree().paused = false
	state = MOVE
