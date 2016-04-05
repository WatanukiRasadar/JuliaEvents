using Base.insert!
include("Trigger.jl")
type EventHandler{K,T <: Trigger}
	_listeners::Dict{K,Array{Function}}
	_triggers::Dict{K,Dict{String,T}}
	addListener::Function
	addEventToListener::Function
	action::Function
end 

EventHandler(K,T) = EventHandler(Dict{K,Array{Function}}(),Dict{K,Dict{String,T}}(), 
	function addListener(self::EventHandler,key::K,listener::Function)
		self._listeners[key] = listener
		self._triggers[key] = Dict{String,T}()
	end,
	function addEventToListener(self::EventHandler,listenerkey::K,listenerStatus::String,event::Event)
		triggersListener = self._triggers[listenerkey]
		if !(listenerStatus in keys(triggersListener))
			triggersListener[listenerStatus] = Trigger()
		end
		insert(triggersListener[listenerStatus],event)
	end,
	function action(self::EventHandler)
		for kv in self._listeners
			listenerKey = kv[1]
			status = kv[2]()
			for status in keys(self._triggers[listenerkey])
				action(self._triggers[listenerkey][status])
			end
		end
	end)
EventHandler(K)= EventHandler(K,Trigger)
action(handler::EventHandler) = handler.action(handler)