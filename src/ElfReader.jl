module ElfReader

export read_headers

using Transducers

const Headers = Dict{String, String}

struct ElfFileContents
    headers::Headers
end

function read_headers(filepath::AbstractString)::Headers
    (readlines(`readelf -h $filepath`)
    |> Drop(1)
    |> Map(parse_header)
    |> Headers)
end

function parse_header(line::AbstractString)
    (split(line, ':')
    |> Map(strip)
    |> collect
    |> h -> (h[1] => h[2]))
end

end
