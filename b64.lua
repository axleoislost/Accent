-- Kencoder: Simple Luau-compatible base64 module
local Kencoder = {}

local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function Kencoder.encode(data)
	local bytes = {}
	for i = 1, #data, 3 do
		local a, b1, c = data:byte(i, i + 2)
		local triple = (a or 0) * 65536 + (b1 or 0) * 256 + (c or 0)

		local s1 = math.floor(triple / 262144) % 64 + 1
		local s2 = math.floor(triple / 4096) % 64 + 1
		local s3 = math.floor(triple / 64) % 64 + 1
		local s4 = triple % 64 + 1

		bytes[#bytes+1] = b:sub(s1,s1)
		bytes[#bytes+1] = b:sub(s2,s2)
		bytes[#bytes+1] = (b1 ~= nil) and b:sub(s3,s3) or '='
		bytes[#bytes+1] = (c ~= nil) and b:sub(s4,s4) or '='
	end
	return table.concat(bytes)
end

function Kencoder.decode(data)
	data = data:gsub('[^'..b..'=]', '')
	local t = {}
	for i = 1, #data, 4 do
		local s1 = b:find(data:sub(i, i)) - 1
		local s2 = b:find(data:sub(i+1, i+1)) - 1
		local s3 = b:find(data:sub(i+2, i+2)) or 0
		local s4 = b:find(data:sub(i+3, i+3)) or 0

		local n = s1 * 262144 + s2 * 4096 + s3 * 64 + s4

		local a = math.floor(n / 65536) % 256
		local b1 = math.floor(n / 256) % 256
		local c = n % 256

		t[#t+1] = string.char(a)
		if data:sub(i+2,i+2) ~= '=' then t[#t+1] = string.char(b1) end
		if data:sub(i+3,i+3) ~= '=' then t[#t+1] = string.char(c) end
	end
	return table.concat(t)
end

return Kencoder
