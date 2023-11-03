function onload()
    local lstate = Global.getTable("state")
    index_cards = {
        [1] = getObjectFromGUID("f15874"),
        [2] = getObjectFromGUID("7d3607"),
        [3] = getObjectFromGUID("ab35a2"),
        [4] = getObjectFromGUID("3b21f7"),
        [5] = getObjectFromGUID("c92543"),
    }
    MainDeck = getObjectFromGUID("d9273d")

        if lstate ~= nil and lstate.GameOn == true then return end
    
        self.createButton({
            label = "开始游戏",
            height = "1200",
            width = "2400",
            font_size = "500",
            click_function = "begin", 
            tooltip = "请确保所有玩家都已正确就座/选择颜色，再开始游戏",
            position = {0,2,0},
        })

        
    end
    
    function begin()
    self.clearButtons()
    local lstate = Global.getTable("state")
    lstate.GameOn = true
    Global.call("next_stage")

    end