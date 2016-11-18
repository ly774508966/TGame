local transform;
local gameObject;

RoomPanel = {};
local this = RoomPanel;

--启动事件--
function RoomPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function RoomPanel.InitPanel()
	
end

--单击事件--
function RoomPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end