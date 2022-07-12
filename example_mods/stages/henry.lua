function onCreate() 
	addCharacterToList('bf-ourple-pixel', 'boyfriend')
	addCharacterToList('henry-pixel', 'dad')
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf_ourple')
	makeLuaSprite('backstage','bg/henry_bg', 0, 0)
	scaleObject('backstage', 1.4, 1.4)
	updateHitbox('backstage')
	setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)
	
	makeLuaSprite('scanline','scanline',0, 0)
	scaleObject('scanline', 1.5, 1.5)
	setScrollFactor('scanline', 0, 0)
	setObjectCamera('scanline', 'other')
	if lowQuality == false then
		addLuaSprite('scanline', true)
	end
	setProperty('scanline.visible', false)

end

function onUpdate()
	setPropertyFromClass('GameOverSubstate', 'characterName', getProperty('boyfriend.curCharacter'))
	
	if getProperty('boyfriend.curCharacter') == 'bf-ourple-pixel' then
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'crushed')
	else
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx')
	end
end