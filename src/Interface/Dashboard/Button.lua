local Roact = require(script.Parent.Parent.Parent.Submodules.Roact)
local Theme = require(script.Parent.Parent.Theme)

local Button = Roact.Component:extend("Button")

function Button:render()
	local activeTheme = Theme[self.props.theme]

	local Callback = self.props.Callback
	local Active = self.props.Active
	local Icon = self.props.Icon

	local Position = self.props.Position
	local Size = self.props.Size

	local ZIndex = self.props.ZIndex

	return Roact.createElement("ImageButton", {
		Image = Icon,
		ScaleType = Enum.ScaleType.Fit,
		ImageColor3 = (Active and activeTheme.ActiveImageButtonColor) or activeTheme.ImageButtonColor,
		BackgroundTransparency = 1,

		Position = Position,
		Size = Size,

		ZIndex = ZIndex,

		[Roact.Event.Activated] = Callback,
	}, {
		UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint")
	})
end

return Button