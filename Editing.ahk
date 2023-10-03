$2:: Send, {Space}
$^2:: Send, {F3}{F3}{F3}{F3}{F3}
$^3:: Send, {F4}{F4}{F4}{F4}{F4}
$^+,:: Send, ^.
$^+.:: Send, ^,
$MButton:: Send, ?
$+MButton:: Send, {Return}
$XButton1:: Send, .
$XButton2:: Send, ,
$RButton:: Send, {Backspace}
^RButton:: Send, ^{Backspace}
$^MButton:: Send, {Return}{Return}
$^XButton1:: Send, ...
$^XButton2:: Send, '   
$+XButton1:: Send, -
$^w::                                                                 
 Send ^c
sleep, 50
StringUpper Clipboard, Clipboard
 Send %Clipboard%
RETURN
^g:: ^d
^9:: Send, 9
$9:: Send, {Backspace}s{Space}
^e::                                                                 
 Send ^c
sleep, 50
 StringLower Clipboard, Clipboard
 Send %Clipboard%
RETURN
^s::                                                                 
 Send ^c
sleep, 50
 StringUpper Clipboard, Clipboard
 Send "%Clipboard%
RETURN
$^d::Send "
$+^w:: Send ^w
$^.:: Send, {Backspace}.{Space}   
$^,:: Send, {Backspace},{Space}
$+^1:: Send, {BackSpace}!{Space}
$+^?:: Send, {BackSpace}?{Space}
$^Tab::                                                                 
 Send ^c
sleep, 50
 StringUpper Clipboard, Clipboard
 StringReplace , Clipboard, Clipboard, %A_Space%,,All
 Send %Clipboard%
RETURN
$Space:: Send, 2