-- filesystem.d.lua


--- Appends string content to the end of a file at the specified path. If the file does not exist, it will be created.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The file path to append to. |
--- | `contents` | The string content to add to the file. |
---
---This is useful for logging, accumulating data over time, or extending file contents without overwriting them.
--- Example:
--- ```lua
--- writefile("file4.txt", "print(")
--- appendfile("file4.txt", "'Hello')")
--- print(readfile("file4.txt")) -- Output: print('Hello')
--- ```
declare function appendfile(path: string, contents: string): ()


--- Deletes the file at the specified path if it exists.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The path of the file to delete. |
---
--- Example:
--- ```lua
--- writefile("file5.txt", "Hello")
--- print(isfile("file5.txt")) -- Output: true
--- delfile("file5.txt")
--- print(isfile("file5.txt")) -- Output: false
--- ```
declare function delfile(path: string): ()


--- Deletes the folder at the specified path if it exists.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The path of the folder to delete. |
---
--- Example:
--- ```lua
--- makefolder("folder3")
--- print(isfolder("folder3")) -- Output: true
--- delfolder("folder3")
--- print(isfolder("folder3")) -- Output: false
--- ```
declare function delfolder(path: string): ()


--- Returns a content ID (e.g. rbxasset://) that can be used in Roblox APIs for loading audio, meshes, UI images, and other asset types.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The file path to convert into an asset ID. |
---
--- Internally, the file at the given path is copied to the game's content directory and then exposed with a usable asset URL.
--- Example:
--- ```lua
--- local encoded = game:HttpGet("https://gitlab.com/sens3/nebunu/-/raw/main/encodedBytecode.txt")
--- writefile("ExampleSound.mp3", base64decode(encoded))
--- local asset_id = getcustomasset("ExampleSound.mp3")
--- local sound = Instance.new("Sound")
--- sound.Parent = workspace
--- sound.SoundId = asset_id
--- sound.Volume = 0.35
--- sound:Play()
--- ```
declare function getcustomasset(path: string): string


--- Checks whether a given path exists and refers to a file.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The path to check. |
---
--- Example:
--- ```lua
--- print(isfile("nonexistent.txt")) -- Output: false
--- writefile("file3.txt", "")
--- print(isfile("file3.txt")) -- Output: true
--- ```
declare function isfile(path: string): boolean


--- Checks whether a given path exists and refers to a folder.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The path to check. |
---
--- Example:
--- ```lua
--- writefile("file7.txt", "")
--- makefolder("folder2")
--- print(isfolder("file7.txt")) -- Output: false
--- print(isfolder("folder2"))   -- Output: true
--- ```
declare function isfolder(path: string): boolean


--- Returns an array of strings representing all files and folders within the specified directory.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The path to the directory to scan. |
---
--- Example:
--- ```lua
--- writefile("file1.txt", "")
--- writefile("file2.lua", "")
--- task.wait()
--- for _, file in listfiles("") do
---     if file == "file1.txt" then
---         print(`Found: {file}`) -- Output: Found: file1.txt
---     end
---     if file == "file2.lua" then
---         print(`Found: {file}`) -- Output: Found: file2.lua
---     end
--- end
--- ```
declare function listfiles(path: string): { string }


--- Compiles the Luau source code from a file and returns the resulting function (chunk). 
--- This chunk runs in the global environment.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The path to the file to be loaded. |
---
--- Example 1:
--- ```lua
--- writefile("file6.lua", "return 10 + ...")
--- local chunk = loadfile("file6.lua")
--- print(chunk(1)) -- Output: 11
--- ```
--- Example 2:
--- ```lua
--- writefile("file6.lua", "retrn 10 + ...")
--- loadfile("file6.lua") -- This will throw an error in the console
--- ```
declare function loadfile<A...>(path: string): ((A...) -> any | nil, string?)


--- Creates a folder at the specified path if one does not already exist.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The folder path to create. |
---
--- Example:
--- ```lua
--- makefolder("test_folder")
--- print(isfolder("test_folder")) -- Output: true
--- ```
declare function makefolder(path: string): ()


--- Retrieves the contents of a file at the specified path and returns it as a string.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The file path to read from. |
---
--- Example:
--- ```lua
--- writefile("file0.txt", "Hello")
--- print(readfile("file0.txt")) -- Output: Hello
--- ```
declare function readfile(path: string): string


--- Writes data to a file at the specified path. 
--- If the file already exists, its contents will be overwritten.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `path` | The file path to write to. |
--- | `data` | The string data to write into the file. |
---
--- Example:
--- ```lua
--- writefile("file.txt", "Hello world")
--- print(readfile("file.txt")) -- Output: Hello world
--- ```
declare function writefile(path: string, data: string): ()

