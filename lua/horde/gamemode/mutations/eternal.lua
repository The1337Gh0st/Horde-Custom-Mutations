MUTATION.PrintName = "Eternal"
MUTATION.Description = "Material is set to a textureless white. \n25% chance to dodge attacks, damage received cannot exceed 25% of max health. \nOnly randomly occurs starting from wave 8."
MUTATION.Wave = 8

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "eternal" then
        local c = ent:GetColor()
        ent:SetMaterial("models/shiny")
    end
end

hook.Add("EntityTakeDamage", "Horde_EternalTakeDamage", function (target, dmg)
    if not target:IsValid() then return end
    if target:IsNPC() and target:Horde_HasMutation("eternal") then
	local p = math.random()
	local quarter = target:GetMaxHealth() * 0.25
	 if p <= 0.25 then
	dmg:SetDamage(0)
	end
	if target:IsNPC() and target:Horde_HasMutation("eternal") and (dmg:GetDamage() >= quarter) then
	dmg:SetDamage(quarter)
	end
end
end)

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "eternal" then return end
end
