-- require "Common/Util/UnityMonoUtil";
-- require "Common/Util/PanelUtil";

MainCtrl = Class:new(ModuleClass);
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
	PanelUtil:OpenPanel("Main",this.OnCreate,"tim",123);
	UpdateBeat:Add(Update,this);
	this.curDestoryCount =0;
end


function Update()
	if (Input.GetMouseButtonDown(0)) then
			if (EventSystem.current:IsPointerOverGameObject()) then
				local gb = EventSystem.current.currentSelectedGameObject;
				if gb then 
					logWarn("当前触摸在UI上---->"..gb.name);
				else
					logWarn("当前没有触摸在UI上");	
				end
			else 
				logWarn("当前触摸在外部精灵上");
			end
	end
end

--启动事件--
function MainCtrl.OnCreate(obj,arg)
	gameObject = obj;
    gameObject:SetActive(true);
	local lb = gameObject:GetComponent('LuaBehaviour');
	local fun = function(go,args) 
	logWarn("点击事件触发了~~~"..args[1]); 
	PanelUtil:OpenModule(CtrlNames.Room,args[1]);
	end
	UnityMonoUtil:AddOnClick(lb,MainPanel.btn_bh,fun,"aa");
	UnityMonoUtil:AddOnClick(lb,MainPanel.btn_bhd,fun,"bb");
	logWarn("Start lua--->>"..gameObject.name);
end

--单击事件--
function MainCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function MainCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Main);
	-- UpdateBeat:Remove(Update,this);
end