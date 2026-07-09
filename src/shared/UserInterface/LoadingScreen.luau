local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local module = {}

module.LoadingScreen = function()
	local instances = {}
	local scope = Fusion.scoped(Fusion)

	local strokeColors = {}

	local function hover(button: TextButton)
		local UIstroke: UIStroke? = button:FindFirstChildOfClass("UIStroke")
		if UIstroke then
			strokeColors[button] = UIstroke.Color
			UIstroke.Color = Color3.new(UIstroke.Color.R * 0.85, UIstroke.Color.G * 0.85, UIstroke.Color.B * 0.85)
		end
		button.TextColor3 = Color3.new(0.458824, 0.458824, 0.458824)
	end

	local function dehover(button: TextButton)
		local UIstroke: UIStroke? = button:FindFirstChildOfClass("UIStroke")
		if UIstroke then
			strokeColors[button] = UIstroke.Color
			UIstroke.Color = Color3.new(UIstroke.Color.R * 0.85, UIstroke.Color.G * 0.85, UIstroke.Color.B * 0.85)
		end
		button.TextColor3 = Color3.new(0.458824, 0.458824, 0.458824)
	end

	local buttonProps = {
		Size = UDim2.new(1, 0, 0.15, 0),
		TextColor3 = Color3.new(1, 1, 1),
		[scope.OnEvent("MouseEntered")] = hover,
		[scope.OnEvent("MouseExited")] = dehover,
	}

	instances.PlayButton = scope:New("TextButton")({
		Text = "Play",
		table.unpack(buttonProps),
	})

	instances.CreditsButton = scope:New("TextButton")({
		Text = "Credits",
		table.unpack(buttonProps),
	})

	instances.SettingsButton = scope:New("TextButton")({
		Text = "Settings",
		table.unpack(buttonProps),
	})

	instances.ButtonsContainer = scope:New("Frame")({
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(10, 0, -10, 1),
		Size = UDim2.new(0.25, 0, 1, -20),

		[scope.Children] = {
			instances.PlayButton,
			instances.CreditsButton,
			instances.SettingsButton,
			scope:New("UIListLayout")({
				FillDirection = Enum.FillDirection.Vertical,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
				Padding = UDim.new(0.025, 0),
			}),
		},
	})

	instances.Background = scope:New("Frame")({
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(2, 0, 2, 0),

		[scope.Children] = {
			instances.ButtonsContainer,
		},
	})

	return instances, scope.doCleanup()
end

return
