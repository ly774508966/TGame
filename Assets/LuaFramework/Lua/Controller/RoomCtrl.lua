require "Game/Room/CPBoom"

RoomCtrl = ModuleClass:new(nil);
local this = RoomCtrl;

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
	PanelUtil:OpenPanel(this,ModuleNames.Room, this.OnCreate,false,false,data);

end

--启动事件--
function RoomCtrl.OnCreate(obj,new)
	gameObject = obj;
	transform = gameObject.transform;
	this.camera = Camera.allCameras[1];
	lb = gameObject:GetComponent('LuaBehaviour');
	UnityMonoUtil.AddOnClick(lb,RoomPanel.btn_callback,function(go) PanelUtil:OpenModule(CtrlNames.Main); end);
	logWarn("Start lua--->>"..gameObject.name);
	UnityMonoUtil.AddTriggerEvent(RoomPanel.t,function (oth) logWarn("碰撞了！！！"..oth.name.."--"..RoomPanel.t.name)end,nil,nil);
	UnityMonoUtil.AddTriggerEvent(RoomPanel.d,function (oth) logWarn("碰撞了！！！"..oth.name.."--"..RoomPanel.d.name)end,nil,nil);
	UnityMonoUtil.AddTriggerEvent(RoomPanel.l,function (oth) logWarn("碰撞了！！！"..oth.name.."--"..RoomPanel.l.name)end,nil,nil);
	UnityMonoUtil.AddTriggerEvent(RoomPanel.r,function (oth) logWarn("碰撞了！！！"..oth.name.."--"..RoomPanel.r.name)end,nil,nil);
	UpdateBeat:Add(this.Update,this);
end

function RoomCtrl.WallTriggerEnter()


end


function RoomCtrl:Update()
	if (Input.GetMouseButtonDown(0)) then
			if (EventSystem.current:IsPointerOverGameObject()) then
				local gb = EventSystem.current.currentSelectedGameObject;
				if gb then 
					-- logWarn("当前触摸在UI上---->"..gb.name);
				else
					
					-- logWarn("当前摄像机:"..camera.tag);
					local v3 = Input.mousePosition;
					-- logWarn("当前鼠标点击坐标为:"..v3.x..":"..v3.y..":"..v3.z);
					local screenpos = this.camera:ScreenToWorldPoint(v3);
					-- logWarn("当前鼠标点击屏幕坐标为:"..screenpos.x..":"..screenpos.y..":"..screenpos.z);
					local np = screenpos-RoomPanel.boom_platfrom.transform.position;
					-- logWarn("旋转坐标为:"..np.x..":"..np.y..":"..np.z);
					RoomPanel.boom_platfrom.transform.rotation = Quaternion.FromToRotation(Vector3.up,np);
					local nBoom = newObject(RoomPanel.boom);
					-- logWarn("旧子弹坐标:"..RoomPanel.boom.transform.position.x..":"..RoomPanel.boom.transform.position.y..":"..RoomPanel.boom.transform.position.z);
					CPBoom:new(nBoom,screenpos,RoomPanel.boom_Emp);
				end
			else 
				logWarn("当前触摸在外部精灵上");
			end
	end
end

function RoomCtrl:BoomUpdate()



end

function RoomCtrl:__Hide()
	UpdateBeat:Remove(this.Update,this);
end

--单击事件--
function RoomCtrl.OnClick(go)
	destroy(gameObject);
end

--关闭事件--
function RoomCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Message);
end