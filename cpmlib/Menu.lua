-- Menu class
local Control = require('cpmlib.Control')
local MenuItem = require('cpmlib.MenuItem')
local Menu = class(Control)

function Menu:init(attrs, logger)
  Control.init(self, attrs, logger)
  self._items = {}
  self._visibleItems = {}
  self._selectedIndex = 0
  self._firstIndex = 1
  self._lastIndex = 4
end

function Menu:getItem(index)
  if index > #self._items or index == 0 then return end
  return self._items[index]
end

function Menu:append(item)
  if not item:is_a(MenuItem) then return end
  table.insert(self._items, item)
end

function Menu:insert(item, index)
  if not item:is_a(MenuItem) then return end
  if index > #self._items or index == 0 then return end
  table.insert(self._items, index, item)
end

function Menu:getSelectedIndex()
  return self._selectedIndex
end

function Menu:getSelectedItem()
  return self._items[self:getSelectedIndex()]
end

function Menu:onMoveDown(sender)
  self:getSelectedItem():setSelected(false)
  self._selectedIndex = self._selectedIndex == #self._items and 
                        self._selectedIndex or 
                        self._selectedIndex + 1
  self:getSelectedItem():setSelected(true)
  if self._selectedIndex > self._lastIndex then
    
  end
end

function Menu:onMoveUp(sender)
  self:getSelectedItem():setSelected(false)
  self._selectedIndex = self._selectedIndex == 0 and
                        self._selectedIndex or
                        self._selectedIndex - 1
  self:getSelectedItem():setSelected(true)
end

return Menu
--[[
Menu = {}
Menu.new = function(props)
  --start
  local self = Control.new(props)
  
  --private members
  local _className = 'Menu'
  local _items = {} --Menu items.
  local _visibleItems = {} --"window" of visible items
  local _minIndex = 1
  local _maxIndex = 4
  local _selectedIndex = 1 --index of active menu item.

  local _getItemsData = function(object)
    if object == nil then
      error('Object must be specified')
      return nil
    end
  
    local _itemsData = {}
    for _i = 1, #menu_items do
      if menu_items[_i].owner == object then
        table.insert(_itemsData, menu_items[_i])
      end
    end
  
    return _itemsData
  end

  --public members

  self.make = function(templ, object)
    for _k, _v in pairs(templ._attr) do
      local attr_name = self.getAttrName(_v)
      if attr_name == nil then
        self[_k] = _v
      else
        self[_k] = object[attr_name]
      end
    end
  
    local _itemsData = _getItemsData(object)
    local _itemTempl = templ.Row
    for _i = 1, #_itemsData do
      local _listItem = MenuItem.new();
      _listItem.make(_itemTempl, _itemsData[_i])
      _items[_i] = _listItem;
    end
  
    for _i = 1, _maxIndex do
      _visibleItems[_i] = _i
    end
  
    _items[_selectedIndex].setSelected(true)
  end

  self.drawText = function()
    local _s = {}
    for _k, _v in pairs(_visibleItems) do
      if _items[_v] ~= nil then
        _s[_k] = _items[_v].drawText()
      end
    end
    while #_s < _maxIndex do
      table.insert(_s, (' '):rep(64))
    end
    return _s
  end

  self.onMoveDown = function(sender)
    if not self.isFocused() then return end
    local _prevIndex = _selectedIndex
    _selectedIndex = _selectedIndex + 1
    if _selectedIndex > #_items then
      _selectedIndex = #_items
    end
  
    _items[_prevIndex].setSelected(false)
    _items[_selectedIndex].setSelected(true)
  
    if _selectedIndex > _visibleItems[_maxIndex] then
      for _i = 1, #_visibleItems do
        _visibleItems[_i] = _visibleItems[_i] + 1
      end
    end
    sender.setCtxIconType(_items[_selectedIndex].ref_type)
    sender.setDescription(_items[_selectedIndex].ref.desc)
  end

  self.onMoveUp = function(sender)
    if not self.isFocused() then return end
    local _prevIndex = _selectedIndex
    _selectedIndex = _selectedIndex - 1
    if _selectedIndex < _minIndex then
      _selectedIndex = _minIndex
    end
  
    _items[_prevIndex].setSelected(false)
    _items[_selectedIndex].setSelected(true)
  
    if _selectedIndex < _visibleItems[_minIndex] then
      for _i = 1, _maxIndex do
        _visibleItems[_i] = _visibleItems[_i] - 1
      end
    end
    sender.setCtxIconType(_items[_selectedIndex].ref_type)
    sender.setDescription(_items[_selectedIndex].ref.desc)
  end

  self.onShowSubmenu = function(sender)
    if not self.isFocused() then return end
    sender.checkPermission()
  end
  
  self.onExitSubmenu = function(sender)
    if not self.isFocused() then return end
    for _, _v in pairs(menu_items) do
      if _v.name == _items[_selectedIndex].owner.name then
        sender.showMenu(_v.owner.name)
        return
      end
    end
  end
  --end
  return self
end
--]]



