--#############################
--##### TRIP'S WARLOCK UI #####
--#############################

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
    DateTime = "v0.01 (20 August 2022)",
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
            },
			{
				{ -- RECOVERY POTION CONTROLLER
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Healing Potion", value = "HealingPotion" },
						{ text = "Haste Potion", value = "HastePotion" },						
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
            { -- WARLOCK HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== WARLOCK ====== ",
                    },
                },
            },
			{
				{ -- Spec
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Affliction", value = "Affliction" },
						{ text = "Demonology", value = "Demonology" },
						{ text = "Destruction", value = "Destruction" },					
                    },
                    DB = "SpecSelect",
                    DBV = "Affliction",
                    L = { 
                        ANY = "Specialisation",
                    }, 
                    TT = { 
                        ANY = "Pick your specialisation!", 
                    }, 
                    M = {},
                },
				{ -- Pet
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Imp", value = "Imp" },
						{ text = "Voidwalker", value = "Voidwalker" },
						{ text = "Succubus", value = "Succubus" },
						{ text = "Incubus", value = "Incubus" },
						{ text = "Felhunter", value = "Felhunter" },
						{ text = "Felguard", value = "Felguard" },						
                    },
                    DB = "PetChoice",
                    DBV = "Felhunter",
                    L = { 
                        ANY = "Summon Pet",
                    }, 
                    TT = { 
                        ANY = "Pick your pet!", 
                    }, 
                    M = {},
                },					
			},
			{
                { -- LifeTap
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LifeTapMana",
                    DBV = 50,
                    ONOFF = true,
                    L = { 
                        ANY = "Life Tap Mana (%)",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Life Tap.", 
                    },                     
                    M = {},
                },
                { -- LifeTap
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LifeTapHP",
                    DBV = 50,
                    ONOFF = true,
                    L = { 
                        ANY = "Life Tap Health (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to stop using Life Tap.", 
                    },                     
                    M = {},
                },				
			},
			{
				{ -- Curse
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Agony", value = "Agony" },
						{ text = "Elements", value = "Elements" },
						{ text = "Tongues", value = "Tongues" },
						{ text = "Weakness", value = "Weakness" },	
						{ text = "Doom", value = "Doom" },						
						{ text = "Exhaustion", value = "Exhaustion" },							
                    },
                    DB = "CurseChoice",
                    DBV = "Elements",
                    L = { 
                        ANY = "Curse Choice",
                    }, 
                    TT = { 
                        ANY = "Pick your curse!", 
                    }, 
                    M = {},
                },					
			},			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },			
			{ -- AFFLICTION HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== AFFLICTION ====== ",
                    },
                },
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{ -- DEMONOLOGY HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DEMONOLOGY ====== ",
                    },
                },
            },
			{ -- DESTRUCTION HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== DESTRUCTION ====== ",
                    },
                },
            },			
		},
}