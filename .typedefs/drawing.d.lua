-- drawing.d.luau


-- Base Drawing Object (Shared Properties & Methods)
declare class DrawingObject
    --- Whether the object is rendered. Defaults to false.
    Visible: boolean
    
    --- Render order; higher values appear on top.
    ZIndex: number
    
    --- Translucency, where 1 is fully transparent and 0 is fully visible.
    --- Note: sUNC follows the correct definition (0=Opaque, 1=Transparent).
    Transparency: number
    
    --- The color of the drawing.
    Color: Color3
    
    --- Whether the drawing object exists.
    --- Useful for checking if an object has been destroyed.
    __OBJECT_EXISTS: boolean

    --- Permanently removes the drawing from view.
    function Destroy(self): ()
    
    --- Alias for Destroy (commonly supported in executors).
    function Remove(self): ()
end

-- Add this line to create the type alias
export type Drawing = DrawingObject

declare class DrawingLine extends DrawingObject
    --- Start position of the line.
    From: Vector2
    --- End position of the line.
    To: Vector2
    --- Width of the line.
    Thickness: number
end

declare class DrawingText extends DrawingObject
    --- The text content to render.
    Text: string
    --- Computed text size (read-only).
    TextBounds: Vector2
    --- Font to use (values from Drawing.Fonts).
    Font: number
    --- Size of the text.
    Size: number
    --- Top-left corner of the text.
    Position: Vector2
    --- Horizontally center the text.
    Center: boolean
    --- Whether to draw an outline.
    Outline: boolean
    --- Outline color.
    OutlineColor: Color3
end

declare class DrawingImage extends DrawingObject
    --- Raw image byte string (e.g. from readfile).
    Data: string
    --- Size of the rendered image.
    Size: Vector2
    --- Top-left corner of the image.
    Position: Vector2
    --- Amount of corner rounding (optional aesthetic).
    Rounding: number
end

declare class DrawingCircle extends DrawingObject
    --- Number of sides used to approximate the circle.
    NumSides: number
    --- Radius of the circle.
    Radius: number
    --- Center point of the circle.
    Position: Vector2
    --- Outline thickness (if not filled).
    Thickness: number
    --- Whether the circle is filled.
    Filled: boolean
end

declare class DrawingSquare extends DrawingObject
    --- Size of the rectangle.
    Size: Vector2
    --- Top-left corner.
    Position: Vector2
    --- Outline thickness (if not filled).
    Thickness: number
    --- Whether the square is filled.
    Filled: boolean
end

declare class DrawingQuad extends DrawingObject
    --- First point.
    PointA: Vector2
    --- Second point.
    PointB: Vector2
    --- Third point.
    PointC: Vector2
    --- Fourth point.
    PointD: Vector2
    --- Outline thickness (if not filled).
    Thickness: number
    --- Whether the quad is filled.
    Filled: boolean
end

declare class DrawingTriangle extends DrawingObject
    --- First point.
    PointA: Vector2
    --- Second point.
    PointB: Vector2
    --- Third point.
    PointC: Vector2
    --- Outline thickness (if not filled).
    Thickness: number
    --- Whether the triangle is filled.
    Filled: boolean
end

--------------------------------------------------------------------------------
-- DRAWING LIBRARY GLOBAL
--------------------------------------------------------------------------------

declare Drawing: {
    --- Creates a new render object of the specified type.
    --- These objects render directly onto the game window and do not exist in the DataModel.
    --- @param type The type of drawing to create.
    new: ((type: "Line") -> DrawingLine)
       & ((type: "Text") -> DrawingText)
       & ((type: "Image") -> DrawingImage)
       & ((type: "Circle") -> DrawingCircle)
       & ((type: "Square") -> DrawingSquare)
       & ((type: "Quad") -> DrawingQuad)
       & ((type: "Triangle") -> DrawingTriangle),

    --- Enum for text fonts.
    Fonts: {
        UI: number,
        System: number,
        Plex: number,
        Monospace: number
    }
}

--- Removes all active drawing objects created with Drawing.new.
---
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `(none)` | This function takes no parameters.
---
--- Example:
--- ```lua
--- local camera = game.Workspace.CurrentCamera
--- local viewport = camera.ViewportSize
--- local pos = Vector2.new(viewport.X / 2, viewport.Y / 2)
--- local circle = Drawing.new("Circle")
--- circle.Radius = 50
--- circle.Color = Color3.fromRGB(255, 0, 0)
--- circle.Filled = true
--- circle.NumSides = 60
--- circle.Position = pos
--- circle.Transparency = 1
--- circle.Visible = true
--- task.defer(cleardrawcache)
--- print(circle.__OBJECT_EXISTS) -- Output: true
--- task.wait()
--- print(circle.__OBJECT_EXISTS) -- Output: false
--- ```
declare function cleardrawcache(): ()


--- Retrieves the value of a property from a Drawing object. This behaves identically to using object[property], but is useful when working with dynamic property names or for reflection-like access.
--- | Parameter | Description |
--- | :--- | :--- |
--- | `drawing` | A valid Drawing object. |
--- | `property` | The name of the property to retrieve. |
---
--- Example:
--- ```lua
--- local circle = Drawing.new("Circle")
--- circle.Radius = 50
--- circle.Visible = true
--- print(getrenderproperty(circle, "Radius"))    -- Output: 50
--- print(getrenderproperty(circle, "Visible"))   -- Output: true
--- ```
declare function getrenderproperty(drawing: DrawingObject, property: string): any


--- Whether a given value is a valid Drawing object.p
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `object` | The value to check for Drawing validity. |
---
--- This is useful for validation in functions or modules that work with custom render systems.
--- Example:
--- ```lua
--- local square = Drawing.new("Square")
--- print(isrenderobj(square))       -- Output: true
--- print(isrenderobj(workspace))    -- Output: false
--- print(isrenderobj("not a draw")) -- Output: false
--- ```
declare function isrenderobj(object: any): boolean

--- Assigns a value to a property of a Drawing object. 
--- This behaves identically to object[property] = value, but is useful for dynamic or abstracted property access.
--- | Parameter | Description | 
--- | :--- | :--- |
--- | `drawing` | A valid Drawing object. |
--- | `property` | The name of the property to assign. |
--- | `value` | The value to assign to the specified property. |
---
--- Example:
--- ```lua
--- local circle = Drawing.new("Circle")
--- setrenderproperty(circle, "Radius", 50)
--- setrenderproperty(circle, "Visible", true)
--- print(circle.Radius)   -- Output: 50
--- print(circle.Visible)  -- Output: true
--- ```
declare function setrenderproperty(drawing: Drawing, property: string, value: any): ()
