AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 2.0)
end

function SWEP:OnDrop()
	if (self.AllowDrop) then return end
	self:Remove()
end