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
	this.btn_callback = UnityMonoUtil.FindChild(gameObject,"context/btn_callcak");
	this.boom_platfrom = UnityMonoUtil.FindChild(gameObject,"context/em_boom/img_boom_4");
	this.boom_Emp = UnityMonoUtil.FindChild(gameObject,"context/em_boom/boom_fam");
	this.boom = UnityMonoUtil.FindChild(this.boom_Emp,"boom");

	this.t = UnityMonoUtil.FindChild(gameObject,"top/t");
	this.d = UnityMonoUtil.FindChild(gameObject,"top/d");
	this.l = UnityMonoUtil.FindChild(gameObject,"top/l");
	this.r = UnityMonoUtil.FindChild(gameObject,"top/r");

	this.boom:SetActive(false);
end

--单击事件--
function RoomPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end