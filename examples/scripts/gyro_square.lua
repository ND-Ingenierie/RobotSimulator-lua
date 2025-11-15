-- Square Pattern with Gyroscope
-- This script demonstrates using the gyroscope to drive in a precise square pattern

local DRIVE_SPEED = 200
local TURN_SPEED = 150
local SIDE_LENGTH_MS = 2000  -- Drive for 2 seconds per side

function driveForward(duration)
    leftMotor.setReversed(false)
    rightMotor.setReversed(false)
    leftMotor.setSpeed(DRIVE_SPEED)
    rightMotor.setSpeed(DRIVE_SPEED)
    delay(duration)
end

function turnRight90()
    -- Reset gyro
    gyroscope:reset()
    delay(50)

    -- Turn until we've rotated 90 degrees
    leftMotor.setReversed(false)
    rightMotor.setReversed(false)
    leftMotor.setSpeed(TURN_SPEED)
    rightMotor.setSpeed(0)

    while true do
        local angle = gyroscope:read()
        if angle >= 90 then
            break
        end
        delay(10)
    end

    -- Stop
    leftMotor.setSpeed(0)
    rightMotor.setSpeed(0)
    delay(500)
end

print("Driving in square pattern...")

-- Drive in a square
for i = 1, 4 do
    print("Side " .. i)
    driveForward(SIDE_LENGTH_MS)
    turnRight90()
end

print("Square complete!")

-- Stop
leftMotor.setSpeed(0)
rightMotor.setSpeed(0)
