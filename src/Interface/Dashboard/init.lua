local Roact = require(script.Parent.Parent.Submodules.Roact)
local Dashboard = Roact.Component:extend("Dashboard")

local Theme = require(script.Parent.Theme)
local PanelComponent = require(script.PanelComponent)

function Dashboard:render()
	local activeTheme = Theme[self.props.theme]

	return Roact.createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = activeTheme.BackgroundColor
	}, {
		PanelComponent = Roact.createElement(PanelComponent, self.props)
	})
end

return Dashboard