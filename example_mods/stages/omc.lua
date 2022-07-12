function onCreate() 

	precacheImage('cassidy-dead')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'crushed')
	setPropertyFromClass('GameOverSubstate', 'characterName', 'cassidy-dead')
	makeLuaSprite('lake','bg/omc', -1100, 0)
	scaleObject('lake', 3, 3)
	updateHitbox('lake')
	setProperty('lake.antialiasing', false)
	addLuaSprite('lake',false)
	
	makeLuaSprite('scanline','scanline',0, 0)
	scaleObject('scanline', 1.5, 1.5)
	setScrollFactor('scanline', 0, 0)
	setObjectCamera('scanline', 'other')
	if lowQuality == false then
		addLuaSprite('scanline', true)
	end
	close(true)

end
