FancyPanel = {};
local this = FancyPanel;
--启动事件--
function FancyPanel.Awake(obj)
	this.gameObject = obj;
	this.transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..this.gameObject.name);
end

--初始化面板--
function FancyPanel.InitPanel()
	this.vp = UnityMonoUtil.FindChild(this.gameObject,"context/bg/Viewport");
	this.bg = UnityMonoUtil.FindChild(this.vp,"Content");
	this.gjt = UnityMonoUtil.FindChild(this.gameObject,"top/gj/Viewport/Content");
	this.dt = UnityMonoUtil.FindChild(this.bg,"Image");
	this.bg.transform.sizeDelta = Vector2.New(this.dt.transform.sizeDelta.x,this.dt.transform.sizeDelta.y);
	this.comp = UnityMonoUtil.FindChild(this.bg,"comp");
	this.lt = UnityMonoUtil.FindChild(this.vp,"lt");
	this.rd = UnityMonoUtil.FindChild(this.vp,"rd");
	this.save = UnityMonoUtil.FindChild(this.gameObject,"top/save");
	this.next = UnityMonoUtil.FindChild(this.gameObject,"top/next");
	--this.tx = UnityMonoUtil.GetComponentsInChildren(this.gjt,"MoveBehaviourScript",true);
	this.init = UnityMonoUtil.FindChild(this.vp,"init");
	this.canvas = UnityMonoUtil.Find("/Canvas");

	-- for i=0,this.tx.Length-1 do 
	-- 	this.tx[i].canvas = this.canvas.transform;
	-- 	logWarn(i.."---------------------->"..this.tx[i].gameObject.name);
	-- end
	-- this.i1 = UnityMonoUtil.GetComponent(this.gameObject,"MoveBehaviourScript");
end

--单击事件--
function FancyPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
	CtrlManager.GetCtrl(CtrlNames.Fancy).Close();
end