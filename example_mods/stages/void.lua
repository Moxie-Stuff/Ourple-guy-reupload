_G.alive = true
spitehp = {}
spitegroup = {}
stunholder = {}
counter = 4
spitealive = {}
spiteOgX = {}
--i love tables
curType = ''
default = true
curFlashbackF = 1
bannedAnims = {'singUP', 'singDOWN', 'singLEFT', 'singRIGHT', 'die', 'idle-dead'}
listHealing = {'dee','peter','steven','gf','blackjack'}
listAttacking = {'dee','peter','steven','gf','boyfriend'}
bjDefY = 0
introDone = false
function onCreate() 
	precacheImage('spite/hit')
	precacheImage('heal')
	precacheImage('flashbacks')
	precacheImage('millerint')
	setProperty('camZooming', true)
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'horn')
	
	setObjectOrder('dadGroup', getObjectOrder('dadGroup') + 2)
	setObjectOrder('gfGroup', getObjectOrder('gfGroup') + 2)
	
	makeLuaSprite('void','flesh', 605, 3881)
	addLuaSprite('void', false)
	
	makeAnimatedLuaSprite('blackjack', 'bounces', 4842.55, 4842.55);
	bjDefY = getProperty('blackjack.y')
	addAnimationByPrefix('blackjack', 'dance', 'blackjack idle', 30, false);
	addAnimationByPrefix('blackjack', 'die', 'blackjack dead', 30, false);
	objectPlayAnimation('blackjack', 'dance', true);
	doTweenY('floatUp', 'blackjack', getProperty('blackjack.y') - 150, 2, 'sineInOut')
	
	addLuaSprite('blackjack', true)
	
	makeLuaSprite('spite1', 'spite/spite1', 2436.65, 5212.2); --bottom right
	addLuaSprite('spite1', true)
	spitegroup[1] = getProperty('spite1')
	stunholder[1] = false
	spitealive[1] = true
	spitehp[1] = 100
	spiteOgX[1] = getProperty('spite1.x')
	
	makeLuaSprite('spite2', 'spite/spite2', 2210.05, 4413.45); --upper right
	addLuaSprite('spite2', true)
	spitegroup[2] = getProperty('spite2')
	stunholder[2] = false
	spitealive[2] = true
	spitehp[2] = 100
	spiteOgX[2] = getProperty('spite2.x')
	
	makeLuaSprite('spite3', 'spite/spite3', 1542.55, 5224.85); --bottom left
	addLuaSprite('spite3', true)
	spitegroup[3] = getProperty('spite3')
	stunholder[3] = false
	spitealive[3] = true
	spitehp[3] = 100
	spiteOgX[3] = getProperty('spite3.x')
	
	makeLuaSprite('spite4', 'spite/spite4', 1572.2, 4519.8); --upper left
	addLuaSprite('spite4', true)
	spitegroup[4] = getProperty('spite4')
	stunholder[4] = false
	spitealive[4] = true
	spitehp[4] = 100
	spiteOgX[4] = getProperty('spite4.x')
	
	makeLuaText('WEAKENED', 'WEAKENED!', 305, (getPropertyFromClass('flixel.FlxG', 'width') * 0.39), (getPropertyFromClass('flixel.FlxG', 'height') * 0.75))
	setTextAlignment('WEAKENED', 'center')
	setProperty('WEAKENED.alpha', 0)
	setTextSize('WEAKENED', 50)
	setTextBorder('WEAKENED', 2, 'FFFFFF')
	setTextColor('WEAKENED', 'D60A0A')
	--setTextFont('WEAKENED', 'Arial Narrow')
	setTextItalic('WEAKENED', true)
	addLuaText('WEAKENED')
	
	for i,object in pairs(spitegroup) do
		doTweenY('floatDownS'..i, object, getProperty(object..'.y') + 150, 2 + i/100, 'sineInOut')
	end
	
	makeLuaSprite('barup','',-34.95,-160.95)
	makeGraphic('barup',1348.9,281,'000000')
	addLuaSprite('barup',true)
    setScrollFactor('barup',0,0)
    setObjectCamera('barup','hud')

	makeLuaSprite('bardown','',-26,630.45)
	makeGraphic('bardown',1348.9,281,'000000')
	addLuaSprite('bardown',true)
    setScrollFactor('bardown',0,0)
    setObjectCamera('bardown','hud')
	
	makeLuaSprite('black','', -1500, -1500)
	makeGraphic('black', 5000, 5000, '000000')
	addLuaSprite('black', true)
    setScrollFactor('black',0,0)
    --setObjectCamera('black','other')
	setProperty('camHUD.alpha', 0)
	
	makeAnimatedLuaSprite('flashbacks', 'flashbacks', 0, 0);
	for i=1, 12 do
		addAnimationByPrefix('flashbacks', tostring(i), tostring(i)..'0000', 0, false);
	end
	objectPlayAnimation('flashbacks', '1', true);
	setObjectCamera('flashbacks', 'other')
	scaleObject('flashbacks', 0.8, 0.8)
	screenCenter('flashbacks')
	setProperty('flashbacks.alpha', 0)
	setProperty('flashbacks.antialiasing', false)
	addLuaSprite('flashbacks', true)
	
	makeAnimatedLuaSprite('millerint', 'millerint', 0, 0);
	addAnimationByPrefix('millerint', 'int', 'millerint', 30, false);
	setObjectCamera('millerint', 'hud')
	screenCenter('millerint')
	setProperty('millerint.antialiasing', false)
	setProperty('millerint.visible', false)
	addLuaSprite('millerint', true)
	
	makeLuaSprite('hint','spite/hint', 0, 0)
	setProperty('hint.antialiasing', false)
	scaleObject('hint', 1.5, 1.5)
	updateHitbox('hint')
	screenCenter('hint')
	setObjectCamera('hint', 'other')
	setProperty('hint.y', getProperty('hint.y')+500)
	addLuaSprite('hint', true)
	
	makeLuaSprite('THX','ty', 0, 0)
	setProperty('THX.antialiasing', false)
	scaleObject('THX', 0.49, 0.49)
	updateHitbox('THX')
	screenCenter('THX')
	setObjectCamera('THX', 'other')
	setProperty('THX.alpha', 0)
	addLuaSprite('THX', true)
end

function onCreatePost()
	duration = getPropertyFromClass('Conductor', 'stepCrochet') * 8 / 1000
	setProperty('henrylip.x', getProperty('dad.x')-400)
	setProperty('henrylip.y', getProperty('dad.y')-130)
end

function onGameOverStart()
	setPropertyFromClass('flixel.FlxG', 'camera.x', 0)
	setPropertyFromClass('flixel.FlxG', 'camera.y', 0)
	setProperty('boyfriend.visible', false)
	
	makeLuaSprite('usuck','usuck', 0, 0)
	setProperty('usuck.antialiasing', false)
	setScrollFactor('usuck', 0, 0)
	scaleObject('usuck', 5, 5)
	updateHitbox('usuck')
	screenCenter('usuck')
	addLuaSprite('usuck', true)
	return Function_Continue;
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('health') > 0.2 then
		if counter > 0 then
			damage = counter * 1.7 / 100
			setProperty('health', (getProperty('health')) - damage)
		end
	end
end

function onTweenCompleted(tag)
	if _G.alive == true then
		if tag == 'floatDown' then
			doTweenY('floatUp', 'blackjack', getProperty('blackjack.y') - 150, duration, 'sineInOut')
		end
		
		if tag == 'floatUp' then
			doTweenY('floatDown', 'blackjack', getProperty('blackjack.y') + 150, duration, 'sineInOut')
		end
	end
	for i,object in pairs(spitegroup) do
	
		if stunholder[i] == false and spitehp[i] > 0 and object ~= nil then
			if tag == 'floatDownS'..i then
				doTweenY('floatUpS'..i, object, getProperty(object..'.y') - 150, 2 + i/100, 'sineInOut')
			end
			
			if tag == 'floatUpS'..i then
				doTweenY('floatDownS'..i, object, getProperty(object..'.y') + 150, 2 + i/100, 'sineInOut')
			end
		end
		
		if object ~= nil then
			if tag == 'knockbackS'..i then
				if spitehp[i] < 1 then
					doTweenAlpha('fadeS'..i, object, 0, 0.2, 'sineIn')
				else
					doTweenX('moveBackS'..i, object, spiteOgX[i], 0.2, 'sineIn')
				end
			end
			
			if tag == 'fadeS'..i then
				removeLuaSprite(object)
			end
		end
	end
	
	for i,object in pairs(listHealing) do
		if tag == 'fadeHeal'..i then
			removeLuaSprite('healFX'..i)
		end
	end
	
	if tag == 'raiseHint2' then
		removeLuaSprite('hint')
	end
end

function onEvent(n,v1,v2)

	if n == 'All Sing' then
		triggerEvent('Play Animation', 'singUP', 'gf')
		triggerEvent('Object Play Animation', 'dee', 'singUP')
		triggerEvent('Object Play Animation', 'peter', 'singUP')
		triggerEvent('Object Play Animation', 'steven', 'singUP')
	end
	if n == 'Object Play Animation' then
		if v2 == 'die' then
			if v1 == 'blackjack' then
				_G.alive = false
			end
		end
	end
	
	if n == 'Object Play Animation' then
		if v2 == 'dance' then
			if v1 == 'blackjack' then
				_G.alive = true
				setProperty('blackjack.y', bjDefY)
				doTweenY('floatDown', 'blackjack', getProperty('blackjack.y') + 150, 2, 'sineInOut')
				for i,object in pairs(listHealing) do
					sprName = 'healFX'..i
					local ofsX = 500
					local ofsY = 400
					if i == 4 then
						ofsX = 700
					elseif i == 1 then
						ofsY = 700
						ofsX = 600
					elseif i == 2 or i == 3 then
						ofsY = 600
						ofsX = 570
					end
					makeAnimatedLuaSprite(sprName, 'heal', getMidpointX(object)-ofsX, getMidpointY(object)-ofsY)
					addAnimationByPrefix(sprName, 'hit', 'heal', 33, false)
					objectPlayAnimation(sprName, 'hit', true)
					scaleObject(sprName, 5, 5)
					updateHitbox(sprName)
					setProperty(sprName..'.antialiasing', false)
					addLuaSprite(sprName, true)
					doTweenAlpha('fadeHeal'..i, sprName, 0, 1.2, 'sineIn')
				end
			end
		end
	end
	
	if n == 'Set Note Type' then
		curType = v1
		if curType == 'bf' or curType == 'BF' then
			curType = ''
		end
		if curType == '' or curType == 'GF Sing' then
			default = true
		else
			default = false
		end
	end
	
	if n == 'Add Alpha' and v1 == 'flashbacks' then
		objectPlayAnimation('flashbacks', tostring(curFlashbackF), true)
		curFlashbackF = curFlashbackF + 1
	end
	
	if n == 'Play Animation' and (v1 == 'singDOWN' or v1 == 'singUP' or v1 == 'singLEFT' or v1 == 'singRIGHT') and v2 == 'gf' then
		setProperty('gf.holdTimer', 0)
	end
	
	if n == 'Alter Visibility' and v1 == 'millerint' and v2 == 'false' then
		removeLuaSprite('millerint')
		removeLuaSprite('flashbacks')
		removeLuaSprite('black')
		introDone = true
		setProperty('camHUD.visible', true)
	end
	
	if n == 'Alter Visibility' and v1 == 'hint' and v2 == 'true' then
		doTweenY('raiseHint', 'hint', getProperty('hint.y')-500, 0.75, 'cubeOut')
		runTimer('flyHint', 2.5)
	end

end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'flyHint' then
		doTweenY('raiseHint2', 'hint', getProperty('hint.y')-500, 0.75, 'cubeIn')
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Spite Note' then
		local index = noteData+1
		
		spitehp[index] = spitehp[index] - 8

		if spitealive[index] == true and spitehp[index] < 1 then
			finalHit(index)
		end
		
		for i,object in pairs(spitegroup) do
			if i == index then
				doTweenX('knockbackS'..i, object, getProperty(object..'.x') - 150, 0.2, 'cubeOut')
				
				makeAnimatedLuaSprite('hitFX'..i, 'spite/hit', getMidpointX(object)-500, getMidpointY(object)-500)
				addAnimationByPrefix('hitFX'..i, 'hit', 'hit', 30, false) 
				objectPlayAnimation('hitFX'..i, 'hit', true)
				scaleObject('hitFX'..i, 5, 5)
				updateHitbox('hitFX'..i)
				setProperty('hitFX'..i..'.antialiasing', false)
				addLuaSprite('hitFX'..i, true)
			end
		end
		playSound('dmg-spite', 0.15)
		--[[local charPick = math.random(1,5)
		local charName = listAttacking[charPick] 
		local animName = getProperty(charName..'.animation.name')
		repeat
			charPick = math.random(1,5) 
			charName = listAttacking[charPick] 
			animName = getProperty(charName..'.animation.name')
		until animName == 'idle' or string.sub(getProperty(animName),1,5) == 'dance'
		
		if animName == 'idle' or string.sub(getProperty(animName),1,5) == 'dance' then
			playHitAnim(charName)
		end--]]
	end
end

function finalHit(index)
	cancelTween('Fall')
	cancelTween('FallX')
	cancelTween('Bounce')
	cancelTween('BounceX')
	setProperty('WEAKENED.y', (getPropertyFromClass('flixel.FlxG', 'height') * 0.75))
	setProperty('WEAKENED.x', (getPropertyFromClass('flixel.FlxG', 'width') * 0.39))
	setProperty('WEAKENED.alpha', 1)
	doTweenY('Bounce', 'WEAKENED', getProperty('WEAKENED.y') - 20, 1, 'sineOut')
	doTweenX('BounceX', 'WEAKENED', getProperty('WEAKENED.x') + 30, 1, 'sineOut')
	spitealive[index] = false
	counter = counter - 1
end

function onUpdate(elapsed)
	if getProperty('WEAKENED.alpha') > 0 then
		setProperty('WEAKENED.alpha', getProperty('WEAKENED.alpha') - 0.005)
	end
	
	for i=1, 4 do
		if getProperty('hitFX'..i..'.animation.curAnim.finished') then
			removeLuaSprite('hitFX'..i)
		end
	end
	
	for i = 0, getProperty('notes.length')-1 do
		if spitehp[getPropertyFromGroup('notes', i, 'noteData') + 1] < 1 and 
			getPropertyFromGroup('notes', i, 'noteType') == 'Spite Note' then
				--debugPrint('removed spite note'..tostring(getPropertyFromGroup('notes', i, 'noteData') + 1))
				removeFromGroup('notes', i)
		end
		
		if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') ~= 'Spite Note' then
			setPropertyFromGroup('notes', i, 'noteType', curType)
			if curType == 'GF Sing' then
				setPropertyFromGroup('notes', i, 'gfNote', true)
			else
				setPropertyFromGroup('notes', i, 'gfNote', false)
			end
			if not default then
				setPropertyFromGroup('notes', i, 'noAnimation', true)
				setProperty('boyfriend.hasMissAnimations', false)
			else
				setPropertyFromGroup('notes', i, 'noAnimation', false)
				setProperty('boyfriend.hasMissAnimations', true)
			end
		end
	end
	
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if spitehp[getPropertyFromGroup('unspawnNotes', i, 'noteData') + 1] < 1 and 
			getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Spite Note' then
				removeFromGroup('unspawnNotes', i)
		end
	end

	if mustHitSection == false then
		setProperty('defaultCamZoom', 0.45)
	else
		setProperty('defaultCamZoom', 0.3)
	end
	
	if introDone == false then
		if getProperty('flashbacks.alpha') > 0 then
			setProperty('flashbacks.alpha', getProperty('flashbacks.alpha') - 0.6 * elapsed)
			setProperty('flashbacks.scale.x', getProperty('flashbacks.scale.x') + 0.1 * elapsed)
			setProperty('flashbacks.scale.y', getProperty('flashbacks.scale.y') + 0.1 * elapsed)
		else
			setProperty('flashbacks.scale.x', 1.4)
			setProperty('flashbacks.scale.y', 1.4)
		end
	end
	
	if getProperty('THX.alpha') > 0 then
		setProperty('THX.scale.x', getProperty('THX.scale.x') - 0.005 * elapsed)
		setProperty('THX.scale.y', getProperty('THX.scale.y') - 0.005 * elapsed)
	end
end 