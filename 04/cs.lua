function readFile(path)
    local file = io.open(path, "r")
    local content = file:read("*all")
    file:close()
    return content
end

function split(string, separator)
    if separator == nil then
        separator = "%s"
    end
    local out = {}
    for word in string.gmatch(string, "([^" .. separator .. "]+)") do
        table.insert(out, word)
    end
    return out
end


function countXMAX(rows)
    local out = 0
    for i, row in ipairs(rows) do
        for j, col in ipairs(row) do
            if col == "X" then

                -- X
                -- M
                -- A
                -- S
                if i < #rows - 2 then
                    if rows[i + 1][j] == "M" and rows[i + 2][j] == "A" and rows[i + 3][j] == "S" then
                        out = out + 1
                    end
                end

                -- S
                -- A
                -- M
                -- X
                if i > 3 then
                    if rows[i - 1][j] == "M" and rows[i - 2][j] == "A" and rows[i - 3][j] == "S" then
                        out = out + 1
                    end
                end

                -- XMAS
                if j < #row - 2 then
                    if row[j + 1] == "M" and row[j + 2] == "A" and row[j + 3] == "S" then
                        out = out + 1
                    end
                end

                -- SAMX
                if j > 3 then
                    if row[j - 1] == "M" and row[j - 2] == "A" and row[j - 3] == "S" then
                        out = out + 1
                    end
                end

                -- X...
                -- .M..
                -- ..A.
                -- ...S
                if i < #rows - 2 and j < #row - 2 then
                    if rows[i + 1][j + 1] == "M" and rows[i + 2][j + 2] == "A" and rows[i + 3][j + 3] == "S" then
                        out = out + 1
                    end
                end

                
                -- ...S
                -- ..A.
                -- .M..
                -- X...
                if i > 3 and j < #row - 2 then
                    if rows[i - 1][j + 1] == "M" and rows[i - 2][j + 2] == "A" and rows[i - 3][j + 3] == "S" then
                        out = out + 1
                    end
                end

                -- S...
                -- .A..
                -- ..M.
                -- ...X
                if i > 3 and j > 3 then
                    if rows[i - 1][j - 1] == "M" and rows[i - 2][j - 2] == "A" and rows[i - 3][j - 3] == "S" then
                        out = out + 1
                    end
                end

                -- ...X
                -- ..M.
                -- .A..
                -- S...
                if i < #rows - 2 and j > 3 then
                    if rows[i + 1][j - 1] == "M" and rows[i + 2][j - 2] == "A" and rows[i + 3][j - 3] == "S" then
                        out = out + 1
                    end
                end

            end
        end
    end
    return out
end

function countX_MAX(rows)
    local out = 0
    local paterns = {
        {"M", "M", "S", "S"},
        {"S", "S", "M", "M"},
        {"M", "S", "M", "S"},
        {"S", "M", "S", "M"}
    }
    for i, row in ipairs(rows) do
        for j, col in ipairs(row) do
            if col == "A" then
                if i < #rows and i > 1 and j > 1 and j < #row then
                    for _, patern in ipairs(paterns) do
                        if rows[i-1][j-1] == patern[1] and rows[i-1][j+1] == patern[2] and rows[i+1][j-1] == patern[3] and rows[i+1][j+1] == patern[4] then
                            out = out + 1
                        end
                    end
                end
            end
        end
    end
    return out
end


input = readFile("input.txt")
-- input = "MMMSXXMASM\nMSAMXMSMSA\nAMXSXMAAMM\nMSAMASMSMX\nXMASAMXAMM\nXXAMMXXAMA\nSMSMSASXSS\nSAXAMASAAA\nMAMMMXMMMM\nMXMXAXMASX\n"
rows = split(input, "\n")

newrows = {}

for _, row in ipairs(rows) do
    newrow = {}
    for char in row:gmatch(".") do
        table.insert(newrow, char)
    end
    table.insert(newrows, newrow)
end

rows = newrows

-- for i, row in ipairs(rows) do
--     for j, col in ipairs(row) do
--         io.write(col)
--     end
--     print()
-- end

print(#rows)

print(countXMAX(rows))
print(countX_MAX(rows))











