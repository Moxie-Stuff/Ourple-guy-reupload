-- Script by Shadow Mario
-- Customized for Simplicity by Kevin Kuntz
tvSings = false
function onCreate()
	makeAnimationList();
	makeOffsets();
	precacheImage('characters/henry-tv')
	
	makeAnimatedLuaSprite('comp', 'characters/henry-tv', -170, -70);
	addAnimationByPrefix('comp', 'idle', 'idle', 30, false);
	addAnimationByPrefix('comp', 'singLEFT', 'left', 30, false);
	addAnimationByPrefix('comp', 'singDOWN', 'down', 30, false);
	addAnimationByPrefix('comp', 'singUP', 'up', 30, false);
	addAnimationByPrefix('comp', 'singRIGHT', 'right', 30, false);
	setScrollFactor('comp', 0, 0)
	setProperty('comp.visible', false)
	
	addLuaSprite('comp', true);

	playAnimation('comp', 'idle', true);
end

animationsList = {}
holdTimers = {comp = 10.0};
singAnimations = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
function makeAnimationList()
	animationsList['idle'] = 'idle';
	animationsList['singLEFT'] = 'singLEFT';
	animationsList['singDOWN'] = 'singDOWN';
	animationsList['singUP'] = 'singUP';
	animationsList['singRIGHT'] = 'singRIGHT';
end

offsetscomp = {};
function makeOffsets()
	offsetscomp['idle'] = {x = 0, y = 0}; --idle
	offsetscomp['singLEFT'] = {x = 0, y = 0}; --left
	offsetscomp['singDOWN'] = {x = 0, y = 0}; --down
	offsetscomp['singUP'] = {x = 0, y = 0}; --up
	offsetscomp['singRIGHT'] = {x = 0, y = 0}; --right
end

function onEvent(n,v1,v2)

	if n == 'Object Play Animation' and v1 == 'comp' then
		playAnimation(v1,v2,true)
		specialAnim = true
	end
	
	if n == 'TV Sings' then
		tvSings = not tvSings
	end

end

function onUpdate(elapsed)
	holdCap = stepCrochet * 0.004;
	if holdTimers.comp >= 0 then
		holdTimers.comp = holdTimers.comp + elapsed;
		if holdTimers.comp >= holdCap then
			playAnimation('comp', 'idle', false);
			holdTimers.comp = -1;
		end
	end
	
	for i=0, getProperty('notes.length')-1 do
		if tvSings == true and getPropertyFromGroup('notes', i, 'noteType') == '' and not getPropertyFromGroup('notes', i, 'mustPress') then
			setPropertyFromGroup('notes', i, 'noteType', 'TV Sings')
			setPropertyFromGroup('notes', i, 'noAnimation', true)
		elseif tvSings == false and getPropertyFromGroup('notes', i, 'noteType') == 'TV Sings' and not getPropertyFromGroup('notes', i, 'mustPress') then
			setPropertyFromGroup('notes', i, 'noteType', '')
			setPropertyFromGroup('notes', i, 'noAnimation', false)
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'TV Sings' then
		if not isSustainNote then
			animToPlay = singAnimations[direction+1];
		end	
		characterToPlay = 'comp'
		holdTimers.comp = 0;
				
		playAnimation(characterToPlay, animToPlay, true);
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
		if holdTimers.comp < 0 then
			playAnimation('comp', 'idle', false);
		end
	end
end

function playAnimation(character, animId, forced)
	-- 0 = idle
	-- 1 = singLEFT
	-- 2 = singDOWN
	-- 3 = singUP
	-- 4 = singRIGHT
	animName = animationsList[animId];
	--debugPrint(animName);
	objectPlayAnimation(character, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)
	offsetTable = offsetscomp
	setProperty(character..'.offset.x', offsetTable[animId].x);
	setProperty(character..'.offset.y', offsetTable[animId].y);
end