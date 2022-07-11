function onCreate()  
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'crushed')
	makeLuaSprite('barup','',-34.95,-90.95)
	makeGraphic('barup',1348.9,211,'000000')
	addLuaSprite('barup',true)
    setScrollFactor('barup',0,0)
    setObjectCamera('barup','hud')

	makeLuaSprite('bardown','',-26,630.45)
	makeGraphic('bardown',1348.9,211,'000000')
	addLuaSprite('bardown',true)
    setScrollFactor('bardown',0,0)
    setObjectCamera('bardown','hud')

	setPropertyFromClass('GameOverSubstate', 'characterName', 'jka')
    makeLuaSprite('room','bg/ngt/ngroom', -600, -180)
	updateHitbox('room')
	setProperty('room.antialiasing', false)
	addLuaSprite('room',false)
 
    makeLuaSprite('room2','bg/ngt/ngforeground', -600, -100)
	updateHitbox('room2')
	setProperty('room2.antialiasing', false)
	setScrollFactor('room2', 1.2, 1.2)
	addLuaSprite('room2',true)
	close(true)
end 



