if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.UseHands = nil

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Magpul PDR"
	SWEP.CSMuzzleFlashes = false
	
	SWEP.IronsightPos = Vector(-2.37, 0, 0.437)
	SWEP.IronsightAng = Vector(-0.21, 0.019, 0)
	
	SWEP.ViewModelMovementScale = 1
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.AimBreathingEnabled = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/roleplay_weapons/w_models/pdr.mdl"
	SWEP.WMPos = Vector(-0.4, -7.5, -1.5)
	SWEP.WMAng = Vector(-4.5, 0, 180)
	
	function SWEP:getMuzzlePosition()
	return self.CW_VM:GetAttachment(self.CW_VM:LookupAttachment(self.MuzzleAttachmentName))
	end
	
end

SWEP.MuzzleVelocity = 480 -- in meter/s

SWEP.ADSFireAnim = true
SWEP.MuzzleAttachmentName = "muzzle"

SWEP.Attachments = {}

SWEP.Animations = {
	draw = "base_draw",
	idle = "base_idle",
	
	fire = "base_fire",
	fire_aim = "base_fire",
	
	reload = "base_reload",
	reload_empty = "base_reloadempty",
}
	
SWEP.Sounds = {
	base_reload = {
		{time = 0.4, sound = "ROLEPLAY_PDR_MAGOUT"},
		{time = 3.1, sound = "ROLEPLAY_PDR_MAGIN"}
	},
	
	base_reloadempty = {
		{time = 0.4, sound = "ROLEPLAY_PDR_MAGOUT"},
		{time = 3.1, sound = "ROLEPLAY_PDR_MAGIN"},
		{time = 3.95, sound = "ROLEPLAY_PDR_BOLTFORWARD"},
		{time = 4.35, sound = "ROLEPLAY_PDR_BOLTBACK"}
	}
}

SWEP.SpeedDec = 30

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "rpg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "roleplay_base"
SWEP.Category = "CW 2.0 Roleplay SMGs"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.UseHands = true
SWEP.ViewModel		= "models/roleplay_weapons/v_models/pdr.mdl"
SWEP.WorldModel		= "models/roleplay_weapons/w_models/pdr.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireSound = "ROLEPLAY_PDR_FIRE"

SWEP.FireDelay = 0.087
SWEP.Recoil = 1.252

SWEP.HipSpread = 0.039
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.02
SWEP.SpreadPerShot = 0.004
SWEP.SpreadCooldown = 0.11
SWEP.Shots = 1
SWEP.Damage = 27
SWEP.DeployTime = 0.42

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 4.62
SWEP.ReloadTime_Empty = 5.9
SWEP.ReloadHalt = 1
SWEP.ReloadHalt_Empty = 1

function SWEP:createCustomVM(mdl)
self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
self.CW_VM:SetNoDraw(true)
self.CW_VM:SetupBones()

if self.ViewModelFlip then
local mtr = Matrix()
mtr:Scale(Vector(1, -1, 1))

self.CW_VM:EnableMatrix("RenderMultiply", mtr)
end
end

function SWEP:_drawViewModel()
-- draw the viewmodel
self.Owner:GetHands():SetParent(self.CW_VM)
self.Owner:GetHands():AddEffects(EF_BONEMERGE_FASTCULL)
self.Owner:GetHands():SetPos(self.CW_VM:GetPos())
self.Owner:GetHands():SetAngles(self.CW_VM:GetAngles())
--cam.IgnoreZ(false)
if self.ViewModelFlip then
render.CullMode(MATERIAL_CULLMODE_CW)
end

local POS = EyePos() - self.CW_VM:GetPos()

self.CW_VM:FrameAdvance(FrameTime())
self.CW_VM:SetupBones()
self.CW_VM:DrawModel()

if self.ViewModelFlip then
render.CullMode(MATERIAL_CULLMODE_CCW)
end

-- draw the attachments
self:drawAttachments()

-- draw the customization menu
self:drawInteractionMenu()

-- draw the unique scope behavior if it is defined
if self.reticleFunc then
self.reticleFunc(self)
end

-- and lastly, draw the custom hud if the player has it enabled
if GetConVarNumber("cw_customhud_ammo") >= 1 then
self:draw3D2DHUD()
end
end