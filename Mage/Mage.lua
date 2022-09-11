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
	Counterspell			= Create({ Type = "Spell", ID = 2139, useMaxRank = true        }),
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
	Frostbolt				= Create({ Type = "Spell", ID = 116, useMaxRank = true        }),
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
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    AuraForCC                               = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun"},    
    AuraForInterrupt                        = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "KickImun"},
    AuraForFear                             = {"TotalImun", "DamageMagicImun", "Reflect", "CCTotalImun", "FearImun"},	
	OpenerRotation							= false,	
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
}    

local BlockSpellFireWard = {
	51505, -- Lava Burst
	133, -- Fireball
	2948, -- Scorch
	33938, -- Pyroblast
	29722, -- Incinerate

}

local BlockSpellFrostWard = {
	44614, -- FrostFire Bolt
	116, -- FrostBolt	

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

local function InRange(unitID)
    -- @return boolean 
    return A.Frostbolt:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, nil, nil, true)   
	if useKick and A.Counterspell:IsReady(unitID) and not notInterruptable then
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
	if Unit(player):PowerPercent() <= ManaGem then 
		return A.ManaAgate	
	end 
end

local function WardCheck(unitID)
	
	if IsUnitEnemy(unitID) then
		local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(unitID)
		if A.FireWard:IsReady(player) then 
			for i = 1, #BlockSpellFireWard do    
				if spellId == BlockSpellFireWard[i] then        
					return A.FireWard
				end
			end
		end
		if A.FrostWard:IsReady(player) then
			for i = 1, #BlockSpellFrostWard do    
				if spellId == BlockSpellFrostWard[i] then        
					return A.FrostWard
				end
			end		
		end
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
	
	if A.Evocation:GetCooldown() <= 5 and Player:ManaPercentage() <= A.GetToggle(2, "EvocationMana") + 10 then
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
		if A.IceBlock:IsReady(player) and Unit(player):HealthPercent() <= DefensivesHP then
			return A.IceBlock:Show(icon)
		end	
	end
	
	--Will of the Forsaken
	if A.WilloftheForsaken:AutoRacial() then 
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

	if A.ArcaneIntellect:IsReady(unitID) and Unit(player):HasBuffs(A.ArcaneIntellect.ID) == 0 and Unit(player):HasBuffs(A.FelIntelligence.ID) == 0 and Unit(player):HasBuffs( A.KirusSongofVictory.ID) == 0 and Unit(player):HasBuffs(A.ArcaneBrilliance.ID) == 0 and (unitID == player or unitID == nil) then
		return A.ArcaneIntellect:Show(icon)
	end	
	
	if A.IceBarrier:IsReady(player) and Unit(player):HasBuffs(A.IceBarrier.ID) == 0 and not Player:IsMounted() then
		return A.IceBarrier:Show(icon)
	end
	
	if A.ColdSnap:IsReady(player) and ((A.SummonWaterElemental:GetCooldown() > 5 and A.IceBlock:GetCooldown() > 5) or (Unit(player):HasDeBuffs(A.Hypothermia.ID) < 2 and A.IceBlock:GetCooldown() > 5)) then
		return A.ColdSnap:Show(icon)
	end
	
	if BlockDebuffFireWard() then
		return A.FireWard:Show(icon)
	end
	
	if BlockDebuffFrostWard() then
		return A.FrostWard:Show(icon)
	end
 
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
		
		local DoSpellsteal = SpellstealPurge(unitID)
		if DoSpellsteal then
			return DoSpellsteal:Show(icon)
		end
		
		local DoInterrupt = Interrupts(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
		end

		if A.IsInPvP then
			if A.FrostArmor:IsReady(player) and Unit(player):HasBuffs(A.FrostArmor.ID) == 0 and Unit(unitID):Class() == "Warrior" or Unit(unitID):Class() == "Rogue" or Unit(unitID):Class() == "Death Knight" or Unit(unitID):Class() == "Paladin" or Unit(unitID):HasBuffs(A.CatForm.ID) > 0 then
				return A.FrostArmor:Show(icon)
			end
			
			if A.FrostNova:IsReady(player) and MultiUnits:GetByRange(10, 3) >= 1 then
				return A.FrostNova:Show(icon)
			end
			
			--[[if A.FireWard:IsReady(player) and (Unit("arena1" or "arena2" or "arena3"):IsCasting() == A.LavaBurst:Info() or Unit("arena1" or "arena2" or "arena3"):HasBuffs(A.HotStreak.ID) > 0) then
				return A.FireWard:Show(icon)
			end]]
			
			local UseWard = WardCheck(unitID)
			local UseWardFocus = WardCheck(focus)
			if UseWard then
				return UseWard:Show(icon)
			end
			if UseWardFocus then
				return UseWard:Show(icon)
			end
			
			if A.Polymorph:IsReady(focus) and Unit(focus):IsControlAble("incapacitate", 100) and Unit(focus):GetCC(nil) == 0 then
				return A.Polymorph:Show(icon)
			end
			
		end

		local EvocationMana = A.GetToggle(2, "EvocationMana")
		if A.Evocation:IsReady(player) and inCombat and not isMoving and Player:ManaPercentage() < EvocationMana and Unit(player):HasDeBuffs(A.ArcaneBlast.ID) == 0 then
			return A.Evocation:Show(icon)
		end

		if inCombat and not canAoE and BurstIsON(unitID) then
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

		if A.DeepFreeze:IsReady(unitID) then
			return A.DeepFreeze:Show(icon)
		end
		
		if A.SummonWaterElemental:IsReady(player) and inCombat then
			return A.SummonWaterElemental:Show(icon)
		end
		
		if Unit(player):HasBuffs(A.BrainFreeze.ID) > 0 then
			if A.FrostfireBolt:IsReady(unitID) then 
				return A.FrostfireBolt:Show(icon)
			elseif A.Fireball:IsReady(unitID) then
				return A.Fireball:Show(icon)
			end
		end

		if A.Pyroblast:IsReady(unitID) and Unit(player):HasBuffs(A.HotStreak.ID, true) > 0 then
			return A.Pyroblast:Show(icon)
		end

		if A.LivingBomb:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.LivingBomb.ID, true) == 0 then
			return A.LivingBomb:Show(icon)
		end

		if A.BlastWave:IsReady(player) and UseAoE and MultiUnits:GetByRange(8, 10) >= AoEEnemies and Unit(player):HasBuffs(A.Firestarter.ID) == 0 then
			return A.BlastWave:Show(icon)
		end

		if A.Flamestrike:IsReady(player) and canAoE and ((Unit(player):HasBuffs(A.PresenceofMind.ID) > 0 and Unit(player):HasBuffs(A.ArcanePotency.ID) == 0) or Unit(player):HasBuffs(A.Firestarter.ID, true) > 0) then
			return A.Flamestrike:Show(icon)
		end

		if A.DragonsBreath:IsReady(player) and UseAoE and MultiUnits:GetByRange(10, 10) >= AoEEnemies and Unit(player):HasBuffs(A.Firestarter.ID) == 0 then
			return A.DragonsBreath:Show(icon)
		end

		if A.ConeofCold:IsReady(player) and UseAoE and MultiUnits:GetByRange(10, 10) >= 1 then
			return A.ConeofCold:Show(icon)
		end

		if A.Blizzard:IsReady(player) and not isMoving and canAoE then
			if A.PresenceofMind:IsReady(player) then
				return A.PresenceofMind:Show(icon)
			end
			return A.Blizzard:Show(icon)
		end
		
		if A.Flamestrike:IsReady(player) and canAoE and (not isMoving or Unit(player):HasBuffs(A.PresenceofMind.ID) > 0 or Unit(player):HasBuffs(A.Firestarter.ID) > 0) then
			return A.Flamestrike:Show(icon)
		end
		
		if A.ArcaneExplosion:IsReady(player) and UseAoE and MultiUnits:GetByRange(8, 10) >= AoEEnemies then
			return A.ArcaneExplosion:Show(icon)
		end

		if A.Fireball:IsReady(unitID) and A.HotStreakTalent:IsTalentLearned() and not isMoving then
			return A.Fireball:Show(icon)
		end

		if A.ArcaneBarrage:IsReady(unitID) and Unit(player):HasBuffs(A.MissileBarrageBuff.ID) == 0 then 
			if ((Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) >= 4 or (Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) >= 3 and Player:ManaPercentage() < 40 and A.Evocation:GetCooldown() > 10)) or not A.ArcaneBlast:IsReady(unitID)) then
				return A.ArcaneBarrage:Show(icon)
			end
		end
		
		if A.ArcaneMissiles:IsReady(unitID) and not isMoving and (Unit(player):HasBuffs(A.MissileBarrageBuff.ID) > 0 or not A.MissileBarrage:IsTalentLearned() or not A.ArcaneBarrage:IsReady(unitID)) then
			if ((Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) >= 4 or (Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) >= 3 and Player:ManaPercentage() < 40 and A.Evocation:GetCooldown() > 10)) or not A.ArcaneBlast:IsReady(unitID)) then
				return A.ArcaneMissiles:Show(icon)
			end
		end

		if A.ArcaneBlast:IsReady(unitID) and not isMoving and Unit(player):HasDeBuffsStacks(A.ArcaneBlast.ID, true) < 4 and A.ArcaneEmpowerment:IsTalentLearned() then
			return A.ArcaneBlast:Show(icon)
		end
		
		if A.Frostbolt:IsReady(unitID) and not isMoving then
			return A.Frostbolt:Show(icon)
		end

		if A.Fireball:IsReady(unitID) and not isMoving then
			return A.Fireball:Show(icon)
		end		
		
		if A.FireBlast:IsReady(unitID) then
			return A.FireBlast:Show(icon)
		end		

		if A.IceLance:IsReady(unitID) then
			return A.IceLance:Show(icon)
		end

    end

	if A.IsUnitEnemy("target") then 
        return EnemyRotation("target")
    end 
        
end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

local function ArenaRotation(icon, unitID)
    if A.IsInPvP and (A.Zone == "pvp" or A.Zone == "arena") and not Player:IsStealthed() and not Player:IsMounted() then     
		
		--Add kick on heal spell if team bursting
		local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, "PvP", nil, true)   
		if useKick and A.Counterspell:IsReady(unitID) and not notInterruptable then
			return A.Counterspell:Show(icon)
		end

		--Spellsteal
		if A.Spellsteal:IsReady(unitID, true) then 
			if AuraIsValid(unitID, "UseDispel", "PurgeHigh") then 
				return A.Spellsteal:Show(icon)
			end 
		end 
		
	end
end

A[6] = function(icon)

    
    return ArenaRotation(icon, "arena1")
end

A[7] = function(icon)

    
    return ArenaRotation(icon, "arena2")
end

A[8] = function(icon)

    
    return ArenaRotation(icon, "arena3")
end
