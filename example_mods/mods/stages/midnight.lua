function onCreate() 
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf_ourple')
	makeLuaSprite('sky','', 0, -300)
	makeGraphic('sky', 5000, 5000, '00021E')
	setScrollFactor('sky', 0, 0);
	setProperty('sky.antialiasing', false)
	addLuaSprite('sky',false)
	
	makeLuaSprite('back','bg/midnight/back', 0, -969)
	setScrollFactor('back', 0.7, 0.7);
	scaleObject('back', 3, 3)
	updateHitbox('back')
	setProperty('back.antialiasing', false)
	addLuaSprite('back',false)
	
	makeLuaSprite('front','bg/midnight/front', 0, 0)
	scaleObject('front', 3, 3)
	updateHitbox('front')
	setProperty('front.antialiasing', false)
	addLuaSprite('front',false)
	
	makeAnimatedLuaSprite('green', 'bg/midnight/green', 1235.6, 526.35);
	setProperty('green.antialiasing', false)
	addAnimationByPrefix('green', 'dance', 'green guy', 30, false);
	objectPlayAnimation('green', 'dance', true);
	addLuaSprite('green', false)
	
	makeAnimatedLuaSprite('freddie', 'bg/freddie', 1235.6-1500, 526.35-500);
	setProperty('freddie.antialiasing', false)
	scaleObject('freddie', 4, 4)
	updateHitbox('freddie')
	addAnimationByPrefix('freddie', 'dance', 'fredie freaker', 30, true);
	objectPlayAnimation('freddie', 'dance', true);
	--addLuaSprite('freddie', false)
	
	makeAnimatedLuaSprite('rain', 'bg/midnight/rain', 80, 0);
	setProperty('rain.antialiasing', false)
	setScrollFactor('rain', 1.25, 1.25);
	addAnimationByPrefix('rain', 'rain', 'rain', 30, true);
	setProperty('rain.alpha', 0.5)
	addLuaSprite('rain', true)

end
function onBeatHit()
	-- triggered 4 times per section
	
	if curBeat % 2 == 0 then
		objectPlayAnimation('green', 'dance', true)
		
		if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			objectPlayAnimation('boyfriend', 'idle', true)
		end
	end
	
end