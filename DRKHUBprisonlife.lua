pcall(function()if game.PlaceId == 155615604 then
    game.StarterGui:SetCore("SendNotification", {
    Title = "Notification";
    Text = "DRKscripts on top"; -- what the text says (ofc)
    Duration = 10;
  })
  local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Kavo%20ui%20lib"))()
  local Window = Library.CreateLib("DRK Hub - Prison life", "Sentinel")
  
        -- Auto kill all 
        local Main = Window:NewTab("Main")
        local MainSection = Main:NewSection("Rage")
  
        local isAutoKillRunning = false -- Variable to track the state of the auto-kill loop
  
        local function AutoKillLoop()
            while isAutoKillRunning do
                for i,v in next, game:GetService("Players"):GetChildren() do
                    pcall(function()
                        if v ~= game:GetService("Players").LocalPlayer and not v.Character:FindFirstChildOfClass("ForceField") and v.Character.Humanoid.Health > 0 then
                            while v.Character:WaitForChild("Humanoid").Health > 0 and isAutoKillRunning do
                                task.wait()
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                                for v, c in next, game:GetService("Players"):GetChildren() do
                                    if c ~= game:GetService("Players").LocalPlayer then
                                        game.ReplicatedStorage.meleeEvent:FireServer(c)
                                    end
                                end
                            end
                        end
                    end)
                    task.wait()
                end
            end
        end
  
        -- Automatic jump when sitting
        local function AutoJump()
            while isAutoKillRunning do
                if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
                    local humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
                    if humanoid.Sit then
                        humanoid.Jump = true
                    end
                end
                task.wait()
            end
        end
  
        MainSection:NewToggle("Loop Tp Kill All (Use With Kill Aura)", "Kill everyone inside the server, will jump if seated", function(state)
            if state then
                print("Toggle On")
                isAutoKillRunning = true
                spawn(AutoKillLoop)
                spawn(AutoJump) -- Start the automatic jump function
            else
                print("Toggle Off")
                isAutoKillRunning = false
            end
        end)    
  
        --Killaura
  
        local Parts = {}
        local States = {}
        local plr = game.Players.LocalPlayer
        local char = plr.Character
  
         MainSection:NewToggle("Kill Aura", "Toggle Kill Aura", function(state)
        States.KillAura = state
        if state then
            print("Kill Aura On")
            CreateKillPart()
        else
            print("Kill Aura Off")
            if Parts[1] and Parts[1].Name == "KillAura" then
                Parts[1]:Destroy()
                Parts[1] = nil
            end
         end
        end)
  
        function CreateKillPart()
            if Parts[1] then
             pcall(function()
                 Parts[1]:Destroy()
             end)
             Parts[1] = nil
        end
        local Part = Instance.new("Part",plr.Character)
        local hilight = Instance.new("Highlight",Part)
        hilight.FillTransparency = 1
  
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanTouch = false
        Part.Material = Enum.Material.SmoothPlastic
        Part.Transparency = .98
        Part.Material = Enum.Material.SmoothPlastic
        Part.BrickColor = BrickColor.White()
        Part.Size = Vector3.new(20,2,20)
        Part.Name = "KillAura"
        Parts[1] = Part
     end
  
     task.spawn(function()
        repeat task.task.wait()until plr.Character and char and char:FindFirstChildOfClass("Humanoid")
  
        if States.KillAura then
            CreateKillPart()
        end
      end)
  
     game:GetService("RunService").Stepped:Connect(function()
        if States.KillAura then
            for i,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    if (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude <14 and v.Character.Humanoid.Health >0 then
                        local args = {
                            [1] = v
                        }
                        for i =1,2 do
                            task.spawn(function()
                                game:GetService("ReplicatedStorage").meleeEvent:FireServer(unpack(args))
                            end)
                        end
                    end
                end
            end
        end  
     end)
  
       --loop tp
     local plr = game.Players.LocalPlayer
     local char = plr.Character
  
     MainSection:NewTextBox("Teleport to Player", "Enter part of a player's username", function(txt)
         local players = game.Players:GetPlayers()
         local target
         for i, player in pairs(players) do
             if string.find(string.lower(player.Name), string.lower(txt)) then
                 target = player
                 break
             end
         end
         if target then
             local targetChar = target.Character
             if targetChar then
                 local targetPos = targetChar.HumanoidRootPart.Position
                 char:MoveTo(targetPos + Vector3.new(0,0,2))
                 print("Teleported to "..target.Name)
             else
                 print(target.Name.." does not have a character in the game")
             end
         else
             print("No player found with username containing "..txt)
         end
     end)
  
     MainSection:NewButton("Teleport Tool", "Tool", function()
  game.StarterGui:SetCore("SendNotification", {
    Title = "Teleport Tool";
    Text = "Made by Riotscripter"; -- what the text says (ofc)
    Duration = 5;
  })
  
  local LocalPlayer = game.Players.LocalPlayer
  
  local rp = LocalPlayer.Character.HumanoidRootPart
  
  local tool = Instance.new("Tool",LocalPlayer.Backpack)
  
  local mouse = LocalPlayer:GetMouse()
  
  tool.Name = "Teleport Tool"
  
  tool.RequiresHandle = false
  
  tool.Activated:Connect(function()
  
    rp.CFrame = CFrame.new(mouse.Hit.X,mouse.Hit.Y + 4,mouse.Hit.Z)
  
  end)
  
  end)
  
     MainSection:NewButton("Infinite Jump", "", function()
        print("Clicked")
  
  local InfiniteJumpEnabled = true
  game:GetService("UserInputService").JumpRequest:connect(function()
  if InfiniteJumpEnabled then
    game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
  end
  end)
        print("Ready")
    end)
  
    MainSection:NewButton("Prison Ware", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/PRISONWARE_v1.3.txt"))();
        print("Ready")
    end)
  
    MainSection:NewButton("Prison Ruiner (Patched)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet('https://pastebin.com/raw/iZ64yzjE'))();
        print("Ready")
    end)
  
     MainSection:NewButton("Reset (Kills You)", "", function()
        print("Clicked")
  
  game.Players.LocalPlayer.Character.Humanoid.Health = 0
        print("Ready")
    end)
  
     MainSection:NewButton("Kill Aura V2", "", function()
        print("Clicked")
  
   while task.wait () do
  for i, e in pairs(game.Players:GetChildren()) do
                        if e ~= game.Players.LocalPlayer then
                            local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                            meleeEvent:FireServer(e)
  
                        end end end 
        print("Ready")
    end)
  
     MainSection:NewButton("Super Speed", "Runs to 111 speed", function()
  
  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 111
   print("Ready")
    end)
  
    local Player = Window:NewTab("Player")
    local PlayerSection = Player:NewSection("Visuals")
  
    PlayerSection:NewToggle("Fullbright ", "Makes u be able to see in night", function() -------- FullBRIGHT
        print("Clicked")
        loadstring(game:HttpGet('https://raw.githubusercontent.com/XxReisWolfxX/fullbright/main/fbscript'))();
        print("Applyd")
    end)
  
    PlayerSection:NewSlider("Fov", "Change ur fov", 130, 70, function(s) 
        game:GetService'game.Workspace'.Camera.FieldOfView = s
    end)
  
    PlayerSection:NewButton("Anti lag", "Boosts fps", function()
  
  -- Made by Riotscripter
  getgenv().Settings = {
    Players = {
        ["Ignore Me"] = true, -- Ignore your Character
        ["Ignore Others"] = true -- Ignore other Characters
    },
    Meshes = {
        Destroy = false, -- Destroy Meshes
        LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
    },
    Images = {
        Invisible = true, -- Invisible Images
        LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
        Destroy = false, -- Destroy Images
    },
    ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
    ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
    ["No Explosions"] = true, -- Makes Explosion's invisible
    ["No Clothes"] = true, -- Removes Clothing from the game
    ["Low Water Graphics"] = true, -- Removes Water Quality
    ["No Shadows"] = true, -- Remove Shadows
    ["Low Rendering"] = true, -- Lower Rendering
    ["Low Quality Parts"] = true -- Lower quality parts
  }
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/FPSBOOSTER.lua"))()   
   print("Ready")
    end)
  
    PlayerSection:NewToggle("Add RTX", "Adds a shader", function(state)
        if state then
            local find1 = game.Lighting:FindFirstChildWhichIsA("BloomEffect")
            if find1 then
                game.Lighting:FindFirstChildWhichIsA("BloomEffect"):Destroy()
            end
            local find2 = game.Lighting:FindFirstChildWhichIsA("SunRaysEffect")
            if find2 then
                game.Lighting:FindFirstChildWhichIsA("SunRaysEffect"):Destroy()
            end
            local find3 = game.Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect")
            if find3 then
                game.Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect"):Destroy()
            end
            local find4 = game.Lighting:FindFirstChildWhichIsA("BlurEffect")
            if find4 then
                game.Lighting:FindFirstChildWhichIsA("BlurEffect"):Destroy()
            end
            local find5 = game.Lighting:FindFirstChildWhichIsA("Sky")
            if find5 then
                game.Lighting:FindFirstChildWhichIsA("Sky"):Destroy()
            end
            local blem = Instance.new("BloomEffect",game.Lighting)
            local sanrey = Instance.new("SunRaysEffect",game.Lighting)
            local color = Instance.new("ColorCorrectionEffect",game.Lighting)
            local blor = Instance.new("BlurEffect",game.Lighting)
            Instance.new("Sky",game.Lighting)
            game.Lighting.ExposureCompensation = 0.34
            game.Lighting.ShadowSoftness = 1
            game.Lighting.EnvironmentDiffuseScale = 0.343
            game.Lighting.EnvironmentSpecularScale = 1
            game.Lighting.Brightness = 2
            game.Lighting.ColorShift_Top = Color3.fromRGB(118,117,108)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(141,141,141)
            game.Lighting.GeographicLatitude = 100
            game.Lighting.Ambient = Color3.fromRGB(112,112,112)
            blem.Intensity = 0.5
            blem.Size = 22
            blem.Threshold = 1.5
            sanrey.Intensity = 0.117
            sanrey.Spread = 1
            blor.Size = 2
            color.Contrast = 0.3
            color.Saturation = 0.2
            color.TintColor = Color3.fromRGB(255,252,224)
        else 
           local find1 = game.Lighting:FindFirstChildWhichIsA("BloomEffect")
           if find1 then
               game.Lighting:FindFirstChildWhichIsA("BloomEffect"):Destroy()
           end
  
           local find2 = game.Lighting:FindFirstChildWhichIsA("SunRaysEffect")
           if find2 then
               game.Lighting:FindFirstChildWhichIsA("SunRaysEffect"):Destroy()
           end
  
           local find3 = game.Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect")
           if find3 then
               game.Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect"):Destroy()
           end
  
           local find4 = game.Lighting:FindFirstChildWhichIsA("BlurEffect")
           if find4 then
               game.Lighting:FindFirstChildWhichIsA("BlurEffect"):Destroy()
           end
  
           local find5 = game.Lighting:FindFirstChildWhichIsA("Sky")
           if find5 then
               game.Lighting:FindFirstChildWhichIsA("Sky"):Destroy()
           end
  
           -- Reset lighting properties to default values.
           game.Lighting.ExposureCompensation = 0 
           game.Lighting.ShadowSoftness = 0 
           game.Lighting.EnvironmentDiffuseScale = 1 
           game.Lighting.EnvironmentSpecularScale = 1 
           game.Lighting.Brightness = 1 
           game.Lighting.ColorShift_Top = Color3.fromRGB(0,0,0) 
           game.Lighting.OutdoorAmbient = Color3.fromRGB(127,127,127) 
           game.Lighting.GeographicLatitude=41.733299255371094 
           game.Lighting.Ambient=Color3.fromRGB(127,127,127) 
        end 
    end)
  
    local cam = game.Workspace.CurrentCamera
    local noclip = false
  
    PlayerSection:NewToggle("Freeze cam", "Freezes ur cam", function(state)
        noclip = state
        if state then
            print("Freeze cam")
            cam.CameraSubject = nil
            cam.CameraType = Enum.CameraType.Scriptable
        else
            print("Freeze cam Off")
            cam.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
            cam.CameraType = Enum.CameraType.Custom
        end
    end)
  
    local PlayerSection = Player:NewSection("Movement") 
  
    PlayerSection:NewSlider("Walkspeed", "changes ur speed, pretty cool i guessss", 100, 16, function(s) 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)
    PlayerSection:NewSlider("JumpPower", "Be a lil monkey", 100, 50, function(s) 
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
    end)
  
    PlayerSection:NewButton("Inf Stamina", "Infinite amount of Stamina", function()
        local plr = game:GetService("Players").LocalPlayer
     for i,v in next, getgc() do 
        if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
            for i2,v2 in next, debug.getupvalues(v) do 
                if type(v2) == "number" then 
                    debug.setupvalue(v, i2, math.huge)
                end
            end
        end
     end
        print("Clicked")
    end)
  
    PlayerSection:NewTextBox("NoClip -Use Keybind v", "Adds a key to ur no clip!", function(NoClip)
        print("key set to "..NoClip)
        local StealthMode = true -- If game has an anticheat that checks the logs
  
        local Indicator
  
        if not StealthMode then
            local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
            Indicator = Instance.new("TextLabel", ScreenGui)
            Indicator.AnchorPoint = Vector2.new(0, 1)
            Indicator.Position = UDim2.new(0, 0, 1, 0)
            Indicator.Size = UDim2.new(0, 200, 0, 50)
            Indicator.BackgroundTransparency = 1
            Indicator.TextScaled = true
            Indicator.TextStrokeTransparency = 0
            Indicator.TextColor3 = Color3.new(0, 0, 0)
            Indicator.TextStrokeColor3 = Color3.new(1, 1, 1)
            Indicator.Text = "Noclip: Enabled"
        end
  
        local noclip = true
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
  
        local mouse = player:GetMouse()
  
        mouse.KeyDown:Connect(function(key)
            if key == NoClip then
                noclip = not noclip
  
                if not StealthMode then
                    Indicator.Text = "Noclip: " .. (noclip and "Enabled" or "Disabled")
                end
            end
        end)
  
        while true do
            player = game.Players.LocalPlayer
            character = player.Character
  
            if noclip then
                for i, v in pairs(character:GetDescendants()) do
                    pcall(function()
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end)
                end
            end
  
            game:GetService("RunService").Stepped:Wait()
        end
    end)
  
    local Admin = Window:NewTab("Admin")
    local AdminSection = Admin:NewSection("Admin Guis (Credits To Their Rightful Owners)")
  
    AdminSection:NewButton("Nameless Admin", "", function()
        print("Clicked")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))();
        print("Ready")
    end)
  
    AdminSection:NewButton("Infinite Yield", "", function()
        print("Clicked")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))();
        print("Ready")
    end)
    
    AdminSection:NewButton("Nameless Admin", "", function()
        print("Clicked")
        loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Nameless-Admin-no-byfron-ui-11288"))();
        print("Ready")
    end)
  
    AdminSection:NewButton("Reviz Admin v2", "", function()
        print("Clicked")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Pa1ntex/reviz-admin-v2-script-FE/main/Reviz%20admin%20v2%20FE"))();
        print("Ready")
    end)
    
    AdminSection:NewButton("Chat Bypasser", "", function()
        print("Clicked")
        loadstring(game:HttpGet("https://pastebin.ai/raw/lstrrfipqq"))();
        print("Ready")
    end)
    
    AdminSection:NewButton("Titan Admin (Made by me!)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Titan%20Admin"))()
        print("Ready")
    end)

    AdminSection:NewButton("Prizzlife Admin (Made by me!)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Prizz%20life"))()
        print("Ready")
    end)
  
    AdminSection:NewButton("Riots Tiger Admin (New Tiger Admin!)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Dalloc%20Tiger%20Admin%202"))()
        print("Ready")
    end)
    
   AdminSection:NewButton("Old Tiger Admin", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Old%20Tiger%20Admin"),true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Death Panel Admin (Black Tiger Admin Gui)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Death%20Panel%20Admin"))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Riots Admin (Made By Me)", "", function()
             print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Riots%20Admin"))()
        print("Ready")
    end)
    
  AdminSection:NewButton("Xenon Admin (Made By Me) (Chat Admin Commands)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Xenon%20Admin"),true))()
        print("Ready")
    end)
  
    AdminSection:NewButton("Lightux Admin (Needs Key)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/cool83birdcarfly02six/Lightux/main/README.md"),true))()    
        print("Ready")
    end)
    
    AdminSection:NewButton("Lightux Lite (Needs Key)", "", function()
         print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/cool83birdcarfly02six/LTXLITE/main/README.md"))()
        print("Ready")
    end)
    
    AdminSection:NewButton("Lightux Esp (Keyless)", "", function()
         print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/UNIVERSALESPLTX/main/README.md"))()
        print("Ready")
    end)
  
    AdminSection:NewButton("Prison Ware", "", function()
        print("Clicked")
  
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Denverrz/scripts/master/PRISONWARE_v1.3.txt"))();
        print("Ready")
    end)
  
    AdminSection:NewButton("Btools (NOT FE)", "", function()
        print("Clicked")
  
  local tool1   = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
  tool1.BinType = "Hammer"
   print("Ready")
    end)
  
      AdminSection:NewButton("Prevail X (Works)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://pastebin.com/raw/mHfK0Xk4", true))()
        print("Ready")
    end)
  
      AdminSection:NewButton("Prevail X And Prison Ruiner", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Prison%20Life%20Script%202022.txt"),true))()
        print("Ready")
    end)
  
      AdminSection:NewButton("Fling Gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Fling%20Gui.md"),true))()
        print("Ready")
    end)
  
      AdminSection:NewButton("02hacks Prevail X", "", function()
        print("Clicked")
  
  --[[
    88""Yb  88""Yb  888888 Yb    dP    db     88  88      Yb  dP
    88__dP  88__dP  88__    Yb  dP    dPYb    88  88       YbdP 
    88"""   88"Yb   88""     YbdP    dP__Yb   88  88  .o   dPYb 
    88      88  Yb  888888    YP    dP""""Yb  88  88ood8  dP  Yb  ~02hacks
  ]]
  loadstring(game:HttpGet("https://pastebin.com/raw/mHfK0Xk4", true))()
        print("Ready")
    end)
  
      AdminSection:NewButton("GodMode", "", function()
        print("Clicked")
  
  local p=game.Players.LocalPlayer;
  local oldcframe;
  local holdingfoil=false;
  p.Character.Humanoid:SetStateEnabled(15,false);
  p.Character.Humanoid:SetStateEnabled(16,false);
  -- p.Character.Humanoid:SetStateEnabled(18,false);
  p.CharacterRemoving:Connect(function()
    if (p.Character) then
        local t=p.Character:FindFirstChild("Torso")
        if (t ~= nil) then oldcframe=t.CFrame end
        if (p.Character:findFirstChild("Foil")) then holdingfoil=true end
    end
  end)
  p.CharacterAdded:Connect(function()
    while p.Character==nil do task.wait() end
    while p.Character.Parent==nil do task.wait() end
    local h=p.Character:WaitForChild("Humanoid")
    local rp=p.Character:WaitForChild("HumanoidRootPart")
    --[[ created by static / "Des" ]]
    if (h ~= nil and rp ~= nil) then
        h:SetStateEnabled(15,false);
        h:SetStateEnabled(16,false);
        -- h:SetStateEnabled(18,false);
        for i=1,10 do
            rp.CFrame=oldcframe;
        end
        if (holdingfoil) then
            holdingfoil=false
            local foil=p.Backpack:FindFirstChild("Foil")
            if (foil ~= nil) then
                foil.Parent=p.Character
            end
        end
    end
  end)
        print("Ready")
    end)
  
  AdminSection:NewButton("Chat Bypasser", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Suno0526/Faith/main/module.lua", true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Ez Admin (Patched)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://pastebin.com/raw/gQ4ugY1Q", true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Willy Prison Admin (Patched)", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://pastebin.com/raw/VwELNvdc", true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("FE Sound Spam (Warning EarRape)", "", function()
        print("Clicked")
  
  -- Works in any game where RespectFilteringEnabled option is false
  -- !! If it doesn't say success, try it on a different game, usually an older game will work. !!
  
  --[[ 
  A few games i've tested it on:
  https://www.roblox.com/games/12109643/Fencing
  https://www.roblox.com/games/189707/Natural-Disaster-Survival
  https://www.roblox.com/games/192800/Work-at-a-Pizza-Place
  https://www.roblox.com/games/6441847031/CHAOS
  https://www.roblox.com/games/155615604/Prison-Life
  Works on a lot more games than this, you just need to find them! ~ trial and error :)
  --]]
  
  local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()
  local SoundService = game:GetService("SoundService")
  
  if SoundService.RespectFilteringEnabled == false then
  Notification.new("success", "Success", "Everyone can hear the sounds in this game!")
  Notification.new("message", "YouTube : Riotscripter", "YouTube - Riotscripter")
  else
  Notification.new("warning", "Warning", "Unfortunately no one else can hear it in this game, try a different one.\nMaybe an older game will work.")
  end
  
  while task.wait() do
  for i, sound in next, game.Workspace:GetDescendants() do
    if sound:IsA("Sound") then
      sound.Volume = 10
      sound:Play()
    end
  end
  end
        print("Ready")
    end)
  
  AdminSection:NewButton("Fe Grab Knife", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Fe%20Grab%20Knife"),true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Hacker Chat Bypasser", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts-3/main/hacker%20chat.lua"))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Dev Ware", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://pastebin.com/raw/EWDRqhUC", true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("H4X Admin", "", function()
             print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/H4X-ADMIN"))()
        print("Ready")
    end)
    
   AdminSection:NewButton("Rawnder Admin/XRawnder", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/xRawnder/main/x-Rawnder/(1)"))();
        print("Ready")
    end)
  
  AdminSection:NewButton("Dark Ware", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/WhackyCode/DarkWare/main/loader.lua"),true))()
   print("Ready")
    end)
  
  AdminSection:NewButton("GoTo Player Gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/GoTo%20Player%20Gui"),true))()
   print("Ready")
    end)
  
  AdminSection:NewButton("Prison Life Fling Gui", "", function()
             print("Clicked")
  
  loadstring(game:HttpGet("https://github.com/Riotscripter/RiotExploits/blob/main/Prison%20Life%20Fling%20Gui"))()
    print("Ready")
   end)
  
  AdminSection:NewButton("Dalloc Admin", "", function()
        print("Clicked")
  
  getgenv().KeyBind = "RightShift"; 
  getgenv().oldUi = true --set this to false for that new ui which most of u hate
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Dalloc%20Admin"))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Dalloc Admin V2", "", function()
        print("Clicked")
  
  getgenv().KeyBind = "RightShift"; 
  getgenv().oldUi = false --set this to false for that new ui which most of u hate
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Dalloc%20Admin"))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Juanko Prison Admin Hub", "", function()
        print("Clicked")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Juanko%20Admin"))();
        print("Ready")
    end)
    
  AdminSection:NewButton("Fly gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet('https://pastebin.com/raw/5AztwCYD'))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Space Hub", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/spacvehubloader"))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Riot Prison Gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Riot%20Prison%20Gui"))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Zombie Fling", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://pastefy.app/w7KnPY70/raw"),true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Riot Prison Life Gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/RiotExploits/RiotExploits/main/Riot%20Prison%20Life%20Gui"),true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Prison Life Gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Prison%20Life%20Gui"))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Prison Life Gui 2", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Prison%20Life%20Gui%202"),true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Corgi Prison Admin", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Corgi%20Gui"))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Corgi Fling Gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Corgi%20Fling%20Gui"))())
        print("Ready")
    end)
  
  AdminSection:NewButton("Tool Giver", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Prison%20life%20tool%20giver"),true))()
        print("Ready")
    end)
  
  AdminSection:NewButton("Mobile Crouch Gui", "", function()
        print("Clicked")
  
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Riotscripter/RiotExploits/main/Prison%20life%20crouch%20gui"))();
        print("Ready")
    end)
  
    local Guns = Window:NewTab("Guns")
    local GunsSection = Guns:NewSection("Guns/Items")
  
    GunsSection:NewButton("Get All Guns", "", function()
        print("Clicked")
  
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(822, 101, 2251, 1, -0, 0, 0, 1, 0, -0, -0, 1)
  task.wait(1.1)
  local args = {
    [1] = game.Workspace:WaitForChild("Prison_ITEMS"):WaitForChild("giver"):WaitForChild("M9"):WaitForChild("ITEMPICKUP")
  }
  
  game.Workspace:WaitForChild("Remote"):WaitForChild("ItemHandler"):InvokeServer(unpack(args))
  task.wait(1.1)
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(824.801025, 104.330627, 2250.36157, 0.173624337, 0.984811902, 0, -0.984811902, 0.173624337, -0, -0, 0, 1)
  task.wait(1.1)
  local args = {
    [1] = game.Workspace:WaitForChild("Prison_ITEMS"):WaitForChild("giver"):WaitForChild("Remington 870"):WaitForChild("ITEMPICKUP")
  }
  
  game.Workspace:WaitForChild("Remote"):WaitForChild("ItemHandler"):InvokeServer(unpack(args))
  task.wait(1.1)
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-936.710632, 93.5627747, 2054.66602, 0, -1, 0, 1, 0, -0, 0, 0, 1)
  task.wait(1.1)
  local args = {
    [1] = game.Workspace:WaitForChild("Prison_ITEMS"):WaitForChild("giver"):WaitForChild("AK-47"):WaitForChild("ITEMPICKUP")
  }
  
  game.Workspace:WaitForChild("Remote"):WaitForChild("ItemHandler"):InvokeServer(unpack(args))
        print("Ready")
    end)
 
    GunsSection:NewButton("Get M9", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.giver["M9"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get AK-47", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.giver["AK-47"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get Remington 870", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.giver["Remington 870"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get M4A1 (Requires Riot Gamepass!)", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.giver["M4A1"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get Riot Shield (Requires Riot Gamepass!)", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.giver["Riot Shield"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get Hammer", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.single["Hammer"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get Crude Knife", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.single["Crude Knife"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get Key card (Must be dropped!)", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.single["Key card"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get Police hat", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.hats["Police hat"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get Riot helmet", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.hats["Riot helmet"]})    
        print("Ready")
    end)
    
    GunsSection:NewButton("Get Ski mask", "", function()
        print("Clicked")

  game.Workspace.Remote.ItemHandler:InvokeServer({Position = game.Players.LocalPlayer.Character.Head.Position, Parent = game.Workspace.Prison_ITEMS.hats["Ski mask"]})    
        print("Ready")
    end)
  
    local GunsSection = Guns:NewSection("Modify")
    GunsSection:NewButton("Mod Guns", "This will modify all of your guns", function()
        print("Clicked")
        getgenv().loop = true
        while getgenv().loop == true do task.wait(0.5)
           game.Workspace.Remote.ItemHandler:InvokeServer(game.Workspace.Prison_ITEMS:findFirstChild('M9', true).ITEMPICKUP)
           game.Workspace.Remote.ItemHandler:InvokeServer(game.Workspace.Prison_ITEMS:findFirstChild('Remington 870', true).ITEMPICKUP)
           game.Workspace.Remote.ItemHandler:InvokeServer(game.Workspace.Prison_ITEMS:findFirstChild('AK-47', true).ITEMPICKUP)
               for i, v in next, debug.getregistry() do 
                   if type(v) == "table" then 
                       if v.Bullets then 
                       v.AutoFire = true
                       v.FireRate = 0
                       v.Bullets = 50
                       v.Range = math.huge
                       v.MaxAmmo = math.huge
                       v.CurrentAmmo = math.huge
                       v.StoredAmmo = math.huge
                   end
               end
           end
       end
        print("Ready")
    end)
  
    GunsSection:NewButton("Mod M9", "Mods that gun", function()
  
  local player = game:GetService("Players").LocalPlayer
        local gun = player.Backpack:FindFirstChild("M9")
        local sM = require(gun:FindFirstChild("GunStates"))
        sM["Damage"] = 999
        sM["MaxAmmo"] = 9999991
        sM["StoredAmmo"] = 9999991
        sM["FireRate"] = 0.05
        sM["AmmoPerClip"] = 9999991
        sM["Range"] = 5000
        sM["ReloadTime"] = 0.05
        sM["Bullets"] = 1
        sM["AutoFire"] = true
    end)  
   print("Ready")
  
    GunsSection:NewButton("Mod Remington 870", "Mods that gun", function()
  
  local player = game:GetService("Players").LocalPlayer
        local gun = player.Backpack:FindFirstChild("Remington 870")
        local sM = require(gun:FindFirstChild("GunStates"))
        sM["Damage"] = 999
        sM["MaxAmmo"] = 9999991
        sM["StoredAmmo"] = 9999991
        sM["FireRate"] = 0.05
        sM["AmmoPerClip"] = 9999991
        sM["Range"] = 5000
        sM["ReloadTime"] = 0.05
        sM["Bullets"] = 1
        sM["AutoFire"] = true
    end)   
   print("Ready")
  
    GunsSection:NewButton("Mod AK-47", "Mods that gun", function()
  
  local player = game:GetService("Players").LocalPlayer
        local gun = player.Backpack:FindFirstChild("AK-47")
        local sM = require(gun:FindFirstChild("GunStates"))
        sM["Damage"] = 999
        sM["MaxAmmo"] = 9999991
        sM["StoredAmmo"] = 9999991
        sM["FireRate"] = 0.05
        sM["AmmoPerClip"] = 9999991
        sM["Range"] = 5000
        sM["ReloadTime"] = 0.05
        sM["Bullets"] = 1
        sM["AutoFire"] = true   
   print("Ready")
    end)
  
    GunsSection:NewButton("Mod M4A1", "Mods that gun", function()
  
  local gun = player.Backpack:FindFirstChild("M4A1")
        local sM = require(gun:FindFirstChild("GunStates"))
        sM["Damage"] = 999
        sM["MaxAmmo"] = 9999991
        sM["StoredAmmo"] = 9999991
        sM["FireRate"] = 0.05
        sM["AmmoPerClip"] = 9999991
        sM["Range"] = 5000
        sM["ReloadTime"] = 0.05
        sM["Bullets"] = 1
        sM["AutoFire"] = true      
   print("Ready")
    end)
  
    GunsSection:NewButton("Silent Aim", "", function()
        print("Clicked")
  
  local Players = game.Players
  local LocalPlayer = Players.LocalPlayer
  local GetPlayers = Players.GetPlayers
  local Camera = game.Workspace.CurrentCamera
  local WTSP = Camera.WorldToScreenPoint
  local FindFirstChild = game.FindFirstChild
  local Vector2_new = Vector2.new
  local Mouse = LocalPlayer.GetMouse(LocalPlayer)
  function ClosestChar()
    local Max, Close = math.huge
    for I,V in pairs(GetPlayers(Players)) do
        if V ~= LocalPlayer and V.Team ~= LocalPlayer.Team and V.Character then
            local Head = FindFirstChild(V.Character, "Head")
            if Head then
                local Pos, OnScreen = WTSP(Camera, Head.Position)
                if OnScreen then
                    local Dist = (Vector2_new(Pos.X, Pos.Y) - Vector2_new(Mouse.X, Mouse.Y)).Magnitude
                    if Dist < Max then
                        Max = Dist
                        Close = V.Character
                    end
                end
            end
        end
    end
    return Close
  end
  
  local MT = getrawmetatable(game)
  local __namecall = MT.__namecall
  setreadonly(MT, false)
  MT.__namecall = newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    if Method == "FindPartOnRay" and not checkcaller() and tostring(getfenv(0).script) == "GunInterface" then
        local Character = ClosestChar()
        if Character then
            return Character.Head, Character.Head.Position
        end
    end
  
    return __namecall(self, ...)
  end)
  setreadonly(MT, true)
        print("Ready")
    end)
  
  GunsSection:NewButton("Auto Reload", "Auto Reloads Your Gun", function()
        print("Clicked")
  
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  
  local GunStates = {}
  -- require
  ReplicatedStorage.UpdateEvent.OnClientEvent:connect(function(_, Tool)
    local Gun = Tool:FindFirstChild("GunStates")
    if Tool and Gun and Gun.ClassName == "ModuleScript" then
        sM = require(Gun)
        if sM.CurrentAmmo == 0 and not table.find(GunStates, Tool.Name) then
            table.insert(GunStates, Tool.Name)
            print(Tool.Name.." empty, reloading")
            ReplicatedStorage.ReloadEvent:FireServer(Tool)
            task.wait(sM.ReloadTime)
            warn("finished reloading "..Tool.Name)
            sM.CurrentAmmo = sM.MaxAmmo
            for i,v in pairs(GunStates) do
                if v == Tool.Name then
                    table.remove(GunStates, i)
                end
            end
        end
    end
  end)
        print("Ready")
    end)
  
    local Teleports = Window:NewTab("Teleports")
    local TeleportsSection = Teleports:NewSection("Teleports")
  
    TeleportsSection:NewButton("Outside of prison", "Teleports You outside of the prison!", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(451.6684265136719, 98.0399169921875, 2216.338134765625)
    end)
    TeleportsSection:NewButton("Prison Yard", "Teleports You to the Prison Yard", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(736.4671630859375, 97.99992370605469, 2517.583740234375)
    end)
    TeleportsSection:NewButton("Kitchen", "Teleports You to the Kitchen!", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(906.641845703125, 99.98993682861328, 2237.67333984375)
    end)
    TeleportsSection:NewButton("Prison Cells", "Teleports You to the Prison Cells!", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.5551147460938, 99.98998260498047, 2441.700927734375)
    end)
    TeleportsSection:NewButton("Surveilance Room", "Teleports You to the Surveilance Room!", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(795.251953125, 99.98998260498047, 2327.720703125)
    end)
    TeleportsSection:NewButton("Break Room", "Teleports You to the Break Room!", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(800.0896606445312, 99.98998260498047, 2266.71630859375)
    end)
    TeleportsSection:NewButton("Police Armory", "Teleports You to the Police Armory!", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(837.2889404296875, 99.98998260498047, 2270.99658203125)
    end)
    TeleportsSection:NewButton("Police Room", "Teleports to to the Police Room", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(836.5386352539062, 99.98998260498047, 2320.604248046875)
    end)
    TeleportsSection:NewButton("Cafeteria", "Teleports you to the Cafeteria!", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.994873046875, 99.98993682861328, 2325.73095703125)
    end)
    TeleportsSection:NewButton("Criminal Base Inside", "Teleports you to the Criminal Base Inside!", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-935.360474, 94.1287842, 2066.77319)
    end)
  
    TeleportsSection:NewButton("Teleporter Gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(('https://pastebin.com/raw/KfeptYP6'),true))()
        print("Ready")
    end)
  
    TeleportsSection:NewButton("Main Tower", "", function()
        print("Clicked")
  
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(823.287292, 130.039948, 2587.73975)
  end)
        print("Ready")
  
     TeleportsSection:NewButton("Reception", "Teleports to area", function()
  
  local LocalPlayer = game.Players.LocalPlayer.Character.HumanoidRootPart
  LocalPlayer.CFrame = CFrame.new(695, 99, 2273)
  
  print("Ready")
    end)
  
     TeleportsSection:NewButton("Back", "Teleports to that area", function()
  
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(980, 101, 2327)
   print("Ready")
    end)
  
    TeleportsSection:NewButton("Escape Prison", "Teleports to that area", function()
  
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(465.9,98.19,2253.47)  
   print("Ready")
    end)
  
    TeleportsSection:NewButton("Nexus", "Teleports to that area", function()
  
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(879,99,2377)
   print("Ready")
    end)
  
  local World = Window:NewTab("World")
  local WorldSection = World:NewSection("World")
  
  local ez = Instance.new("Folder")
  ez.Name = "nikodoors"
  ez.Parent = game:service"ReplicatedStorage"
  local ez = Instance.new("Folder")
  ez.Name = "nikofences"
  ez.Parent = game:service"ReplicatedStorage"
  
  WorldSection:NewToggle("Remove doors", "Removes all doors from your game", function(state)
    if state then
        print("Toggle On")
        for i,v in pairs(game.Workspace.Doors:GetChildren()) do
             v.Parent = game:service"ReplicatedStorage".nikodoors
  
        end
    else
        print("Toggle Off")
        for i,v in pairs(game:service"ReplicatedStorage".nikodoors:GetChildren()) do
            v.Parent = game.Workspace.Doors
        end
    end
  end)
  
  WorldSection:NewToggle("Remove Fences", "Don't be caged like a monkey, be free", function(state)
    if state then
        print("Toggle On")
        for i,v in pairs(game.Workspace.Prison_Fences:GetChildren()) do
            v.Parent = game:GetService("ReplicatedStorage").nikofences
        end
    else
        print("Toggle Off")
        for i,v in pairs(game:GetService("ReplicatedStorage").nikofences:GetChildren()) do
            v.Parent = game.Workspace.Prison_Fences
        end
    end
  end)
  
  WorldSection:NewButton("Arrest All", "Arrest All Criminals", function()
    task.wait(0.1)
  Player = game.Players.LocalPlayer
  Pcf = Player.Character.HumanoidRootPart.CFrame
  for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
    if v.Name ~= Player.Name then
      local i = 10
      repeat
        task.wait()
        i = i-1
        game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
        Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
      until i == 0
    end
  end
  
  end)    
  
  WorldSection:NewButton("Kill All (Reset To Stop) ", "Reset To Stop", function()
    spawn(function()
    while task.wait(0.1) do
        for i, v in next, game:GetService("Players"):GetChildren() do
            pcall(function()
                if v~= game:GetService("Players").LocalPlayer and not v.Character:FindFirstChildOfClass("ForceField") and v.Character.Humanoid.Health > 0 then
                    while v.Character:WaitForChild("Humanoid").Health > 0 do
                        task.wait();
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame;
                        for x, c in next, game:GetService("Players"):GetChildren() do
                            if c ~= game:GetService("Players").LocalPlayer then game.ReplicatedStorage.meleeEvent:FireServer(c) end
                        end
                    end
                end
            end)
            task.wait()
        end
   end
  end)
  end)
  
  WorldSection:NewButton("InvisGUI", "Invisible", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/AYtzGEPb'))()
  end)
  
  WorldSection:NewButton("Rejoin", "Rejoin The Game", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/1gtVMUz3"))()
  end)
  
  WorldSection:NewButton("Leave", "Leave The Game", function()
  
  task.wait(.1)
    game:Shutdown()
       print("Ready")
    end)
  
  WorldSection:NewButton("Server Hop", "Server Hops", function()
  
  local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()
  
  module:Teleport(game.PlaceId)
       print("Ready")
    end)
  
  WorldSection:NewButton("Server Hop To Dead Server", "Server hops to a dead server", function()
  
  local Http = game:GetService("HttpService")
  local TPS = game:GetService("TeleportService")
  local Api = "https://games.roblox.com/v1/games/"
  
  local _place = game.PlaceId
  local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
  function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
  end
  
  local Server, Next; repeat
   local Servers = ListServers(Next)
   Server = Servers.data[1]
   Next = Servers.nextPageCursor
  until Server
  
  TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
       print("Ready")
    end)
  
    local Hacks = Window:NewTab("Hacks")
    local HacksSection = Hacks:NewSection("Hacks")
  
    HacksSection:NewButton("Mobile buttons", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(("https://pastebin.com/raw/jfBF6Ccg"),true))()
        print("Ready")
    end)
  
    HacksSection:NewButton("Esp", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(('https://pastebin.com/raw/iRFj1ZfR'),true))()
        print("Ready")
    end)
  
    HacksSection:NewButton("Ez Hub", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(('https://raw.githubusercontent.com/debug420/Ez-Industries-Launcher-Data/master/Launcher.lua'),true))()
        print("Ready")
    end)
  
    HacksSection:NewButton("Fe Bypass", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/Enes5858/Enes5858/main/SKIDDDDD.txt"))()
        print("Ready")
    end)
  
     HacksSection:NewButton("Fe Bypass Gui V3", "", function()
        print("Clicked")
  
  loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\103\48\48\108\88\112\108\111\105\116\101\114\47\103\48\48\108\88\112\108\111\105\116\101\114\47\109\97\105\110\47\70\101\37\50\48\98\121\112\97\115\115\34\44\32\116\114\117\101\41\41\40\41\10")()
        print("Ready")
    end)
  
    HacksSection:NewButton("Fe Disabled Tools", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://pastebin.com/raw/AZVi2tuK"))()
        print("Ready")
    end)
  
    HacksSection:NewButton("Chat Bypasser", "Bypasses chat filter", function()
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/synnyyy/synergy/additional/betterbypasser",true))()   
   print("Ready")
    end)
  
    HacksSection:NewButton("One Punch", "", function()
        print("Clicked")
  
  mainRemotes = game.ReplicatedStorage
  meleeRemote = mainRemotes['meleeEvent']
  mouse = game.Players.LocalPlayer:GetMouse()
  punching = false
  cooldown = false
  
  function punch()
  cooldown = true
  local part = Instance.new("Part", game.Players.LocalPlayer.Character)
  part.Transparency = 1
  part.Size = Vector3.new(5, 2, 3)
  part.CanCollide = false
  local w1 = Instance.new("Weld", part)
  w1.Part0 = game.Players.LocalPlayer.Character.Torso
  w1.Part1 = part
  w1.C1 = CFrame.new(0,0,2)
  part.Touched:connect(function(hit)
  if game.Players:FindFirstChild(hit.Parent.Name) then
  local plr = game.Players:FindFirstChild(hit.Parent.Name)
  if plr.Name ~= game.Players.LocalPlayer.Name then
  part:Destroy()
  
  for i = 1,100 do
  meleeRemote:FireServer(plr)
  end
  end
  end
  end)
  
  task.wait(1)
  cooldown = false
  part:Destroy()
  end
  
  mouse.KeyDown:connect(function(key)
  if cooldown == false then
  if key:lower() == "f" then
  
  punch()
  
  end
  end
  end)
  
        print("Ready")
    end)
  
    local Scripts = Window:NewTab("Scripts")
    local ScriptsSection = Scripts:NewSection("Scripts")
  
         ScriptsSection:NewButton("Keyboard", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
        print("Ready")
    end)
  
    ScriptsSection:NewButton("Kill All Gui", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet('https://pastebin.com/raw/AvDk19WS'))()
        print("Ready")
    end)
  
    ScriptsSection:NewButton("Baseball bat", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet(('https://pastebin.com/raw/mTrRfcXV'),true))()
        print("Ready")
    end)
  
    ScriptsSection:NewButton("Infinite Stamina", "", function()
        print("Clicked")
  
  loadstring(game:HttpGet("https://scriptblox.com/raw/Prison-Life-(Cars-fixed!)-Inf-Stamina-NO-BUGS-4782"))()
        print("Ready")
    end)
  
    local Gui = Window:NewTab("Gui")
    local GuiSection = Gui:NewSection("Gui")
  
  
    GuiSection:NewKeybind("Toggle The Gui", "Use b to toggle", Enum.KeyCode.B, function()
  Library:ToggleUI()
  end)
  
    GuiSection:NewButton("Anti Afk", "", function()
        print("Clicked")
  
  local Rice = Instance.new("ScreenGui")
  local Main = Instance.new("Frame")
  local Title = Instance.new("TextLabel")
  local Credits = Instance.new("TextLabel")
  local Activate = Instance.new("TextButton")
  local UICorner = Instance.new("UICorner")
  local OpenClose = Instance.new("TextButton")
  local UICorner_2 = Instance.new("UICorner")
  
  Rice.Name = "Rice"
  Rice.Parent = game.CoreGui
  Rice.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  
  Main.Name = "Main"
  Main.Parent = Rice
  Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  Main.BorderSizePixel = 0
  Main.Position = UDim2.new(0.321207851, 0, 0.409807354, 0)
  Main.Size = UDim2.new(0, 295, 0, 116)
  Main.Visible = false
  Main.Active = true
  Main.Draggable =  true
  
  Title.Name = "Title"
  Title.Parent = Main
  Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
  Title.BorderSizePixel = 0
  Title.Size = UDim2.new(0, 295, 0, 16)
  Title.Font = Enum.Font.GothamBold
  Title.Text = "Rice Anti-Afk"
  Title.TextColor3 = Color3.fromRGB(255, 255, 255)
  Title.TextScaled = true
  Title.TextSize = 12.000
  Title.TextWrapped = true
  
  Credits.Name = "Credits"
  Credits.Parent = Main
  Credits.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
  Credits.BorderSizePixel = 0
  Credits.Position = UDim2.new(0, 0, 0.861901641, 0)
  Credits.Size = UDim2.new(0, 295, 0, 16)
  Credits.Font = Enum.Font.GothamBold
  Credits.Text = "Made by Riot_Exploits"
  Credits.TextColor3 = Color3.fromRGB(255, 255, 255)
  Credits.TextScaled = true
  Credits.TextSize = 12.000
  Credits.TextWrapped = true
  
  Activate.Name = "Activate"
  Activate.Parent = Main
  Activate.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
  Activate.BorderColor3 = Color3.fromRGB(27, 42, 53)
  Activate.BorderSizePixel = 0
  Activate.Position = UDim2.new(0.0330629945, 0, 0.243326917, 0)
  Activate.Size = UDim2.new(0, 274, 0, 59)
  Activate.Font = Enum.Font.GothamBold
  Activate.Text = "Activate"
  Activate.TextColor3 = Color3.fromRGB(0, 255, 127)
  Activate.TextSize = 43.000
  Activate.TextStrokeColor3 = Color3.fromRGB(102, 255, 115)
  Activate.MouseButton1Down:connect(function()
  local vu = game:GetService("VirtualUser")
  game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),game.Workspace.CurrentCamera.CFrame)
    task.wait(1)
    vu:Button2Up(Vector2.new(0,0),game.Workspace.CurrentCamera.CFrame)
  end)
  end)
  
  UICorner.Parent = Activate
  
  OpenClose.Name = "Open/Close"
  OpenClose.Parent = Rice
  OpenClose.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
  OpenClose.Position = UDim2.new(0.353924811, 0, 0.921739101, 0)
  OpenClose.Size = UDim2.new(0, 247, 0, 35)
  OpenClose.Font = Enum.Font.GothamBold
  OpenClose.Text = "Open/Close"
  OpenClose.TextColor3 = Color3.fromRGB(255, 255, 255)
  OpenClose.TextSize = 14.000
  
  UICorner_2.Parent = OpenClose
  
  local function NERMBF_fake_script() -- OpenClose.LocalScript 
  local script = Instance.new('LocalScript', OpenClose)
  
  local frame = script.Parent.Parent.Main
  
  script.Parent.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
  end)
  end
  coroutine.wrap(NERMBF_fake_script)()
        print("Ready")
    end)
  
  GuiSection:NewButton("Discord Invite", "copies the discord invite link", function()
        print("Clicked")
  
  setclipboard("https://discord.com/invite/JJH9MGxn2v")
   print("Ready")
    end)
  
  GuiSection:NewButton("Youtube Channel (Subscribe!)", "", function()
        print("Clicked")
  
  setclipboard("https://youtube.com/@lucas_777.-?si=qgk9tAfeoVGSG6AP")
        print("Ready")
    end)
  
     local Teams = Window:NewTab("Teams")
     local TeamsSection = Teams:NewSection("Teams")
  
     TeamsSection:NewButton("Neutral", "", function()
        print("Clicked")
  
  game.Workspace.Remote.TeamEvent:FireServer("Medium stone grey")
       print("Ready")
    end)
  
    TeamsSection:NewButton("Inmate", "", function()
        print("Clicked")
  
  game.Workspace.Remote.TeamEvent:FireServer("Bright orange")
        print("Ready")
    end)
  
    TeamsSection:NewButton("Guard (Wont Work If The Team Is Full)", "", function()
        print("Clicked")
  
  game.Workspace.Remote.TeamEvent:FireServer("Bright blue")
        print("Ready")
    end)
  
     TeamsSection:NewButton("Criminal", "", function()
        print("Clicked")
  
  local LP = game.Players.LocalPlayer
    local RE = LP.Character.HumanoidRootPart.Position
    LP.Character.HumanoidRootPart.CFrame = CFrame.new(-919.958, 95.327, 2138.189)
    task.wait(0.075)
    LP.Character.HumanoidRootPart.CFrame = CFrame.new(RE)
  
        print("Ready")
    end)
  
     TeamsSection:NewButton("Criminal 2", "", function()
  
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-976.125183, 109.123924, 2059.99536)
  
    task.wait(0.3)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.77,100,2379.07)
  
   print("Ready")
    end)
  
    TeamsSection:NewButton("Criminal 3", "", function()
  
  local lastPos = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").position
  LCS = game.Workspace["Criminals Spawn"].SpawnLocation
  LCS.CanCollide = false
  LCS.Size = Vector3.new(51.05, 24.12, 54.76)
  LCS.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
  LCS.Transparency = 1
  task.wait(0.5)
  LCS.CFrame = CFrame.new(-920.510803, 92.2271957, 2138.27002, 0, 0, -1, 0, 1, 0, 1, 0, 0)
  LCS.Size = Vector3.new(6, 0.2, 6)
  LCS.Transparency = 0
  task.wait()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(lastPos)
  
   print("Ready")
    end)
  
    TeamsSection:NewButton("Criminal 4", "", function()
        print("Clicked")
  
  local CrimPad = game.Workspace["Criminals Spawn"].SpawnLocation
        CrimPad.CanCollide = false
        CrimPad.Transparency = 1
        CrimPad.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        task.wait()
        CrimPad.CanCollide = true
        CrimPad.Transparency = 0
        CrimPad.CFrame = CFrame.new(-920.510803, 92.2271957, 2138.27002, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        local savedcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local savedcamcf = game.Workspace.CurrentCamera.CFrame
        local CrimPad = game.Workspace["Criminals Spawn"].SpawnLocation
        CrimPad.CanCollide = false
        CrimPad.Transparency = 1
        CrimPad.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        task.wait()
        CrimPad.CanCollide = true
        CrimPad.Transparency = 0
        CrimPad.CFrame = CFrame.new(-920.510803, 92.2271957, 2138.27002, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
        game.Workspace.CurrentCamera.CFrame = savedcamcf			
        print("Ready")
    end)
  
  TeamsSection:NewButton("Criminal 5", "", function()
        print("Clicked")
  
    task.wait(0.3)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-976.125183, 109.123924, 2059.99536)
  
    task.wait(0.3)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.77,100,2379.07)
        print("Ready")
    end)
  end
  end);
