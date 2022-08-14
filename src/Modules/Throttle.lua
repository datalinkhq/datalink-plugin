--[[
	Throttle.lua
]]--

-- // Constants
local THROTTLE_LIMIT = 100
local THROTTLE_RESET_TIME = 1

-- // Variables
local Throttle = { }

function Throttle.Reset()
	Throttle.value = 0
end

function Throttle.IsThrottled()
	return Throttle.value >= THROTTLE_LIMIT
end

function Throttle.Increment(value)
	value = value or 1

	Throttle.value += value
end

function Throttle.init(Datalink)
	Throttle.reset = Datalink.Signal.new()
	Throttle.value = 0

	task.spawn(function()
		while task.wait(THROTTLE_RESET_TIME) do
			Throttle.Reset()
		end
	end)
end

return Throttle