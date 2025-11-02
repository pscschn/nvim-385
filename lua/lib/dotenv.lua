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

---Reads a dotenv file to a lua table
---@param path string Path to a dotenv file
---@return table|nil table  Deserialized dotenv content
M.read_file = function(path)
  if path == nil then
    return nil
  end
  local file = io.open(path, "r")
  if file == nil then
    return nil
  end

  io.input(file)
  local data = io.read("*a")
  io.close(file)
  return parse_data(data)
end

return M
