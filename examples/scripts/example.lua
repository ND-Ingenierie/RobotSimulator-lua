-- Example Robot Script for Students
-- This demonstrates the motor control API

print("Robot script starting...")

-- Available functions:
-- print(msg)              - Output text to console
-- delay(ms)               - Sleep for specified milliseconds
-- millis()                - Returns milliseconds since script start
--
-- leftMotor.setSpeed(0-255)    - Set left motor speed (128 = stop, 0 = full reverse, 255 = full forward)
-- leftMotor.setReversed(bool)  - Reverse left motor direction
-- leftMotor.getSpeed()         - Get current left motor speed
--
-- rightMotor.setSpeed(0-255)   - Set right motor speed
-- rightMotor.setReversed(bool) - Reverse right motor direction
-- rightMotor.getSpeed()        - Get current right motor speed

-- Example 1: Basic movement
print("Moving forward")
leftMotor.setSpeed(200)
rightMotor.setSpeed(200)
delay(2000)

print("Stopping")
leftMotor.setSpeed(128)  -- 128 is neutral/stop
rightMotor.setSpeed(128)
delay(1000)

-- Example 2: Turning
print("Turning right")
leftMotor.setSpeed(200)   -- Left motor fast
rightMotor.setSpeed(100)  -- Right motor slow
delay(1500)

-- Example 3: Using motor reversal for differential drive
print("Setting up differential drive (reversed left motor)")
leftMotor.setReversed(true)

print("Both motors forward (robot should go straight)")
leftMotor.setSpeed(200)
rightMotor.setSpeed(200)
delay(2000)

-- Final stop
leftMotor.setSpeed(128)
rightMotor.setSpeed(128)

print("Script complete after " .. millis() .. "ms")
