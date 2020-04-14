extends Control

signal convo_end

#onready var potrait = get_node("Potrait") as TextureRect
onready var npc_name = get_node("NPCLabel") as Label
onready var dialogue_text = get_node("PanelBox/DialogueContents") as RichTextLabel
#onready var chatlabel = get_node("DialoguePanelContainer/ActionButtonContainer/ChatButton/ChatLabel") as Label
#onready var giftlabel = get_node("DialoguePanelContainer/ActionButtonContainer/GiftButton/GiftLabel") as Label
onready var char_name  = "" setget set_char_name

var dialogue_contents
#var times_chatted :int = 0
#var chatted = false
var sentence_ended = false

func _ready():
	LoadDialogue()
	UpdateDialogueContents()

func LoadDialogue():
	dialogue_contents = DialogueDataImport.dialogue_data["Roselia"].Chat0

func UpdateDialogueContents():
	dialogue_text.set_bbcode(dialogue_contents) 
	dialogue_text.percent_visible = 0
	$Tween.interpolate_property(dialogue_text, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _process(delta) -> void:
#	match ending_convo:
#		true:
#			print("Ending convo")
#		false:
	pass

		
func _on_Tween_tween_completed(object, key):
	$Indicator.show()
	sentence_ended = true

func set_char_name(value):
	char_name = value
	npc_name.set_text(value)
	
func _on_NothingButton_pressed():
	emit_signal("convo_end")
	queue_free()
