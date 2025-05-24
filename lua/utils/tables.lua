local M = {}

M.add_if = function(condition, list, element)
    if condition then
        table.insert(list, element)
    end
end

return M
