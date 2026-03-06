print("Script Made By ProjectMikoyan")

print("NBD Car Fly - Loaded | by ProjectMikoyan")



local UIS = game:GetService("UserInputService")

local RunService = game:GetService("RunService")

local Flymguiv2 = Instance.new("ScreenGui")

local Drag = Instance.new("Frame")

local FlyFrame = Instance.new("Frame")

local Title = Instance.new("TextLabel")

local Subtitle = Instance.new("TextLabel")

local SpeedInfo = Instance.new("TextLabel")

local Speed = Instance.new("TextBox")

local Stat2 = Instance.new("TextLabel")

local KeyList = Instance.new("TextLabel")

local Close = Instance.new("TextButton")



-- GUI Main Setup

Flymguiv2.Name = "NBDCarFly"

Flymguiv2.Parent = game.CoreGui

Flymguiv2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling



-- Main Orange Header

Drag.Name = "Drag"

Drag.Parent = Flymguiv2

Drag.Active = true

Drag.BackgroundColor3 = Color3.fromRGB(255, 140, 0) -- Orange

Drag.BorderSizePixel = 0

Drag.Draggable = true

Drag.Position = UDim2.new(0.4, 0, 0.4, 0)

Drag.Size = UDim2.new(0, 237, 0, 45)



Title.Name = "Title"

Title.Parent = Drag

Title.BackgroundTransparency = 1

Title.Position = UDim2.new(0, 0, 0, 2)

Title.Size = UDim2.new(1, 0, 0, 25)

Title.Font = Enum.Font.SourceSansBold

Title.Text = "NBD Car Fly"

Title.TextColor3 = Color3.fromRGB(255, 255, 255)

Title.TextScaled = true



Subtitle.Name = "Subtitle"

Subtitle.Parent = Drag

Subtitle.BackgroundTransparency = 1

Subtitle.Position = UDim2.new(0, 0, 0, 22)

Subtitle.Size = UDim2.new(1, 0, 0, 20)

Subtitle.Font = Enum.Font.SourceSansItalic

Subtitle.Text = "by ProjectMikoyan" -- Updated Branding

Subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)

Subtitle.TextSize = 14



-- Dark Main Body

FlyFrame.Name = "FlyFrame"

FlyFrame.Parent = Drag

FlyFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

FlyFrame.BorderSizePixel = 0

FlyFrame.Position = UDim2.new(0, 0, 1, 0)

FlyFrame.Size = UDim2.new(0, 237, 0, 210)



-- Speed Instruction Label

SpeedInfo.Name = "SpeedInfo"

SpeedInfo.Parent = FlyFrame

SpeedInfo.BackgroundTransparency = 1

SpeedInfo.Position = UDim2.new(0, 0, 0.05, 0)

SpeedInfo.Size = UDim2.new(1, 0, 0, 20)

SpeedInfo.Font = Enum.Font.SourceSans

SpeedInfo.Text = "Changing this changes speed"

SpeedInfo.TextColor3 = Color3.fromRGB(255, 140, 0)

SpeedInfo.TextSize = 14



Speed.Name = "Speed"

Speed.Parent = FlyFrame

Speed.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

Speed.BorderSizePixel = 0

Speed.Position = UDim2.new(0.1, 0, 0.18, 0)

Speed.Size = UDim2.new(0.8, 0, 0, 30)

Speed.Font = Enum.Font.SourceSans

Speed.Text = "150" -- Default Speed at 150

Speed.TextColor3 = Color3.fromRGB(255, 255, 255)

Speed.TextScaled = true



-- Keybinds List

KeyList.Name = "KeyList"

KeyList.Parent = FlyFrame

KeyList.BackgroundTransparency = 1

KeyList.Position = UDim2.new(0.05, 0, 0.45, 0)

KeyList.Size = UDim2.new(0.9, 0, 0, 70)

KeyList.Font = Enum.Font.SourceSans

KeyList.Text = "[U] Toggle Fly\n[V] Hide Menu\n[R] Boost Forward\n[F] Boost Backward"

KeyList.TextColor3 = Color3.fromRGB(255, 255, 255)

KeyList.TextSize = 16

KeyList.TextXAlignment = Enum.TextXAlignment.Left



Stat2.Name = "Stat2"

Stat2.Parent = FlyFrame

Stat2.BackgroundTransparency = 1

Stat2.Position = UDim2.new(0, 0, 0.8, 0)

Stat2.Size = UDim2.new(1, 0, 0, 30)

Stat2.Font = Enum.Font.SourceSansBold

Stat2.Text = "STATUS: OFF"

Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)

Stat2.TextSize = 20



Close.Name = "Close"

Close.Parent = Drag

Close.BackgroundColor3 = Color3.fromRGB(255, 140, 0)

Close.BackgroundTransparency = 1

Close.Position = UDim2.new(0.88, 0, 0, 0)

Close.Size = UDim2.new(0, 27, 0, 27)

Close.Text = "X"

Close.TextColor3 = Color3.fromRGB(255, 255, 255)

Close.TextSize = 20

Close.MouseButton1Click:Connect(function() Flymguiv2:Destroy() end)



--- LOGIC FUNCTIONS ---

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



    if Stat2.Text == "STATUS: OFF" then

        Stat2.Text = "STATUS: ON"

        Stat2.TextColor3 = Color3.fromRGB(0, 255, 0)

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

        Stat2.Text = "STATUS: OFF"

        Stat2.TextColor3 = Color3.fromRGB(255, 0, 0)

        if _G.FlyConn then _G.FlyConn:Disconnect() end

        if HumanoidRP:FindFirstChild("BodyVelocity") then HumanoidRP.BodyVelocity:Destroy() end

        if HumanoidRP:FindFirstChild("BodyGyro") then HumanoidRP.BodyGyro:Destroy() end

    end

end



--- INPUT HANDLER ---

UIS.InputBegan:Connect(function(input, gpe)

    if gpe then return end

    if input.KeyCode == Enum.KeyCode.U then toggleFly() end

    if input.KeyCode == Enum.KeyCode.V then Flymguiv2.Enabled = not Flymguiv2.Enabled end

    if Stat2.Text == "STATUS: ON" then

        if input.KeyCode == Enum.KeyCode.R then movePlayer(1)

        elseif input.KeyCode == Enum.KeyCode.F then movePlayer(-1) end

    end

end)
