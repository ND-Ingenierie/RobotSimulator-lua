-- IR Sensor Test
-- This script prints IR sensor readings to help you calibrate and understand sensor behavior

print("IR Sensor Test - Starting...")
print("Left IR | Right IR")
print("-------------------")

while true do
    local leftValue = irLeft:read()
    local rightValue = irRight:read()

    print(string.format("%7d | %8d", leftValue, rightValue))

    -- Stop motors during testing
    leftMotor.setSpeed(0)
    rightMotor.setSpeed(0)

    delay(200)
end
