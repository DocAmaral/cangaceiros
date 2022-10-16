zonaLoja = {}
lojaSnap = {}
posLoja = {}
loja = getObjectFromGUID("870670")


function getLastCardGUID(deck)
    if deck.tag == 'Deck' then
        local deckContents = deck.getObjects()
        return deckContents[#deckContents].guid

    elseif deck.tag == 'Card' then
        return deck.guid
    end
end