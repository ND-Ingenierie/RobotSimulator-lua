-- Test Robot Script - Motor Control Demo
-- Industry-standard motor API

print("Robot script loaded!")

-- Test motor API
print("Testing motor controls...")

-- Move forward
print("Moving forward at speed 200")
leftMotor.setReversed(false)
leftMotor.setReversed(true)
leftMotor.setSpeed(200)
rightMotor.setSpeed(200)

delay(3000)

-- Stop
print("Stopping")
leftMotor.setSpeed(128)
rightMotor.setSpeed(0)
delay(10000)

-- Turn right
print("Turning right")
leftMotor.setSpeed(200)
rightMotor.setSpeed(50)
delay(2000)

-- Reverse left motor for differential drive
print("Testing motor reversal")
leftMotor.setReversed(true)
leftMotor.setSpeed(200)
rightMotor.setSpeed(200)
delay(2000)

-- Stop
print("Final stop")
leftMotor.setSpeed(128)
rightMotor.setSpeed(128)

print("Motor test complete!")
