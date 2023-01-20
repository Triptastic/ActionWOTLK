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
    DateTime = "v1.2 (31 October 2022)",
    -- Class settings
    [2] = {        
            { -- GENERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== REBIND INFO ====== ",
                    },
                },
            }, 
			{
                {
                    E = "Label",
                    L = {
                        ANY = "Rebinds occur when a pixel is broken or an ability is missing from the loader. In the list below, the first ability is the binding that you use in the game and the second ability is the binding that you use in the launcher. Ensure that they are the same.",
                    },
                },
			},			
			{
                {
                    E = "Label",
                    L = {
                        ANY = "Fan of Knives -> Distract",
                    },
                },
			},
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
                        ANY = "Fan of Knives Targets",
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
                        ANY = "Blade Flurry Targets",
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
            { -- PVE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== PvE ====== ",
                    },
                },
            },			
			--[[{
				{ -- Main Hand Poison
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Instant", value = "Instant" },	
						{ text = "Deadly", value = "Deadly" },						
						{ text = "Wound", value = "Wound" },
                        { text = "Auto", value = "Auto" },                       
						{ text = "None", value = "None" },							
                    },
                    DB = "MainHandPoison",
                    DBV = "Auto",
                    L = { 
                        ANY = "Main Hand Poison",
                    }, 
                    TT = { 
                        ANY = "Main Hand Poison", 
                    }, 
                    M = {},
                },
				{ -- Offhand Poison
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Instant", value = "Instant" },	
						{ text = "Deadly", value = "Deadly" },						
						{ text = "Wound", value = "Wound" },
                        { text = "Auto", value = "Auto" },                       
						{ text = "None", value = "None" },							
                    },
                    DB = "OffhandPoison",
                    DBV = "Auto",
                    L = { 
                        ANY = "Offhand Poison",
                    }, 
                    TT = { 
                        ANY = "Offhand Poison", 
                    }, 
                    M = {},
                },				
			}, ]]
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
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
			{
				{ -- Cold Blood
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Eviscerate", value = "Eviscerate" },
						{ text = "Envenom", value = "Envenom" },
						{ text = "Rupture", value = "Rupture" },									
                    },
                    DB = "BuffColdBlood",
                    DBV = "Envenom",
                    L = { 
                        ANY = "Cold Blood usage",
                    }, 
                    TT = { 
                        ANY = "Choose the ability to use with Cold Blood. Normally used with Rupture if Combat or Envenom if Assassination.", 
                    }, 
                    M = {},
                },
			},
            { -- ROGUE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== PvP ====== ",
                    },
                },
            },            				
		},    
}