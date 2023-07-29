Explanation of how damage is being calculated by this library

9mm example
	Velocity: 900
	Weight: 115
	Burn Time: 7
	Target Resistance: 50
	Damage: 45
		
5.56 nato example
	velocity: 2750
	weight: 55
	Burn Time: 14.5
	Target Resistance: 50
	Damage: 1902.5
	
This highlights just how important bullet resistence is. Think of it as you would body armor.
You still feel the impact even if it doesn't penetrate and even if it does penetrate, some of the bullets power is lost after going through the armor.
Obviously higher power rounds will punch through armor and retain more of its power.

The data above for demonstrating types of ammo is based on some real world numbers for those type of bullets:
1. Velocity is based on the lowest reported fps for real world bullets for both 9mm and 5.56 NATO.
2. Weight is based on lowest real world bullet grain weight.
3. Burn Time is the optimal barrel length to ensure all powder has been burned before the round leaves the barrel.
   We aren't measuring each model's barrel length so we are assuming its correct by default.
4. Target resistence is the balistic resistence of a target's armor.
	
	damage calculation formula:
		( Velocity - Weight * BurnTime ) - Resistance
		
This is not the MOST realistic way to determine damage for bullets, but it is close while still being reasonable.
If we find a better way later, then this will change.
