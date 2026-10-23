-- scripts.d.lua

--- Returns the Script, LocalScript, or ModuleScript that triggered the current code execution.
---
--- Example:
--- ```lua
--- local old; old = hookmetamethod(game, "__index", function(self, key)
---     if not checkcaller() then
---         local caller = getcallingscript()
---         warn("__index access from script:", caller and caller:GetFullName() or "Unknown")

---         hookmetamethod(game, "__index", old) -- Restore the original
---         return old(self, key)
---     end

---     return old(self, key)
--- end)
---
--- print(getcallingscript()) -- Output: nil, since we called from an executor thread
--- ```
declare function getcallingscript(): BaseScript | ModuleScript | nil


--- Returns a list of all ModuleScript instances that have been loaded (e.g. require'd).
--- This includes only modules with completed executions, and excludes any modules that errored or haven't been required yet.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- local loaded = Instance.new("ModuleScript")
--- local not_loaded = Instance.new("ModuleScript")
---
--- pcall(require, loaded)
---
--- for _, module in pairs(getloadedmodules()) do
---     if module == loaded then
---         -- The first modulescript was found because it was required in line 4
---         print("Found loaded module!")
---     elseif module == notLoaded then
---         -- The second modulescript should NOT be found because it was never required
---         print("This should never appear.")
---     end
--- end
--- ```
declare function getloadedmodules(): { ModuleScript }



--- Returns a list of all running scripts in the caller's global state. 
--- This includes Script, LocalScript, and ModuleScript instances - excluding CoreScripts by default.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- local running = game.Players.LocalPlayer.Character:FindFirstChild("Animate")
--- local inactive = Instance.new("LocalScript") -- Not running because no bytecode to run
---
--- for _, script in pairs(getrunningscripts()) do
---     if script == running then
---         print("Found the running Animate script.")
---     elseif script == inactive then
---         print("This should never print.")
---         print("If this did print, then you have just experienced 1 in a quintillion chance of BITS FLIPPING from radiation. Do you live inside a nuclear reactor?")
---     end
--- end
--- ```
declare function getrunningscripts(): { BaseScript | ModuleScript }



--- Retrieves the bytecode of a LocalScript, ModuleScript, and Script.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `script` | The script instance to retrieve the bytecode from. |
---
--- Example:
--- ```lua
--- local animate = game.Players.LocalPlayer.Character:FindFirstChild("Animate")
---
--- print(getscriptbytecode(animate)) -- Returns bytecode as a string
---
--- print(getscriptbytecode(Instance.new("LocalScript"))) -- Output: nil
--- ```
declare function getscriptbytecode(script: BaseScript | ModuleScript): string | nil



--- Creates and returns a Luau function closure from the compiled bytecode of a Script, LocalScript, or ModuleScript.
--- This function is often used to extract constants or behaviour from scripts without needing to run them inside the game.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `script` | The script instance to convert into a function. |
---
--- Example:
--- ```lua
--- local animate = game.Players.LocalPlayer.Character:FindFirstChild("Animate")
---
--- local closure = getscriptclosure(animate)
---
--- print(typeof(closure)) -- Output: function 0x....
---
--- print(getscriptclosure(Instance.new("LocalScript"))) -- Output: nil
--- ```
declare function getscriptclosure(script: BaseScript | ModuleScript): ((...any) -> (...any)) | nil


--- Returns a SHA-384 hash in hexadecimal format of the raw bytecode for a given Script, LocalScript, or ModuleScript.
--- This is useful for identifying scripts by their content, especially when checking for known modules or verifying integrity.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `script` | The BaseScript or ModuleScript instance to hash. |
---
--- Example:
--- ```lua
--- local Animate = game.Players.LocalPlayer.Character:FindFirstChild("Animate")
---
--- print(getscripthash(Animate)) -- Output: 384-bit hash string
---
--- print(getscripthash(Instance.new("LocalScript"))) -- Output: nil
--- ```
declare function getscripthash(script: BaseScript | ModuleScript): string | nil


--- Returns a list of all Script, LocalScript, and ModuleScript instances present.
--- This function excludes CoreScripts by default.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- eturns a list of all Script, LocalScript, and ModuleScript instances present.
---
--- This function excludes CoreScripts by default.
--- ```
declare function getscripts(): { BaseScript | ModuleScript }



--- returns the global environment table of a given Script, LocalScript, or ModuleScript.
--- This environment contains all global variables and functions available to the target script, such as custom-defined functions or state values.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `script` | The script instance whose environment should be retrieved. |
---
--- Example:
--- ```lua
--- local animate = game.Players.LocalPlayer.Character:FindFirstChild("Animate")
---
--- local env = getsenv(animate)
---
--- print(typeof(env.onSwimming)) -- Output: function
--- ```
declare function getsenv(script: BaseScript | ModuleScript): { [any]: any } | nil



--- Compiles a string of Luau code and returns it as a runnable function. 
--- If the code has errors, nil is returned and an error message is output.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `source` | The source code string to compile. |
--- | `chunkname?` | Custom chunk name. |
---
--- Example:
--- ```lua
--- loadstring([[
---     placeholder = {"Example"}
--- ]])()
---
--- print(placeholder[1]) -- Output: Example
--- ```
declare function loadstring<A...>(source: string, chunkname: string?): (((A...) -> any) | nil, string?)