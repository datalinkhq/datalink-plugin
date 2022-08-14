--[[
	DatalinkPlugin.lua
]]--

-- // Services
local HttpService = game:GetService("HttpService")

-- // Constants
local NAME = "DataLink"

local WIDGET_SIZE = Vector2.new(350, 410)
local SPAWN_WIDGET_SIZE = Vector2.new(1100, 750)
local WIDGET_DEFAULT_ACTIVE = false

-- // Modules
local Janitor = require(script.Parent.Submodules.Janitor)
local Roact = require(script.Parent.Submodules.Roact)
local Screen = require(script.Parent.Interface.Screen)

-- // Variables
local pluginSettings = settings()
local DatalinkPlugin, DatalinkClasses = { }, {
	"Console", "Throttle", "Queue", "Https", "Session"
}

function DatalinkPlugin:Exit()
	
end

function DatalinkPlugin:Load()
	DatalinkPlugin.Promise = require(script.Parent.Submodules.Promise)
	DatalinkPlugin.Signal = require(script.Parent.Submodules.Signal)

	DatalinkPlugin.Console = require(script.Parent.Modules.Console)
	DatalinkPlugin.Constants = require(script.Parent.Modules.Constants)
	DatalinkPlugin.Queue = require(script.Parent.Modules.Queue)
	DatalinkPlugin.Https = require(script.Parent.Modules.Https)
	DatalinkPlugin.Session = require(script.Parent.Modules.Session)
	DatalinkPlugin.Throttle = require(script.Parent.Modules.Throttle)

	for _, className in DatalinkClasses do
		DatalinkPlugin[className].init(DatalinkPlugin)
	end
end

function DatalinkPlugin:Bind()
	DatalinkPlugin.uiState.uiCallbacks.authenticateAsync = function(gameKey, userId)
		if DatalinkPlugin.uiState.isLoading then
			return
		end

		DatalinkPlugin.developerKey = gameKey
		DatalinkPlugin.developerId = userId

		DatalinkPlugin.uiState.isLoading = true
		DatalinkPlugin:Mount()

		task.wait(1)
		-- -- DatalinkPlugin.Https.Authenticate()

		-- DatalinkPlugin.uiState.isLoading = false
		-- DatalinkPlugin:Mount()

		DatalinkPlugin.uiState.isLoading = false
		DatalinkPlugin.uiState.isAuthenticated = true

		DatalinkPlugin:Mount()
	end
end

function DatalinkPlugin:Init()
	DatalinkPlugin.uiState = setmetatable({
		uiCallbacks = { },
		title = "initiating",
		mobileView = false, isLoading = false,

		theme = pluginSettings.Studio.Theme.Name
	}, {
		__newindex = function(uiState, key, value)
			rawset(uiState, key, value)

			DatalinkPlugin:Mount()
		end
	})

	DatalinkPlugin.toolbarObject = plugin:CreateToolbar(NAME)
	DatalinkPlugin.toolbarButton = DatalinkPlugin.toolbarObject:CreateButton("Dashboard", "Open DataLink Dashboard", "rbxassetid://10524827068")
	DatalinkPlugin.toolbarButton.ClickableWhenViewportHidden = true

	DatalinkPlugin.pluginWidgetInformation = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, WIDGET_DEFAULT_ACTIVE, false, SPAWN_WIDGET_SIZE.X, SPAWN_WIDGET_SIZE.Y, WIDGET_SIZE.X, WIDGET_SIZE.Y)
	DatalinkPlugin.pluginWidget = plugin:CreateDockWidgetPluginGui(HttpService:GenerateGUID(false), DatalinkPlugin.pluginWidgetInformation)

	DatalinkPlugin.pluginWidget.Name = NAME
	DatalinkPlugin.pluginWidget.Title = string.format("%s :: %s", NAME, DatalinkPlugin.uiState.title)

	DatalinkPlugin.janitor:Give(pluginSettings.Studio.Theme.Changed:Connect(function()
		DatalinkPlugin.uiState.theme = pluginSettings.Studio.Theme.Name
	end))

	DatalinkPlugin.janitor:Give(DatalinkPlugin.toolbarButton.Click:Connect(function()
		DatalinkPlugin.pluginWidget.Enabled = not DatalinkPlugin.pluginWidget.Enabled
	end))

	DatalinkPlugin.uiState.title = "Authentication"

	DatalinkPlugin:Load()
	DatalinkPlugin:Bind()
end

function DatalinkPlugin:Mount()
	if DatalinkPlugin.handle then
		DatalinkPlugin.handle = Roact.update(
			DatalinkPlugin.handle,
			Roact.createElement(Screen, DatalinkPlugin.uiState)
		)
	else
		DatalinkPlugin.handle = Roact.mount(
			Roact.createElement(Screen, DatalinkPlugin.uiState),
			DatalinkPlugin.pluginWidget, NAME
		)
	end
end

function DatalinkPlugin.new()
	DatalinkPlugin.janitor = Janitor.new()
	DatalinkPlugin.janitor:Give(plugin.Unloading:Connect(function()
		DatalinkPlugin:Exit()
		DatalinkPlugin.janitor:Clean()
	end))

	DatalinkPlugin:Init()
	DatalinkPlugin:Mount()

	return DatalinkPlugin
end

return DatalinkPlugin.new()