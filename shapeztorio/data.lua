
--Pre feed seed
local seed = settings.startup["shapez-random-seed"].value
local v = 0
for i = 0, seed % 2 do
    v = math.random()
end
for i = 0, seed % 3 do
    v = math.random()
end
for i = 0, seed % 5 do
    v = math.random()
end
for i = 0, seed % 7 do
    v = math.random()
end
for i = 0, seed % 11 do
    v = math.random()
end
for i = 0, seed / 13 do
    v = math.random()
end
for i = 0, seed / 17 do
    v = math.random()
end
for i = 0, seed % 19 do
    v = math.random()
end
for i = 0, seed % 23 do
    v = math.random()
end
for i = 0, seed % 29 do
    v = math.random()
end



require("__shapeztorio__/prototypes/item-groups")
require("__shapeztorio__/prototypes/recipe-category")
require("__shapeztorio__/prototypes/item")
require("__shapeztorio__/prototypes/shapez")
require("__shapeztorio__/prototypes/fluid")
require("__shapeztorio__/prototypes/entities")
require("__shapeztorio__/prototypes/technology")
require("__shapeztorio__/prototypes/recipe")
