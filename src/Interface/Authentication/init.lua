local Roact = require(script.Parent.Parent.Submodules.Roact)
local Authentication = Roact.Component:extend("Authentication")

local Theme = require(script.Parent.Theme)
local InputBox = require(script.InputBox)

function Authentication:init()
	local activeTheme = Theme[self.props.theme]

	self.state.strokeColor = activeTheme.StrokeColor
	self.state.gameKey = ""
	self.state.userId = ""

	self.onMouseEnter = function()
		self:setState({ strokeColor = activeTheme.StrokeActiveColor })
	end

	self.onMouseLeave = function()
		self:setState({ strokeColor = activeTheme.StrokeColor })
	end

	self.onGameKeySet = function(value)
		self.state.gameKey = value
	end

	self.onUserIdSet = function(value)
		self.state.userId = value
	end

	self.onMouseActivated = function()
		if self.props.uiCallbacks.authenticateAsync then
			self.props.uiCallbacks.authenticateAsync(self.state.gameKey, self.state.userId)
		end
	end
end

function Authentication:render()
	local activeTheme = Theme[self.props.theme]

	local strokeColor = self.state.strokeColor

	return Roact.createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = activeTheme.BackgroundColor
	}, {
		Content = Roact.createElement("Frame", {
			Size = UDim2.fromOffset(350, 350),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1
		}, {
			DataLinkImage = Roact.createElement("ImageLabel", {
				ScaleType = Enum.ScaleType.Fit,
				Image = "rbxassetid://10524827068",

				BackgroundTransparency = 1,

				Position = UDim2.fromScale(0.5, 0.08),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(240, 35),
			}),

			DataLinkText = Roact.createElement("TextLabel", {
				Text = "DataLink // Login",
				TextColor3 = activeTheme.BoldTextColor,
				Font = activeTheme.BoldTextFont,
				TextSize = 24,

				BackgroundTransparency = 1,

				Position = UDim2.fromScale(0.5, 0.2),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(240, 35),
			}),

			UserIdTextLabel = Roact.createElement("TextLabel", {
				Position = UDim2.fromScale(0.5, 0.4),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(240, 20),

				BackgroundTransparency = 1,

				Font = activeTheme.BoldTextFont,

				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = activeTheme.TextColor,
				TextSize = 14,
				Text = "User ID"
			}),

			UserIdBox = Roact.createElement(InputBox, {
				BackgroundColor = activeTheme.BackgroundColor,

				StrokeActiveColor = activeTheme.StrokeActiveColor,
				StrokeColor = activeTheme.StrokeColor,

				TextColor = activeTheme.TextColor,
				TextFont = activeTheme.TextFont,

				PasswordField = false,

				Callback = self.onUserIdSet,

				Size = UDim2.fromOffset(250, 40),
				Position = UDim2.fromScale(0.5, 0.5),
			}),

			GameIdTextLabel = Roact.createElement("TextLabel", {
				Position = UDim2.fromScale(0.5, 0.6),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(240, 20),

				BackgroundTransparency = 1,

				Font = activeTheme.BoldTextFont,

				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = activeTheme.TextColor,
				TextSize = 14,
				Text = "Game Key"
			}),

			GameIdBox = Roact.createElement(InputBox, {
				BackgroundColor = activeTheme.BackgroundColor,

				StrokeActiveColor = activeTheme.StrokeActiveColor,
				StrokeColor = activeTheme.StrokeColor,

				TextColor = activeTheme.TextColor,
				TextFont = activeTheme.TextFont,

				PasswordField = true,
				ScramblePastedData = false,

				Callback = self.onGameKeySet,

				Size = UDim2.fromOffset(250, 40),
				Position = UDim2.fromScale(0.5, 0.7),
			}),

			AuthenticateFrame = Roact.createElement("Frame", {
				BackgroundTransparency = 1,

				Position = UDim2.fromScale(0.5, 0.9),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.fromOffset(240, 35),
			}, {
				UICorner = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				UIStroke = Roact.createElement("UIStroke", {
					Thickness = 2,
					Color = strokeColor
				}),
				Authenticate = Roact.createElement("TextButton", {
					Size = UDim2.fromScale(1, 1),

					BackgroundTransparency = 1,

					Font = activeTheme.BoldTextFont,

					TextColor3 = activeTheme.TextColor,
					TextSize = 18,
					Text = "Authenticate",

					[Roact.Event.MouseEnter] = self.onMouseEnter,
					[Roact.Event.MouseLeave] = self.onMouseLeave,
					[Roact.Event.MouseButton1Down] = self.onMouseLeave,
					[Roact.Event.MouseButton1Up] = self.onMouseEnter,
					[Roact.Event.Activated] = self.onMouseActivated
				})
			})
		})
	})
end

return Authentication