function onCreate() 
	makeLuaSprite('backstage','bg/samm_room', -300, -150)
	updateHitbox('backstage')
	addLuaSprite('backstage',false)
	
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
	close(true)
end