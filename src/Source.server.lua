--[[
	DatalinkPlugin.lua
]]--

-- // Services
local HttpService = game:GetService("HttpService")

-- // Constants
local NAME = "DataLink"

local WIDGET_SIZE = Vector2.new()
local WIDGET_DEFAULT_ACTIVE = false

-- // Modules
local Janitor = require(script.Parent.Submodules.Janitor)
local Roact = require(script.Parent.Submodules.Roact)
local Screen = require(script.Parent.Components.Screen)

-- // Variables
local pluginJanitor = Janitor.new()

local toolbarObject = plugin:CreateToolbar(NAME)
local toolbarButton = toolbarObject:CreateButton("Dashboard", "Open DataLink Dashboard", "rbxassetid://10524827068")
toolbarButton.ClickableWhenViewportHidden = true

local pluginWidgetInformation = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, WIDGET_DEFAULT_ACTIVE, false, WIDGET_SIZE.X, WIDGET_SIZE.Y, WIDGET_SIZE.X, WIDGET_SIZE.Y)
local pluginWidget = plugin:CreateDockWidgetPluginGui(HttpService:GenerateGUID(false), pluginWidgetInformation)

local handle = Roact.mount(Roact.createElement(Screen, { init = false }), pluginWidget, string.format("%s-RoactTree", NAME))
local handleData = { state = "initiating" }

pluginWidget.Name = NAME
pluginWidget.Title = string.format("%s :: %s", NAME, handleData.state)

-- // Source
setmetatable(handleData, {
	__newindex = function(self, key, value)
		rawset(self, key, value)

		pluginWidget.Title = string.format("%s :: %s", NAME, handleData.state)
		handle = Roact.update(handle, Roact.createElement(Screen, handleData))
	end
})

pluginJanitor:Give(toolbarButton.Click:Connect(function()
	pluginWidget.Enabled = not pluginWidget.Enabled
end))

pluginJanitor:Give(function()
	Roact.unmount(handle)

	toolbarButton:Destroy()
	pluginWidget:Destroy()
end)

plugin.Unloading:Connect(function()
	pluginJanitor:Clean()
end)

require(script.Parent.Interface)(handleData, pluginJanitor)