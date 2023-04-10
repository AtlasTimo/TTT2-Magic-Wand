include("shared.lua")

local Spell1 = 0;
local Spell2 = 1:
local WorldModel = ClientsideModel(SWEP.WorldModel)

function SWEP:Initialize()
	self.SelectedSpell = Spell1
end

-- Settings...
WorldModel:SetSkin(1)
WorldModel:SetNoDraw(true)

function SWEP:DrawWorldModel()
	local _Owner = self:GetOwner()

	if (IsValid(_Owner)) then
		-- Specify a good position
		local offsetVec = Vector(3, -1, -3)
		local offsetAng = Angle(80, 0, 0)

		local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
		if !boneid then return end

		local matrix = _Owner:GetBoneMatrix(boneid)
		if !matrix then return end

		local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

		WorldModel:SetPos(newPos)
		WorldModel:SetAngles(newAng)

		WorldModel:SetupBones()
	else
		WorldModel:SetPos(self:GetPos())
		WorldModel:SetAngles(self:GetAngles())
	end

	WorldModel:DrawModel()
end

function SWEP:DrawHUD()
	if (self:GetOwner() == LocalPlayer() && self:GetOwner():ShouldDrawLocalPlayer()) then
		
	end
end

