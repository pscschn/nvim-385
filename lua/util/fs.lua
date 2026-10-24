local M = {}

---Reads a file and returns its contents
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
  return data
end

M.file_exists = function(path)
  local file = io.open(path, "r")
  if not file then
    return false
  end
  file:close()
  return true
end

return M
