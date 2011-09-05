return {
	armhawk = {
		acceleration = 0.47999998927116,
		airsightdistance = 800,
		brakerate = 11.25,
		buildcostenergy = 4593,
		buildcostmetal = 114,
		buildpic = "ARMHAWK.DDS",
		buildtime = 7685,
		canfly = true,
		canmove = true,
		category = "ALL NOTLAND MOBILE WEAPON ANTIGATOR NOTSUB ANTIFLAME ANTIEMG ANTILASER VTOL NOTSHIP",
		collide = false,
		cruisealt = 160,
		description = "Stealth Fighter",
		explodeas = "BIG_UNITEX",
		footprintx = 2,
		footprintz = 2,
		icontype = "air",
		maxdamage = 335,
		maxslope = 10,
		maxvelocity = 11.960000038147,
		maxwaterdepth = 0,
		name = "Hawk",
		nochasecategory = "NOTAIR",
		objectname = "ARMHAWK",
		seismicsignature = 0,
		selfdestructas = "BIG_UNIT",
		sightdistance = 200,
		stealth = true,
		turnrate = 1425,
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
				[1] = "vtolarmv",
			},
			select = {
				[1] = "vtolarac",
			},
		},
		weapondefs = {
			armvtol_advmissile = {
				areaofeffect = 8,
				impactonly = 1,
				collidefriendly = false,
				craterboost = 0,
				cratermult = 0,
				explosiongenerator = "custom:FLASH2",
				firestarter = 0,
				impulseboost = 0,
				impulsefactor = 0,
				metalpershot = 0,
				model = "missile",
				name = "GuidedMissiles",
				noselfdamage = true,
				range = 562,
				reloadtime = 0.85000002384186,
				smoketrail = true,
				soundhit = "xplosml2",
				soundstart = "Rocklit3",
				startvelocity = 650,
				texture2 = "armsmoketrail",
				tolerance = 8000,
				tracks = true,
				turnrate = 36000,
				weaponacceleration = 250,
				weapontimer = 7,
				weapontype = "MissileLauncher",
				weaponvelocity = 850,
				damage = {
					bombers = 265,
					commanders = 5,
					subs = 5,
					default = 12,
					fighters = 400,
					vtol = 265,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "NOTAIR",
				def = "ARMVTOL_ADVMISSILE",
			},
			[2] = {
        badtargetcategory = "NOTAIR",
				def = "ARMVTOL_ADVMISSILE",
			},
		},
	},
}
