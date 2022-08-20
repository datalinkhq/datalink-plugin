local Roact = require(script.Parent.Parent.Parent.Parent.Submodules.Roact)
local Theme = require(script.Parent.Parent.Parent.Theme)

local HomePage = Roact.Component:extend("HomePage")

function HomePage:render()
	local activeTheme = Theme[self.props.theme]
	
	return Roact.createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1
	}, {
		Roact.createElement("TextLabel", {
			Text = "HOME_PAGE",
			Size = UDim2.fromScale(1, 1),
			TextColor3 = activeTheme.BoldTextColor,
			Font = activeTheme.BoldTextFont,
			BackgroundTransparency = 1,
			TextScaled = true,
		})
	})
end

return HomePage