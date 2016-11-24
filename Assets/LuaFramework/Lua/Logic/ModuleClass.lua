
local ModuleClass = Class:new();
  
function ModuleClass:__new()
	self.forever = false;
	self.destoryCount = 5;--默认销毁次数，当玩家操作窗口该次数还没激活这个模块时，会销毁相关信息
	self.curDestoryCount = 0;--当前容器生命周期
	self.isCal = true;--打开容器时是否增加生命次数
end




function ModuleClass:destory()
	if (self.destoryCount==0 or self.curDestoryCount>=self.destoryCount) then
		logWarn("模块达到生命周，销毁模块");
		self:Close();
	end
end






