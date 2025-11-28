local M = {}

M.nearest_in_sorted = function(nums, target)
  local lo, hi = 1, #nums

  -- handle edge cases
  if hi == 0 then
    return nil
  end
  if target <= nums[1] then
    return nums[1]
  end
  if target >= nums[hi] then
    return nums[hi]
  end

  -- binary search for insertion point
  while lo <= hi do
    local mid = math.floor((lo + hi) / 2)
    local v = nums[mid]

    if v == target then
      return v
    elseif v < target then
      lo = mid + 1
    else
      hi = mid - 1
    end
  end

  -- At this point:
  -- hi < lo and the closest numbers are nums[hi] and nums[lo]
  local left = nums[hi]
  local right = nums[lo]

  if math.abs(target - left) <= math.abs(right - target) then
    return left
  else
    return right
  end
end

M.nearest_key = function(tbl, target)
  -- extract and sort numeric keys
  local keys = {}
  for k in pairs(tbl) do
    if type(k) == "number" then
      table.insert(keys, k)
    end
  end
  table.sort(keys)

  -- edge cases
  local n = #keys
  if n == 0 then
    return nil
  end
  if target <= keys[1] then
    return keys[1]
  end
  if target >= keys[n] then
    return keys[n]
  end

  -- binary search
  local lo, hi = 1, n
  while lo <= hi do
    local mid = math.floor((lo + hi) / 2)
    local v = keys[mid]

    if v == target then
      return v
    elseif v < target then
      lo = mid + 1
    else
      hi = mid - 1
    end
  end

  -- closest between keys[hi] and keys[lo]
  local left = keys[hi]
  local right = keys[lo]

  if math.abs(target - left) <= math.abs(right - target) then
    return left
  else
    return right
  end
end

M.table_copy = function(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end


M.find_range_key = function(tbl, target)
  -- extract and sort numeric keys
  local keys = {}
  for k in pairs(tbl) do
    if type(k) == "number" then
      table.insert(keys, k)
    end
  end
  table.sort(keys)

  local n = #keys
  if n == 0 then return nil end

  local lo, hi = 1, n

  while lo <= hi do
    local mid = math.floor((lo + hi) / 2)
    local start = keys[mid]
    local finish = tbl[start].ending or tbl[start]._end

    if target >= start and target <= finish then
      return start
    end

    if target < start then
      hi = mid - 1
    else
      lo = mid + 1
    end
  end

  return nil
end

return M