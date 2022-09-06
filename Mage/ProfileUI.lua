--##########################
--##### TRIP'S MAGE UI #####
--##########################

local TMW											= TMW 
local CNDT											= TMW.CNDT
local Env											= CNDT.Env

local A												= Action
local GetToggle										= A.GetToggle
local InterruptIsValid								= A.InterruptIsValid

local UnitCooldown									= A.UnitCooldown
local Unit											= A.Unit 
local Player										= A.Player 
local Pet											= A.Pet
local LoC											= A.LossOfControl
local MultiUnits									= A.MultiUnits
local EnemyTeam										= A.EnemyTeam
local FriendlyTeam									= A.FriendlyTeam
local TeamCache										= A.TeamCache
local InstanceInfo									= A.InstanceInfo
local select, setmetatable							= select, setmetatable

A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI = {    
    DateTime = "v1.03 (5 September 2022)",
    -- Class settings
    [2] = {        
            { -- GENERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== GENERAL ====== ",
                    },
                },
            },            
            { -- GENERAL OPTIONS FIRST ROW
				{ -- AOE
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {},
                },
                { -- AoEEnemies
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "AoEEnemies",
                    DBV = 4,
                    ONOFF = true,
                    L = { 
                        ANY = "Enemies to use AoE",
                    },
                    TT = { 
                        ANY = "Enemies to use AoE", 
                    },                     
                    M = {},
                },					
			},
			{
                {-- MACRO LABEL
                    E = "Label",
                    L = {
                        ANY = "Blizzard (the company) made AoE detection pretty hard for ranged classes. Mage's AoE detection is based on how many targets have been in combat with the player in the past 3 seconds and are still alive. If AoE isn't being detected properly, try changing targets to tag 3+ enemies.",
                    },
                },			
            },
			{
				{ -- RECOVERY POTION CONTROLLER
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Healing Potion", value = "HealingPotion" },
						{ text = "Limited Invulnerability", value = "LimitedInvulnerabilityPotion" },
						{ text = "Living Action", value = "LivingActionPotion" },
						{ text = "Restorative", value = "RestorativePotion" },						
                    },
                    DB = "PotionController",
                    DBV = "HealingPotion",
                    L = { 
                        ANY = "Potion Usage",
                    }, 
                    TT = { 
                        ANY = "Pick what potion you would like to use. Use slider on the first page of /action to set health value.", 
                    }, 
                    M = {},
                },						
			},
			{
                { -- HealthStone
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HSHealth",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "HP (%) for HealthStone",
                    },
                    TT = { 
                        ANY = "HP (%) to use HealthStone", 
                    },                     
                    M = {},
                },							
			},						
			{
                { -- Defensives
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DefensivesHP",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Defensive Cooldown HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Defensive cooldowns.", 
                    },                     
                    M = {},
                },				
			},
            { -- MAGE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== MAGE ====== ",
                    },
                },
            },
			{
				{ -- ArmorSelect
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Mage Armor", value = "MageArmor" },
						{ text = "Molten Armor", value = "MoltenArmor" },
						{ text = "Frost Armor", value = "FrostArmor" },					
                    },
                    DB = "ArmorSelect",
                    DBV = "MageArmor",
                    L = { 
                        ANY = "Magic Armor",
                    }, 
                    TT = { 
                        ANY = "Choose your armor type.", 
                    }, 
                    M = {},
                },
			},
			{
                { -- ManaGem
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ManaGem",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Mana Gem Mana (%)",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Mana Gem", 
                    },                     
                    M = {},
                },
                { -- EvocationMana
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EvocationMana",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Evocation Mana (%)",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Evocation. Will wait until burned all stacks of Arcane Blast.", 
                    },                     
                    M = {},
                },				
			},			
		},
}