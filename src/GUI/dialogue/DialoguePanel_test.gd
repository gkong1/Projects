extends Control

signal close_dialogue_panel

#onready var potrait = get_node("Potrait") as TextureRect
#onready var char_name = get_node("NPCNameLabel").get_text() as String
onready var dialogue_text = get_node("DialoguePanelContainer/DialogueRichText") as RichTextLabel
#onready var chatlabel = get_node("DialoguePanelContainer/ActionButtonContainer/ChatButton/ChatLabel") as Label
#onready var giftlabel = get_node("DialoguePanelContainer/ActionButtonContainer/GiftButton/GiftLabel") as Label

var dialogue_contents
var times_chatted :int = 0
var chatted = false
var ending_convo = false
var char_name = "Roselia"

	
func _ready():
	set_process_input(true)
	SetCharPotrait()
	DetermineDialogueContents()
	UpdateDialogueContents()

func SetCharPotrait():
	pass

func DetermineDialogueContents():
	if times_chatted == 0 && ending_convo == false:
		dialogue_contents = DialogueDataImport.dialogue_data[char_name].Chat0

	if times_chatted == 1 && ending_convo == false:
		dialogue_contents = DialogueDataImport.dialogue_data[char_name].Chat1
	
	elif times_chatted > 1 && ending_convo == false:
		dialogue_contents = DialogueDataImport.dialogue_data[char_name].Chat2
	
	if ending_convo == true:
		dialogue_contents = DialogueDataImport.dialogue_data[char_name].EndConvo

func UpdateDialogueContents():
	dialogue_text.set_bbcode(dialogue_contents) 
	dialogue_text.set_visible_characters(0)

func _input(event):
	if event is InputEventMouseButton: # need to find someway to change to Is event.just_pressed
		var current_visible_char = dialogue_text.get_visible_characters()
		var total_char_count = dialogue_text.get_total_character_count()
		if current_visible_char < total_char_count:
			dialogue_text.set_visible_characters(total_char_count)
			
		elif current_visible_char == total_char_count:
			if chatted == false:
				pass
			elif times_chatted == 1:
				times_chatted += 1
				DetermineDialogueContents()
				UpdateDialogueContents()	
			elif ending_convo == true:
				emit_signal("close_dialogue_panel")

func _on_ChatButton_pressed():
	times_chatted += 1
	if chatted == false:
		DetermineDialogueContents()
		UpdateDialogueContents()
		chatted = true
		#chatlabel.add_color_override("Chat", Color(85757))
	
	if chatted == true:
		pass

#func _on_GiftButton_pressed():
#	pass # Replace with function body.

func _on_NothingButton_pressed():
	ending_convo = true
	DetermineDialogueContents()
	UpdateDialogueContents()

func _on_Timer_timeout():
	dialogue_text.set_visible_characters(dialogue_text.get_visible_characters()+1)

####
extends Control

onready var dialogueContents = get_node("PanelBox/DialogueContents") as RichTextLabel

var dialog = ["Hello, how can I help you?", "It's a great day!", "I wonder what else is happening today."]
var times_chatted : int = 0
var max_times_chatted : int = 2
var dialogue_contents
var sentence_finished = false

func _ready():
	set_process_input(true)
	load_dialogue()

func load_dialogue():
	dialogue_contents = dialog[times_chatted]
	dialogueContents.set_bbcode(dialogue_contents)
	dialogueContents.percent_visible = 0
	$Tween.interpolate_property(dialogueContents, "percent_visible", 0, 1, 1, $Tween.TRANS_LINEAR, $Tween.EASE_IN_OUT)
	$Tween.start()

func _input(event) -> void:
	if sentence_finished == false:
		pass
	elif sentence_finished == true:
		if times_chatted == 0:
			$Indicator.visible = false
		elif times_chatted == 1:
			$Indicator.visible = true
		if Input.is_action_just_pressed("ui_interact"):
			if times_chatted < max_times_chatted:
				times_chatted += 1
				load_dialogue()
			elif times_chatted == max_times_chatted:
				times_chatted = max_times_chatted
				load_dialogue()

func _on_Tween_tween_completed(object, key):
	sentence_finished = true

func _on_NothingButton_pressed():
	queue_free()

