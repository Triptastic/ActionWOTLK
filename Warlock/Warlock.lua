--################################
--##### TRIP'S WOTLK WARLOCK #####
--################################

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
	Corruption									= Create({ Type = "Spell", ID = 172, useMaxRank = true        }),
	CurseofAgony								= Create({ Type = "Spell", ID = 980, useMaxRank = true        }),
	CurseofDoom									= Create({ Type = "Spell", ID = 603, useMaxRank = true        }),
	CurseofTongues								= Create({ Type = "Spell", ID = 1714, useMaxRank = true        }),
	CurseofWeakness								= Create({ Type = "Spell", ID = 702, useMaxRank = true        }),
	CurseoftheElements							= Create({ Type = "Spell", ID = 1490, useMaxRank = true        }),
	DeathCoil									= Create({ Type = "Spell", ID = 6789, useMaxRank = true        }),
	DrainLife									= Create({ Type = "Spell", ID = 689, useMaxRank = true        }),	
	DrainMana									= Create({ Type = "Spell", ID = 5138, useMaxRank = true        }),
	DrainSoul									= Create({ Type = "Spell", ID = 1120, useMaxRank = true        }),
	Fear										= Create({ Type = "Spell", ID = 5782, useMaxRank = true        }),	
	HowlofTerror								= Create({ Type = "Spell", ID = 5484, useMaxRank = true        }),
	LifeTap										= Create({ Type = "Spell", ID = 1454, useMaxRank = true        }),
	SeedofCorruption							= Create({ Type = "Spell", ID = 27243, useMaxRank = true        }),
	Banish										= Create({ Type = "Spell", ID = 710, useMaxRank = true        }),
	CreateFirestone								= Create({ Type = "Spell", ID = 6366, useMaxRank = true        }),
	CreateHealthstone							= Create({ Type = "Spell", ID = 6201, useMaxRank = true        }),
	CreateSoulstone								= Create({ Type = "Spell", ID = 693, useMaxRank = true        }),
	CreateSpellstone							= Create({ Type = "Spell", ID = 2362, useMaxRank = true        }),
	DemonArmor									= Create({ Type = "Spell", ID = 706, useMaxRank = true        }),
	DemonSkin									= Create({ Type = "Spell", ID = 687, useMaxRank = true        }),
	DetectInvisibility							= Create({ Type = "Spell", ID = 132, useMaxRank = true        }),
	EyeofKilrogg								= Create({ Type = "Spell", ID = 126, useMaxRank = true        }),
	FelArmor									= Create({ Type = "Spell", ID = 28176, useMaxRank = true        }),
	HealthFunnel								= Create({ Type = "Spell", ID = 755, useMaxRank = true        }),
	RitualofSouls								= Create({ Type = "Spell", ID = 29893, useMaxRank = true        }),	
	RitualofSummoning							= Create({ Type = "Spell", ID = 698, useMaxRank = true        }),
	SenseDemons									= Create({ Type = "Spell", ID = 5500, useMaxRank = true        }),
	ShadowWard									= Create({ Type = "Spell", ID = 6229, useMaxRank = true        }),	
	Soulshatter									= Create({ Type = "Spell", ID = 29858, useMaxRank = true        }),
	SubjugateDemon								= Create({ Type = "Spell", ID = 1098, useMaxRank = true        }),
	SummonFelhunter								= Create({ Type = "Spell", ID = 691, useMaxRank = true        }),
	SummonImp									= Create({ Type = "Spell", ID = 688, useMaxRank = true        }),
	SummonIncubus								= Create({ Type = "Spell", ID = 713, useMaxRank = true        }),
	SummonSuccubus								= Create({ Type = "Spell", ID = 712, useMaxRank = true        }),
	SummonVoidwalker							= Create({ Type = "Spell", ID = 697, useMaxRank = true        }),
	UnendingBreath								= Create({ Type = "Spell", ID = 5697, useMaxRank = true        }),
	Hellfire									= Create({ Type = "Spell", ID = 1949, useMaxRank = true        }),
	Immolate									= Create({ Type = "Spell", ID = 348, useMaxRank = true        }),
	Incinerate									= Create({ Type = "Spell", ID = 29722, useMaxRank = true        }),	
	RainofFire									= Create({ Type = "Spell", ID = 5740, useMaxRank = true        }),
	SearingPain									= Create({ Type = "Spell", ID = 5676, useMaxRank = true        }),
	ShadowBolt									= Create({ Type = "Spell", ID = 686, useMaxRank = true        }),
	SoulFire									= Create({ Type = "Spell", ID = 6353, useMaxRank = true        }),	
	CurseofExhaustion							= Create({ Type = "Spell", ID = 18223, useMaxRank = true        }),	
	SiphonLife									= Create({ Type = "Spell", ID = 63108, useMaxRank = true        }),
	DarkPact									= Create({ Type = "Spell", ID = 18220, useMaxRank = true        }),
	UnstableAffliction							= Create({ Type = "Spell", ID = 30108, useMaxRank = true        }),	
	Haunt										= Create({ Type = "Spell", ID = 48181, useMaxRank = true        }),
	SoulLink									= Create({ Type = "Spell", ID = 19028, useMaxRank = true        }),
	FelDomination								= Create({ Type = "Spell", ID = 18708, useMaxRank = true        }),	
	ManaFeed									= Create({ Type = "Spell", ID = 30326, useMaxRank = true        }),	
	DemonicEmpowerment							= Create({ Type = "Spell", ID = 47193, useMaxRank = true        }),	
	SummonFelguard								= Create({ Type = "Spell", ID = 30146, useMaxRank = true        }),
	Metamorphosis								= Create({ Type = "Spell", ID = 59672, useMaxRank = true        }),	
	Shadowburn									= Create({ Type = "Spell", ID = 17877, useMaxRank = true        }),
	Conflagrate									= Create({ Type = "Spell", ID = 17962, useMaxRank = true        }),	
	Shadowfury									= Create({ Type = "Spell", ID = 30283, useMaxRank = true        }),	
	ChaosBolt									= Create({ Type = "Spell", ID = 50796, useMaxRank = true        }),	
	ImmolationAura								= Create({ Type = "Spell", ID = 50589, useMaxRank = true        }),	
	ShadowCleave								= Create({ Type = "Spell", ID = 50581, useMaxRank = true        }),		
	Shadowflame									= Create({ Type = "Spell", ID = 47897, useMaxRank = true        }),		

    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444	}),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua
	SoulShard									= Create({ Type = "Item", ID = 6265      }),

	--Glyphs

	
	--Talents
	ImprovedShadowBolt							= Create({ Type = "Spell", ID = 17803      }),
	ShadowMastery								= Create({ Type = "Spell", ID = 17800      }),
	MoltenCore									= Create({ Type = "Spell", ID = 71165      }),
	Decimation									= Create({ Type = "Spell", ID = 63167      }),	
		
	--Pet Spells
	LashofPain									= Create({ Type = "Spell", ID = 7814, useMaxRank = true      }),
	Torment										= Create({ Type = "Spell", ID = 3716, useMaxRank = true      }),
	ShadowBite									= Create({ Type = "Spell", ID = 54049, useMaxRank = true      }),
	Cleave										= Create({ Type = "Spell", ID = 30213, useMaxRank = true      }),
	SpellLock									= Create({ Type = "Spell", ID = 19244, useMaxRank = true      }),
	DevourMagic									= Create({ Type = "Spell", ID = 19505, useMaxRank = true      }),
	FireShield									= Create({ Type = "Spell", ID = 2947, useMaxRank = true      }),
	Seduction									= Create({ Type = "Spell", ID = 6358, useMaxRank = true      }),	
	
    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),  
}

local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })
Player:AddBag("SOUL_SHARD",     { itemID = A.SoulShard.ID})
Pet:AddActionsSpells(A.PlayerClass, { A.Torment, A.LashofPain, A.SpellLock, A.DevourMagic, A.FireShield, A.Seduction, A.ShadowBite, A.Cleave}) --Need to add A.ShadowBite, A.Cleave when lib updated for WOTLK
Pet:AddTrackers(A.PlayerClass)

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

local function InRange(unitID)
    -- @return boolean 
    return A.ShadowBolt:IsInRange(unitID)
end 
InRange = A.MakeFunctionCachedDynamic(InRange)

local function Interrupts(unitID)
    local useKick, useCC, useRacial = A.InterruptIsValid(unitID, "TargetMouseover")   
    
   
end 
Interrupts = A.MakeFunctionCachedDynamic(Interrupts)

local function CastCurse()

	local CurseofAgonyDebuff = Unit(unitID):HasDeBuffs(A.CurseofAgony.ID) > 0
	local CurseoftheElementsDebuff = Unit(unitID):HasDeBuffs(A.CurseoftheElements.ID) > 0
	local CurseofTonguesDebuff = Unit(unitID):HasDeBuffs(A.CurseofTongues.ID) > 0
	local CurseofWeaknessDebuff = Unit(unitID):HasDeBuffs(A.CurseofWeakness.ID) > 0 
	local CurseofDoomDebuff = Unit(unitID):HasDeBuffs(A.CurseofDoom.ID) > 0
	local CurseofExhaustionDebuff = Unit(unitID):HasDeBuffs(A.CurseofExhaustion.ID) > 0	

	local CurseChoice = A.GetToggle(2, "CurseChoice")
	if CurseChoice == "Agony" then
		if A.CurseofAgony:IsReady(player) and not CurseofAgonyDebuff then
			return A.CurseofAgony
		end
	elseif CurseChoice == "Elements" then
		if A.CurseoftheElements:IsReady(player) and not CurseoftheElementsDebuff then
			return A.CurseoftheElements
		end
	elseif CurseChoice == "Tongues" then
		if A.CurseofTongues:IsReady(player) and not CurseofTonguesDebuff then
			return A.CurseofTongues
		end
	elseif CurseChoice == "Weakness" then
		if A.CurseofWeakness:IsReady(player) and not CurseofWeaknessDebuff then
			return A.CurseofWeakness
		end	
	elseif CurseChoice == "Doom" then
		if A.CurseofDoom:IsReady(player) and not CurseofAgonyDebuff then
			return A.CurseofDoom
		end	
	elseif CurseChoice == "Exhaustion" then
		if A.CurseofExhaustion:IsReady(player) and not CurseofExhaustionDebuff then
			return A.CurseofExhaustion
		end		
	end

end

local function BestArmor()

	local NoArmor = Unit(player):HasBuffs(A.DemonSkin.ID) == 0 and Unit(player):HasBuffs(A.DemonArmor.ID) == 0 and Unit(player):HasBuffs(A.FelArmor.ID) == 0

	if NoArmor then
		if A.FelArmor:IsReady(player) then
			return A.FelArmor
		elseif A.DemonSkin:IsReady(player) then
			return A.DemonSkin
		elseif A.DemonArmor:IsReady(player) then
			return A.DemonArmor
		end
	end
end

local function GetSoulShards()
    return Player:GetBag("SOUL_SHARD") and Player:GetBag("SOUL_SHARD").count or A.SoulShard:GetCount() or 0
end 
local SoulshardCount = GetSoulShards()

local function GetHealthstonesByCastName(castName, checkHighRanks)
    -- @return number
    local count     
    if checkHighRanks then 
        for _, v in ipairs(Temp.CastHealthStoneToAllHisRankItems[castName]) do 
            count = v:GetCount()
            if count > 0 then 
                return count
            end 
        end 
    else         
        for _, v in ipairs(Temp.CastHealthStoneToItems[castName]) do             
            count = v:GetCount()
            if count > 0 then 
                return count
            end 
        end 
    end
    
    return 0
end 

local function GetSoulstoneInBag()
    -- @return itemID or nil 
    for i = 1, #Temp.BagSoulstone do 
        if Player:GetBag(Temp.BagSoulstone[i]) then 
            return Player:GetBag(Temp.BagSoulstone[i]).itemID 
        end 
    end 
end 

local function CanDispel(unitID, isFriendly)
    -- @return boolean 
    -- Note: Only [3] APL
    if A.DevourMagic:IsReady(unitID, true) and Pet:IsInRange(A.DevourMagic, unitID) then 
        if isFriendly then 
            if (AuraIsValid(unitID, "UseDispel", "Magic") or AuraIsValid(unitID, "UsePurge", "PurgeFriendly")) then 
                return A.DevourMagic
            end 
        else 
            if (AuraIsValid(unitID, "UsePurge", "PurgeHigh") or AuraIsValid(unitID, "UsePurge", "PurgeLow")) then 
                return A.DevourMagic
            end 
        end 
    end 
end 

local function CanInterrupt(unitID)
    -- @return boolean 
    -- Note: Only [3] APL
	local useKick, useCC, _, notInterruptable, castRemainsTime = InterruptIsValid(unitID, nil, nil, false)
	if (useKick or useCC) and castRemainsTime >= GetLatency() then 
		if useKick and not notInterruptable and Pet:IsInRange(A.SpellLock, unitID) and A.SpellLock:IsReady(unitID, true) and A.SpellLock:AbsentImun(unitID, Temp.AuraForInterrupt) then 
			return A.SpellLock   
		end 
		
		if useCC and Unit(unitID):IsHumanoid() and castRemainsTime > A.Seduction:GetSpellCastTimeCache() + GetPing() and Pet:IsInRange(A.Seduction, unitID) and A.Seduction:IsReady(unitID, true) and A.Seduction:AbsentImun(unitID, Temp.AuraForCC) and Unit(unitID):IsControlAble("fear") then 
			return A.Seduction        
		end 
	end 
end 

local function CanFear(unitID) 
    -- @return boolean 
    -- Note: Only [3] APL
    if not A.Fear:IsSpellLastGCD() and not A.Fear:IsSpellInFlight() and A.Fear:IsLatenced() and A.Fear:IsReadyByPassCastGCD(unitID) and A.Fear:AbsentImun(unitID, Temp.AuraForFear) and not Unit(unitID):IsTotem() and Unit(unitID):IsControlAble("fear") then 
        return true 
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
    
	--Toaster AoE
	if not A.Toaster:IsPlaying("TripToast") then
		if A.IsUnitEnemy(target) and A.Shadowfury:GetCooldown() <= 2 and A.Shadowfury:IsTalentLearned() and UseAoE and inCombat and (Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3) then
			A.Toaster:Spawn("TripToast", "Shadowfury!", "Shadowfury soon, get cursor ready!", A.Shadowfury.ID)
		end
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
       if petName == "Voidwalker" and A.Sacrifice:IsReadyByPassCastGCD(player) then 
            if Unit(player):HealthPercent() > DefensivesHP and Unit(player):GetRealTimeDMG() > 0 then 
                return A.Sacrifice:Show(icon)
            end  
        end 
	end
	
    if A.DeathCoil:IsReady(unitID) and Unit(player):IsExecuted() and A.DeathCoil:AbsentImun(target, Temp.AuraForCC) then 
        return A.DeathCoil:Show(icon)
    end	       	
    
	--Will of the Forsaken
	if A.WilloftheForsaken:AutoRacial() then 
		return A.WilloftheForsaken:Show(icon)
	end 
	
    --###############
    --##### OOC #####
    --###############    

	if A.FelDomination:IsReady(player) and inCombat and not Unit(pet):IsExists() then
		return A.FelDomination:Show(icon)
	end

	local PetChoice = A.GetToggle(2, "PetChoice")
	if not Unit(pet):IsExists() and (not inCombat or Unit(player):HasBuffs(A.FelDomination.ID, true) > 0) then
		if PetChoice == "Imp" then
			if A.SummonImp:IsReady(player) then
				return A.SummonImp:Show(icon)
			end
		elseif PetChoice == "Voidwalker" then
			if A.SummonVoidwalker:IsReady(player) then
				return A.SummonVoidwalker:Show(icon)
			end
		elseif PetChoice == "Succubus" then
			if A.SummonSuccubus:IsReady(player) then
				return A.SummonSuccubus:Show(icon)
			end
		elseif PetChoice == "Incubus" then
			if A.SummonIncubus:IsReady(player) then
				return A.SummonIncubus:Show(icon)
			end	
		elseif PetChoice == "Felhunter" then
			if A.SummonFelhunter:IsReady(player) then
				return A.SummonFelhunter:Show(icon)
			end	
		elseif PetChoice == "Felguard" then
			if A.SummonSuccubus:IsReady(player) then
				return A.SummonFelguard:Show(icon)
			end
		end
	end
	
	--Warlock Armor
	local ArmorBuff = BestArmor()
	if ArmorBuff and canCast then
		return ArmorBuff:Show(icon)
	end		 

 
    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unitID)

        local npcID = select(6, Unit(unitID):InfoGUID())		
		local SpecSelect = A.GetToggle(2, "SpecSelect")
    
		local CorruptionActive = Unit(unitID):HasDeBuffs(A.Corruption.ID, true) > 0
		local ImmolateDown = Unit(unitID):HasDeBuffs(A.Immolate.ID, true) <= A.Immolate:GetSpellCastTime()
		local UARefresh = Player:GetDeBuffsUnitCount(A.UnstableAffliction.ID) < 1 
    
		local DrainLifeHP = A.GetToggle(2, "DrainLifeHP")
		if A.DrainLife:IsReady(unitID) and Unit(player):HealthPercent() <= DrainLifeHP and canCast and not isMoving then
			return A.DrainLife:Show(icon)
		end

		local LifeTapMana = A.GetToggle(2, "LifeTapMana")
		local LifeTapHP = A.GetToggle(2, "LifeTapHP")		
		if A.LifeTap:IsReady(player) and Player:ManaPercentage() <= LifeTapMana and Unit(player):HealthPercent() >= LifeTapHP then
			return A.LifeTap:Show(icon)
		end
		
		local Soulshardcap = A.GetToggle(2, "Soulshardcap")
		if A.DrainSoul:IsReady(unitID) and not Unit(unitID):IsBoss() and SoulshardCount < Soulshardcap and Unit(unitID):HealthPercent() <= 25 then
			return A.DrainSoul:Show(icon)
		end

		local DoInterrupt = CanInterrupt(unitID)
		if DoInterrupt then 
			return DoInterrupt:Show(icon)
        end

		if A.DeathCoil:IsReady(unitID) then         
			local useKick, useCC, useRacial, _, castRemainsTime = InterruptIsValid(target, nil, nil, true)
			if (useKick or useCC or useRacial) and castRemainsTime >= A.GetLatency() and A.DeathCoil:AbsentImun(target, Temp.AuraForCC) and Unit(target):IsControlAble("fear") then 
				return A.DeathCoil:Show(icon)
			end 
		end 

		local DoPurge = CanDispel(unitID, isFriendly)
		if DoPurge then 
			return DoPurge:Show(icon)
        end

		if inCombat and BurstIsON(unitID) then
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
		
		--AFFLICTION
		if InRange(unitID) and (SpecSelect == "Affliction" or (SpecSelect == "Auto" and A.Haunt:IsTalentLearned())) then
			if A.Shadowflame:IsReady(unitID) and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.Shadowflame:Show(icon)
			end	

			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3 then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end	
		
			if A.ShadowBolt:IsReady(unitID) and (A.ImprovedShadowBolt:IsTalentLearned() or not inCombat) and not isMoving and canCast then 
				if Unit(unitID):HasDeBuffs(A.ShadowMastery.ID) < A.ShadowBolt:GetSpellCastTime() and not A.ShadowBolt:IsSpellInFlight() then
					return A.ShadowBolt:Show(icon)
				end
			end
			
			if A.Corruption:IsReady(unitID) and not CorruptionActive and canCast and Unit(unitID):TimeToDie() >= 8 then
				if (A.ImprovedShadowBolt:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ImprovedShadowBolt.ID)) or not A.ImprovedShadowBolt:IsTalentLearned() then
					return A.Corruption:Show(icon)
				end
			end
			
			if A.UnstableAffliction:IsReady(unitID) and not isMoving and canCast and Unit(unitID):TimeToDie() >= 15 and UARefresh then
				return A.UnstableAffliction:Show(icon)
			end
			
			local DoCurse = CastCurse()
			if DoCurse and canCast then
				return DoCurse:Show(icon)
			end
			
			if A.Haunt:IsReady(unitID) and canCast and not isMoving then
				return A.Haunt:Show(icon)
			end
			
			if A.DrainSoul:IsReady(unitID) and Unit(unitID):HealthPercent() < 25 and not isMoving and canCast then
				return A.DrainSoul:Show(icon)
			end
			
			if A.ShadowBolt:IsReady(unitID) and not isMoving and canCast then
				return A.ShadowBolt:Show(icon)
			end

		end
		
		--DEMONOLOGY
		if InRange(unitID) and (SpecSelect == "Demonology" or (SpecSelect == "Auto" and A.SummonFelguard:IsTalentLearned())) then

			if A.Metamorphosis:IsReady(player) and BurstIsON(unitID) then
				if (UseAoE and MultiUnits:GetByRange(15, 4) >= 3) or (Unit(unitID):TimeToDie() > 30 or Unit(unitID):IsBoss()) then 
					return A.Metamorphosis:Show(icon)
				end
			end

			if A.ShadowBolt:IsReady(unitID) and (A.ImprovedShadowBolt:IsTalentLearned() or not inCombat) and not isMoving and canCast then 
				if Unit(unitID):HasDeBuffs(A.ShadowMastery.ID) < A.ShadowBolt:GetSpellCastTime() and not A.ShadowBolt:IsSpellInFlight() then
					return A.ShadowBolt:Show(icon)
				end
			end		
			
			if A.DemonicEmpowerment:IsReadyByPassCastGCD(player) and Pet:IsInRange(A.Cleave.ID, unitID) then
				return A.DemonicEmpowerment:Show(icon)
			end
			
			if A.ImmolationAura:IsReady(unitID) and Unit(player):HasBuffs(A.Metamorphosis.ID, true) > 0 and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.ImmolationAura:Show(icon)
			end
			
			if A.ShadowCleave:IsReady(unitID) and Unit(player):HasBuffs(A.Metamorphosis.ID, true) > 0 and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.ShadowCleave:Show(icon)
			end		

			if A.Shadowflame:IsReady(unitID) and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.Shadowflame:Show(icon)
			end	

			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3 then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end			

			local DoCurse = CastCurse()
			if DoCurse and canCast then
				return DoCurse:Show(icon)
			end

			if A.Corruption:IsReady(unitID) and not CorruptionActive and canCast and Unit(unitID):TimeToDie() >= 17 then
				if (A.ImprovedShadowBolt:IsTalentLearned() and Unit(unitID):HasDeBuffs(A.ImprovedShadowBolt.ID)) or not A.ImprovedShadowBolt:IsTalentLearned() then
					return A.Corruption:Show(icon)
				end
			end

			if A.Immolate:IsReady(unitID) and ImmolateDown and canCast and Unit(unitID):TimeToDie() >= 5 and not isMoving then
				return A.Immolate:Show(icon)
			end

			if A.SoulFire:IsReady(unitID) and Unit(player):HasBuffs(A.Decimation.ID) > 0 and canCast and not isMoving then
				return A.SoulFire:Show(icon)
			end
			
			if A.Incinerate:IsReady(unitID) and (Unit(player):HasBuffs(A.MoltenCore.ID) > 0 or not A.ImprovedShadowBolt:IsTalentLearned()) and not isMoving and canCast then
				return A.Incinerate:Show(icon)
			end
			
			if A.ShadowBolt:IsReady(unitID) and canCast and not isMoving then
				return A.ShadowBolt:Show(icon)
			end

		end
		
		--DESTRUCTION
		if InRange(unitID) and (SpecSelect == "Destruction" or (SpecSelect == "Auto" and A.ChaosBolt:IsTalentLearned())) then

			if A.Incinerate:IsReady(unitID) and not inCombat and canCast and not isMoving then
				return A.Incinerate:Show(icon)
			end

			local DoCurse = CastCurse()
			if DoCurse and canCast then
				return DoCurse:Show(icon)
			end
			
			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3 or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3  then
				if A.Shadowfury:IsReady(player) and UseAoE and canCast then
					return A.Shadowfury:Show(icon)
				end
			end	

			if A.Shadowflame:IsReady(unitID) and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.Shadowflame:Show(icon)
			end	
			
			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3 or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3  then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end				
			
			if A.Immolate:IsReady(unitID) and ImmolateDown and canCast and Unit(unitID):TimeToDie() >= 5 and not isMoving then
				return A.Immolate:Show(icon)
			end
			
			if A.Conflagrate:IsReady(unitID) and not ImmolateDown and canCast then
				return A.Conflagrate:Show(icon)
			end
			
			if A.ChaosBolt:IsReady(unitID) and canCast and not isMoving then
				return A.ChaosBolt:Show(icon)
			end
			
			if A.Incinerate:IsReady(unitID) and canCast and not isMoving then
				return A.Incinerate:Show(icon)
			end
			
			if A.Corruption:IsReady(unitID) and canCast and not CorruptionActive then
				return A.Corruption:Show(icon)
			end

		end
		
		--Failsafe if nothing selected
		if InRange(unitID) then
			if A.ShadowBolt:IsReady(unitID) and (A.ImprovedShadowBolt:IsTalentLearned() or not inCombat) and not isMoving and canCast then 
				if Unit(unitID):HasDeBuffs(A.ShadowMastery.ID) < A.ShadowBolt:GetSpellCastTime() and not A.ShadowBolt:IsSpellInFlight() then
					return A.ShadowBolt:Show(icon)
				end
			end	

			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 or Pet:GetInRange(A.Cleave.ID, 5) >= 3 or MultiUnits:GetByRange(15, 4) >= 3 then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end	
				
			if A.Corruption:IsReady(unitID) and canCast and not CorruptionActive then
				return A.Corruption:Show(icon)
			end
			
			if A.Immolate:IsReady(unitID) and ImmolateDown and canCast and Unit(unitID):TimeToDie() >= 5 and not isMoving then
				return A.Immolate:Show(icon)
			end	

			if A.ShadowBolt:IsReady(unitID) then
				return A.ShadowBolt:Show(icon)
			end
        end
    end
    
     
	if A.IsUnitEnemy("target") and not Unit("target"):IsDead() then 
        unitID = "target"
        
        if EnemyRotation(unitID) then 
            return true 
        end
		
    end
        
    end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil