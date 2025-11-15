-- Line Following Example
-- This script demonstrates basic line following using dual IR sensors

local BASE_SPEED = 200
local TURN_SPEED = 150
local LINE_THRESHOLD = 512

local function driveForward(speed)
    leftMotor.setReversed(false)
    rightMotor.setReversed(false)
    leftMotor.setSpeed(speed)
    rightMotor.setSpeed(speed)
end

while true do
    local leftValue = irLeft:read()
    local rightValue = irRight:read()

    local leftOnLine = leftValue > LINE_THRESHOLD
    local rightOnLine = rightValue > LINE_THRESHOLD

    if leftOnLine and rightOnLine then
        -- Both sensors on line - go straight
        driveForward(BASE_SPEED)
    elseif leftOnLine then
        -- Only left sensor on line - turn left
        leftMotor.setSpeed(TURN_SPEED / 2)
        rightMotor.setSpeed(TURN_SPEED)
    elseif rightOnLine then
        -- Only right sensor on line - turn right
        leftMotor.setSpeed(TURN_SPEED)
        rightMotor.setSpeed(TURN_SPEED / 2)
    else
        -- Lost the line - stop
        leftMotor.setSpeed(0)
        rightMotor.setSpeed(0)
    end

    delay(20)
end
