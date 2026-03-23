print("NBD Car Fly - Loaded | by ProjectMikoyan")

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Destroy existing instance if re-executing
if CoreGui:FindFirstChild("NBDCarFly") then
    CoreGui.NBDCarFly:Destroy()
end

local Flymguiv2 = Instance.new("ScreenGui")
Flymguiv2.Name = "NBDCarFly"
Flymguiv2.Parent = CoreGui
Flymguiv2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Container (Dark Background)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = Flymguiv2
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Starts at 0 for animation
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0.7, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "NBD Car Fly"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Parent = MainFrame
Close.AnchorPoint = Vector2.new(1, 0)
Close.Position = UDim2.new(1, 0, 0, 0)
Close.Size = UDim2.new(0, 45, 0, 40)
Close.BackgroundColor3 = Color3.fromRGB(255, 140, 0) -- Orange
Close.BorderSizePixel = 0
Close.Font = Enum.Font.GothamBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 20

-- Speed Input Container
local SpeedContainer = Instance.new("Frame")
SpeedContainer.Name = "SpeedContainer"
SpeedContainer.Parent = MainFrame
SpeedContainer.AnchorPoint = Vector2.new(0.5, 0)
SpeedContainer.Position = UDim2.new(0.5, 0, 0, 65)
SpeedContainer.Size = UDim2.new(0.85, 0, 0, 35)
SpeedContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = SpeedContainer

local Speed = Instance.new("TextBox")
Speed.Name = "Speed"
Speed.Parent = SpeedContainer
Speed.BackgroundTransparency = 1
Speed.Size = UDim2.new(1, 0, 1, 0)
Speed.Font = Enum.Font.GothamBlack
Speed.Text = "150"
Speed.TextColor3 = Color3.fromRGB(0, 0, 0)
Speed.TextStrokeColor3 = Color3.fromRGB(255, 140, 0)
Speed.TextStrokeTransparency = 0 -- Gives the orange outline from the image
Speed.TextSize = 22

-- Keybinds List
local KeyList = Instance.new("TextLabel")
KeyList.Name = "KeyList"
KeyList.Parent = MainFrame
KeyList.BackgroundTransparency = 1
KeyList.Position = UDim2.new(0, 15, 0, 120)
KeyList.Size = UDim2.new(0.9, 0, 0, 80)
KeyList.Font = Enum.Font.GothamSemibold
KeyList.Text = "[U] Toggle Fly\n[V] Hide Menu\n[W/S] Move Forward/Back"
KeyList.TextColor3 = Color3.fromRGB(240, 240, 240)
KeyList.TextSize = 14
KeyList.TextXAlignment = Enum.TextXAlignment.Left
KeyList.TextYAlignment = Enum.TextYAlignment.Top

-- Fly Status
local FlyStatus = Instance.new("TextLabel")
FlyStatus.Name = "FlyStatus"
FlyStatus.Parent = MainFrame
FlyStatus.BackgroundTransparency = 1
FlyStatus.AnchorPoint = Vector2.new(0.5, 0)
FlyStatus.Position = UDim2.new(0.5, 0, 0, 215)
FlyStatus.Size = UDim2.new(1, 0, 0, 20)
FlyStatus.Font = Enum.Font.GothamBold
FlyStatus.Text = "FLY: OFF"
FlyStatus.TextColor3 = Color3.fromRGB(255, 60, 60) -- Red
FlyStatus.TextSize = 15

--- ANIMATION & DRAGGING LOGIC ---

-- Opening Animation
local targetSize = UDim2.new(0, 260, 0, 290)
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local openTween = TweenService:Create(MainFrame, tweenInfo, {Size = targetSize})
openTween:Play()

-- Smooth Dragging Setup
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Close Button Animation & Logic
Close.MouseButton1Click:Connect(function()
    local closeInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local closeTween = TweenService:Create(MainFrame, closeInfo, {Size = UDim2.new(0, 0, 0, 0)})
    closeTween:Play()
    closeTween.Completed:Wait()
    Flymguiv2:Destroy()
end)

--- FLY LOGIC ---

local function movePlayer(direction)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart:FindFirstChild("BodyVelocity") then
        local BV = char.HumanoidRootPart.BodyVelocity
        local speedVal = tonumber(Speed.Text) or 150
        for i = 1, 8 do
            BV.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * (speedVal * direction)
            task.wait(0.05)
        end
        BV.Velocity = Vector3.new(0, 0, 0)
    end
end

local function toggleFly()
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local HumanoidRP = char.HumanoidRootPart

    if FlyStatus.Text == "FLY: OFF" then
        FlyStatus.Text = "FLY: ON"
        FlyStatus.TextColor3 = Color3.fromRGB(60, 255, 60) -- Green
        
        local BV = Instance.new("BodyVelocity", HumanoidRP)
        local BG = Instance.new("BodyGyro", HumanoidRP)
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        _G.FlyConn = RunService.RenderStepped:Connect(function()
            if HumanoidRP:FindFirstChild("BodyGyro") then
                BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                BG.D = 5000
                BG.P = 100000
                BG.CFrame = game.Workspace.CurrentCamera.CFrame
            end
        end)
    else
        FlyStatus.Text = "FLY: OFF"
        FlyStatus.TextColor3 = Color3.fromRGB(255, 60, 60) -- Red
        
        if _G.FlyConn then _G.FlyConn:Disconnect() end
        if HumanoidRP:FindFirstChild("BodyVelocity") then HumanoidRP.BodyVelocity:Destroy() end
        if HumanoidRP:FindFirstChild("BodyGyro") then HumanoidRP.BodyGyro:Destroy() end
    end
end

--- INPUT HANDLER ---
local menuVisible = true

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    
    if input.KeyCode == Enum.KeyCode.U then 
        toggleFly() 
    end
    
    if input.KeyCode == Enum.KeyCode.V then 
        menuVisible = not menuVisible
        Flymguiv2.Enabled = menuVisible
    end
    
    if FlyStatus.Text == "FLY: ON" then
        if input.KeyCode == Enum.KeyCode.W then 
            movePlayer(1)
        elseif input.KeyCode == Enum.KeyCode.S then 
            movePlayer(-1) 
        end
    end
end)
