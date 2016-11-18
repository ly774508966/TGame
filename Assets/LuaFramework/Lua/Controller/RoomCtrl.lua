RoomCtrl = {};
local this = RoomCtrl;

local message;
local transform;
local gameObject;

--构建函数--
function RoomCtrl.New()
	logWarn("RoomCtrl.New--->>");
	return this;
end

function RoomCtrl.Awake()
	logWarn("RoomCtrl.Awake--->>");
    local data = {name = "Tim"};
	panelMgr:CreatePanel('Room', this.OnCreate,data);
end

--启动事件--
function RoomCtrl.OnCreate(obj,source)
	gameObject = obj;
    gameObject:SetActive(true);
	message = gameObject:GetComponent('LuaBehaviour');


	logWarn("Start lua--->>"..gameObject.name);
end

--单击事件--
function RoomCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function RoomCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Message);
end