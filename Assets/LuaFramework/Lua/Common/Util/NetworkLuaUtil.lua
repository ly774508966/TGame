require "3rd/pbc/protobuf"

Event = require 'events'

NetworkLuaUtil = {};
local this = NetworkLuaUtil;
this.rid = 0;
function NetworkLuaUtil.sendMessage(sid,func,...)
	local data = NetworkLuaUtil.getMo({...});
	local rid = NetworkLuaUtil.getRid();
	Event.AddListener(tostring(rid),func);
	local buffer = ByteBuffer.New();
	buffer:WriteInt(rid);
	buffer:WriteInt(sid);
    buffer:WriteBuffer(data);
    networkMgr:SendMessage(buffer);
end

function NetworkLuaUtil.getData(_name,_sd)
	logWarn("------------------->"..type(protobuf));
	local data = _sd:ReadBuffer();
  	local pData = protobuf.decode("com.ftkj.proto.".._name,data);
  	return pData;
end


function NetworkLuaUtil.getMo(val)
    local temp = "";
    if val ~= nil and #val >=1 then 
        for k,v in ipairs(val) do  
            temp = temp..v.."Ω";
        end
    end
    local mo = {
        msg = "";
    }
    mo.msg = temp;
    log("获得Mo数据"..mo.msg..type(protobuf));
    local data = protobuf.encode("com.ftkj.proto.MoData",mo);
    log("测试打印-->"..tostring(data));
    return data;
end


function NetworkLuaUtil.getRid()
    this.rid = this.rid + 1;
    if this.rid > 10000 then
        this.rid = 1;
    end
    return this.rid;
end

function NetworkLuaUtil.RegisterProtoPB(pName)
    local path = Util.DataPath.."lua/3rd/pbc/"..pName..".pb";
    log("初始化PB--->"..path.."下的"..pName);
    local addr = io.open(path, "rb")
    local buffer = addr:read "*a"
    addr:close()
    protobuf.register(buffer)
end

function NetworkLuaUtil.getpathes(rootpath, pathes)
	print("------------------------>jinlaile")
    pathes = pathes or {}
    for entry in lfs.dir(rootpath) do
        if entry ~= '.' and entry ~= '..' then
            local path = rootpath .. '\\' .. entry
            local attr = lfs.attributes(path)
            assert(type(attr) == 'table')
            
            if attr.mode == 'directory' then
                getpathes(path, pathes)
            else
                table.insert(pathes, path)
            end
        end
    end
    return pathes
end