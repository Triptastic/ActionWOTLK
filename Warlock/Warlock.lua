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
	ImmolationAura									= Create({ Type = "Spell", ID = 50589, useMaxRank = true        }),	
	ShadowCleave									= Create({ Type = "Spell", ID = 50581, useMaxRank = true        }),		
	Shadowflame									= Create({ Type = "Spell", ID = 47897, useMaxRank = true        }),		

	CreateFirestoneLesser                    = Create({ Type = "Spell", ID = 6366		}),
    CreateFirestone                            = Create({ Type = "Spell", ID = 17951	}),
    CreateFirestoneGreater                    = Create({ Type = "Spell", ID = 17952		}),
    CreateFirestoneMajor                    = Create({ Type = "Spell", ID = 17953		}),
    CreateHealthstoneMinor                    = Create({ Type = "Spell", ID = 6201		}),
    CreateHealthstoneLesser                    = Create({ Type = "Spell", ID = 6202		}),
    CreateHealthstone                        = Create({ Type = "Spell", ID = 5699		}),
    CreateHealthstoneGreater                = Create({ Type = "Spell", ID = 11729		}),
    CreateHealthstoneMajor                    = Create({ Type = "Spell", ID = 11730		}),
    CreateSoulstoneMinor                    = Create({ Type = "Spell", ID = 693			}),
    CreateSoulstoneLesser                    = Create({ Type = "Spell", ID = 20752		}),
    CreateSoulstone                            = Create({ Type = "Spell", ID = 20755	}),
    CreateSoulstoneGreater                    = Create({ Type = "Spell", ID = 20756		}),
    CreateSoulstoneMajor                    = Create({ Type = "Spell", ID = 20757		}),
    CreateSpellstone                        = Create({ Type = "Spell", ID = 2362		}),
    CreateSpellstoneGreater                    = Create({ Type = "Spell", ID = 17727	}),
    CreateSpellstoneMajor                    = Create({ Type = "Spell", ID = 17728		}),
    -- Potions
    MajorManaPotion                            = Create({ Type = "Potion", ID = 13444	}),
    -- Hidden Items    
    -- Note: Healthstone items created in Core.lua
    MajorFirestone                            = Create({ Type = "Item",  ID = 13701,     Hidden = true	}),
    GreaterFirestone                        = Create({ Type = "Item",  ID = 13700,     Hidden = true	}),
    Firestone                                = Create({ Type = "Item",  ID = 13699,     Hidden = true	}),
    LesserFirestone                            = Create({ Type = "Item",  ID = 1254,     Hidden = true	}),
    MajorSoulstone                            = Create({ Type = "Item",  ID = 16896,     Hidden = true	}),
    GreaterSoulstone                        = Create({ Type = "Item",  ID = 16895,     Hidden = true	}),
    Soulstone                                = Create({ Type = "Item",  ID = 16893,     Hidden = true	}),
    LesserSoulstone                            = Create({ Type = "Item",  ID = 16892,     Hidden = true	}),
    MinorSoulstone                            = Create({ Type = "Item",  ID = 5232,     Hidden = true	}),
    MajorSpellstone                            = Create({ Type = "Item",  ID = 13603,     Hidden = true	}),
    GreaterSpellstone                        = Create({ Type = "Item",  ID = 13602,     Hidden = true	}),
    Spellstone                                = Create({ Type = "Item",  ID = 5522,     Hidden = true	}),
    SoulShard                                = Create({ Type = "Item",  ID = 6265,     Hidden = true	}),
    InfernalStone                            = Create({ Type = "Item",  ID = 5565,     Hidden = true	}),

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
	
    --Misc
    Heroism										= Create({ Type = "Spell", ID = 32182        }),
    Bloodlust									= Create({ Type = "Spell", ID = 2825        }),
    Drums										= Create({ Type = "Spell", ID = 29529        }),
    SuperHealingPotion							= Create({ Type = "Potion", ID = 22829, QueueForbidden = true }),  
}

local A                                     = setmetatable(Action[Action.PlayerClass], { __index = Action })
Player:AddBag("SOUL_SHARD",     { itemID = A.SoulShard.ID                                                                                                                                                                        })
-- All items going from highest (1) to lowest rank 
Player:AddBag("FIRESTONE_1",     { itemID = A.MajorFirestone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("FIRESTONE_2",     { itemID = A.GreaterFirestone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("FIRESTONE_3",     { itemID = A.Firestone.ID,             itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("FIRESTONE_4",     { itemID = A.LesserFirestone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("SPELLSTONE_1",     { itemID = A.MajorSpellstone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("SPELLSTONE_2",     { itemID = A.GreaterSpellstone.ID,     itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("SPELLSTONE_3",     { itemID = A.Spellstone.ID,         itemClassID = LE_ITEM_CLASS_ARMOR, itemSubClassID = LE_ITEM_ARMOR_GENERIC, isEquippableItem = true                                                         })
Player:AddBag("SOULSTONE_1",     { itemID = A.MajorSoulstone.ID                                                                                                                                                                    })
Player:AddBag("SOULSTONE_2",     { itemID = A.GreaterSoulstone.ID                                                                                                                                                                })
Player:AddBag("SOULSTONE_3",     { itemID = A.Soulstone.ID                                                                                                                                                                        })
Player:AddBag("SOULSTONE_4",     { itemID = A.LesserSoulstone.ID                                                                                                                                                                })
Player:AddBag("SOULSTONE_5",     { itemID = A.MinorSoulstone.ID                                                                                                                                                                    })
Player:AddInv("WL_OFF_HAND",     CONST.INVSLOT_OFFHAND, {                                                                                                                                                                     })
Pet:AddActionsSpells(A.PlayerClass, { A.Torment, A.LashofPain, A.SpellLock, A.DispelMagic, A.DevourMagic, A.FireShield, A.Seduction, }) --Need to add A.ShadowBite, A.Cleave when lib updated for WOTLK
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

	local CurseofAgonyDebuff = Unit(unitID):HasDeBuffs(980 or 1014 or 6217 or 11711 or 11712 or 11713 or 27218 or 47863 or 47864) > 0
	local CurseoftheElementsDebuff = Unit(unitID):HasDeBuffs(1490 or 11721 or 11722 or 27228 or 47865) > 0
	local CurseofTonguesDebuff = Unit(unitID):HasDeBuffs(1714 or 11719) > 0
	local CurseofWeaknessDebuff = Unit(unitID):HasDeBuffs(702 or 1108 or 6205 or 7646 or 11707 or 11708 or 27224 or 30909 or 50511) > 0 
	local CurseofDoomDebuff = Unit(unitID):HasDeBuffs(603 or 30910 or 47867) > 0
	local CurseofExhaustionDebuff = Unit(unitID):HasDeBuffs(A.CurseofExhaustion) > 0	

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

	local NoArmor = Unit(player):HasBuffs(28176 or 28189 or 687 or 696 or 706 or 1086 or 11733 or 11734 or 11735 or 27260 or 47892 or 47893) == 0

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
    
    --[[if not Player:IsStealthed() then  
        local Healthstone = GetToggle(2, "HSHealth") 
        if Healthstone >= 0 then 
            local HealthStoneObject = DetermineUsableObject(player, true, nil, true, nil, A.HSGreater3, A.HSGreater2, A.HSGreater1, A.HS3, A.HS2, A.HS1, A.HSLesser3, A.HSLesser2, A.HSLesser1, A.HSMajor3, A.HSMajor2, A.HSMajor1, A.HSMinor3, A.HSMinor2, A.HSMinor1, A.HSMaster1, A.HSMaster2, A.HSMaster3)
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
    end ]]
    
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

	end
    
    --###############
    --##### OOC #####
    --###############    

	local PetChoice = A.GetToggle(2, "PetChoice")
	if not Unit(pet):IsExists() then
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
    
		local CorruptionActive = Unit(unitID):HasDeBuffs(172 or 6222 or 6223 or 7648 or 11671 or 11672 or 25311 or 27216 or 47812 or 47813, true) > 0
		local ImmolateDown = Unit(unitID):HasDeBuffs(348 or 707 or 1094 or 2941 or 11665 or 11667 or 11668 or 25309 or 27215 or 47810, true) <= A.Immolate:GetSpellCastTime()
		local UARefresh = Player:GetDeBuffsUnitCount(30108 and 30404 and 30405 and 47841 and 47843) < 1 
    
		local LifeTapMana = A.GetToggle(2, "LifeTapMana")
		local LifeTapHP = A.GetToggle(2, "LifeTapHP")		
		
		if A.LifeTap:IsReady(player) and Player:ManaPercentage() <= LifeTapMana and Unit(player):HealthPercent() >= LifeTapHP then
			return A.LifeTap:Show(icon)
		end
		
		
		--AFFLICTION
		if SpecSelect == "Affliction" and InRange then
			if A.Shadowflame:IsReady(unitID) and UseAoE and MultiUnits:GetByRange(15, 4) >= 3 then
				return A.Shadowflame:Show(icon)
			end	

			if Pet:GetInRange(A.LashofPain.ID, 5) >= 3  or Pet:GetInRange(A.Torment.ID, 5) >= 3 or Pet:GetInRange(A.ShadowBite.ID, 5) >= 3 then
				if A.SeedofCorruption:IsReady(unitID) and UseAoE and canCast and not isMoving then
					return A.SeedofCorruption:Show(icon)
				end
			end		
		
			if A.ShadowBolt:IsReady(unitID) and A.ImprovedShadowBolt:IsTalentLearned() and not isMoving and canCast then 
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
		if SpecSelect == "Demonology" then

			if A.Metamorphosis:IsReady(player) and BurstIsON(unitID) then
				if (UseAoE and MultiUnits:GetByRange(15, 4) >= 3) or (Unit(unitID):TimeToDie() > 30 or Unit(unitID):IsBoss()) then 
					return A.Metamorphosis:Show(icon)
				end
			end
			
			if A.DemonicEmpowerment:IsReadyByPassCastGCD(player) then --and Pet:IsInRange(A.Cleave.ID, unitID) once Cleave is added to PetLib. 
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

			if A.ShadowBolt:IsReady(unitID) and A.ImprovedShadowBolt:IsTalentLearned() and not isMoving and canCast then 
				if Unit(unitID):HasDeBuffs(A.ShadowMastery.ID) < A.ShadowBolt:GetSpellCastTime() and not A.ShadowBolt:IsSpellInFlight() then
					return A.ShadowBolt:Show(icon)
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

			if A.Immolate:IsReady(unitID) and ImmolateDown and canCast and Unit(unitID):TimeToDie() >= 10 and not isMoving then
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
		
		--BEAR
		if SpecSelect == "Destruction" then


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
