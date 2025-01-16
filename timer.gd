extends Node

enum TimerState {stopped, inspecting, timing, stopping}
var timer_state: TimerState = TimerState.stopped

enum Inspection {normal, late, dnf}

var inspect_time: float = 0
var solving_time: float = 0

func _ready() -> void:
	print(Config.has_inspection)

func _process(delta: float) -> void:
	if timer_state == TimerState.inspecting:
		inspecting(delta)

	if timer_state == TimerState.timing:
		timing(delta)

func _input(event: InputEvent) -> void:
	match timer_state:
		TimerState.stopped:
			if event.is_action_released("toggle_timer"):

				if Config.has_inspection:
					inspect_time = 15
					timer_state = TimerState.inspecting
				else:
					solving_time = 0
					timer_state = TimerState.timing

		TimerState.inspecting:
			if event.is_action_released("toggle_timer"):
					solving_time = 0
					timer_state = TimerState.timing

		TimerState.timing:
			if event.is_action_pressed("toggle_timer"):
				timer_state = TimerState.stopping

		TimerState.stopping:
			if event.is_action_released("toggle_timer"):
					timer_state = TimerState.stopped

func inspecting(delta: float) -> void:
	inspect_time -= delta

	match inspect_result():
		Inspection.normal:
			self.text = "%02d" % (int(inspect_time) + 1)
		Inspection.late:
			self.text = "+2"
		Inspection.dnf:
			self.text = "DNF"

func timing(delta: float) -> void:
	solving_time += delta
	self.text = str(solving_time).pad_decimals(3)

func inspect_result() -> Inspection:
	if inspect_time > 0:
		return Inspection.normal

	if inspect_time > -2:
		return Inspection.late

	return Inspection.dnf
