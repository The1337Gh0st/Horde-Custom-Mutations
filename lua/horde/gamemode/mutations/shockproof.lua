MUTATION.PrintName = "Shockproof"
MUTATION.Description = "Tinted blue. \n75% reduction in damage received from non-physical damage.  \nOnly randomly occurs starting from wave 6."
MUTATION.Wave = 6

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "shockproof" then
        local c = ent:GetColor()
        ent:SetColor(Color(41, 134, 204))
    end
end

hook.Add("EntityTakeDamage", "Horde_ShockproofTakeDamage", function (target, dmg)
    if not target:IsValid() then return end
    if target:IsNPC() and target:Horde_HasMutation("shockproof") and not (dmg:IsDamageType(DMG_BULLET) or dmg:IsDamageType(DMG_SNIPER) or dmg:IsDamageType(DMG_BUCKSHOT) or dmg:IsDamageType(DMG_CLUB) or dmg:IsDamageType(DMG_SLASH) or dmg:IsDamageType(DMG_GENERIC) or dmg:IsDamageType(DMG_CRUSH) or dmg:IsDamageType(DMG_SONIC) or dmg:IsDamageType(DMG_DIRECT)) then
	dmg:ScaleDamage(0.25)
end
end)

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "shockproof" then return end
end