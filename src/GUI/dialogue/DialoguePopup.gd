extends Control

#onready var potrait = get_node("Potrait") as TextureRect
onready var npc_name = get_node("Panel/Name") as Label
onready var dialogue_text = get_node("Panel/Contents") as RichTextLabel

var dialogue_contents
var chatted = false
var char_name
var sentence_ended = false


func _ready():
	set_process_input(false)
	get_tree().paused = false
	self.hide()
	print("Hiding popupbox and setting process input false")

func open():
	self.show()
	get_tree().paused = true
	LoadDialogue()
	UpdateDialogueContents()
	print("LoadingDialogue and pausing background time, show popuoBox")

func LoadDialogue():
	dialogue_contents = DialogueDataImport.dialogue_data[char_name].Chat0

func UpdateDialogueContents():
	dialogue_text.set_bbcode(dialogue_contents)
	dialogue_text.percent_visible = 0
	$Tween.interpolate_property(dialogue_text, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _process(delta) -> void:
#	if Input.is_action_just_pressed("ui_interact") && sentence_ended == true:
#		close()
	pass

# FOr some reason input not processing well
#func _input(event):
#	if event is InputEventMouseButton: # need to find someway to change to Is event.just_pressed
#		print("I can click")
#		if sentence_ended == true:
#			close()
#	if event is InputEventKey:
#		print("I can press this key")
#

func _on_Tween_tween_completed(object, key):
#	$Indicator.show()
	sentence_ended = true
#	print("Sentence has ended.") #This works

func _on_Player_start_convo(colliding_name):
	char_name = colliding_name
	npc_name.set_text(char_name)
	set_process_input(true)
	print("Setting process input true")
	open()
	print("Opening chat box.")

func _on_CloseBoxButton_pressed():
	set_process_input(false)
	get_tree().paused = false
	print("UnPausing game, setting process input to false, and hiding box")
	self.hide()
