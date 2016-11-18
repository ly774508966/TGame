map = {}

local this = map

function this:new()
    o = {}
    setmetatable(o,self)
    self.__index = self
    self.count = 0
    return o
end

function this:insert(k,v)

    if nil == self[k] then
        --table.insert(self,{a = b})
        self[k] = v
        self.count = self.count + 1
        print("insert")
    end
    print("insert end")
end

function this:remove(k)
    if nil ~= self[k] then
        self[k] = nil
        if self.count >0 then
            self.count = self.count - 1
        end
    end
end

function this:getpair(k)
    local value = nil
    if nil ~= self[k] then
        value = self[k]
        print("getpair")
    end
    return value
end

function this:clear()
    for k,_ in pairs(self) do
        if nil ~= self[k] then
            self[k] = nil
        end
    end
    self.count = 0
end

-- local characters = map:new()

-- characters:insert("name1"," this Name:123")
-- characters:remove("name1")
-- characters:insert("name2","this Name:2")

-- local name2 = characters:getpair("name2")
-- print(name2)

-- print(characters.count)

-- for k,v in pairs(characters) do
--     print(k,v)
-- end