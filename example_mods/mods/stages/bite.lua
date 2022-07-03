dadX = 0
dadY = 0
function onCreate() 
	addCharacterToList('foxy', 'dad')
	precacheImage('bg/bite/freddy-jumpscare')
	precacheImage('bg/bite/bonniebg')
	precacheImage('bg/bite/chicabg')
	precacheImage('bg/bite/foxy-run')
	precacheImage('bg/bite/golden')
	makeLuaSprite('backstage','bg/bite/office', -200, 50)
	--setProperty('backstage.antialiasing', false)
	addLuaSprite('backstage',false)
	
	makeAnimatedLuaSprite('bonnie', 'bg/bite/bonniebg', 50, 150)
	addAnimationByPrefix('bonnie', 'dance', 'Bonnie', 30, false)
	setProperty('bonnie.visible', false)
	addLuaSprite('bonnie')
	
	makeAnimatedLuaSprite('chica', 'bg/bite/chicabg', 650, 180)
	addAnimationByPrefix('chica', 'dance', 'Chica', 30, false)
	setProperty('chica.visible', false)
	addLuaSprite('chica')
	
	makeAnimatedLuaSprite('freddyJump', 'bg/bite/freddy-jumpscare', 0, 0)
	addAnimationByPrefix('freddyJump', 'jumpscare', 'jumpscare-fred', 40, false)
	setScrollFactor('freddyJump', 0, 0)
	scaleObject('freddyJump', 1.55, 1.55)
	updateHitbox('freddyJump')
	setProperty('freddyJump.visible', false)
	addLuaSprite('freddyJump', true)
	
	makeAnimatedLuaSprite('foxyRunning', 'bg/bite/foxy-run', -100, -100)
	addAnimationByPrefix('foxyRunning', 'running', 'run-foxy', 40, false)
	setScrollFactor('foxyRunning', 0, 0)
	scaleObject('foxyRunning', 3.2, 3.2)
	updateHitbox('foxyRunning')
	setProperty('foxyRunning.visible', false)
	addLuaSprite('foxyRunning', true)
	
	makeLuaSprite('golden', 'bg/bite/golden', 0, 0)
	setScrollFactor('golden', 0, 0)
	setProperty('golden.visible', false)
	addLuaSprite('golden', true)
end

function onCreatePost() 
	setProperty('dad.alpha', 0)
	dadX = getProperty('dad.x') + 100
	dadY = getProperty('dad.y')
end

function onUpdate(elapsed)
	if mustHitSection then
		setProperty('defaultCamZoom', 1.1)
	else
		setProperty('defaultCamZoom', 1.5)
	end
end

function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('bonnie', 'dance', true)
		objectPlayAnimation('chica', 'dance', true)
	end
end

function onEvent(n, v1, v2)
	if n == 'Freddy Intro' then
		doTweenX('freddyMove', 'dad', getProperty('dad.x') + 100, 4, 'cubeOut')
		doTweenAlpha('freddyFade', 'dad', 1, 4, 'cubeOut')
	end
	
	if n == 'Change Character' and v2 == 'freddy' then
		setProperty('dad.x', dadX)
		setProperty('dad.y', dadY)
	end
end