function onCreatePost()
	defaultY = getProperty('iconP2.y')
	setProperty('boyfriend.visible', false)
end

function onBeatHit()
	setProperty('iconP2.scale.y', 1)
	setProperty('iconP2.scale.x', 1)
end

function onUpdatePost()
	local angleOfs = math.random(-5, 5)
	local posXOfs = math.random(-8, 8)
	local posYOfs = math.random(-4, 4)
	if getProperty('healthBar.percent') > 80 then
		setProperty('iconP2.angle', angleOfs)
		setProperty('iconP2.x', getProperty('iconP2.x') + posXOfs)
		setProperty('iconP2.y', defaultY + posYOfs)
	else
		setProperty('iconP2.angle', 0)
	end
end