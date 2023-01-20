--#############################
--##### TRIP'S WOTLK MAGE #####
--#############################

local _G, setmetatable, pairs, ipairs, select, error, math = 
_G, setmetatable, pairs, ipairs, select, error, math 

local wipe                                     = _G.wipe     
local math_max                                = math.max      

local TMW                                     = _G.TMW 
local strlowerCache                          = TMW.strlowerCache
local Action                                = _G.Action
local toNum                                 = Action.toNum
local CONST                                 = Action.Const
local Create                                 = Action.Create
local Listener                                = Action.Listener
local Print                                    = Action.Print
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local Pet                                       = LibStub("PetLibrary") 
local AuraType                                    = LibStub("LibAuraTypes")

local SetToggle                                = Action.SetToggle
local GetToggle                                = Action.GetToggle
local GetPing                                = Action.GetPing
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local GetLatency                            = Action.GetLatency
local GetSpellInfo                            = Action.GetSpellInfo
local BurstIsON                                = Action.BurstIsON
local InterruptIsValid                        = Action.InterruptIsValid
local IsUnitEnemy                            = Action.IsUnitEnemy
local DetermineUsableObject                    = Action.DetermineUsableObject 
local DetermineIsCurrentObject                = Action.DetermineIsCurrentObject 
local DetermineCountGCDs                    = Action.DetermineCountGCDs 
local DetermineCooldownAVG                    = Action.DetermineCooldownAVG 
local AuraIsValid                            = Action.AuraIsValid

local CanUseStoneformDefense                = Action.CanUseStoneformDefense
local CanUseStoneformDispel                    = Action.CanUseStoneformDispel
local CanUseHealingPotion                    = Action.CanUseHealingPotion
local CanUseLivingActionPotion                = Action.CanUseLivingActionPotion
local CanUseLimitedInvulnerabilityPotion    = Action.CanUseLimitedInvulnerabilityPotion
local CanUseRestorativePotion                = Action.CanUseRestorativePotion
local CanUseSwiftnessPotion                    = Action.CanUseSwiftnessPotion
local CanUseManaRune                        = Action.CanUseManaRune

local TeamCacheFriendly                        = TeamCache.Friendly
local TeamCacheFriendlyGUIDs                = TeamCacheFriendly.GUIDs -- unitGUID to unitID
local TeamCacheEnemy                        = TeamCache.Enemy
local ActiveUnitPlates                        = MultiUnits:GetActiveUnitPlates()

local SPELL_FAILED_TARGET_NO_POCKETS        = _G.SPELL_FAILED_TARGET_NO_POCKETS      
local ERR_INVALID_ITEM_TARGET                = _G.ERR_INVALID_ITEM_TARGET    
local MAX_BOSS_FRAMES                        = _G.MAX_BOSS_FRAMES  

local CreateFrame                            = _G.CreateFrame
local UIParent                                = _G.UIParent        
local StaticPopup1                            = _G.StaticPopup1    
local StaticPopup1Button2                    -- nil because frame is not created at this moment

local GetWeaponEnchantInfo                    = _G.GetWeaponEnchantInfo    
local GetItemInfo                            = _G.GetItemInfo  
local      UnitGUID,       UnitIsUnit,      UnitCreatureType,       UnitAttackPower = 
_G.UnitGUID, _G.UnitIsUnit, _G.UnitCreatureType, _G.UnitAttackPower

--For Toaster
local Toaster                                    = _G.Toaster
local GetSpellTexture                             = _G.TMW.GetSpellTexture

Action[Action.PlayerClass]                     = {
    --Racial
	Perception									= Create({ Type = "Spell", ID = 58985		}),
	EscapeArtist								= Create({ Type = "Spell", ID = 20589		}),
	BloodFury									= Create({ Type = "Spell", ID = 20572		}),
	Berserking									= Create({ Type = "Spell", ID = 26297		}),	
	WilloftheForsaken							= Create({ Type = "Spell", ID = 7744		}),
	ArcaneTorrent								= Create({ Type = "Spell", ID = 28730		}),	
	GiftoftheNaaru								= Create({ Type = "Spell", ID = 59548		}),	
	
	--Class Skills
	AmplifyMagic			= Create({ Type = "Spell", ID = 1008, useMaxRank = true        }),
	ArcaneBlast				= Create({ Type = "Spell", ID = 30451, useMaxRank = true        }),
--	ArcaneBlastBuff			= Create({ Type = "Spell", ID = 36032, useMaxRank = true        }),	
	ArcaneBrilliance		= Create({ Type = "Spell", ID = 23028, useMaxRank = true        }),
	ArcaneExplosion			= Create({ Type = "Spell", ID = 1449, useMaxRank = true        }),
	ArcaneIntellect			= Create({ Type = "Spell", ID = 1459, useMaxRank = true        }),
	ArcaneMissiles			= Create({ Type = "Spell", ID = 5143, useMaxRank = true        }),
	Blink					= Create({ Type = "Spell", ID = 1953, useMaxRank = true        }),
	Blizzard				= Create({ Type = "Spell", ID = 10, useMaxRank = true        }),
	ConeofCold				= Create({ Type = "Spell", ID = 120, useMaxRank = true        }),
	ConjureFood				= Create({ Type = "Spell", ID = 587, useMaxRank = true        }),
	ConjureManaGem			= Create({ Type = "Spell", ID = 759, useMaxRank = true        }),
	ConjureRefreshment		= Create({ Type = "Spell", ID = 42956, useMaxRank = true        }),	
	ConjureWater			= Create({ Type = "Spell", ID = 5504, useMaxRank = true        }),
	Counterspell			= Create({ Type = "Spell", ID = 2139, useMaxRank = true, Desc = "Automatic Interrupt"        }),
	DalaranBrilliance		= Create({ Type = "Spell", ID = 61316, useMaxRank = true        }),	
	DalaranIntellect		= Create({ Type = "Spell", ID = 61024, useMaxRank = true        }),
	DampenMagic				= Create({ Type = "Spell", ID = 604, useMaxRank = true        }),
	Evocation				= Create({ Type = "Spell", ID = 12051, useMaxRank = true        }),
	FireBlast				= Create({ Type = "Spell", ID = 2136, useMaxRank = true        }),
	FireWard				= Create({ Type = "Spell", ID = 543, useMaxRank = true        }),	
	Fireball				= Create({ Type = "Spell", ID = 133, useMaxRank = true        }),
	Flamestrike				= Create({ Type = "Spell", ID = 2120, useMaxRank = true        }),
	FrostArmor				= Create({ Type = "Spell", ID = 168, useMaxRank = true        }),	
	FrostNova				= Create({ Type = "Spell", ID = 122, useMaxRank = true        }),
	FrostWard				= Create({ Type = "Spell", ID = 6143, useMaxRank = true        }),
	Frostbolt				= Create({ Type = "Spell", ID = 205, useMaxRank = true        }),
	FrostboltR1				= Create({ Type = "Spell", ID = 116, isRank = 1       }),	
	FrostfireBolt			= Create({ Type = "Spell", ID = 44614, useMaxRank = true        }),	
	IceArmor				= Create({ Type = "Spell", ID = 7302, useMaxRank = true        }),
	IceBlock				= Create({ Type = "Spell", ID = 45438, useMaxRank = true        }),
	IceLance				= Create({ Type = "Spell", ID = 30455, useMaxRank = true        }),	
	Invisibility			= Create({ Type = "Spell", ID = 66, useMaxRank = true        }),
	MageArmor				= Create({ Type = "Spell", ID = 6117, useMaxRank = true        }),
	ManaShield				= Create({ Type = "Spell", ID = 1463, useMaxRank = true        }),
	MirrorImage				= Create({ Type = "Spell", ID = 55342, useMaxRank = true        }),
	MoltenArmor				= Create({ Type = "Spell", ID = 30482, useMaxRank = true        }),	
	Polymorph				= Create({ Type = "Spell", ID = 118, useMaxRank = true        }),
	RemoveCurse				= Create({ Type = "Spell", ID = 475, useMaxRank = true        }),
	RitualofRefreshment		= Create({ Type = "Spell", ID = 43987, useMaxRank = true        }),	
	Scorch					= Create({ Type = "Spell", ID = 2948, useMaxRank = true        }),	
	SlowFall				= Create({ Type = "Spell", ID = 130, useMaxRank = true        }),	
	Spellsteal				= Create({ Type = "Spell", ID = 30449, useMaxRank = true        }),	
	SummonWaterElemental	= Create({ Type = "Spell", ID = 31687, useMaxRank = true        }),	
	ArcaneBarrage			= Create({ Type = "Spell", ID = 44425, useMaxRank = true        }),	
	ArcanePower				= Create({ Type = "Spell", ID = 12042, useMaxRank = true        }),
	BlastWave				= Create({ Type = "Spell", ID = 11113, useMaxRank = true        }),	
	ColdSnap				= Create({ Type = "Spell", ID = 11958, useMaxRank = true        }),	
	Combustion				= Create({ Type = "Spell", ID = 11129, useMaxRank = true        }),	
	DragonsBreath			= Create({ Type = "Spell", ID = 31661, useMaxRank = true        }),	
	FocusMagic				= Create({ Type = "Spell", ID = 54646, useMaxRank = true        }),
	IceBarrier				= Create({ Type = "Spell", ID = 11426, useMaxRank = true        }),	
	IcyVeins				= Create({ Type = "Spell", ID = 12472, useMaxRank = true        }),	
	LivingBomb				= Create({ Type = "Spell", ID = 44457, useMaxRank = true        }),	
	PresenceofMind			= Create({ Type = "Spell", ID = 12043, useMaxRank = true        }),
	Pyroblast				= Create({ Type = "Spell", ID = 11366, useMaxRank = true        }),	
	DeepFreeze				= Create({ Type = "Spell", ID = 44572, useMaxRank = true        }),	

    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444	}),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua

	--Glyphs

	
	--Items
	ManaAgate				= Create({ Type = "Item", ID = 5514, Hidden = true       }),
	ManaJade				= Create({ Type = "Item", ID = 5513, Hidden = true       }),	
	ManaCitrine				= Create({ Type = "Item", ID = 8007, Hidden = true       }),
	ManaRuby				= Create({ Type = "Item", ID = 8008, Hidden = true       }),	
	ManaEmerald				= Create({ Type = "Item", ID = 22044, Hidden = true       }),
	
	--Talents
	MissileBarrage				= Create({ Type = "Spell", ID = 44404, useMaxRank = true, Hidden = true       }),	
	MissileBarrageBuff			= Create({ Type = "Spell", ID = 44401, useMaxRank = true, Hidden = true       }),
	ArcanePotency				= Create({ Type = "Spell", ID = 57531, useMaxRank = true, Hidden = true       }),	
	HotStreak					= Create({ Type = "Spell", ID = 48108, useMaxRank = true, Hidden = true       }),	
	HotStreakTalent				= Create({ Type = "Spell", ID = 44445, useMaxRank = true, Hidden = true       }),
	Firestarter					= Create({ Type = "Spell", ID = 54741, useMaxRank = true, Hidden = true       }),	
	ArcaneEmpowerment			= Create({ Type = "Spell", ID = 31579, useMaxRank = true, Hidden = true       }),	
	BrainFreeze					= Create({ Type = "Spell", ID = 57761, useMaxRank = true, Hidden = true       }),	
	FingersofFrost				= Create({ Type = "Spell", ID = 74396, useMaxRank = true, Hidden = true       }),
	WintersChill				= Create({ Type = "Spell", ID = 74396, useMaxRank = true, Hidden = true       }),	
	
	--PVP
	CatForm										= Create({ Type = "Spell", ID = 768, Hidden = true         }),	

    --Misc
    Hypothermia								= Create({ Type = "Spell", ID = 41425        }),
	Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),
	FelIntelligence								= Create({ Type = "Spell", ID = 57567, useMaxRank = true         }),
	KirusSongofVictory							= Create({ Type = "Spell", ID = 46302         }),	
	PolymorphGreen								= Create({ Type = "SpellSingleColor", ID = 118, Color = "GREEN", Desc = "AntiFake CC", useMaxRank = true        }),
	CounterspellGreen							= Create({ Type = "SpellSingleColor", ID = 2139, Color = "GREEN", Desc = "AntiFake Interrupt", useMaxRank = true        }),	
}

local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })

local player = "player"
local target = "target"
local pet = "pet"
local targettarget = "targettarget"
local focus = "focus"

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

--Register Toaster
Toaster:Register("TripToast", function(toast, ...)
        local title, message, spellID = ...
        toast:SetTitle(title or "nil")
        toast:SetText(message or "nil")
        if spellID then 
            if type(spellID) ~= "number" then 
                error(tostring(spellID) .. " (spellID) is not a number for TripToast!")
                toast:SetIconTexture("Interface\FriendsFrame\Battlenet-WoWicon")
            else 
                toast:SetIconTexture((GetSpellTexture(spellID)))
            end 
        else 
            toast:SetIconTexture("Interface\FriendsFrame\Battlenet-WoWicon")
        end 
        toast:SetUrgencyLevel("normal") 
end)

------------------------------------------
-------------- COMMON PREAPL -------------
------------------------------------------
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun", 48707}, -- added Anti-Magic Shell
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun", "CCMagicImun", 19263, 34692, 47585}, --added Deterrence, The Beast Within, Dispersion
    AuraForCC                               = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun"},    
    AuraForInterrupt                        = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "KickImun"},
    AuraForFear                             = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "FearImun"},	
	StopStomping							= 0,
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
}    

local BlockSpellFireWard = {
	51505, 60043, -- Lava Burst
	133, 143, 145, 3140, 8400, 8401, 8402, 10148, 10149, 10150, 10151, 25306, 27070, 38692, 42832, 42833, -- Fireball
	2948, 8444, 8445, 8446, 10205, 10206, 10207, 27073, 27074, 42858, 42859, -- Scorch
	11366, 12505, 12522, 12523, 12524, 12525, 12526, 18809, 27132, 33938, 42890, 42891, -- Pyroblast
	29722, 32231, 47837, 47838, -- Incinerate
	50796, 59170, 59171, 59172, -- Chaos Bolt

}

local BlockSpellFrostWard = {
	44614, 47610, -- FrostFire Bolt
	116, 205, 837, 7322, 8406, 8407, 8408, 10179, 10180, 10181, 25304, 27071, 27072, 38697, 42841, 42842, -- Frostbolt	

}

local function BlockDebuffFireWard()

	return Unit(player):HasDeBuffs({
	44457, -- Living Bomb
	348, -- Immolate
	
	
	}) > 0
end

local function BlockDebuffFrostWard()
	
	return Unit(player):HasDeBuffs({
	45477, -- Icy Touch
	55095, -- Frost Fever


	}) > 0
end

local function SpellstealList()
	
	return Unit(unitID):HasBuffs({
	12042,  -- Arcane Power
	31884,  -- Avenging wrath
	2825,   -- Bloodlust
	16166,  -- Elemental Mastery
	44544,  -- Fingers of Frost
	57761,  -- Fireball
	1044,   -- Hand of Freedom
	32182,  -- Heroism
	12472,  -- Icy Veins
	29166,  -- Innervate
	10060,  -- Power Infusion

	}) > 0
end

local StompMe = {
	5193, -- Tremor Totem
	2630, -- Earthbind
	10467, -- Mana Tide Totem
	5925, -- Grounding Totem
	3579, 3911, 3912, 3913, 7398, 7399, 15478, 31120, 31121, 31122, --Stoneclaw Totem

}

--[[local function TotemStomp()

	if A.IceLance:IsReady(target) or A.FireBlast:IsReady(target) then
		local TotemNameplates = MultiUnits:GetActiveUnitPlates()
		if TotemNameplates then
			for TotemUnit in pairs(TotemNameplates) do
				for i = 1, #StompMe do 
					local TotemID = select(6, Unit(TotemUnit):InfoGUID())					
					if Unit(TotemUnit):IsTotem() and TotemID == StompMe[i] and A.IceLance:IsInRange(TotemUnit) then
						if not UnitIsUnit(TotemUnit, target) then
							return A:Show(icon, ACTION_CONST_AUTOTARGET)
						elseif UnitIsUnit(TotemUnit, target) then
							if A.IceLance:IsReady(target) then
								return A.IceLance
							end
							if A.FireBlast:IsReady(target) then
								return A.FireBlast
							end
						end
					end
				end
			end
		end
	end
	
end]]

local function InRange(unitID)
    -- @return boolean 
    return A.Frostbolt:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function Interrupts()
	local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(target, nil, nil, true) 

	if useKick and A.Counterspell:IsReady(target) and not notInterruptable and castRemainsTime > A.GetLatency() and A.Counterspell:AbsentImun(target, Temp.TotalAndMagKick) then
		return A.Counterspell
	end

end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function SpellstealPurge(unitID)
    if A.Spellsteal:IsReady(unitID, true) then 
		if AuraIsValid(unitID, "UseDispel", "PurgeHigh") then 
			return A.Spellsteal
		end 
    end 
end

local function ArmorChoice()
    local inCombat = Unit(player):CombatTime() > 0
	local MageArmorRefresh = (not inCombat and Unit(player):HasBuffs(A.MageArmor.ID) >= 0 and Unit(player):HasBuffs(A.MageArmor.ID) <= 300) or Unit(player):HasBuffs(A.MageArmor.ID) == 0
	local MoltenArmorRefresh = (not inCombat and Unit(player):HasBuffs(A.MoltenArmor.ID) >= 0 and Unit(player):HasBuffs(A.MoltenArmor.ID) <= 300) or Unit(player):HasBuffs(A.MoltenArmor.ID) == 0	
	local FrostArmorRefresh = (not inCombat and Unit(player):HasBuffs(A.FrostArmor.ID) >= 0 and Unit(player):HasBuffs(A.FrostArmor.ID) <= 300) or Unit(player):HasBuffs(A.FrostArmor.ID) == 0
	local IceArmorRefresh = (not inCombat and Unit(player):HasBuffs(A.IceArmor.ID) >= 0 and Unit(player):HasBuffs(A.IceArmor.ID) <= 300) or Unit(player):HasBuffs(A.IceArmor.ID) == 0
	local ArmorSelect = A.GetToggle(2, "ArmorSelect")

	if not A.IsInPvP then	
		if ArmorSelect == "MageArmor" then
			if A.MageArmor:IsReady(player) and MageArmorRefresh then
				return A.MageArmor
			end
		elseif ArmorSelect == "MoltenArmor" then
			if A.MoltenArmor:IsReady(player) and MoltenArmorRefresh then
				return A.MoltenArmor
			end
		elseif ArmorSelect == "FrostArmor" and FrostArmorRefresh and IceArmorRefresh then
			if A.FrostArmor:IsReady(player) then
				return A.FrostArmor
			end
		end
	end
end

local function UseManaGem()
	local ManaGem = A.GetToggle(2, "ManaGem")  
	local GemItem = DetermineUsableObject(player, true, nil, true, nil, A.ManaAgate, A.ManaJade, A.ManaCitrine, A.ManaRuby, A.ManaEmerald)
	if GemItem then 
		if Unit(player):PowerPercent() <= ManaGem then 
			return A.ManaAgate
		end
	end 
end

local function WardCheck(unitID)
	
	local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(unitID)
		
	if A.IsUnitEnemy(unitID) then	
		if A.FireWard:IsReady(player) then 
			for i = 1, #BlockSpellFireWard do    
				if spellId == BlockSpellFireWard[i] then --and destGUID == UnitGUID("player") then        
					return A.FireWard
				end
			end
		end
		if A.FrostWard:IsReady(player) then
			for i = 1, #BlockSpellFrostWard do    
				if spellId == BlockSpellFrostWard[i] then --and destGUID == UnitGUID("player") then        
					return A.FrostWard
				end
			end	
		end
    end  
	
end

-- [1] AntiFake CC Target
A[1] = function(icon)  
	local unitID = "target"
	
	if A.PolymorphGreen:IsReady(unitID) and Unit(unitID):IsControlAble("incapacitate", 99) and Unit(unitID):InCC() == 0 and A.Polymorph:AbsentImun(unitID, Temp.DisableMag) then
		return A.PolymorphGreen:Show(icon)
	end
	
end

-- [2] AntiFake Interrupt Target
A[2] = function(icon)	
	local unitID = "target"
	
	local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, nil, nil, true)   
	if useKick and A.CounterspellGreen:IsReady(unitID) and castRemainsTime > A.GetLatency() and A.Counterspell:AbsentImun(unitID, Temp.TotalAndMagKick) then
		return A.CounterspellGreen:Show(icon)
	end
end

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)

    --------------------
    --- ROTATION VAR ---
    --------------------
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime() > 0
    local combatTime = Unit(player):CombatTime()
    local UseAoE = A.GetToggle(2, "AoE")
	local AoEEnemies = A.GetToggle(2, "AoEEnemies")
	local canAoE = UseAoE and MultiUnits:GetActiveEnemies(10, 30) >= AoEEnemies
	local isFrozen = Unit(player):HasBuffs(A.FingersofFrost.ID) > 0

	if (Player:IsCasting() or Player:IsChanneling()) then
		canCast = false
	else 
		canCast = true
	end
	
	if not A.Evocation:IsBlocked() and A.Evocation:GetCooldown() <= 5 and Player:ManaPercentage() <= A.GetToggle(2, "EvocationMana") + 10 then
		A.Toaster:SpawnByTimer("TripToast", 15, "Evocation!", "Using Evocation soon! Be prepared!", A.Evocation.ID)	
	end
	
    --###############################
    --##### POTIONS/HEALTHSTONE #####
    --###############################
    
    local UsePotions = A.GetToggle(1, "Potion")        
    local PotionController = A.GetToggle(2, "PotionController")    
 
		if not Player:IsStealthed() then 
			-- Healthstone 
			local Healthstone = GetToggle(2, "HSHealth") 
			if Healthstone >= 0 then 
				local HealthStoneObject = DetermineUsableObject(player, true, nil, true, nil, A.HSGreater3, A.HSGreater2, A.HSGreater1, A.HS3, A.HS2, A.HS1, A.HSLesser3, A.HSLesser2, A.HSLesser1, A.HSMajor3, A.HSMajor2, A.HSMajor1, A.HSMinor3, A.HSMinor2, A.HSMinor1)
				if HealthStoneObject then 			
					if Healthstone >= 100 then -- AUTO 
						if Unit(player):TimeToDie() <= 9 and Unit(player):HealthPercent() <= 40 then 
							return HealthStoneObject:Show(icon)	
						end 
					elseif Unit(player):HealthPercent() <= Healthstone then 
						return HealthStoneObject:Show(icon)								 
					end 
				end 
			end 		
		end 

	if UsePotions and combatTime > 2 then
		--Living Action
		if PotionController == "LivingActionPotion" and Action.CanUseLivingActionPotion(icon, InRange()) then 
			return true
		end 
		
		-- RestorativePotion
		if PotionController == "RestorativePotion" and Action.CanUseRestorativePotion(icon) then 
			return true 
		end   

		-- LimitedInvulnerabilityPotion
		if PotionController == "LimitedInvulnerabilityPotion" and Unit(player):HasBuffs("DeffBuffs") and Action.CanUseLimitedInvulnerabilityPotion(icon) then 
			return true  
		end 
		
		-- HealingPotion 
		if PotionController == "HealingPotion" and Action.CanUseHealingPotion(icon) then 
			return true 
		end 	
	end
    
    --######################
    --##### DEFENSIVES #####
    --######################	
	
	local DefensivesHP = A.GetToggle(2, "DefensivesHP")
	if inCombat then
		if A.IceBlock:IsReadyByPassCastGCD(player) and Unit(player):HealthPercent() <= DefensivesHP then
			return A.IceBlock:Show(icon)
		end	
	end
	
	--Will of the Forsaken
	if A.WilloftheForsaken:IsReady(player) and Unit(player):HasDeBuffs("Fear") > 0 then 
		return A.WilloftheForsaken:Show(icon)
	end 
	
	-- EscapeArtist
	if A.EscapeArtist:AutoRacial() then 
		return A.EscapeArtist:Show(icon)
	end 	  

	local MageArmorBuff = ArmorChoice()
	if MageArmorBuff then
		return MageArmorBuff:Show(icon)
	end
	
	local UseManaGem = UseManaGem()
	if inCombat and canCast then
		if UseManaGem then
			return UseManaGem:Show(icon)
		end
	end
	
	if A.ArcaneIntellect:IsReady(target) and Unit(target):HasBuffs(A.ArcaneIntellect.ID) == 0 and Unit(target):HasBuffs(A.FelIntelligence.ID) == 0 and Unit(target):HasBuffs( A.KirusSongofVictory.ID) == 0 and Unit(player):HasBuffs(A.ArcaneBrilliance.ID) == 0 and not inCombat and not Unit(target):IsNPC() and not Unit(target):IsTotem() then
		return A.ArcaneIntellect:Show(icon)
	end		

	if A.IceLance:IsReady(target) or A.FireBlast:IsReady(target) and Temp.StopStomping == 0 then
		local TotemNameplates = MultiUnits:GetActiveUnitPlates()
		if TotemNameplates then
			for TotemUnit in pairs(TotemNameplates) do
				for i = 1, #StompMe do 
					local TotemID = select(6, Unit(TotemUnit):InfoGUID())					
					if Unit(TotemUnit):IsTotem() and TotemID == StompMe[i] and A.IceLance:IsInRange(TotemUnit) then
						local TotemTarget = A.GetToggle(2, "TotemStomp")
						if not UnitIsUnit(TotemUnit, target) and TotemTarget then
							return A:Show(icon, ACTION_CONST_AUTOTARGET)
						elseif UnitIsUnit(TotemUnit, target) then
							if A.IceLance:IsReady(target) then
								return A.IceLance:Show(icon)
							end
							if A.FireBlast:IsReady(target) then
								return A.FireBlast:Show(icon)
							end
						end						
					end
				end
			end
		end
	end
	
	if A.IceBarrier:IsReady(player) and Unit(player):HasBuffs(A.IceBarrier.ID) == 0 then
		return A.IceBarrier:Show(icon)
	end
	
	local ManaShieldMana = A.GetToggle(2, "ManaShieldMana")
	if A.ManaShield:IsReady(player) and Unit(player):HasBuffs(A.ManaShield.ID) == 0 and Unit(player):HasBuffs(A.IceBarrier.ID) == 0 and Player:ManaPercentage() >= ManaShieldMana then
		return A.ManaShield:Show(icon)
	end
	
	if A.ColdSnap:IsReady(player) and ((A.SummonWaterElemental:GetCooldown() > 5 and A.IceBlock:GetCooldown() > 5) or (Unit(player):HasDeBuffs(A.Hypothermia.ID) < 2 and A.IceBlock:GetCooldown() > 5)) then
		return A.ColdSnap:Show(icon)
	end
	
	if BlockDebuffFireWard() and A.FireWard:IsReady(player) then
		return A.FireWard:Show(icon)
	end
	
	if BlockDebuffFrostWard() and A.FrostWard:IsReady(player) then
		return A.FrostWard:Show(icon)
	end
	
	local UseWard = WardCheck(target)
	local UseWardFocus = WardCheck(focus)
	if UseWard and UnitIsUnit(player, "targettarget") then
		return UseWard:Show(icon)
	end
	if UseWardFocus and UnitIsUnit(player, "focustarget") then
		return UseWardFocus:Show(icon)
	end
 
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
		local StopAtBreakAble = A.GetToggle(1, "StopAtBreakAble")
		local dontBreakCC = (Unit(unitID):HasDeBuffs("BreakAble") == 0 and StopAtBreakAble) or not StopAtBreakAble
		
		if A.RemoveCurse:IsReady(player, nil, nil, true) and AuraIsValid(player, "UseDispel", "Curse") then 
            return A.RemoveCurse:Show(icon)
        end 	
		
		local DoSpellsteal = SpellstealPurge(unitID)
		if DoSpellsteal then
			return DoSpellsteal:Show(icon)
		end
		
		local AutoInterrupt = A.GetToggle(2, "AutoInterrupt")
		local DoInterrupt = Interrupts()
		if DoInterrupt and AutoInterrupt then 
			return DoInterrupt:Show(icon)
		end
		
		local BlinkStun = A.GetToggle(2, "BlinkStun")
		if A.Blink:IsReady(player) and Unit(player):HasDeBuffs("Stuned") > 0.1 and BlinkStun then
			return A.Blink:Show(icon)
		end

		if A.IsInPvP then
		
		local localizedClass, englishClass, classIndex = UnitClass(unitID)	

			--[[if A.IceArmor:IsReady(player) and Unit(player):HasBuffs(A.FrostArmor.ID) == 0 and Unit(player):HasBuffs(A.IceArmor.ID) == 0 and englishClass == "WARRIOR" or englishClass == "ROGUE" or englishClass == "DEATH KNIGHT" or englishClass == "PALADIN" or Unit(unitID):HasBuffs(A.CatForm.ID) > 0 then
				return A.IceArmor:Show(icon)
			end]]
			
			if A.FrostNova:IsReady(player) and MultiUnits:GetByRange(10, 3) >= 1 then
				local FrostNovaNameplates = MultiUnits:GetActiveUnitPlates()
				if FrostNovaNameplates then
					for FrostNovaUnit in pairs(FrostNovaNameplates) do
						if Unit(FrostNovaUnit):GetRange() <= 10 and A.FrostNova:AbsentImun(FrostNovaUnit, Temp.DisableMag) then
							return A.FrostNova:Show(icon)
						end
					end
				end
			end
			
			
			--[[if A.FrostNova:IsReady(player) and MultiUnits:GetByRange(10, 3) >= 1 and dontBreakCC and A.FrostNova:AbsentImun(unitID, Temp.TotalAndMag) and then
				return A.FrostNova:Show(icon)
			end]]
			
			--R1 Frostbolt
			if A.Frostbolt:IsReady(unitID) and Unit(unitID):HasDeBuffs("Slowed") == 0 and not A.Frostbolt:IsSpellInFlight() and dontBreakCC and A.Frostbolt:AbsentImun(unitID, Temp.TotalAndMag) and not A.DragonsBreath:IsTalentLearned() then
				return A.SlowFall:Show(icon)
			end
			
		end

		local EvocationMana = A.GetToggle(2, "EvocationMana")
		if A.Evocation:IsReady(player) and inCombat and not isMoving and Player:ManaPercentage() < EvocationMana and Unit(player):HasDeBuffs(A.ArcaneBlast.ID) == 0 then
			return A.Evocation:Show(icon)
		end

		if Unit(unitID):HasBuffs("Reflect") >= 1 and IsUnitEnemy(unitID) then
			local PlayerBursting = Unit(player):HasBuffs(A.ArcanePower.ID) > 0 or Unit(player):HasBuffs(A.IcyVeins.ID) > 0 or Unit(player):HasBuffs(A.Combustion.ID) > 0 or Unit(player):HasBuffs(A.Berserking.ID) > 0 or Unit(player):HasBuffs(A.BloodFury.ID) > 0 
			
			if A.Polymorph:IsReady(unitID) and Unit(player):HealthPercent() <= 50 and not PlayerBursting then
				return A.Polymorph:Show(icon)
			end
			
			if A.IceLance:IsReady(unitID) and Unit(player):HasBuffs(A.FingersofFrost.ID) == 0 then
				return A.IceLance:Show(icon)
			end
			
			if A.FireBlast:IsReady(unitID) and Unit(player):HasBuffs(A.FingersofFrost.ID) > 0 then
				return A.FireBlast:Show(icon)
			end
		end 

		if inCombat and not canAoE and BurstIsON(unitID) and A.Frostbolt:AbsentImun(unitID, Temp.TotalAndMag) then
			if A.ArcanePower:IsReady(player) then
				return A.ArcanePower:Show(icon)
			end
			
			if A.IcyVeins:IsReady(player) and Unit(player):HasBuffs(A.IcyVeins.ID) == 0 then
				return A.IcyVeins:Show(icon)
			end
			
			if A.Combustion:IsReady(player) then
				return A.Combustion:Show(icon)
			end
			
			if A.MirrorImage:IsReady(player) then
				return A.MirrorImage:Show(icon)
			end
			
			if A.BloodFury:IsReady(player) then
				return A.BloodFury:Show(icon)
			end
			
			if A.Berserking:IsReady(player) then
				return A.Berserking:Show(icon)
			end
			
			--Trinket 1
			if A.Trinket1:IsReady(player) then
				return A.Trinket1:Show(icon)    
			end
			
			--Trinket 2
			if A.Trinket2:IsReady(player) then
				return A.Trinket2:Show(icon)    
			end    			
		end

		if A.DeepFreeze:IsReady(unitID) and dontBreakCC and A.DeepFreeze:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.DeepFreeze:Show(icon)
		end
		
		if A.SummonWaterElemental:IsReady(player) and inCombat and dontBreakCC and A.Frostbolt:AbsentImun(unitID, Temp.TotalAndMag) and not Unit(pet):IsExists() then
			return A.SummonWaterElemental:Show(icon)
		end
		
		if Unit(player):HasBuffs(A.BrainFreeze.ID) > 0 and dontBreakCC then
			if A.FrostfireBolt:IsReady(unitID) and A.FrostfireBolt:AbsentImun(unitID, Temp.TotalAndMag) then 
				return A.FrostfireBolt:Show(icon)
			elseif A.Fireball:IsReady(unitID) and A.Fireball:AbsentImun(unitID, Temp.TotalAndMag) then
				return A.Fireball:Show(icon)
			end
		end

		if A.Pyroblast:IsReady(unitID) and Unit(player):HasBuffs(A.HotStreak.ID, true) > 0 and dontBreakCC and A.Pyroblast:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.Pyroblast:Show(icon)
		end

		if A.LivingBomb:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.LivingBomb.ID, true) == 0 and dontBreakCC and A.LivingBomb:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.LivingBomb:Show(icon)
		end

		if A.BlastWave:IsReady(player) and ((UseAoE and MultiUnits:GetByRange(10, 10) >= AoEEnemies) or (A.IsInPvP and MultiUnits:GetByRange(10, 10) >= 1)) and Unit(player):HasBuffs(A.Firestarter.ID) == 0 and A.BlastWave:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.BlastWave:Show(icon)
		end

		if A.Flamestrike:IsReady(player) and canAoE and ((Unit(player):HasBuffs(A.PresenceofMind.ID) > 0 and Unit(player):HasBuffs(A.ArcanePotency.ID) == 0) or Unit(player):HasBuffs(A.Firestarter.ID, true) > 0) and A.Flamestrike:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.Flamestrike:Show(icon)
		end

		if A.DragonsBreath:IsReady(player) and ((UseAoE and MultiUnits:GetByRange(10, 10) >= AoEEnemies) or (A.IsInPvP and MultiUnits:GetByRange(10, 10) >= 1)) and Unit(player):HasBuffs(A.Firestarter.ID) == 0 and A.DragonsBreath:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.DragonsBreath:Show(icon)
		end

		if A.ConeofCold:IsReady(player) and ((UseAoE and MultiUnits:GetByRange(10, 10) >= AoEEnemies) or (A.IsInPvP and MultiUnits:GetByRange(10, 10) >= 1)) and A.ConeofCold:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.ConeofCold:Show(icon)
		end

		if A.Blizzard:IsReady(player) and not isMoving and canAoE and A.Blizzard:AbsentImun(unitID, Temp.TotalAndMag) then
			if A.PresenceofMind:IsReady(player) then
				return A.PresenceofMind:Show(icon)
			end
			return A.Blizzard:Show(icon)
		end
		
		if A.Flamestrike:IsReady(player) and canAoE and (not isMoving or Unit(player):HasBuffs(A.PresenceofMind.ID) > 0 or Unit(player):HasBuffs(A.Firestarter.ID) > 0) and A.Flamestrike:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.Flamestrike:Show(icon)
		end
		
		if A.ArcaneExplosion:IsReady(player) and UseAoE and MultiUnits:GetByRange(8, 10) >= AoEEnemies and dontBreakCC and A.ArcaneExplosion:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.ArcaneExplosion:Show(icon)
		end

		if A.Scorch:IsReady(unitID) and A.HotStreakTalent:IsTalentLearned() and not isMoving and A.IsInPvP and dontBreakCC and A.Scorch:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.Scorch:Show(icon)
		end

		if A.Fireball:IsReady(unitID) and A.HotStreakTalent:IsTalentLearned() and not isMoving and dontBreakCC and A.Fireball:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.Fireball:Show(icon)
		end

		if A.ArcaneBarrage:IsReady(unitID) and Unit(player):HasBuffs(A.MissileBarrageBuff.ID) == 0 and dontBreakCC and A.ArcaneBarrage:AbsentImun(unitID, Temp.TotalAndMag) then 
			if ((Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) >= 4 or (Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) >= 3 and Player:ManaPercentage() < 40 and A.Evocation:GetCooldown() > 10)) or not A.ArcaneBlast:IsReady(unitID)) then
				return A.ArcaneBarrage:Show(icon)
			end
		end
		
		if A.ArcaneMissiles:IsReady(unitID) and not isMoving and (Unit(player):HasBuffs(A.MissileBarrageBuff.ID) > 0 or not A.MissileBarrage:IsTalentLearned() or not A.ArcaneBarrage:IsReady(unitID)) and dontBreakCC and A.ArcaneMissiles:AbsentImun(unitID, Temp.TotalAndMag) then
			if ((Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) >= 4 or (Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) >= 3 and Player:ManaPercentage() < 40 and A.Evocation:GetCooldown() > 10)) or not A.ArcaneBlast:IsReady(unitID)) then
				return A.ArcaneMissiles:Show(icon)
			end
		end

		if A.ArcaneBlast:IsReady(unitID) and not isMoving and Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) < 4 and A.ArcaneEmpowerment:IsTalentLearned() and dontBreakCC and A.ArcaneBlast:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.ArcaneBlast:Show(icon)
		end
		
		if A.Frostbolt:IsReady(unitID) and not isMoving and dontBreakCC and A.Frostbolt:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.Frostbolt:Show(icon)
		end

		if A.Fireball:IsReady(unitID) and not isMoving and dontBreakCC and A.Fireball:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.Fireball:Show(icon)
		end		
		
		if A.FireBlast:IsReady(unitID) and dontBreakCC and A.FireBlast:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.FireBlast:Show(icon)
		end		

		if A.IceLance:IsReady(unitID) and dontBreakCC and A.IceLance:AbsentImun(unitID, Temp.TotalAndMag) then
			return A.IceLance:Show(icon)
		end

    end

	if A.IsUnitEnemy(target) then 
		unitID = target 
		if EnemyRotation(unitID) then 
			return true 
		end 
	end
        
end
-- Finished

--[[A[4] = function(icon, unitID)
	
	local InterruptRotation = A.GetToggle(2, "InterruptRotation")
	if InterruptRotation == "Focus" then unitID = focus end
	if InterruptRotation == "Target" then unitID = target end
	local dontBreakCC = (Unit(unitID):HasDeBuffs("BreakAble") == 0 and StopAtBreakAble) or not StopAtBreakAble	

	local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, nil, nil, true)   
	if useCC and A.DeepFreeze:GetCooldown() < A.GetGCD() and A.DeepFreeze:AbsentImun(unitID, Temp.TotalAndMag) and dontBreakCC and (Unit(player):HasBuffs(A.FingersofFrost.ID) > 0 or Unit(unitID):HasDeBuffs(A.FrostNova.ID) > 0 or Unit(unitID):HasDeBuffs(33395) > 0) then --33395 is freeze from pet
		return A.DeepFreeze:Show(icon)
	end	

	if useKick and A.Counterspell:IsReady(unitID) and not notInterruptable and A.Counterspell:AbsentImun(unitID, Temp.TotalAndMagKick) then
		return A.Counterspell:Show(icon)
	end	
   
	if useCC and A.DragonsBreath:IsReady(unitID) and A.DragonsBreath:AbsentImun(unitID, Temp.TotalAndMag) and Unit(unitID):GetRange() <= 10 and dontBreakCC then
		return A.DragonsBreath:Show(icon)
	end	
	
	if A.Polymorph:IsReady(unitID) and A.Polymorph:AbsentImun(unitID, Temp.DisableMag) and Unit(unitID):HasDeBuffs(A.DeepFreeze.ID) > 0 and Unit(unitID):HasDeBuffs(A.DeepFreeze.ID) < A.Polymorph:GetSpellCastTime() + 1 and Unit(unitID):IsControlAble("incapacitate", 99) then
		return A.Polymorph:Show(icon)
	end
	
	if A.IsUnitEnemy(unitID) then
		return
	end
	
end]]

A[5] = function(icon)
	
	if A.Zone == "arena" then
		if A.GetToggle(1, "AutoTarget") and not Unit(target):IsExists() then
			return A:Show(icon, ACTION_CONST_AUTOTARGET)
		end
	end

end

local PassiveUnitID = {
    raid = {
        [1] = "raid1",
        [2] = "raid2",
        [3] = "raid3",
    },
    party = {
        [1] = "party1",
        [2] = "party2",
        [3] = "party3",
    },
    arena = {
        [1] = "arena1",
        [2] = "arena2",
        [3] = "arena3",
    },
}

local function ArenaRotation(icon)

    local n = icon.ID and icon.ID - 5
    if n then  
        local unitIDe
		local unitIDf
        if TeamCacheEnemy.Type and A.Zone == "pvp" then 
            unitIDe = PassiveUnitID[TeamCacheEnemy.Type][n]
        end 
        
        if TeamCacheFriendly.Type then 
            unitIDf = PassiveUnitID[TeamCacheFriendly.Type][n]
        end 

		if unitIDe and Unit(unitIDe):IsExists() and A.IsInPvP and not Player:IsStealthed() and not Player:IsMounted() and not Unit(unitIDe):InLOS() then     
			
			--[[Add kick on heal spell ?if team bursting
			local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitIDe, nil, nil, true) 
			local AutoInterrupt = A.GetToggle(2, "AutoInterrupt")			
			if useKick and A.Counterspell:IsReady(unitIDe) and not notInterruptable and AutoInterrupt and A.Counterspell:AbsentImun(unitIDe, Temp.TotalAndMagKick) then
				return A.Counterspell:Show(icon)
			end]]

			--Spellsteal
			if A.Spellsteal:IsReady(unitIDe, true) then 
				if AuraIsValid(unitIDe, "UseDispel", "PurgeHigh") and A.Spellsteal:AbsentImun(unitIDe, Temp.TotalAndMag) then 
					return A.Spellsteal:Show(icon)
				end 
			end 	
		end
		
		if unitIDf and Unit(unitIDf):IsExists() and A.IsInPvP and not Player:IsStealthed() and not Player:IsMounted() and not Unit(unitIDf):InLOS() then
		
			if A.RemoveCurse:IsReady(unitIDf, nil, nil, true) and AuraIsValid(unitIDf, "UseDispel", "Curse") then 
                return A.RemoveCurse:Show(icon)
            end 			
		
		end
		
	end
end

A[6] = function(icon)

	return ArenaRotation(icon)
end

--AntiFake CC Focus
A[7] = function(icon)
	
	if A.PolymorphGreen:IsReady(focus) and Unit(focus):IsControlAble("incapacitate", 99) and Unit(focus):InCC() == 0 and A.Polymorph:AbsentImun(focus, Temp.DisableMag) then
		return A.PolymorphGreen:Show(icon)
	end


	return ArenaRotation(icon)
end

--AntiFake Interrupt Focus
A[8] = function(icon)

	local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(focus, nil, nil, true)   
	if useKick and A.CounterspellGreen:IsReady(focus) and castRemainsTime > A.GetLatency() and A.Counterspell:AbsentImun(focus, Temp.TotalAndMagKick) then
		return A.CounterspellGreen:Show(icon)
	end	 

	return ArenaRotation(icon)
end
