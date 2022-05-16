local speed = 0
local xx2 = 581;
local yy2 = 1187.2;
local xx = 1038.75;
local yy = 1178.8;
local ofs = 20;
local followchars = true;

function onCreate() 

	makeLuaSprite('backstage','bg/showtime', 0, 0)
	scaleObject('backstage', 2.8, 2.8)
	updateHitbox('backstage')
	setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)

end

function onCreatePost()
	setProperty('gf.visible', false)
end