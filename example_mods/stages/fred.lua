local speed = 0
local xx = 30;
local yy = 0;
local xx2 = 0;
local yy2 = 0;
local ofs = 50;
local followchars = true;

function onCreate()
	precacheImage('vignette')
	precacheImage('bg/eyes')
	makeAnimatedLuaSprite('memories','bg/memories', -1392.25, -576)
	addAnimationByPrefix('memories', 'flash', 'bgs', 120, false)
	objectPlayAnimation('memories', 'flash', true)
	setProperty('memories.visible', false)
	addLuaSprite('memories', false)
	
	makeAnimatedLuaSprite('eyes','bg/eyes', -880, -500)
	addAnimationByPrefix('eyes', 'flash', 'fuck', 30, true)
	objectPlayAnimation('eyes', 'flash', true)
	setProperty('eyes.visible', false)
	scaleObject('eyes', 3.2, 3)
	updateHitbox('eyes')
	setProperty('eyes.antialiasing', false)
	if flashingLights == true then
		addLuaSprite('eyes', false)
	end
	
	makeLuaSprite('scanline','scanline',0, 0)
	scaleObject('scanline', 1.5, 1.5)
	setScrollFactor('scanline', 0, 0)
	setObjectCamera('scanline', 'other')
	if lowQuality == false then
		addLuaSprite('scanline', true)
	end
	
end

function onCreatePost()
	setProperty('camFollowPos.x', 60)
	setProperty('camFollowPos.y', 30)
	setProperty('boyfriend.visible', false)
	setProperty('gf.visible', false)
end 

function onEvent(n, v1, v2)
	if flashingLights == true then
		if n == 'Alter Visibility' and v1 == 'eyes' and v2 == 'true' then
			triggerEvent('Flash Camera', '0.5', '0')
			triggerEvent('Add Camera Zoom', '0.13', '0.16')
		end
		
		if n == 'Alter Visibility' and v1 == 'eyes' and v2 == 'false' then
			setProperty('eyes.alpha', 1)
		end
	end
end