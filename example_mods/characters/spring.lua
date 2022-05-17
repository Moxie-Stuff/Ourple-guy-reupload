flipped = true
function onBeatHit() 
	flipped = not flipped
	setProperty('iconP2.flipX', flipped)
	doTweenY('jumpUp', 'iconP2', getProperty('iconP2.y') - 60, 0.17, 'cubeOut')
	if flipped then
		doTweenAngle('tiltUp', 'iconP2', getProperty('iconP2.angle') + 30, 0.18, 'sineOut')
	else
		doTweenAngle('tiltUp', 'iconP2', getProperty('iconP2.angle') - 30, 0.18, 'sineOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'jumpUp' then
		doTweenY('fallDown', 'iconP2', getProperty('iconP2.y') + 60, 0.17, 'cubeIn')
		if flipped then
			doTweenAngle('tiltUp', 'iconP2', getProperty('iconP2.angle') - 30, 0.18, 'sineIn')
		else
			doTweenAngle('tiltUp', 'iconP2', getProperty('iconP2.angle') + 30, 0.18, 'sineIn')
		end
	end
end