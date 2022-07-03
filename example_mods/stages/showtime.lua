glassNotPlayed = true
function onCreate() 
	precacheImage('bg/showtimebg/car')
	makeLuaSprite('sky','', 0, -300)
	makeGraphic('sky', 5000, 5000, '00021E')
	setScrollFactor('sky', 0, 0);
	setProperty('sky.antialiasing', false)
	--addLuaSprite('sky',false)
	
	makeAnimatedLuaSprite('cassidy', 'bg/showtimebg/cassidy', 672, 615.9);
	setProperty('cassidy.antialiasing', false)
	addAnimationByPrefix('cassidy', 'dance', 'Cassidy', 10, true);
	objectPlayAnimation('cassidy', 'dance', true);
	scaleObject('cassidy', 2, 2)
	updateHitbox('cassidy')
	addLuaSprite('cassidy', false)
	
	makeAnimatedLuaSprite('car', 'bg/showtimebg/car', 208.15, 262.7);
	setProperty('car.antialiasing', false)
	addAnimationByPrefix('car', 'dance', 'glass', 30, false);
	objectPlayAnimation('car', 'dance', true);
	scaleObject('car', 2, 2)
	updateHitbox('car')
	setProperty('car.visible', false)
	addLuaSprite('car', false)
	
	makeLuaSprite('back','bg/showtimebg/foreground', 0, 0)
	scaleObject('back', 3, 3)
	updateHitbox('back')
	setProperty('back.antialiasing', false)
	addLuaSprite('back',false)
	
	makeAnimatedLuaSprite('kid1', 'bg/showtimebg/kiddance', 525.15, 707.75);
	setProperty('kid1.antialiasing', false)
	addAnimationByPrefix('kid1', 'dance', 'kid', 30, true);
	objectPlayAnimation('kid1', 'dance', true);
	scaleObject('kid1', 3, 3)
	updateHitbox('kid1')
	addLuaSprite('kid1', false)
	
	makeAnimatedLuaSprite('kid2', 'bg/showtimebg/kiddance', 352.4, 869.55);
	setProperty('kid2.antialiasing', false)
	addAnimationByPrefix('kid2', 'dance', 'kid', 30, true);
	objectPlayAnimation('kid2', 'dance', true);
	scaleObject('kid2', 3, 3)
	updateHitbox('kid2')
	addLuaSprite('kid2', false)
	
	makeAnimatedLuaSprite('kid3', 'bg/showtimebg/kiddance', 1604.8, 707.55);
	setProperty('kid3.antialiasing', false)
	addAnimationByPrefix('kid3', 'dance', 'kid', 30, true);
	objectPlayAnimation('kid3', 'dance', true);
	scaleObject('kid3', 3, 3)
	updateHitbox('kid3')
	addLuaSprite('kid3', false)
	
	makeAnimatedLuaSprite('kid4', 'bg/showtimebg/kiddance', 1801.55, 869.35);
	setProperty('kid4.antialiasing', false)
	addAnimationByPrefix('kid4', 'dance', 'kid', 30, true);
	objectPlayAnimation('kid4', 'dance', true);
	scaleObject('kid4', 3, 3)
	updateHitbox('kid4')
	addLuaSprite('kid4', false)
end

function onUpdate()
	if getProperty('car.animation.curAnim.curFrame') == 108 and glassNotPlayed and getProperty('car.visible') == true then
		glassNotPlayed = false
		playSound('glass')
	end
end