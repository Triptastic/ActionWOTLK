--############################
--##### TRIP'S PRIEST UI #####
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
                { -- DesperatePrayer
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DesperatePrayerHP",
                    DBV = 35,
                    ONOFF = true,
                    L = { 
                        ANY = "Desperate Prayer HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Desperate Prayer.", 
                    },                     
                    M = {},
                },
                { -- Dispersion
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DispersionHP",
                    DBV = 20,
                    ONOFF = true,
                    L = { 
                        ANY = "Dispersion HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Dispersion.", 
                    },                     
                    M = {},
                },				
			},
			{
                { -- ShadowfiendMana
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ShadowfiendMana",
                    DBV = 60,
                    ONOFF = true,
                    L = { 
                        ANY = "Mana (%) for Shadowfiend.",
                    },
                    TT = { 
                        ANY = "Mana (%) to use Shadowfiend.", 
                    },                     
                    M = {},
                },							
			},				
            { -- PRIEST HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== PRIEST ====== ",
                    },
                },
            },			
            { -- PRIEST OPTIONS FIRST ROW
				{ -- SWDMoving
                    E = "Checkbox", 
                    DB = "SWDMoving",
                    DBV = true,
                    L = { 
                        ANY = "Shadow Word: Death with movement",
                    }, 
                    TT = { 
                        ANY = "Use Shadow Word: Death whenever moving to keep damage uptime.",
                    }, 
                    M = {},
                },	
				{ -- SWDMoving
                    E = "Checkbox", 
                    DB = "DPMoving",
                    DBV = true,
                    L = { 
                        ANY = "Devouring Plague with movement",
                    }, 
                    TT = { 
                        ANY = "Use Devouring Plague whenever moving to keep damage uptime. This will overwrite your previous Devouring Plague.",
                    }, 
                    M = {},
                },					
            },			
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },		
			{ -- HOLY HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== HOLY/DISCIPLINE ====== ",
                    },
                },
            },
			{
                {
                    E = "Label",
                    L = {
                        ANY = "Keep the sliders below on AUTO to use the experimental healing method. Theoretically, this should be much more efficient and accurate healing than standard HP percent calculations. Divine Hymn should be cast manually.",
                    },
                },
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{
				{ -- HealingStyle
                    E = "Dropdown",                                                         
                    OT = {
						{ text = "Target", value = "Target" },
						{ text = "Focus", value = "Focus" },					
                    },
                    DB = "HealingStyle",
                    DBV = "Target",
                    L = { 
                        ANY = "Healing Rotation Style: Target or Focus",
                    }, 
                    TT = { 
                        ANY = "Pick how you would like to use the healing rotation style, whether you want to automatically change your target or automatically change your focus. If you set this to focus, it is important that you change all of your heal abilities to '/cast [@focus] SpellName'. You must also change all of your Target Member macros to /focus instead of /target. You may need an updated HealingEngine.lua from Trip to get this to work (message in Discord).", 
                    }, 
                    M = {},
                },
                { -- DPSHEAL
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "DPSHEAL",
                    DBV = 0,
                    ONLYOFF = true,
                    L = { 
                        ANY = "DPS while healing mana (%)",
                    },
                    TT = { 
                        ANY = "Mana (%) to keep DPSing while healing. Keep at 100 to never DPS while in a party. Can only be used with Focus healing style.", 
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
                        ANY = "Cleanse",
                    }, 
                    TT = { 
                        ANY = "Automatically cleanse (careful when using this, might be very fast on cleansing).",
                    }, 
                    M = {},
                },
                { -- Global Heal Modifier
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 2, 
					Precision = 1,
                    DB = "globalhealmod",
                    DBV = 0.8,
                    ONOFF = false,
                    L = { 
                        ANY = "Global Heal Modifier",
                    },
                    TT = { 
                        ANY = "Multiplies the healing calculations by this amount (if healing sliders are set to AUTO). A lower number means that your heals will be cast sooner. Not recommended to have this higher than 1. Default is 0.8.", 
                    },                     
                    M = {},
                },				
            },
			{
				{ -- BlanketRenew
                    E = "Checkbox", 
                    DB = "BlanketRenew",
                    DBV = false,
                    L = { 
                        ANY = "Blanket Renew",
                    }, 
                    TT = { 
                        ANY = "Spread blanket Renew whenever any ally is slightly hurt (usually for raid only).",
                    }, 
                    M = {},
                },
                { -- RenewHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RenewHP",
                    DBV = 0,
                    ONOFF = true,
                    L = { 
                        ANY = "Renew HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Renew. Leave this slider at 0 (and turn off blanket option) if you only want to Renew the tank. Block from Action menu if you want to turn Renew off completely.", 
                    },                     
                    M = {},
                },				
            },			
			{
                { -- GreaterHealHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "GreaterHealHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Greater Heal HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Greater Heal.", 
                    },                     
                    M = {},
                },
                { -- FlashHealHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "FlashHealHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Flash Heal HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Flash Heal.", 
                    },                     
                    M = {},
                },
                { -- BindingHealHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "BindingHealHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Binding Heal HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Binding Heal. Will also check your own HP at 75% of value.", 
                    },                     
                    M = {},
                },					
			},
			{
                { -- CircleofHealing
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "CircleofHealingHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Circle of Healing HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Circle of Healing.", 
                    },                     
                    M = {},
                },			
                { -- PrayerofHealing
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PrayerofHealingHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Prayer of Healing HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Prayer of Healing.", 
                    },                     
                    M = {},
                },	
                { -- PrayerofHealingUnits
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 5,                            
                    DB = "PrayerofHealingUnits",
                    DBV = 4,
                    ONOFF = false,
                    L = { 
                        ANY = "Prayer of Healing Targets",
                    },
                    TT = { 
                        ANY = "Number of targets to use Prayer of Healing.", 
                    },                     
                    M = {},
                },
			},	
			{
                { -- LesserHeal
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LesserHealHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Lesser Heal HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Lesser Heal.", 
                    },                     
                    M = {},
                },			
                { -- PenanceHP
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PenanceHP",
                    DBV = 100,
                    ONOFF = true,
                    L = { 
                        ANY = "Penance HP (%)",
                    },
                    TT = { 
                        ANY = "HP (%) to use Penance.", 
                    },                     
                    M = {},
                },
				{ -- BlanketPWS
                    E = "Checkbox", 
                    DB = "BlanketPWS",
                    DBV = false,
                    L = { 
                        ANY = "Blanket Power Word: Shield",
                    }, 
                    TT = { 
                        ANY = "Spread Power Word: Shield over entire party/raid when able. Only works with Improved Power Word: Shield talent.",
                    }, 
                    M = {},
                },				
			},
			{ -- PWS HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== IMPORTANT NOTE ABOUT POWER WORD: SHIELD ====== ",
                    },
                },
            },				
			{
                {
                    E = "Label",
                    L = {
                        ANY = "Right-click the Blanket Power Word: Shield checkbox to create a macro for toggling this option on or off. When this option is turned on, you will spam Power Word: Shield whenever it's available. I highly suggest you use a macro to toggle this on and off, and ONLY TURN IT ON WHEN YOU'RE EXPECTING RAID-WIDE DAMAGE SOON (it's also probably fine to keep it on always when in a dungeon). Remember to turn it off again when the raid-wide damage is over, otherwise there's a good chance you'll OOM yourself.",
                    },
                },
			},
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },
			{ -- SHADOW HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ====== SHADOW ====== ",
                    },
                },
            },	
			{ -- MACRO LABEL
                {
                    E = "Label",
                    L = {
                        ANY = "Make sure you bind StopCast in GGL! We use StopCast to ensure that we don't waste any time channeling Mind Flay, especially when we can snipe an execute with Shadow Word: Death!",
                    },
                },
			},
			{
                {
                    E = "Label",
                    L = {
                        ANY = "Unfortunately, automatic target swapping for DoTs is too unreliable and can cause you to accidentally pull things that you shouldn't. You'll have to change targets manually to multi-dot.",
                    },
                },				
            },
			{
                { -- ShadowfiendMana
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "MindSearTargets",
                    DBV = 5,
                    ONOFF = true,
                    L = { 
                        ANY = "Mind Sear Targets",
                    },
                    TT = { 
                        ANY = "Amount of targets to replace Mind Flay with Mind Sear. Please be aware that AoE detection is difficult on ranged/petless classes.", 
                    },                     
                    M = {},
                },							
			},				
		},
}