M = {}

---@param original table
---@return table
function M.copy(original)
  local copy = {}
  for k, v in pairs(original) do
    copy[k] = v
  end
  return copy
end

---@param original table
---@return table
function M.deepCopy(original)
  if type(original) ~= "table" then
    return original
  end

  local copy = {}
  for k, v in pairs(original) do
    copy[M.deepCopy(k)] = M.deepCopy(v)
  end
  return copy
end

---@param a table
---@param b table
---@return table
function M.mergeTables(a, b)
  if b == nil then
    return a
  end
  for i, elem in pairs(b) do
    a[i] = elem
  end
  return a
end

---@param name string
---@return boolean
function M.fileExist(name)
  if vim.fn.filereadable(name) == 1 then
    return true
  end
  return false
end

return M
