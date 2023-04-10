AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1.0)
	local ow = self:GetOwner()
	traceResult = ow:GetEyeTrace()
	targetEntity = traceResult.Entity
	if (targetEntity == nil) then return end
	if (not targetEntity:IsPlayer()) then return end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.AllowDrop = false 
	ow:SetAnimation(PLAYER_ATTACK1)

	timer.Simple(0.1, function()
		if (not ow:IsValid()) then return end
		if (not targetEntity:IsValid()) then return end
		if (not targetEntity:Alive()) then return end
		if (targetEntity:GetObserverMode() ~= OBS_MODE_NONE) then return end
		self:CreateBeamSpell(ow, "255 15 15", targetEntity:GetPos())
		targetEntity:StripWeapons()
		self.AllowDrop = true
	end)
end

function SWEP:CreateBeamSpell(ow, color, targetPos)
	if (not ow:IsValid()) then return end

	local pViewModel = ow:GetViewModel()
	if (not pViewModel:IsValid()) then return end

	local uAttachment = pViewModel:LookupAttachment("tip")
	if (uAttachment < 1) then return end

	local tAttachment = pViewModel:GetAttachment(uAttachment)
	if (tAttachment == nil) then return end

	self.tip = ents.Create("info_target")
	self.tip:SetKeyValue("targetname", tostring(self.tip))
	self.tip:SetPos(tAttachment.Pos)
	self.tip:Spawn()

	self.targ = ents.Create("info_target")
	self.targ:SetKeyValue("targetname", tostring(self.targ))
	self.targ:SetPos(targetPos + Vector(0, 0, 30))
	self.targ:Spawn()

	self.stuetzVektor = self.tip:GetPos()
	self.richtungsVektor = self.targ:GetPos() - self.tip:GetPos()

	self.laser = ents.Create("env_beam")
	self.laser:SetKeyValue("Radius", 0)
	self.laser:SetKeyValue("BoltWidth", 1)
	self.laser:SetKeyValue("LightningStart", tostring(self.tip))
	self.laser:SetKeyValue("LightningEnd", tostring(self.targ))
	self.laser:SetKeyValue("rendercolor", color)
	self.laser:SetKeyValue("renderamt", "255")
	self.laser:SetKeyValue("damage", "0")
	self.laser:SetKeyValue("texture", "sprites/laserbeam.spr")
	self.laser:SetKeyValue("TextureScroll", "30")

	self.laser:Spawn()
	self.laser:SetKeyValue("life", "0.1")
	self.laser:Fire("StrikeOnce")
	self.tip:Fire("Kill", "", 0.1)
	self.targ:Fire("Kill", "", 0.1)
	self.laser:Fire("Kill", "", 0.1)
end

function SWEP:OnDrop()
	if (self.AllowDrop) then return end
	self:Remove()
end