local Roact = require(script.Parent.Parent.Parent.Submodules.Roact)
local Theme = require(script.Parent.Parent.Theme)
local Button = require(script.Parent.Button)

local TopbarFrame = Roact.Component:extend("TopbarFrame")

function TopbarFrame:init()
	self.onHomeButtonActivated = function()
		if self.props.onNewPageSelected then
			self.props.onNewPageSelected("Home")
		end
	end

	self.onSettingsButtonActivated = function()
		if self.props.onNewPageSelected then
			self.props.onNewPageSelected("Settings")
		end
	end

	self.onRestartButtonActivated = function()

	end

	self.onUnauthorizeButtonActivated = function()

	end
end

function TopbarFrame:render()
	local activeTheme = Theme[self.props.theme]
	local activeButton = self.props.activeButton

	return Roact.createElement("Frame", {
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 82),
		BackgroundTransparency = 1
	}, {
		Frame = Roact.createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 44),

			ZIndex = 2,
			BorderSizePixel = 2,
			BorderColor3 = activeTheme.StrokeColor,
			BackgroundColor3 = activeTheme.ForegroundColor
		}, {
			Image = Roact.createElement("ImageLabel", {
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromScale(0.7, 0.7),
				AnchorPoint = Vector2.new(0.5, 0.5),

				ZIndex = 2,
				BackgroundTransparency = 1,

				ScaleType = Enum.ScaleType.Fit,
				Image = "rbxassetid://10524827068",
			}, {
				UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint")
			}),

			RestartButton = Roact.createElement(Button, {
				Icon = "http://www.roblox.com/asset/?id=10659078957",
				Callback = self.onRestartButtonActivated,
				Size = UDim2.fromOffset(20, 20),
				Position = UDim2.new(1, -60, 0.25, 0),

				ZIndex = 2,
				Active = true,
				theme = self.props.theme
			}),

			UnauthorizeButton = Roact.createElement(Button, {
				Icon = "http://www.roblox.com/asset/?id=10659126955",
				Callback = self.onUnauthorizeButtonActivated,
				Size = UDim2.fromOffset(20, 20),
				Position = UDim2.new(1, -30, 0.25, 0),

				ZIndex = 2,
				Active = true,
				theme = self.props.theme
			}),
		}),

		ContentButtons = Roact.createElement("Frame", {
			Position = UDim2.new(0.5, 0, 0, 40),
			Size = UDim2.fromOffset(350, 40),

			AnchorPoint = Vector2.new(0.5, 0),

			ZIndex = 4,
			BackgroundTransparency = 1
		}, {
			UIListLayout = Roact.createElement("UIListLayout", {
				Padding = UDim.new(0, 13),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center
			}),

			HomeButton = Roact.createElement(Button, {
				Icon = "http://www.roblox.com/asset/?id=10658764053",
				Callback = self.onHomeButtonActivated,
				Size = UDim2.fromOffset(20, 20),

				ZIndex = 4,
				Active = activeButton == "Home",
				theme = self.props.theme
			}),
			SettingsButton = Roact.createElement(Button, {
				Icon = "http://www.roblox.com/asset/?id=10659462937",
				Callback = self.onSettingsButtonActivated,
				Size = UDim2.fromOffset(20, 20),

				ZIndex = 4,
				Active = activeButton == "Settings",
				theme = self.props.theme
			})
		}),

		FrameFold = Roact.createElement("Frame", {
			Position = UDim2.new(0.5, 0, 0, 40),
			Size = UDim2.fromOffset(350, 15),

			AnchorPoint = Vector2.new(0.5, 0),

			ZIndex = 3,
			BorderSizePixel = 0,
			BackgroundColor3 = activeTheme.ForegroundColor
		}, {
			UIPadding = Roact.createElement("UIPadding", {
				PaddingTop = UDim.new(0, 14)
			}),
		}),

		SubFrameStroke = Roact.createElement("Frame", {
			Position = UDim2.new(0.5, 0, 0, 30),
			Size = UDim2.fromOffset(350, 50),

			AnchorPoint = Vector2.new(0.5, 0),

			ZIndex = 1,
			BackgroundColor3 = activeTheme.ForegroundColor
		}, {
			UICorner = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0, 8)
			}),

			UIStroke = Roact.createElement("UIStroke", {
				Color = activeTheme.StrokeColor,
				Thickness = 2
			}),
		}),
	})
end

return TopbarFrame