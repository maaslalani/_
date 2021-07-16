make:
	echo "-- THIS FILE WAS AUTO-GENERATED (source fnl/init.fnl)" > lua/init.lua
	fennel --compile fnl/init.fnl >> lua/init.lua
