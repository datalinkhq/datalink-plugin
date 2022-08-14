local Roact = require(script.Parent.Parent.Submodules.Roact)
local Flipper = require(script.Parent.Parent.Submodules.Flipper)

local Theme = require(script.Parent.Theme)
local Gif = require(script.Parent.Components.Gif)
local Loading = Roact.Component:extend("Loading")

function Loading:init()
	self.motor = Flipper.SingleMotor.new(1)
	self.binding, self.setBinding = Roact.createBinding(self.motor:getValue())
	self.motor:onStep(self.setBinding)
end

function Loading:didUpdate()
	self.motor:setGoal(Flipper.Spring.new((self.props.isLoading and 0) or 1, {
		frequency = 5,
		dampingRatio = 1
	}))
end

function Loading:render()
	local activeTheme = Theme[self.props.theme]

	return Roact.createElement("Frame", {
		Size = UDim2.fromOffset(350, 410),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundColor3 = activeTheme.BackgroundColor,
		BorderSizePixel = 0,
		ZIndex = 10,

		BackgroundTransparency = self.binding:map(function(value)
			return value
		end),

		Active = self.binding:map(function(value)
			return value ~= 0
		end),
	}, {
		Gif = Roact.createElement(Gif, {
			SpriteImage = "http://www.roblox.com/asset/?id=10573217688",
			SpriteColor = Color3.new(1, 1, 1),
			Columns = 10,
			Rows = 10,
			Frames = 95,

			SpriteTransparency = self.binding:map(function(value)
				return value
			end),

			ZIndex = 10,
			Size = UDim2.fromScale(0.2, 0.2)
		}),
	})
end

return Loading