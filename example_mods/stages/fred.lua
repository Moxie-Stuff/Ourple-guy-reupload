local speed = 0
local xx = 30;
local yy = 0;
local xx2 = 0;
local yy2 = 0;
local ofs = 50;
local followchars = true;

function onCreate()
	precacheImage('vignette')
	makeAnimatedLuaSprite('memories','bg/memories', -1392.25, -576)
	addAnimationByPrefix('memories', 'flash', 'bgs', 120, false)
	objectPlayAnimation('memories', 'flash', true)
	setProperty('memories.visible', false)
	addLuaSprite('memories', false)
	
	makeLuaSprite('scanline','scanline',0, 0)
	scaleObject('scanline', 1.5, 1.5)
	setScrollFactor('scanline', 0, 0)
	setObjectCamera('scanline', 'other')
	addLuaSprite('scanline', true)
	
end

function onCreatePost()
	setProperty('camFollowPos.x', 60)
	setProperty('camFollowPos.y', 30)
	setProperty('boyfriend.visible', false)
	setProperty('gf.visible', false)
end 