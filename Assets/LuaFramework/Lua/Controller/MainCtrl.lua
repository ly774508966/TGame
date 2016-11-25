-- require "Common/Util/UnityMonoUtil";
-- require "Common/Util/PanelUtil";

MainCtrl = ModuleClass:new(nil);
local this = MainCtrl;

local message;
local transform;
local gameObject;

--构建函数--
function MainCtrl.New()
	logWarn("MainCtrl.New--->>");
	this.name = CtrlNames.Main;
	return this;
end

function MainCtrl.Awake()
	logWarn("MainCtrl.Awake--->>");
	PanelUtil:OpenPanel(this,"Main",this.OnCreate,false,false,"tim",123);
	this.curDestoryCount =0;
end


function MainCtrl.Update()
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
	local lb = gameObject:GetComponent('LuaBehaviour');
	logWarn("创建传参------------------->>"..arg[1]);
	local fun = function(go,args) 
		logWarn("点击事件触发了~~~"..args[1]); 
		PanelUtil:OpenModule(CtrlNames.Room,args[1]);
	end
	UnityMonoUtil:AddOnClick(lb,MainPanel.btn_bh,fun,"aa");
	UnityMonoUtil:AddOnClick(lb,MainPanel.btn_bhd,fun,"bb");
	UpdateBeat:Add(this.Update,this);
	logWarn("Start lua--->>"..gameObject.name);
end

function MainCtrl.__Hide()
	UpdateBeat:Remove(this.Update,this);
end


--单击事件--
function MainCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function MainCtrl.Close()
	-- panelMgr:ClosePanel(CtrlNames.Main);
	logWarn("-----------------------------------关闭Panel了！！！");
	UpdateBeat:Remove(this.Update,this);
end