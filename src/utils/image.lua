ImageUtils = {}
ImageUtils.__index = ImageUtils

function ImageUtils:generate_quads(atlas, tile_width, tile_height)
    local sheet_width = atlas:getWidth() / tile_width
    local sheet_height = atlas:getHeight() / tile_height

    local sheet_counter = 1
    local quads = {}

    for y = 0, sheet_height - 1 do
        for x = 0, sheet_width - 1 do
            -- this quad represents a square cutout of our atlas that we can
            -- individually draw instead of the whole atlas
            quads[sheet_counter] =
                love.graphics.newQuad(x * tile_width, y * tile_height, tile_width,
                tile_height, atlas:getDimensions())
            sheet_counter = sheet_counter + 1
        end
    end

    return quads
end