; for adding an upstroke space 
$Space::
if T = 0
Send  {Space}
T = 1
return

$Space  Up::
if T = 1
Send  {Space}
T = 0
return
