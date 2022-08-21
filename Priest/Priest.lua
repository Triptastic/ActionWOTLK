--###############################
--##### TRIP'S WOTLK PRIEST #####
--###############################

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
local HealingEngine                            = Action.HealingEngine

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
	WilloftheForsaken							= Create({ Type = "Spell", ID = 7744		}),
	ArcaneTorrent								= Create({ Type = "Spell", ID = 28730		}),	
	
	--Class Skills
	AbolishDisease								= Create({ Type = "Spell", ID = 552, useMaxRank = true        }),
	BindingHeal									= Create({ Type = "Spell", ID = 32546, useMaxRank = true        }),	
	CureDisease									= Create({ Type = "Spell", ID = 528, useMaxRank = true        }),
	DevouringPlague								= Create({ Type = "Spell", ID = 2944, useMaxRank = true        }),	
	DispelMagic									= Create({ Type = "Spell", ID = 527, useMaxRank = true        }),
	DivineHymn									= Create({ Type = "Spell", ID = 64843, useMaxRank = true        }),	
	DivineSpirit								= Create({ Type = "Spell", ID = 14752, useMaxRank = true        }),	
	Fade										= Create({ Type = "Spell", ID = 586, useMaxRank = true        }),
	FearWard									= Create({ Type = "Spell", ID = 6346, useMaxRank = true        }),
	FlashHeal									= Create({ Type = "Spell", ID = 2061, useMaxRank = true        }),	
	GreaterHeal									= Create({ Type = "Spell", ID = 2060, useMaxRank = true        }),
	Heal										= Create({ Type = "Spell", ID = 2054, useMaxRank = true        }),	
	HolyFire									= Create({ Type = "Spell", ID = 14914, useMaxRank = true        }),	
	HolyNova									= Create({ Type = "Spell", ID = 15237, useMaxRank = true        }),	
	HymnofHope									= Create({ Type = "Spell", ID = 64901, useMaxRank = true        }),
	InnerFire									= Create({ Type = "Spell", ID = 588, useMaxRank = true        }),
	LesserHeal									= Create({ Type = "Spell", ID = 2050, useMaxRank = true        }),
	Levitate									= Create({ Type = "Spell", ID = 1706, useMaxRank = true        }),
	ManaBurn									= Create({ Type = "Spell", ID = 8129, useMaxRank = true        }),
	MassDispel									= Create({ Type = "Spell", ID = 32375, useMaxRank = true        }),
	MindBlast									= Create({ Type = "Spell", ID = 8092, useMaxRank = true        }),
	MindControl									= Create({ Type = "Spell", ID = 605, useMaxRank = true        }),
	MindFlay									= Create({ Type = "Spell", ID = 15407, useMaxRank = true        }),	
	MindSear									= Create({ Type = "Spell", ID = 48045, useMaxRank = true        }),
	MindSoothe									= Create({ Type = "Spell", ID = 453, useMaxRank = true        }),	
	MindVision									= Create({ Type = "Spell", ID = 2096, useMaxRank = true        }),
	PowerWordFortitude							= Create({ Type = "Spell", ID = 1243, useMaxRank = true        }),
	PowerWordShield								= Create({ Type = "Spell", ID = 17, useMaxRank = true        }),
	PrayerofFortitude							= Create({ Type = "Spell", ID = 21562, useMaxRank = true        }),
	PrayerofHealing								= Create({ Type = "Spell", ID = 596, useMaxRank = true        }),
	PrayerofMending								= Create({ Type = "Spell", ID = 33076, useMaxRank = true        }),	
	PrayerofShadowProtection					= Create({ Type = "Spell", ID = 27683, useMaxRank = true        }),
	PrayerofSpirit								= Create({ Type = "Spell", ID = 27681, useMaxRank = true        }),
	PsychicScream								= Create({ Type = "Spell", ID = 8122, useMaxRank = true        }),
	Renew										= Create({ Type = "Spell", ID = 139, useMaxRank = true        }),
	Resurrection								= Create({ Type = "Spell", ID = 2006, useMaxRank = true        }),
	ShackleUndead								= Create({ Type = "Spell", ID = 9484, useMaxRank = true        }),	
	ShadowProtection							= Create({ Type = "Spell", ID = 976, useMaxRank = true        }),
	ShadowWordDeath								= Create({ Type = "Spell", ID = 32379, useMaxRank = true        }),	
	ShadowWordPain								= Create({ Type = "Spell", ID = 589, useMaxRank = true        }),
	Shadowfiend									= Create({ Type = "Spell", ID = 34433, useMaxRank = true        }),	
	Shadowform									= Create({ Type = "Spell", ID = 15473, useMaxRank = true        }),	
	Smite										= Create({ Type = "Spell", ID = 585, useMaxRank = true        }),
	GuardianSpirit								= Create({ Type = "Spell", ID = 47788, useMaxRank = true        }),
	InnerFocus									= Create({ Type = "Spell", ID = 14751, useMaxRank = true        }),	
	Lightwell									= Create({ Type = "Spell", ID = 724, useMaxRank = true        }),
	PainSuppression								= Create({ Type = "Spell", ID = 33206, useMaxRank = true        }),
	Penance										= Create({ Type = "Spell", ID = 47540, useMaxRank = true        }),
	PowerInfusion								= Create({ Type = "Spell", ID = 10060, useMaxRank = true        }),	
	PsychicHorror								= Create({ Type = "Spell", ID = 64044, useMaxRank = true        }),
	Silence										= Create({ Type = "Spell", ID = 15487, useMaxRank = true        }),	
	VampiricEmbrace								= Create({ Type = "Spell", ID = 15286, useMaxRank = true        }),	
	VampiricTouch								= Create({ Type = "Spell", ID = 34914, useMaxRank = true        }),	
	Dispersion									= Create({ Type = "Spell", ID = 47585, useMaxRank = true        }),	

    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444	}),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua

	--Glyphs

	
	--Talents
	ShadowWeaving								= Create({ Type = "Spell", ID = 15258, Hidden = true       }),	
    Darkness		                            = Create({ Type = "Spell", ID = 15259,    isTalent = true, useMaxRank = true,    Hidden = true }),
    TwinDisciplines	                            = Create({ Type = "Spell", ID = 47586,    isTalent = true, useMaxRank = true,    Hidden = true }),	
	
    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),  
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
	VampiricTouchDelay						= 0,
}

local ImmuneArcane = {
    [18864] = true,
    [18865] = true,
    [15691] = true,
    [20478] = true, -- Arcane Servant
}    

local function InRange(unitID)
    -- @return boolean 
    return A.ShadowWordPain:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = A.InterruptIsValid(unitID, nil, nil, true)   
    if (useKick or useCC) and castRemainsTime >= GetLatency() then
		if useCC and A.PsychicScream:IsReady(player) then
			return A.PsychicScream
		end
		
		if useKick and A.Silence:IsReady(unitID) and not notInterruptable then
			return A.Silence
		end
	end
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CanDispel(unitID, isFriendly)
    -- @return boolean 
    -- Note: Only [3] APL
    if A.DispelMagic:IsReady(unitID, true) then 
        if isFriendly then 
            if (AuraIsValid(unitID, "UseDispel", "Magic") or AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) then 
                return A.DispelMagic
            end 
        else 
            if (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
                return A.DispelMagic
            end 
        end 
    end 
end 

spellDmg = GetSpellBonusDamage(6) --Shadow bonus damage
local function SWDeathDmgCalc() --to add glyph damage once supported
	
	local TwinDisciplinesDmg = A.TwinDisciplines:GetTalentRank() * 1 / 100
	local ShadowWeavingDmg = Unit(player):HasBuffsStacks(A.ShadowWeaving.ID) * 2 / 100
	local DarknessDmg = A.Darkness:GetTalentRank() * 2 / 100
	
	if A.ShadowWordDeath:GetSpellRank() == 0 then
		return 0
	elseif A.ShadowWordDeath:GetSpellRank() == 1 then
		return (450+(0.429*spellDmg))*(1+TwinDisciplinesDmg)*(1+ShadowWeavingDmg)*(1+DarknessDmg)
	elseif A.ShadowWordDeath:GetSpellRank() == 2 then
		return (572+(0.429*spellDmg))*(1+TwinDisciplinesDmg)*(1+ShadowWeavingDmg)*(1+DarknessDmg)
	elseif A.ShadowWordDeath:GetSpellRank() == 3 then
		return (639+(0.429*spellDmg))*(1+TwinDisciplinesDmg)*(1+ShadowWeavingDmg)*(1+DarknessDmg)
	elseif A.ShadowWordDeath:GetSpellRank() == 4 then
		return (750+(0.429*spellDmg))*(1+TwinDisciplinesDmg)*(1+ShadowWeavingDmg)*(1+DarknessDmg)		
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


	if (Player:IsCasting() or Player:IsChanneling()) then
		canCast = false
	else 
		canCast = true
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
    
    --[[if UsePotions and combatTime > 2 then
        if PotionController == "HealingPotion" then
            if CanUseHealingPotion(icon) then 
                return true
            end 
        end    
    end   ]] 
    
    --[[if CanUseManaRune(icon) then
        return true
    end]]
    
    --######################
    --##### DEFENSIVES #####
    --######################	
	
	local DefensivesHP = A.GetToggle(2, "DefensivesHP")
	if inCombat then
		if A.Dispersion:IsReady(player) and Unit(player):HealthPercent() <= DefensivesHP then
			return A.Dispersion:Show(icon)
		end
	end

	--PsychicScream
	if A.IsInPvP and A.PsychicScream:IsReady(player, true) then 
		-- Enemy healer
		if A.Zone == "pvp" then 
			local enemyHealerInRange, _, enemyHealerUnitID = EnemyTeam("HEALER"):PlayersInRange(1)
			if enemyHealerInRange and not UnitIsUnit(enemyHealerUnitID, "target") and ((Unit(enemyHealerUnitID):GetRange() > 0 and Unit(enemyHealerUnitID):GetRange() <= 10) or (petIsActive and Temp.IsPetInMelee(enemyHealerUnitID) and Unit(pet):GetRange() <= 10)) and A.PsychicScream:AbsentImun(enemyHealerUnitID, Temp.AuraForFear) and Unit(enemyHealerUnitID):IsControlAble("fear") then 
				return A.PsychicScream:Show(icon)
			end 
		end 
		
		-- Enemy players 
		local namePlateUnitID
		local damagersOnPlayer = 0
		for namePlateUnitID in pairs(ActiveUnitPlates) do                 
			if Unit(namePlateUnitID):IsPlayer() and ((Unit(namePlateUnitID):GetRange() > 0 and Unit(namePlateUnitID):GetRange() <= 10) or (petIsActive and Temp.IsPetInMelee(namePlateUnitID) and Unit(pet):GetRange() <= 10)) and A.PsychicScream:AbsentImun(namePlateUnitID, Temp.AuraForFear) and Unit(namePlateUnitID):IsControlAble("fear") then 
				if UnitIsUnit(namePlateUnitID .. "target", player) and Unit(namePlateUnitID):IsDamager() then 
					damagersOnPlayer = damagersOnPlayer + 1
				end 
				
				-- Multi-fear all damager who sits on player                    
				if damagersOnPlayer >= 3 then 
					return A.PsychicScream:Show(icon)
				end 
				
				-- Fear nearest not selected in target:
				-- 1. With any burst buffs
				-- 2. With any casting spell 
				-- 3. If it's enemy healer 
				-- 4. If in unit's own target on execute phase any unit 
				if not UnitIsUnit(namePlateUnitID, "target") and (Unit(namePlateUnitID .. "target"):IsExecuted() or Unit(namePlateUnitID):IsCastingRemains() > 0 or Unit(namePlateUnitID):HasBuffs("DamageBuffs") > 2 or Unit(namePlateUnitID):IsHealer()) and (not Unit(namePlateUnitID):IsFocused() or Unit(namePlateUnitID):GetRealTimeDMG() == 0) then 
					return A.PsychicScream:Show(icon)
				end 
			end 
		end 
	end         	
    
	--Will of the Forsaken
	if A.WilloftheForsaken:AutoRacial() then 
		return A.WilloftheForsaken:Show(icon)
	end 
	
	-- EscapeArtist
	if A.EscapeArtist:AutoRacial() and not mouseoverInRange30 and not targetInRange30 then 
		return A.EscapeArtist:Show(icon)
	end 	  

	
 ------------------------------------------------------------------------------------------------

    local function EnemyRotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
    
		local SWPActive = Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID, true) > 0
		local VampiricTouchActive = Unit(unitID):HasDeBuffs(A.VampiricTouch.ID, true) >= A.VampiricTouch:GetSpellCastTime() and Temp.VampiricTouchDelay > 0
		local DevouringPlagueRefresh = Player:GetDeBuffsUnitCount(A.DevouringPlague.ID, true) < 1 
		local DoTMissing = not SWPActive or not VampiricTouchActive or DevouringPlagueRefresh

		--VampTouch DoubleCast fix
		if Temp.VampiricTouchDelay == 0 and Player:IsCasting() == A.VampiricTouch:Info() then
			Temp.VampiricTouchDelay = 90
		end
		
		if Temp.VampiricTouchDelay > 0 then
			Temp.VampiricTouchDelay = Temp.VampiricTouchDelay - 1
		end

		--BUFFS
		if A.VampiricEmbrace:IsReady(player) and Unit(player):HasBuffs(A.VampiricEmbrace.ID, true) == 0 then
			return A.VampiricEmbrace:Show(icon)
		end

		if A.InnerFire:IsReady(player) and Unit(player):HasBuffs(A.InnerFire.ID, true) == 0 then
			return A.InnerFire:Show(icon)
		end		
		
		if A.PowerWordFortitude:IsReady(player) and Unit(player):HasBuffs(A.PowerWordFortitude.ID, true) == 0 then
			return A.PowerWordFortitude:Show(icon)
		end			

		--STOPCAST
		if A.GetToggle(1, "StopCast") and Player:IsChanneling() == A.MindFlay:Info() then
			if DoTMissing and Unit(player):HasBuffsStacks(A.ShadowWeaving.ID, true) >= 5 then 
				return A:Show(icon, ACTION_CONST_STOPCAST)
			end
			
			if A.ShadowWordDeath:IsReadyByPassCastGCD(unitID) and Unit(unitID):Health() < SWDeathDmgCalc() and Unit(player):Health() > SWDeathDmgCalc() then
				return A:Show(icon, ACTION_CONST_STOPCAST)
			end				
		end

		local DoInterrupt = Interrupts(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
        end

		local DoPurge = CanDispel(unitID, isFriendly)
		if DoPurge then 
			return DoPurge:Show(icon)
        end

        if A.Fade:IsReady(player) and inCombat and not A.IsInPvP and TeamCacheFriendly.Type and (Unit(player):IsTankingAoE() or (inShadowform and combatTime < 5)) then 
            return A.Fade:Show(icon)
        end 
	
		local ShadowfiendMana = A.GetToggle(2, "ShadowfiendMana")
		if A.Shadowfiend:IsReady(unitID) and inCombat and Player:ManaPercentage() <= ShadowfiendMana then
			return A.Shadowfiend:Show(icon)
		end
	
		if A.Shadowform:IsReady(player) and Unit(player):HasBuffs(A.Shadowform.ID) == 0 then
			return A.Shadowform:Show(icon)
		end
		
		if A.ShadowWordDeath:IsReady(unitID) and Unit(unitID):Health() < SWDeathDmgCalc() and Unit(player):Health() > SWDeathDmgCalc() then
			return A.ShadowWordDeath:Show(icon)
		end
		
		--SWP only with Shadow Weavingx5
		if A.ShadowWordPain:IsReady(unitID) and not SWPActive and Unit(player):HasBuffsStacks(A.ShadowWeaving.ID, true) >= 5 then
			return A.ShadowWordPain:Show(icon)
		end
		
		if A.VampiricTouch:IsReady(unitID) and not isMoving and not VampiricTouchActive then
			return A.VampiricTouch:Show(icon)
		end
		
		if A.DevouringPlague:IsReady(unitID) and DevouringPlagueRefresh then
			return A.DevouringPlague:Show(icon)
		end
		
		if A.MindBlast:IsReady(unitID) and not isMoving then
			return A.MindBlast:Show(icon)
		end
		
		local MindSearTargets = A.GetToggle(2, "MindSearTargets")
		if A.MindSear:IsReady(unitID) and not isMoving and MultiUnits:GetActiveEnemies(36, 10) >= MindSearTargets then
			return A.MindSear:Show(icon)
		end
		
		if A.MindFlay:IsReady(unitID) and not isMoving then
			return A.MindFlay:Show(icon)
		end
		
		local SWDMoving = A.GetToggle(2, "SWDMoving")
		if A.ShadowWordDeath:IsReady(unitID) and SWDMoving and Unit(player):Health() > SWDeathDmgCalc() then
			return A.ShadowWordDeath:Show(icon)
		end
		
		local DPMoving = A.GetToggle(2, "DPMoving")		
		if A.DevouringPlague:IsReady(unitID) and DPMoving then
			return A.DevouringPlague:Show(icon)
		end		
	end
    
 --------------------------------------------------------------------------------------------------    
	local function HealingRotation(unitID) 
		
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unitID)
		local getmembersAll = HealingEngine.GetMembersAll()		
        local unitGUID = UnitGUID(unitID)    	
		local DungeonGroup = TeamCache.Friendly.Size >= 2 and TeamCache.Friendly.Size <= 5
		local RaidGroup = TeamCache.Friendly.Size >= 5 		
		
	
	end

---------------------------------------------------------------------------------------------------

    if A.IsUnitEnemy("target") then 
        return EnemyRotation("target")
    elseif A.IsUnitFriendly("target") then
        return HealingRotation("target")
    end 
        
end

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil