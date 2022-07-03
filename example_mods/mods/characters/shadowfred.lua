function onCreatePost()
	setProperty('iconP2.antialiasing', false)
	setProperty('iconP1.antialiasing', false)
end

function onBeatHit()
	setProperty('iconP2.scale.y', 1)
	setProperty('iconP2.scale.x', 1)
	
	setProperty('iconP1.scale.y', 1)
	setProperty('iconP1.scale.x', 1)
end