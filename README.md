# Widget

## Usage
```elixir
# Start the ETS store
{:ok, pid} = Widget.ETSStore.start_link

# Create a new item
item = %Widget.Item{value: "hello"}

# Save the item
Widget.ETSStore.save(item)

# Find the item
Widget.ETSStore.find(1)

# Attempt to find an item that doesn't exist
Widget.ETSStore.find(2)

# Count the existing items
Widget.ETSStore.count
```
