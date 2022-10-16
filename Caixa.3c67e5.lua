

-- Declarações de variáveis:
---------------------------------------------------
--Objetos de conjunto
---------------------------------------------------

--Variável que vai conter os objetos zonas, declarado como array inicialmente
local zones = {}
--Array com as GUIDs
local zonesGUIDs = {
	BA2 	= 'bf5469',
    BA1 	= '8b5193',
    SE 		= '6e0092',
    AL 		= 'b9b23a',
    PE 		= '24c139',
    PA 		= '9ca947',
    RN 		= '13c069',
    CES 	= '4e18dc',
	CEN		= '87774b',
	event 	= '17d7e0',
	moedas 	= '1188bb',
	agua 	= '9b64d7',
	deckEspolio = '6e0314',
	descarteEspolio = '83d71c'
}

local decks = {}
local decksGUIDs = {
	subchefe	= '060c8c',
	loja1 		= '62af7f',
	evento1 	= '3ab7a1',
	evento2 	= 'b3ebdd',
	localInicial = '3526fb'
}

local bags = {}
local bagsGUIDs = {
    vila 		= '13a192',
    fazenda 	= 'f50a97',
    cidade 		= 'fa9358',
	agua 		= 'a75ad3',
	localidades = '88cf32',
	bag1 		= '461624',
encomendasIniciais = 'af78f8'
}


local msg = {
	welcome			= 'Escolha uma cor antes do Setup!',
	corInvalida 	= 'Escolha cores válidas!',
	choose			= 'Escolha um chefe do Bando',
	noTile			= 'Sem tile',
	finalRodada		= "Seca e Pontuação no fim da rodada!",
	res 			= 'Preenchida Resistência',
	endGame 		= 'Fim de Jogo',
	zMoedas 		= "Zero Moedas.",
}

local gavetas = {}
local gavetasGUIDs = {
	g1 = '390971',
	g2 = 'b1ab11',
	g3 = 'e2b080',
	g4 = '2fa11f',
	g5 = '3dcbdd',
	g6 = '7d257b'
}

local markers = {}
local markersGUIDs = {
	Blue	= '54d589',
	Red		= '946c24',
	Green 	= 'b65230',
	Yellow 	= '2fc5c8',
	Purple 	= 'f685b7'
}

local blockers = {}
local blockersGUIDs = {
	white2p = '56dea2',
	white3p = '20d747',
	swhite2p1 = '8a609d',
	swhite2p2 = 'c598ce',
	swhite3p1 = '545db8',
	swhite3p2 = '2fb904',
	blue2p = '87111c',
	blue3p = 'd67814',
	yellow2p = '359d01',
	yellow3p = 'dc14ea',
	RN = '0aa8b4',
	CES = '206383',
	CEN = 'd3560d',
	half = '442d58'
}

local blockerpos = {
	white = {-5.82, 1.05, 4.73},
	swhite1 = {-14.36, 1.05, 1.17}, 
	swhite2 = {-12.14, 1.05, -3.25},
	swhite11 = {-11.30, 1.05, -1.83},
	swhite21 = {-13.62, 1.05, 2.49},
	blue = {-11.10, 1.00, 3.92},
	blue2 = {-10.38, 1.00, 5.11},
	yellow = {-9.52, 1.00, 0.31},
	yellow2 = {-8.85, 1.00, 1.42},
	RN = {15.32, 1.05, 10.60},
	CES = {4.19, 1.05, 5.92},
	CEN = {3.63, 1.05, 11.90},
	half = {-1.72, 1.05, 8.39}
}



---------------------------------------------------
--Objetos soltos
---------------------------------------------------
local mainBoard
local mainBoardGUID = 'e2cef1'
local turnMarkerGUID = '91edf3'

-- muitos objetos pra fazer a mesma coisa. Vale um for, até pra caso apareça um objeto futuro com a memsa condição
local snaps ={
	BA2 = {
		position = {x=-0.52, y=2.0, z=-2.60},
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	},
	BA1 = {
		position = {x=4.78, y=2.0, z=-5.37}, -- {4.78, 0.95, -5.12}
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	},
	SE = {
		position = {x=13.10, y=2.0, z=-7.56}, -- {12.75, 0.95, -7.60}
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	},
	AL = {
		position = {x=16.40, y=2.0, z=-3.33}, -- {16.20, 0.95, -3.26}
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	},
	PE = {
		position = {x=9.45, y=2.0, z=1.07}, -- {9.76, 0.95, 1.38}
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	},
	PA = {
		position = {x=13.1, y=2.0, z=5.70}, -- {13.03, 0.95, 5.76}
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	},
	RN = {
		position = {x=15.3, y=2.0, z=10.64}, --{16.23, 0.95, 10.74}
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	},
	CES = {
		position = {x=4.14, y=2.0, z=5.91}, -- {13.03, 0.95, 5.76}
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	},
	CEN = {
		position = {x=3.63, y=2.0, z=11.93}, --{3.53, 0.95, 12.22}
		rotation = {x=0, y=180, z=0},
		callback_function = function(obj) take_callback(obj) end,
	}
}

local pinosPos = {
	Blue = {24.80, 1.11, -13.55},
	Yellow = {-10.92, -0.63, -38.12},
	Red = {-46.83, 1.11, -13.88},
	Green = {-46.90, 1.11, 11.67},
	Purple = {24.71, 1.11, 14.20}
}

local colorGaveta = {
	Blue	= 'g1',
	Yellow	= 'g2',
	Red		= 'g3',
	Green	= 'g4',
	Purple	= 'g6'
}

local params_endround = {
	click_function = "click_func_endround",
	function_owner = self,
	label          = "Fim da Rodada",
	position       = {0, 1, 2.3},
	rotation       = {0, 0, 0},
	width          = 1800,
	height         = 400,
	font_size      = 250,
	color          = {0.5, 0.5, 0.5},
	font_color     = {1, 1, 1},
	tooltip        = "Fim da rodada",
}

local params_setup = {
	click_function = "click_func_setup",
	function_owner = self,
	label          = "Setup",
	position       = {0, 1, 2.3},
	rotation       = {0, 0, 0},
	width          = 1800,
	height         = 400,
	font_size      = 250,
	color          = {0.5, 0.5, 0.5},
	font_color     = {1, 1, 1},
	tooltip        = "Setup",
}

local discardParams = {	position= {67.39, 3.70, 12.72}	} --{67.39, 1.66, 12.72}

local loja
loja = getObjectFromGUID("870670")

------------------------------------------
--funcoes
------------------------------------------
function onSave()
	local dataToSave = {}
	dataToSave.round_counter = round_counter

	savedData = JSON.encode(dataToSave)

	--Uncomment this line to reset the save data
	--savedData = ''
	return savedData
end

function onLoad(savedData)
	--Carrega dados salvos, caso haja algum
	if savedData != '' and  savedData != nil then
        local loadedData = JSON.decode(savedData)
        round_counter = loadedData.round_counter
    else
        round_counter = 1
    end

	--Carrega objetos internos
	loadZones()
	loadDecks()
	loadBags()
	loadGavetas()
	loadMarkers()
	loadOtherObjects()
	loadBlockers()

    broadcastToAll(msg.welcome)

    if round_counter == 1 then
        self.createButton(params_setup)
    else
        self.createButton(params_endround)
    end
end

function click_func_setup(obj, clickPlayerColor, alt_click)
    local inicioPontuacao = {position = {x=-14.18, y=1.0, z=-15.82}}  --{-13.15, 1.04, -15.82}
    espolioAberto1 ={position = zones.deckEspolio.getPosition(), rotation = {x=0, y=180, z=0}} 
	playerCount = #getSeatedPlayers()
	startLuaCoroutine(self,'setupEspolio')
	

	-----------------Randomiza Player ORDER ------------------------
	local function BBcolor(stringColor)
		local color = stringColorToRGB(stringColor)
		return '[' .. string.format("%02x%02x%02x", color[1]*255, color[2]*255, color[3]*255) .. ']'
	end

	order = 0
	orderturno =  0.95
	local seated = getSeatedPlayers()
	local shuffled = {}
	while #seated > 0 do
		local rand = math.random(1, #seated)
		table.insert(shuffled, table.remove(seated, rand))
	end
	local msg = '#'  .. Player[clickPlayerColor].steam_name .. ' (' .. Player[clickPlayerColor].color .. ') '
	msg = msg .. 'iniciou o jogo! Segue a ordem de turno: '
	for k,color in ipairs(shuffled) do
		
		if markers[color] != nil then
			markers[color].takeObject({position = {x=-14.25+order, y=1.0+order, z=-15.82}})
			markers[color].takeObject({position = {x=-16.2, y=1.0, z=-0.8-orderturno}})
		end
		
		msg = msg .. BBcolor(color) .. Player[color].steam_name .. ' (' .. color .. '), [-]'
		order = order + 1.12
		orderturno = orderturno + 0.87
	end
	msg = msg:sub(1, -6)
	broadcastToAll(msg, {1, 1, 1})

	
    --Setup jogador
    for _,playerColor in ipairs(getSeatedPlayers()) do
		if playerColor == 'Blue' or
			playerColor == 'Red' or
			playerColor == 'Green' or
			playerColor == 'Purple' then

			decks.subchefe.deal(2, playerColor)
			--decks.espolioInicial.deal(1, playerColor) -- trocar por espolio normal
			decks.localInicial.deal(1, playerColor)
			bags.encomendasIniciais.deal(1,playerColor)
			


		else
			broadcastToAll(msg.corInvalida)
		end
	end

    broadcastToAll(msg.choose)
	
    self.removeButton(0)
    self.createButton(params_endround)
	--volanteSetup()
	startLuaCoroutine(self, 'volanteSetup')
	checkRes()
	loja.call("click_func_atualizarLoja")
	
	--Mudanças a depender do player count
	
	
	if playerCount == 2 then
		blockers.white2p.setPositionSmooth(blockerpos.white)
		blockers.swhite3p1.setPositionSmooth(blockerpos.swhite1)
		blockers.swhite3p2.setPositionSmooth(blockerpos.swhite2)
		blockers.swhite2p1.setPositionSmooth(blockerpos.swhite11)
		blockers.swhite2p2.setPositionSmooth(blockerpos.swhite21)
		blockers.yellow3p.setPositionSmooth(blockerpos.yellow)
		blockers.blue3p.setPositionSmooth(blockerpos.blue)
		blockers.yellow2p.setPositionSmooth(blockerpos.yellow2)
		blockers.blue2p.setPositionSmooth(blockerpos.blue2)
		blockers.RN.setPositionSmooth(blockerpos.RN)
		blockers.CES.setPositionSmooth(blockerpos.CES)
		blockers.CEN.setPositionSmooth(blockerpos.CEN)
		blockers.half.setPositionSmooth(blockerpos.half)
		newWater()
		dinamica_moedas()
		setupEncomendas2p()
	end
	if playerCount == 3 then
		--blockers.white3p.setPositionSmooth(blockerpos.white)
		blockers.swhite3p1.setPositionSmooth(blockerpos.swhite1)
		blockers.swhite3p2.setPositionSmooth(blockerpos.swhite2)
		blockers.yellow3p.setPositionSmooth(blockerpos.yellow)
		blockers.blue3p.setPositionSmooth(blockerpos.blue)
		--blockers.RN.setPositionSmooth(blockerpos.RN)
		--blockers.CES.setPositionSmooth(blockerpos.CES)
		--blockers.CEN.setPositionSmooth(blockerpos.CEN)
		newWater()
		dinamica_moedas()
	end

end

function setupEncomendas2p()

	bag = getObjectFromGUID('70592f')

	for i,o in ipairs(bag.getObjects()) do
		if o.name == "not2p" then
			bag.takeObject({position= {67.39, 3.70, 12.72}, guid = o.guid})
		end
		
	end

end

function take_callback(object_spawned)
    object_spawned.setLock(false)
end

function volanteSetup()
	for i=1,5 do
		decks.evento1.takeObject(discardParams)
		decks.evento2.takeObject(discardParams)
	end

	decks.evento1.setPositionSmooth({15.22, 4.00, -13.02})
	decks.evento2.setPositionSmooth({15.22, 2.00, -13.02})

	while eventReady() == false do
		coroutine.yield(0)
	end

	drawEvento()
	return 1
	
end

function eventReady()
	for i, o in ipairs(zones.event.getObjects()) do
		if #o.getObjects() == 6 then
			return true
		end
	end
	return false
end

function evento ()
	local mergeParams = {x=19.09, y=3, z=-9.39} --
    decks.evento1.setPositionSmooth(mergeParams)
end


function drawEvento ()
    events = zones.event.getObjects()
		if round_counter == 1 then
			for i, o in ipairs(events) do
				lastevent = Global.call("getLastCardGUID", o)
			end
		end

    Event = {
        position = {15.22, 2.00, -13.02},
        rotation = {x=0, y=180, z=0}
    }

    for i, o in ipairs(events) do
		if round_counter == 2 then -- Faz nada no round 2, carta ja revelada no inicio do jogo
			return
		end
        if round_counter < 8 then
			if o.type == "Deck" then
				o.takeObject(Event)
			elseif o.guid == lastevent then
				o.setRotationSmooth({0, 180, 0})
			else
				o.setPositionSmooth({67.39, 3.70, 12.72}) --{67.39, 1.66, 12.72} {34.88, 3.70, 12.58}
			end
        end
    end
end

function newWater()
	local aguas = zones.agua.getObjects()
	takeParams1 = {
		position = {-15.20, 1.07, 2.57}, --{-15.03, 1.07, 0.87}
	}
	takeParams2 = {
		position = {-13.52, 1.07, 2.57}, --{-15.99, 1.07, 2.49}
	}
	takeParams3 = {
		position = {-14.35, 1.07, 1.16}, -- {-14.09, 1.07, 2.47}
	}

	--Preencher águas
	for i, o in ipairs(aguas) do
		if not o.hasTag("blocker") then
			destroyObject(o)
		end
	end

	bags.agua.takeObject(takeParams1)
	if playerCount > 2 then
		bags.agua.takeObject(takeParams2)
	end
	if playerCount > 3 then
		bags.agua.takeObject(takeParams3)
	end
end

function click_func_endround(obj, color, alt_click)

	local moedas = zones.moedas.getObjects()
	local aguas = zones.agua.getObjects()
	takeParams1 = {
		position = {-15.20, 1.07, 2.57}, --{-15.03, 1.07, 0.87}
	}
	takeParams2 = {
		position = {-13.52, 1.07, 2.57}, --{-15.99, 1.07, 2.49}
	}
	takeParams3 = {
		position = {-14.35, 1.07, 1.16}, -- {-14.09, 1.07, 2.47}
	}

	
	group(moedas)

  	Wait.time(dinamica_moedas, 1)


	newWater()

    turns()
    round_counter = round_counter + 1
	if round_counter < 9 then
		print("Rodada ", round_counter)	
	end
	
	if round_counter == 3 or round_counter == 6 or round_counter == 8 then
		broadcastToAll(msg.finalRodada)
	end

	
	local hits = castForObjects({source="5ad9c6", position={0.3, 0, -0.4}, size={x= 1.3, y= 1, z =1.1}})
	for i,o in ipairs(hits) do
		if o.getName() == "pinoAzul" then
			o.setPositionSmooth(pinosPos.Blue)
			pinosPos.Blue[3] = pinosPos.Blue[3] + 0.8 
		end
		if o.getName() == "pinoAmarelo" then
			o.setPositionSmooth(pinosPos.Yellow)
			pinosPos.Yellow[3] = pinosPos.Yellow[3] + 0.8
		end
		if o.getName() == "pinoVermelho" then
			o.setPositionSmooth(pinosPos.Red)
			pinosPos.Red[3] = pinosPos.Red[3] + 0.8
		end
		if o.getName() == "pinoVerde" then
			o.setPositionSmooth(pinosPos.Green)
			pinosPos.Green[3] = pinosPos.Green[3] + 0.8
		end
		if o.getName() == "pinoRoxo" then
			o.setPositionSmooth(pinosPos.Purple)
			pinosPos.Purple[3] = pinosPos.Purple[3] + 0.8
		end
	end

	obj = getObjectFromGUID('870670')
	if round_counter ~= 6 then
		obj.call('slideLoja')
		obj.call('slideEspolio')
	end
	-- atualizar espolio

	startLuaCoroutine(self,'atualEspolio') --MANTIDO FORA PELO DESIGNER
end

function setupEspolio()
	local preEspolio = {
		getObjectFromGUID("0fda6e"),
		getObjectFromGUID("79c47b"),
		getObjectFromGUID("2b3088"),
		getObjectFromGUID("41872d")
	}

	
	local h=0.5

	if playerCount == 3 then
		for i, deck in pairs (preEspolio) do
			deck.takeObject({position={-72.89, 2.5+h, 2.25}})
			h=h+0.5
		end
		
	end

	if playerCount == 2 then

		for i, deck in pairs (preEspolio) do
			deck.takeObject({position={-72.89, 2.5+h, 2.25}})
			h=h+0.5
		end
		for i, deck in pairs (preEspolio) do
			deck.takeObject({position={-72.89, 2.5+h, 2.25}})
			h=h+0.5
		end
		
	end

	deckEspolioGroup = group(preEspolio)
	coroutine.yield(0)
		while deckEspolio ~= nil and deckEspolio.resting == false do
			coroutine.yield(0)
		end

	for i, o in pairs (deckEspolioGroup) do	
		deckEspolio = getObjectFromGUID(o.guid)
	end	
	
	deckEspolio.shuffle()
	deckEspolio.setRotation({180,0,0})
	deckEspolio.setPositionSmooth(zones.deckEspolio.getPosition())
	coroutine.yield(0)
		while deckEspolio ~= nil and deckEspolio.resting == false do
			coroutine.yield(0)
		end
	--COMECA aqui
	
	for _,playerColor in ipairs(getSeatedPlayers()) do
		if playerColor == 'Blue' or
			playerColor == 'Red' or
			playerColor == 'Green' or
			playerColor == 'Purple' then

				deckEspolio.deal(1, playerColor)
		else
			broadcastToAll(msg.corInvalida)
		end
	end
	 -- AQUI
	return 1

end



function turns ()
    local turn_marker = getObjectFromGUID(turnMarkerGUID)
	local dx = {1.545, 1.545, 1.755, 1.65, 1.85, 1.85, 1.65}
	local objects
	local takeParamsres

	if round_counter == 1 then
		local pos = turn_marker.getPosition()
        pos.x = pos.x + dx[round_counter]
        turn_marker.setPositionSmooth(pos)
        --Evento ja aberto no setup

	elseif round_counter >1 and round_counter ~=5 and round_counter < 8 then
        local pos = turn_marker.getPosition()
        pos.x = pos.x + dx[round_counter]
        turn_marker.setPositionSmooth(pos)
        drawEvento()

    elseif round_counter == 5 then
        local pos = turn_marker.getPosition()
        pos.x = pos.x + dx[round_counter]
        turn_marker.setPositionSmooth(pos)
        --Evento fim da rodada 5  - 
				
        broadcastToAll(msg.res)
        drawEvento()
		faseLoja()
    elseif round_counter >= 7 then
        broadcastToAll(msg.endGame)
		self.removeButton(0)
    end
	checkRes()

end

function checkRes()
	if playerCount >= 3 or playerCount == 1 then
		for i, o in pairs (zones) do
			if i == 'BA2' or i== 'SE' or i == 'PA' or i == 'CEN' then
				objects = o.getObjects()
				if #objects == 1 then
					bags.vila.takeObject(snaps[i])
				end
			elseif i == 'CES' or i== 'BA1' or i == 'AL' then
				objects = o.getObjects()
				if #objects == 1 then
					bags.fazenda.takeObject(snaps[i])
				end
			elseif i == 'RN' or i== 'PE' then
				objects = o.getObjects()
				if #objects == 1 then
					bags.cidade.takeObject(snaps[i])
				end
			end
		end
	else
		for i, o in pairs (zones) do
			if i == 'BA2' or i== 'SE' or i == 'PA'  then
				objects = o.getObjects()
				if #objects == 1 then
					bags.vila.takeObject(snaps[i])
				end
			elseif i== 'BA1' or i == 'AL' then
				objects = o.getObjects()
				if #objects == 1 then
					bags.fazenda.takeObject(snaps[i])
				end
			elseif i== 'PE' then
				objects = o.getObjects()
				if #objects == 1 then
					bags.cidade.takeObject(snaps[i])
				end
			end
		end
	end
	
end


function takeFromBag1(number)
	params1 = {
        position = {-13.00, 0.95, -1.98}, --{-12.91, 0.95, -3.51}
    }
    params2 = {
        position = {-11.21, 0.95, -1.91}, --{-13.68, 0.95, -1.79}
    }
    params3 = {
        position = {-12.13, 0.95, -3.30}, --{-11.83, 0.95, -1.93}
    }

	if number >= 1 then
		bags.bag1.takeObject(params1)
	end
	if number >= 2 then
		bags.bag1.takeObject(params2)
	end
	if number >= 3 then
		bags.bag1.takeObject(params3)
	end
end

function dinamica_moedas ()
  local pilhas = zones.moedas.getObjects()
	local GUID, dinero, tamanho, resto
	

	-- MUDANÇAS BASEADAS EM PLAYERS
	if playerCount == 2 then
		
		local allParams = 1
		local twoParams = 1
		local oneParams = 1
		if #pilhas == 0 then
		
			--Caso zero moedas
			print(msg.zMoedas)
			takeFromBag1(allParams)
		else
			--If it isn't empty, we use a for loop to look at each entry in the list
			for _, object in ipairs(pilhas) do
				if not object.hasTag("blocker") then
					GUID = object.getGUID()
					dinero = getObjectFromGUID(GUID)
					tamanho = dinero.getQuantity() 
					resto = tamanho%1
					destroyObject(dinero)
				end
			end
	 
				if tamanho < 4 then
					  takeFromBag1(allParams)
				 else
					for i=1, tamanho/1 do
						takeFromBag1(allParams)
	 				end
					
				end
	 
	   end
	   --Se 3 players ou menos excluir espaço 3 
	elseif playerCount == 3 then
		local allParams = 2
		local twoParams = 2
		local oneParams = 1
		if #pilhas == 0 then
		
			--Caso zero moedas
			print(msg.zMoedas)
			takeFromBag1(allParams)
		else
			--If it isn't empty, we use a for loop to look at each entry in the list
			for _, object in ipairs(pilhas) do
				if not object.hasTag("blocker") then
					GUID = object.getGUID()
					dinero = getObjectFromGUID(GUID)
					tamanho = dinero.getQuantity() 
					resto = tamanho%2
					destroyObject(dinero)
				end
			end
	 
				if tamanho < 3 then
					takeFromBag1(allParams)
				else
					for i=1, tamanho/2 do
						takeFromBag1(allParams)
	 				end
					if resto == 1 then
						takeFromBag1(oneParams)
					end
				end
	 
	   end
	else
		local allParams = 3
		local twoParams = 2
		local oneParams = 1
		if #pilhas == 0 then
		
			--Caso zero moedas
			print(msg.zMoedas)
			takeFromBag1(allParams)
		else
			--If it isn't empty, we use a for loop to look at each entry in the list
			for _, object in ipairs(pilhas) do
				if not object.hasTag("blocker") then
					GUID = object.getGUID()
					dinero = getObjectFromGUID(GUID)
					tamanho = dinero.getQuantity() 
					resto = tamanho%3
					destroyObject(dinero)
				end
			end
	 
				if tamanho < 4 then
					  takeFromBag1(allParams)
				 else
					for i=1, tamanho/3 do
						takeFromBag1(allParams)
	 
					end
					if resto == 1 then
						takeFromBag1(oneParams)
					elseif resto == 2 then
						takeFromBag1(twoParams)
					end
				end
	 
	   end


	end



end

function faseLoja()
	startLuaCoroutine(self, 'faseLojaCoroutine')
end

function faseLojaCoroutine()
	zonaDeckloja = getObjectFromGUID('640fbb')
	loja1 = getObjectFromGUID('5d59d0')
	loja2 = getObjectFromGUID('918a00')
	loja3 = getObjectFromGUID('b7f839')
	
	for i, o in pairs (zonaDeckloja.getObjects()) do
		if o.tag == "Deck" then
			oldDeck = o
		end
	end
	zonaDeckloja2 = getObjectFromGUID('411228')
	for i, o in pairs (zonaDeckloja2.getObjects()) do
		if o.tag == "Deck" then
			newDeck = o
		end
	end
	buttonLoja = getObjectFromGUID('870670')
	zonaDescarte = getObjectFromGUID('ecbdaa')

	if newDeck != null then
		oldDeck.flip()
		oldDeck.setPositionSmooth({-22.52, 0.76, -10.51})
		newDeck.setPositionSmooth({-22.61, 0.83, -5.27} ) --{-15.67, 1.03, -7.52}
	end
	
	for i, o in pairs (loja1.getObjects()) do
		o.setPositionSmooth({-22.52, 0.76, -10.51})
	end
	for i, o in pairs (loja2.getObjects()) do
		o.setPositionSmooth({-22.52, 0.76, -10.51})
	end
	for i, o in pairs (loja3.getObjects()) do
		o.setPositionSmooth({-22.52, 0.76, -10.51})
		coroutine.yield(0)
		while o ~= nil and o.resting == false do
			coroutine.yield(0)
		end
	end
		
	atualizarLoja()
	return 1
end

function onObjectEnterScriptingZone(zone, obj)
    if zone == getObjectFromGUID('1188bb') then
      if obj.getName() == "$2" then
      	local pos = obj.getPosition()
				obj.destruct()
				bags.bag1.takeObject({position = pos})
				pos[2] = pos[2] + 1
				bags.bag1.takeObject({position = pos})
			elseif obj.getName() == "$5" then
				local pos = obj.getPosition()
				obj.destruct()
				bags.bag1.takeObject({position = pos})
				for i = 1, 4 do
					pos[2] = pos[2] + 0.5
					bags.bag1.takeObject({position = pos})
				end

      end
    end
end

function atualizarLoja()
	buttonLoja = getObjectFromGUID('870670')
	buttonLoja.call("click_func_atualizarLoja")
end

function getEspolio()
	local zona = zones.deckEspolio
    for i, o in pairs (zona.getObjects()) do
        return o
    end

    return nil
end

function RandomOrder(_, clickPlayerColor)
	local function BBcolor(stringColor)
		local color = stringColorToRGB(stringColor)
		return '[' .. string.format("%02x%02x%02x", color[1]*255, color[2]*255, color[3]*255) .. ']'
	end

	clickCount = clickCount or 1
	local seated = getSeatedPlayers()
	local shuffled = {}
	while #seated > 0 do
		local rand = math.random(1, #seated)
		table.insert(shuffled, table.remove(seated, rand))
	end
	local msg = '(#' .. clickCount .. ') ' .. Player[clickPlayerColor].steam_name .. ' (' .. Player[clickPlayerColor].color .. ') '
	msg = msg .. 'determines the random player order to be: '
	for k,color in ipairs(shuffled) do
		msg = msg .. BBcolor(color) .. Player[color].steam_name .. ' (' .. color .. '), [-]'
	end
	msg = msg:sub(1, -6)
	broadcastToAll(msg, {1, 1, 1})

	clickCount = clickCount + 1
	

    
end

---------------------------------------------
--funcoes de load
---------------------------------------------
function loadZones()
	for i, g in pairs(zonesGUIDs) do --g de Guid
		zones[i] = getObjectFromGUID(g)
	end
	--facilita a isnerção de mais zonas no futuro! =)
end

function loadDecks() --copy paste de zonas
	for i, g in pairs(decksGUIDs) do --g de Guid
		decks[i] = getObjectFromGUID(g)
	end
end

function loadBags() --copy paste de zonas
	for i, g in pairs(bagsGUIDs) do --g de Guid
		bags[i] = getObjectFromGUID(g)
	end
end

function loadGavetas() --copy paste de zonas
	for i, g in pairs(gavetasGUIDs) do --g de Guid
		gavetas[i] = getObjectFromGUID(g)
	end
end

function loadMarkers() --copy paste de zonas
	for i, g in pairs(markersGUIDs) do --g de Guid
		markers[i] = getObjectFromGUID(g)
	end
end

function loadBlockers() --copy paste de zonas
	for i, g in pairs(blockersGUIDs) do --g de Guid
		blockers[i] = getObjectFromGUID(g)
	end
end


--Qualquer outro tipo de objeto que não se encaixe num conjunto
function loadOtherObjects()
	mainBoard = getObjectFromGUID(mainBoardGUID)
end


-- Cast functions 
function condenseHits(hits)
	local out = {}
	for key, value in pairs(hits) do
	  table.insert(out, value.hit_object)
	end
	return out
  end
  
  function castForObjects(parameters)
	  local source = parameters.source
	if type(source) == "string" then source = getObjectFromGUID(source) end
	if not source then
	  print("Object does not exist.")
	  return nil
	end
	  local position = source.positionToWorld(parameters.position)
	local size = parameters.size
	local scale = source.getScale()
	size = {size.x * scale.x, size.y * scale.y, size.z * scale.z}
	  local hits = Physics.cast({origin=position,
		  size=size, direction=source.GetTransformUp(), type=3,
		  max_distance=0, orientation=source.getRotation()})
	  return condenseHits(hits)
  end