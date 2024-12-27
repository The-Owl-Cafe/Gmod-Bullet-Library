# NOTICE: This is Abandoned. Owl Cafe nolonger has a use for this. Will remain for research purposes

# NOTICE:
Not only are you free to use this in your sweps, I encourage and would love to see this more widely adopted for use. I hate how unrealistic alot of sweps are when it comes to damage aswell as how most servers handle armor for players. I really do prefer it to be more realistic.

# How to use

## Create your ammo types
This is where the damage a bullet can do is determined. This is more realistic to how guns in the real world work. It's not a perfect 1:1 match but it is more realistic than the weapon itself determining the ammo's capability alone. You will need to know your ammo's fps(velocity), grain(weight), and the optimal Barrel Length(BurnTime) when you create it. these numbers exist for pretty much all ammo that exists in the real world both old and new. Some varry so feel free to play around a little to get it just right. This also means instead of trying to balance a single weapon's damage, you can ballence every weapon that uses the specific ammo at the same time. This should mean the only thing specific to a swep that needs to be changed is stuff like reload time, rate of fire, spread and recoil.

## Create your armor types
This is still partially being worked on, but the idea is that in real life balistic armor can stop certain rounds but weaken other rounds. So based on the example ammo bellow, if a player has on armor with a resistance of 50 and they get hit by a 9mm bullet, they will only take 45 damage. Where as if they get hit by a 5.56 round, they are gunna take 1902.5 damage. Now first thing you are probably thinking is, holy hell thats alot of damage and you are right it is. BUT this is closer to being realistic because if a 5.56 round were to slam into a person who has no armor or insufficient armor they are going to either be dead, or knocked rought out of the fight anyways. So this is where higher level body armor comes in. We can use real world numbers to somewhat determin how much resistence a armor type should have.

So lets say that a player gets hit by a 5.56 round, but this time they are wearing a rifle rated armor type, that stops 1900 damage from hitting them. Well they will end up taking 52.2 damage. Well that basically means 1 hit took half their health away. Yes it does, realistically if you are hit by a round, even with protection you will most likely feel it when it's higher powered rounds.

So what does this mean for YOU using this library? It means you can not only calculate the resistince of your armor(with some tweeks to make it more ballenced), you can also make variations of your armor types that have trauma pads under the armor to justify further reducing the damage the player takes. This is basically like saying the round hit, but the traumapad reduced how much of it you felt when it impacted.

If a round has enough force to overcome the added protection and still do enough damage to outright kill the player, then chances are you are firing something like a 50bmg, or another round with enough force behind it that realistically no armor in the real world would protect you from.

9mm
Velocity: 900
Weight: 115
Burn Time: 7
Damage: 95
		
5.56 nato
velocity: 2750
weight: 55
Burn Time: 14.5
Damage: 1952.5


## Velocity Drop
As a bullet in the real world travels, velocity is dropped over time resulting in less effective stopping power and longer ranges. The library has a function in it that is used to calculate loss of energy the further the bullet has to travel. The function does have the option to keep a certain percentage of damage from being lost. So certain weapons will still have long range effectiveness, even if their damage is still reduced. This also allows armor to be more effective at range and thus add to the realistic behavior.

Going by the 5.56 nato example above, the damage gets lower and lower as the distance increases. This is not tested yet but the dropoff rate likely will need to change depending on engine distance measurements.
500 units: 1269.125
1000 units: 878.625
10000 units: 527.175


## Firing the ammo in a swep
Call BulletLib.Initialize() to make the library handle body armor resistance with the ammo types. Otherwise higher rounds may do more damage than they should.

The function BulletLib.FireBullet( ent, bullet ) takes a weapon as the ent and the name of the ammo you are firing as bullet. This function then decides what amount of damage to apply when it hits a player. Currently bullet spread isn't yet handled by the library but this is planned to be implemented some how later. This should also handle setting up lagcompensation for the fired bullets and handle bullet tracers when firing. So you can focuse more on ballencing other things such as weapon recoil.


# How damage is calculated
( Velocity - Weight * BurnTime ) - Resistance

This gives us a usable number for how much damage a type of ammo should reasonably do. For smaller rounds it produces a realistic enough number assuming a player is working with health at 100. For higher rounds being fired at the player, armor is going to be more important to have. This sorta reflects how the real world works when it comes to guns and body armor.

		
This is not the MOST realistic way to determine damage for bullets, but it is close while still being reasonable.
If we find a better way later, then this will change.
