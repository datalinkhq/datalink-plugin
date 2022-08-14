local Roact = require(script.Parent.Parent.Submodules.Roact)
local Screen = Roact.Component:extend("Screen")

local Authentication = require(script.Parent.Authentication)
local Dashboard = require(script.Parent.Dashboard)
local Loading = require(script.Parent.Loading)

function Screen:render()
	return Roact.createElement("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
	}, {
		Page = if self.props.isAuthenticated then
			Roact.createElement(Dashboard, self.props)
		else
			Roact.createElement(Authentication, self.props),

		LoadingPage = Roact.createElement(Loading, self.props)
	})
end

return Screen