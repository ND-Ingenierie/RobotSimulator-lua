-- Test script for Lidar sensor

print("=== Lidar Test ===")
print("")

-- Check if lidar exists
if not lidar then
    print("ERROR: Lidar not available!")
    return
end

-- Read lidar measurements (scans automatically every frame)
print("Reading 360° lidar data...")
local readings = lidar:read()

-- Count total readings
local count = 0
for _ in pairs(readings) do
    count = count + 1
end

print(string.format("Total readings: %d (expected 72 readings at 5° intervals)", count))
print("")

-- Display some sample readings
print("Sample readings:")
print(string.format("    0°: %.1f cm", readings[360] or 0))  -- 360° = 0° (forward)
print(string.format("   45°: %.1f cm", readings[45] or 0))   -- Right-forward
print(string.format("   90°: %.1f cm", readings[90] or 0))   -- Right
print(string.format("  135°: %.1f cm", readings[135] or 0))  -- Right-backward
print(string.format("  180°: %.1f cm", readings[180] or 0))  -- Backward
print(string.format("  225°: %.1f cm", readings[225] or 0))  -- Left-backward
print(string.format("  270°: %.1f cm", readings[270] or 0))  -- Left
print(string.format("  315°: %.1f cm", readings[315] or 0))  -- Left-forward
print("")

-- Find closest obstacle
local minDistance = 400.0
local minAngle = 0
for angle, distance in pairs(readings) do
    if distance < minDistance then
        minDistance = distance
        minAngle = angle
    end
end

print(string.format("Closest obstacle: %.1f cm at %d°", minDistance, minAngle))
print("")

-- Find direction with most clearance
local maxDistance = 0
local maxAngle = 0
for angle, distance in pairs(readings) do
    if distance > maxDistance then
        maxDistance = distance
        maxAngle = angle
    end
end

print(string.format("Most clearance: %.1f cm at %d°", maxDistance, maxAngle))
print("")

-- Count obstacles in front (315° to 45° = forward 90° arc)
local obstaclesInFront = 0
for angle = 315, 360, 5 do
    if readings[angle] and readings[angle] < 50.0 then
        obstaclesInFront = obstaclesInFront + 1
    end
end
for angle = 5, 45, 5 do
    if readings[angle] and readings[angle] < 50.0 then
        obstaclesInFront = obstaclesInFront + 1
    end
end

print(string.format("Obstacles within 50cm in front arc: %d", obstaclesInFront))
print("")

print("=== Test Complete ===")
