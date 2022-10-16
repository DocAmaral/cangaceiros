-- Colocar as zonas no Global, já que são usadas em diversos arquivos
--Testing git

local deckLoja
local lastCard
local lastEspolio
local lastCardGUID
local lastEspolioGUID


function onLoad()
  ----------------------------------
  --Variables
  ----------------------------------

  flip = {x=0, y=180, z=0}

  local timer
  local params_loja = {
  	click_function = "click_func_atualizarLoja",
  	function_owner = self,
  	label          = "Atualizar Loja",
  	position       = {-0.5, 1, 1.0},
  	rotation       = {0, 0, 0},
  	width          = 2500,
  	height         = 500,
  	font_size      = 350,
  	color          = {0.5, 0.5, 0.5},
  	font_color     = {1, 1, 1},
  	tooltip        = "Atualizar Loja",
  }

  zonaLoja = {
      getObjectFromGUID('640fbb'),
      getObjectFromGUID('5d59d0'),
      getObjectFromGUID('918a00'),
      getObjectFromGUID('b7f839'),
      getObjectFromGUID('ed021a')
  }

  zonaEspolio = {
	getObjectFromGUID('6e0314'),
    getObjectFromGUID('c3380f'),
    getObjectFromGUID('957a05'),
    getObjectFromGUID('d9898c'),
 }

  lojaSnap ={
      {
          position = {x=-22.61, y=1, z=-5.27}, --{-22.61, 0.80, -5.27}
          rotation = {x=0, y=180, z=0},
      },
      {
          position = {x=-15.67 , y=1, z=-8.26}, --{-15.67, 0.96, -8.26}
          rotation = {x=0, y=180, z=0},
      },
      {
          position = {x=-12.46, y=1, z=-8.26}, --{-12.46, 0.96, -8.26}
          rotation = {x=0, y=180, z=0},
      },

      {
          position = {x=-9.27, y=1, z=-8.26}, --{-9.27, 0.96, -8.26}
          rotation = {x=0, y=180, z=0},
      },
      {
          position = {x=-6.05, y=1, z=-8.26}, --{-6.05, 0.96, -8.26}
		  rotation = {x=0, y=180, z=0}
      }
  }

  espolioSnap ={
	{
		position = {x=-17.58, y=1.42, z=-20.04}, 
		rotation = {x=0, y=180, z=0},
	},
	{
		position = {x=-15.89, y=1, z=-12.96}, 
		rotation = {x=0, y=180, z=0},
	},
	{
		position = {x=-13.34, y=1, z=-12.96},
		rotation = {x=0, y=180, z=0},
	},
	{
		position = {x=-10.79, y=1, z=-12.96},
		rotation = {x=0, y=180, z=0},
	}
	
}

  posLoja = {
	{x=-22.61, y=1, z=-5.27}, --{-22.61, 0.83, -5.27}
    {x=-15.67 , y=1, z=-8.26},
    {x=-12.46, y=1, z=-8.26},
    {x=-9.27, y=1, z=-8.26},
    {x=-6.05, y=1, z=-8.26}
  }

  posEspolio = {
	{x=-17.58, y=1.42, z=-20.04},
	{x=-15.89, y=1, z=-12.96},
	{x=-13.34, y=1, z=-12.96},
    {x=-10.79, y=1, z=-12.96}
  }

  zonaDeckloja2 = getObjectFromGUID('411228')
  zonaDescarte = getObjectFromGUID('ecbdaa')
  zonaDescarteEspolio = getObjectFromGUID('83d71c')
  deckLoja1 = getObjectFromGUID('357587')
  deckLoja2 = getObjectFromGUID('70c7f6')
  self.createButton(params_loja)
  deckLoja1.shuffle()
  deckLoja2.shuffle()

end



-----------------------------------
--Getters and Setters
-----------------------------------
function getDeck()
    for i, o in pairs (zonaLoja[1].getObjects()) do
        if o.tag == 'Deck' then
            lastCardGUID = o.getObjects()[#o.getObjects()].guid
            return o
        end
        if o.tag == 'Card' then
            lastCardGUID = o.guid
        end
    end

    return nil
end

function getDeckEspolio()
    for i, o in pairs (zonaEspolio[1].getObjects()) do
        if o.tag == 'Deck' then
            lastEspolioGUID = o.getObjects()[#o.getObjects()].guid
            return o
        end
        if o.tag == 'Card' then
            lastEspolioGUID = o.guid
        end
    end

    return nil
end

------------------------------------
--Methods
------------------------------------


function click_func_atualizarLoja()
	startLuaCoroutine(self, 'drawLoja')
	startLuaCoroutine(self, 'drawEspolio')
end

function slideLoja()
	startLuaCoroutine(self, 'slideLojaCoroutine')
end

function slideEspolio()
	startLuaCoroutine(self, 'slideEspolioCoroutine')
end

function slideLojaCoroutine()
	local currentZone = 5
	local nextZone
	
	local found = false
	local cardToMove
	
	local pos = {x=0, y=0, z=0}
	local flip = {x=0, y=180, z=0}
	
	local obj
	local zoneOut
	
	deckLoja = getDeck()
	
	--Discard Last, if exists
	pos = zonaDescarte.getPosition()
	
	for i, o in pairs(zonaLoja[5].getObjects()) do
		if o.tag == 'Card' then
			o.setPositionSmooth(pos)
			coroutine.yield(0)
			while o ~= nil and o.resting == false do
				coroutine.yield(0)
			end
		end
	end
	--End 
	
	nextZone = currentZone - 1
	while currentZone > 1 do
		
		found = false

		while not found and nextZone > 1 do
			for i, o in pairs(zonaLoja[nextZone].getObjects()) do
				if o.tag == 'Card' then
					found = true
					cardToMove = getObjectFromGUID(o.guid)
					zoneOut = nextZone
				end
			end
			nextZone = nextZone - 1
		end
		
		if not found and nextZone == 1 then
			 if deckLoja == nil or #deckLoja.getObjects() == 0 then
                cardToMove = getObjectFromGUID(lastCardGUID)
				
				if cardToMove ~= nil then
					currentObjsIn = #zonaLoja[currentZone].getObjects()
					cardToMove.setPositionSmooth(posLoja[currentZone])
					cardToMove.setRotationSmooth(flip)
					
					coroutine.yield(0)
					while #zonaLoja[currentZone].getObjects() == currentObjsIn do
						coroutine.yield(0)
					end

					deckLoja = getNewDeck()
		
					coroutine.yield(0)
					while #zonaLoja[1].getObjects() ~= 1 do
						coroutine.yield(0)
					end
				end
            else
				currentObjsIn = #zonaLoja[currentZone].getObjects()
                obj = deckLoja.takeObject(lojaSnap[currentZone])
                coroutine.yield(0)
				while #zonaLoja[currentZone].getObjects() == currentObjsIn do
                    coroutine.yield(0)
                end
            end
		elseif found then
			currentObjsIn = #zonaLoja[currentZone].getObjects()
			currentObjsOut = #zonaLoja[zoneOut].getObjects()
			
			cardToMove.setPositionSmooth(posLoja[currentZone])
			cardToMove.setRotationSmooth(flip)
			coroutine.yield(0)
			
			while #zonaLoja[currentZone].getObjects() == currentObjsIn or #zonaLoja[zoneOut].getObjects() == currentObjsOut do
				coroutine.yield(0)
			end
		end

		currentZone = currentZone - 1
	end
	return 1
end


function drawLoja()
	local currentZone = 5
	local nextZone
	
	local found = false
	local cardToMove
	
	local pos = {x=0, y=0, z=0}
	local flip = {x=0, y=180, z=0}
	
	local obj
	local zoneOut
	
	local currentObjsIn
	local currentObjsOut
	
	deckLoja = getDeck()
	pos = zonaDescarte.getPosition()
	
	--Search last empty space
	local empty
	while currentZone > 1 and not found do
		empty = true
		for i, o in pairs(zonaLoja[currentZone].getObjects()) do
			if o.tag == 'Card' then
				empty = false
			end
		end
		if not empty then
			currentZone = currentZone -1
		else
			found = true
		end
	end
	--End 
	
	nextZone = currentZone - 1
	while currentZone > 1 do
		found = false

		while not found and nextZone > 1 do
			for i, o in pairs(zonaLoja[nextZone].getObjects()) do
				if o.tag == 'Card' then
					found = true
					cardToMove = getObjectFromGUID(o.guid)
					zoneOut = nextZone
				end
			end
			nextZone = nextZone - 1
		end
		
		if not found and nextZone == 1 then
			if deckLoja == nil or #deckLoja.getObjects() == 0 then
                cardToMove = getObjectFromGUID(lastEspolioGUID)
				currentObjsIn = #zonaLoja[currentZone].getObjects()
				cardToMove.setPositionSmooth(posLoja[currentZone])
				cardToMove.setRotationSmooth(flip)
				
				coroutine.yield(0)
                while #zonaLoja[currentZone].getObjects() == currentObjsIn do
                    coroutine.yield(0)
                end

                deckLoja = getNewDeck()
	
				coroutine.yield(0)
                while #zonaLoja[1].getObjects() ~= 1 do
                    coroutine.yield(0)
                end
            else
				currentObjsIn = #zonaLoja[currentZone].getObjects()
                obj = deckLoja.takeObject(lojaSnap[currentZone])
                coroutine.yield(0)
				while #zonaLoja[currentZone].getObjects() == currentObjsIn do
                    coroutine.yield(0)
                end
            end
		elseif found then
			currentObjsIn = #zonaLoja[currentZone].getObjects()
			currentObjsOut = #zonaLoja[zoneOut].getObjects()
			
			cardToMove.setPositionSmooth(posLoja[currentZone])
			cardToMove.setRotationSmooth(flip)
			coroutine.yield(0)
			
			while #zonaLoja[currentZone].getObjects() == currentObjsIn or #zonaLoja[zoneOut].getObjects() == currentObjsOut do
				coroutine.yield(0)
			end
		end

		currentZone = currentZone - 1
	end
	return 1
end

--AQUI
function slideEspolioCoroutine()
	pos = zonaDescarteEspolio.getPosition()
	
	for i, o in pairs(zonaEspolio[4].getObjects()) do
		if o.tag == 'Card' then
			o.setPositionSmooth(pos)
			coroutine.yield(0)
			while o ~= nil and o.resting == false do
				coroutine.yield(0)
			end
		end
	end
	drawEspolio()
	return 1
end



function drawEspolio()
--DO NOT START UNTIL THERE IS SOMETHING
--Se o deck nao existir ele nao anda
-- Se o deck existir mas nao estiver no lugar da erro
	while #zonaEspolio[1].getObjects() == 0 and #zonaDescarteEspolio.getObjects() == 0 do
		coroutine.yield(0)
	end

	local currentZone = 4
	local nextZone
	
	local found = false
	local cardToMove
	
	local pos = {x=0, y=0, z=0}
	local flip = {x=0, y=180, z=0}
	
	local obj
	local zoneOut
	
	local currentObjsIn
	local currentObjsOut
	
	deckEspolio = getDeckEspolio()
	pos = zonaDescarteEspolio.getPosition()
	
	--Search last empty space
	local empty
	while currentZone > 1 and not found do
		empty = true
		for i, o in pairs(zonaEspolio[currentZone].getObjects()) do
			if o.tag == 'Card' then
				empty = false
			end
		end
		if not empty then
			currentZone = currentZone -1
		else
			found = true
		end
	end
	--End 
	
	nextZone = currentZone - 1
	while currentZone > 1 do
		found = false

		while not found and nextZone > 1 do
			for i, o in pairs(zonaEspolio[nextZone].getObjects()) do
				if o.tag == 'Card' then
					found = true
					cardToMove = getObjectFromGUID(o.guid)
					zoneOut = nextZone
				end
			end
			nextZone = nextZone - 1
		end
		
		if not found and nextZone == 1 then
			if deckEspolio == nil or #deckEspolio.getObjects() == 0 then
                cardToMove = getObjectFromGUID(lastEspolioGUID)
				currentObjsIn = #zonaEspolio[currentZone].getObjects()
				cardToMove.setPositionSmooth(posEspolio[currentZone]) 
				cardToMove.setRotationSmooth(flip)
				
				coroutine.yield(0)
                while #zonaEspolio[currentZone].getObjects() == currentObjsIn do
                    coroutine.yield(0)
                end

                deckEspolio = getNewDeckEspolio()
	
				coroutine.yield(0)
                while #zonaEspolio[1].getObjects() ~= 1 do
                    coroutine.yield(0)
                end
            else
				currentObjsIn = #zonaEspolio[currentZone].getObjects()
                obj = deckEspolio.takeObject(espolioSnap[currentZone])
                coroutine.yield(0)
				while #zonaEspolio[currentZone].getObjects() == currentObjsIn do
                    coroutine.yield(0)
                end
            end
		elseif found then
			currentObjsIn = #zonaEspolio[currentZone].getObjects()
			currentObjsOut = #zonaEspolio[zoneOut].getObjects()
			
			cardToMove.setPositionSmooth(posEspolio[currentZone])
			cardToMove.setRotationSmooth(flip)
			coroutine.yield(0)
			
			while #zonaEspolio[currentZone].getObjects() == currentObjsIn or #zonaEspolio[zoneOut].getObjects() == currentObjsOut do
				coroutine.yield(0)
			end
		end

		currentZone = currentZone - 1
	end
	return 1
end


function getNewDeck()
    for i, o in pairs (zonaDeckloja2.getObjects()) do
        if o.tag=='Deck' then
            o.setPositionSmooth({x=-22.61, y=1, z=-5.27})
            print("Fim do baralho") --colocar em array msg
            return o
        end
    end

    -- Se o segundo deck já exauriu, pegar descarte
    for i, o in pairs(zonaDescarte.getObjects()) do
        if o.tag == 'Deck' then
            o.flip() -- Sugiro setRotation, pois o usuário pode colocar pra baixo.
            o.shuffle()
            o.setPositionSmooth({x=-22.61, y=1, z=-5.27})
            return o
        end
    end
end

function getNewDeckEspolio()

    --Pegar descarte
    for i, o in pairs(zonaDescarteEspolio.getObjects()) do
        if o.tag == 'Deck' then
            o.flip() -- Sugiro setRotation, pois o usuário pode colocar pra baixo.
            o.shuffle()
            o.setPositionSmooth({x=-15.86, y=1, z=-20.17}) 
            return o
        end
    end
end