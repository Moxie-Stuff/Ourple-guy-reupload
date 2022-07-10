function onCreate() 
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf_ourple')
	makeLuaSprite('backstage','bg/oval', -286, -60)
	scaleObject('backstage', 2.5, 2.5)
	updateHitbox('backstage')
	setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)
	
end

function onMoveCamera(focus)
	setProperty('boyfriend.visible', false)
	setPropertyFromClass('flixel.FlxG.camera', 'target', nil)
	setProperty('isCameraOnForcedPos', true)
	setProperty('camFollowPos.x', getPropertyFromClass('flixel.FlxG', 'width') / 2 - 350)
	setProperty('camFollowPos.y', getPropertyFromClass('flixel.FlxG', 'height') / 2 - 350)
	setProperty('camFollow.x', getPropertyFromClass('flixel.FlxG', 'width') / 2 - 350)
	setProperty('camFollow.y', getPropertyFromClass('flixel.FlxG', 'height') / 2 - 350)
end