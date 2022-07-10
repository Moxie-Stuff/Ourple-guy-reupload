local speed = 0
local xx2 = 581;
local yy2 = 1187.2;
local xx = 1038.75;
local yy = 1178.8;
local ofs = 20;
local followchars = true;

function onCreate() 
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'crushed')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'wind')
	makeLuaSprite('backstage','bg/stage0/showtime', 0, 0)
	scaleObject('backstage', 2.8, 2.8)
	updateHitbox('backstage')
	setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)
	
	makeLuaSprite('child1','bg/stage0/child1', 0, 0)
	scaleObject('child1', 2.8, 2.8)
	updateHitbox('child1')
	setProperty('child1.antialiasing', false)
	addLuaSprite('child1',false)
	
	makeLuaSprite('child2','bg/stage0/child2', 0, 0)
	scaleObject('child2', 2.8, 2.8)
	updateHitbox('child2')
	setProperty('child2.antialiasing', false)
	addLuaSprite('child2',false)

end

function onGameOverStart()
	-- You died! Called every single frame your health is lower (or equal to) zero
	--return Function_Stop
	setScrollFactor(getPropertyFromClass('GameOverSubstate', 'boyfriend'), 0, 0)
	setPropertyFromClass('flixel.FlxG', 'camera.x', 0)
	setPropertyFromClass('flixel.FlxG', 'camera.y', 0)
	setProperty('boyfriend.x', 180)
	setProperty('boyfriend.y', 180)
	setProperty('boyfriend.alpha', 0)
	doTweenAlpha('fadeIn', 'boyfriend', 1, 3, 'sineIn')
	--objectPlayAnimation('boyfriend', 'die', true)
	return Function_Continue;
end


function onCreatePost()
	if not getPropertyFromClass('clientPrefs', 'middleScroll') then
	setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0)
	setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1)

	setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2)

	setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3)

	setPropertyFromGroup('playerStrums', 4, 'x', defaultOpponentStrumX4)

	setPropertyFromGroup('opponentStrums', 0, 'x', defaultPlayerStrumX0 + 0)

	setPropertyFromGroup('opponentStrums', 1, 'x', defaultPlayerStrumX1 + 0)

	setPropertyFromGroup('opponentStrums', 2, 'x', defaultPlayerStrumX2 + 0)

	setPropertyFromGroup('opponentStrums', 3, 'x', defaultPlayerStrumX3 + 0)

	setPropertyFromGroup('opponentStrums', 4, 'x', defaultPlayerStrumX4 + 0)
	end
end