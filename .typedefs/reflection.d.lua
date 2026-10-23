-- reflection.d.lua

--- Retrieves the value of a hidden or non-scriptable property (e.g. BinaryString, SharedString, SystemAddress) from a given Instance
--- Even if it would normally throw an error when accessed directly.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `instance` | The instance containing the hidden property. |
--- | `property_name` | The name of the property to access. |
---
--- Example:
--- ```lua
--- local part = Instance.new("Part")
--- print(gethiddenproperty(part, "Name"))       -- Output: Part, false
--- print(gethiddenproperty(part, "DataCost"))   -- Output: 20, false
--- print(gethiddenproperty(part, "NetworkOwnerV3"))   -- Output: -1, true
--- ```
declare function gethiddenproperty(instance: Instance, property_name: string): (any, boolean)
    

--- Retrieves the thread's identity of the running Luau thread.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- task.defer(function()
---     setthreadidentity(2)
---     print(getthreadidentity()) -- Output: 2
--- end)
--- setthreadidentity(3)
--- print(getthreadidentity())     -- Output: 3
--- ```
declare function getthreadidentity(): number


--- Returns whether the given property of an Instance is scriptable (i.e. it does not have the notscriptable tag).
--- If it returns true, then the property is scriptable and can be indexed normally, and vice versa.
--- If it returns nil, then the property provided does not exist.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `object` | The Instance that owns the target property. |
--- | `property` | The name of the property to check. |
---
--- Example:
--- ```lua
--- local part = Instance.new("Part")
---
--- setscriptable(part, "BottomParamA", false)
---
--- print(isscriptable(part, "BottomParamA")) -- false
--- ```
declare function isscriptable(object: Instance, property: string): boolean | nil


--- Assigns a value to a hidden or non-scriptable property of an Instance, even if that property is normally read-only or inaccessible.
--- It returns true if the property is hidden and was successfully written to, or false if the property wasn't hidden but was still updated.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `instance` | The instance that owns the target property. |
--- | `property_name` | The name of the property to update. |
--- | `property_value` | The new value to assign to the property. |
---
--- Example:
--- ```lua
--- local part = Instance.new("Part")
---
--- print(gethiddenproperty(part, "DataCost")) -- Output: 20, true
---
--- sethiddenproperty(part, "DataCost", 100)
---
--- print(gethiddenproperty(part, "DataCost")) -- Output: 100, true
--- ```
declare function sethiddenproperty(instance: Instance, property_name: string, property_value: any): boolean


--- Toggles the scriptability of a hidden or non-scriptable property on an Instance. 
--- When a property is made scriptable, it can be accessed or assigned through standard indexing.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `instance` | The Instance that owns the target property. |
--- | `property_name` | The name of the property to make scriptable or un-scriptable. |
--- | `state` | Whether to enable (true) or disable (false) scriptability. |
---
--- Example:
--- ```lua
--- local part = Instance.new("Part")
---
--- setscriptable(part, "BottomParamA", true)
--- print(part.BottomParamA) -- Output: -0.5
---
--- setscriptable(part, "BottomParamA", false)
--- print(part.BottomParamA) -- Throws an error
--- ```
declare function setscriptable(instance: Instance, property_name: string, state: boolean): boolean | nil


--- sets the current [Luau thread](https://create.roblox.com/docs/reference/engine/libraries/coroutine#running) identity and capabilities matching that identity.
--- This is commonly used alongside functions like gethiddenproperty or getconnections which may require elevated access.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `id` | The identity level to set the current thread to. |
---
--- Example:
--- ```lua
--- setthreadidentity(2)
--- print(pcall(function() return game.CoreGui end)) -- Output: false (restricted access)
---
--- setthreadidentity(8)
--- print(pcall(function() return game.CoreGui end)) -- Output: true Instance
--- ```
declare function setthreadidentity(id: number): ()