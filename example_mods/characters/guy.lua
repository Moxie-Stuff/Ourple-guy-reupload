flipped = true
flippedIdle = false
defaultY = 0
function onCreatePost()
	defaultY = getProperty('dad.y')
end
function onBeatHit() 
	if getProperty('healthBar.percent') < 80 then
		flipped = not flipped
		setProperty('iconP2.flipX', flipped)
	end
	
	if curBeat % 1 == 0 and getProperty('dad.animation.curAnim.name') == 'idle' then
		flippedIdle = not flippedIdle
		setProperty('dad.flipX', flippedIdle)
		setProperty('dad.y', getProperty('dad.y') + 20)
		doTweenY('raise', 'dad', getProperty('dad.y') - 20, 0.15, 'cubeOut')
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if not getPropertyFromGroup('notes', id, 'gfNote') then
	cancelTween('raise')
	setProperty('dad.y', defaultY)
	setProperty('dad.flipX', false)
	end
end

function onStepHit() 
	if getProperty('healthBar.percent') > 80 and curStep % 2 == 0 then
		flipped = not flipped
		setProperty('iconP2.flipX', flipped)
	end
end

function onUpdate(e)
	local angleOfs = math.random(-5, 5)
	if getProperty('healthBar.percent') > 80 then
		setProperty('iconP2.angle', angleOfs)
	else
		setProperty('iconP2.angle', 0)
	end
end