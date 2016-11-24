local transform;
local gameObject;

MainPanel = {};
local this = MainPanel;

--启动事件--
function MainPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end

--初始化面板--
function MainPanel.InitPanel()
	this.btn_bh = transform:FindChild("context/btn_bh").gameObject;
	this.btn_bhd = transform:FindChild("context/btn_bhd").gameObject;
	this.btn_nfl = transform:FindChild("context/btn_nfl").gameObject;
	this.btn_ml = transform:FindChild("context/btn_ml").gameObject;
end

--单击事件--
function MainPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
	CtrlManager.GetCtrl(CtrlNames.Main).Close();
end
