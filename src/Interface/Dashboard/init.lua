local Roact = require(script.Parent.Parent.Submodules.Roact)
local Theme = require(script.Parent.Theme)
local Topbar = require(script.Topbar)

local HomePage = require(script.Pages.Home)
local SettingsPage = require(script.Pages.Settings)

local Dashboard = Roact.Component:extend("Dashboard")
local PageIndexes = {
	["Home"] = 2,
	["Settings"] = 1
}

function Dashboard:init()
	self.state.activeButton = "Home"
	self.UIPageLayoutReference = Roact.createRef()

	self.onNewPageSelected = function(pageEnum)
		local UIPageLayout = self.UIPageLayoutReference:getValue()

		UIPageLayout:JumpToIndex(PageIndexes[pageEnum])
	end

	self.onUIPageLayoutChanged = function(pageLayout)
		self:setState({
			activeButton = pageLayout.CurrentPage and string.gsub(pageLayout.CurrentPage.Name, "Page", "")
		})
	end
end

function Dashboard:render()
	local activeTheme = Theme[self.props.theme]
	local propsParameter = self.props

	propsParameter.onNewPageSelected = self.onNewPageSelected
	propsParameter.activeButton = self.state.activeButton

	return Roact.createElement("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = activeTheme.BackgroundColor
	}, {
		Container = Roact.createElement("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 10
		}, {
			TopbarComponent = Roact.createElement(Topbar, propsParameter),
			PagesComponent = Roact.createElement("Frame", {
				Size = UDim2.new(1, 0, 1, -82),
				Position = UDim2.new(0, 0, 0, 82),

				BackgroundTransparency = 1
			}, {
				HomePage = Roact.createElement(HomePage, propsParameter),
				SettingsPage = Roact.createElement(SettingsPage, propsParameter),

				UIPadding = Roact.createElement("UIPadding", {
					PaddingBottom = UDim.new(0,16),
					PaddingRight = UDim.new(0, 16),
					PaddingLeft = UDim.new(0, 16),
					PaddingTop = UDim.new(0, 16),
				}),
				UIPageLayout = Roact.createElement("UIPageLayout", {
					Padding = UDim.new(0, 25),
					EasingStyle = Enum.EasingStyle.Cubic,
					TweenTime = 0.2,

					[Roact.Ref] = self.UIPageLayoutReference,
					[Roact.Change.CurrentPage] = self.onUIPageLayoutChanged
				})
			})
		})
	})
end

return Dashboard