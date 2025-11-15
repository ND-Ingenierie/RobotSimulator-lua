-- Obstacle Avoidance Example
-- This script demonstrates obstacle detection and avoidance using the ultrasonic sensor

local DRIVE_SPEED = 200
local TURN_SPEED = 150
local MIN_DISTANCE = 50  -- Stop if obstacle within 50cm

while true do
    -- Point ultrasonic sensor forward
    servo.setAngle(0)
    delay(100)

    local distance = ultrasonic:read()

    if distance < MIN_DISTANCE then
        -- Obstacle detected - stop and turn
        leftMotor.setSpeed(0)
        rightMotor.setSpeed(0)
        delay(500)

        -- Turn right
        leftMotor.setReversed(false)
        rightMotor.setReversed(false)
        leftMotor.setSpeed(TURN_SPEED)
        rightMotor.setSpeed(0)
        delay(1000)
    else
        -- Clear path - drive forward
        leftMotor.setReversed(false)
        rightMotor.setReversed(false)
        leftMotor.setSpeed(DRIVE_SPEED)
        rightMotor.setSpeed(DRIVE_SPEED)
    end

    delay(50)
end
