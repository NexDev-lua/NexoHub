
-- miscellaneous.d.lua

--- Returns the name and version of the currently running executor.
---
--- Example:
--- ```lua
--- local exec_name, exec_version = identifyexecutor()
--- print(exec_name, exec_version) -- Output: "YourExploitName 0.0.1"
--- ```
declare function identifyexecutor(): (string, string)



--- | Parameter | Type | Description | 
--- | :--- | :--- | :--- |
--- | `Url` | string | The target URL. |
--- | `Method` | string | The HTTP method (GET, HEAD, POST, PUT, DELETE, OPTIONS or PATCH). |
--- | `Body ` | string? | (Optional) The request payload. |
--- | `Headers` | { [string]: string }? | (Optional) Dictionary of HTTP headers. |
--- | `Cookies` | { [string]: string }? | (Optional) Dictionary of cookies. |
export type RequestOptions = {
    Url: string,
    Method: "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "OPTIONS" | "PATCH",
    Body: string?,
    Headers: { [string]: string }?,
    Cookies: { [string]: string }?
}


--- | Parameter | Type | Description | 
--- | :--- | :--- | :--- |
--- | `Succes` | boolean | Whether the request was successful. |
--- | `Body` | string | The returned response body. |
--- | `StatusCode ` | number | The numeric HTTP status code. |
--- | `StatusMessage` | string | The human-readable status description. |
--- | `Headers` | { [string]: string } | Dictionary of response headers. |
export type Response = {
    Success: boolean,
    Body: string,
    StatusCode: number,
    StatusMessage: string,
    Headers: { [string]: string }
}

--- Sends a HTTP request to the given URL using the provided configuration table. 
--- It yields until the request is complete and returns a structured response.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `options` | A table of fields defining the HTTP request. |
---
--- Executors will attach this unique header automatically:
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `PREFIX-User-Identifier` | Unique user ID that stays consistent across devices for the same user. |
--- | `PREFIX-Fingerprint` | Hardware-bound identifier (HWID) of the client's machine. |
--- | `User-Agent` | Executor name and version string. |
---
--- Example 1:
--- ```lua
--- local response = request({
---     Url = "http://httpbin.org/get",
---     Method = "GET",
--- })
--- local decoded = game:GetService("HttpService"):JSONDecode(response.Body)
--- local retrieved_fingerprint
--- for key in pairs(decoded.headers) do
---     if key:match("Fingerprint") then
---         retrieved_fingerprint = key
---         break
---     end
--- end
--- print(response.StatusCode)         -- Output: 200
--- print(response.Success)            -- Output: true
--- print(retrieved_fingerprint)        -- Output: PREFIX-Fingerprint
--- ```
--- 
--- Example 2:
--- ```lua
--- local response = request({
---     Url = "http://httpbin.org/post",
---     Method = "POST",
---     Body = "Example"
--- })
--- print(response.StatusMessage)                               -- Output: OK
--- print(response.StatusCode)                                  -- Output: 200
--- print(game:GetService("HttpService"):JSONDecode(response.Body).data) -- Output: Example
--- ```
declare function request(options: RequestOptions): Response
    


declare function queue_on_teleport(code: string): ()

