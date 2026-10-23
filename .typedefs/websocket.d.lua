-- websocket.d.lua

-- 1. Define the connection object returned when you call :Connect()
export type WebSocketConnection = {
    Disconnect: (self: WebSocketConnection) -> ()
}

-- 2. Define the signal for the OnMessage event
export type OnMessageSignal = {
    Connect: (self: OnMessageSignal, callback: (message: string) -> ()) -> WebSocketConnection
}

-- 3. Define the signal for the OnClose event
export type OnCloseSignal = {
    Connect: (self: OnCloseSignal, callback: () -> ()) -> WebSocketConnection
}

-- 4. Define the actual WebSocket instance methods and events
export type WebSocket = {
    -- Events
    OnMessage: OnMessageSignal,
    OnClose: OnCloseSignal,
    
    -- Methods
    Send: (self: WebSocket, message: string) -> (),
    Close: (self: WebSocket) -> ()
}

-- 5. Declare the global WebSocket namespace and constructor
declare WebSocket: {
    connect: (url: string) -> WebSocket
}

--declare function WebSocket.connect(url: string): WebSocket