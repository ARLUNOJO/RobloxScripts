-- Protección de encabezado para solo cargar este script una vez
if _G.Console then
    return _G.Console
end

-- Consola personalizada capaz de imprimir tablas y crear sub consolas con un prefijo
Console = {}
do
    function KeyToStr(k)
		if type(k) == "string" then
			if k:match("^[A-Za-z_][A-Za-z0-9_]*$") ~= nil and k:sub(1, 1):match("%d") == nil then
				return k
			end
			return table.concat({ '["', tostring(k), '"]' })
		end
		return table.concat({ "[", tostring(k), "]" })
	end

	function _dump(o, ident)
		local result = ""
		local objType = type(o)
		ident = ident or ""
		if objType == "string" then
			result = table.concat({ result, '"', o:gsub('"', '\\"'):gsub("\n", "\\n"), '"' })
		elseif objType == "number" or objType == "boolean" then
			result = table.concat({ result, tostring(o) })
		elseif objType == "function" then
			local funcInfo = debug.getinfo(o)
			result = table.concat({ result, "function(" })
			for nparams = 1, funcInfo.numparams, 1 do
				result = table.concat({ result, "p", nparams })
				if nparams ~= funcInfo.numparams then
					result = table.concat({ result, ", " })
				end
			end
			result = table.concat({ result, ") end" })
		elseif objType == "table" then
			result = table.concat({ result, "{\n" })
			for k, v in pairs(o) do
				result = table.concat({
					result,
					ident,
					"\t",
					KeyToStr(k),
					" = ",
					_dump(v, table.concat({ ident, "\t" })),
					",\n",
				})
			end
			result = table.concat({ result, ident, "}" })
		elseif typeof(o) == "Instance" then
			result = table.concat({ result, '"', tostring(o), " <", o.ClassName, '>"' })
		else
			result = table.concat({ result, '"', tostring(o), " <", typeof(o), '>"' })
		end
		return result
	end

	function Console:Dump(o)
		return _dump(o)
	end

    function Console:GetPrint(...)
        local tab_args = {...}
        local tab_print = {}
        for key, val in tab_args do
            if type(val) == "table" then
                table.insert(tab_print, Console:Dump(val))
            elseif type(val) == "string" then
				table.insert(tab_print, val)
			else
                table.insert(tab_print, tostring(val))
            end
        end
        return table.concat(tab_print)
    end

    function Console:Log(...)
        print(Console:GetPrint(...))
    end

    function Console:Warn(...)
        warn(Console:GetPrint(...))
    end

    function Console:Error(...)
        error(Console:GetPrint(...))
    end

    function Console:new(prefijo)
        local Self = table.clone(Console)
        function Self:Log(...)
            Console:Log(prefijo, " ", ...)
        end

        function Self:Warn(...)
            Console:Warn(prefijo, " ", ...)
        end

        function Self:Error(...)
            Console:Error(prefijo, " ", ...)
        end

        return Self
    end
end

_G.Console = Console
return _G.Console
