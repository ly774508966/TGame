require "Logic/Class";
--单例父类
SingleClass = Class:new(nil);

local this = SingleClass;

function this:GetInstance()
    if nil == self.m_Instance then
        self.m_Instance= self:new();
    end
    return self.m_Instance;
end
