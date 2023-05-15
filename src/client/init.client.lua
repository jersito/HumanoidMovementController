--// Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--/// Variables
local localPlayer = game:GetService("Players").LocalPlayer
local robloxController = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule"))
robloxController:GetControls():Disable()

local moveDirection = Vector3.new()
local cam = workspace.CurrentCamera
local hum

--// Functions
local function Move()
	hum:Move(moveDirection)
end

--// Events
RunService.RenderStepped:Connect(function()
	local char = localPlayer.Character
	if char == nil or char:FindFirstChild("Humanoid") == nil then
		return
	end

	hum = char.Humanoid

	moveDirection = Vector3.new()

	if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then
		moveDirection += cam.CFrame.LookVector
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then
		moveDirection += cam.CFrame.LookVector * -1
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then
		moveDirection += cam.CFrame.RightVector * -1
	end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then
		moveDirection += cam.CFrame.RightVector
	end

	Move()
end)

UserInputService.InputBegan:Connect(function(key, processed)
	if processed then
		return
	end

	if key.KeyCode == Enum.KeyCode.Space then
		hum.Jump = true
	end
end)

while task.wait(math.random(1, 5)) do
	if hum == nil then
		continue
	end

	hum.WalkSpeed = math.random(10, 25)
end
