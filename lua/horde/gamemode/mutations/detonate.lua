MUTATION.PrintName = "Detonate"
MUTATION.Description = "Tinted yellow. \n50% reduction to blast damage received. Spawns a live grenade on death that deals Blast damage. \nOnly randomly occurs starting from wave 3."
MUTATION.Wave = 3

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "detonate" then
        ent.Horde_Mutation_Detonate = true
		ent:SetColor(Color(253, 248, 32))
    end
end

MUTATION.Hooks.Horde_OnEnemyKilled = function(victim, killer, weapon)
    if victim:Horde_HasMutation("detonate") then
        local ent = ents.Create("arccw_horde_detonate_nade")
        ent:SetPos(victim:GetPos())
        ent:SetOwner(victim)
        ent.Owner = victim
        ent.Inflictor = victim
        ent:Spawn()
        ent:Activate()
        timer.Simple(3.5, function()
            if ent:IsValid() then
                ent:Detonate()
            end
        end)
        if ent:GetPhysicsObject():IsValid() then
            ent:GetPhysicsObject():EnableMotion(false)
        end
        timer.Simple(4, function() if ent:IsValid() then ent:Remove() end end)
    end
    end

hook.Add("EntityTakeDamage", "Horde_DetonateTakeDamage", function (target, dmg)
    if not target:IsValid() then return end
    if target:IsNPC() and target:Horde_HasMutation("detonate") and (dmg:IsDamageType(DMG_BLAST) or dmg:IsDamageType(DMG_MISSILEDEFENSE)) then
	dmg:ScaleDamage(0.5)
end
end)

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "detonate" then return end
    ent.Horde_Mutation_Detonate = nil
end
