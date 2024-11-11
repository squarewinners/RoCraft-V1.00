local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local isPlacingEnabled = false 
local currentColorIndex = 1 
local colors = { 
	Color3.fromRGB(255, 0, 0),   
	Color3.fromRGB(255, 165, 0),
	Color3.fromRGB(255, 255, 0), 
	Color3.fromRGB(0, 255, 0),   
	Color3.fromRGB(0, 0, 255),   
	Color3.fromRGB(128, 0, 128), 
	Color3.fromRGB(255, 192, 203), 
	Color3.fromRGB(0, 0, 0),     
	Color3.fromRGB(128, 128, 128), 
	Color3.fromRGB(141, 99, 36), 
	Color3.fromRGB(255, 255, 255) 
}


local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui


local colorDisplay = Instance.new("TextLabel")
colorDisplay.Size = UDim2.new(0, 200, 0, 50)
colorDisplay.Position = UDim2.new(0, 1000, 0, 200)
colorDisplay.TextColor3 = Color3.fromRGB(255, 255, 255) 
colorDisplay.BackgroundTransparency = 1 
colorDisplay.TextStrokeTransparency = 0
colorDisplay.TextScaled = true 
colorDisplay.Text = "Current Color: " .. tostring(currentColorIndex) 
colorDisplay.Parent = screenGui 


local isGuiVisible = true 


local function updateColorDisplay()
	local color = colors[currentColorIndex]
	colorDisplay.Text = "Current Color: " .. tostring(currentColorIndex) 
	colorDisplay.TextColor3 = color 
end


local function createBlock(position)
	local block = Instance.new("Part")
	block.Size = Vector3.new(4, 4, 4) 
	block.Position = position 
	block.Anchored = true 
	block.Color = colors[currentColorIndex] 
	block.Material = Enum.Material.SmoothPlastic 
	block.Parent = workspace 
end


local function onMouseClick()
	if isPlacingEnabled then
		local targetPosition = mouse.Hit.Position


		local snappedPosition = Vector3.new(
			math.floor(targetPosition.X / 4 + 0.5) * 4,
			math.floor(targetPosition.Y / 4 + 0.5) * 4,
			math.floor(targetPosition.Z / 4 + 0.5) * 4
		)


		createBlock(snappedPosition)
	end
end


local function onKeyPress(input, gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.M then
			isPlacingEnabled = true 
		elseif input.KeyCode == Enum.KeyCode.N then
			isPlacingEnabled = false 
		elseif input.KeyCode == Enum.KeyCode.L then
			local target = mouse.Target
			if target and target:IsA("Part") and target.Size == Vector3.new(4, 4, 4) then
				target:Destroy() 
			end
		elseif input.KeyCode == Enum.KeyCode.K then

			currentColorIndex = currentColorIndex % #colors + 1
			updateColorDisplay() 
		elseif input.KeyCode == Enum.KeyCode.B then

			isGuiVisible = not isGuiVisible
			screenGui.Enabled = isGuiVisible 
		end
	end
end


updateColorDisplay()


mouse.Button1Down:Connect(onMouseClick)
UserInputService.InputBegan:Connect(onKeyPress)
