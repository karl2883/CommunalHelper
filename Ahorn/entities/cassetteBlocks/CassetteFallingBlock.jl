module CommunalHelperCassetteFallingBlock

using ..Ahorn, Maple
using Ahorn.CommunalHelper

@mapdef Entity "CommunalHelper/CassetteFallingBlock" CassetteFallingBlock(x::Integer, 
                                                                  y::Integer, 
                                                                  width::Integer=Maple.defaultBlockWidth, 
                                                                  height::Integer=Maple.defaultBlockHeight,
                                                                  index::Integer=0,
                                                                  tempo::Number=1.0) 

const placements = Ahorn.PlacementDict(
    "Cassette Falling Block ($index - $color) (Communal Helper)" => Ahorn.EntityPlacement(
        CassetteFallingBlock,
        "rectangle",
        Dict{String, Any}(
            "index" => index,
        )
    ) for (color, index) in cassetteColorNames
)

Ahorn.editingOptions(entity::CassetteFallingBlock) = Dict{String, Any}(
    "index" => cassetteColorNames
)

Ahorn.nodeLimits(entity::CassetteFallingBlock) = 1, 1

Ahorn.minimumSize(entity::CassetteFallingBlock) = 16, 16
Ahorn.resizable(entity::CassetteFallingBlock) = true, true

function Ahorn.selection(entity::CassetteFallingBlock)
    x, y = Ahorn.position(entity)

    width = Int(get(entity.data, "width", 8))
    height = Int(get(entity.data, "height", 8))

    return Ahorn.Rectangle(x, y, width, height)
end

const block = "objects/cassetteblock/solid"

function Ahorn.render(ctx::Ahorn.Cairo.CairoContext, entity::CassetteFallingBlock)
    width = Int(get(entity.data, "width", 32))
    height = Int(get(entity.data, "height", 32))

    index = Int(get(entity.data, "index", 0))
    
    renderCassetteBlock(ctx, 0, 0, width, height, index)
end

end