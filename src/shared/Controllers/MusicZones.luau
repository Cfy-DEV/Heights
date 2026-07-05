local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local observers = require(ReplicatedStorage.Packages.observers)
local trove = require(ReplicatedStorage.Packages.trove)

local lp = Players.LocalPlayer

local newTrove = trove.new()
local currentlyPlaying = Instance.new("Sound", SoundService)
local lastTouch

currentlyPlaying.Name = "ZoneMusic"
currentlyPlaying.Looped = true

local zones = {}
local musics = {}

newTrove:Add(RunService.RenderStepped:Connect(function(deltaTime: number)
	local char = lp.Character
	if not char then
		return
	end
	local hrs: BasePart = char:FindFirstChild("HumanoidRootPart")
	if not hrs then
		return
	end

	local currentZone = nil

	for _, zone: BasePart in ipairs(zones) do
		local pos1 = zone.Position
		local pos2 = hrs.Position

		local halfSize = zone.Size / 2
		local minBound = pos1 - halfSize
		local maxBound = pos1 + halfSize

		local clampedPos = Vector3.new(
			math.clamp(pos2.X, minBound.X, maxBound.X),
			math.clamp(pos2.Y, minBound.Y, maxBound.Y),
			math.clamp(pos2.Z, minBound.Z, maxBound.Z)
		)

		if clampedPos == pos2 then
			currentZone = zone
			break
		end
	end

	if currentZone ~= lastTouch or (currentZone and not currentlyPlaying.IsPlaying) then
		if currentZone then
			currentlyPlaying.SoundId = musics[currentZone.Name]
			currentlyPlaying.TimePosition = 0
			currentlyPlaying:Play()
		else
			currentlyPlaying:Stop()
		end

		lastTouch = currentZone
	end
end))

observers.observeTag("MusicZone", function(instance: BasePart)
	assert(typeof(instance) == "Instance", "How???")

	if not instance:IsA("BasePart") then
		warn(("Music zone %s is not a basepart"):format(instance.Name))
	end

	local find: Sound = ReplicatedStorage.Music:FindFirstChild(instance.Name)

	if find and find:IsA("Sound") and not musics[instance.Name] then
		musics[instance.Name] = find.SoundId
	end

	table.insert(zones, instance)
end)
