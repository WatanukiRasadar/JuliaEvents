type Event
	action::Function
end
action(event::Event) = event.action(event)