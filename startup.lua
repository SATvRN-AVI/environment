peripheralList = peripheral.getNames() 

print("Press any key to continue...")

if next(peripheralList) then
    local event = os.pullEvent("char")  
    local id = multishell.launch({}, "rom/programs/")
    for i = 1, #peripheralList do
        print("There is a "..peripheral.getType(peripheralList[i]).." connected to the \""..peripheralList[i].."\"")
        if peripheral.getType(peripheralList[i]) == "modem" then
            textutils.slowPrint("Modem found! Accessing modem...")
            os.sleep(2)
            io.write("To power up modem for remote use, press Y, otherwise press N: ")
            local userinput = io.read()
            if userinput == "y" then
                rednet.open(peripheralList[i])
                textutils.slowPrint("Modem powered up, loading boot sequence for manual control. Standby...")
                os.sleep(2)
                local id = multishell.launch({}, "/customboot/manualwireless")
                multishell.setTitle(id, "Manual Control")
                shell.switchTab(2)
                return
                shell.exit()
            elseif userinput == "n" then
                textutils.slowPrint("Returning to root...")
                return
            else
                print("This key is not recognized, please hit Y or N...")
            end
        end
    end
else
    textutils.slowPrint("Could not find any peripherals. Terminating bootup...")
    return
end