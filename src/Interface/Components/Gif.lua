local RunService = game:GetService("RunService")

local Roact = require(script.Parent.Parent.Parent.Submodules.Roact)
local Janitor = require(script.Parent.Parent.Parent.Submodules.Janitor)

local GifImageComponent = Roact.Component:extend()

function GifImageComponent:update()
	self.state.Column = self.state.FrameNumber
	self.state.Row = 1

	while self.state.Column > self.props.Columns do
		self.state.Column -= self.props.Columns
		self.state.Row += 1
	end

	self:setState({
		FrameNumber = (self.state.FrameNumber + 1 > self.props.Frames and 1) or self.state.FrameNumber + 1,
		Position = UDim2.fromScale(-(self.state.Column - 1), -(self.state.Row - 1))
	})
end

function GifImageComponent:init()
	self.Janitor = Janitor.new()
	self.state = { FrameNumber = 1, FPS = 120, FPSTick = tick() }

	self:update()
end

function GifImageComponent:didMount()
	self.Janitor:Give(RunService.RenderStepped:Connect(function()
		local FPSTick = tick()

		if FPSTick - self.state.FPSTick >= 1/self.state.FPS then
			self:update()

			self.state.FPSTick = FPSTick
		end
	end))
end

function GifImageComponent:willUnmount()
	self.Janitor:Clean()
end

function GifImageComponent:render()
	local Position = self.state.Position
	local Columns, Rows = self.props.Columns, self.props.Rows

	return Roact.createElement("Frame", {
		AnchorPoint = self.props.AnchorPoint or Vector2.new(0.5, 0.5),
		Position = self.props.Position or UDim2.fromScale(0.5, 0.5),
		Size = self.props.Size or UDim2.fromScale(1, 1),

		ZIndex = self.props.ZIndex,

		BackgroundTransparency = 1,
		ClipsDescendants = true
	}, {
		UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
			AspectType = Enum.AspectType.FitWithinMaxSize,
			DominantAxis = Enum.DominantAxis.Width,
			AspectRatio = 1,
		}),

		Sprite = Roact.createElement("ImageLabel", {
			ImageColor3 = self.props.SpriteColor or Color3.new(1, 1, 1),
			ImageTransparency = self.props.SpriteTransparency or 0,
			Size = UDim2.fromScale(Columns, Rows),
			Image = self.props.SpriteImage,
			ZIndex = self.props.ZIndex,
			BackgroundTransparency = 1,
			Position = Position
		})
	})
end

return GifImageComponent