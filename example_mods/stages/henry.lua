local speed = 0
local xx = 887.2;
local yy = 767.45;
local xx2 = 1461.6;
local yy2 = 767.45;
local ofs = 20;
local followchars = true;

function onCreate() 

	makeLuaSprite('backstage','bg/henry_bg', 0, 0)
	scaleObject('backstage', 1.4, 1.4)
	updateHitbox('backstage')
	setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)

end