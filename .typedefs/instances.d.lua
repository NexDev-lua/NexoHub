-- instances.d.lua

--- Returns a reference clone of an Instance. 
--- The returned object behaves identically to the original but is not strictly equal (==) to it.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `object` | The Instance to clone a safe reference from. |
---
--- Example:
--- ```lua
--- local players = game:GetService("Players")
--- local original = players.LocalPlayer
--- local clone = cloneref(original)
--- print(original == clone) -- Output: false
--- print(clone.Name)        -- Output: Player's name (same as original)
--- ```
declare function cloneref<T>(object: T & Instance): T


--- Checks if two Instances are equal.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `object1` | This first Instance to compare. |
--- | `object2` | The second Instance to compare against. |
---
--- Example:
--- ```lua
--- print(compareinstances(game, game))              -- true
--- print(compareinstances(game, workspace))         -- false
--- print(compareinstances(game, cloneref(game)))    -- true
--- print(game == cloneref(game))                    -- false
--- ```
declare function compareinstances(object1: Instance, object2: Instance): boolean


--- Fireclickdetector triggers a ClickDetector event. 
--- By default, it fires the MouseClick event.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `detector` | The ClickDetector to trigger. |
--- | `distance?` | Distance from which the click is simulated. Defaults to infinite. |
--- | `event??` | The event to trigger. |
---
--- Example:
--- ```lua
--- local click_detector = Instance.new("ClickDetector")
--- click_detector.MouseClick:Connect(function(player)
---     print(`{player.Name} Fired M1`)
--- end)
--- click_detector.RightMouseClick:Connect(function(player)
---     print(`{player.Name} Fired M2`)
--- end)
--- click_detector.MouseHoverEnter:Connect(function(player)
---     print(`{player.Name} Fired HoverEnter`)
--- end)
--- click_detector.MouseHoverLeave:Connect(function(player)
---     print(`{player} Fired HoverLeave`)
--- end)
--- fireclickdetector(click_detector, 0, "MouseClick") -- Output: Player Fired M1
--- fireclickdetector(click_detector, 0, "RightMouseClick") -- Output: Player Fired M2
--- fireclickdetector(click_detector, 0, "MouseHoverEnter") -- Output: Player Fired HoverEnter
--- fireclickdetector(click_detector, 0, "MouseHoverLeave") -- Output: Player Fired HoverLeave
--- ```
declare function fireclickdetector(detector: ClickDetector, distance: number?, event: string?): ()


--- Fireproximityprompt instantly triggers a ProximityPrompt, bypassing its HoldDuration and activation distance.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `prompt` | The ProximityPrompt to trigger. |
---
--- Example:
--- ```lua
--- local part = Instance.new("Part", workspace)
--- local prompt = Instance.new("ProximityPrompt", part)
--- prompt.ActionText = "Click Me"
--- prompt.Triggered:Connect(function(player)
---     print(player.Name .. " triggered the prompt")
--- end)
--- fireproximityprompt(prompt) -- Output: [YourName] triggered the prompt
--- ```
declare function fireproximityprompt(prompt: ProximityPrompt): ()

--- ### This function should not be implemented in Luau. Doing so exposes you to easy detection vectors.
--- 
--- Firetouchinterest simulates a physical touch event between two BasePart objects. 
--- It can emulate both the start and end of a Touched event.
---
--- Example:
--- ```lua
declare function firetouchinterest(part1: BasePart, part2: BasePart, toggle: boolean | number): ()


--- Firetouchinterest simulates a physical touch event between two BasePart objects. 
--- It can emulate both the start and end of a Touched event.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `part1` | The initiating BasePart. |
--- | `part2` | The BasePart that should be touched. |
--- | `toggle` | Whether to simulate touch start or end. true or 0 simulates touch; false or 1 simulates un-touch. |
---
--- Example 1:
--- ```lua
--- local dummy_part = Instance.new("Part")
--- dummy_part.CFrame = CFrame.new(0, -200, 0)
--- dummy_part.Anchored = true
--- dummy_part.Parent = workspace
--- dummy_part.Touched:Connect(function(part)
---     print(part.Name .. " touched the dummy part!")
--- end)
--- local player_head = game.Players.LocalPlayer.Character.Head
--- firetouchinterest(player_head, dummy_part, true) -- Simulate touch
--- task.wait(0.5)
--- firetouchinterest(player_head, dummy_part, false) -- Simulate un-touch
--- ```
--- Example 2:
--- ```lua
--- local dummy_part = Instance.new("Part")
--- dummy_part.CFrame = CFrame.new(0, -200, 0)
--- dummy_part.Anchored = true
--- dummy_part.Parent = workspace
--- dummy_part.Touched:Connect(function(part)
---     print(part.Name .. " touched the dummy part!")
--- end)
--- local player_head = game.Players.LocalPlayer.Character.Head
--- firetouchinterest(player_head, dummy_part, 0) -- Simulate touch
--- task.wait(0.5)
--- firetouchinterest(player_head, dummy_part, 1) -- Simulate un-touch
--- ```
declare function firetouchinterest(part1: BasePart, part2: BasePart, toggle: boolean | number): ()


--- Retrieves the assigned callback property on an Instance, such as OnInvoke.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `object` | The Instance that owns the callback property. |
--- | `property` | The name of the callback property to retrieve. |
---
--- Example:
--- ```lua
--- local dummy_bindable = Instance.new("BindableFunction")
--- local dummy_remote_function = Instance.new("RemoteFunction")
--- dummy_bindable.OnInvoke = function()
---     print("Hello from callback!")
--- end
--- local retrieved = getcallbackvalue(dummy_bindable, "OnInvoke")
--- retrieved() -- Output: Hello from callback!
--- print(getcallbackvalue(dummy_remote_function, "OnClientInvoke")) -- Output: nil
--- ```
declare function getcallbackvalue(object: Instance, property: string): any | nil


--- Returns a hidden Instance container used for safely storing UI elements. 
--- This container is mainly designed to avoid detections
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters.|
---
--- Example:
--- ```lua
--- local hui = gethui() :: (BasePlayerGui | Folder)
--- local gui = Instance.new("ScreenGui")
--- gui.Parent = hui
--- gui.Name = "GUI"
--- local label = Instance.new("TextLabel")
--- label.Size = UDim2.fromOffset(200, 50)
--- label.Text = "Hello from gethui!"
--- label.Parent = gui
--- print(hui:FindFirstChild("GUI")) -- Output: GUI
--- ```
declare function gethui(): BasePlayerGui | Folder


--- Retrieves every Instance from the registry. 
--- Which means that instances that are/were parented to nil will also be returned.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- local dummy_part = Instance.new("Part")
--- dummy_part.Parent = nil
--- for _, instance in pairs(getinstances()) do
---     if instance == dummy_part then
---         print("Found the dummy part!")
---     end
--- end
--- ```
declare function getinstances(): { Instance }


--- Returns a list of Instance objects that are currently unparented. 
--- These instances exist in memory but are no longer part of the DataModel hierarchy.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters. |
---
--- Example:
--- ```lua
--- local part = Instance.new("Part")
--- for _, instance in pairs(getnilinstances()) do
---     if instance == part then
---         print("Found our unattached part!")
---     end
--- end
--- ```
declare function getnilinstances(): { Instance }
