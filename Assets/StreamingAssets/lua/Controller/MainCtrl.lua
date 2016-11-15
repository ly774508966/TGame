require "Common/Util/UnityMonoUtil";

MainCtrl = {};
local this = MainCtrl;

local message;
local transform;
local gameObject;

--构建函数--
function MainCtrl.New()
	logWarn("MainCtrl.New--->>");
	return this;
end

function MainCtrl.Awake()
	logWarn("MainCtrl.Awake--->>");
	panelMgr:CreatePanel('Main', this.OnCreate,nil);
end

--启动事件--
function MainCtrl.OnCreate(obj)
	gameObject = obj;
    gameObject:SetActive(true);
	local lb = gameObject:GetComponent('LuaBehaviour');
	local fun = function() logWarn("点击事件触发了~~~"); end
	UnityMonoUtil:AddOnClick(lb,MainPanel.btn_bh,fun);
	logWarn("Start lua--->>"..gameObject.name);
end

--单击事件--
function MainCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function MainCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Main);
end