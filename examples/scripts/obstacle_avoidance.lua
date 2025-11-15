-- Obstacle Avoidance Demo Script
-- Robot moves forward until obstacle < 30cm, then scans left/right and turns toward biggest distance

print("Obstacle Avoidance Demo Started")

-- Constants
local OBSTACLE_THRESHOLD = 30.0  -- cm
local FORWARD_SPEED = 180  -- 0-255 range (180 is about 70% speed)
local TURN_SPEED = 120     -- 0-255 range (120 is about 47% speed)
local SCAN_ANGLES = {0, 45, 90, 135, 180}  -- Servo angles to scan
local SERVO_DEFAULT_SPEED = 300.0  -- degrees per second (fixed servo speed)

-- Helper function to move forward
function moveForward(speed)
    leftMotor.setReversed(false)
    rightMotor.setReversed(false)
    leftMotor.setSpeed(speed)
    rightMotor.setSpeed(speed)
end

-- Helper function to turn right in place
function turnRight(speed)
    leftMotor.setReversed(false)
    leftMotor.setSpeed(speed)
    rightMotor.setReversed(true)
    rightMotor.setSpeed(speed)
end

-- Helper function to turn left in place
function turnLeft(speed)
    leftMotor.setReversed(true)
    leftMotor.setSpeed(speed)
    rightMotor.setReversed(false)
    rightMotor.setSpeed(speed)
end

-- Helper function to stop
function stop()
    leftMotor.setSpeed(0)
    rightMotor.setSpeed(0)
end

-- Function to wait until servo reaches target angle (within tolerance)
function waitForServo(targetAngle, tolerance)
    tolerance = tolerance or 2.0  -- Default 2 degree tolerance
    while math.abs(servo:read() - targetAngle) > tolerance do
        delay(50)  -- Check every 50ms
    end
end

-- Function to scan and get distance at a given servo angle
function getDistanceAtAngle(angle)
    servo:write(angle)
    waitForServo(angle)

    return ultrasonic:read()
end

-- Function to find best direction with real-time scanning (returns angle with biggest distance)
function findBestDirection()
    print("Scanning for best direction...")

    local maxDistance = 0
    local bestAngle = 90

    for i, angle in ipairs(SCAN_ANGLES) do
        local distance = getDistanceAtAngle(angle)
        print(string.format("  Angle %d°: %.1f cm", angle, distance))

        if distance > maxDistance then
            maxDistance = distance
            bestAngle = angle
        end
    end

    print(string.format("Best direction: %d° (%.1f cm)", bestAngle, maxDistance))

    return bestAngle, maxDistance
end

-- Main loop
local running = true
local loopCount = 0

while running do
    loopCount = loopCount + 1
    print(string.format("\n=== Loop %d ===", loopCount))

    -- Point servo forward
    servo:write(90)

    -- Check distance ahead
    local distance = ultrasonic:read()
    print(string.format("Distance ahead: %.1f cm", distance))

    if distance < OBSTACLE_THRESHOLD then
        -- Obstacle detected! Stop and scan
        print("Obstacle detected! Stopping...")
        stop()
        delay(500)

        -- Scan left and right to find best direction
        local bestAngle, bestDistance = findBestDirection()

        -- Determine turn direction based on best angle
        -- 90 = forward, <90 = right, >90 = left
        if bestAngle < 90 then
            print("Turning RIGHT toward best direction...")
            local turnTime = 200  -- Approximate ms per degree
            turnRight(200)
            delay(turnTime)
            stop()
        else
            print("Turning LEFT toward best direction...")
            local turnTime = 200  -- Approximate ms per degree
            turnLeft(200)
            delay(turnTime)
            stop()
        end

        delay(500)
    else
        -- Path is clear, move forward
        print("Path clear, moving forward...")
        moveForward(FORWARD_SPEED)
        delay(500)
    end

    -- Safety limit: stop after 50 loops
    if loopCount >= 50 then
        print("\nReached loop limit, stopping...")
        running = false
    end
end

-- Final cleanup
stop()
servo:write(90)
print("\nObstacle Avoidance Demo Complete!")
