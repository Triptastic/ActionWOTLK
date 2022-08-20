--###########################
--##### TRIP'S DRUID UI #####
--###########################

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
    DateTime = "v0.01 (8 June 2022)",
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
                { -- Innervate
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "InnervatePercent",
                    DBV = 25,
                    ONOFF = false,
                    L = { 
                        ANY = "Mana (%) for Innervate (self only)",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Innervate (self only). Make sure that your keybinding for Innervate is a macro: /cast [@player] Innervate", 
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
                        ANY = "HP (%) to use Defensive cooldowns (Survival Instincts, Frenzied Regeneration).", 
                    },                     
                    M = {},
                },
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },			
			{ -- PVE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== SPEC/SHAPESHIFT ====== ",
                    },
                },
            },
			{
				{ -- Spec
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Balance", value = "Balance" },
						{ text = "Feral (Cat)", value = "FeralCat" },
						{ text = "Feral (Bear)", value = "FeralBear" },
						{ text = "Restoration", value = "Restoration" },						
						{ text = "Automatic", value = "Auto" },						
                    },
                    DB = "SpecSelect",
                    DBV = "Auto",
                    L = { 
                        ANY = "Specialisation",
                    }, 
                    TT = { 
                        ANY = "Pick your specialisation!", 
                    }, 
                    M = {},
                },			
				{ -- Auto Form
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Moonkin Form", value = "MoonkinForm" },
						{ text = "Cat Form", value = "CatForm" },
						{ text = "Bear Form", value = "BearForm" },	
						{ text = "None", value = "None" },						
                    },
                    DB = "AutoForm",
                    DBV = "None",
                    L = { 
                        ANY = "Shapeshift Form",
                    }, 
                    TT = { 
                        ANY = "Pick the shapeshift form for your spec!", 
                    }, 
                    M = {},
                },
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{ -- BALANCE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== BALANCE ====== ",
                    },
                },
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{ -- FERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== FERAL ====== ",
                    },
                },
            },
			{
				{ -- Opener
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Max DPS (Risky)", value = "MaxDPS" },
						{ text = "Safer", value = "Safer" },
						{ text = "None", value = "None" },						
                    },
                    DB = "CatOpener",
                    DBV = "Safer",
                    L = { 
                        ANY = "Opener Type",
                    }, 
                    TT = { 
                        ANY = "Pick your opener type! Won't work until you've learned Savage Roar.", 
                    }, 
                    M = {},
                },
			},	
			{ -- RESTO HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== RESTORATION ====== ",
                    },
                },
            },
			{
                { -- Emergency Heal
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "Emergency",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Emergency Healing Combo (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Nature's Swiftness + Healing Touch emergency combo.", 
                    },                     
                    M = {},
                },
			},	
			{
				{ -- Cleanse
                    E = "Checkbox", 
                    DB = "Cleanse",
                    DBV = true,
                    L = { 
                        ANY = "Cleanses", 
                    }, 
                    TT = { 
                        ANY = "Cleanse poisons/curses from targets (warning, delay not functioning correctly so may cleanse inhumanly fast).", 
                    }, 
                    M = {},
                },				
				{ -- BlanketRejuv
                    E = "Checkbox", 
                    DB = "BlanketRejuv",
                    DBV = true,
                    L = { 
                        ANY = "Blanket Rejuvenation", 
                    }, 
                    TT = { 
                        ANY = "Spread blanket rejuvenation whenever any ally is slightly hurt (usually for raid only).", 
                    }, 
                    M = {},
                },			
                { -- RejuvHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RejuvHP",
                    DBV = 80,
                    ONOFF = true,
                    L = { 
                        ANY = "Rejuvenation HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Rejuvenation. Only works if blanket mode is turned off (checkbox next to this).", 
                    },                     
                    M = {},
                },
			},	
			{
                { -- SwiftmendHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "SwiftmendHP",
                    DBV = 40,
                    ONOFF = true,
                    L = { 
                        ANY = "Swiftmend HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Swiftmend.", 
                    },                     
                    M = {},
                },
                { -- NourishHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "NourishHP",
                    DBV = 40,
                    ONOFF = true,
                    L = { 
                        ANY = "Nourish HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Nourish.", 
                    },                     
                    M = {},
                },
                { -- RegrowthHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RegrowthHP",
                    DBV = 50,
                    ONOFF = true,
                    L = { 
                        ANY = "Regrowth HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Regrowth.", 
                    },                     
                    M = {},
                },				
			},
			{
                { -- WildGrowthHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "WildGrowthHP",
                    DBV = 60,
                    ONOFF = true,
                    L = { 
                        ANY = "Wild Growth HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Wild Growth. Used in conjunction with the number of targets slider next to this one. ONLY WORKS IN DUNGEONS. MUST BE STANDING WITHIN 15 YARDS OF YOUR PARTY. CREATE A MACRO: /cast [@player] Wild Growth", 
                    },                     
                    M = {},
                },	
                { -- WildGrowthTargets
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 5,                            
                    DB = "WildGrowthTargets",
                    DBV = 4,
                    ONOFF = true,
                    L = { 
                        ANY = "Wild Growth Targets",
                    },
                    TT = { 
                        ANY = "Number of targets for Wild Growth to be used. Used in conjunction with the HP slider next to this one. ONLY WORKS IN DUNGEONS. MUST BE STANDING WITHIN 15 YARDS OF YOUR PARTY. CREATE A MACRO: /cast [@player] Wild Growth", 
                    },                     
                    M = {},
                },				
			},	
			{
                { -- TranqHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "TranqHP",
                    DBV = 50,
                    ONOFF = true,
                    L = { 
                        ANY = "Tranquility HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Tranquility. Used in conjunction with the number of targets slider next to this one. ONLY WORKS IN DUNGEONS.", 
                    },                     
                    M = {},
                },
                { -- TranqHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 5,                            
                    DB = "TranqTargets",
                    DBV = 4,
                    ONOFF = true,
                    L = { 
                        ANY = "Tranquility Targets",
                    },
                    TT = { 
                        ANY = "Number of targets for Tranquility to be used. Used in conjunction with the HP slider next to this one. ONLY WORKS IN DUNGEONS.", 
                    },                     
                    M = {},
                },				
			},				
		},
}