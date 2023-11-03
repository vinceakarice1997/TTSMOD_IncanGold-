function onLoad()
    Bags = {
        bag_of_one = getObjectFromGUID("b886f6"),
        bag_of_five = getObjectFromGUID("106fbf"),
        bag_of_ten = getObjectFromGUID("62c82b"),
    }

        MainDeck = getObjectFromGUID("d9273d")

        index_cards = {
            [1] = getObjectFromGUID("f15874"),
            [2] = getObjectFromGUID("7d3607"),
            [3] = getObjectFromGUID("ab35a2"),
            [4] = getObjectFromGUID("3b21f7"),
            [5] = getObjectFromGUID("c92543"),
        }
end

--control
-------------------------------

function next_stage()
    MainDeck.shuffle()
    state.StageIndex = state.StageIndex + 1
    index_cards[state.StageIndex].setRotation({0,270,0},false,false)
    
    active_players = updateSeatedPlayers

        local artifact_cards = getObjectFromGUID("2481ec").getObjects()
        if artifact_cards ~= nil and artifact_cards.type == deck then
            local c = artifact_cards.takeObject()

        elseif artifact_cards ~= nil and artifact_cards.type == card then
            
        end
end

function next_card()
    local card = MainDeck.takeObject()
    table.insert( state.cave_cards, card)
    local cardindex = #state.cave_cards
    card.setPositionSmooth(card_position[cardindex], false, false)
    card.setRotationSmooth({0.00, 180.00, 0.00}, false, false)
    if card.event ~= nil then
        local ev_str = card.event
        if ev_str == "treasure" then 
            treasure_spill(card.count)
        elseif ev_str == "artifact" then
            table.insert("artifacts", card)
        else hardzard_event.ev_str() end
    end
end

function hazard_break_out(obj)
    
end

function treasure_spill(num)
    local pl_num = #active_players
    local spill = math.floor(num/pl_num)
    local left = num%pl_num
    local left_onCard = {}
    if spill ~= 0 then
        for _,pl in pairs(active_players) do
            for j = 1,spill do
                local gem = bag_of_one.takeObject()
                local lpos = posMergeRand(s, {0,1,0})
                gem.setPositionSmooth(lpos)
            end
        end
    end

    if left ~= 0 then
    for i = 1, left do
        local gem = bag_of_one.takeObject()
        local lpos = posMergeRand(obj.getPosition(), {0,1,0})
        gem.setPositionSmooth(lpos)
        table.insert("left_onCard", gem)
    end
        table.insert("Left_things", left_onCard)
    end
end

function update_activeplayers()
    
end

--player action
--------------------

function vote_going(player)
    local col = player.color
    vote_list[col] = true
end

function vote_quit(player)
    local col = player.color
    vote_list[col] = false
end

function vote_start()
    for _, value in vote_list do
    value = nil
    end
end

function vote_confirm()
    for key,value in pairs(vote_list) do
        if value ~= nil then
            if value then table.insert(active_players,#active_players, key) end
            if value == false then table.insert(quiting_players, #quiting_players, key) end
        end
    end
end

function vote_end()
    vote_confirm()
    if #quiting_players ~= 0 then
    for _,pl in pairs(quiting_players) do                                           --every pl
        player_camped.pl = true
        for _, left_tabs in pairs(Left_things) do                                   --every card
            local spill = math.floor(#left_tabs/#quiting_players)                   --every gem
                if spill == 0 then 
                    --do nothing
                else
                    for i =1,spill do
                            local lpos = posMergeRand(plcol_gems_position.pl, {0,1,0})
                            left_tabs[1].setPositionSmooth(lpos,false,false)
                            table.remove(left_tabs, 1)
                    end
                end
        end
    end
    else end

    if #quiting_players == 1 then
        --take all artifacts
    end


    next_card()
end

function updateSeatedPlayers()
    seatedPlayers = {}
    if Player["Red"].seated then seatedPlayers[#seatedPlayers+1] = "Red" end
    if Player["Orange"].seated then seatedPlayers[#seatedPlayers+1] = "Orange" end
    if Player["Yellow"].seated then seatedPlayers[#seatedPlayers+1] = "Yellow" end
    if Player["Teal"].seated then seatedPlayers[#seatedPlayers+1] = "Teal" end
    if Player["Blue"].seated then seatedPlayers[#seatedPlayers+1] = "Blue" end
    if Player["Green"].seated then seatedPlayers[#seatedPlayers+1] = "Green" end
    if Player["Purple"].seated then seatedPlayers[#seatedPlayers+1] = "Purple" end
    if Player["Pink"].seated then seatedPlayers[#seatedPlayers+1] = "Pink" end
    return seatedPlayers
end

hardzard_event = {
    ["spider"] = function ()
        if state.spider_alarm == true then
            broadcastToAll("完蛋！要被蜘蛛包围了！")
        elseif state.spider_alarm == false then
            state.spider_alarm = true
        end
    end,
    
    ["snake"] = function() 
        if state.snake_alarm == true then
            broadcastToAll("完蛋！要被蛇蛇包围了！")
        elseif state.spider_alarm == false then
        state.snake_alarm = true
        end
    end,

    ["rock"] = function() 
        if state.rock_alarm == true then
            broadcastToAll("完蛋！要被落石包围了！")
        elseif state.rock_alarm == false then
        state.rock_alarm = true
        end
    end,

    ["fire"] = function() 
        if state.fire_alarm == true then
            broadcastToAll("完蛋！要被火灾包围了！")
        elseif state.fire_alarm == false then
        state.fire_alarm = true
        end
    end,

    ["zombie"] = function() 
        if state.zombie_alarm == true then
            broadcastToAll("完蛋！要被脏比包围了！")
        elseif state.zombie_alarm == false then
        state.zombie_alarm = true
        end
    end

}

--misc
--------------------
function posMerge(pos1, pos2)
    return {pos1[1]+pos2[1],pos1[2]+pos2[2],pos1[3]+pos2[3]}
end

function posMergeRand(pos1, pos2)
    local var = 0.2
    return {
        pos1[1]+pos2[1] + math.random()*var*2-var,
        pos1[2]+pos2[2] + math.random()*var*2-var,
        pos1[3]+pos2[3] + math.random()*var*2-var,}
end

--
----table
card_position = 
{
[1] = {-24.50, 1, 4.82},
[2] = {-21.77, 1, 4.82},
[3] = {-19.05, 1, 4.82},
[4] = {-16.25, 1, 4.82},
[5] = {-13.47, 1, 4.82},
[6] = {-10.68, 1, 4.82},

[7] = {-24.50, 1, 0.91},
[8] = {-21.77, 1, 0.91},
[9] = {-19.05, 1, 0.91},
[10] = {-16.25, 1, 0.91},
[11] = {-13.47, 1, 0.91},
[12] = {-10.68, 1, 0.91},

[13] = {-24.50, 1, -3.06},
[14] = {-21.77, 1, -3.06},
[15] = {-19.05, 1, -3.06},
[16] = {-16.25, 1, -3.06},
[17] = {-13.47, 1, -3.06},
[18] = {-10.68, 1, -3.06},

[19] = {-24.50, 1, -7},
[20] = {-21.77, 1, -7},
[21] = {-19.05, 1, -7},
[22] = {-16.25, 1, -7},
[23] = {-13.47, 1, -7},
[24] = {-10.68, 1, -7},

[25] = {-22.59, 1, -11.05},
[26] = {-19.68, 1, -11.05},
[27] = {-16.81, 1, -11.05},
[28] = {-13.97, 1, -11.05},
[29] = {-11.15, 1, -11.05},
[30] = {-8.38, 1, -11.05},
}

plcol_gems_position = {
    Red = {9.91, 3.51, -16.25},
    Orange = {-10.15, 3.51, -16.25},
    Yellow = {-26.00, 3.51, 15.29},
    Green = {-8.14, 3.51, 16.64},
    Teal = {-25.78, 3.51, -16.86},
    Blue = {9.99, 3.51, 16.12},
    Purple = {25.46, 3.51, 15.77},
    Pink = {25.48, 3.51, -14.00},
}

plcol_gems_guid = {
    Red = "6b4a21",
    Orange ="228a56",
    Yellow = "b5b704",
    Green = "f98191",
    Teal = "a05271",
    Blue = "34c96f",
    Purple = "d8a686",
    Pink = "b93cac",
}
--state table
--------------------
state = {
    GameOn = false,
    StageIndex = 0,
    Left_things = {}, -- table : gems
    cave_cards = {},
    artifacts = {},
    snake_alarm = false,
    fire_alarm = false,
    spider_alarm = false,
    rock_alarm = false,
    zombie_alarm = false,
    seatedPlayers = {},
    active_players = {},
    quiting_players = {},
    player_camped = {
        Red =nil,
        Orange = nil,
        Yellow = nil,
        Green = nil,
        Teal = nil,
        Blue = nil,
        Purple = nil,
        Pink = nil
    },
    vote_list = {
        Red =nil,
        Orange = nil,
        Yellow = nil,
        Green = nil,
        Teal = nil,
        Blue = nil,
        Purple = nil,
        Pink = nil,
    },

    Cardguid_to_going = {
        Red = nil,
        Orange = nil,
        Yellow = nil,
        Green = nil,
        Teal = nil,
        Blue = nil,
        Purple = nil,
        Pink = nil,
    },

    Cardguid_to_quit = {
        Red = nil,
        Orange = nil,
        Yellow = nil,
        Green = nil,
        Teal = nil,
        Blue = nil,
        Purple = nil,
        Pink = nil,
    },
}


SeatedPlayers = {}

