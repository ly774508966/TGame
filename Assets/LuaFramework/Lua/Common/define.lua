
CtrlNames = {
	-- Prompt = "PromptCtrl",
	-- Message = "MessageCtrl",
	Main = "MainCtrl",
	Room = "RoomCtrl"
}

PanelNames = {
	-- "PromptPanel",	
	-- "MessagePanel",
	"MainPanel",
	"RoomPanel",
}

UtilNames = {
	"NetworkLuaUtil",
	"PanelUtil",
	"UnityMonoUtil",
}

ModuleNames = {
	Main = "Main",
	Room = "Room"
}

--协议类型--
ProtocalType = {
	BINARY = 0,
	PB_LUA = 1,
	PBC = 2,
	SPROTO = 3,
}
--当前使用的协议类型--
TestProtoType = ProtocalType.BINARY;

Util = LuaFramework.Util;
AppConst = LuaFramework.AppConst;
LuaHelper = LuaFramework.LuaHelper;
ByteBuffer = LuaFramework.ByteBuffer;
Input = UnityEngine.Input;
EventSystem = UnityEngine.EventSystems.EventSystem;

resMgr = LuaHelper.GetResManager();
panelMgr = LuaHelper.GetPanelManager();
soundMgr = LuaHelper.GetSoundManager();
networkMgr = LuaHelper.GetNetManager();

WWW = UnityEngine.WWW;
GameObject = UnityEngine.GameObject;