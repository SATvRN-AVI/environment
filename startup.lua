peripheralList = peripheral.getNames() 

shell.setAlias("Main Menu", "startup")
os.pullEvent("key")
textutils.slowPrint("Booting SATvRN Core, standby...")
os.sleep(1)
print("Press any key to continue...")

if next(peripheralList) then 
    
    for i = 1, #peripheralList do
        print("There is a "..peripheral.getType(peripheralList[i]).." connected to the \""..peripheralList[i].."\"")
        if peripheral.getType(peripheralList[i]) == "modem" then
            os.sleep(1)
            textutils.slowPrint("Modem found!")
            os.sleep(2)
            print("For a list of commands type \""corelist"\"") 
            io.write("Awaiting command: ")
            local userinput = io.read()
            if userinput == "y" then
                rednet.open(peripheralList[i])
                textutils.slowPrint("Modem powered up, loading boot sequence for manual control. Standby...")
                os.sleep(2)
                local id = multishell.launch({}, "/customboot/manualwireless")
                multishell.setTitle(id, "Manual Control")
                shell.switchTab(2)
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