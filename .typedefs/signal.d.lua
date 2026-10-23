-- signal.d.lua

--- Invokes all Luau [connections](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection) connected to a given RBXScriptSignal.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `signal` | The signal whose connections you want to manually fire. |
--- | `...?` | The arguments to pass to the connected functions. |
---
--- Example:
--- ```lua
--- local part = Instance.new("Part")
---
--- part.ChildAdded:Connect(function(arg1)
---     print(typeof(arg1))
--- end)
---
--- firesignal(part.ChildAdded)            -- Output: nil
--- firesignal(part.ChildAdded, workspace) -- Output: Instance
--- ```
declare function firesignal(signal: RBXScriptSignal, ...: any?)

export type Connection = {
    -- Fields
    Enabled: boolean,
    ForeignState: boolean,
    LuaConnection: boolean,
    Function: ((...any) -> ...any)?,
    Thread: thread?,
    
    -- Methods
    Fire: (self: Connection, ...any) -> (),
    Defer: (self: Connection, ...any) -> (),
    Disconnect: (self: Connection) -> (),
    Disable: (self: Connection) -> (),
    Enable: (self: Connection) -> ()
}


--- Retrieves a list of [Connection](https://docs.sunc.su/Signals/Connection/) objects currently attached to a given RBXScriptSignal.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `signal` | The signal to inspect for active connections. |
---
--- Example 1:
--- ```lua
--- local folder = Instance.new("Folder")
--- folder.ChildAdded:Connect(function()
---     print("Triggered")
--- end)
---
--- local connection = getconnections(folder.ChildAdded)[1] -- First connection in the list
--- connection.Function()     -- Output: Triggered
--- connection:Fire() -- Same as above, Output: Triggered
--- print(typeof(connection.Thread)) -- Output: thread
--- ```
--- Example 2:
--- ```lua
--- local cconnection = getconnections(game.Players.LocalPlayer.Idled)[1]
--- print(cconnection.Function)  -- Output: nil
--- print(cconnection.Thread)    -- Output: nil
--- ```
declare function getconnections(signal: RBXScriptSignal): {Connection}



--- Replicates a signal to the server with the provided arguments, if possible. 
--- The arguments must also match accordingly to the signal itself. 
--- To know a signal's arguments, visit [this](https://robloxapi.github.io/ref/).
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `signal` | The signal to replicate to the server. |
--- | `...?` | Arguments to pass to the signal. |
---
--- Example:
--- ```lua
--- local detector = workspace.replicatesigmal.ClickDetector
--- replicatesignal(detector.MouseActionReplicated, game.Players.LocalPlayer, 0)
--- task.wait(0.1)
---
--- print(game.Players.LocalPlayer:GetAttribute("MouseClickReplicated")) -- Output: true
--- ```
--- Example 2:
--- ```lua
--- local ui_frame = game.Players.LocalPlayer.PlayerGui.ScreenGui.Frame
---
--- -- These will throw an error.
--- replicatesignal(ui_frame.MouseWheelForward)
--- replicatesignal(ui_frame.MouseWheelForward, 121)
---
--- -- This succeeds
--- replicatesignal(ui_frame.MouseWheelForward, 121, 214)
--- task.wait(0.1)
---
--- print(game.Players.LocalPlayer:GetAttribute("MouseWheelForwardReplicated")) -- Output: true
--- ```
declare function replicatesignal(signal: RBXScriptSignal, ...: any?)