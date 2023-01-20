--############################
--##### TRIP'S HUNTER UI #####
--############################

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
    DateTime = "v1.5 (25 October 2022)",
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
                {-- MACRO LABEL
                    E = "Label",
                    L = {
                        ANY = "AoE detection currently only works with pet thanks to limitations in WoW API. Please drag the following pet abilities that your pet knows to ANY slot on your action bar (does not need to be bound): Claw, Smack, Gore, Bite. Reload your UI after putting the ability on your action bar.",
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
                { -- MendPet
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "MendPetHP",
                    DBV = 40,
                    ONOFF = true,
                    L = { 
                        ANY = "Mend Pet HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Mend Pet.", 
                    },                     
                    M = {},
                },				
			},
			{ -- TRINKET HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== TRINKETS ====== ",
                    },
                },
            },
			{
				{ -- Trinket Type 1
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Damage", value = "Damage" },
						{ text = "Friendly", value = "Friendly" },
						{ text = "Self Defensive", value = "SelfDefensive" },
						{ text = "Mana Gain", value = "ManaGain" },						
                    },
                    DB = "TrinketType1",
                    DBV = "Damage",
                    L = { 
                        ANY = "First Trinket",
                    }, 
                    TT = { 
                        ANY = "Pick what type of trinket you have in your first/upper trinket slot (only matters for trinkets with Use effects).", 
                    }, 
                    M = {},
                },	
				{ -- Trinket Type 2
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Damage", value = "Damage" },
						{ text = "Friendly", value = "Friendly" },
						{ text = "Self Defensive", value = "SelfDefensive" },
						{ text = "Mana Gain", value = "ManaGain" },						
                    },
                    DB = "TrinketType2",
                    DBV = "Damage",
                    L = { 
                        ANY = "Second Trinket",
                    }, 
                    TT = { 
                        ANY = "Pick what type of trinket you have in your second/lower trinket slot (only matters for trinkets with Use effects).", 
                    }, 
                    M = {},
                },				
			},			
			{
                { -- TrinketValue1
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketValue1",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "First Trinket Value",
                    },
                    TT = { 
                        ANY = "HP/Mana (%) to use your first trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                    },                     
                    M = {},
                },	
                { -- TrinketValue2
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TrinketValue2",
                    DBV = 40,
                    ONOFF = false,
                    L = { 
                        ANY = "Second Trinket Value",
                    },
                    TT = { 
                        ANY = "HP/Mana (%) to use your second trinket, based on what you've chosen for your trinket type. Damage trinkets will be used on burst targets.", 
                    },                     
                    M = {},
                },					
			},				
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },				
            { -- HUNTER HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== HUNTER ====== ",
                    },
                },
            },
			{
				{ -- STING CONTROLLER
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Serpent Sting", value = "SerpentSting" },
						{ text = "Scorpid Sting", value = "ScorpidSting" },
						{ text = "Viper Sting", value = "ViperSting" },	
						{ text = "Automatic", value = "Auto" },							
						{ text = "None", value = "None" },						
                    },
                    DB = "StingController",
                    DBV = "Auto",
                    L = { 
                        ANY = "Sting Usage",
                    }, 
                    TT = { 
                        ANY = "Pick your sting to use in your rotation. Selecting Viper Sting will have it only be used if target has mana, otherwise it will use Serpent Sting.", 
                    }, 
                    M = {},
                },
			},
			{
				{ -- Static Hunter's Mark
                    E = "Checkbox", 
                    DB = "StaticMark",
                    DBV = true,
                    L = { 
                        ANY = "Static Hunter's Mark", 
                    }, 
                    TT = { 
                        ANY = "Check this box to not change your Hunter's Mark target until it expires/dies (useful if you swap targets a lot).", 
                    }, 
                    M = {},
                },
				{ -- Static Hunter's Mark
                    E = "Checkbox", 
                    DB = "BossMark",
                    DBV = false,
                    L = { 
                        ANY = "Hunter's Mark Boss Only", 
                    }, 
                    TT = { 
                        ANY = "Check this box to only use Hunter's Mark on bosses.", 
                    }, 
                    M = {},
                },				
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            }, 			
			{
				{ -- ConcussiveShotPvE
                    E = "Checkbox", 
                    DB = "ConcussiveShotPvE",
                    DBV = true,
                    L = { 
                        ANY = "Concussive Shot Aggro", 
                    }, 
                    TT = { 
                        ANY = "Use Concussive Shot to slow target if aggro swaps to you.", 
                    }, 
                    M = {},
                },		
				{ -- ArcaneMovementOnly
                    E = "Checkbox", 
                    DB = "ArcaneMovingOnly",
                    DBV = true,
                    L = { 
                        ANY = "Arcane Shot with Movement Only", 
                    }, 
                    TT = { 
                        ANY = "Only use Arcane Shot when moving.", 
                    }, 
                    M = {},
                },				
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{
				{ -- EndCombatViper
                    E = "Checkbox", 
                    DB = "EndCombatViper",
                    DBV = true,
                    L = { 
                        ANY = "End Combat With Aspect of the Viper", 
                    }, 
                    TT = { 
                        ANY = "Swap to Aspect of the Viper out of combat when less than 100% mana to ensure mana regen. Useful for regaining mana between packs of mobs.", 
                    }, 
                    M = {},
                },					
			},
			{
                { -- Mana Viper
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ManaViperStart",
                    DBV = 10, -- Set healthpercentage @30% life. 
                    ONOFF = false,
                    L = { 
                        ANY = "Viper Aspect Mana Start(%)",
                    },
                    TT = { 
                        ANY = "Value (%) to start dancing with Aspect of the Viper. Used in conjunction with the dropdown boxes next to this slider.", 
                    },                     
                    M = {},
                },				
				{
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Steady Shot", value = 1 },
						{ text = "Aimed Shot", value = 2 },
						{ text = "Arcane Shot", value = 3 },								
                    },
                    MULT = true,
                    DB = "ViperWeave",
                    DBV = {
                        [1] = true, 
                        [2] = false,
                        [3] = false,
                    }, 
                    L = { 
                        ANY = "Aspect Weave Shots (Viper)",
                    }, 
                    TT = { 
                        ANY = "Automatically use Aspect of the Viper for these shots when below the mana threshold set on the other slider.", 
                    }, 
                    M = {},
                },				
			},			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },					
		},
}