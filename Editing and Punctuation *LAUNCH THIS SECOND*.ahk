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
^w::                                                                 
 Send ^c
sleep, 50
StringUpper Clipboard, Clipboard
 Send %Clipboard%
RETURN
^g:: ^d
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
^.:: Send, {Backspace}.{Space}   
^,:: Send, {Backspace},{Space}
+^1:: Send, {BackSpace}!{Space}
+^?:: Send, {BackSpace}?{Space}

