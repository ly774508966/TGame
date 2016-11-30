
MainPanel = {};
local this = MainPanel;
--启动事件--
function MainPanel.Awake(obj)
	this.gameObject = obj;
	this.transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..this.gameObject.name);
end

--初始化面板--
function MainPanel.InitPanel()
	this.btn_bh = this.transform:FindChild("context/btn_bh").gameObject;
	this.btn_bhd = this.transform:FindChild("context/btn_bhd").gameObject;
	this.btn_nfl = this.transform:FindChild("context/btn_nfl").gameObject;
	this.btn_ml = this.transform:FindChild("context/btn_ml").gameObject;
end

--单击事件--
function MainPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
	CtrlManager.GetCtrl(CtrlNames.Main).Close();
end
