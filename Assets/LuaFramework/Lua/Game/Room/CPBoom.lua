CPBoom = Class:new(nil);
local speed = 50;
local tags = 1;
function CPBoom:__new(go,target,parent)
	self.gameobject = go;
	tags = tags + 1;
	self.gameobject.name = self.gameobject.name.."_"..tags;
	self.target = parent.transform:InverseTransformPoint(target)*1173;
	-- self.target = target;
	self.gameobject.transform:SetParent(parent.transform);
	self.gameobject.transform.localPosition = Vector3.zero;
	-- self.gameobject.transform.position = Vector3.zero;
	-- logWarn("新子弹坐标:"..self.gameobject.transform.localPosition.x..":"..self.gameobject.transform.localPosition.y..":"..self.gameobject.transform.localPosition.z);
	self.gameobject:SetActive(true);
	-- logWarn("1222222222222222222222");
	-- logWarn("新子弹坐标:"..self.gameobject.transform.position.x..":"..self.gameobject.transform.position.y..":"..self.gameobject.transform.position.z);
	self.gameobject.transform.position.z = 0;
	self.target.z = 0;
	-- logWarn("新子弹坐标:"..self.gameobject.transform.position.x..":"..self.gameobject.transform.position.y..":"..self.gameobject.transform.position.z);
	-- logWarn("新目标坐标:"..self.target.x..":"..self.target.y..":"..self.target.z);
	
	-- self.gameobject.transform.localPosition.z =0;
	FixedUpdateBeat:Add(self.Update,self);
	-- UnityMonoUtil:Destroy(self.gameobject,3);
	return self;
end


function CPBoom:Update()
	local step = speed * Time.deltaTime;  
	-- self.gameobject.transform:Translate(self.target * step,Space.Self);
    self.gameobject.transform.localPosition = Vector3.MoveTowards(self.gameobject.transform.localPosition, self.target, step);
    -- logWarn(self.gameobject.transform.position.x..","..self.gameobject.transform.position.y);
    -- self.gameobject.transform.localPosition = 
    -- self.gameobject.transform.localPosition = Vector3.Slerp(self.gameobject.transform.localPosition, self.target, step);
end

function CPBoom:Destroy()
	FixedUpdateBeat:Remove(self.Update,self);
	UnityMonoUtil.Destroy(self.gameobject); 
end