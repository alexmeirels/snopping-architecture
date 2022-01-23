onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Snooping/Clock
add wave -noupdate /Snooping/state1
add wave -noupdate /Snooping/state2
add wave -noupdate /Snooping/WriteRead
add wave -noupdate /Snooping/bus
add wave -noupdate /Snooping/newState1
add wave -noupdate /Snooping/newState2
add wave -noupdate /Snooping/WriteBack
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {176 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1 ns}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 3000ps sim:/Snooping/Clock 
WaveCollapseAll -1
wave clipboard restore
