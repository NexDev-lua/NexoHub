-- metatable.d.lua

export type userdata = typeof(newproxy()) -- 


--- Returns the name of the method that invoked the __namecall metamethod.
--- When used inside a hookmetamethod hook targeting __namecall, it will attempt to retrieve the method being called (e.g. InvokeServer).
--- When used outside of said hook, this function will safely return nil.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- local refs = {}
--- refs.__namecall = hookmetamethod(game, "__namecall", function(...)
---     local self = ...
---     local method = getnamecallmethod()
---     if self == game and method == "service" then
---         error("Using game:service() is not allowed.")
---     end
---     return refs.__namecall(...)
--- end)
--- ```
declare function getnamecallmethod(): string?


--- Returns the raw metatable of an object, even if that object has a __metatable field set.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `object` | The object whose metatable to retrieve. |
---
--- Example 1:
--- ```lua
--- local mt = getrawmetatable(game)
--- print(type(mt)) -- Output: table
--- print(mt.__index(game, "Workspace")) -- Output: Workspace
--- ```
--- Example 2:
--- ```lua
--- print(getrawmetatable(newproxy(false)))
--- ```
declare function getrawmetatable(object: { any } | userdata): { [any]: any } | nil


--- Checks whether a table is currently set as readonly.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `table` | The table to check for readonly status. |
---
--- Example:
--- ```lua
--- print(isreadonly({})) -- Output: false
--- print(isreadonly(getrawmetatable(game))) -- Output: true
--- ```
declare function isreadonly(table: { any }): boolean


--- Forcibly sets the metatable of a value, bypassing the __metatable protection field.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `object` | The value whose metatable will be overwritten. |
--- | `metatable` | The new metatable to assign. |
---
--- Example:
--- ```lua
--- local dummy_string = "Example"
--- local string_metatable = setrawmetatable(dummy_string, {
---     __index = getgenv()
--- })
--- print(string_metatable)          -- Output: Example
--- print(string_metatable.getgenv)        -- Output: function: 0x...
--- ```
declare function setrawmetatable<T>(object: T & ({ any } | userdata), metatable: { any }): T


--- Sets whether a table is readonly or writable.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `table` | The table whose readonly status you want to modify. |
--- | `state` | true to lock the table, false to unlock it. |
---
--- Example:
--- ```lua
--- local mt = getrawmetatable(game)
--- mt.Example = "Hello" -- Throws an error
--- setreadonly(mt, false)
--- mt.Example = "Hello"
--- print(mt.Example) -- Output: Hello
--- setreadonly(mt, true) -- Lock back
--- ```
declare function setreadonly(table: { any }, state: boolean): ()

