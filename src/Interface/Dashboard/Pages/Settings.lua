local Roact = require(script.Parent.Parent.Parent.Parent.Submodules.Roact)
local Theme = require(script.Parent.Parent.Parent.Theme)

local SettingsPage = Roact.Component:extend("SettingsPage")

function SettingsPage:render()
	local activeTheme = Theme[self.props.theme]
	
	return Roact.createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1
	}, {
		Roact.createElement("TextLabel", {
			Text = "SETTINGS_PAGE",
			Size = UDim2.fromScale(1, 1),
			TextColor3 = activeTheme.BoldTextColor,
			Font = activeTheme.BoldTextFont,
			BackgroundTransparency = 1,
			TextScaled = true,
		})
	})
end

return SettingsPage