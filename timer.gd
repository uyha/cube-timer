extends Node

enum TimerState {stopped, running, stopping}
var timer_state: TimerState = TimerState.stopped
var total: float = 0

func _process(delta: float) -> void:
	if timer_state != TimerState.running:
		return

	total += delta
	self.text = str(total).pad_decimals(3)

func _input(event: InputEvent) -> void:
	match timer_state:
		TimerState.stopped:
			if event.is_action_released("toggle_timer"):
				total = 0
				timer_state = TimerState.running

		TimerState.running:
			if event.is_action_pressed("toggle_timer"):
				timer_state = TimerState.stopping

		TimerState.stopping:
			if event.is_action_released("toggle_timer"):
					timer_state = TimerState.stopped
