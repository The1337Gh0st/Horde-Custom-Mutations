MUTATION.PrintName = "Wall"
MUTATION.Description = "Material set to brick. \n50% decrease in physical damage taken, but 50% increase in blast and ice damage taken. \nOnly randomly occurs starting from wave 3."
MUTATION.Wave = 3

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "wall" then
		ent:SetMaterial("brick/brick_model")
    end
end

hook.Add("EntityTakeDamage", "Horde_WallTakeDamage", function (target, dmg)
    if not target:IsValid() then return end
    if target:IsNPC() and target:Horde_HasMutation("wall") and (dmg:IsDamageType(DMG_BULLET) or dmg:IsDamageType(DMG_SNIPER) or dmg:IsDamageType(DMG_BUCKSHOT) or dmg:IsDamageType(DMG_CLUB) or dmg:IsDamageType(DMG_SLASH) or dmg:IsDamageType(DMG_GENERIC) or dmg:IsDamageType(DMG_CRUSH) or dmg:IsDamageType(DMG_SONIC)) then
	dmg:ScaleDamage(0.5)
end
    if target:IsNPC() and target:Horde_HasMutation("wall") and (dmg:IsDamageType(DMG_BLAST) or dmg:IsDamageType(DMG_MISSILEDEFENSE) or dmg:IsDamageType(DMG_REMOVENORAGDOLL)) then
	dmg:ScaleDamage(1.5)
end
end)

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "wall" then return end
end