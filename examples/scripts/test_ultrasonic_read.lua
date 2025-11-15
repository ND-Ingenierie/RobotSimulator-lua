-- Test script for simplified ultrasonic sensor API
print("=== Ultrasonic Sensor Read Test ===")
print("")

-- Point servo forward
servo:write(90)
print("Servo positioned at 90 degrees (forward)")

-- Wait a moment for servo to settle
delay(500)

-- Test the new read() method
print("Testing ultrasonic:read() method...")
local distance = ultrasonic:read()

print(string.format("Distance measured: %.1f cm", distance))

if distance < 400.0 then
    print("Obstacle detected!")
else
    print("No obstacle detected (max range)")
end

print("")
print("=== Test Complete ===")
