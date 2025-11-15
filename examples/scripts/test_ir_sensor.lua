-- Test script for IR sensor
print("=== IR Sensor Test ===")
print("")

-- Test 1: Read sensor value while stationary
print("Test 1: Reading IR sensor value...")
local value = ir:read()
print(string.format("IR sensor value: %d", value))
print("")

-- Explain the value
if value < 200 then
    print("Surface: Very light/white (high reflection)")
elseif value < 500 then
    print("Surface: Light gray")
elseif value < 700 then
    print("Surface: Medium gray")
elseif value < 900 then
    print("Surface: Dark gray")
else
    print("Surface: Very dark/black (low reflection)")
end

print("")

-- Test 2: Move forward slowly while reading sensor
print("Test 2: Moving forward and sampling every 100ms...")
print("(Stop the script to end)")

local sampleCount = 0
local maxSamples = 20

while sampleCount < maxSamples do
    -- Move forward slowly
    leftMotor.setSpeed(100)
    rightMotor.setSpeed(100)

    -- Read IR sensor
    local reading = ir:read()
    sampleCount = sampleCount + 1

    print(string.format("Sample %d: IR value = %d", sampleCount, reading))

    delay(100)
end

-- Stop robot
leftMotor.setSpeed(0)
rightMotor.setSpeed(0)

print("")
print("=== Test Complete ===")
