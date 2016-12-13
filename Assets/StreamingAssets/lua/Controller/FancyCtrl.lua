FancyCtrl = ModuleClass:new(nil);
local this = FancyCtrl;

local transform;
local gameObject;

--构建函数--
function FancyCtrl.New()
	logWarn("FancyCtrl.New--->>");
	this.name = CtrlNames.Room;
	this.boomList = {};
	return this;
end

function FancyCtrl.Awake(tp)
	logWarn("FancyCtrl.Awake--->>"..tp[1]);
    -- local data = {name = "Sam"};
    this.type = tp[1];
	PanelUtil:OpenPanel(this,ModuleNames.Fancy, this.OnCreate,false,false);
end

--启动事件--
function FancyCtrl.OnCreate(obj,new)
	gameObject = obj;
	transform = gameObject.transform;
	this.lb = gameObject:GetComponent('LuaBehaviour');
	logWarn("打开的工具条类型"..this.type);
	
	PanelUtil:CreatePrefab("fancy",this.InitGJT,this.type);
	
	-- this.camera = Camera.allCameras[1];
	-- UnityMonoUtil.AddOnClick(lb,RoomPanel.btn_callback,function(go) PanelUtil:OpenModule(CtrlNames.Main); end);
	-- logWarn("Start lua--->>"..gameObject.name);
	-- local triggerFun = function (oth)
	-- 	if(oth.tag ~= "Wall") then 
	-- 		logWarn("碰撞了！！！"..oth.name.."--"..RoomPanel.t.name);
	-- 		local sc = this.boomList[oth.name];
	-- 		if(sc ~=nil) then
	-- 			sc:Destroy();
	-- 			this.boomList[oth.name] = nil;
	-- 		end
	-- 	end 
	-- end
	-- UnityMonoUtil.AddTriggerEvent(RoomPanel.t,triggerFun,nil,nil);
	-- UnityMonoUtil.AddTriggerEvent(RoomPanel.d,triggerFun,nil,nil);
	-- UnityMonoUtil.AddTriggerEvent(RoomPanel.l,triggerFun,nil,nil);
	-- UnityMonoUtil.AddTriggerEvent(RoomPanel.r,triggerFun,nil,nil);
	-- UpdateBeat:Add(this.Update,this);
end

function FancyCtrl.OnSaveClick()
	this.saveLast = true;
end

function FancyCtrl.OnNextClick()
	 PanelUtil:OpenModule(CtrlNames.Fancy,"sun");
end

function FancyCtrl.InitGJT(objs)
	local go = newObject(objs[0]);
	-- go:SetActive(false);
	local count = 0;
	while go.transform.childCount>0 do
		local cl = go.transform:GetChild(0);
		-- cl.gameObject:SetActive(true);
		-- cl.gameObject:SetActive(false);
		cl.transform.parent = FancyPanel.gjt.transform;
		cl.gameObject.layer = FancyPanel.gjt.layer;
		cl.transform.localPosition = Vector3.New(cl.transform.localPosition.x,cl.transform.localPosition.y,0);
		cl.transform.localScale = Vector3.New(1,1,1);
		-- logWarn(type(this.lb).."加载了一个工具------>"..type(cl.gameObject).."--"..type(this.GJOnClick));
		local gj = cl.transform:GetChild(0);
		UnityMonoUtil.AddOnClick(this.lb,gj.gameObject,this.GJOnClick);
		count = count +1;
	end
	-- logWarn("工具数量-------->"..count);
	local count = (5 - count) * 125;
	-- logWarn("工具数量-------->"..count);
	if count < 0  then
		local rtf  = FancyPanel.gjt.transform;
		-- logWarn("工具数量-------->x="..rtf.sizeDelta.x.."y="..rtf.sizeDelta.y);
		rtf.sizeDelta = Vector2.New(rtf.sizeDelta.x-count,rtf.sizeDelta.y);
	end
	UnityMonoUtil.Destroy(go);
end

function FancyCtrl.GJOnClick(go)
	-- logWarn("点击事件触发"..type(go));
	local ngo = newObject(go);
	ngo.transform.parent = FancyPanel.comp.transform;
	ngo.transform.anchoredPosition = Vector2.New(FancyPanel.init.transform.anchoredPosition.x,FancyPanel.init.transform.anchoredPosition.y);
	ngo.transform.localScale = Vector3.New(1,1,1);
	ngo.gameObject.name = go.name;
	local mv =  UnityMonoUtil.AddComponent(ngo,"MoveBehaviourScript");
	local btn = UnityMonoUtil.GetComponent(ngo,"Button");
	UnityMonoUtil.Destroy(btn);
	mv.canvas = FancyPanel.canvas.transform;
	mv.lt = FancyPanel.lt.transform;
	mv.rd = FancyPanel.rd.transform;
	local ags = split(ngo.gameObject.name,"-");
	logWarn("Name="..ags[1].."|"..ags[2].."|"..ags[3]);
	local x,y=tonumber(ags[2]),tonumber(ags[3]);
	logWarn("图形实际大小为x="..x.."y="..y);
	local rtf  = UnityMonoUtil.GetComponent(ngo,"RectTransform");
	-- local rtf  = ngo.transform;
 --    x = -x - rtf.offsetMin.x + rtf.offsetMax.x;
 --    y = -y - rtf.offsetMin.y + rtf.offsetMax.y;
 --    rtf.offsetMin = Vector2.New( rtf.offsetMin.x + rtf.pivot.x * x, rtf.offsetMin.y + rtf.pivot.y * y);
 --    rtf.offsetMax = Vector2.New( -(-rtf.offsetMax.x + (1-rtf.pivot.x) * x),-(-rtf.offsetMax.y + (1-rtf.pivot.y) * y));
	logWarn("图形默认大小为x="..rtf.sizeDelta.x.."y="..rtf.sizeDelta.y);
	local v2 = Vector2.New(x,y);
	rtf.sizeDelta = v2;
	logWarn("图形修改后大小为x="..rtf.sizeDelta.x.."y="..rtf.sizeDelta.y);
end


function FancyCtrl:__Hide()
	-- UpdateBeat:Remove(this.Update,this);
end

--关闭事件--
function FancyCtrl.Close()
	panelMgr:ClosePanel(CtrlNames.Message);
end