extends Node

var total: float = 0
var running_timer: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !running_timer:
		return

	total += delta
	self.text = str(total).pad_decimals(3)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_timer"):
		if running_timer:
			total = 0
		running_timer = !running_timer
