--Panel容器管理
PanelUtil = SingleClass:GetInstance();
local this = PanelUtil;
this.viewStack = {};--3层结构的视图管理，整个窗体只保留3个Panel，重叠调用销毁
this.foreverPanel = list:new();--永久视图列表,不受当前视图管理类管理，这里只是做一个标识。避免重复打开
this.curIndex = 0;--当前视图位置

function PanelUtil:OpenPanel(ctrl,module,fun,close,forever,...)
		if(forever) then --是否不受视图管理生命周期影响
			if(self.foreverPanel:find(module)) then--已经存在，不再放入
				return;
			else
				self.foreverPanel:push(module);
			end
		end
		local arg = {...};
		local tempFun = function (go,...)
			logWarn("回调了---------------------------->");
			local index = self:GetCurIndex();
			local oldIndex = self:FindPanelByName(module);
			local newIndex = index+1;
			logWarn(index.."="..newIndex.."找到的旧的下标---------------------------->"..(oldIndex or -1));
			local ogo = self.viewStack[index];
			if(ogo and ogo.name~=module) then --上一层Panel不为空
				if (ogo.close) then --立即销毁视图
					panelMgr:ClosePanel(ogo.name);
				else
					ogo.ctrl:Hide();
					ogo.gameObject:SetActive(false);--将上一层Panel屏蔽	
				end
			end

			if(oldIndex) then --判断是否已经存在视图栈中，如果存在修改当前位置下标。
				newIndex = oldIndex;
			end
			local newOgO = {
				["name"] = module,
				["gameObject"] = go,
				["close"] = close,
				["ctrl"] = ctrl,
			};
			self:PutViewStack(newIndex,newOgO);
			fun(go,arg);
			go:SetActive(true);
		end
		
		panelMgr:CreatePanel(module,tempFun,nil);
		logWarn(this.curIndex.."创建Panel---------------------------->"..module);
end

function PanelUtil:PutViewStack(index,ogo)
	logWarn("============================"..index);
	local old = self.viewStack[index];
	if(old and old.name~=ogo.name) then--判断原位置是否为空，并且是否跟当前Panel重复
		panelMgr:ClosePanel(old.name);
	end
	self:UpdateCurIndex(index);--重定向下标
	self.viewStack[index] = ogo;
	-- PrintTable(self.viewStack);
end

function PanelUtil:UpdateCurIndex(index)
	if (index) then
		self.curIndex = index;
	else
		self.curIndex = self.curIndex + 1;
	end
end

function PanelUtil:GetCurIndex()
	return self.curIndex%3;
end

function PanelUtil:FindPanelByName(name)
	logWarn("1111111111111111"..name);
	for i=1,#self.viewStack do 
		if self.viewStack[i] ~= nil then 
			logWarn("22222222222222222"..self.viewStack[i].name);
			if(self.viewStack[i].name==name) then
				return i;
			end
		end
	end
	return nil;
end

function PanelUtil:OpenModule(ctrlName,...)
	 local ctrl = CtrlManager.GetCtrl(ctrlName);
	 local args = {...};
	 args.moduleName = ctrlName;
    if ctrl ~= nil then
        ctrl.Awake(args);
        logWarn("创建Ctrl---------------------------->"..ctrlName);
    end
end


