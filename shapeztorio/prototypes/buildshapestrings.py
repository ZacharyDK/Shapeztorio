#shape_code = ["C","R","S","D"]
#color_code = ["u","r","g","b","c","y","m","w"]

shape_code = ["C","R"]
color_code = ["r","g","b","w"]

#The max for any prototype category is 65535. I don't have the item budget or recipe budget to add all the shapez into factorio
#16^4 is 65536
#shape_code_len x color_code_len + 1 = quarter_codes. quarter_codes^4 is the total number of shapez items. +1 is for the -- space
#With just 2 shapez, and 4 colors we get 9 possible quarters. 9^4 is 6561. This gives a ~10 shapez recipes to include.

quarter_code = []
for i in (shape_code):
    for j in (color_code):
        q = i + j
        quarter_code.append(q)

quarter_code.append("--")

shape_layer = {}

for RU in (quarter_code):
    for RL in (quarter_code):
        for LL in (quarter_code):
            for LU in (quarter_code):
                layer = {}
                layer.update({"RU" : RU, "RL" : RL , "LL" : LL, "LU" : LU })
                key = RU + RL + LL + LU
                shape_layer[key] = layer

file = open("test.txt",'w')

for s in shape_layer:
    #file.write(s + '\n')
    if(s != "--------"):
        file.write(s + " ") #we can use string.gmatch(line, "[^%s]+") to get an iterator from this string, and then do stuff...

file.close()