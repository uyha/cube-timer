extends Node

var has_inspection : bool = false

func _ready() -> void:
	var file : FileAccess = FileAccess.open("res://config.json", FileAccess.READ)
	if file == null:
		return

	var json : JSON = JSON.new()
	var text : String = file.get_as_text()
	var error : int = json.parse(text)

	if error != OK:
		print("JSON parse error: {message} at line {line}"
			.format(
				{"message": json.get_error_message(),
				"line": json.get_error_line()
			}))
		return

	var data : Variant = json.data

	if typeof(data) != TYPE_DICTIONARY:
		return

	for key : Variant in data:
		if typeof(key) == TYPE_STRING and key == "has_inspection":
			if typeof(data[key]) == TYPE_BOOL:
				has_inspection = data[key]

