<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE MudletPackage>
<MudletPackage version="1.001">
	<AliasPackage>
		<AliasGroup isActive="yes" isFolder="yes">
			<name>CK UI</name>
			<script></script>
			<command></command>
			<packageName></packageName>
			<regex></regex>
			<Alias isActive="yes" isFolder="no">
				<name>RightPanelWidth</name>
				<script>rightPanelWidth = matches[2]

moveMapConsole()
moveChatConsole()
adjustLayout()</script>
				<command></command>
				<packageName></packageName>
				<regex>^CK adjustright (.+)$</regex>
			</Alias>
			<Alias isActive="yes" isFolder="no">
				<name>BottomPanelHeight</name>
				<script>bottomPanelHeight = matches[2]

adjustLayout()</script>
				<command></command>
				<packageName></packageName>
				<regex>^CK adjustbottom (.+)$</regex>
			</Alias>
		</AliasGroup>
	</AliasPackage>
</MudletPackage>
