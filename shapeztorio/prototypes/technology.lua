data:extend(
{
    {
        type = "technology",
        name = "shapez-discovery",
        icon = "__shapeztorio__/graphics/shapezlogo.png",
        icon_size = 128,
        essential = true,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "painter-plant"
            },
            {
                type = "unlock-recipe",
                recipe = "shapez-plant"
            },
            {
                type = "unlock-recipe",
                recipe = "rotator-CW"
            },
            {
                type = "unlock-recipe",
                recipe = "rotator-CCW"
            },
            {
              type = "unlock-recipe",
              recipe = "half-destroyer-L"
            },
            {
              type = "unlock-recipe",
              recipe = "half-destroyer-R"
            },
            {
               type = "unlock-recipe",
               recipe = "shapez-splitter"
            },
            {
               type = "unlock-recipe",
               recipe = "rotate-stack-180"
            },
            {
                type = "unlock-recipe",
                recipe = "rotate-stack-90-CW"
            },
            {
                type = "unlock-recipe",
                recipe = "swap-box"
            },
            {
                type = "unlock-recipe",
                recipe = "shapez-lab"
            },
  
        },
        prerequisites = {"automation-science-pack","logistic-science-pack","chemical-science-pack"},
        unit =
        {
          count = 100,
          ingredients =
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
          },
          time = 60
        }
      },
})