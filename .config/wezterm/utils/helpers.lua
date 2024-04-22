local utils = {}
function utils.merge(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                utils.merge(t1[k] or {}, t2[k] or {})
            else
							print(v)
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

return utils
