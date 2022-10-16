function onLoad()
    self.shuffle()
end

function onSearchEnd()
    self.shuffle()
end
function onObjectLeaveContainer(container)
    if container == self then self.shuffle() end
end

function onObjectEnterContainer(container)
    if container == self then self.shuffle() end
end