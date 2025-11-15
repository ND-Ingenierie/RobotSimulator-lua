-- Test script for the dump() function

print("=== Testing dump() function ===\n")

-- Test 1: Simple values
print("Test 1: Simple values")
dump(42)
print("")

dump("Hello World")
print("")

dump(true)
print("")

dump(nil)
print("")

-- Test 2: Simple table
print("\nTest 2: Simple table")
local simple = {
    name = "Robot",
    speed = 150,
    active = true
}
dump(simple)
print("")

-- Test 3: Array
print("\nTest 3: Array")
local array = {10, 20, 30, 40, 50}
dump(array)
print("")

-- Test 4: Nested table
print("\nTest 4: Nested table")
local nested = {
    position = {
        x = 100,
        y = 200
    },
    velocity = {
        x = 5.5,
        y = -3.2
    },
    name = "TestRobot"
}
dump(nested)
print("")

-- Test 5: Motor API
print("\nTest 5: Motor API (leftMotor)")
dump(leftMotor)
print("")

-- Test 6: Gyroscope API
print("\nTest 6: Gyroscope API")
dump(gyroscope)
print("")

-- Test 7: Mixed table
print("\nTest 7: Mixed table (array + named fields)")
local mixed = {
    "first",
    "second",
    "third",
    name = "mixed",
    count = 3
}
dump(mixed)
print("")

print("=== All tests complete ===")
