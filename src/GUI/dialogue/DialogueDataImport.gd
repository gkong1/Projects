extends Node

var dialogue_data : Dictionary

func _ready():
	var dialogue_file = File.new()
	dialogue_file.open("res://data/DialogueData.json", File.READ)
	var dialogue_json = JSON.parse(dialogue_file.get_as_text())
	dialogue_file.close()
	dialogue_data = dialogue_json.result.DialogueData