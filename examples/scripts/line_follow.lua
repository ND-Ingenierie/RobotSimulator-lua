-- Line Following Script
-- Uses two IR sensors (left and right) to follow a black line on a white surface
-- The robot drives straight until it finds a black line, then follows it

print("=== Line Following Script ===")
print("Robot will follow black lines using IR sensors")
print("")

-- Configuration
local BASE_SPEED = 200          -- Normal forward speed
local TURN_SPEED = 150          -- Speed when turning
local LINE_THRESHOLD = 512      -- Values above this are considered "line" (black)

-- State tracking
local foundLine = false
local lastSideSeenLine = "none"  -- Track which side last saw the line: "left", "right", or "none"

-- Movement control functions
local function driveForward(speed)
    leftMotor.setReversed(false)
    rightMotor.setReversed(false)
    leftMotor.setSpeed(speed)
    rightMotor.setSpeed(speed)
end

local function turnLeft(speed)
    -- Turn left by reversing left motor and driving right motor forward
    leftMotor.setSpeed(0)
    rightMotor.setReversed(false)
    rightMotor.setSpeed(speed)
end

local function turnRight(speed)
    -- Turn right by driving left motor forward and reversing right motor
    leftMotor.setReversed(false)
    leftMotor.setSpeed(speed)
    rightMotor.setSpeed(0)
end

local function turnGently(leftSpeed, rightSpeed)
    -- Gentle turn by adjusting motor speeds (both forward)
    leftMotor.setReversed(false)
    rightMotor.setReversed(false)
    leftMotor.setSpeed(leftSpeed)
    rightMotor.setSpeed(rightSpeed)
end

print("Starting line following...")
print("Searching for line...")

-- Main control loop
while true do
    -- Read both IR sensors
    local leftValue = irLeft:read()
    local rightValue = irRight:read()

    -- Determine if each sensor sees the line (black = high value)
    local leftOnLine = leftValue > LINE_THRESHOLD
    local rightOnLine = rightValue > LINE_THRESHOLD

    -- First time detecting the line
    if not foundLine and (leftOnLine or rightOnLine) then
        foundLine = true
        print("Line detected! Following...")
    end

    -- Track which side last saw the line
    if leftOnLine and not rightOnLine then
        lastSideSeenLine = "left"
    elseif rightOnLine and not leftOnLine then
        lastSideSeenLine = "right"
    elseif leftOnLine and rightOnLine then
        -- Both sensors see line, maintain last known side
        -- (or set to "none" if you prefer centered behavior)
    end

    -- Line following logic
    if leftOnLine and rightOnLine then
        -- Both sensors on line: go straight
        driveForward(BASE_SPEED)

    elseif leftOnLine and not rightOnLine then
        -- Only left sensor on line: turn left gently to get back on line
        turnGently(TURN_SPEED, TURN_SPEED / 2)

    elseif rightOnLine and not leftOnLine then
        -- Only right sensor on line: turn right gently to get back on line
        turnGently(TURN_SPEED / 2, TURN_SPEED)

    else
        -- No sensors on line
        if foundLine then
            -- Lost the line - turn toward the side that last saw it
            if lastSideSeenLine == "left" then
                turnRight(TURN_SPEED)
                print("Line lost! Turning right to search...")
            elseif lastSideSeenLine == "right" then
                turnLeft(TURN_SPEED)
                print("Line lost! Turning left to search...")
            else
                -- Unknown - just spin in place to search
                turnRight(TURN_SPEED)
                print("Line lost! Searching...")
            end
        else
            -- Haven't found line yet - drive straight to search
            driveForward(255)
        end
    end

    -- Small delay to avoid overwhelming the system
    delay(20)
end
