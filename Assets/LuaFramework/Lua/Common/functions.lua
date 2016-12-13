
--输出日志--
function log(str)
    Util.Log(str);
end

--错误日志--
function logError(str) 
	Util.LogError(str);
end

--警告日志--
function logWarn(str) 
	Util.LogWarning(str);
end

--查找对象--
function find(str)
	return GameObject.Find(str);
end

function destroy(obj)
	GameObject.Destroy(obj);
end

function newObject(prefab)
	return GameObject.Instantiate(prefab);
end

--创建面板--
function createPanel(name)
	PanelManager:CreatePanel(name);
end

function child(str)
	return transform:FindChild(str);
end

function subGet(childNode, typeName)		
	return child(childNode):GetComponent(typeName);
end

function findPanel(str) 
	local obj = find(str);
	if obj == nil then
		error(str.." is null");
		return nil;
	end
	return obj:GetComponent("BaseLua");
end

function split(str, delimiter)
  if str==nil or str=='' or delimiter==nil then
    return nil
  end
  
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function PrintTable( tbl , level, filteDefault,str)
  local msg = ""
  filteDefault = filteDefault or true --默认过滤关键字（DeleteMe, _class_type）
  level = level or 1
  str = str or ""
  local indent_str = ""
  for i = 1, level do
    indent_str = indent_str.."  "
  end
  str = str..indent_str .. "{"
  for k,v in pairs(tbl) do
    if filteDefault then
      if k ~= "_class_type" and k ~= "DeleteMe" then
        local item_str = string.format("%s%s = %s", indent_str .. " ",tostring(k), tostring(v))
        str = str..item_str;
        if type(v) == "table" then
          PrintTable(v, level + 1,nil,str)
        end
      end
    else
      local item_str = string.format("%s%s = %s", indent_str .. " ",tostring(k), tostring(v))
      str = str..item_str;
      if type(v) == "table" then
        PrintTable(v, level + 1,nil,str)
      end
    end
  end
  logWarn(str .. "}");
end


