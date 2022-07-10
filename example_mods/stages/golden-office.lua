function onCreate() 
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf_ourple')
	makeLuaSprite('backstage','bg/golden-office', 0, 0)
	scaleObject('backstage', 2, 2)
	updateHitbox('backstage')
	setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)
	
end

function onCreatePost() 
	setProperty('gf.visible', false)
	--close(true)
	
end