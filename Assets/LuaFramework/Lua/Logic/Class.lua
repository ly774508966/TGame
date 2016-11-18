local setmetatable = setmetatable  
--对象父类
Class = {}  
  
function Class:new(super)  
  local class = {}  
  class.__index = class  
    
  local mt = {}  
  setmetatable(class, mt)  
  if super then   
    mt.__index = super  
  end  
  function class:new(...)  
    local obj = {}  
        setmetatable(obj, self)  
        if obj.__new then  
            obj:__new(...)  
        end  
        return obj  
    end  
    return class  
end  
  
return Class

-- local AA = Class:new();
-- AA.b = "cc";
-- function AA:cal(x,y)
--   return self:aa();
-- end
-- local BB = Class:new(AA);
-- BB.b="dd";
-- function BB:aa()
--   return 2;
-- end

-- print(AA:cal(2,1));
-- print(BB:cal(5,2));
-- print(AA:aa());
