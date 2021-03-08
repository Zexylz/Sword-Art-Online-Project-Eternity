local Library =
    loadstring(
    game:HttpGet(
        "https://raw.githubusercontent.com/Zexylz/Sword-Art-Online-Project-Eternity/Ui-Library/WeebwareUI",
        true
    )
)()

for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
    v:Disable()
end

for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "ScreenGui" then
        v:Destroy()
    end
end

s = {}
setmetatable(
    s,
    {
        __index = function(_, service)
            return game:GetService(service)
        end,
        __newindex = function(t, i)
            t[i] = nil
            return
        end
    }
)

local window = Library:CreateWindow("Speed Run Simulator")
window:AddToggle(
    {
        text = "Auto Speed",
        flag = "sped",
        state = false,
        callback = function(func)
            getgenv().AutoSpeedToggled = func
            while getgenv().AutoSpeedToggled do
               s["ReplicatedStorage"].Remotes.AddSpeed:FireServer()
               s["RunService"].RenderStepped:Wait()
            end
        end
    }
)

window:AddToggle(
    {
        text = "Auto Rebirth",
        flag = "reb",
        state = false,
        callback = function(func)
            getgenv().RebirthToggled = func
            while getgenv().RebirthToggled do
               s["ReplicatedStorage"].Remotes.Rebirth:FireServer()
               s["RunService"].RenderStepped:Wait()
            end
        end
    }
)

window:AddList(
    {
        text = "Egg",
        value = "EggOne",
        values = {"EggOne", "EggTwo", "EggThree", "EggFour", "EggFive", "EggSix", "EggSeven", "EggEight", "EggNine", "EggTen", "EggEleven", "EggTwelve", "EggThirteen", "EggFourteen", "EggFifteen", "EggSixteen"},
        callback = function(func)
            game:GetService("ReplicatedStorage").Remotes.CanBuyEgg:InvokeServer(func)
        end
    }
)



window:AddBind(
    {
        text = "Toggle UI",
        flag = "Bind",
        key = Enum.KeyCode.RightShift,
        callback = function(a)
            Library:Close()
        end
    }
)

Library:Init()
