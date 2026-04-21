local Vector = require ("src/Math/vector")
local Form = require("src/Math/form")
local gs = require ("src/Math/gamespace")
local coll = require ("src/Game/collisions")
local Sprite = require ("src/Textures/sprites")
local const = require ("src/Config/const")

local Figure = {}

local initialSpeed = 500;

Figure.sizeX = 75
Figure.sizeY = 105

local sprites = 
{
    ["THE BEGGAR"] = {sprite = love.graphics.newImage("resources/sprites/figures/beggar.png")},
    ["THE MONARCH"] = {sprite = love.graphics.newImage("resources/sprites/figures/monarch.png")},
    ["THE WARRIOR"] = {sprite = love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["THE THIEF"] = {sprite =love.graphics.newImage("resources/sprites/figures/thief.png")},
    ["THE SLAVE"] = {sprite =love.graphics.newImage("resources/sprites/figures/slave.png")},
    ["THE KNIGHT"] = {sprite =love.graphics.newImage("resources/sprites/figures/knight.png")},
    ["THE PRISONER"] = {sprite =love.graphics.newImage("resources/sprites/figures/prisoner.png")},
    ["THE POLITICIAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/politician.png")},
    ["THE SPY"] = {sprite =love.graphics.newImage("resources/sprites/figures/spy.png")},
    ["THE VIKING"] = {sprite =love.graphics.newImage("resources/sprites/figures/viking.png")},
    ["THE ASSASSIN"] = {sprite =love.graphics.newImage("resources/sprites/figures/assassin.png")},
    ["THE GENERAL"] = {sprite =love.graphics.newImage("resources/sprites/figures/general.png")},
    ["THE MILLIONAIRE"] = {sprite = love.graphics.newImage("resources/sprites/figures/millionaire.png")},
    ["THE DICTATOR"] = {sprite =love.graphics.newImage("resources/sprites/figures/dictator.png")},
    ["THE NINJA"] = {sprite =love.graphics.newImage("resources/sprites/figures/ninja.png")},
    ["THE CEO"] = {sprite =love.graphics.newImage("resources/sprites/figures/ceo.png")},
    ["THE SAMURAI"] = {sprite =love.graphics.newImage("resources/sprites/figures/samurai.png")},
    ["THE EMPLOYEE"] = {sprite =love.graphics.newImage("resources/sprites/figures/employee.png")},
    ["THE CAPTAIN"] = {sprite =love.graphics.newImage("resources/sprites/figures/captain.png")},
    ["THE PIRATE"] = {sprite =love.graphics.newImage("resources/sprites/figures/pirate.png")},
    ["THE STUDENT"] = {sprite =love.graphics.newImage("resources/sprites/figures/student.png")},
    ["THE HITMAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/hitman.png")},
    ["THE POLICEMAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/policeman.png")},
    ["THE STRAWHAT"] = {sprite =love.graphics.newImage("resources/sprites/figures/strawhat.png")},
    ["THE GENIUS"] = {sprite =love.graphics.newImage("resources/sprites/figures/genius.png")},
    ["THE CAPO"] = {sprite =love.graphics.newImage("resources/sprites/figures/capo.png")},
    ["THE SENSEI"] = {sprite =love.graphics.newImage("resources/sprites/figures/sensei.png")},
    ["THE SHERIFF"] = {sprite =love.graphics.newImage("resources/sprites/figures/sheriff.png")},
    ["THE COWBOY"] = {sprite =love.graphics.newImage("resources/sprites/figures/cowboy.png")},
    ["THE MARTIAL ARTIST"] = {sprite =love.graphics.newImage("resources/sprites/figures/martial-artist.png")},
    ["THE SCAMMER"] = {sprite =love.graphics.newImage("resources/sprites/figures/scammer.png")},
    ["THE WIZARD"] = {sprite =love.graphics.newImage("resources/sprites/figures/wizard.png")},
    ["THE SCIENTIST"] = {sprite =love.graphics.newImage("resources/sprites/figures/scientist.png")},
    ["THE VILLAIN"] = {sprite =love.graphics.newImage("resources/sprites/figures/villain.png")},
    ["THE ASTROLOGER"] = {sprite =love.graphics.newImage("resources/sprites/figures/astrologer.png")},
    ["THE SHINOBI"] = {sprite =love.graphics.newImage("resources/sprites/figures/shinobi.png")},
    ["THE SUPERHERO"] = {sprite =love.graphics.newImage("resources/sprites/figures/superhero.png")},
    ["THE MONK"] = {sprite =love.graphics.newImage("resources/sprites/figures/monk.png")},
    ["THE ENGINEER"] = {sprite =love.graphics.newImage("resources/sprites/figures/engineer.png")},
    ["THE ASTRONAUT"] = {sprite =love.graphics.newImage("resources/sprites/figures/astronaut.png")},
    ["THE VIGILANTE"] = {sprite =love.graphics.newImage("resources/sprites/figures/vigilante.png")},
    ["THE PHILANTROPIST"] = {sprite =love.graphics.newImage("resources/sprites/figures/philantropist.png")},
    ["THE ROBOT"] = {sprite =love.graphics.newImage("resources/sprites/figures/robot.png")},
    ["THE BOUNTY HUNTER"] = {sprite =love.graphics.newImage("resources/sprites/figures/bounty-hunter.png")},
    ["THE DEMIGOD"] = {sprite =love.graphics.newImage("resources/sprites/figures/demigod.png")},
    ["THE SENTINEL"] = {sprite =love.graphics.newImage("resources/sprites/figures/sentinel.png")},
    ["THE CYBORG"] = {sprite =love.graphics.newImage("resources/sprites/figures/cyborg.png")},
    ["THE EMPEROR"] = {sprite =love.graphics.newImage("resources/sprites/figures/emperor.png")},
    ["THE ALIEN"] = {sprite =love.graphics.newImage("resources/sprites/figures/alien.png")},
    ["THE STEEL MAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/steel-man.png")},
    ["THE LEGEND"] = {sprite =love.graphics.newImage("resources/sprites/figures/legend.png")},
}

Figure.sprites = sprites

function Figure.init(type)
    figureAux = {}

    figureAux.dir = Vector.initVector2(0,1)
	figureAux.grabOffset = Vector.initVector2(0,0)
    figureAux.speed = initialSpeed
	figureAux.accel = 3000
    figureAux.isBeingGrabbed = false
	figureAux.isFalling = true;
    figureAux.isResting = false
    figureAux.type = type
    figureAux.form= {}
    figureFormPos = Vector.initVector2(0,0)

    if figureAux.type == "THE WARRIOR" then
        figureFormPos.x = 100
        figureFormPos.y = 10
    elseif figureAux.type == "THE MONARCH" or (figureAux.type == "THE BEGGAR") then
        figureFormPos.x = 700
        figureFormPos.y = 200
    end

    figureAux.form = Form.initRectangle(figureFormPos.x, figureFormPos.y, Figure.sizeX, Figure.sizeY)
    figureAux.sprite = Figure.sprites[figureAux.type].sprite

    return figureAux
end

function Figure.drag(mouse, figure)
    if mouse.x - figure.grabOffset.x < world.leftWall.pos.x then
        figure.form.pos.x = world.leftWall.pos.x
    elseif (mouse.x - figure.grabOffset.x) + figure.form.width > world.rightWall.pos.x then
        figure.form.pos.x = world.rightWall.pos.x - figure.form.width
    else 
        figure.form.pos.x = mouse.x - figure.grabOffset.x
    end
    if (mouse.y - figure.grabOffset.y) + figure.form.height > world.floor.pos.y 
        and (mouse.x - figure.grabOffset.x) +figure.form.width < world.floor.pos.x + world.floor.width + figure.form.width then
        figure.form.pos.y = world.floor.pos.y - figure.form.height
    else
    figure.form.pos.y = mouse.y - figure.grabOffset.y
    end
end

function Figure.update(game, i, dt)
    
    if not game.figures[i].isResting then
        game.figures[i].isFalling = not coll.rectOnRect(game.figures[i].form, game.world.floor) -- If figure isn't colliding with floor, it's falling
    else
        game.figures[i].isFalling = false
    end
    
	if game.figures[i].isBeingGrabbed then
		Figure.drag(game.player.mouse, game.figures[i])
        game.figures[i].isFalling = false
	end

    Figure.fall(game.figures[i], dt)
end

function Figure.fall(figure, dt)

    if (figure.isFalling and not figure.isBeingGrabbed) then
		figure.speed = figure.speed + figure.accel * dt
		figure.dir.y = 1
		figure.form.pos.y = figure.form.pos.y + figure.dir.y * figure.speed * dt
        game.fellsound:play()
    else 
		figure.speed = initialSpeed
	end
	--figure.form.pos.x = figure.form.pos.x + figure.dir.x * figure.speed * dt
end

function Figure.draw(figure, player)
	Sprite.drawFigure(figure)
    --Form.draw(figure.form)
	if (coll.pointOnRect(player.mouse, figure.form)) then
		love.graphics.setColor(0,0,0)
		love.graphics.printf(figure.type, gs.toResX(figure.form.pos.x), gs.toResY(figure.form.pos.y), gs.toResX(const.figSizeX), "center")
    end
	love.graphics.setColor(1,1,1)
end

function Figure.addNewFigure(figures, newFigure)
    table.insert(figures, newFigure)
end

function Figure.getTypeFromIndex(ind)
    local typeFromIndex =
    {
        [1] = "THE BEGGAR",
        [2] = "THE MONARCH",
        [3] = "THE WARRIOR",
        [4] = "THE THIEF",
        [5] = "THE SLAVE",
        [6] = "THE KNIGHT",
        [7] = "THE PRISONER",
        [8] = "THE POLITICIAN",
        [9] = "THE SPY",
        [10] = "THE VIKING",
        [11] = "THE ASSASSIN",
        [12] = "THE GENERAL",
        [13] = "THE MILLIONAIRE",
        [14] = "THE DICTATOR",
        [15] = "THE NINJA",
        [16] = "THE CEO",
        [17] = "THE SAMURAI",
        [18] = "THE EMPLOYEE",
        [19] = "THE CAPTAIN",
        [20] = "THE PIRATE",
        [21] = "THE STUDENT",
        [22] = "THE HITMAN",
        [23] = "THE POLICEMAN",
        [24] = "THE STRAWHAT",
        [25] = "THE GENIUS",
        [26] = "THE CAPO",
        [27] = "THE SENSEI",
        [28] = "THE SHERIFF",
        [29] = "THE COWBOY",
        [30] = "THE MARTIAL ARTIST",
        [31] = "THE SCAMMER",
        [32] = "THE WIZARD",
        [33] = "THE SCIENTIST",
        [34] = "THE VILLAIN",
        [35] = "THE ASTROLOGER",
        [36] = "THE SHINOBI",
        [37] = "THE SUPERHERO",
        [38] = "THE MONK",
        [39] = "THE ENGINEER",
        [40] = "THE ASTRONAUT",
        [41] = "THE VIGILANTE",
        [42] = "THE PHILANTROPIST",
        [43] = "THE ROBOT",
        [44] = "THE BOUNTY HUNTER",
        [45] = "THE DEMIGOD",
        [46] = "THE SENTINEL",
        [47] = "THE CYBORG",
        [48] = "THE EMPEROR",
        [49] = "THE ALIEN",
        [50] = "THE STEEL MAN",
        [51] = "THE LEGEND",
    }

    return typeFromIndex[ind]
end

function Figure.getIndexFromType(type, maxTypes)
    indexFromType = 
    {
        ["THE BEGGAR"]= 1,
        ["THE MONARCH"]= 2,
        ["THE WARRIOR"]= 3,
        ["THE THIEF"] = 4,
        ["THE SLAVE"] = 5,
        ["THE KNIGHT"] = 6,
        ["THE PRISONER"] = 7,
        ["THE POLITICIAN"] = 8,
        ["THE SPY"] = 9,
        ["THE VIKING"] = 10,
        ["THE ASSASSIN"] = 11,
        ["THE GENERAL"] = 12,
        ["THE MILLIONAIRE"] = 13,
        ["THE DICTATOR"] = 14,
        ["THE NINJA"] = 15,
        ["THE CEO"] = 16,
        ["THE SAMURAI"] = 17,
        ["THE EMPLOYEE"] = 18,
        ["THE CAPTAIN"] = 19,
        ["THE PIRATE"] = 20,
        ["THE STUDENT"] = 21,
        ["THE HITMAN"] = 22,
        ["THE POLICEMAN"] = 23,
        ["THE STRAWHAT"] = 24,
        ["THE GENIUS"] = 25,
        ["THE CAPO"] = 26,
        ["THE SENSEI"] = 27,
        ["THE SHERIFF"] = 28,
        ["THE COWBOY"] = 29,
        ["THE MARTIAL ARTIST"] = 30,
        ["THE SCAMMER"] = 31,
        ["THE WIZARD"] = 32,
        ["THE SCIENTIST"] = 33,
        ["THE VILLAIN"] = 34,
        ["THE ASTROLOGER"] = 35,
        ["THE SHINOBI"] = 36,
        ["THE SUPERHERO"] = 37,
        ["THE MONK"] = 38,
        ["THE ENGINEER"] = 39,
        ["THE ASTRONAUT"] = 40,
        ["THE VIGILANTE"] = 41,
        ["THE PHILANTROPIST"] = 42,
        ["THE ROBOT"] = 43,
        ["THE BOUNTY HUNTER"] = 44,
        ["THE DEMIGOD"] = 45,
        ["THE SENTINEL"] = 46,
        ["THE CYBORG"] = 47,
        ["THE EMPEROR"] = 48,
        ["THE ALIEN"] = 49,
        ["THE STEEL MAN"] = 50,
        ["THE LEGEND"] = 51,
    }

    return indexFromType[type]
end

function Figure.getMergeResult(figure1Type, figure2Type)
    resultType = "NONE"

    local possFigures = 
    {
        ["THE BEGGAR"]= false,
        ["THE MONARCH"]= false,
        ["THE WARRIOR"]= false,
        ["THE THIEF"] = false,
        ["THE SLAVE"] = false,
        ["THE KNIGHT"] = false,
        ["THE PRISONER"] = false,
        ["THE POLITICIAN"] = false,
        ["THE SPY"] = false,
        ["THE VIKING"] = false,
        ["THE ASSASSIN"] = false,
        ["THE GENERAL"] = false,
        ["THE MILLIONAIRE"] = false,
        ["THE DICTATOR"] = false,
        ["THE NINJA"] = false,
        ["THE CEO"] = false,
        ["THE SAMURAI"] = false,
        ["THE EMPLOYEE"] = false,
        ["THE CAPTAIN"] = false,
        ["THE PIRATE"] = false,
        ["THE STUDENT"] = false,
        ["THE HITMAN"] = false,
        ["THE POLICEMAN"] = false,
        ["THE STRAWHAT"] = false,
        ["THE GENIUS"] = false,
        ["THE CAPO"] = false,
        ["THE SENSEI"] = false,
        ["THE SHERIFF"] = false,
        ["THE MARTIAL ARTIST"] = false,
        ["THE COWBOY"] = false,
        ["THE SCAMMER"] = false,
        ["THE WIZARD"] = false,
        ["THE SCIENTIST"] = false,
        ["THE VILLAIN"] = false,
        ["THE ASTROLOGER"] = false,
        ["THE SHINOBI"] = false,
        ["THE SUPERHERO"] = false,
        ["THE MONK"] = false,
        ["THE ENGINEER"] = false,
        ["THE ASTRONAUT"] = false,
        ["THE VIGILANTE"] = false,
        ["THE PHILANTROPIST"] = false,
        ["THE ROBOT"] = false,
        ["THE BOUNTY HUNTER"] = false,
        ["THE DEMIGOD"] = false,
        ["THE SENTINEL"] = false,
        ["THE CYBORG"] = false,
        ["THE EMPEROR"] = false,
        ["THE ALIEN"] = false,
        ["THE STEEL MAN"] = false,
        ["THE LEGEND"] = false,

    }
    possFigures[figure1Type] = true
    possFigures[figure2Type] = true

    if (possFigures["THE BEGGAR"]) then

        if(possFigures["THE EMPLOYEE"])then
            resultType = "THE STUDENT"

        elseif (possFigures["THE WARRIOR"])then
            resultType = "THE THIEF"

        elseif (possFigures["THE MONARCH"]) then
            resultType = "THE SLAVE"
        end
    end

    if (possFigures["THE MONARCH"]) then
        
        if (possFigures["THE PIRATE"]) then
            resultType = "NAKAMA"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "THE GENIUS"
        elseif (possFigures["THE MILLIONAIRE"]) then
            resultType = "THE CEO"
            elseif (possFigures["THE THIEF"]) then
            resultType = "THE POLITICIAN"
            elseif (possFigures["THE BEGGAR"]) then
            resultType = "THE SLAVE"
            elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE KNIGHT"
            elseif (possFigures["THE KNIGHT"]) then
            resultType = "THE GENERAL"
        end
    end

    if (possFigures["THE WARRIOR"]) then

        if (possFigures["THE BEGGAR"]) then
            resultType = "THE THIEF"
        elseif (possFigures["THE SPY"]) then
            resultType = "THE ASSASSIN"
        elseif (possFigures["THE EMPLOYEE"]) then
            resultType = "THE POLICEMAN"
        elseif (possFigures["THE SCIENTIST"]) then
            resultType = "THE ENGINEER"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "THE MARTIAL ARTIST"
        elseif (possFigures["THE THIEF"]) then
            resultType = "THE VIKING"
        end
    end

    if(possFigures["THE THIEF"]) then
        
        if (possFigures["THE SHERIFF"]) then
            resultType = "THE COWBOY"
        elseif (possFigures["THE CAPTAIN"]) then
            resultType = "THE PIRATE"
        elseif (possFigures["THE GENIUS"]) then
            resultType = "THE SCAMMER"
            elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE VIKING"
            elseif (possFigures["THE POLITICIAN"]) then
            resultType = "THE MILLIONAIRE"
            elseif (possFigures["THE SLAVE"]) then
            resultType = "THE PRISONER"
            elseif (possFigures["THE MONARCH"]) then
            resultType = "THE POLITICIAN"
            elseif(possFigures["THE GENERAL"]) then
            resultType = "THE SPY"
        end
    end

    if(possFigures["THE SLAVE"]) then
        
        if (possFigures["THE CEO"]) then
            resultType = "THE EMPLOYEE"
        elseif (possFigures["THE THIEF"]) then
            resultType = "THE PRISONER"
        end
    end

    if(possFigures["THE KNIGHT"]) then
        
        if (possFigures["THE NINJA"]) then
            resultType = "THE SAMURAI"
        elseif (possFigures["THE WIZARD"]) then
            resultType = "THE SUPERHERO"
        elseif (possFigures["THE MONARCH"]) then
            resultType = "THE GENERAL"
        end
    end

    if(possFigures["THE POLITICIAN"]) then
        
        if (possFigures["THE THIEF"]) then
            resultType = "THE MILLIONAIRE"
        elseif (possFigures["THE GENERAL"]) then
            resultType = "THE DICTATOR"
        end
    end

    if(possFigures["THE SPY"]) then
        
        if (possFigures["THE ASSASSIN"]) then
            resultType = "THE NINJA"
        elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE ASSASSIN"
        end
    end

    if(possFigures["THE VIKING"]) then
        
        if (possFigures["THE SUPERHERO"]) then
            resultType = "THE DEMIGOD"
        elseif (possFigures["THE GENERAL"]) then
            resultType = "THE CAPTAIN"
        end
    end

    if(possFigures["THE ASSASSIN"]) then
        
        if (possFigures["THE EMPLOYEE"]) then
            resultType = "THE HITMAN"
        elseif (possFigures["THE SPY"]) then
            resultType = "THE NINJA"
        elseif (possFigures["THE POLICEMAN"]) then
            resultType = "THE SHERIFF"
        end
    end

    if(possFigures["THE GENERAL"]) then
        
        if (possFigures["THE POLITICIAN"]) then
            resultType = "THE DICTATOR"
        elseif (possFigures["THE VIKING"]) then
            resultType = "THE CAPTAIN"
        elseif (possFigures["THE SCIENTIST"]) then
            resultType = "THE ENGINEER"
        end
    end

    if(possFigures["THE MILLIONAIRE"]) then
        
        if (possFigures["THE MONARCH"]) then
            resultType = "THE CEO"
        elseif (possFigures["THE SUPERHERO"]) then
            resultType = "THE VIGILANTE"
        end
    end

    if(possFigures["THE DICTATOR"]) then
        
        if (possFigures["THE ASTRONAUT"]) then
            resultType = "THE EMPEROR"
        end
    end

    if(possFigures["THE NINJA"]) then
        
        if (possFigures["THE WIZARD"]) then
            resultType = "THE SHINOBI"
        elseif (possFigures["THE ROBOT"]) then
            resultType = "THE CYBORG"
        end
    end

    if(possFigures["THE CEO"]) then
        
        if (possFigures["THE SLAVE"]) then
            resultType = "THE EMPLOYEE"
        elseif (possFigures["THE HITMAN"]) then
            resultType = "THE CAPO"
        end
    end

    if(possFigures["THE SAMURAI"]) then
        
        if (possFigures["THE STUDENT"]) then
            resultType = "THE SENSEI"
        end
    end

    if(possFigures["THE EMPLOYEE"]) then
        
        if (possFigures["THE BEGGAR"]) then
            resultType = "THE STUDENT"
        elseif (possFigures["THE GENIUS"]) then
            resultType = "THE SCIENTIST"
        elseif (possFigures["THE ASSASSIN"]) then
            resultType = "THE HITMAN"
        elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE POLICEMAN"
        end
    end

    if(possFigures["THE CAPTAIN"]) then
        
        if (possFigures["THE THIEF"]) then
            resultType = "THE PIRATE"
        end
    end

    if(possFigures["THE PIRATE"]) then
        
        if (possFigures["THE MONARCH"]) then
            resultType = "THE STRAWHAT"
        end
    end

    if(possFigures["THE STUDENT"]) then
        
        if (possFigures["THE MONARCH"]) then
            resultType = "THE GENIUS"
        elseif (possFigures["THE GENIUS"]) then
            resultType = "THE WIZARD"
        elseif (possFigures["THE SAMURAI"]) then
            resultType = "THE SENSEI"
        elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE MARTIAL ARTIST"
        end
    end

    if(possFigures["THE HITMAN"]) then
        
        if (possFigures["THE CEO"]) then
            resultType = "THE CAPO"
        end
    end

    if(possFigures["THE POLICEMAN"]) then
        
        if (possFigures["THE ASSASSIN"]) then
            resultType = "THE SHERIFF"
        elseif (possFigures["THE ROBOT"]) then
            resultType = "THE SENTINEL"
        end
    end

    if (possFigures["THE GENIUS"]) then

        if (possFigures["THE THIEF"]) then
            resultType = "THE SCAMMER"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "THE WIZARD"
        elseif (possFigures["THE EMPLOYEE"]) then
            resultType = "THE SCIENTIST"
        elseif (possFigures["THE DICTATOR"]) then
            resultType = "THE VILLAIN"
        elseif (possFigures["THE ENGINEER"]) then
            resultType = "THE ROBOT"
        end
    end

    if(possFigures["THE MARTIAL ARTIST"]) then
        
        if (possFigures["THE WIZARD"]) then
            resultType = "THE MONK"
        end
    end
    
    if(possFigures["THE SCAMMER"]) then
        
        if (possFigures["THE WIZARD"]) then
            resultType = "THE ASTROLOGER"
        end
    end

     if(possFigures["THE WIZARD"]) then
        
        if (possFigures["THE SCAMMER"]) then
            resultType = "THE ASTROLOGER"
        elseif (possFigures["THE NINJA"]) then
            resultType = "THE SHINOBI"
        elseif (possFigures["THE KNIGHT"]) then
            resultType = "THE SUPERHERO"
        elseif (possFigures["THE MARTIAL ARTIST"]) then
            resultType = "THE MONK"
        end
    end

    if(possFigures["THE SCIENTIST"]) then
        
        if (possFigures["THE GENERAL"]) then
            resultType = "THE ENGINEER"
        end
    end

    if(possFigures["THE VILLAIN"]) then
        
        if (possFigures["THE ASTRONAUT"]) then
            resultType = "THE ALIEN"
        end
    end

    if(possFigures["THE COWBOY"]) then
        
        if (possFigures["THE ASTRONAUT"]) then
            resultType = "THE BOUNTY HUNTER"
        end
    end

    if(possFigures["THE ASTROLOGER"]) then
        
        if (possFigures["THE ENGINEER"]) then
            resultType = "THE ASTRONAUT"
        end
    end

    if(possFigures["THE SUPERHERO"]) then
        
        if (possFigures["THE VIKING"]) then
            resultType = "THE DEMIGOD"
        elseif (possFigures["THE MILLIONAIRE"]) then
            resultType = "THE VIGILANTE"
        elseif (possFigures["THE ALIEN"]) then
            resultType = "THE STEEL MAN"
        elseif (possFigures["THE ENGINEER"]) then
            resultType = "THE PHILANTROPIST"
        end
    end

    if(possFigures["THE MONK"]) then
        
        if (possFigures["THE ALIEN"]) then
            resultType = "THE LEGEND"
        end
    end


    if(possFigures["THE GENERAL"]) then
        
        if (possFigures["THE POLITICIAN"]) then
            resultType = "THE DICTATOR"
        elseif (possFigures["THE VIKING"]) then
            resultType = "THE CAPTAIN"
        elseif (possFigures["THE SCIENTIST"]) then
            resultType = "THE ENGINEER"
        end
    end

    if(possFigures["THE ASTRONAUT"]) then
        
        if (possFigures["THE DICTATOR"]) then
            resultType = "THE EMPEROR"
        elseif (possFigures["THE COWBOY"]) then
            resultType = "THE BOUNTY HUNTER"
        elseif (possFigures["THE VILLAIN"]) then
            resultType = "THE ALIEN"
        end
    end

    if(possFigures["THE ALIEN"]) then
        
        if (possFigures["THE SUPERHERO"]) then
            resultType = "THE STEEL MAN"
        elseif (possFigures["THE MONK"]) then
            resultType = "THE LEGEND"
        end
    end

        return resultType
end

return Figure