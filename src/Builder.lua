---Builder - create and manage tree of controls
require ("Control")
require ("Stack")
require ("List")
require ("ListItem")
require ("Icon")
require ("Text")
require ("Line")

Builder = {}
Builder.Classes = {}
Builder.Root = {}
Builder.Controls = {}
Builder.curr_desc = {}
Builder.Classes["Control"] = Control
Builder.Classes["Stack"] = Stack
Builder.Classes["List"] = List
Builder.Classes["ListItem"] = ListItem
Builder.Classes["Icon"] = Icon
Builder.Classes["Text"] = Text
Builder.Classes["Line"] = Line

---Create a tree of controls depends on xml file
-- @param self
-- @param root main level of xml tree. Must include node <MmiDescription>
-- @return nothing
function Builder:make(root)
  self.mmi = root.MmiDescription
  local name, class = self:find_startup()
  local ctrl_desc = self:find(class, name)
  self:add_control(class, name, ctrl_desc)
  table.sort(self.Controls)
  self:print_controls()
end

function Builder:print_controls()
  for k,v in pairs(self.Controls) do
    local parent = v.parent
    if parent == nil then
      print(v.class.."("..k..") -> nil")
    elseif self.Controls[parent] == nil then
      print(v.class.."("..k..") -> invalid parent")
    else
      print(v.class.."("..k..") -> "..self.Controls[parent].class.."("..parent..")")
    end
  end
end

function Builder:add_control(class, name, ctrl_desc)
  self:make_control(class,ctrl_desc._attr)
  if ctrl_desc.Ref ~= nil then
    for _, ref in pairs(ctrl_desc.Ref) do
      local class_child = ref._attr.class
      local name_child = ref._attr.name
      local ctrl_desc_child = self:find(class_child, name_child)
      self:add_control(class_child, name_child, ctrl_desc_child)
      self.Controls[name_child].parent = name
    end
    return
  else
    for k, v in pairs(ctrl_desc) do
      if self.Classes[k] ~= nil and v._attr ~= nil then
        local class_child = k
        local name_child = v._attr.name
        local ctrl_desc_child = v
        self:add_control(class_child, name_child, ctrl_desc_child)
        self.Controls[name_child].parent = name
      elseif self.Classes[k] ~= nil and v._attr == nil then
        for k1, v1 in pairs(v) do
          local class_child = k
          local name_child = v1._attr.name
          local ctrl_desc_child = v1
          self:add_control(class_child, name_child, ctrl_desc_child)
          self.Controls[name_child].parent = name
        end
      elseif type(k) == "number" and type(v) == "string" then
        self.Controls[name].value = v
      end
    end
    return
  end
end

function Builder:make_control(class, props)
  self.Controls[props.name] = self.Classes[class](props)
end

function Builder:find_startup()
  if self.mmi == nil then return nil, nil end
  if self.mmi.Parameters == nil then return nil, nil end
  if self.mmi.Parameters.Startup == nil then return nil, nil end
  return self.mmi.Parameters.Startup._attr.name, self.mmi.Parameters.Startup._attr.class
end

function Builder:find(class, name, root)
  if class == nil then return end
  if name == nil then return end
  if root ==nil then root = self.mmi end

  for key, value in pairs(root) do
    if (key == class) then
      for _, value1 in pairs(value) do
        if value1._attr.name == name then
          return value1
        end
      end
    end
  end
end

function Builder:debug(var, level)
  if level == nil then level = 0 end

  if (type(var) == "table") then
    for k, v in pairs(var) do
      local msg = ""
      if type(v) ~= "table" then
        msg = string.rep(" ", level)..k.."="..v
      else
        msg = string.rep(" ", level)..k
      end
      print (msg)
      if (type(v) == "table") then
        self:debug(v, level + 1)
      end
    end
  end
end

function Builder:find_root_ctrl()
  for k, v in pairs(self.Controls) do
    if v.parent == nil then return v end
  end
end
