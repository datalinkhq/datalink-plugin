local UserInputService = game:GetService("UserInputService")

local Roact = require(script.Parent.Parent.Parent.Submodules.Roact)
local InputBox = Roact.Component:extend("InputBox")

local CENSOR_CHARACTER = "*"

function InputBox:init()
	local previousCharCount = 0
	local isTextComputing = false

	local StrokeColor = self.props.StrokeColor
	local StrokeActiveColor = self.props.StrokeActiveColor

	self.state.boxPassword = ""
	self.state.strokeColor = StrokeColor

	self.onTextChanged = function(textBox)
		if isTextComputing or not self.props.PasswordField then
			if not isTextComputing and self.props.Callback then
				self.props.Callback(textBox.Text)
			end

			return
		end

		isTextComputing = true
		if #textBox.Text >= previousCharCount then
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
				isTextComputing = false

				return
			end

			self.state.boxPassword ..= string.sub(textBox.Text, previousCharCount + 1, #textBox.Text)
		else
			if string.find(textBox.Text, CENSOR_CHARACTER) then
				self.state.boxPassword = textBox.Text
			else
				self.state.boxPassword = string.sub(self.state.boxPassword, 1, #textBox.Text)
			end
		end

		if self.props.Callback then
			self.props.Callback(self.state.boxPassword)
		end

		print(self.state.boxPassword )

		previousCharCount = #self.state.boxPassword
		textBox.Text = string.rep(CENSOR_CHARACTER, previousCharCount - 1) .. string.sub(textBox.Text, #textBox.Text, -1)
		isTextComputing = false
	end

	self.onBoxFocused = function()
		self:setState({ strokeColor = StrokeActiveColor })
	end

	self.onBoxFocusLost = function()
		self:setState({ strokeColor = StrokeColor })
	end
end

function InputBox:render()
	local BackgroundColor = self.props.BackgroundColor

	local Size = self.props.Size
	local Position = self.props.Position

	local TextColor = self.props.TextColor
	local TextFont = self.props.TextFont

	local StrokeColor = self.state.strokeColor

	return Roact.createElement("Frame", {
		Size = Size,
		Position = Position,
		BackgroundColor3 = BackgroundColor,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5)
	}, {
		TextBox = Roact.createElement("TextBox", {
			TextSize = 14,
			TextColor3 = TextColor,
			TextWrapped = true,
			Font = TextFont,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			ClearTextOnFocus = true,
			PlaceholderText = "",
			Text = "",
			Active = true,

			[Roact.Change.Text] = self.onTextChanged,
			[Roact.Event.Focused] = self.onBoxFocused,
			[Roact.Event.FocusLost] = self.onBoxFocusLost
		}),

		UIPadding = Roact.createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
			PaddingTop = UDim.new(0, 10),
		}),
		UICorner = Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		UIStroke = Roact.createElement("UIStroke", {
			Thickness = 2,
			Color = StrokeColor
		})
	})
end

return InputBox