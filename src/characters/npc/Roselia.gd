extends KinematicBody2D

#onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = $AnimationTree.get("parameters/playback")

#var dialoguePopup
#var player
export var SPEED = 60
var moving_dir
var velocity :int 
var npc_stats
var moving_vector = Vector2()
#var ori_pos = Vector2() #original position
#var cur_pos = Vector2() #latest position

enum {UP, DOWN, LEFT, RIGHT,IDLE}

#var tilesize = 16
#var can_move = true
#var facing = 'right'
#var moves = {'right': Vector2(1,0),
#			 'left': Vector2(-1,0),
#			 'up': Vector2(0,-1),
#			 'down': Vector2(0,1)}

func _ready():
	npc_stats = load("res://src/characters/npc/Roselia.tres")	

func _process(delta):
#	cur_pos = self.position
#	if cur_pos.x - ori_pos.x > 300:
#		ori_pos = cur_pos
#		moving_dir = DOWN
	
	match moving_dir:
		UP:
			moving_vector = Vector2(0,-1)

		DOWN:
			moving_vector = Vector2(0,1)

		LEFT:
			moving_vector = Vector2(-1,0)

		RIGHT:
			moving_vector = Vector2(1,0)

		IDLE:
			moving_vector = Vector2(0,0)

	if moving_vector != Vector2.ZERO:
		velocity = moving_vector * SPEED
		animationTree.set("parameters/Idle/blend_position", moving_vector)
		animationTree.set("parameters/Walk/blend_position", moving_vector)
		animationState.travel("Walk")
	else:
		animationState.travel("Idle")
		velocity = moving_vector * SPEED

	move_and_slide(velocity)

#func _ready():
#	facing = moves.keys()[randi() % 4]
#
#func _process(delta):
#	if can_move:
#		if not move(facing) or randi() % 10 > 5:
#			facing = moves.keys()[randi() % 4]
#
#func move(dir):
#	if can_move == false:
#		return 
#	facing = dir
#	can_move = false
#	$Tween.interpolate_property(self, "position", position, position + moves[facing] * tilesize, 0.8, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
#	$Tween.start()
#	animationTree.set("parameters/Idle/blend_position")
#	return true
#
#func _on_Tween_tween_completed(object, key):
#	can_move = true

#func talk():
#	dialoguePopup.npc_name = "Roselia"
