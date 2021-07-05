make:
	rm -rf lua
	mkdir -p lua
	echo "-- THIS FILE WAS AUTO-GENERATED" >> lua/init.lua
	echo "-- See fnl/init.fnl for source" >> lua/init.lua
	fennel --compile fnl/init.fnl >> lua/init.lua
