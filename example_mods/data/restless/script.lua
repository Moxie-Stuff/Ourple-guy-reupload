allowCountdown = false
function onCreatePost()
	setProperty('boyfriend.x', getProperty('gf.x')+40)
	setProperty('boyfriend.y', getProperty('gf.y')-80)
	
	setProperty('gf.visible', false)
	setProperty('iconP2.visible', false)
	setProperty('dad.visible', false)
	setProperty('camZooming', true)
	
	for i=0, getProperty('opponentStrums.length')-1 do
		setPropertyFromGroup('opponentStrums', i, 'visible', false)
	end
	setProperty('camGame.zoom', 1.2)
	setProperty('defaultCamZoom', 1.2)
	
	setProperty('timeBar.visible', false)
	setProperty('timeBarBG.visible', false)
	setProperty('timeTxt.visible', false)
end

function onStartCountdown()
	if not allowCountdown then
		characterPlayAnim('bf', 'idle', true)
		runTimer('transform', 1.5)
		return Function_Stop
	end
	return Function_Continue
end

function onTimerCompleted(t, timer, loops)
	if t == 'transform' then
		characterPlayAnim('bf', 'transform', true)
		playSound('crushed')
		setProperty('camGame.zoom', 4)
		setProperty('defaultCamZoom', 4)
		setProperty('defaultCamZoom', 1.2)
		runTimer('start', 0.5)
	end
	
	if t == 'start' then
		characterPlayAnim('bf', 'idle-alt', true)
		allowCountdown = true
		setProperty('boyfriend.idleSuffix', '-alt')
		startCountdown()
		for i=0, getProperty('opponentStrums.length')-1 do
			setPropertyFromGroup('opponentStrums', i, 'visible', false)
			if not getPropertyFromClass('ClientPrefs', 'middleScroll') then
				setPropertyFromGroup('playerStrums', i, 'x', getPropertyFromGroup('playerStrums', i, 'x') - 325)
			end
		end
		close(true)
	end
end