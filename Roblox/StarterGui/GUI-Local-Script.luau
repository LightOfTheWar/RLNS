local Players = game:GetService("Players")
local player = Players.LocalPlayer

local GF

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RS = ReplicatedStorage:WaitForChild("RS")

local eventfolder = RS:WaitForChild("events")
local guifolder = RS:WaitForChild("gui")
local templatesfolder = RS:WaitForChild("templates")

local reciverevent = eventfolder:WaitForChild("COM-TC")

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

	return clonetemp
end

local function RemoveFromGUI(GUI, what)
	if not GUI or not what then return end

	local toremove = GUI:FindFirstChild(what.Name)

	if toremove then
		toremove:Destroy()
	end
end

local function receivenotification(templatename, title, text, duration)
	if not GF then return end

	if typeof(templatename) ~= "string" then return end
	if typeof(title) ~= "string" then return end
	if typeof(text) ~= "string" then return end
	if typeof(duration) ~= "number" then return end

	local template = templatesfolder:FindFirstChild(templatename)

	if not template then
		warn("Template not found :", templatename)
		return
	end

	local notifications = GF:WaitForChild("Notifications")
	local notif = template:Clone()

	local titleLabel = notif:FindFirstChild("Title", true)
	local textLabel = notif:FindFirstChild("Text", true)

	if not titleLabel or not titleLabel:IsA("TextBox") then
		warn("Title not found in template :", templatename)
		notif:Destroy()
		return
	end

	if not textLabel or not textLabel:IsA("TextBox") then
		warn("Text not found in template :", templatename)
		notif:Destroy()
		return
	end

	titleLabel.Text = title
	textLabel.Text = text

	notif.Parent = notifications

	task.delay(math.clamp(duration, 0, 30), function()
		if notif and notif.Parent then
			notif:Destroy()
		end
	end)
end

-- INITIATEUR

task.wait(2)
SetupGui(guifolder:WaitForChild("Main"))

reciverevent.OnClientEvent:Connect(function(author, template, title, text, duration)
	print("Notification by : " .. tostring(author))
	print("Text : " .. tostring(text))
	print("Duration : " .. tostring(duration))

	receivenotification(template, title, text, duration)
end)