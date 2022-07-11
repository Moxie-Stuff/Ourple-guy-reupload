defaultY = 0
function onCreatePost()
	defaultY = getProperty('dad.y')
end
function onBeatHit() 
	if curBeat % 1 == 0 and getProperty('dad.animation.curAnim.name') == 'idle' then
		setProperty('dad.y', getProperty('dad.y') + 20)
		doTweenY('raiseDad', 'dad', getProperty('dad.y') - 20, 0.15, 'cubeOut')
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if not getPropertyFromGroup('notes', id, 'gfNote') then
		cancelTween('raiseDad')
		setProperty('dad.y', defaultY)
		doTweenY('raiseDad', 'dad', getProperty('dad.y') - 20, 0.15, 'cubeOut')
	end
end