MUTATION.PrintName = "Singe"
MUTATION.Description = "Tinted red and ignited. \nDamage builds up Ignite. Immune to Fire damage. \nOnly randomly occurs starting from wave 6."
MUTATION.Wave = 6

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "singe" then
        local c = ent:GetColor()
        ent:SetColor(Color(125, 50, 50))
        ent:Ignite(9999999)
    end
end

MUTATION.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_HasMutation("singe") then
   --     dmg:SetDamageType(DMG_BURN)
		ply:Horde_AddDebuffBuildup(HORDE.Status_Ignite, dmg:GetDamage() * 2)
    end	
end

hook.Add("EntityTakeDamage", "Horde_SingeTakeDamage", function (target, dmg)
    if not target:IsValid() then return end
    if target:IsNPC() and target:Horde_HasMutation("singe") and (dmg:IsDamageType(DMG_BURN) or dmg:IsDamageType(DMG_SLOWBURN) or dmg:IsDamageType(DMG_PLASMA)) then
	dmg:SetDamage(0)
end
end)

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "singe" then return end
end