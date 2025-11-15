-- Simple Gyroscope Test - 90 degrees left then 90 degrees right

print("Gyroscope Test Started")

-- Helper function to stop motors
function stop()
    leftMotor.setSpeed(0)
    rightMotor.setSpeed(0)
    leftMotor.setReversed(false)
    rightMotor.setReversed(false)
end

-- Helper function to turn left (counter-clockwise)
function turnLeft(speed)
    leftMotor.setReversed(true)
    leftMotor.setSpeed(speed)
    rightMotor.setReversed(false)
    rightMotor.setSpeed(speed)
end

-- Helper function to turn right (clockwise)
function turnRight(speed)
    leftMotor.setReversed(false)
    leftMotor.setSpeed(speed)
    rightMotor.setReversed(true)
    rightMotor.setSpeed(speed)
end

-- Function to rotate using gyroscope
function rotateByAngle(direction, targetDegrees)
    print(string.format("\n=== Rotating %s by %.1f degrees ===", direction, targetDegrees))

    local accumulated = 0.0
    local prevTime = millis()

    -- Start rotation
    if direction == "left" then
        turnLeft(150)
    else
        turnRight(150)
    end

    -- Integration loop
    local stuckCounter = 0
    local lastAccumulated = 0

    while accumulated < targetDegrees do
        delay(1)  -- Allow simulation to update

        local currTime = millis()
        local dt = (currTime - prevTime) / 1000.0
        prevTime = currTime

        if dt > 0 then
            local angVel = gyroscope:getAngularVelocity()
            local delta = math.abs(angVel * dt)
            accumulated = accumulated + delta

            -- Debug output every 10 degrees
            if math.floor(accumulated / 10) > math.floor((accumulated - delta) / 10) then
                print(string.format("  %.1f° / %.1f° (vel: %.1f°/s, dt: %.4fs)",
                      accumulated, targetDegrees, angVel, dt))
            end

            -- Check if we're stuck (not accumulating anymore)
            if math.abs(accumulated - lastAccumulated) < 0.01 then
                stuckCounter = stuckCounter + 1
                if stuckCounter > 100 then
                    print(string.format("  STUCK at %.1f° - angular velocity too low!", accumulated))
                    -- Boost speed to get moving again
                    if direction == "left" then
                        turnLeft(150)
                    else
                        turnRight(150)
                    end
                    stuckCounter = 0
                end
            else
                stuckCounter = 0
            end
            lastAccumulated = accumulated

            -- Don't slow down - keep constant speed to avoid getting stuck
            -- Removing proportional control for now
        end
    end

    stop()
    print(string.format("  Complete! Rotated %.1f° (error: %.1f°)", accumulated, accumulated - targetDegrees))
    delay(500)
end

-- Test sequence
print("\nWaiting 1 second before start...")
delay(1000)

-- Rotate left 90 degrees
rotateByAngle("left", 90.0)

delay(1000)

-- Rotate right 90 degrees
rotateByAngle("right", 90.0)

print("\n=== Test Complete ===")
