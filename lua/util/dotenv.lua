local M = {}

---Reads dotenv string content to lua table
---@param data string Content of a dotenv file
---@return table table Deserialized dotenv content
local parse_data = function(data)
  local values = vim.split(data, "\n")
  local out = {}
  for _, pair in pairs(values) do
    pair = vim.trim(pair)

    if vim.startswith(pair, "#") or pair == "" then
      goto continue
    end

    local splitted = vim.split(pair, "=")

    if #splitted == 1 then
      goto continue
    end

    local key = splitted[1]
    local v = {}
    for i = 2, #splitted, 1 do
      local k = vim.trim(splitted[i])
      if k ~= "" then
        table.insert(v, splitted[i])
      end
    end
    if #v > 0 then
      local value = table.concat(v, "=")
      value, _ = string.gsub(value, '"', "")
      vim.env[key] = value
      out[key] = value
    end
  end
  ::continue::
  return out
end

M.read_file = function(path)
  local data = require("util.fs").read_file(path)
  return parse_data(data)
end

return M
