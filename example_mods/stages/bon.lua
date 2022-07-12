local speed = 0
local xx = 480;
local yy = 300;
local xx2 = 799;
local yy2 = 550;
local ofs = 80;
local followchars = true;

function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf_ourple')
	makeLuaSprite('scanline','scanline',0, 0)
	scaleObject('scanline', 1.5, 1.5)
	setScrollFactor('scanline', 0, 0)
	setObjectCamera('scanline', 'other')
	if lowQuality == false then
		addLuaSprite('scanline', true)
	end
	
	close(true)
end