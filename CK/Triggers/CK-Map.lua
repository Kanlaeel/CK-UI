<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MudletPackage>
<MudletPackage version="1.001">
	<TriggerPackage>
		<TriggerGroup isActive="yes" isFolder="yes" isTempTrigger="no" isMultiline="no" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
			<name>CK-Map</name>
			<script></script>
			<triggerType>0</triggerType>
			<conditonLineDelta>0</conditonLineDelta>
			<mStayOpen>0</mStayOpen>
			<mCommand></mCommand>
			<packageName>CK-Map</packageName>
			<mFgColor>#ff0000</mFgColor>
			<mBgColor>#ffff00</mBgColor>
			<mSoundFile></mSoundFile>
			<colorTriggerFgColor>#000000</colorTriggerFgColor>
			<colorTriggerBgColor>#000000</colorTriggerBgColor>
			<regexCodeList />
			<regexCodePropertyList />
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="yes" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Capture City Map</name>
				<script>local map = CK.map
local console = map.console
local container = map.container

if map.last ~= 1 then
      container.x = (100 - rightPanelWidth).."%"
      container.y = "0%"
      container.width = rightPanelWidth.."%"
      container.height = "50%"
      container:resize()
end


console:clear()
moveCursor(0, getLineNumber() - 18)
for i = 0, 16, 1 do
    moveCursor(0, getLineNumber() + 1)
    selectCurrentLine()
    copy()
    console:appendBuffer()
    deselect()
end

map.last = 1

moveCursor(0, getLineNumber() - 12)
for i = 0, 11, 1 do
    gagLine()
end</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>1</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>o---------------------------------o</string>
					<string>Obvious exits:</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>3</integer>
					<integer>3</integer>
				</regexCodePropertyList>
			</Trigger>
			<Trigger isActive="yes" isFolder="no" isTempTrigger="no" isMultiline="yes" isPerlSlashGOption="no" isColorizerTrigger="no" isFilterTrigger="no" isSoundTrigger="no" isColorTrigger="no" isColorTriggerFg="no" isColorTriggerBg="no">
				<name>Capture Wilderness Map</name>
				<script>local map = CK.map
local console = map.console
local container = map.container

if map.last ~= 2 then
      container.x = (100 - rightPanelWidth).."%"
      container.y = "0%"
      container.width = rightPanelWidth.."%"
      container.height = "50%"
      container:resize()
end

console:clear()
moveCursor(0, getLineNumber() - 18)
for i = 0, 16, 1 do
    moveCursor(0, getLineNumber() + 1)
    selectCurrentLine()
    copy()
    console:appendBuffer()
    deselect()
end

map.last = 2

moveCursor(0, getLineNumber() - 12)
for i = 0, 11, 1 do
    gagLine()
end</script>
				<triggerType>0</triggerType>
				<conditonLineDelta>1</conditonLineDelta>
				<mStayOpen>0</mStayOpen>
				<mCommand></mCommand>
				<packageName></packageName>
				<mFgColor>#ff0000</mFgColor>
				<mBgColor>#ffff00</mBgColor>
				<mSoundFile></mSoundFile>
				<colorTriggerFgColor>#000000</colorTriggerFgColor>
				<colorTriggerBgColor>#000000</colorTriggerBgColor>
				<regexCodeList>
					<string>o------------------------------------------------------------o</string>
					<string>Obvious exits:</string>
				</regexCodeList>
				<regexCodePropertyList>
					<integer>3</integer>
					<integer>3</integer>
				</regexCodePropertyList>
			</Trigger>
		</TriggerGroup>
	</TriggerPackage>
</MudletPackage>
