local speed = 0
local xx = 881.05;
local yy = 846.95;
local xx2 = 1490.55;
local yy2 = 946;
local ofs = 20;
local followchars = true;

function onCreate() 
	
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
	
	makeAnimatedLuaSprite('rain', 'bg/midnight/rain', 80, 0);
	setProperty('rain.antialiasing', false)
	setScrollFactor('rain', 1.25, 1.25);
	addAnimationByPrefix('rain', 'rain', 'rain', 30, true);
	setProperty('rain.alpha', 0.5)
	addLuaSprite('rain', true)

end

function onCreatePost()
	setProperty('gf.visible', false)
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