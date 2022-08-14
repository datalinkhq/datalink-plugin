local Roact = require(script.Parent.Parent.Parent.Submodules.Roact)
local PanelComponent = Roact.Component:extend("PanelComponent")

local Theme = require(script.Parent.Parent.Theme)

function PanelComponent:render()
	local activeTheme = Theme[self.props.theme]

	return Roact.createElement("Frame", {
		Size = UDim2.fromScale(0.25, 1),
		BorderSizePixel = 0,
		BackgroundColor3 = activeTheme.ForegroundColor
	}, {
		TitleFrame = Roact.createElement("Frame", {
			BackgroundColor3 = activeTheme.StrongForegroundColor,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 0.1)
		}),

		UISizeConstraint = Roact.createElement("UISizeConstraint", {
			MaxSize = Vector2.new(230, math.huge)
		})
	})
end

return PanelComponent