return {
	cortitan = {
		acceleration = 0.2,
		blocking = false,
		brakerate = 0.0725,
		buildcostenergy = 7200,
		buildcostmetal = 340,
		buildpic = "CORTITAN.DDS",
		buildtime = 14722,
		canfly = true,
		canmove = true,
		category = "ALL NOTLAND MOBILE WEAPON VTOL NOTSUB NOTSHIP NOTHOVER",
		collide = true,
		cruisealt = 120,
		description = "Torpedo Bomber",
		energymake = 1.5,
		energyuse = 1.5,
		explodeas = "mediumexplosiongeneric",
		footprintx = 3,
		footprintz = 3,
		icontype = "air",
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 1760,
		maxslope = 10,
		maxvelocity = 10.58,
		maxwaterdepth = 0,
		name = "Titan",
		nochasecategory = "VTOL",
		objectname = "CORTITAN",
		seismicsignature = 0,
		selfdestructas = "mediumExplosionGenericSelfd",
		sightdistance = 455,
		turnrate = 600,
		customparams = {
			model_author = "Mr Bob",
			subfolder = "coreaircraft/t2",
			techlevel = 2,
			wingsurface = 0.4,
		},
		sfxtypes = {
			crashexplosiongenerators = {
				[1] = "crashing-small",
				[2] = "crashing-small",
				[3] = "crashing-small2",
				[4] = "crashing-small3",
				[5] = "crashing-small3",
			},
			pieceexplosiongenerators = {
				[1] = "deathceg3",
				[2] = "deathceg4",
				[3] = "deathceg2",
			},
		},
		sounds = {
			canceldestruct = "cancel2",
			underattack = "warning1",
			cant = {
				[1] = "cantdo4",
			},
			count = {
				[1] = "count6",
				[2] = "count5",
				[3] = "count4",
				[4] = "count3",
				[5] = "count2",
				[6] = "count1",
			},
			ok = {
				[1] = "vtolcrmv",
			},
			select = {
				[1] = "vtolcrac",
			},
		},
		weapondefs = {
			armair_torpedo = {
				areaofeffect = 16,
				avoidfeature = false,
				avoidfriendly = false,
				burnblow = true,
				collidefriendly = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:genericshellexplosion-large-uw",
				flighttime = 3,
				impulseboost = 0.123,
				impulsefactor = 0.123,
				model = "torpedo",
				name = "Torpedo launcher",
				noselfdamage = true,
				range = 650,
				reloadtime = 8,
				soundhit = "xplodep2",
				soundstart = "bombrel",
				startvelocity = 0,
				tolerance = 2000,
				tracks = true,
				turnrate = 192000,
				turret = false,
				waterweapon = true,
				weaponacceleration = 35,
				weapontimer = 5,
				weapontype = "TorpedoLauncher",
				weaponvelocity = 200,
				customparams = {
					bar_model = "cortorpedo.s3o",
				},
				damage = {
					default = 1500,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "NOTSHIP",
				def = "ARMAIR_TORPEDO",
				onlytargetcategory = "NOTHOVER",
			},
		},
	},
}
