AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1.0)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.AllowDrop = false 
	local ow = self:GetOwner()

	timer.Simple(0.1, function()
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
		self.targ:SetPos(tAttachment.Pos + ow:GetAimVector() * 500)
		self.targ:Spawn()

		self.stuetzVektor = self.tip:GetPos()
		self.richtungsVektor = self.targ:GetPos() - self.tip:GetPos()

		self.laser = ents.Create("env_beam")
		self.laser:SetKeyValue("Radius", 0)
		self.laser:SetKeyValue("BoltWidth", 1)
		self.laser:SetKeyValue("LightningStart", tostring(self.tip))
		self.laser:SetKeyValue("LightningEnd", tostring(self.targ))
		self.laser:SetKeyValue("rendercolor", "255 15 15")
		self.laser:SetKeyValue("renderamt", "255")
		self.laser:SetKeyValue("damage", "0")
		self.laser:SetKeyValue("texture", "sprites/laserbeam.spr")
		self.laser:SetKeyValue("TextureScroll", "30")

		self.laser:Spawn()
		self.laser:SetKeyValue("life", "0.05")
		self.laser:Fire("StrikeOnce")
		self.lastStrike = CurTime()
		self.tip:Fire("Kill", "", 5)
		self.targ:Fire("Kill", "", 5)
		self.laser:Fire("Kill", "", 5)

		self.AllowDrop = true
	end)
end

function SWEP:Think()
	if (self.lastStrike = nil) then return end
	if (CurTime() >= self.lastStrike + 0.05) then return end

	local ow = self:GetOwner()
	if (not ow:IsValid()) then return end

	local pViewModel = ow:GetViewModel()
	if (not pViewModel:IsValid()) then return end

	local uAttachment = pViewModel:LookupAttachment("tip")
	if (uAttachment < 1) then return end

	local tAttachment = pViewModel:GetAttachment(uAttachment)
	if (tAttachment == nil) then return end

	if (self.tip == nil) then return end

	self.tip:SetPos(tAttachment.Pos)
	self.laser:SetKeyValue("LightningStart", tostring(self.tip))
	self.laser:Fire("StrikeOnce")
	self.lastStrike = CurTime()
end

function SWEP:OnDrop()
	if (self.AllowDrop) then return end
	self:Remove()
end