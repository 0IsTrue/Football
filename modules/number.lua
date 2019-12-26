local number = {}

function number.sep(number, sep)
  if type(number) ~= "number" then
    return false
  end
    
  local k
  local seps = {",", "."}
  if sep ~= seps[1] or sep ~= seps[2] then
    sep = seps[2]
  end
  
  number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", "%1" .. sep .. "%2")
    if k == 0 then
      return false
      end
  return number
end


function number.digit(number, places)
  local result
  places = ("%%.%df"):format(places or 0)
    if not number or type(number) ~= "number" then
        return false
    elseif number >= 1000000000000 then
        result = places:format(number / 1000000000000) .. "t" -- trillion
    elseif number >= 1000000000 then
        result = places:format(number / 1000000000) .. "b" -- billion
    elseif number >= 1000000 then
        result = places:format(number / 1000000) .. "m" -- million
    elseif number >= 1000 then
        result = places:format(number / 1000) .. "k" -- thousand
    else
        result = number
    end
    return result
end

return number