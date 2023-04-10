SWEP.PrintName			= "Magic Wand"
SWEP.Author				= "Atlas"
SWEP.Instructions		= "Test"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= true
SWEP.DrawCrosshair		= true

SWEP.HoldType 	= "meele"
SWEP.ViewModelFOV = 40
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/magic_wand/c_magic_wand/c_magic_wand.mdl"
SWEP.WorldModel = "models/magic_wand/w_magic_wand/magic_wand.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.Icon 		= "VGUI/ttt/weapon_magic_wand.png"

SWEP.Base 			= "weapon_tttbase"
SWEP.Kind 			= WEAPON_EQUIP2
SWEP.AutoSpawnable 	= false
SWEP.AmmoEnt 		= "item_ammo_ttt"

SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.InLoadoutFor 	= nil
SWEP.LimitedStock 	= true
SWEP.AllowDelete 	= false
SWEP.AllowDrop 		= true

if CLIENT then
	SWEP.EquipMenuData = {
		type = "Weapon",
		desc = "Test"
	};
end
