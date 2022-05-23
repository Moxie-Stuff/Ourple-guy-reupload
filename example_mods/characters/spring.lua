flipped = true
duration = 0
function onCreatePost()
	duration = getPropertyFromClass('Conductor', 'stepCrochet') * 2 / 1100
end
function onBeatHit() 
	if getProperty('dad.curCharacter') == 'spring' then
		flipped = not flipped
		setProperty('iconP2.flipX', flipped)
		doTweenY('jumpUp', 'iconP2', getProperty('iconP2.y') - 60, duration, 'cubeOut')
		if flipped then
			doTweenAngle('tiltUp', 'iconP2', getProperty('iconP2.angle') + 30, duration, 'sineOut')
		else
			doTweenAngle('tiltUp', 'iconP2', getProperty('iconP2.angle') - 30, duration, 'sineOut')
		end
	end
end

function onTweenCompleted(tag)
	if getProperty('dad.curCharacter') == 'spring' then
		if tag == 'jumpUp' then
			doTweenY('fallDown', 'iconP2', getProperty('iconP2.y') + 60, duration, 'cubeIn')
			if flipped then
				doTweenAngle('tiltUp', 'iconP2', getProperty('iconP2.angle') - 30, duration, 'sineIn')
			else
				doTweenAngle('tiltUp', 'iconP2', getProperty('iconP2.angle') + 30, duration, 'sineIn')
			end
		end
	end
end