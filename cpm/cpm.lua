-- Stubs for C functions
local M = {}

function M.drawLine(funcId, attr, x1, y1, x2, y2)
    cpmlib.Log:print(3, 'funcID:'..funcId..', attr='..attr..' ,x1:'..x1..', y1='..y1..' ,x2='..x2..' ,y2='..y2)   
end

function M.drawText(funcId, attr, text, left, top)
    cpmlib.Log:print(3, 'funcID:'..funcId..', attr='..attr..' ,text='..text..' ,left='..left..' ,top='..top)
end

function M.drawIcon(funcId, attr, height, vidth, left, top, data)
    cpmlib.Log:print(3, 'funcID:'..funcId..', attr='..attr..' ,height='..height..', width='..width..',left='..left..' ,top='..top..', data='..data)
end
return M