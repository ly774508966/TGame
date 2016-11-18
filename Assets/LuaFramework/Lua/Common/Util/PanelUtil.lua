--Panel容器管理
PanelUtil = {};



function PanelUtil:OpenPanel(module,fun,...)
		panelMgr:CreatePanel(module,fun,{...});
		logWarn("创建Panel---------------------------->"..module);
end

function PanelUtil:OpenModule(ctrlName,...)
	 local ctrl = CtrlManager.GetCtrl(ctrlName);
	 {...}.moduleName = ctrlName;
    if ctrl ~= nil then
        ctrl.Awake({...});
        logWarn("创建Ctrl---------------------------->"..ctrlName);
    end
end