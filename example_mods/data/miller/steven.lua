-- Script by Shadow Mario
-- Customized for Simplicity by Kevin Kuntz
function onCreate()
	makeAnimationList();
	makeOffsets();
	
	makeAnimatedLuaSprite('steven', 'characters/steven', 4700.4, 5077.65);
	addAnimationByPrefix('steven', 'idle', 'idle', 30, false);
	addAnimationByPrefix('steven', 'singLEFT', 'left0', 30, false);
	addAnimationByPrefix('steven', 'singDOWN', 'down0', 30, false);
	addAnimationByPrefix('steven', 'singUP', 'up0', 30, false);
	addAnimationByPrefix('steven', 'singRIGHT', 'right0', 30, false);
	
	addAnimationByPrefix('steven', 'singLEFTmiss', 'leftmiss', 30, false);
	addAnimationByPrefix('steven', 'singDOWNmiss', 'downmiss', 30, false);
	addAnimationByPrefix('steven', 'singUPmiss', 'upmiss', 30, false);
	addAnimationByPrefix('steven', 'singRIGHTmiss', 'rightmiss', 30, false);
	
	addAnimationByPrefix('steven', 'die', 'dead', 30, true);
	scaleObject('steven', 1.8, 1.8)
	updateHitbox('steven')
	setProperty('steven.antialiasing', false)
	setProperty('steven.visible', false)
	addLuaSprite('steven', true);

	playAnimation('steven', 'idle', true);
	addLuaScript('peter')
	setObjectOrder('peter', getObjectOrder('steven')+1)
end

animationsList = {}
holdTimers = {steven = 15.0};
singAnimations = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
function makeAnimationList()
	animationsList['idle'] = 'idle';
	animationsList['singLEFT'] = 'singLEFT';
	animationsList['singDOWN'] = 'singDOWN';
	animationsList['singUP'] = 'singUP';
	animationsList['singRIGHT'] = 'singRIGHT';
	animationsList['singLEFTmiss'] = 'singLEFTmiss';
	animationsList['singDOWNmiss'] = 'singDOWNmiss';
	animationsList['singUPmiss'] = 'singUPmiss';
	animationsList['singRIGHTmiss'] = 'singRIGHTmiss';
	animationsList['die'] = 'die';
end

offsetssteven = {};
function makeOffsets()
	offsetssteven['idle'] = {x = 0, y = 0}; --idle
	offsetssteven['singLEFT'] = {x = 85, y = 156}
	offsetssteven['singDOWN'] = {x = 85, y = 156}
	offsetssteven['singUP'] = {x = 85, y = 156}
	offsetssteven['singRIGHT'] = {x = 85, y = 156}
	offsetssteven['singLEFTmiss'] = {x = 85, y = 156}
	offsetssteven['singDOWNmiss'] = {x = 85, y = 156}
	offsetssteven['singUPmiss'] = {x = 85, y = 156}
	offsetssteven['singRIGHTmiss'] = {x = 85, y = 156}
	offsetssteven['die'] = {x = 55, y = -328};
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Steven Sing' then
		if not isSustainNote then
			animToPlay = singAnimations[direction+1];
		end	
		characterToPlay = 'steven'
		holdTimers.steven = 0;
				
		playAnimation(characterToPlay, animToPlay, true);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Steven Sing' then
		if not isSustainNote then
			animToPlay = singAnimations[direction+1]..'miss';
		end	
		characterToPlay = 'steven'
		animToPlay = animToPlay
				
		playAnimation(characterToPlay, animToPlay, true);
	end
end

function onUpdate(elapsed)
	holdCap = stepCrochet * 0.004;
	if holdTimers.steven >= 0 then
		holdTimers.steven = holdTimers.steven + elapsed;
		if holdTimers.steven >= holdCap then
			playAnimation('steven', 'idle', false);
			holdTimers.steven = -1;
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
		if holdTimers.steven < 0 and getProperty('steven.animation.curAnim.name') ~= 'die' then
			playAnimation('steven', 'idle', true);
		end
	end
end

function playAnimation(character, animId, forced)
	objectPlayAnimation(character, animId, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)
	offsetTable = offsetssteven
	setProperty(character..'.offset.x', offsetTable[animId].x)
	setProperty(character..'.offset.y', offsetTable[animId].y)
end

function onEvent(n,v1,v2)

	if n == 'Object Play Animation' and v1 == 'steven' then
		playAnimation(v1,v2,true)
		if string.sub(getProperty('steven.animation.curAnim.name'),1,4) == 'sing' then
			holdTimers.steven = 0
		end
	end

end