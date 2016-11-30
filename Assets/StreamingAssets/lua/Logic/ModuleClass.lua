local setmetatable = setmetatable  
--对象父类
ModuleClass = {}  
  
function ModuleClass:new(super)  
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
  function class:Hide()
    if(self.__Hide) then
      self.__Hide();
    end
    logWarn("隐藏该Panel----->"..self.name);
  end
 
  return class  
end  
return ModuleClass


