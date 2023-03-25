AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:InitProjectile()
end

function ENT:InitProjectile()
    self:SetModel("models/magic_wand/w_projectile/w_projectile")
    self:PhysicsInit(SOLID_NONE)
    self:SetSolid( SOLID_NONE ) 
    self:SetMoveType( MOVETYPE_NONE )
    self:SetCollisionGroup(COLLISION_GROUP_NONE)
    self:PhysWake()
    self:DrawShadow(false)

    timer.Simple(4, function()
        if (IsValid(self)) then
            self:Remove()
        end
    end)
end

function ENT:SetWeapon(weapon)
    self.weapon = weapon
end

function ENT:Think()
    self:SetPos(self:GetPos() + Vector(5, 0, 0))
    self:NextThink( CurTime() + 1 )
    return true
end

function ENT:PhysicsCollide(colData, collider)
    if CurTime() > self.nextHitTime then

        local hitPlayer = colData.HitEntity
        self.nextHitTime = CurTime() + 0.1

        if IsValid(hitPlayer) and hitPlayer:IsPlayer() and self:GetVelocity():Length() > 100 then

            if (IsValid(ttt_hydrodynamic_spetule_last_hit_player) and hitPlayer:GetName() ~= ttt_hydrodynamic_spetule_last_hit_player:GetName()) then
                print("notlast")
                ttt_hydrodynamic_spetule_last_hit_player:SetWalkSpeed(220)
                ttt_hydrodynamic_spetule_last_hit_player:SetRunSpeed(220)
                timer.Remove("resetRunSpeed")
            end

            hitPlayer:TakeDamage(HYDRODYNAMIC_SPETULA.CVARS.hydrodynamic_spetula_burger_damage, self:GetOwner(), self.weapon)
            hitPlayer:SetWalkSpeed(220 * HYDRODYNAMIC_SPETULA.CVARS.hydrodynamic_spetula_burger_target_resulting_speed)
            hitPlayer:SetRunSpeed(220 * HYDRODYNAMIC_SPETULA.CVARS.hydrodynamic_spetula_burger_target_resulting_speed)
            ttt_hydrodynamic_spetule_last_hit_player = hitPlayer

            if timer.Exists("resetRunSpeed") then
                timer.Adjust("resetRunSpeed", 2, nil, nil)
            else
                timer.Create("resetRunSpeed", 2, 1, function()
                    hitPlayer:SetWalkSpeed(220)
                    hitPlayer:SetRunSpeed(220)
                    ttt_hydrodynamic_spetule_last_hit_player = nil
                end)
            end
        end
    end
end