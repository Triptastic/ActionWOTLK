--##########################
--##### TRIP'S ROGUE UI #####
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
    DateTime = "v1.00 (27 August 2022)",
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
                { -- FoKEnemies
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "FoKEnemies",
                    DBV = 4,
                    ONOFF = true,
                    L = { 
                        ANY = "Enemies to use Fan of Knives",
                    },
                    TT = { 
                        ANY = "Enemies to use Fan of Knives", 
                    },                     
                    M = {},
                },	
                { -- Blade Flurry
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "BFEnemies",
                    DBV = 2,
                    ONOFF = true,
                    L = { 
                        ANY = "Enemies to use Blade Flurry",
                    },
                    TT = { 
                        ANY = "Enemies to use Blade Flurry", 
                    },                     
                    M = {},
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
                { -- EvasionHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "EvasionHP",
                    DBV = 30,
                    ONOFF = true,
                    L = { 
                        ANY = "Evasion HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Evasion.", 
                    },                     
                    M = {},
                },				
			},
            { -- MAGE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== ROGUE ====== ",
                    },
                },
            },
			{
				{ -- Poison
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
				{ -- StealthOpener
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Garrote", value = "openGarrote" },
						{ text = "Cheap Shot", value = "openCheapShot" },
						{ text = "Ambush", value = "openAmbush" },		
						{ text = "Manual", value = "openManual" },							
                    },
                    DB = "openStealth",
                    DBV = "openManual",
                    L = { 
                        ANY = "Stealth Opener",
                    }, 
                    TT = { 
                        ANY = "Choose the ability to use from Stealth. Manual will not use anything.", 
                    }, 
                    M = {},
                },
			},			
		},
}