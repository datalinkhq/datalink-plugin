local Roact = require(script.Parent.Parent.Submodules.Roact)
local Screen = Roact.Component:extend("Screen")

function Screen:render()
	if self.props.init then
		return Roact.createElement("Frame")
	end

	return Roact.createElement("Frame", {
		Size = UDim2.fromScale(1, 1)
	})
end

return Screen