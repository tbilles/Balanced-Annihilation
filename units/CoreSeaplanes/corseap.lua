return {
	corseap = {
		acceleration = 0.22,
		blocking = false,
		brakerate = 0.375,
		buildcostenergy = 6100,
		buildcostmetal = 240,
		buildpic = "CORSEAP.DDS",
		buildtime = 10698,
		canfly = true,
		canmove = true,
		cansubmerge = true,
		category = "ALL NOTLAND MOBILE WEAPON VTOL NOTSUB NOTSHIP NOTHOVER",
		collide = true,
		cruisealt = 100,
		description = "Torpedo Gunship",
		energymake = 0.7,
		energyuse = 0.7,
		explodeas = "mediumExplosionGeneric",
		footprintx = 3,
		footprintz = 3,
		hoverattack = true,
		icontype = "air",
		idleautoheal = 5,
		idletime = 1800,
		maxdamage = 960,
		maxslope = 10,
		maxvelocity = 8.87,
		maxwaterdepth = 255,
		name = "Typhoon",
		nochasecategory = "VTOL",
		objectname = "CORSEAP",
		seismicsignature = 0,
		selfdestructas = "mediumExplosionGenericSelfd",
		sightdistance = 455,
		turnrate = 610,
		customparams = {
			model_author = "Beherith",
			subfolder = "coreseaplanes",
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
				[1] = "deathceg2",
				[2] = "deathceg3",
				[3] = "deathceg4",
			},
		},
		sounds = {
			build = "nanlath1",
			canceldestruct = "cancel2",
			repair = "repair1",
			underattack = "warning1",
			working = "reclaim1",
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
				[1] = "seapsel2",
			},
		},
		weapondefs = {
			armseap_weapon1 = {
				areaofeffect = 16,
				avoidfeature = false,
				avoidfriendly = false,
				burnblow = true,
				collidefriendly = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.2,
				explosiongenerator = "custom:genericshellexplosion-small-uw",
				flighttime = 1.75,
				impulseboost = 0.123,
				impulsefactor = 0.123,
				model = "torpedo",
				name = "TorpedoLauncher",
				noselfdamage = true,
				range = 500,
				reloadtime = 1.75,
				soundhit = "xplodep2",
				soundstart = "bombrel",
				startvelocity = 100,
				tolerance = 12000,
				tracks = true,
				turnrate = 99000,
				turret = false,
				waterweapon = true,
				weaponacceleration = 15,
				weapontimer = 5,
				weapontype = "TorpedoLauncher",
				weaponvelocity = 100,
				customparams = {
					bar_model = "cortorpedo.s3o",
				},
				damage = {
					bombers = 15,
					commanders = 63,
					default = 125,
					fighters = 15,
					vtol = 15,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "NOTSHIP",
				def = "ARMSEAP_WEAPON1",
				onlytargetcategory = "NOTHOVER",
			},
		},
	},
}
