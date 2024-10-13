<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MudletPackage>
<MudletPackage version="1.001">
	<ScriptPackage>
		<ScriptGroup isActive="yes" isFolder="yes">
			<name>CK-Chat</name>
			<packageName>CK-Chat</packageName>
			<script></script>
			<eventHandlerList />
			<Script isActive="yes" isFolder="no">
				<name>CK-Chat</name>
				<packageName></packageName>
				<script>local ck = require("CK")
ck:register("CK-Chat", "24.09.06")
local chat = ck:get_table("chat")
local helpers = ck:get_table("chat.helpers")
local defaultConfig = { activeColor = "black", inactiveColor = "black", activeBorder = "green", activeText = "green", inactiveText =
"grey", background = "black", windowBorder = "green", title = "green" }
local emco = require("CK-Chat.emco")
emco.cmdLineStyleSheet = nil
chat.config = chat.config or defaultConfig
local baseStyle = Geyser.StyleSheet:new(f [[
  border-width: 2px;
  border-style: solid;
]])
local activeStyle = Geyser.StyleSheet:new(f [[
  border-color: {chat.config.activeBorder};
  background-color: {chat.config.activeColor};
]], baseStyle)
local inactiveStyle = Geyser.StyleSheet:new(f [[
  border-color: {chat.config.inactiveColor};
  background-color: {chat.config.inactiveColor};
]], baseStyle)
local adjLabelStyle = Geyser.StyleSheet:new(f [[
  background-color: rgba(0,0,0,100%);
  border: 4px double;
  border-color: {chat.config.windowBorder};
  border-radius: 4px;]])

local default_constraints = { 
    name = "CK chatContainer", 
    x = (100 - rightPanelWidth).."%",
    y = "0%",
    width = rightPanelWidth.."%",
    height = "50%",
    titleText = "Tabbed Chat" 
}

local EMCOfilename = getMudletHomeDir() .. "/CK-Chat/EMCOPrebuiltChat.lua"
local confFile = getMudletHomeDir() .. "/CK-Chat/EMCOPrebuiltExtraOptions.lua"

function helpers.echo(msg)
    msg = msg or ""
    cecho(f "&lt;green&gt;CK chat: &lt;reset&gt;{msg}\n")
end

function helpers.resetToDefaults()
    default_constraints.adjLabelstyle = adjLabelStyle:getCSS()
    chat.container = chat.container or Adjustable.Container:new(default_constraints)
    chat.config = defaultConfig
    chat.emco = emco:new({
        name = "CKPrebuiltChat",
        x = 0,
        y = 0,
        height = "100%",
        width = "100%",
        consoles = {"All", "OOC", "Tells", "Group", "Auction", "Event", "Say"},
        allTab = true,
        allTabName = "All",
        blankLine = false,
        blink = true,
        bufferSize = 10000,
        deleteLines = 500,
        timestamp = true,
        fontSize = 12,
        font = "Ubuntu Mono",
        consoleColor = chat.config.background,
        activeTabCSS = activeStyle:getCSS(),
        inactiveTabCSS = inactiveStyle:getCSS(),
        activeTabFGColor = chat.config.activeText,
        inactiveTabFGColor = chat.config.inactiveText,
        gap = 3,
        commandLine = true,
    }, chat.container)
    helpers.retheme()
end

function helpers.retheme()
    activeStyle:set("background-color", chat.config.activeColor)
    activeStyle:set("border-color", chat.config.activeBorder)
    inactiveStyle:set("background-color", chat.config.inactiveColor)
    inactiveStyle:set("border-color", chat.config.inactiveColor)
    adjLabelStyle:set("border-color", chat.config.windowBorder)
    local als = adjLabelStyle:getCSS()
    chat.container.adjLabelstyle = als
    chat.container.adjLabel:setStyleSheet(als)
    chat.container:setTitle(chat.container.titleText, chat.config.title)
    chat.emco.activeTabCSS = activeStyle:getCSS()
    chat.emco.inactiveTabCSS = inactiveStyle:getCSS()
    chat.emco:setActiveTabFGColor(chat.config.activeText)
    chat.emco:setInactiveTabFGColor(chat.config.inactiveText)
    chat.emco:setConsoleColor(chat.config.background)
    chat.emco:switchTab(chat.emco.currentTab)
end

function helpers.setConfig(cfg, val)
    local validOptions = table.keys(chat.config)
    if not table.contains(validOptions, cfg) then
        return nil, f"invalid option: valid options are {table.concat(validOptions, ', ')}"
    end
    chat.config[cfg] = val
    helpers.retheme()
    return true
end

function helpers.save()
    chat.emco:save()
    table.save(confFile, chat.config)
    chat.container:save()
end

function helpers.load()
    if io.exists(confFile) then
        local conf = {}
        table.load(confFile, conf)
        chat.config = table.update(chat.config, conf)
        for option, value in pairs(defaultConfig) do
            chat.config[option] = chat.config[option] or value
        end
    end
    if io.exists(EMCOfilename) then
        chat.emco:hide()
        chat.emco:load()
        chat.emco:show()
    end
    chat.container:load()
    helpers.retheme()
end

local function startup()
    helpers.resetToDefaults()
    helpers.load()
end

if not chat.emco then
    startup()
end

-- Function to move and resize the chat container
function moveChatConsole()
    if chat.container then
        chat.container:move((100 - rightPanelWidth).."%", "50%")    -- Move to x = 60%, y = 50%
        chat.container:resize(rightPanelWidth.."%", "50%")  -- Resize to width = 40%, height = 50%
    end
end

-- Call the function to move and resize the container
moveChatConsole()
</script>
				<eventHandlerList />
			</Script>
		</ScriptGroup>
	</ScriptPackage>
</MudletPackage>
