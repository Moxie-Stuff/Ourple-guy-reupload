defaultY = 0
function onCreatePost()
	defaultY = getProperty('boyfriend.y')
end
function onBeatHit() 
	if curBeat % 1 == 0 and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		setProperty('boyfriend.y', getProperty('boyfriend.y') + 20)
		doTweenY('raiseBf', 'boyfriend', getProperty('boyfriend.y') - 20, 0.15, 'cubeOut')
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if not getPropertyFromGroup('notes', id, 'gfNote') then
		cancelTween('raiseBf')
		setProperty('boyfriend.y', defaultY)
		doTweenY('raiseBf', 'boyfriend', getProperty('boyfriend.y') - 20, 0.15, 'cubeOut')
	end
end