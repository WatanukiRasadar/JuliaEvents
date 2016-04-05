using Base.insert!
include("Event.jl")
type Trigger
	_events::Array{Event}
	action::Function
end
Base.insert!(trigger::Trigger,event::Event)=Base.insert!(trigger._events,size(trigger._events,1)+1,event)
action(trigger::Trigger) = trigger.action(trigger)
Trigger()=Trigger(Array(Event,0),
		function action(this::Trigger)
			for event::Event in this._events
				action(event)
			end
		end
		)
