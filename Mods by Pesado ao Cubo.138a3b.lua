self.interactable = false

adList = {
    "https://i.ibb.co/mD3mTLp/Arte-Pod.png",
    "https://i.ibb.co/42yLC9W/Art-Logo-mini.png",
    "https://i.ibb.co/gzf1gRc/Arte-Pod.png",
    "https://i.ibb.co/m5dSZ93/Arte-Pod-GH.png"
}

adconfig = {
    ADTIME = {3,8},
    INITIALDISPLAY = "sequence",
}

local anim = 0;
local current = 0;

function randomAd()
    if (#adList > 0) then
        math.randomseed(os.time() + self.guid:byte())
        current = math.random(1, #adList)
        for i,v in ipairs(adList) do
            if (i ~= current) then
                self.UI.hide("ad_"..i)
            end
        end
        self.UI.show("ad_"..current)
        anim = Wait.time(randomAd, math.random(adconfig.ADTIME[1], adconfig.ADTIME[2]) + math.random())
    end
end

function sequenceAd()
    if (#adList > 0) then
        math.randomseed(os.time() + self.guid:byte())
        current = current + 1
        if (current > #adList) then
            current = 1
        end
        for i,v in ipairs(adList) do
            if (i ~= current) then
                self.UI.hide("ad_"..i)
            end
        end
        self.UI.show("ad_"..current)
        anim = Wait.time(sequenceAd, math.random(adconfig.ADTIME[1], adconfig.ADTIME[2]) + math.random())
    end
end

function displayRandom()
    Wait.stop(anim)
    math.randomseed(os.time() + self.guid:byte())
    current = math.random(1, #adList)
    for i,v in ipairs(adList) do
        if (current ~= i) then
            self.UI.hide("ad_"..i)
        end
    end
    self.UI.show("ad_"..current)
    anim = Wait.time(randomAd, math.random(adconfig.ADTIME[1], adconfig.ADTIME[2]) + math.random())
end

function displaySequence()
    Wait.stop(anim)
    current = 1
    for i,v in ipairs(adList) do
        if (i ~= current) then
            self.UI.hide("ad_"..i)
        end
    end
    self.UI.show("ad_"..current)
    anim = Wait.time(sequenceAd, math.random(adconfig.ADTIME[1], adconfig.ADTIME[2]) + math.random())
end

function rebuildUI()

    local ui = {}

    local assets = {}
    local assetRefs = {}
    local refLen = 0
    for i,url in pairs(adList) do
        if (assetRefs[url] == nil) then
            refLen = refLen + 1
            assetRefs[url] = self.guid.."_ad_"..refLen
            table.insert(assets, {name=assetRefs[url], url=url})
        end

        table.insert(ui, {
            tag="Panel", children={
                {
                    tag="Image",
                    attributes={
                        color="#ffffffc0",
                        image=(assetRefs[url]),
                        width=6400/3.5,
                        height=3600/3.5,
                        position="0 0 -650",
                        rotation="-80 0 0",
                    }
                }
            }, attributes={
                position="0 0 0",
                id=("ad_"..i),
                active=false,
                showAnimation="Grow",
                hideAnimation="Shrink",
                animationDuration=1.0
            }
        })
    end
    self.UI.setCustomAssets(assets)
    self.UI.setXmlTable({ {tag="Panel", children=ui} })
end

function refresh()
    TRH = Global.getTable("TRH") or {}
    self.UI.setAttribute("score_player1_name", "text", TRH['score_p1n'] or "")
    self.UI.setAttribute("score_player1_value", "text", TRH['score_p1v'] or "-")
    self.UI.setAttribute("score_player2_name", "text", TRH['score_p2n'] or "")
    self.UI.setAttribute("score_player2_value", "text", TRH['score_p2v'] or "-")
end

function onSave()
    local component = self.getComponent("MeshCollider") or self.getComponent("BoxCollider")
    local data = {col = component.get("enabled")}
    return JSON.encode(data)
end

function onLoad(save)
    local data = JSON.decode(save) or { col = true }
    component = self.getComponent("MeshCollider") or self.getComponent("BoxCollider")
    component.set("enabled", data.col)
    self.interactable = data.col
    rebuildUI()
    Wait.frames(refresh, 2)
    if (adconfig.INITIALDISPLAY == "sequence") then
        Wait.frames(displaySequence, 3)
    else
        Wait.frames(displayRandom, 3)
    end
end
--DO NOT EDIT THIS TABLE
cmdconst = { OK = 0, STATUS_ERROR = 1, STATUS_BADARGS = 2, STATUS_PERMISSIONS = 3, SPECTATOR = 1, PLAYER = 2, PROMOTED = 4, BLACK = 8, HOST = 16, ALL = 31, NOSPECTATOR = 30 }

--okay, now you can edit stuff

--set your config here
cmdconfig = {
    PROMPT = "!jumbotron", --edit this to determine what you want your command line trigger to be. Recommend starting with an exclaimation point. You can make this an integer-key'd table to listen to multiple command prompts, if you want. Be careful
    TERMINAL = "[ff8000]JUMBOTRON>[-] ", --printed before each line in most cases
    VERBOSITY = "never", --set to 'always' for complete feedback, 'error' for only errors, 'help' for only displaying help messages, 'never' to get it to shut up - this does not stop command calls from printing, but will stop command line errors
    ACCESS = {cmdconst.HOST, cmdconst.BLACK},
        --[[
            ""
            "GUEST" => Anyone can acess,
            "SEATED&PROMOTED"
            "PROMOTED" => Anyone promoted can access
        ]]
}

--add your commands here
commands = {
    ["set"] = false,
    ["add"] = false,
    ["sub"] = false,
    ["clear"] = false,
    ["seated"] = false,
    ["name"] = false,
    ["unname"] = false,
    ["display"] = {
        desc = "Change the order in which the ads are displayed",
        arguments = {
            {"sequence|random", "one after another or randomly determined", true}
        },
        requiredArgs = 1,
        call = function(player, display)
            if (display == "sequence") then displaySequence() end
            if (display == "random") then displayRandom() end
            --Wait.frames(refresh, 2)
            return cmdconst.OK
        end
    },
    ["mode"] = {
        desc = "toggles between game mode (disabled collisions and non-interactive) and edit mode",
        arguments = {
            {"edit|game", "'edit' will enabled interactibility, 'game' disables interactibility", true}
        },
        requiredArgs = 1,
        call = function(player, mode)
            if (mode == "game") then
                self.interactable = false
                (self.getComponent("MeshCollider") or self.getComponent("BoxCollider")).set("enabled", false)
            elseif (mode == "edit") then
                self.interactable = true
                (self.getComponent("MeshCollider") or self.getComponent("BoxCollider")).set("enabled", true)
            end
            return cmdconst.OK
        end
    }
}

--don't edit below here

commands=commands or{}cmdconfig.ACCESS=cmdconfig.ACCESS or{cmdconst.HOST}commands['help']={desc="lists out what commands are available, or describes a specific command",arguments={{"[command]","Specific command to gather more information on"}},call=function(a,b)if cmdconfig.VERBOSITY=="always"or cmdconfig.VERBOSITY=="help"then if b~=nil then if commands[b]~=false then printToAll("\n================\nHelp: "..b.."\n================\n",{1.0,0.9,0.5})if commands[b]~=nil then local c=""local d={}for e,f in ipairs(commands[b].arguments or{})do c=c.." "..((f[3]or false)and"[b]"..f[1].."[/b] "or"[i]"..f[1].."[/i]")d[e]="> [99ccff]"..f[1].."[-] "..((f[3]or false)and"(required)"or"(optional)").." - "..f[2]end;a.print(commands[b].desc or"No information found",{1.0,1.0,1.0})a.print("",{1.0,1.0,1.0})a.print("Syntax",{1.0,1.0,1.0})a.print("[ffe680]"..(type(cmdconfig.PROMPT)=="table"and cmdconfig.PROMPT[1]or cmdconfig.PROMPT).." "..b.."[-][99ccff]"..c.."[-]",{1.0,1.0,1.0})a.print("",{1.0,1.0,1.0})if#d>0 then a.print("Arguments",{1.0,1.0,1.0})end;for g,h in ipairs(d)do a.print(h,{1.0,1.0,1.0})end else a.print("Help doesn't know anything about '"..b.."'",{1.0,0.4,0.4})end end else printToAll("\n================\nHelp\n================\n",{1.0,0.9,0.5})for i,h in pairs(commands)do if h~=false then if not(h.private or false)then local c=""for e,f in ipairs(h.arguments or{})do c=c.." "..((f[3]or false)and"[b]"..f[1].."[/b] "or"[i]"..f[1].."[/i]")end;a.print("[ffe680]"..(type(cmdconfig.PROMPT)=="table"and cmdconfig.PROMPT[1]or cmdconfig.PROMPT).." "..i.."[-][99ccff]"..c.."[-] - "..(h.desc or"[ff8080]Undocumented[-]"),{1.0,1.0,1.0})end end end end end;return cmdconst.OK end}function onChat(j,a)local k=false;local l=""if type(cmdconfig.PROMPT)=="table"then for g,m in ipairs(cmdconfig.PROMPT)do k=string.lower(string.sub(j,1,string.len(m)+1))==string.lower(m).." "if k then l=m;break end end else k=string.lower(string.sub(j,1,string.len(cmdconfig.PROMPT)+1))==string.lower(cmdconfig.PROMPT).." "l=cmdconfig.PROMPT end;if k then local n=bit32.bor(a.host and cmdconst.HOST or 0,a.color=="Black"and cmdconst.BLACK or 0,a.color~="Grey"and a.color~="Black"and cmdconst.PLAYER or 0,a.promoted and cmdconst.PROMOTED or 0,a.color=="Grey"and cmdconst.SPECTATOR or 0)if bit32.band(bit32.bor(table.unpack(cmdconfig.ACCESS)),n)==0 then if cmdconfig.VERBOSITY=="always"or cmdconfig.VERBOSITY=="error"then a.print(cmdconfig.TERMINAL.."Insufficient Priviliges",{1.0,0.4,0.4})end;return false end;local o={}local p=string.sub(j,string.len(l)+2)local q=0;while true do local r=q+1;r=p:find("%S",r)if r==nil then break end;if p:sub(r,r)=="'"then q=p:find("'",r+1)r=r+1 elseif p:sub(r,r)=='"'then q=p:find('"',r+1)r=r+1 else q=p:find("%s",r+1)end;if q==nil then q=#p+1 end;o[#o+1]=p:sub(r,q-1)end;if#o<1 then if cmdconfig.VERBOSITY=="always"or cmdconfig.VERBOSITY=="error"then a.print(cmdconfig.TERMINAL.."Command Expected",{1.0,0.4,0.4})if commands.help~=nil then a.print("Use '"..l.." help' for a list of valid commands",{1.0,0.4,0.4})else a.print(cmdconfig.TERMINAL.."Help command not found!",{1.0,0.4,0.4})end end;return false end;local b=string.lower(table.remove(o,1))if commands[b]~=nil then if commands[b]~=false then if bit32.band(bit32.bor(table.unpack(commands[b].access or{cmdconst.NOSPECTATOR})),n)==0 then if cmdconfig.VERBOSITY=="always"or cmdconfig.VERBOSITY=="error"then a.print(cmdconfig.TERMINAL.."Insufficient Priviliges",{1.0,0.4,0.4})end;return false else local s=commands[b].requiredArgs;if s==nil then s=0;for g,h in pairs(commands[b].arguments or{})do if h[3]then s=s+1 else break end end end;if#o<s then if cmdconfig.VERBOSITY=="always"or cmdconfig.VERBOSITY=="error"then a.print(cmdconfig.TERMINAL.."Bad Arguments",{1.0,0.4,0.4})if commands.help==nil then a.print(cmdconfig.TERMINAL.."WARNING: Help command not found!",{1.0,0.4,0.4})else a.print(cmdconfig.TERMINAL.."Use '"..l.." help "..b.."' for help with this command",{1.0,0.4,0.4})end end;return false end;local t=commands[b].call(a,table.unpack(o))if t~=nil then if cmdconfig.VERBOSITY=="always"or cmdconfig.VERBOSITY=="error"then if t==cmdconst.STATUS_ERROR then a.print(cmdconfig.TERMINAL.."General Error",{1.0,0.4,0.4})end;if t==cmdconst.STATUS_BADARGS then a.print(cmdconfig.TERMINAL.."Bad Arguments",{1.0,0.4,0.4})if commands.help~=nil then a.print(cmdconfig.TERMINAL.."Use '"..l.." help "..b.."' for help with this command",{1.0,0.4,0.4})else a.print(cmdconfig.TERMINAL.."Help command not found!",{1.0,0.4,0.4})end end;if t==cmdconst.STATUS_PERMISSIONS then a.print(cmdconfig.TERMINAL.."Insufficient Priviliges ",{1.0,0.4,0.4})end end end end else return false end else if cmdconfig.VERBOSITY=="always"or cmdconfig.VERBOSITY=="error"then a.print(cmdconfig.TERMINAL.."Unknown Command '"..b.."'",{1.0,0.4,0.4})if commands.help~=nil then a.print(cmdconfig.TERMINAL.."Use '"..l.." help' for a list of valid commands",{1.0,0.4,0.4})else a.print(cmdconfig.TERMINAL.."WARNING: Help command not found!",{1.0,0.4,0.4})end end end;return false end end