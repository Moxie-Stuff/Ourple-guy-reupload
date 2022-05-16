function onEvent(n,v1,v2)


	if n == 'Alter Visibility' then
			if v2 == 'true' then
				setProperty(v1..'.visible', true)
			else
				setProperty(v1..'.visible', false)
			end
	end



end