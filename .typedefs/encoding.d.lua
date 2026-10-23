-- encoding.d.luau


--- Decodes a Base64-encoded string back into its original form.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `data` | The Base64-encoded string to decode. |
---
--- Example:
--- ```lua
--- local bytecode = game:HttpGet("https://api.rubis.app/v2/scrap/zuxQZuM9Tnl5MRbo/raw")
--- writefile("sound.mp3", base64decode(bytecode)) -- This file should be a valid and working MP3 file.
--- ```
declare function base64decode(data: string): string

--- Encodes a string with Base64 encoding.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `data` | The string to encode. |
---
--- Example:
--- ```lua
--- print(base64encode("DummyString\0\2")) -- Output: RHVtbXlTdHJpbmcAAg==
--- ```
declare function base64encode(data: string): string


--- Compresses a string with the LZ4 compression algorithm.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `data` | The string to compress. |
---
--- Example:
--- ```lua
--- local text = "Hello, world! Hello, world! Goodbye, world!"
--- print(#text) -- 43
--- print(#lz4compress(text)) -- 34
--- ```
declare function lz4compress(data: string): string


--- Decompresses a string that was encoded using the LZ4 compression algorithm back to regular data.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `data` | The string to decompress. |
---
--- Example:
--- ```lua
--- local text = "Hello, world! Hello, world!"
--- local compressed = lz4compress(text)
--- print(lz4decompress(compressed, #text)) -- "Hello, world! Hello, world!"
--- ```
declare function lz4decompress(data: string): string

