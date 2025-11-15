-- Servo Demo Script
-- Demonstrates servo sweeping motion and ultrasonic sensor readings

print("Servo Demo Script Started")

-- Set initial servo position
servo:write(90)
print("Initial servo angle: 90 degrees")
print("Starting servo sweep demo...")

-- Sweep from 90 to 180 degrees
for angle = 90, 180, 10 do
    servo:write(angle)
    print(string.format("Servo angle: %d degrees", angle))

    -- Read ultrasonic sensor distance
    local distance = ultrasonic:read()
    if distance < 400.0 then
        print(string.format("  Distance: %.1f cm", distance))
    else
        print("  No obstacle detected")
    end

    delay(200)  -- Wait between measurements
end

print("Reached maximum angle: 180 degrees")
delay(500)

-- Sweep from 180 back to 0 degrees
for angle = 180, 0, -10 do
    servo:write(angle)
    print(string.format("Servo angle: %d degrees", angle))

    -- Read ultrasonic sensor distance
    local distance = ultrasonic:read()
    if distance < 400.0 then
        print(string.format("  Distance: %.1f cm", distance))
    else
        print("  No obstacle detected")
    end

    delay(200)
end

print("Reached minimum angle: 0 degrees")
delay(500)

-- Return to center
servo:write(90)
print("Returned to center position")
print("Servo demo complete!")
