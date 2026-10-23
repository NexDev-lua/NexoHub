-- enviroment.d.lua

export type AnyFunction = (...any) -> (...any)
export type AnyTable = { [any]: any }

export type userdata = typeof(newproxy()) -- 


--- Returns a list of non-dead garbage-collectable values. 
--- These include functions, userdatas, and optionally tables.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `includeTables?` | If true, also includes tables in the returned list. Defaults to false. |
---
--- Example 1:
--- ```lua
--- local dummy_table = {}
--- local function dummy_function() end
--- task.wait(0.05) -- Step a bit
--- for _, value in pairs(getgc()) do
---     if value == dummy_function then
---         print(`Found function: {dummy_function}`)
---     elseif value == dummy_table then
---         print(`Found table?: {dummy_table}`) -- This shouldn't print
---     end
--- end
--- ```
--- Example 2:
--- local dummy_table = {}
--- local function dummy_function() end
--- task.wait(0.05) -- Step a bit
--- for _, value in pairs(getgc(true)) do
---     if value == dummy_function then
---         print(`Found function: {dummy_function}`) -- Should print
---     elseif value == dummy_table then
---         print(`Found table: {dummy_table}`) -- Should also print
---     end
--- end
--- ```
declare getgc:
    ((includeTables: true) -> { { AnyTable } | AnyFunction | userdata }) &
    ((includeTables: false?) -> { AnyFunction })


--- Returns the executor's global environment table, which is shared across all executor-made threads.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- getgenv().dummy_val = "value"
--- getfenv().dummy_val_2 = 1
--- print(dummy_val, getgenv().dummy_val_2) -- Output: value, nil
--- getgenv().dummy_val = "value2"
--- dummy_val = nil
--- print(dummy_val) -- Output: value2
--- ```
declare function getgenv(): { any }


--- Returns the Luau registry table. 
--- The registry is a special table which is used internally to store references like threads, functions, and data shared between C and Luau (userdata).
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- local loop_thread = task.spawn(function()
---     while task.wait(1) do
---         print("I am still running...")
---     end
--- end)
--- task.wait(0.2) -- Let the loop run for a bit
--- for _, value in pairs(getreg()) do
---     if value ~= loop_thread then continue end
---     print(`Found loop thread: {loop_thread}`) -- Should print
---     coroutine.close(loop_thread) -- Should close the thread
---     break
--- end
--- ```
declare function getreg(): { [any]: any }


--- Returns the Roblox global environment, which is used by the entire game. 
--- Changes to this environment will affect your executor environment as well.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- getrenv().warn = "Hello!"
--- print(type(warn)) -- Output: string
--- getrenv().game = nil
--- print(game) -- Output: nil
--- ```
declare function getrenv(): { any }



export type FunctionFilterOptions = {
    --- Matches functions with a specific name (debug.info(f, "n")).
    Name: string?,
    --- Matches functions from a specific script (debug.info(f, "s")).
    Script: string?,
    --- Matches functions that contain specific constants.
    Constants: { any }?,
    --- Matches functions that have specific upvalues.
    Upvalues: { any }?,
    --- Matches functions with a specific environment table.
    Environment: { [any]: any }?,
    --- Matches functions with a specific bytecode hash.
    Hash: string?,
    --- Matches functions that are closures (C or Lua).
    IsProto: boolean?
}

export type TableFilterOptions = {
    --- Matches tables that contain specific keys.
    Keys: { any }?,
    --- Matches tables that contain specific values.
    Values: { any }?,
    --- Matches tables that have a specific metatable.
    Metatable: { [any]: any }?
}


--- Allows you to retrieve specific garbage-collected values from Luau's memory, using fine-tuned filters.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `filterType` | The type of value to search for. |
--- | `filterOptions` | A set of rules used to match functions or tables. |
--- | `returnOne?` | If true, returns the first match, instead of a table of matches. |
---
--- This function is most often used to find game-defined functions or internal tables by matching constants, keys, metatables, and more. 
--- It behaves similarly to getgc, but offers simplicity, efficiency, and more control over what gets returned.
--- [View Documentation](https://docs.sunc.su/Environment/filtergc/)
declare filtergc: 
    (( filterType: "function", filterOptions: FunctionFilterOptions, returnOne: true) -> AnyFunction? ) &
    ((( filterType: "function", filterOptions: FunctionFilterOptions, returnOne: false?) -> ( AnyFunction | { AnyFunction } ) )) &
    (( filterType: "table", filterOptions: TableFilterOptions, returnOne: true) -> { AnyTable? } ) &
    (( filterType: "table", filterOptions: TableFilterOptions, returnOne: false? ) -> { AnyTable })
