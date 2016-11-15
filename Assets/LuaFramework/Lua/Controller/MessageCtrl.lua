
MessageCtrl = {};
local this = MessageCtrl;

local message;
local transform;
local gameObject;

--构建函数--
function MessageCtrl.New()
	logWarn("MessageCtrl.New--->>");
	return this;
end

function MessageCtrl.Awake()
	logWarn("MessageCtrl.Awake--->>");
    local data = {name = "Tim"};
	panelMgr:CreatePanel('Message', this.OnCreate,data);
end

--启动事件--
function MessageCtrl.OnCreate(obj,source)
	gameObject = obj;
    gameObject:SetActive(true);
	message = gameObject:GetComponent('LuaBehaviour');
	message:AddClick(MessagePanel.btnClose, this.OnClick);
    logWarn("message source--->"..source.name);
	logWarn("Start lua--->>"..gameObject.name);
end

--单击事件--
function MessageCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function MessageCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Message);
end