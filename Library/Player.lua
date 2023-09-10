--------|     Library     |--------

--------|    Reference    |--------
local Players = game:GetService("Players")

--------|     Setting     |--------
local Player = {
	Optional = {},
	Player = function(plrInst) return plrInst or Players.LocalPlayer end
}

--- Character primitives
local function Character(plrInst)
	return Player.Player(plrInst).Character
end
Player.Optional.Character = Character
function Player.Character(plrInst)
	return Player.Player(plrInst).Character or Player.Player(plrInst).CharacterAdded:Wait()
end

--- Part-based primitives
--- PrimaryPart
local function PrimaryPart(inst)
	return Player.Optional.Character(inst) and Player.Optional.Character(inst).PrimaryPart
end
Player.Optional.PrimaryPart = PrimaryPart
function Player.PrimaryPart(plrInstance)
	local primaryPart = Player.Character(plrInstance).PrimaryPart
	if primaryPart then
		return primaryPart
	end
	Player.Character(plrInstance):WaitForChild("HumanoidRootPart", math.huge)
	local primaryPart2 = Player.Character(plrInstance).PrimaryPart
	assert(primaryPart2)
	return primaryPart2
end

--- Humanoid primitive
local function Humanoid(plrInstance)
	return Player.Optional.Character(plrInstance) and Player.Optional.Character(plrInstance):FindFirstChildOfClass("Humanoid")
end
Player.Optional.Humanoid = Humanoid
function Player.Humanoid(plrInstance)
	local plrHum = Player.Character(plrInstance):FindFirstChildOfClass("Humanoid")
	if plrHum then
		return plrHum
	end
	Player.Character(plrInstance):WaitForChild("Humanoid", math.huge)
	local hum2 = Player.Character(plrInstance):FindFirstChildOfClass("Humanoid")
	assert(hum2)
	return hum2
end

--- Part primitive
local function Part(plrInstance, partName)
	return Player.Character(plrInstance):FindFirstChild(partName)
end
Player.Optional.Part = Part
function Player.Part(plrInstance, partName)
	return Player.Character(plrInstance):WaitForChild(partName, math.huge)
end

--- EmbeddedPart primitive
local function EmbeddedPart(plrInstance, partName, embedPartName)
	return Player.Optional.Part(plrInstance, partName) and Player.Optional.Part(plrInstance, partName):FindFirstChild(embedPartName)
end
Player.Optional.EmbeddedPart = EmbeddedPart
function Player.EmbeddedPart(plrInstance, partName, embedPartName)
	return Player.Part(plrInstance, partName):WaitForChild(embedPartName, math.huge)
end

--- Main player stuff. Don't modify, side effects include brain damage
local function Head(inst) return Player.Optional.Part(inst, "Head") end
function Player.Head(inst) return Player.Part(inst, "Head") end
Player.Optional.Head = Head
local function UpperTorso(inst) return Player.Optional.Part(inst, "UpperTorso") end
function Player.UpperTorso(inst) return Player.Part(inst, "UpperTorso") end
Player.Optional.UpperTorso = UpperTorso
local function LowerTorso(inst) return Player.Optional.Part(inst, "LowerTorso") end
function Player.LowerTorso(inst) return Player.Part(inst, "LowerTorso") end
Player.Optional.LowerTorso = LowerTorso
local function LeftFoot(inst) return Player.Optional.Part(inst, "LeftFoot") end
function Player.LeftFoot(inst) return Player.Part(inst, "LeftFoot") end
Player.Optional.LeftFoot = LeftFoot
local function LeftHand(inst) return Player.Optional.Part(inst, "LeftHand") end
function Player.LeftHand(inst) return Player.Part(inst, "LeftHand") end
Player.Optional.LeftHand = LeftHand
local function LeftLowerArm(inst) return Player.Optional.Part(inst, "LeftLowerArm") end
function Player.LeftLowerArm(inst) return Player.Part(inst, "LeftLowerArm") end
Player.Optional.LeftLowerArm = LeftLowerArm
local function LeftLowerLeg(inst) return Player.Optional.Part(inst, "LeftLowerLeg") end
function Player.LeftLowerLeg(inst) return Player.Part(inst, "LeftLowerLeg") end
Player.Optional.LeftLowerLeg = LeftLowerLeg
local function LeftUpperArm(inst) return Player.Optional.Part(inst, "LeftUpperArm") end
function Player.LeftUpperArm(inst) return Player.Part(inst, "LeftUpperArm") end
Player.Optional.LeftUpperArm = LeftUpperArm
local function LeftUpperLeg(inst) return Player.Optional.Part(inst, "LeftUpperLeg") end
function Player.LeftUpperLeg(inst) return Player.Part(inst, "LeftUpperLeg") end
Player.Optional.LeftUpperLeg = LeftUpperLeg
local function RightFoot(inst) return Player.Optional.Part(inst, "RightFoot") end
function Player.RightFoot(inst) return Player.Part(inst, "RightFoot") end
Player.Optional.RightFoot = RightFoot
local function RightHand(inst) return Player.Optional.Part(inst, "RightHand") end
function Player.RightHand(inst) return Player.Part(inst, "RightHand") end
Player.Optional.RightHand = RightHand
local function RightLowerArm(inst) return Player.Optional.Part(inst, "RightLowerArm") end
function Player.RightLowerArm(inst) return Player.Part(inst, "RightLowerArm") end
Player.Optional.RightLowerArm = RightLowerArm
local function RightLowerLeg(inst) return Player.Optional.Part(inst, "RightLowerLeg") end
function Player.RightLowerLeg(inst) return Player.Part(inst, "RightLowerLeg") end
Player.Optional.RightLowerLeg = RightLowerLeg
local function RightUpperArm(inst) return Player.Optional.Part(inst, "RightUpperArm") end
function Player.RightUpperArm(inst) return Player.Part(inst, "RightUpperArm") end
Player.Optional.RightUpperArm = RightUpperArm
local function RightUpperLeg(inst) return Player.Optional.Part(inst, "RightUpperLeg") end
function Player.RightUpperLeg(inst) return Player.Part(inst, "RightUpperLeg") end
Player.Optional.RightUpperLeg = RightUpperLeg

--- Joint stuff
local function Root(inst) return Player.Optional.EmbeddedPart(inst, "LowerTorso", "Root") end
function Player.Root(inst) return Player.EmbeddedPart(inst, "LowerTorso", "Root") end
Player.Optional.Root = Root
local function Waist(inst) return Player.Optional.EmbeddedPart(inst, "UpperTorso", "Waist") end
function Player.Waist(inst) return Player.EmbeddedPart(inst, "UpperTorso", "Waist") end
Player.Optional.Waist = Waist
local function Neck(inst) return Player.Optional.EmbeddedPart(inst, "Head", "Neck") end
function Player.Neck(inst) return Player.EmbeddedPart(inst, "Head", "Neck") end
Player.Optional.Neck = Neck
local function LeftAnkle(inst) return Player.Optional.EmbeddedPart(inst, "LeftFoot", "LeftAnkle") end
function Player.LeftAnkle(inst) return Player.EmbeddedPart(inst, "LeftFoot", "LeftAnkle") end
Player.Optional.LeftAnkle = LeftAnkle
local function LeftWrist(inst) return Player.Optional.EmbeddedPart(inst, "LeftHand", "LeftWrist") end
function Player.LeftWrist(inst) return Player.EmbeddedPart(inst, "LeftHand", "LeftWrist") end
Player.Optional.LeftWrist = LeftWrist
local function LeftElbow(inst) return Player.Optional.EmbeddedPart(inst, "LeftLowerArm", "LeftElbow") end
Player.Optional.LeftElbow = LeftElbow
function Player.LeftElbow(inst) return Player.EmbeddedPart(inst, "LeftLowerArm", "LeftElbow") end
local function LeftKnee(inst) return Player.Optional.EmbeddedPart(inst, "LeftLowerLeg", "LeftKnee") end
function Player.LeftKnee(inst) return Player.EmbeddedPart(inst, "LeftLowerLeg", "LeftKnee") end
Player.Optional.LeftKnee = LeftKnee
local function LeftShoulder(inst) return Player.Optional.EmbeddedPart(inst, "LeftUpperArm", "LeftShoulder") end
function Player.LeftShoulder(inst) return Player.EmbeddedPart(inst, "LeftUpperArm", "LeftShoulder") end
Player.Optional.LeftShoulder = LeftShoulder
local function LeftHip(inst) return Player.Optional.EmbeddedPart(inst, "LeftUpperLeg", "LeftHip") end
function Player.LeftHip(inst) return Player.EmbeddedPart(inst, "LeftUpperLeg", "LeftHip") end
Player.Optional.LeftHip = LeftHip
local function RightAnkle(inst) return Player.Optional.EmbeddedPart(inst, "RightFoot", "RightAnkle") end
function Player.RightAnkle(inst) return Player.EmbeddedPart(inst, "RightFoot", "RightAnkle") end
Player.Optional.RightAnkle = RightAnkle
local function RightWrist(inst) return Player.Optional.EmbeddedPart(inst, "RightHand", "RightWrist") end
function Player.RightWrist(inst) return Player.EmbeddedPart(inst, "RightHand", "RightWrist") end
Player.Optional.RightWrist = RightWrist
local function RightElbow(inst) return Player.Optional.EmbeddedPart(inst, "RightLowerArm", "RightElbow") end
function Player.RightElbow(inst) return Player.EmbeddedPart(inst, "RightLowerArm", "RightElbow") end
Player.Optional.RightElbow = RightElbow
local function RightKnee(inst) return Player.Optional.EmbeddedPart(inst, "RightLowerLeg", "RightKnee") end
function Player.RightKnee(inst) return Player.EmbeddedPart(inst, "RightLowerLeg", "RightKnee") end
Player.Optional.RightKnee = RightKnee
local function RightShoulder(inst) return Player.Optional.EmbeddedPart(inst, "RightUpperArm", "RightShoulder") end
function Player.RightShoulder(inst) return Player.EmbeddedPart(inst, "RightUpperArm", "RightShoulder") end
Player.Optional.RightShoulder = RightShoulder
local function RightHip(inst) return Player.Optional.EmbeddedPart(inst, "RightUpperLeg", "RightHip") end
function Player.RightHip(inst) return Player.EmbeddedPart(inst, "RightUpperLeg", "RightHip") end
Player.Optional.RightHip = RightHip
-- Player screen stuff
local function PlayerGui(inst)
	return Player.Player(inst):FindFirstChild("PlayerGui")
end
function Player.PlayerGui(inst)
	return Player.Player(inst):WaitForChild("PlayerGui", math.huge)
end
Player.Optional.PlayerGui = PlayerGui
function Player.Mouse(inst)
	return Player.Player(inst):GetMouse()
end
--- Cam
function Player.Camera()
	return workspace.CurrentCamera
end
--- player name
function Player.Name(inst)
	return Player.Player(inst).Name
end
--- display name
function Player.DisplayName(inst)
	return Player.Player(inst).DisplayName
end
--- Animator
local function Animator(inst)
	local playerHumanoid = Player.Optional.Humanoid(inst)
	if playerHumanoid then
		local playerAnimator = playerHumanoid:FindFirstChildOfClass("Animator")
		if playerAnimator then
			return playerAnimator
		end
		local plrAnimCtrl = playerHumanoid:FindFirstChildOfClass("AnimationController")
		if plrAnimCtrl then
			return plrAnimCtrl
		end
		return playerHumanoid
	end
	return nil
end
Player.Optional.Animator = Animator
function Player.Animator(inst)
	local playerHumanoid = Player.Humanoid(inst)
	local playerAnimator = playerHumanoid:FindFirstChildOfClass("Animator")
	if playerAnimator then
		return playerAnimator
	end
	local plrAnimCtrl = playerHumanoid:FindFirstChildOfClass("AnimationController")
	if plrAnimCtrl then
		return plrAnimCtrl
	end
	return playerHumanoid
end

return Player