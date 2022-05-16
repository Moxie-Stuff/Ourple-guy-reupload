local allowCountdown = false
local crushed = false
local glitching = false
function onStartCountdown()
	-- countdown started, duh
	triggerEvent('Camera Follow Pos', 30, 0)
	setProperty('camHUD.alpha', 0)
	triggerEvent('Play Animation', 'intro', 'dad')
	if not allowCountdown then
		setProperty('skipCountdown', true)
		return Function_Stop;
	end
	
	return Function_Continue;
end

function onUpdate(elapsed)
	-- start of "update", some variables weren't updated yet
	if getProperty('dad.animation.curAnim.curFrame') == 45 and getProperty('dad.animation.curAnim.name') == 'intro' and glitching == false then
		glitching = true
		playSound('glitching', 1, 'glitch')
	end
	if getProperty('dad.animation.curAnim.curFrame') == 149 and getProperty('dad.animation.curAnim.name') == 'intro' and crushed == false then
		crushed = true
		playSound('crushed')
		stopSound('glitch')
	end
	
	if getProperty('dad.animation.curAnim.finished') == true and getProperty('dad.animation.curAnim.name') == 'intro' then
		doTweenAlpha('camHUDIn', 'camHUD', 1, 2, 'cubeIn')
		allowCountdown = true;
		startCountdown()
		triggerEvent('Play Animation', 'idle', 'dad')
	end
end