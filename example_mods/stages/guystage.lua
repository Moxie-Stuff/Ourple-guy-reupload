local speed = 0
local xx = 480;
local yy = 500;
local xx2 = 799;
local yy2 = 550;
local ofs = 50;
local followchars = true;

function onCreate() 

	makeLuaSprite('backstage','bg/bckrom', -550,-580)
	scaleObject('backstage', 1.75, 1.75)
	updateHitbox('backstage')
	setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)

end