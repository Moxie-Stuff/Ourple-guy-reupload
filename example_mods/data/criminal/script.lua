local allowCountdown = false
local freaked = false
local xx = -285
local yy = -250
function onCreate()
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'scream')
	snapCamFollow(xx, yy)
end
function onCreatePost()
	setProperty('timeBar.visible', false)
	setProperty('timeBarBG.visible', false)
	setProperty('timeTxt.visible', false)
end

function onStartCountdown()
	-- countdown started, duh
	--triggerEvent('Play Animation', 'intro', 'dad')
	if not allowCountdown then
		playSound('criminal', 1, 'criminal')
		setProperty('camHUD.alpha', 0)
		setProperty('dad.alpha', 0)
		runTimer('increaseAlpha', 0.7, 7)
		setProperty('skipCountdown', true)
		return Function_Stop;
	end
	
	setProperty('camHUD.alpha', 1)
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'increaseAlpha' then
		setProperty('dad.alpha', getProperty('dad.alpha') + 0.15)
	end
	
	if tag == 'freak' then
		stopSound('criminal')
		setProperty('dad.idleSuffix', '-fuckedup')
		triggerEvent('Play Animation', 'idle-fuckedup', 'dad')
		runTimer('startSong', 2, 1)
	end
	
	if tag == 'startSong' then
		allowCountdown = true
		startCountdown()
	end
end

function onUpdate()
	if getProperty('dad.alpha') == 1 and not freaked then
		freaked = true
		runTimer('freak', 3, 1)
	end
	
	if not inGameOver then
		for i=0, 3 do
			if getPropertyFromGroup('opponentStrums', i, 'visible') ~= false then
				setPropertyFromGroup('opponentStrums', i, 'visible', false)
			end
		end
		
		if getPropertyFromGroup('playerStrums', 0, 'x') ~= defaultPlayerStrumX0 - 630 and not getPropertyFromClass('ClientPrefs', 'middleScroll') then
			setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0 - 630)
			setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1 - 600)
			setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2 - 30)
		end
		
		for i = 0, getProperty('notes.length')-1 do
			if getPropertyFromGroup('notes', i, 'mustPress') == false and getPropertyFromGroup('notes', i, 'visible') == true then
				setPropertyFromGroup('notes', i, 'visible', false)
			end
		end
	end
end

