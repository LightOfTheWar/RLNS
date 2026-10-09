local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RS = ReplicatedStorage:WaitForChild("RS")
local Settings = require(RS:WaitForChild("Config"))

local SM = require(script.Parent:WaitForChild("SenderModule"))

local eventfolder = RS:WaitForChild("events")
local templatesfolder = RS:WaitForChild("templates")

-- EVENTS

local COMTS = eventfolder:WaitForChild("COM-TS")
local COMTC = eventfolder:WaitForChild("COM-TC")

-- CDS

COMTS.OnServerEvent:Connect(function(player, typeofnotif, templatename, title, text, duration)
	if typeofnotif ~= "notification" then return end
	if typeof(templatename) ~= "string" then return end
	if typeof(title) ~= "string" then return end
	if typeof(text) ~= "string" then return end
	if typeof(duration) ~= "number" then return end

	if not templatesfolder:FindFirstChild(templatename) then return end
	if duration < 0 or duration > 30 then return end

	SM.Sender(COMTC, player, player.Name, templatename, title, text, duration)
end)

-- INIT

print(
	Settings.infos["INTRO"],
	"Version :" .. tostring(Settings.infos["Version"]),
	"Creator :" .. tostring(Settings.infos["Creator"]),
	"Update :" .. tostring(Settings.infos["Update"]),
	"GameName :" .. tostring(Settings.infos["GameName"])
)