function onCreatePost()
    setPropertyFromClass('ClientPrefs', 'scoreZoom', false)

    setProperty('scoreTxt.scale.x', 0.90)
    setProperty('scoreTxt.scale.y', 0.90)
    
    
    -- setTextAlignment("scoretext", 'center')

    makeLuaText("scoretext", "skill issue", 200, getProperty('healthBarBG.x'), getProperty('healthBarBG.y') + 30)
    setTextSize("scoretext", 16)
    setTextFont("scoretext", "vcr.ttf");
    setTextBorder("scoretext", 1, '000001')
    addLuaText("scoretext")
end
function onUpdatePost(elapsed)
    setProperty("scoreTxt.y", -100)
    setTextString("scoretext",  'How Ourple You Are:' .. getProperty('songScore'))
end