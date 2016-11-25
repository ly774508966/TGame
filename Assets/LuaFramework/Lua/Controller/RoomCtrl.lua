RoomCtrl = ModuleClass:new(nil);
local this = RoomCtrl;

local message;
local transform;
local gameObject;

--构建函数--
function RoomCtrl.New()
	logWarn("RoomCtrl.New--->>");
	this.name = CtrlNames.Room;
	return this;
end

function RoomCtrl.Awake()
	logWarn("RoomCtrl.Awake--->>");
    local data = {name = "Tim"};
	PanelUtil:OpenPanel(this,'Room', this.OnCreate,false,false,data);

end


--启动事件--
function RoomCtrl.OnCreate(obj,new)
	gameObject = obj;
	lb = gameObject:GetComponent('LuaBehaviour');
	UnityMonoUtil:AddOnClick(lb,RoomPanel.btn_callback,function(go) PanelUtil:OpenModule(CtrlNames.Main); end);
	logWarn("Start lua--->>"..gameObject.name);
	-- UpdateBeat:Add(this.Update,this);
end

--单击事件--
function RoomCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function RoomCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Message);
end