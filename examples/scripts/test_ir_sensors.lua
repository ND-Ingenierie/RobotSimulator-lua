-- Test script for dual IR sensors
print("=== Dual IR Sensor Test ===")
print("")

-- Test 1: Read both sensor values while stationary
print("Test 1: Reading both IR sensor values...")
local leftValue = irLeft:read()
local rightValue = irRight:read()
print(string.format("Left IR sensor:  %d", leftValue))
print(string.format("Right IR sensor: %d", rightValue))
print("")

-- Explain the values
local function describeSurface(value)
    if value < 200 then
        return "Very light/white (high reflection)"
    elseif value < 500 then
        return "Light gray"
    elseif value < 700 then
        return "Medium gray"
    elseif value < 900 then
        return "Dark gray"
    else
        return "Very dark/black (low reflection)"
    end
end

print("Left sensor:  " .. describeSurface(leftValue))
print("Right sensor: " .. describeSurface(rightValue))
print("")

-- Test 2: Move forward slowly while reading both sensors
print("Test 2: Moving forward and sampling both sensors every 100ms...")
print("(Stop the script to end)")

local sampleCount = 0
local maxSamples = 20

while sampleCount < maxSamples do
    -- Move forward slowly
    leftMotor.setSpeed(100)
    rightMotor.setSpeed(100)

    -- Read both IR sensors
    local leftReading = irLeft:read()
    local rightReading = irRight:read()
    sampleCount = sampleCount + 1

    print(string.format("Sample %d: Left=%d, Right=%d", sampleCount, leftReading, rightReading))

    delay(100)
end

-- Stop robot
leftMotor.setSpeed(0)
rightMotor.setSpeed(0)

print("")
print("=== Test Complete ===")
