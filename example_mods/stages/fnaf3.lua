local speed = 0
local xx2 = 581;
local yy2 = 1187.2;
local xx = 1038.75;
local yy = 1178.8;
local ofs = 20;
local followchars = true;

function onCreate() 

	makeLuaSprite('backstage','bg/fnaf3', -500, 50)
	scaleObject('backstage', 3, 3)
	updateHitbox('backstage')
	--setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)

	close(true)
end