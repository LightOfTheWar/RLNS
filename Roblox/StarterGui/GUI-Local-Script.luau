local Players = game:GetService("Players")
local player = Players.LocalPlayer

local GF

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RS = ReplicatedStorage:WaitForChild("RS")

local eventfolder = RS:WaitForChild("events")
local guifolder = RS:WaitForChild("gui")
local templatesfolder = RS:WaitForChild("templates")

local reciverevent = eventfolder:WaitForChild("recievenotification")

-- SETTINGS

local Settings

-- FONCTIONS



local function SetupGui(GUI)
    if not GUI then return end
    local gui = GUI:Clone()
    gui.Parent = player:WaitForChild("PlayerGui")
    GF = gui
end

local function AddInGUI(GUI, what)
    if not GUI or not what then return end
    local clonetemp = what:Clone()
    clonetemp.Parent = GUI
end

local function RemoveFromGUI(GUI, what)
    if not GUI or not what then return end
    local toremove = GUI:FindFirstChild(what.Name)
    if toremove then
        toremove:Destroy()
    end
end

local function receivenotification(template, title, text, duration)
    if not GF then return end
    local notif = template:Clone()
    notif.Parent = GF:WaitForChild("Notifications")
    notif.Title.Text = title
    notif.Text.Text = text
    task.wait(duration)
    notif:Destroy()
end


-- INITIATEUR

task.wait(2)
SetupGui(guifolder:WaitForChild("Main"))

reciverevent.OnServerEvent:Connect(function(author, template, title, text, duration)
    print("Notification by : " .. author)
    print("Text : " .. text)
    print("Duration : " .. duration)
    receivenotification(template, title, text, duration)
end)