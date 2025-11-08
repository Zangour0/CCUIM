------ TUTLE PROGRAM -------
rednet.open("left")
local CT = peripheral.wrap("right")
local st = fs.open("startup","w")
st.write("shell.run('"..tostring(  fs.getName(shell.getRunningProgram()):gsub("%.lua$"," ")  ).."')")
st.close()
-----------------------------------------
local function DC()
    local Succeed = false
    while true do
        sleep(0)
        local ID,MSG = rednet.receive()
        for i = 1, 9 do
            if i <= 3 then
                turtle.select(i)
            elseif i >= 4 and i <= 6 then
                turtle.select(i+1)
            elseif i >= 7 and i <= 9 then
                turtle.select(i+2)
            end
            if MSG[i] == "" then
            else
                turtle.suckUp(1)
            end
        end
        Succeed = CT.craft(64)
        turtle.dropUp(64)
        for i = 1,10 do
            if i == 4 or i == 8 then
            else
                turtle.select(i)
                turtle.dropUp(64) 
            end
        end
        rednet.send(ID,Succeed)
    end
end
DC()
