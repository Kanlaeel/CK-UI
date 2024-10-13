<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MudletPackage>
<MudletPackage version="1.001">
	<ScriptPackage>
		<ScriptGroup isActive="yes" isFolder="yes">
			<name>CK-Map</name>
			<packageName>CK-Map</packageName>
			<script></script>
			<eventHandlerList />
			<Script isActive="yes" isFolder="no">
				<name>CK-Map</name>
				<packageName></packageName>
				<script>local ck = require("CK")
ck:register("CK-Map", "24.09.06")
local map = ck:get_table("map")

local function create_container()
  local default_constraints =
    {
      name = "MapContainer",
      x = (100 - rightPanelWidth).."%",
      y = "0%",
      width = rightPanelWidth.."%",
      height = "50%",
      titleText = "Map",
    }
  local adjLabelStyle =
    Geyser.StyleSheet:new(
      [[
  background-color: rgba(0,0,0,100%);
  border: 4px double;
  border-color: green;
  border-radius: 4px;]]
    )
  default_constraints.adjLabelstyle = adjLabelStyle:getCSS()
  return Adjustable.Container:new(default_constraints)
end

local function create_console()
  console =
    Geyser.MiniConsole:new(
      {
        name = "MapConsole",
        x = 0,
        y = "1%",
        autoWrap = false,
        color = "black",
        scrollBar = false,
        fontSize = 10,
        width = "100%",
        height = "99%",
      },
      map.container
    )
  return console
end

map.container = map.container or create_container()
map.console = map.console or create_console()

function moveMapConsole()
  if map.container then
    map.container:move((100 - rightPanelWidth).."%", "0%") 
    map.container:resize(rightPanelWidth.."%", "50%")
    map.container:raise()  
  end
end

moveMapConsole()
</script>
				<eventHandlerList />
			</Script>
		</ScriptGroup>
	</ScriptPackage>
</MudletPackage>
