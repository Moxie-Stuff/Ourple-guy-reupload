function onEvent(n,v1,v2)

	if n == 'Object Play Animation' then
		
		if v1 ~= 'dee' then
			objectPlayAnimation(v1,v2,true)
		end
		
		if v2 == 'die' then
			
			if v1 == 'steven' then
				setProperty('steven.offset.y', -290)
				setProperty('steven.offset.x', 135)
			end
			
			if v1 == 'peter' then
				setProperty('peter.offset.y', -401)
				setProperty('peter.offset.x', 178)
			end
			
		end
	end

end