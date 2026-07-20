task.spawn(function()
    local Players = game:GetService("Players")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")

    if PlayerGui:FindFirstChild("BackspaceGUI") then
        PlayerGui.BackspaceGUI:Destroy()
    end

    local running = false
    local maxPress = 500

    local gui = Instance.new("ScreenGui")
    gui.Name = "BackspaceGUI"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,220,0,130)
    frame.Position = UDim2.new(0.5,-110,0.5,-65)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,25)
    title.BackgroundTransparency = 1
    title.Text = "Auto Backspace-Kami•Apa"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 12
    title.TextColor3 = Color3.new(1,1,1)
    title.Parent = frame

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1,-20,0,30)
    box.Position = UDim2.new(0,10,0,35)
    box.Text = tostring(maxPress)
    box.PlaceholderText = "Max Press"
    box.Font = Enum.Font.SourceSans
    box.TextSize = 20
    box.Parent = frame

    local apply = Instance.new("TextButton")
    apply.Size = UDim2.new(0.45,-5,0,30)
    apply.Position = UDim2.new(0,10,0,75)
    apply.Text = "Apply"
    apply.Font = Enum.Font.SourceSansBold
    apply.TextSize = 20
    apply.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.45,-5,0,30)
    toggle.Position = UDim2.new(0.55,0,0,75)
    toggle.Text = "Start"
    toggle.Font = Enum.Font.SourceSansBold
    toggle.TextSize = 20
    toggle.BackgroundColor3 = Color3.fromRGB(50,180,50)
    toggle.Parent = frame

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1,0,0,20)
    status.Position = UDim2.new(0,0,1,-20)
    status.BackgroundTransparency = 1
    status.Text = "Status : OFF"
    status.Font = Enum.Font.SourceSans
    status.TextSize = 18
    status.TextColor3 = Color3.new(1,1,1)
    status.Parent = frame

    apply.MouseButton1Click:Connect(function()
        local n = tonumber(box.Text)
        if n and n > 0 then
            maxPress = math.floor(n)
            print("Max Press diubah menjadi:", maxPress)
        else
            box.Text = tostring(maxPress)
        end
    end)

    local function run()
        local count = 0

        while running and count < maxPress do
            count += 1

            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Backspace, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Backspace, false, game)

            status.Text = string.format("Running : %d/%d", count, maxPress)
            print(("Backspace: %d/%d"):format(count, maxPress))

            task.wait(1)
        end

        running = false
        toggle.Text = "Start"
        toggle.BackgroundColor3 = Color3.fromRGB(50,180,50)
        status.Text = "Status : OFF"
    end

    toggle.MouseButton1Click:Connect(function()
        if running then
            running = false
            toggle.Text = "Start"
            toggle.BackgroundColor3 = Color3.fromRGB(50,180,50)
            status.Text = "Status : OFF"
        else
            running = true
            toggle.Text = "Stop"
            toggle.BackgroundColor3 = Color3.fromRGB(180,50,50)
            status.Text = "Status : ON"
            task.spawn(run)
        end
    end)

end)
