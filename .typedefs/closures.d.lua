-- closures.d.luau

--- Returns a boolean indicating whether the current function was invoked from the executor's own thread. 
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example: 
--- ```lua
--- local from_caller
---
--- local original; original = hookmetamethod(game, "__namecall", function(...)
---     if not from_caller then
---         from_caller = checkcaller()
---     end
---
---     return original(...)
--- end)
---
--- task.wait(0.1) -- Step a bit
--- hookmetamethod(game, "__namecall", original)
---
--- print(from_caller)       -- Output: false
--- print(checkcaller())    -- Output: true (current thread)
--- ```
--- It is often used in hookfunction and/or hookmetamethod.
declare function checkcaller(): boolean


    
--- Creates and returns a new function that has the exact same behaviour as the passed function.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `functionToClone` | The function to clone. |
---
--- Example:
--- ```lua
--- local function dummy_function()
---     print("Hello")
--- end
--- local cloned_function = clonefunction(dummy_function)
--- print(debug.info(cloned_function, "l")) -- Output: 1
--- print(debug.info(cloned_function, "n")) -- Output: dummy_function
--- print(cloned_function == dummy_function) -- Output: false
--- print(getfenv(cloned_function) == getfenv(dummy_function)) -- Output: true
--- ```
declare function clonefunction<A..., R...>(functionToClone: (A...) -> R...): (A...) -> R...


--- Returns the hex-represented SHA384 hash of a provided function's instructions (code) and constants.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `functionToHash` | The function to retrieve the hash of. |
---
--- Example:
--- ```lua
--- local function is_sha384_hex(hash)
---     return #hash == 96 and hash:match("^[0-9a-fA-F]+$") ~= nil
--- end
--- local dummy_function_0 = function() end
--- local dummy_function_1 = function(...) end
--- local dummy_function_2 = function() end
--- local dummy_function_3 = function() return "Constant" end
--- local dummy_function_4 = function() return "Constant2" end
--- print(is_sha384_hex(getfunctionhash(dummy_function_0))) -- Output: true
--- print(getfunctionhash(dummy_function_0) == getfunctionhash(dummy_function_1)) -- Output: false
--- print(getfunctionhash(dummy_function_0) == getfunctionhash(dummy_function_2)) -- Output: true
--- print(getfunctionhash(dummy_function_3) == getfunctionhash(dummy_function_4)) -- Output: false
--- ```
declare function getfunctionhash(functionToHash: (...any) -> (...any)): string


--- Allows you to hook a function with another wanted function, returning the original unhooked function.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `functionToHook` | The function that will be hooked |
--- | `hook` | The function that will be used as a hook |
---
--- Example:
--- ```lua
--- local function dummy_func()
---     print("I am not hooked!")
--- end
--- local function dummy_hook()
---     print("I am hooked!")
--- end
--- dummy_func() -- Output: I am not hooked!
--- local old_func = hookfunction(dummy_func, dummy_hook)
--- dummy_func() -- Output: I am hooked!
--- old_func() -- Output: I am not hooked!
--- ```
declare function hookfunction<A1..., R1..., A2..., R2...>(functionToHook: (A1...) -> R1..., hook: (A2...) -> R2...): (A1...) -> R1...


--- Takes any Luau object that can have a metatable, and attempts to hook the specified metamethod of the object.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `object` | The object which has a metatable. |
--- | `metamethodName` | The name of the metamethod to hook. |
--- | `hook` | The function that will be used as a hook. |
---
--- Example:
--- ```lua
--- local original; original = hookmetamethod(game, "__index", function(...)
---     local key = select(2, ...)
---     print(key)
---     return original(...)
--- end)
--- local _ = game.PlaceId -- Output: "PlaceId"
--- hookmetamethod(game, "__index", original) -- Restores game's __index
--- ```
declare function hookmetamethod(object: { [any]: any } | Instance | any, metamethodName: string, hook: (...any) -> (...any)): (...any) -> (...any)

--- Checks whether a given function is a C closure or not.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `func` | The function to check. |
---
--- Example:
--- ```lua
--- local function dummy_lua_function()
---     print("This is an executor Luau closure")
--- end
--- local dummy_cfunction = newcclosure(function()
---     print("This is an Executor C Closure")
--- end)
--- local dummy_standard_function = print
--- local dummy_global_cfunction = getgc
--- print(iscclosure(dummy_cfunction)) -- Output: true
--- print(iscclosure(dummy_global_cfunction)) -- Output: true
--- print(iscclosure(dummy_standard_function)) -- Output: true
--- print(iscclosure(dummy_lua_function)) -- Output: false
--- ```
declare function iscclosure(func: (...any) -> (...any)): boolean


--- Checks whether a given function is a closure of the executor. This also includes closures retrieved using getscriptclosure or loadstring
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `func` | The function to check. |
---
--- Example:
--- ```lua
--- local function dummy_lua_function()
---     print("This is an executor Luau closure")
--- end
--- local dummy_cfunction = newcclosure(function()
---     print("This is an executor C closure")
--- end)
--- local dummy_standard_cfunction = print
--- local dummy_global_cfunction = getgc
--- print(isexecutorclosure(dummy_lua_function)) -- Output: true
--- print(isexecutorclosure(dummy_cfunction)) -- Output: true
--- print(isexecutorclosure(dummy_global_cfunction)) -- Output: true
--- print(isexecutorclosure(dummy_standard_cfunction)) -- Output: false
--- ```
declare function isexecutorclosure(func: (...any) -> (...any)): boolean


--- Checks whether a given function is a Luau closure or not.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `func` | The function to check. |
---
--- Example:
--- ```lua
--- local function dummy_lua_function()
---     print("This is an executor Luau closure")
--- end
--- local dummy_cfunction = newcclosure(function()
---     print("This is an executor C closure")
--- end)
--- local dummy_standard_cfunction = print
--- print(islclosure(dummy_lua_function)) -- Output: true
--- print(islclosure(dummy_standard_cfunction)) -- Output: false
--- print(islclosure(dummy_cfunction)) -- Output: false
--- ```
declare function islclosure(func: (...any) -> (...any)): boolean
    

--- Many executors seem to be implementing this function using coroutine functions in Luau. Such functions will not pass sUNC checks.
--- The wrapped function must be yieldable, meaning that the function should be able to call task.wait, for example.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `functionToWrap` | A function to be wrapped. |
---
--- takes any Luau function and wraps it into a C closure. When the returned function is called, it invokes the original Luau closure with the provided arguments, then passes the closure's returned values back to the caller.
---
--- Example:
--- ```lua
--- local dummy_function = function(...)
---     return ...
--- end
--- print(iscclosure(dummy_function)) -- Output: false
--- local wrapped_function = newcclosure(dummy_function)
--- print(iscclosure(wrapped_function)) -- Output: true

--- local function_results = wrapped_function("Hello")
--- print(function_results) -- Output: Hello
--- ```
declare function newcclosure<A..., R...>(functionToWrap: (A...) -> R...): (A...) -> R...


--- Restores a hooked function back to the very first original function, even if it has been hooked multiple times.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `functionToRestore` | The hooked function that you want to restore |
---
--- Example 1:
--- ```lua
--- function dummy_func()
---     print("I am not hooked!")
--- end
--- hookfunction(dummy_func, function()
---     print("I am hooked!")
--- end)
--- dummy_func() -- Output: I am hooked!
--- restorefunction(dummy_func)
--- dummy_func() -- Output: I am not hooked!
--- ```
---
--- Example 2:
--- ```lua
--- function dummy_func()
---     print("I am not hooked!")
--- end
--- dummy_func() -- Output: I am not hooked!
--- restorefunction(dummy_func) -- Error: restorefunction: function is not hooked
--- ```
declare function restorefunction(functionToRestore: (...any) -> (...any)): ()

