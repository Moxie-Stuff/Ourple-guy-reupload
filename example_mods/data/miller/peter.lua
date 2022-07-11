-- Script by Shadow Mario
-- Customized for Simplicity by Kevin Kuntz
function onCreate()
	makeOffsets();
	
	makeAnimatedLuaSprite('peter', 'characters/peterk', 4921.25, 5183.3);
	addAnimationByPrefix('peter', 'idle', 'Idle', 24, false);
	addAnimationByPrefix('peter', 'singLEFT', 'Left0', 30, false);
	addAnimationByPrefix('peter', 'singDOWN', 'Down0', 30, false);
	addAnimationByPrefix('peter', 'singUP', 'Up0', 30, false);
	addAnimationByPrefix('peter', 'singRIGHT', 'Right0', 30, false);
	
	addAnimationByPrefix('peter', 'singLEFTmiss', 'LeftMiss', 30, false);
	addAnimationByPrefix('peter', 'singDOWNmiss', 'DownMiss', 30, false);
	addAnimationByPrefix('peter', 'singUPmiss', 'UpMiss', 30, false);
	addAnimationByPrefix('peter', 'singRIGHTmiss', 'RightMiss', 30, false);
	
	addAnimationByPrefix('peter', 'die', 'Dead', 30, true);
	scaleObject('peter', 1.8, 1.8)
	updateHitbox('peter')
	setProperty('peter.antialiasing', false)
	setProperty('peter.visible', false)
	addLuaSprite('peter', true);

	playAnimation('peter', 'idle', true);
end
holdTimers = {peter = 15.0};
singAnimations = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};

offsetspeter = {};
function makeOffsets()
	offsetspeter['idle'] = {x = 0, y = 0}; --idle
	offsetspeter['singLEFT'] = {x = 185, y = -6}; --left
	offsetspeter['singDOWN'] = {x = 185, y = -6};
	offsetspeter['singUP'] = {x = 185, y = -6};
	offsetspeter['singRIGHT'] = {x = 185, y = -6};
	offsetspeter['singLEFTmiss'] = {x = 185, y = -6};
	offsetspeter['singDOWNmiss'] = {x = 185, y = -6};
	offsetspeter['singUPmiss'] = {x = 185, y = -6};
	offsetspeter['singRIGHTmiss'] = {x = 185, y = -6};
	offsetspeter['die'] = {x = 90, y = -270};
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Peter Sing' then
		if not isSustainNote then
			animToPlay = singAnimations[direction+1];
		end	
		characterToPlay = 'peter'
		holdTimers.peter = 0;
				
		playAnimation(characterToPlay, animToPlay, true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Peter Sing' then
		if not isSustainNote then
			animToPlay = singAnimations[direction+1]..'miss';
		end	
		characterToPlay = 'peter'
				
		playAnimation(characterToPlay, animToPlay, true);
	end
end

function onUpdate(elapsed)
	holdCap = stepCrochet * 0.004;
	if holdTimers.peter >= 0 then
		holdTimers.peter = holdTimers.peter + elapsed;
		if holdTimers.peter >= holdCap then
			playAnimation('peter', 'idle', false);
			holdTimers.peter = -1;
		end
	end
end

function onCountdownTick(counter)
	beatHitDance(counter);
end

function onBeatHit()
	beatHitDance(curBeat);
end

function beatHitDance(counter)
	if counter % 2 == 0 then
		if holdTimers.peter < 0 and getProperty('peter.animation.curAnim.name') ~= 'die' then
			playAnimation('peter', 'idle', false);
		end
	end
end

function playAnimation(character, animId, forced)
	objectPlayAnimation(character, animId, forced, 0); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)
	offsetTable = offsetspeter
	setProperty(character..'.offset.x', offsetTable[animId].x)
	setProperty(character..'.offset.y', offsetTable[animId].y)
end

function onEvent(n,v1,v2)

	if n == 'Object Play Animation' and v1 == 'peter' then
		playAnimation(v1,v2,true)
		if string.sub(getProperty('peter.animation.curAnim.name'),1,4) == 'sing' then
			holdTimers.peter = 0
		end
	end

end