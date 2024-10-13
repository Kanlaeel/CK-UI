<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MudletPackage>
<MudletPackage version="1.001">
	<ScriptPackage>
		<ScriptGroup isActive="yes" isFolder="yes">
			<name>CK-UI</name>
			<packageName></packageName>
			<script></script>
			<eventHandlerList />
			<Script isActive="yes" isFolder="no">
				<name>Layout</name>
				<packageName></packageName>
				<script>local ck = require("CK")
ck:register("CK-UI", "1.1.1")

rightPanelWidth = 40
bottomPanelHeight = 10

local rightPanel = Geyser.Container:new({
    name = "RightPanel",
    x = (100 - rightPanelWidth).."%",
    y = "0%",
    width = rightPanelWidth.."%",  
    height = "100%", 
})

local rightPanelBackground = Geyser.Label:new({
    name = "RightPanelBackground",
    x = "0%",
    y = "0%",
    width = "100%",
    height = "100%",
}, rightPanel)

rightPanelBackground:setStyleSheet([[
  background-color: rgba(0, 0, 0, 0);   
  border: none;                         
  pointer-events: none;                 
]])

local bottomBar = Geyser.Container:new({
    name = "BottomBar",
    x = "0%", 
    y = (100 - bottomPanelHeight).."%", 
    width = (100 - rightPanelWidth).."%", 
    height = bottomPanelHeight.."%", 
})

local bottomBarBackground = Geyser.Label:new({
    name = "BottomBarBackground",
    x = "0%",
    y = "0%",
    width = "100%",
    height = "100%",
}, bottomBar) 

bottomBarBackground:setStyleSheet([[
  background-color: rgba(0, 0, 0, 0%);
  border: 2px solid green;
  pointer-events: none;                 
]])

setBorderRight(rightPanel:get_width())
setBorderBottom(bottomBar:get_height())

function adjustLayout()
    local newRightBorder = math.floor(rightPanel:get_width())
    local newBottomBorder = math.floor(bottomBar:get_height())
    setBorderRight(newRightBorder)  
    setBorderBottom(newBottomBorder)  
end

local function moveContainersToBackground()
    if rightPanel then
        rightPanel:lower()  
    end
    if bottomBar then
        bottomBar:lower()   
    end
end

local function hidePanels()
    rightPanel:hide()
    bottomBar:hide()
end

moveContainersToBackground()
hidePanels()
registerAnonymousEventHandler("sysWindowResizeEvent", adjustLayout)


</script>
				<eventHandlerList />
			</Script>
			<ScriptGroup isActive="yes" isFolder="yes">
				<name>HUD</name>
				<packageName></packageName>
				<script></script>
				<eventHandlerList />
				<Script isActive="yes" isFolder="no">
					<name>statsDisplay</name>
					<packageName></packageName>
					<script>local ck = require("CK")
local ROOT = ck:get_table()
local Player = ck:get_table("Player")
local API = ck:get_table("API")
local Combo = ck:get_table("API.Combo")
local Times = ck:get_table("API.Times")
local Skills = ck:get_table("API.Skills")

function statDebug()
    print("Player Name:", tostring(CK.Player.name))
    print("Player Race:", tostring(CK.Player.race))
    print("Player Base Powerlevel:", tostring(CK.Player.BasePl))
    print("Player Max Powerlevel:", tostring(CK.Player.MaxPl))
    print("Player Current Powerlevel:", tostring(CK.Player.Pl))
    print("Player Current Fatigue:", tostring(CK.Player.Fatigue))
    print("Player Max Fatigue", tostring(CK.Player.MaxFatigue))
    print("Player Current Ki, Heat, or Biomass:", tostring(CK.Player.Ki))
    print("Player Max Ki, Heat, or Biomass:", tostring(CK.Player.MaxKi))
    print("Player Current God Ki:", tostring(CK.Player.GK))
    print("Player Max God Ki:", tostring(CK.Player.MaxGK))
    print("Player Damage Roll:", tostring(CK.Player.Damroll))
    print("Player Hit Roll:", tostring(CK.Player.Hitroll))
    print("Player Max Gravity:", tostring(CK.Player.MaxGravity))
    print("Room Gravity:", tostring(CK.Room.Gravity))
    print("Player Zenni:", tostring(CK.Player.Zenni))
    print("Player Upper Body Strength:", tostring(CK.Player.UBS))
    print("Player Lower Body Strength:", tostring(CK.Player.LBS))
    print("Player Dark Energy:", tostring(CK.Player.DarkEnergy))
    print("Player Armor:", tostring(CK.Player.Armor))
    print("Player Tokens:", tostring(CK.Player.Tokens))
    print("Player Points:", tostring(CK.Player.EPoints))
    print("Player Hunger:", tostring(CK.Player.Hunger))
    print("Player Thirst:", tostring(CK.Player.Thirst))
    print("Room Area Name:", tostring(CK.Room.area))
    print("Room Name:", tostring(CK.Room.name))
    print("Room VNum:", tostring(CK.Room.vnum))
    print("Target's Health:", tostring(CK.Target.Health))
    print("Target's Max Health:", tostring(CK.Target.MaxHealth))
    print("Target's Name:", tostring(CK.Target.name))
    print("Target's Level:", tostring(CK.Target.level))
end</script>
					<eventHandlerList />
				</Script>
				<Script isActive="yes" isFolder="no">
					<name>gaugesContainer</name>
					<packageName></packageName>
					<script>local ck = require("CK")
local ROOT = ck:get_table()
local Player = ck:get_table("Player")
local API = ck:get_table("API")
local Combo = ck:get_table("API.Combo")
local Times = ck:get_table("API.Times")
local Skills = ck:get_table("API.Skills")

gaugesContainer = Geyser.Container:new({
    name = "gaugesContainer",
    x = "0%",
    y = "90%",
    width = "15%",
    height = "10%"
}, BottomBar)

borderLabel = Geyser.Label:new({
    name = "gaugesBorderLabel",
    x = "0%", y = "90%",
    width = "15%", height = "10%"
}, BottomBar)

borderLabel:setStyleSheet([[
    border: 4px double green;
    background-color: rgba(0, 0, 0, 0);
]])

local bars = {}

local function createAllBars()
    bars["powerGauge"] = Geyser.Gauge:new({
        name = "powerGauge",
        x = "0%", y = "0%",
        width = "100%",
        height = "20%"
    }, gaugesContainer)
    bars["powerGauge"]:setText("Powerlevel: " .. CK.Player.Pl .. " / " .. CK.Player.MaxPl)
    bars["powerGauge"]:setValue(999, 9999)
    bars["powerGauge"]:setAlignment("c")
    bars["powerGauge"]:setStyleSheet([[background-color: rgb(0, 128, 0);]])
    bars["powerGauge"].back:setStyleSheet("background-color: black;")

    bars["kiGauge"] = Geyser.Gauge:new({
        name = "kiGauge",
        x = "0%", y = "0%",
        width = "100%",
        height = "20%"
    }, gaugesContainer)
    bars["kiGauge"]:setText("Ki: " .. CK.Player.Ki .. " / " .. CK.Player.MaxKi)
    bars["kiGauge"]:setAlignment("c")
    bars["kiGauge"]:setValue(999, 9999)
    bars["kiGauge"]:setStyleSheet([[background-color: rgb(0, 0, 139);]])
    bars["kiGauge"].back:setStyleSheet("background-color: black;")

    bars["fatigueGauge"] = Geyser.Gauge:new({
        name = "fatigueGauge",
        x = "0%", y = "0%",
        width = "100%",
        height = "20%"
    }, gaugesContainer)
    bars["fatigueGauge"]:setText("Fatigue: " .. CK.Player.Fatigue .. " / " .. CK.Player.MaxFatigue)
    bars["fatigueGauge"]:setAlignment("c")
    bars["fatigueGauge"]:setValue(999, 9999)
    bars["fatigueGauge"]:setStyleSheet([[background-color: rgb(255, 140, 0);]])
    bars["fatigueGauge"].back:setStyleSheet("background-color: black;")

    bars["heatGauge"] = Geyser.Gauge:new({
        name = "heatGauge",
        x = "0%", y = "0%",
        width = "100%",
        height = "20%"
    }, gaugesContainer)
    bars["heatGauge"]:setText("Heat: " .. CK.Player.Ki .. " / " .. CK.Player.MaxKi)
    bars["heatGauge"]:setAlignment("c")
    bars["heatGauge"]:setValue(999, 9999)
    bars["heatGauge"]:setStyleSheet([[background-color: rgb(178, 34, 34);]])
    bars["heatGauge"].back:setStyleSheet("background-color: black;")

    bars["biomassGauge"] = Geyser.Gauge:new({
        name = "biomassGauge",
        x = "0%", y = "0%",
        width = "100%",
        height = "20%"
    }, gaugesContainer)
    bars["biomassGauge"]:setText("Biomass: " .. CK.Player.Ki .. " / " .. CK.Player.MaxKi)
    bars["biomassGauge"]:setAlignment("c")
    bars["biomassGauge"]:setValue(999, 9999)
    bars["biomassGauge"]:setStyleSheet([[background-color: rgb(0, 128, 0);]])
    bars["biomassGauge"].back:setStyleSheet("background-color: black;")

    bars["godKiGauge"] = Geyser.Gauge:new({
        name = "godKiGauge",
        x = "0%", y = "0%",
        width = "100%",
        height = "20%"
    }, gaugesContainer)
    bars["godKiGauge"]:setText("God Ki: " .. CK.Player.GK .. " / " .. CK.Player.MaxGK)
    bars["godKiGauge"]:setAlignment("c")
    bars["godKiGauge"]:setValue(0, 1)
    bars["godKiGauge"]:setStyleSheet([[background-color: rgb(218, 165, 32);]])
    bars["godKiGauge"].back:setStyleSheet("background-color: black;")

    bars["darkEnergyGauge"] = Geyser.Gauge:new({
        name = "darkEnergyGauge",
        x = "0%", y = "0%",
        width = "100%",
        height = "20%"
    }, gaugesContainer)
    bars["darkEnergyGauge"]:setText("Dark Energy: " .. CK.Player.DarkEnergy .. " / 100")
    bars["darkEnergyGauge"]:setAlignment("c")
    bars["darkEnergyGauge"]:setValue(CK.Player.DarkEnergy, 100)
    bars["darkEnergyGauge"]:setStyleSheet([[background-color: rgb(75, 0, 130);]])
    bars["darkEnergyGauge"].back:setStyleSheet("background-color: black;")

    for _, bar in pairs(bars) do
        bar:hide()
    end
end

createAllBars()

local function configureAndroidBars()
    for _, bar in pairs(bars) do
        bar:hide()
    end

    bars["powerGauge"]:show()
    bars["powerGauge"]:resize("100%", "50%")
    bars["powerGauge"]:move("0%", "0%")

    bars["heatGauge"]:show()
    bars["heatGauge"]:resize("100%", "50%")
    bars["heatGauge"]:move("0%", "50%")
end

function configureBiodroidBars()
    for _, bar in pairs(bars) do
        bar:hide()
    end

    bars["powerGauge"]:show()
    bars["powerGauge"]:resize("100%", "50%")
    bars["powerGauge"]:move("0%", "0%")

    bars["biomassGauge"]:show()
    bars["biomassGauge"]:resize("100%", "50%")
    bars["biomassGauge"]:move("0%", "50%")
end

local function configureDemonWOGKBars()
    for _, bar in pairs(bars) do
        bar:hide()
    end

    bars["powerGauge"]:show()
    bars["powerGauge"]:resize("100%", "25%")
    bars["powerGauge"]:move("0%", "0%")

    bars["kiGauge"]:show()
    bars["kiGauge"]:resize("100%", "25%")
    bars["kiGauge"]:move("0%", "25%")
    
    bars["fatigueGauge"]:show()
    bars["fatigueGauge"]:resize("100%", "25%")
    bars["fatigueGauge"]:move("0%", "50%")
    
    bars["darkEnergyGauge"]:show()
    bars["darkEnergyGauge"]:resize("100%", "25%")
    bars["darkEnergyGauge"]:move("0%", "75%")
end

local function configureDemonWGKBars()
    for _, bar in pairs(bars) do
        bar:hide()
    end

    bars["powerGauge"]:show()
    bars["powerGauge"]:resize("100%", "20%")
    bars["powerGauge"]:move("0%", "0%")

    bars["kiGauge"]:show()
    bars["kiGauge"]:resize("100%", "20%")
    bars["kiGauge"]:move("0%", "20%")
    
    bars["fatigueGauge"]:show()
    bars["fatigueGauge"]:resize("100%", "20%")
    bars["fatigueGauge"]:move("0%", "40%")
    
    bars["darkEnergyGauge"]:show()
    bars["darkEnergyGauge"]:resize("100%", "20%")
    bars["darkEnergyGauge"]:move("0%", "60%")
    
    bars["godKiGauge"]:show()
    bars["godKiGauge"]:resize("100%", "20%")
    bars["godKiGauge"]:move("0%", "80%")
end

local function configureDefaultWOGKBars()
    for _, bar in pairs(bars) do
        bar:hide()
    end

    bars["powerGauge"]:show()
    bars["powerGauge"]:resize("100%", "33%")
    bars["powerGauge"]:move("0%", "0%")

    bars["kiGauge"]:show()
    bars["kiGauge"]:resize("100%", "33%")
    bars["kiGauge"]:move("0%", "33%")
    
    bars["fatigueGauge"]:show()
    bars["fatigueGauge"]:resize("100%", "33%")
    bars["fatigueGauge"]:move("0%", "66%")
end

local function configureDefaultWGKBars()
    for _, bar in pairs(bars) do
        bar:hide()
    end

    bars["powerGauge"]:show()
    bars["powerGauge"]:resize("100%", "25%")
    bars["powerGauge"]:move("0%", "0%")

    bars["kiGauge"]:show()
    bars["kiGauge"]:resize("100%", "25%")
    bars["kiGauge"]:move("0%", "25%")
    
    bars["fatigueGauge"]:show()
    bars["fatigueGauge"]:resize("100%", "25%")
    bars["fatigueGauge"]:move("0%", "50%")
    
    bars["godKiGauge"]:show()
    bars["godKiGauge"]:resize("100%", "25%")
    bars["godKiGauge"]:move("0%", "75%")
end

local function configureBarsByRace()
    local race = CK.Player.race
    local hasGodKi = CK.Player.MaxGK &gt; 0

    if race == "Android" then
        configureAndroidBars()
    elseif race == "Biodroid" then
        configureBiodroidBars()
    elseif race == "Demon" then
        if hasGodKi then
            configureDemonWGKBars()
        else
            configureDemonWOGKBars()
        end
    else
        if hasGodKi then
            configureDefaultWGKBars()
        else
            configureDefaultWOGKBars()
        end
    end
end

configureBarsByRace()

local function getPowerlevelColor(percentage)
    local r, g, b

    if percentage &gt;= 85 then
        r = 0
        g = 100
        b = 0
    elseif percentage &gt;= 50 then
        local ratio = (percentage - 50) / 35
        r = math.floor(204 * (1 - ratio))
        g = 100 + math.floor((204 - 100) * ratio)
        b = 0
    elseif percentage &gt;= 15 then
        local ratio = (percentage - 15) / 35
        r = 204 - math.floor((204 - 139) * ratio)
        g = 204 - math.floor((204 - 0) * ratio)
        b = 0
    else
        r = 139
        g = 0
        b = 0
    end

    return string.format("rgb(%d, %d, %d)", r, g, b)
end

function updateGauges()
    local powerPercentage = math.floor(math.min(math.max((CK.Player.Pl / CK.Player.MaxPl) * 100, 0), 100))
    local color = getPowerlevelColor(powerPercentage)

    bars["powerGauge"]:setStyleSheet([[background-color: ]] .. color .. [[;]])
    bars["powerGauge"]:setValue(powerPercentage)
    bars["powerGauge"]:setText("&lt;b&gt;PL: " .. formatWithCommas(CK.Player.Pl) .. " / " .. formatWithCommas(CK.Player.MaxPl) .. " ( " .. tostring(math.floor((CK.Player.Pl / CK.Player.MaxPl) * 100)) .. "% )&lt;/b&gt;")
    
    if CK.Player.race ~= "Android" and CK.Player.race ~= "Biodroid" then
        bars["kiGauge"]:setText("&lt;b&gt;Ki: " .. formatWithCommas(CK.Player.Ki) .. " / " .. formatWithCommas(CK.Player.MaxKi) .. " ( " .. tostring(math.floor((CK.Player.Ki / CK.Player.MaxKi) * 100)) .. "% )&lt;/b&gt;")
        bars["kiGauge"]:setValue(math.min(math.max(CK.Player.Ki, 0), CK.Player.MaxKi), CK.Player.MaxKi)
        bars["fatigueGauge"]:setText("&lt;b&gt;Fatigue: " .. formatWithCommas(CK.Player.Fatigue) .. " / " .. formatWithCommas(CK.Player.MaxFatigue) .. " ( " .. tostring(math.floor((CK.Player.Fatigue / CK.Player.MaxFatigue) * 100)) .. "% )&lt;/b&gt;")
        bars["fatigueGauge"]:setValue(math.min(math.max(CK.Player.Fatigue, 0), CK.Player.MaxFatigue), CK.Player.MaxFatigue)
    end
    
    if CK.Player.race == "Android" then
        bars["heatGauge"]:setText("&lt;b&gt;Heat: " .. formatWithCommas(CK.Player.Ki) .. " / " .. formatWithCommas(CK.Player.MaxKi) .. " ( " .. tostring(math.floor((CK.Player.Ki / CK.Player.MaxKi) * 100)) .. "% )&lt;/b&gt;")
        bars["heatGauge"]:setValue(math.max(math.min(CK.Player.MaxKi - CK.Player.Ki, CK.Player.MaxKi), 0), CK.Player.MaxKi)
    end
    
    if CK.Player.race == "Biodroid" then
        bars["biomassGauge"]:setText("&lt;b&gt;Biomass: " .. formatWithCommas(CK.Player.Ki) .. " / " .. formatWithCommas(CK.Player.MaxKi) .. " ( " .. tostring(math.floor((CK.Player.Ki / CK.Player.MaxKi) * 100)) .. "% )&lt;/b&gt;")
        bars["biomassGauge"]:setValue(math.min(math.max(CK.Player.Ki, 0), CK.Player.MaxKi), CK.Player.MaxKi)
    end
        
    if CK.Player.MaxGK &gt; 0 then
        bars["godKiGauge"]:setValue(math.min(math.max(CK.Player.GK, 0), CK.Player.MaxGK), CK.Player.MaxGK)
        bars["godKiGauge"]:setText("&lt;b&gt;God Ki: " .. formatWithCommas(CK.Player.GK) .. " / " .. formatWithCommas(CK.Player.MaxGK) .. " ( " .. tostring(math.floor((CK.Player.GK / CK.Player.MaxGK) * 100)) .. "% )&lt;/b&gt;")
    end
    
    if CK.Player.race == "Demon" then
        bars["darkEnergyGauge"]:setText("&lt;b&gt;Dark Energy: " .. formatWithCommas(CK.Player.DarkEnergy) .. " / 1000 ( " .. tostring(math.floor((CK.Player.DarkEnergy / 1000) * 100)) .. "% )&lt;/b&gt;")
        bars["darkEnergyGauge"]:setValue(math.max(math.min(CK.Player.DarkEnergy, 1000), 0), 1000)
    end
end    

updateGauges()
   
function hideAllBars()
    for _, bar in pairs(bars) do
        bar:hide()
    end
end 

--display(bars)
</script>
					<eventHandlerList />
				</Script>
				<Script isActive="yes" isFolder="no">
					<name>playerInfoContainer</name>
					<packageName></packageName>
					<script>local ck = require("CK")
local ROOT = ck:get_table()
local Player = ck:get_table("Player")
local API = ck:get_table("API")
local Combo = ck:get_table("API.Combo")
local Times = ck:get_table("API.Times")
local Skills = ck:get_table("API.Skills")

local gaugesContainer = Geyser.Container:new({
    name = "playerInfoContainer",
    x = "15%",
    y = "90%",
    width = "15%",
    height = "10%"
}, BottomBar)

local borderLabel = Geyser.Label:new({
    name = "playerBorderLabel",
    x = "15%", y = "90%",
    width = "15%", height = "10%"
}, BottomBar)

borderLabel:setStyleSheet([[
    border: 4px double green;
    background-color: rgba(0, 0, 0, 0);
]])

local playerInfoLabel = Geyser.Label:new({
    name = "playerInfoLabel",
    x = "17%", y = "90%",
    width = "12%", height = "10%",
}, playerInfoContainer)

local playerInfoText = string.format([[
    &lt;div style="display: flex; justify-content: center; align-items: center; height: 100%%;"&gt;
        &lt;table style="width: 80%%; border-spacing: 10px; text-align: left;"&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Name:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Race:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Base PL:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Zenni:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
        &lt;/table&gt;
    &lt;/div&gt;
]], 
    CK.Player.name, 
    CK.Player.race, 
    formatWithCommas(CK.Player.BasePl), 
    formatWithCommas(CK.Player.Zenni)
)

playerInfoLabel:setStyleSheet([[
    background-color: black;
]])

playerInfoLabel:lower()

playerInfoLabel:echo(playerInfoText)

function updatePlayerInfo()
    local updatedPlayerInfoText = string.format([[
    &lt;div style="display: flex; justify-content: center; align-items: center; height: 100%%;"&gt;
        &lt;table style="width: 80%%; border-spacing: 10px; text-align: left;"&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Name:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Race:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Base PL:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Zenni:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
        &lt;/table&gt;
    &lt;/div&gt;
    ]], 
    CK.Player.name, 
    CK.Player.race, 
    formatWithCommas(CK.Player.BasePl), 
    formatWithCommas(CK.Player.Zenni))

    playerInfoLabel:echo(updatedPlayerInfoText)
end</script>
					<eventHandlerList />
				</Script>
				<Script isActive="yes" isFolder="no">
					<name>statsContainer</name>
					<packageName></packageName>
					<script>local ck = require("CK")
local ROOT = ck:get_table()
local Player = ck:get_table("Player")
local API = ck:get_table("API")
local Combo = ck:get_table("API.Combo")
local Times = ck:get_table("API.Times")
local Skills = ck:get_table("API.Skills")

local gaugesContainer = Geyser.Container:new({
    name = "statsContainer",
    x = "30%",
    y = "90%",
    width = "15%",
    height = "10%"
}, BottomBar)

local borderLabel = Geyser.Label:new({
    name = "statsBorderLabel",
    x = "30%", y = "90%",
    width = "15%", height = "10%"
}, BottomBar)

borderLabel:setStyleSheet([[
    border: 4px double green;
    background-color: rgba(0, 0, 0, 0);
]])

local statsLabel = Geyser.Label:new({
    name = "statsLabel",
    x = "31%", y = "90%",
    width = "13%", height = "10%",
}, statsContainer)

local statsText = string.format([[
&lt;div style="display: flex; justify-content: center; align-items: center; height: 100%%;"&gt;
    &lt;table style="width: 100%%; text-align: left;"&gt;
        &lt;tr&gt;
            &lt;td style="padding-right: 5px;"&gt;&lt;b&gt;INT:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;UBS:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;  &lt;!-- Added padding-left for spacing --&gt;
            &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;ARM:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;  &lt;!-- Added padding-left --&gt;
        &lt;/tr&gt;
        &lt;tr&gt;
            &lt;td style="padding-right: 5px;"&gt;&lt;b&gt;STR:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;LBS:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;HIT:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
        &lt;/tr&gt;
        &lt;tr&gt;
            &lt;td style="padding-right: 5px;"&gt;&lt;b&gt;SPD:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;HUNG:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;DAM:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
        &lt;/tr&gt;
        &lt;tr&gt;
            &lt;td style="padding-right: 5px;"&gt;&lt;b&gt;WIS:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;THISRT:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;GRAV:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
        &lt;/tr&gt;
    &lt;/table&gt;
&lt;/div&gt;
]], 
    CK.Player.Stats.INT, CK.Player.UBS, CK.Player.Armor, 
    CK.Player.Stats.STR, CK.Player.LBS, CK.Player.Hitroll, 
    CK.Player.Stats.SPD, CK.Player.Hunger, CK.Player.Damroll, 
    CK.Player.Stats.WIS, CK.Player.Thirst, CK.Player.MaxGravity
)

statsLabel:setStyleSheet([[
    background-color: black;
]])

statsLabel:lower()

statsLabel:echo(statsText)

function updateStats()
    local updatedStatsText = string.format([[
    &lt;div style="display: flex; justify-content: center; align-items: center; height: 100%%;"&gt;
        &lt;table style="width: 100%%; text-align: left;"&gt;
            &lt;tr&gt;
                &lt;td style="padding-right: 5px;"&gt;&lt;b&gt;INT:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
                &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;UBS:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
                &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;ARM:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;/tr&gt;
            &lt;tr&gt;
                &lt;td style="padding-right: 5px;"&gt;&lt;b&gt;STR:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
                &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;LBS:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
                &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;HIT:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;/tr&gt;
            &lt;tr&gt;
                &lt;td style="padding-right: 5px;"&gt;&lt;b&gt;SPD:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
                &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;HUNG:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
                &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;DAM:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;/tr&gt;
            &lt;tr&gt;
                &lt;td style="padding-right: 5px;"&gt;&lt;b&gt;WIS:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
                &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;THISRT:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
                &lt;td style="padding-left: 15px; padding-right: 5px;"&gt;&lt;b&gt;GRAV:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;
            &lt;/tr&gt;
        &lt;/table&gt;
    &lt;/div&gt;
    ]], 
    CK.Player.Stats.INT, CK.Player.UBS, CK.Player.Armor, 
    CK.Player.Stats.STR, CK.Player.LBS, CK.Player.Hitroll, 
    CK.Player.Stats.SPD, CK.Player.Hunger, CK.Player.Damroll, 
    CK.Player.Stats.WIS, CK.Player.Thirst, CK.Player.MaxGravity)

    statsLabel:echo(updatedStatsText)
end
</script>
					<eventHandlerList />
				</Script>
				<Script isActive="yes" isFolder="no">
					<name>targetContainer</name>
					<packageName></packageName>
					<script>local ck = require("CK")
local ROOT = ck:get_table()
local Player = ck:get_table("Player")
local API = ck:get_table("API")
local Combo = ck:get_table("API.Combo")
local Times = ck:get_table("API.Times")
local Skills = ck:get_table("API.Skills")

local gaugeContainer = Geyser.Container:new({
    name = "gaugeContainer",
    x = "45%",
    y = "90%",   
    width = "15%",
    height = "3%"  
}, BottomBar)

local targetInfoContainer = Geyser.Container:new({
    name = "targetInfoContainer",
    x = "46%", 
    y = "93%",   
    width = "13%", 
    height = "7%"   
}, BottomBar)

local targetBorderLabel = Geyser.Label:new({
    name = "targetBorderLabel",
    x = "45%", y = "90%", 
    width = "15%", height = "10%"  
}, BottomBar)

targetBorderLabel:setStyleSheet([[
    border: 4px double green;
    background-color: rgba(0, 0, 0, 0);
]])

targetBorderLabel:raise()

local bars = {}

local function createBar()
    bars["tarPowerGauge"] = Geyser.Gauge:new({
        name = "tarPowerGauge",
        x = "0%", y = "0%",  
        width = "100%",
        height = "100%"
    }, gaugeContainer)  
    
    bars["tarPowerGauge"]:setText("Powerlevel: " .. CK.Target.Health .. " / " .. CK.Target.MaxHealth)
    bars["tarPowerGauge"]:setValue(999, 9999)
    bars["tarPowerGauge"]:setAlignment("c")
    bars["tarPowerGauge"]:setStyleSheet([[background-color: rgb(0, 128, 0);]])
    bars["tarPowerGauge"].back:setStyleSheet("background-color: black;")
end

createBar()

local tarStatsLabel = Geyser.Label:new({
    name = "tarStatsLabel",
    x = "0%", y = "0%", 
    width = "100%", height = "100%",
}, targetInfoContainer)

local tarInfoText = string.format([[
    &lt;div style="display: flex; justify-content: center; align-items: center; height: 100%%;"&gt;
        &lt;table style="width: 80%%; border-spacing: 10px; text-align: left;"&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Name:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
            &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Level:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
        &lt;/table&gt;
    &lt;/div&gt;
]], 
    CK.Target.name, 
    CK.Target.level
)

tarStatsLabel:setStyleSheet([[
    background-color: rgba(0, 0, 0, 0);
    color: white;
]])

tarStatsLabel:echo(tarInfoText)
tarStatsLabel:raise()  

function updateTargetInfo()
    if CK.Target.MaxHealth &gt; 0 then
        -- Update the power gauge
        bars["tarPowerGauge"]:setValue(CK.Target.Health, CK.Target.MaxHealth)
        bars["tarPowerGauge"]:setText("Powerlevel: " .. CK.Target.Health .. " / " .. CK.Target.MaxHealth)

        -- Update the target stats text
        local tarInfoText = string.format([[
            &lt;div style="display: flex; justify-content: center; align-items: center; height: 100%%;"&gt;
                &lt;table style="width: 80%%; border-spacing: 10px; text-align: left;"&gt;
                    &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Name:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
                    &lt;tr&gt;&lt;td style="padding-right: 50px;"&gt;&lt;b&gt;Level:&lt;/b&gt;&lt;/td&gt;&lt;td&gt;&lt;b&gt;%s&lt;/b&gt;&lt;/td&gt;&lt;/tr&gt;
                &lt;/table&gt;
            &lt;/div&gt;
        ]], 
        CK.Target.name, 
        CK.Target.level)

        -- Update and show the stats label with the new information
        tarStatsLabel:echo(tarInfoText)

        -- Ensure all elements are shown
        targetInfoContainer:show()
        gaugeContainer:show()
        targetBorderLabel:show()

    else
        -- Hide all elements if MaxHealth is &lt;= 0
        targetInfoContainer:hide()
        gaugeContainer:hide()
    end
end



</script>
					<eventHandlerList />
				</Script>
				<Script isActive="yes" isFolder="no">
					<name>numberFormat</name>
					<packageName></packageName>
					<script>function formatWithCommas(number)
    -- Convert number to string and reverse it
    local formatted = tostring(number):reverse()

    -- Add commas every 3 digits
    formatted = formatted:gsub("(%d%d%d)", "%1,")

    -- Reverse the string back and remove any trailing commas
    formatted = formatted:reverse():gsub("^,", "")

    return formatted
end</script>
					<eventHandlerList />
				</Script>
			</ScriptGroup>
		</ScriptGroup>
	</ScriptPackage>
</MudletPackage>
