# GymNotes
Pure SwiftUI App of an notes for Gym Strength Training and More

## DB Tables Schemas

###Item (each item represent one workout record)
|properties|type|
|---|---|
|category|Category| 
|timestamp|Date|
|updateState|Int64|
|itemId|String| 
|content|Content|

**category, content to be relationship?**

###Category (the category of each workout, e.g. Strength, Bike, Running, etc.)
|properties|type|
|---|---|
|rawValue|Int|

###Content 
|properties|type|
|---|---|
|itemId|String|
|order|Int64|
|contentDesc|String| 
|reps|Int64|
|timeInterval|Int64|
