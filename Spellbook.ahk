; Dictionary and tweaks by Solomon Kimrey, initial code from Laszlo https://www.autohotkey.com/board/topic/6426-chording-keyboard-strings-sent-at-key-combinations/
#MaxThreadsPerHotkey 10
#MaxThreadsBuffer ON
#MaxHotkeysPerInterval 999
#UseHook
StringCaseSense On
Process Priority,,Realtime
SetKeyDelay -1
BlockInput Send

Low = ``1234567890-=qwertyuiop[]\asdfghjkl`'zxcvbnm,./;
Shft= ~!@#$`%^&*()_+QWERTYUIOP{}|ASDFGHJKL`"ZXCVBNM<>?:
KeySet = ``1234567890-=qwertyuiop[]\asdfghjkl`'zxcvbnm,./;
Loop Parse, KeySet
{
   AllKeys := AllKeys "%x" Asc(A_LoopField) "%"
   HotKey  %A_LoopField%,  KeyDown, B
   HotKey  %A_LoopField% up, KeyUp, B
   HotKey +%A_LoopField%, CKeyDown, B
   HotKey +%A_LoopField% up, KeyUp, B
}
SentTick = 0
SetTimer Action, 10                    ; handle key repeat
RI = 0
Loop                                   ; self healing missed key releases
{                                      ; to prevent infinite repeat
   Sleep 10
   RI := Mod(RI, StrLen(KeySet)) + 1
   StringMid r, KeySet, RI, 1
   If GetKeyState(r,"P")
      Continue
   r := "x" Asc(r)
   %r% =
}
Return

KeyDown:                               ; register keys pressed
   key := "x" Asc(A_ThisHotKey)
   %key% = %A_ThisHotKey%
GoTo Tick

CKeyDown:                              ; register shifted keys pressed
   StringRight k, A_ThisHotKey, 1      ; remove "+"
   StringMid U,Shft,InStr(Low,k,1),1   ; convert k to Shift-%k%
   key := "x" Asc(k)
   %key% = %U%
GoTo Tick
KeyUp:                                 ; register key release
   StringReplace k, A_ThisHotKey, +    ; remove "+"
   key := "x" Asc(k)
   %key% =

Tick:                                  ; register time of key event
   KeyTick = %A_TickCount%
Action:
   Transform keys, Deref, %AllKeys%
   IfNotEqual keys, %key0%, {          ; KEYS CHANGED keys <> key0
      If (keyn = 0 and len0 = 1 and len1 = 0 and keys = "")
            GoSub  SEND1
            
              ; short single key press
      Else If (keyn = 1 and len0 = 1 and len1 = 2 and keys = "" and SentKeys <> key0 and StrLen(SentKeys) = 1)
            GoSub  SEND1   
            
                       ; overlapping keys
      len1:= StrLen(key0)
      len0:= StrLen(keys)
      key0 = %keys%                    ; previous key combination
      keyn = 0                         ; the number of repetitions
   }
   Else {                              ; NO KEY CHANGE keys == key0
      if (keys = ""
       or A_TickCount - KeyTick  < 20  and keyn = 0
       or A_TickCount - SentTick < 360 and keyn = 1
       or A_TickCount - SentTick < 37 and keyn > 1)
         Return
      keyn++
      GoTo SEND
   }
Return

SEND:
   IfLess len0,%len1%
    str = {}         ; no send at releasing keys
SEND1:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
If StrLen(key0) = 1
   {
      Send {%key0%}  
      Return
   }
   
Else If InStr(key0, ".") or InStr(key0, "'") or InStr(key0, ">")
GoSub SENDDOT
Else If InStr(key0, "/") or InStr(key0, "?")
GoSub SENDSLASH
Else If InStr(key0, "q")
GoSub SENDQ
Else If InStr(key0, "w")
GoSub SENDW
Else If InStr(key0, "e")
GoSub SENDE
Else If InStr(key0, "r")
GoSub SENDR
Else If InStr(key0, "t")
GoSub SENDT
Else If InStr(key0, "y")
GoSub SENDY
Else If InStr(key0, "u")
GoSub SENDU
Else If InStr(key0, "i")
GoSub SENDI
Else If InStr(key0, "o")
GoSub SENDO
Else If InStr(key0, "p")
GoSub SENDP
Else If InStr(key0, "a")
GoSub SENDA
Else If InStr(key0, "s")
GoSub SENDS
Else If InStr(key0, "d")
GoSub SENDD
Else If InStr(key0, "f")
GoSub SENDF
Else If InStr(key0, "g")
GoSub SENDG
Else If InStr(key0, "h")
GoSub SENDH
Else If InStr(key0, "j")
GoSub SENDJ
Else If InStr(key0, "k")
GoSub SENDK
Else If InStr(key0, "l")
GoSub SENDL
Else If InStr(key0, "z")
GoSub SENDZ
Else If InStr(key0, "x")
GoSub SENDX
Else If InStr(key0, "c")
GoSub SENDC
Else If InStr(key0, "v")
GoSub SENDV
Else If InStr(key0, "b")
GoSub SENDB
Else If InStr(key0, "n")
GoSub SENDN
Else If InStr(key0, "m")
GoSub SENDM

IfInString, key0, Q
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, W
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, E
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, R
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, T
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, Y
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, U
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, I
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, O
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, P
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, A
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, S
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, D
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, F
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, G
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, H
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, J
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, K
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, Z
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, X
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, C
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, V
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, B
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, N
{
   str := RegExReplace(str, "^(.)", "$T1")
}
IfInString, key0, M
{
   str := RegExReplace(str, "^(.)", "$T1")
}


If InStr(key0, ";") 
{
         if (key0 = "q;")
         Send {BackSpace}{BackSpace}q{Space}
         Else if (key0 = "w;")
         Send {BackSpace}{BackSpace}w{Space}
         Else if (key0 = "e;")
         Send {BackSpace}{BackSpace}e{Space}
         Else if (key0 = "r;")
         Send {BackSpace}{BackSpace}r{Space}
         Else if (key0 = "t;")
         Send {BackSpace}{BackSpace}t{Space}
         Else if (key0 = "y;")
         Send {BackSpace}{BackSpace}y{Space}
         Else if (key0 = "u;")
         Send {BackSpace}{BackSpace}u{Space}
         Else if (key0 = "i;")
         Send {BackSpace}{BackSpace}i{Space}
         Else if (key0 = "o;")
         Send {BackSpace}{BackSpace}o{Space}
         Else if (key0 = "p;")
         Send {BackSpace}{BackSpace}p{Space}
         Else if (key0 = "a;")
         Send {BackSpace}{BackSpace}a{Space}
         Else if (key0 = "s;")
         Send {BackSpace}{BackSpace}s{Space}
         Else if (key0 = "d;")
         Send {BackSpace}{BackSpace}d{Space}
         Else if (key0 = "f;")
         Send {BackSpace}{BackSpace}f{Space}
         Else if (key0 = "g;")
         Send {BackSpace}{BackSpace}g{Space}
         Else if (key0 = "h;")
         Send {BackSpace}{BackSpace}h{Space}
         Else if (key0 = "j;")
         Send {BackSpace}{BackSpace}j{Space}
         Else if (key0 = "k;")
         Send {BackSpace}{BackSpace}k{Space}
         Else if (key0 = "l;")
         Send {BackSpace}{BackSpace}l{Space}
         Else if (key0 = "z;")
         Send {BackSpace}{BackSpace}z{Space}
         Else if (key0 = "x;")
         Send {BackSpace}{BackSpace}x{Space}
         Else if (key0 = "c;")
         Send {BackSpace}{BackSpace}c{Space}
         Else if (key0 = "v;")
         Send {BackSpace}{BackSpace}v{Space}
         Else if (key0 = "b;")
         Send {BackSpace}{BackSpace}b{Space}
         Else if (key0 = "n;")
         Send {BackSpace}{BackSpace}n{Space}
         Else if (key0 = "m;")
         Send {BackSpace}{BackSpace}m{Space}
         Else
         {
            str := RegExReplace(str, "^(.)", "$T1")
            str = {BackSpace}.{Space}%str%
         }
}

If StrLen(key0) > 1 
Send %str%
str = {}
Return

SENDSEMICOLON:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
Return

SENDSLASH:
SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0% 
If (key0 = "ets/" or key0 = "ets/;" or key0 = "ETS?")
    str = {BackSpace}est{Space}
Else if (key0 = "era/" or key0 = "era/;" or key0 = "ERA?")
    str = ear{Space}
Else if (key0 = "tion/" or key0 = "tion/;" or key0 = "TION?")
    str = {BackSpace}{BackSpace}ition{Space}
Else if (key0 = "q/" or key0 = "q/;" or key0 = "Q?")
    str = {BackSpace}q{Space}
Else if (key0 = "w/" or key0 = "w/;" or key0 = "W?")
    str = {BackSpace}w{Space}
Else if (key0 = "ure/" or key0 = "ure/;" or key0 = "URE/")
    str = {backspace}{backspace}ure{Space}
Else if (key0 = "e/" or key0 = "e/;" or key0 = "E?")
    str = {BackSpace}e{Space}
Else if (key0 = "r/" or key0 = "r/;" or key0 = "R?")
    str = {BackSpace}r{Space}
Else if (key0 = "t/" or key0 = "t/;" or key0 = "T?")
    str = {BackSpace}t{Space}
Else if (key0 = "y/" or key0 = "y/;" or key0 = "Y?")
    str = {BackSpace}y{Space}
Else if (key0 = "u/" or key0 = "u/;" or key0 = "U?")
    str = {BackSpace}u{Space}
Else if (key0 = "i/" or key0 = "i/;" or key0 = "I?")
    str = {BackSpace}i{Space}
Else if (key0 = "o/" or key0 = "o/;" or key0 = "O?")
    str = {BackSpace}o{Space}
Else if (key0 = "p/" or key0 = "p/;" or key0 = "P?")
    str = {BackSpace}p{Space}
Else if (key0 = "a/" or key0 = "a/;" or key0 = "A?")
    str = {BackSpace}a{Space}
Else if (key0 = "s/" or key0 = "s/;" or key0 = "S?")
    str = {BackSpace}s{Space}
Else if (key0 = "d/" or key0 = "d/;" or key0 = "D?")
    str = {BackSpace}d{Space}
Else if (key0 = "f/" or key0 = "f/;" or key0 = "F?")
    str = {BackSpace}f{Space}
Else if (key0 = "g/" or key0 = "g/;" or key0 = "G?")
    str = {BackSpace}g{Space}
Else if (key0 = "h/" or key0 = "h/;" or key0 = "H?")
    str = {BackSpace}h{Space}
Else if (key0 = "j/" or key0 = "j/;" or key0 = "J?")
    str = {BackSpace}j{Space}
Else if (key0 = "k/" or key0 = "k/;" or key0 = "K?")
    str = {BackSpace}k{Space}
Else if (key0 = "l/" or key0 = "l/;" or key0 = "L?")
    str = {BackSpace}l{Space}
Else if (key0 = "z/" or key0 = "z/;" or key0 = "Z?")
    str = {BackSpace}z{Space}
Else if (key0 = "x/" or key0 = "x/;" or key0 = "X?")
    str = {BackSpace}x{Space}
Else if (key0 = "c/" or key0 = "c/;" or key0 = "C?")
    str = {BackSpace}c{Space}
Else if (key0 = "v/" or key0 = "v/;" or key0 = "V?")
    str = {BackSpace}v{Space}
Else if (key0 = "b/" or key0 = "b/;" or key0 = "B?")
    str = {BackSpace}b{Space}
Else if (key0 = "n/" or key0 = "n/;" or key0 = "N?")
    str = {BackSpace}n{Space}
Else if (key0 = "m/" or key0 = "m/;" or key0 = "M?")
    str = {BackSpace}m{Space}
Else if (key0 = "tops/" or key0 = "tops/;" or key0 = "TOPS?")
    str = spot{Space}
Else if (key0 = "ts/" or key0 = "ts/;" or key0 = "TS?")
    str = {BackSpace}st{Space}
Else if (key0 = "ertal/" or key0 = "ertal/;" or key0 = "ERTAL?")
    str = latter{Space}
Else if (key0 = "erts/" or key0 = "erts/;" or key0 = "ERTS?")
    str = steer{Space}
Else if (key0 = "erag/" or key0 = "erag/;" or key0 = "ERAG?")
    str = garage{Space}
Else if (key0 = "tosh/" or key0 = "tosh/;" or key0 = "TOSH?")
    str = host{Space}
Else if (key0 = "erp/" or key0 = "erp/;" or key0 = "ERP?")
    str = peer{Space}
Else if (key0 = "ealb/" or key0 = "ealb/;" or key0 = "EALB?")
    str = {BackSpace}{BackSpace}able{Space}
Else if (key0 = "etas/" or key0 = "etas/;" or key0 = "ETAS?")
    str = tease{Space}
Else if (key0 = "wal/" or key0 = "wal/;" or key0 = "WAL?")
    str = law{Space}
Else if (key0 = "esl/" or key0 = "esl/;" or key0 = "ESL?")
    str = {BackSpace}less{Space}
Else if (key0 = "era/" or key0 = "era/;" or key0 = "ERA?")
    str = ear{Space}
Else if (key0 = "ersv/" or key0 = "ersv/;" or key0 = "ERSV?")
    str = sever{Space}
Else if (key0 = "tis/" or key0 = "tis/;" or key0 = "TIS?")
    str = {BackSpace}ist{Space}
Else if (key0 = "eis/" or key0 = "eis/;" or key0 = "EIS?")
    str = {BackSpace}ise{Space}
Else if (key0 = "slcn/" or key0 = "slcn/;" or key0 = "SLCN?")
    str = counsel{Space}
Else if (key0 = "erups/" or key0 = "erups/;" or key0 = "ERUPS?")
    str = pursue{Space}
Else if (key0 = "won/" or key0 = "won/;" or key0 = "WON?")
    str = won{Space}
Else if (key0 = "y/" or key0 = "y/;" or key0 = "Y?")
    str = {backspace}y{Space}
Else if (key0 = "n/" or key0 = "n/;" or key0 = "N?")
    str = {backspace}n{Space}
Return

SENDQ:

   SentTick = %A_TickCount%            
   SentKeys = %key0%
If (key0 = "qerf" or key0 = "qerf;" or key0 = "QERF")
    str = frequency{Space}
Else if (key0 = "qerfn" or key0 = "qerfn;" or key0 = "QERFN")
    str = frequent{Space}
Else if (key0 = "qerui" or key0 = "qerui;" or key0 = "QERUI")
    str = require{Space}
Else if (key0 = "qeu" or key0 = "qeu;" or key0 = "QEU")
    str = queue{Space}
Else if (key0 = "qrac" or key0 = "qrac;" or key0 = "QRAC")
    str = acquire{Space}
Else if (key0 = "qrts" or key0 = "qrts;" or key0 = "QRTS")
    str = request{Space}
Else if (key0 = "qetui" or key0 = "qetui;" or key0 = "QETUI")
    str = quiet{Space}
Else if (key0 = "qeuin" or key0 = "qeuin;" or key0 = "QEUIN")
    str = unique{Space}
Else if (key0 = "qel" or key0 = "qel;" or key0 = "QEL")
    str = equal{Space}
Else if (key0 = "qeru" or key0 = "qeru;" or key0 = "QERU")
    str = queer{Space}
Else if (key0 = "ql" or key0 = "ql;" or key0 = "QL")
    str = quickly{Space}
Else if (key0 = "qetuo" or key0 = "qetuo;" or key0 = "QETUO")
    str = quote{Space}
Else if (key0 = "qfl" or key0 = "qfl;" or key0 = "QFL")
    str = qualify{Space}
Else if (key0 = "qrtuis" or key0 = "qrtuis;" or key0 = "QRTUIS")
    str = squirt{Space}
Else if (key0 = "qyfl" or key0 = "qyfl;" or key0 = "QYFL")
    str = qualify{Space}
Else if (key0 = "qeuip" or key0 = "qeuip;" or key0 = "QEUIP")
    str = equip{Space}
Else if (key0 = "qeuoscn" or key0 = "qeuoscn;" or key0 = "QEUOSCN")
    str = consequence{Space}
Else if (key0 = "qeus" or key0 = "qeus;" or key0 = "QEUS")
    str = {BackSpace}-esque{Space}
Else if (key0 = "qr" or key0 = "qr;" or key0 = "QR")
    str = require{Space}
Else if (key0 = "qrsl" or key0 = "qrsl;" or key0 = "QRSL")
    str = squirrel{Space}
Else if (key0 = "qeryu" or key0 = "qeryu;" or key0 = "QERYU")
    str = query{Space}
Else if (key0 = "qes" or key0 = "qes;" or key0 = "QES")
    str = sequence{Space}
Else if (key0 = "qetyui" or key0 = "qetyui;" or key0 = "QETYUI")
    str = equity{Space}
Else if (key0 = "qrf" or key0 = "qrf;" or key0 = "QRF")
    str = frequent{Space}
Else if (key0 = "qrtfn" or key0 = "qrtfn;" or key0 = "QRTFN")
    str = frequent{Space}
Else if (key0 = "qscn" or key0 = "qscn;" or key0 = "QSCN")
    str = sequence{Space}
Else if (key0 = "qtuanm" or key0 = "qtuanm;" or key0 = "QTUANM")
    str = quantum{Space}
Else if (key0 = "qt" or key0 = "qt;" or key0 = "QT")
    str = question{Space}
Else if (key0 = "qti" or key0 = "qti;" or key0 = "QTI")
    str = quite{Space}
Else if (key0 = "qtl" or key0 = "qtl;" or key0 = "QTL")
    str = quality{Space}
Else if (key0 = "qts" or key0 = "qts;" or key0 = "QTS")
    str = questions{Space}
Else if (key0 = "qtui" or key0 = "qtui;" or key0 = "QTUI")
    str = quit{Space}
Else if (key0 = "qun" or key0 = "qun;" or key0 = "QUN")
    str = unique{Space}
Else if (key0 = "qrt" or key0 = "qrt;" or key0 = "QRT")
    str = quarter{Space}
Return

SENDW:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "wa" or key0 = "wa;" or key0 = "WA")
    str = as well{Space}
Else if (key0 = "wrhv" or key0 = "wrhv;" or key0 = "WRHV")
    str = however{Space}
Else if (key0 = "wertin" or key0 = "wertin;" or key0 = "WERTIN")
    str = winter{Space}
Else if (key0 = "wetas" or key0 = "wetas;" or key0 = "WETAS")
    str = waste{Space}
Else if (key0 = "wiph" or key0 = "wiph;" or key0 = "WIPH")
    str = whip{Space}
Else if (key0 = "wran" or key0 = "wran;" or key0 = "WRAN")
    str = warn{Space}
Else if (key0 = "wrn" or key0 = "wrn;" or key0 = "WRN")
    str = narrow{Space}
Else if (key0 = "wro" or key0 = "wro;" or key0 = "WRO")
    str = row{Space}
Else if (key0 = "wroa" or key0 = "wroa;" or key0 = "WROA")
    str = arrow{Space}
Else if (key0 = "wroan" or key0 = "wroan;" or key0 = "WROAN")
    str = narrow{Space}
Else if (key0 = "wrobn" or key0 = "wrobn;" or key0 = "WROBN")
    str = brown{Space}
Else if (key0 = "wtuoal" or key0 = "wtuoal;" or key0 = "WTUOAL")
    str = outlaw{Space}
Else if (key0 = "wtn" or key0 = "wtn;" or key0 = "WTN")
    str = won't{Space}
Else if (key0 = "werhvn" or key0 = "werhvn;" or key0 = "WERHVN")
    str = whenever{Space}
Else if (key0 = "weoasm" or key0 = "weoasm;" or key0 = "WEOASM")
    str = awesome{Space}
Else if (key0 = "wrpa" or key0 = "wrpa;" or key0 = "WRPA")
    str = wrap{Space}
Else if (key0 = "wlb" or key0 = "wlb;" or key0 = "WLB")
    str = below{Space}
Else if (key0 = "weolb" or key0 = "weolb;" or key0 = "WEOLB")
    str = below{Space}
Else if (key0 = "wan" or key0 = "wan;" or key0 = "WAN")
    str = want to{Space}
Else if (key0 = "wehc" or key0 = "wehc;" or key0 = "WEHC")
    str = chew{Space}
Else if (key0 = "weif" or key0 = "weif;" or key0 = "WEIF")
    str = wife{Space}
Else if (key0 = "weislv" or key0 = "weislv;" or key0 = "WEISLV")
    str = swivel{Space}
Else if (key0 = "werash" or key0 = "werash;" or key0 = "WERASH")
    str = whereas{Space}
Else if (key0 = "werhvn" or key0 = "werhvn;" or key0 = "WERHVN")
    str = whenever{Space}
Else if (key0 = "werin" or key0 = "werin;" or key0 = "WERIN")
    str = winner{Space}
Else if (key0 = "weropm" or key0 = "weropm;" or key0 = "WEROPM")
    str = empower{Space}
Else if (key0 = "werosh" or key0 = "werosh;" or key0 = "WEROSH")
    str = shower{Space}
Else if (key0 = "wertih" or key0 = "wertih;" or key0 = "WERTIH")
    str = wither{Space}
Else if (key0 = "wesk" or key0 = "wesk;" or key0 = "WESK")
    str = skew{Space}
Else if (key0 = "wetishl" or key0 = "wetishl;" or key0 = "WETISHL")
    str = whistle{Space}
Else if (key0 = "whkm" or key0 = "whkm;" or key0 = "WHKM")
    str = homework{Space}
Else if (key0 = "wism" or key0 = "wism;" or key0 = "WISM")
    str = swim{Space}
Else if (key0 = "woasl" or key0 = "woasl;" or key0 = "WOASL")
    str = swallow{Space}
Else if (key0 = "wolb" or key0 = "wolb;" or key0 = "WOLB")
    str = blow{Space}
Else if (key0 = "wra" or key0 = "wra;" or key0 = "WRA")
    str = war{Space}
Else if (key0 = "wrb" or key0 = "wrb;" or key0 = "WRB")
    str = borrow{Space}
Else if (key0 = "wrsm" or key0 = "wrsm;" or key0 = "WRSM")
    str = worrisome{Space}
Else if (key0 = "wrpf" or key0 = "wrpf;" or key0 = "WRPF")
    str = powerful{Space}
Else if (key0 = "wdv" or key0 = "wdv;" or key0 = "WDV")
    str = would've{Space}
Else if (key0 = "werohn" or key0 = "werohn;" or key0 = "WEROHN")
    str = nowhere{Space}
Else if (key0 = "werohv" or key0 = "werohv;" or key0 = "WEROHV")
    str = however{Space}
Else if (key0 = "wrth" or key0 = "wrth;" or key0 = "WRTH")
    str = worth{Space}
Else if (key0 = "weros" or key0 = "weros;" or key0 = "WEROS")
    str = worse{Space}
Else if (key0 = "wed" or key0 = "wed;" or key0 = "WED")
    str = we'd{Space}
Else if (key0 = "wein" or key0 = "wein;" or key0 = "WEIN")
    str = wine{Space}
Else if (key0 = "wetah" or key0 = "wetah;" or key0 = "WETAH")
    str = weather{Space}
Else if (key0 = "wetahl" or key0 = "wetahl;" or key0 = "WETAHL")
    str = wealth{Space}
Else if (key0 = "wofl" or key0 = "wofl;" or key0 = "WOFL")
    str = flow{Space}
Else if (key0 = "werop" or key0 = "werop;" or key0 = "WEROP")
    str = power{Space}
Else if (key0 = "wertn" or key0 = "wertn;" or key0 = "WERTN")
    str = weren't{Space}
Else if (key0 = "wrtn" or key0 = "wrtn;" or key0 = "WRTN")
    str = written{Space}
Else if (key0 = "wadn" or key0 = "wadn;" or key0 = "WADN")
    str = wand{Space}
Else if (key0 = "wdl" or key0 = "wdl;" or key0 = "WDL")
    str = wield{Space}
Else if (key0 = "weav" or key0 = "weav;" or key0 = "WEAV")
    str = wave{Space}
Else if (key0 = "welb" or key0 = "welb;" or key0 = "WELB")
    str = blew{Space}
Else if (key0 = "welb" or key0 = "welb;" or key0 = "WELB")
    str = blew{Space}
Else if (key0 = "weonm" or key0 = "weonm;" or key0 = "WEONM")
    str = women{Space}
Else if (key0 = "werto" or key0 = "werto;" or key0 = "WERTO")
    str = wrote{Space}
Else if (key0 = "werto" or key0 = "werto;" or key0 = "WERTO")
    str = wrote{Space}
Else if (key0 = "wlcm" or key0 = "wlcm;" or key0 = "WLCM")
    str = welcome{Space}
Else if (key0 = "wnm" or key0 = "wnm;" or key0 = "WNM")
    str = women{Space}
Else if (key0 = "wnm" or key0 = "wnm;" or key0 = "WNM")
    str = woman{Space}
Else if (key0 = "wosl" or key0 = "wosl;" or key0 = "WOSL")
    str = slow{Space}
Else if (key0 = "wrdh" or key0 = "wrdh;" or key0 = "WRDH")
    str = hardware{Space}
Else if (key0 = "wrtos" or key0 = "wrtos;" or key0 = "WRTOS")
    str = worst{Space}
Else if (key0 = "wryo" or key0 = "wryo;" or key0 = "WRYO")
    str = worry{Space}
Else if (key0 = "wagn" or key0 = "wagn;" or key0 = "WAGN")
    str = gnaw{Space}
Else if (key0 = "waln" or key0 = "waln;" or key0 = "WALN")
    str = lawn{Space}
Else if (key0 = "wan" or key0 = "wan;" or key0 = "WAN")
    str = awn{Space}
Else if (key0 = "waskl" or key0 = "waskl;" or key0 = "WASKL")
    str = walks{Space}
Else if (key0 = "wdln" or key0 = "wdln;" or key0 = "WDLN")
    str = download{Space}
Else if (key0 = "weahl" or key0 = "weahl;" or key0 = "WEAHL")
    str = whale{Space}
Else if (key0 = "wehl" or key0 = "wehl;" or key0 = "WEHL")
    str = wheel{Space}
Else if (key0 = "weif" or key0 = "weif;" or key0 = "WEIF")
    str = wife{Space}
Else if (key0 = "weigh" or key0 = "weigh;" or key0 = "WEIGH")
    str = weigh{Space}
Else if (key0 = "weis" or key0 = "weis;" or key0 = "WEIS")
    str = wise{Space}
Else if (key0 = "weosh" or key0 = "weosh;" or key0 = "WEOSH")
    str = whose{Space}
Else if (key0 = "weosh" or key0 = "weosh;" or key0 = "WEOSH")
    str = swore{Space}
Else if (key0 = "wertah" or key0 = "wertah;" or key0 = "WERTAH")
    str = weather{Space}
Else if (key0 = "wetigh" or key0 = "wetigh;" or key0 = "WETIGH")
    str = weight{Space}
Else if (key0 = "wets" or key0 = "wets;" or key0 = "WETS")
    str = west{Space}
Else if (key0 = "widl" or key0 = "widl;" or key0 = "WIDL")
    str = wild{Space}
Else if (key0 = "win" or key0 = "win;" or key0 = "WIN")
    str = win{Space}
Else if (key0 = "woc" or key0 = "woc;" or key0 = "WOC")
    str = cow{Space}
Else if (key0 = "wom" or key0 = "wom;" or key0 = "WOM")
    str = mow{Space}
Else if (key0 = "wrgln" or key0 = "wrgln;" or key0 = "WRGLN")
    str = wrangle{Space}
Else if (key0 = "wrhn" or key0 = "wrhn;" or key0 = "WRHN")
    str = nowhere{Space}
Else if (key0 = "wrlnm" or key0 = "wrlnm;" or key0 = "WRLNM")
    str = lawnmower{Space}
Else if (key0 = "wrs" or key0 = "wrs;" or key0 = "WRS")
    str = worse{Space}
Else if (key0 = "wrtos" or key0 = "wrtos;" or key0 = "WRTOS")
    str = worst{Space}
Else if (key0 = "wsdm" or key0 = "wsdm;" or key0 = "WSDM")
    str = wisdom{Space}
Else if (key0 = "wakl" or key0 = "wakl;" or key0 = "WAKL")
    str = walk{Space}
Else if (key0 = "wal" or key0 = "wal;" or key0 = "WAL")
    str = always{Space}
Else if (key0 = "was" or key0 = "was;" or key0 = "WAS")
    str = was{Space}
Else if (key0 = "was" or key0 = "was;" or key0 = "WAS")
    str = was{Space}
Else if (key0 = "wash" or key0 = "wash;" or key0 = "WASH")
    str = wash{Space}
Else if (key0 = "wdf" or key0 = "wdf;" or key0 = "WDF")
    str = forward{Space}
Else if (key0 = "wdn" or key0 = "wdn;" or key0 = "WDN")
    str = wouldn't{Space}
Else if (key0 = "we" or key0 = "we;" or key0 = "WE")
    str = we{Space}
Else if (key0 = "weak" or key0 = "weak;" or key0 = "WEAK")
    str = weak{Space}
Else if (key0 = "weasm" or key0 = "weasm;" or key0 = "WEASM")
    str = awesome{Space}
Else if (key0 = "wef" or key0 = "wef;" or key0 = "WEF")
    str = few{Space}
Else if (key0 = "weh" or key0 = "weh;" or key0 = "WEH")
    str = when{Space}
Else if (key0 = "wehn" or key0 = "wehn;" or key0 = "WEHN")
    str = when{Space}
Else if (key0 = "weid" or key0 = "weid;" or key0 = "WEID")
    str = wide{Space}
Else if (key0 = "weid" or key0 = "weid;" or key0 = "WEID")
    str = wide{Space}
Else if (key0 = "weihl" or key0 = "weihl;" or key0 = "WEIHL")
    str = while{Space}
Else if (key0 = "weis" or key0 = "weis;" or key0 = "WEIS")
    str = wise{Space}
Else if (key0 = "weisdh" or key0 = "weisdh;" or key0 = "WEISDH")
    str = wished{Space}
Else if (key0 = "weiv" or key0 = "weiv;" or key0 = "WEIV")
    str = view{Space}
Else if (key0 = "wek" or key0 = "wek;" or key0 = "WEK")
    str = week{Space}
Else if (key0 = "wekn" or key0 = "wekn;" or key0 = "WEKN")
    str = knew{Space}
Else if (key0 = "wel" or key0 = "wel;" or key0 = "WEL")
    str = well{Space}
Else if (key0 = "wen" or key0 = "wen;" or key0 = "WEN")
    str = new{Space}
Else if (key0 = "weohl" or key0 = "weohl;" or key0 = "WEOHL")
    str = whole{Space}
Else if (key0 = "wer" or key0 = "wer;" or key0 = "WER")
    str = were{Space}
Else if (key0 = "wera" or key0 = "wera;" or key0 = "WERA")
    str = wear{Space}
Else if (key0 = "werasn" or key0 = "werasn;" or key0 = "WERASN")
    str = answer{Space}
Else if (key0 = "werc" or key0 = "werc;" or key0 = "WERC")
    str = crew{Space}
Else if (key0 = "werh" or key0 = "werh;" or key0 = "WERH")
    str = where{Space}
Else if (key0 = "werid" or key0 = "werid;" or key0 = "WERID")
    str = weird{Space}
Else if (key0 = "weriv" or key0 = "weriv;" or key0 = "WERIV")
    str = review{Space}
Else if (key0 = "werosb" or key0 = "werosb;" or key0 = "WEROSB")
    str = browse{Space}
Else if (key0 = "werta" or key0 = "werta;" or key0 = "WERTA")
    str = water{Space}
Else if (key0 = "werth" or key0 = "werth;" or key0 = "WERTH")
    str = whether{Space}
Else if (key0 = "werti" or key0 = "werti;" or key0 = "WERTI")
    str = Twitter{Space}
Else if (key0 = "wetadn" or key0 = "wetadn;" or key0 = "WETADN")
    str = wanted{Space}
Else if (key0 = "wetbn" or key0 = "wetbn;" or key0 = "WETBN")
    str = between{Space}
Else if (key0 = "wetih" or key0 = "wetih;" or key0 = "WETIH")
    str = white{Space}
Else if (key0 = "wetn" or key0 = "wetn;" or key0 = "WETN")
    str = went{Space}
Else if (key0 = "wev" or key0 = "wev;" or key0 = "WEV")
    str = everywhere{Space}
Else if (key0 = "wfl" or key0 = "wfl;" or key0 = "WFL")
    str = follow{Space}
Else if (key0 = "wgk" or key0 = "wgk;" or key0 = "WGK")
    str = working{Space}
Else if (key0 = "wgkl" or key0 = "wgkl;" or key0 = "WGKL")
    str = walking{Space}
Else if (key0 = "wh" or key0 = "wh;" or key0 = "WH")
    str = who{Space}
Else if (key0 = "when" or key0 = "when;" or key0 = "WHEN")
    str = when{Space}
Else if (key0 = "whl" or key0 = "whl;" or key0 = "WHL")
    str = whole{Space}
Else if (key0 = "whn" or key0 = "whn;" or key0 = "WHN")
    str = when{Space}
Else if (key0 = "widn" or key0 = "widn;" or key0 = "WIDN")
    str = wind{Space}
Else if (key0 = "wihc" or key0 = "wihc;" or key0 = "WIHC")
    str = which{Space}
Else if (key0 = "wil" or key0 = "wil;" or key0 = "WIL")
    str = will{Space}
Else if (key0 = "wiodn" or key0 = "wiodn;" or key0 = "WIODN")
    str = window{Space}
Else if (key0 = "wish" or key0 = "wish;" or key0 = "WISH")
    str = wish{Space}
Else if (key0 = "wk" or key0 = "wk;" or key0 = "WK")
    str = work{Space}
Else if (key0 = "wkl" or key0 = "wkl;" or key0 = "WKL")
    str = walk{Space}
Else if (key0 = "wl" or key0 = "wl;" or key0 = "WL")
    str = we'll{Space}
Else if (key0 = "wn" or key0 = "wn;" or key0 = "WN")
    str = network{Space}
Else if (key0 = "wo" or key0 = "wo;" or key0 = "WO")
    str = would{Space}
Else if (key0 = "woal" or key0 = "woal;" or key0 = "WOAL")
    str = allow{Space}
Else if (key0 = "wod" or key0 = "wod;" or key0 = "WOD")
    str = wood{Space}
Else if (key0 = "wodn" or key0 = "wodn;" or key0 = "WODN")
    str = down{Space}
Else if (key0 = "woh" or key0 = "woh;" or key0 = "WOH")
    str = how{Space}
Else if (key0 = "wokn" or key0 = "wokn;" or key0 = "WOKN")
    str = know{Space}
Else if (key0 = "wol" or key0 = "wol;" or key0 = "WOL")
    str = low{Space}
Else if (key0 = "won" or key0 = "won;" or key0 = "WON")
    str = now{Space}
Else if (key0 = "wosh" or key0 = "wosh;" or key0 = "WOSH")
    str = show{Space}
Else if (key0 = "wosn" or key0 = "wosn;" or key0 = "WOSN")
    str = snow{Space}
Else if (key0 = "wpn" or key0 = "wpn;" or key0 = "WPN")
    str = newspaper{Space}
Else if (key0 = "wr" or key0 = "wr;" or key0 = "WR")
    str = we're{Space}
Else if (key0 = "wr" or key0 = "wr;" or key0 = "WR")
    str = we're{Space}
Else if (key0 = "wrad" or key0 = "wrad;" or key0 = "WRAD")
    str = draw{Space}
Else if (key0 = "wram" or key0 = "wram;" or key0 = "WRAM")
    str = warm{Space}
Else if (key0 = "wrdf" or key0 = "wrdf;" or key0 = "WRDF")
    str = wonderful{Space}
Else if (key0 = "wrdfn" or key0 = "wrdfn;" or key0 = "WRDFN")
    str = wonderful{Space}
Else if (key0 = "wrdn" or key0 = "wrdn;" or key0 = "WRDN")
    str = wonder{Space}
Else if (key0 = "wrk" or key0 = "wrk;" or key0 = "WRK")
    str = work{Space}
Else if (key0 = "wrod" or key0 = "wrod;" or key0 = "WROD")
    str = word{Space}
Else if (key0 = "wrodl" or key0 = "wrodl;" or key0 = "WRODL")
    str = world{Space}
Else if (key0 = "wrog" or key0 = "wrog;" or key0 = "WROG")
    str = grow{Space}
Else if (key0 = "wrogn" or key0 = "wrogn;" or key0 = "WROGN")
    str = wrong{Space}
Else if (key0 = "wrok" or key0 = "wrok;" or key0 = "WROK")
    str = work{Space}
Else if (key0 = "wrt" or key0 = "wrt;" or key0 = "WRT")
    str = write{Space}
Else if (key0 = "wrtg" or key0 = "wrtg;" or key0 = "WRTG")
    str = writing{Space}
Else if (key0 = "wrtm" or key0 = "wrtm;" or key0 = "WRTM")
    str = tomorrow{Space}
Else if (key0 = "wrtoh" or key0 = "wrtoh;" or key0 = "WRTOH")
    str = throw{Space}
Else if (key0 = "wrtv" or key0 = "wrtv;" or key0 = "WRTV")
    str = whatever{Space}
Else if (key0 = "wrv" or key0 = "wrv;" or key0 = "WRV")
    str = review{Space}
Else if (key0 = "ws" or key0 = "ws;" or key0 = "WS")
    str = website{Space}
Else if (key0 = "wsf" or key0 = "wsf;" or key0 = "WSF")
    str = software{Space}
Else if (key0 = "wsm" or key0 = "wsm;" or key0 = "WSM")
    str = somewhere{Space}
Else if (key0 = "wt" or key0 = "wt;" or key0 = "WT")
    str = what{Space}
Else if (key0 = "wtadn" or key0 = "wtadn;" or key0 = "WTADN")
    str = wanted{Space}
Else if (key0 = "wtadn" or key0 = "wtadn;" or key0 = "WTADN")
    str = wanted{Space}
Else if (key0 = "wtah" or key0 = "wtah;" or key0 = "WTAH")
    str = what{Space}
Else if (key0 = "wtahc" or key0 = "wtahc;" or key0 = "WTAHC")
    str = watch{Space}
Else if (key0 = "wtan" or key0 = "wtan;" or key0 = "WTAN")
    str = want{Space}
Else if (key0 = "wtasn" or key0 = "wtasn;" or key0 = "WTASN")
    str = wasn't{Space}
Else if (key0 = "wsn" or key0 = "wsn;" or key0 = "WSN")
    str = wasn't{Space}
Else if (key0 = "wtb" or key0 = "wtb;" or key0 = "WTB")
    str = by the way{Space}
Else if (key0 = "wtd" or key0 = "wtd;" or key0 = "WTD")
    str = toward{Space}
Else if (key0 = "wth" or key0 = "wth;" or key0 = "WTH")
    str = whether{Space}
Else if (key0 = "wthc" or key0 = "wthc;" or key0 = "WTHC")
    str = watch{Space}
Else if (key0 = "wti" or key0 = "wti;" or key0 = "WTI")
    str = within{Space}
Else if (key0 = "wtia" or key0 = "wtia;" or key0 = "WTIA")
    str = wait{Space}
Else if (key0 = "wtishc" or key0 = "wtishc;" or key0 = "WTISHC")
    str = switch{Space}
Else if (key0 = "wto" or key0 = "wto;" or key0 = "WTO")
    str = without{Space}
Else if (key0 = "wton" or key0 = "wton;" or key0 = "WTON")
    str = town{Space}
Else if (key0 = "wtuo" or key0 = "wtuo;" or key0 = "WTUO")
    str = without{Space}
Else if (key0 = "wtv" or key0 = "wtv;" or key0 = "WTV")
    str = whatever{Space}
Else if (key0 = "wtvn" or key0 = "wtvn;" or key0 = "WTVN")
    str = interview{Space}
Else if (key0 = "wv" or key0 = "wv;" or key0 = "WV")
    str = we've{Space}
Else if (key0 = "wv" or key0 = "wv;" or key0 = "WV")
    str = we've{Space}
Else if (key0 = "wya" or key0 = "wya;" or key0 = "WYA")
    str = way{Space}
Else if (key0 = "wyahn" or key0 = "wyahn;" or key0 = "WYAHN")
    str = anywhere{Space}
Else if (key0 = "wyan" or key0 = "wyan;" or key0 = "WYAN")
    str = anyway{Space}
Else if (key0 = "wyh" or key0 = "wyh;" or key0 = "WYH")
    str = why{Space}
Else if (key0 = "wyl" or key0 = "wyl;" or key0 = "WYL")
    str = yellow{Space}
Else if (key0 = "werg" or key0 = "werg;" or key0 = "WERG")
    str = grew{Space}
Else if (key0 = "wetic" or key0 = "wetic;" or key0 = "WETIC")
    str = twice{Space}
Else if (key0 = "wtash" or key0 = "wtash;" or key0 = "WTASH")
    str = what's{Space}
Else if (key0 = "wts" or key0 = "wts;" or key0 = "WTS")
    str = what's{Space}
Return

SENDR:
   SentTick = %A_TickCount%            
   SentKeys = %key0% 
if (key0 = "ra" or key0 = "ra;" or key0 = "RA")
    str = around{Space}
Else if (key0 = "ruioasv" or key0 = "ruioasv;" or key0 = "RUIOASV")
    str = saviour{Space}
Else if (key0 = "rtyph" or key0 = "rtyph;" or key0 = "RTYPH")
    str = therapy{Space}
Else if (key0 = "radgn" or key0 = "radgn;" or key0 = "RADGN")
    str = grand{Space}
Else if (key0 = "radk" or key0 = "radk;" or key0 = "RADK")
    str = dark{Space}
Else if (key0 = "radk" or key0 = "radk;" or key0 = "RADK")
    str = dark{Space}
Else if (key0 = "rahc" or key0 = "rahc;" or key0 = "RAHC")
    str = char{Space}
Else if (key0 = "rdv" or key0 = "rdv;" or key0 = "RDV")
    str = drive{Space}
Else if (key0 = "rfgn" or key0 = "rfgn;" or key0 = "RFGN")
    str = finger{Space}
Else if (key0 = "rglabn" or key0 = "rglabn;" or key0 = "RGLABN")
    str = aboriginal{Space}
Else if (key0 = "rgnm" or key0 = "rgnm;" or key0 = "RGNM")
    str = migraine{Space}
Else if (key0 = "riab" or key0 = "riab;" or key0 = "RIAB")
    str = rabbi{Space}
Else if (key0 = "riadf" or key0 = "riadf;" or key0 = "RIADF")
    str = afraid{Space}
Else if (key0 = "rialcnm" or key0 = "rialcnm;" or key0 = "RIALCNM")
    str = criminal{Space}
Else if (key0 = "rian" or key0 = "rian;" or key0 = "RIAN")
    str = rain{Space}
Else if (key0 = "rian" or key0 = "rian;" or key0 = "RIAN")
    str = rain{Space}
Else if (key0 = "ridg" or key0 = "ridg;" or key0 = "RIDG")
    str = grid{Space}
Else if (key0 = "rifac" or key0 = "rifac;" or key0 = "RIFAC")
    str = africa{Space}
Else if (key0 = "rio" or key0 = "rio;" or key0 = "RIO")
    str = {backspace}ior{Space}
Else if (key0 = "riofc" or key0 = "riofc;" or key0 = "RIOFC")
    str = friction{Space}
Else if (key0 = "riopsn" or key0 = "riopsn;" or key0 = "RIOPSN")
    str = prison{Space}
Else if (key0 = "riopsnm" or key0 = "riopsnm;" or key0 = "RIOPSNM")
    str = imprison{Space}
Else if (key0 = "ripg" or key0 = "ripg;" or key0 = "RIPG")
    str = grip{Space}
Else if (key0 = "ripsgn" or key0 = "ripsgn;" or key0 = "RIPSGN")
    str = spring{Space}
Else if (key0 = "ripsgn" or key0 = "ripsgn;" or key0 = "RIPSGN")
    str = spring{Space}
Else if (key0 = "rlcnm" or key0 = "rlcnm;" or key0 = "RLCNM")
    str = criminal{Space}
Else if (key0 = "rlvb" or key0 = "rlvb;" or key0 = "RLVB")
    str = variable{Space}
Else if (key0 = "rlvbn" or key0 = "rlvbn;" or key0 = "RLVBN")
    str = vulnerable{Space}
Else if (key0 = "roagn" or key0 = "roagn;" or key0 = "ROAGN")
    str = organ{Space}
Else if (key0 = "rodm" or key0 = "rodm;" or key0 = "RODM")
    str = dorm{Space}
Else if (key0 = "rofg" or key0 = "rofg;" or key0 = "ROFG")
    str = frog{Space}
Else if (key0 = "rofl" or key0 = "rofl;" or key0 = "ROFL")
    str = floor{Space}
Else if (key0 = "ropf" or key0 = "ropf;" or key0 = "ROPF")
    str = proof{Space}
Else if (key0 = "rpash" or key0 = "rpash;" or key0 = "RPASH")
    str = sharp{Space}
Else if (key0 = "rpsgn" or key0 = "rpsgn;" or key0 = "RPSGN")
    str = passenger{Space}
Else if (key0 = "rpz" or key0 = "rpz;" or key0 = "RPZ")
    str = prize{Space}
Else if (key0 = "rsdv" or key0 = "rsdv;" or key0 = "RSDV")
    str = diverse{Space}
Else if (key0 = "rtg" or key0 = "rtg;" or key0 = "RTG")
    str = trying{Space}
Else if (key0 = "rtgcn" or key0 = "rtgcn;" or key0 = "RTGCN")
    str = congregate{Space}
Else if (key0 = "rtgl" or key0 = "rtgl;" or key0 = "RTGL")
    str = regulate{Space}
Else if (key0 = "rthlzn" or key0 = "rthlzn;" or key0 = "RTHLZN")
    str = horizontal{Space}
Else if (key0 = "rtid" or key0 = "rtid;" or key0 = "RTID")
    str = dirt{Space}
Else if (key0 = "rtid" or key0 = "rtid;" or key0 = "RTID")
    str = dirt{Space}
Else if (key0 = "rtiob" or key0 = "rtiob;" or key0 = "RTIOB")
    str = orbit{Space}
Else if (key0 = "rtiofcn" or key0 = "rtiofcn;" or key0 = "RTIOFCN")
    str = friction{Space}
Else if (key0 = "rtiopm" or key0 = "rtiopm;" or key0 = "RTIOPM")
    str = import{Space}
Else if (key0 = "rtiopm" or key0 = "rtiopm;" or key0 = "RTIOPM")
    str = import{Space}
Else if (key0 = "rtipascn" or key0 = "rtipascn;" or key0 = "RTIPASCN")
    str = transcript{Space}
Else if (key0 = "rtips" or key0 = "rtips;" or key0 = "RTIPS")
    str = strip{Space}
Else if (key0 = "rtlcv" or key0 = "rtlcv;" or key0 = "RTLCV")
    str = vertical{Space}
Else if (key0 = "rtopal" or key0 = "rtopal;" or key0 = "RTOPAL")
    str = portal{Space}
Else if (key0 = "rtopas" or key0 = "rtopas;" or key0 = "RTOPAS")
    str = pastor{Space}
Else if (key0 = "rtpcn" or key0 = "rtpcn;" or key0 = "RTPCN")
    str = counterpart{Space}
Else if (key0 = "rtphcnm" or key0 = "rtphcnm;" or key0 = "RTPHCNM")
    str = anthropomorphic{Space}
Else if (key0 = "rtsc" or key0 = "rtsc;" or key0 = "RTSC")
    str = structure{Space}
Else if (key0 = "rtsc" or key0 = "rtsc;" or key0 = "RTSC")
    str = secret{Space}
Else if (key0 = "rtscb" or key0 = "rtscb;" or key0 = "RTSCB")
    str = subtract{Space}
Else if (key0 = "rtscn" or key0 = "rtscn;" or key0 = "RTSCN")
    str = countries{Space}
Else if (key0 = "rtsda" or key0 = "rtsda;" or key0 = "RTSDA")
    str = asteroid{Space}
Else if (key0 = "rtshc" or key0 = "rtshc;" or key0 = "RTSHC")
    str = stretch{Space}
Else if (key0 = "rtuoc" or key0 = "rtuoc;" or key0 = "RTUOC")
    str = court{Space}
Else if (key0 = "rtyid" or key0 = "rtyid;" or key0 = "RTYID")
    str = dirty{Space}
Else if (key0 = "rtyid" or key0 = "rtyid;" or key0 = "RTYID")
    str = dirty{Space}
Else if (key0 = "rtyplxn" or key0 = "rtyplxn;" or key0 = "RTYPLXN")
    str = explanatory{Space}
Else if (key0 = "rual" or key0 = "rual;" or key0 = "RUAL")
    str = rural{Space}
Else if (key0 = "ruhc" or key0 = "ruhc;" or key0 = "RUHC")
    str = church{Space}
Else if (key0 = "ryiaf" or key0 = "ryiaf;" or key0 = "RYIAF")
    str = fairy{Space}
Else if (key0 = "ryoacnm" or key0 = "ryoacnm;" or key0 = "RYOACNM")
    str = acronym{Space}
Else if (key0 = "rysdnm" or key0 = "rysdnm;" or key0 = "RYSDNM")
    str = syndrome{Space}
Else if (key0 = "ryub" or key0 = "ryub;" or key0 = "RYUB")
    str = bury{Space}
Else if (key0 = "ryuijn" or key0 = "ryuijn;" or key0 = "RYUIJN")
    str = injury{Space}
Else if (key0 = "rtdlnm" or key0 = "rtdlnm;" or key0 = "RTDLNM")
    str = detrimental{Space}
Else if (key0 = "rtdln" or key0 = "rtdln;" or key0 = "RTDLN")
    str = traditional{Space}
Else if (key0 = "ryc" or key0 = "ryc;" or key0 = "RYC")
    str = cry{Space}
Else if (key0 = "rtpsdn" or key0 = "rtpsdn;" or key0 = "RTPSDN")
    str = president{Space}
Else if (key0 = "rtuiag" or key0 = "rtuiag;" or key0 = "RTUIAG")
    str = guitar{Space}
Else if (key0 = "rtip" or key0 = "rtip;" or key0 = "RTIP")
    str = trip{Space}
Else if (key0 = "ruosh" or key0 = "ruosh;" or key0 = "RUOSH")
    str = hours{Space}
Else if (key0 = "ridkn" or key0 = "ridkn;" or key0 = "RIDKN")
    str = drink{Space}
Else if (key0 = "riafc" or key0 = "riafc;" or key0 = "RIAFC")
    str = Africa{Space}
Else if (key0 = "rtiac" or key0 = "rtiac;" or key0 = "RTIAC")
    str = arctic{Space}
Else if (key0 = "rtiacn" or key0 = "rtiacn;" or key0 = "RTIACN")
    str = Antarctica{Space}
Else if (key0 = "wrb" or key0 = "wrb;" or key0 = "WRB")
    str = borrow{Space}
Else if (key0 = "rhlb" or key0 = "rhlb;" or key0 = "RHLB")
    str = horrible{Space}
Else if (key0 = "rp" or key0 = "rp;" or key0 = "RP")
    str = peer{Space}
Else if (key0 = "rahcm" or key0 = "rahcm;" or key0 = "RAHCM")
    str = march{Space}
Else if (key0 = "rdv" or key0 = "rdv;" or key0 = "RDV")
    str = drive{Space}
Else if (key0 = "rdbn" or key0 = "rdbn;" or key0 = "RDBN")
    str = burden{Space}
Else if (key0 = "rdgn" or key0 = "rdgn;" or key0 = "RDGN")
    str = garden{Space}
Else if (key0 = "rfcn" or key0 = "rfcn;" or key0 = "RFCN")
    str = conference{Space}
Else if (key0 = "rfnm" or key0 = "rfnm;" or key0 = "RFNM")
    str = inform{Space}
Else if (key0 = "riagc" or key0 = "riagc;" or key0 = "RIAGC")
    str = cigar{Space}
Else if (key0 = "rid" or key0 = "rid;" or key0 = "RID")
    str = rid{Space}
Else if (key0 = "ridb" or key0 = "ridb;" or key0 = "RIDB")
    str = bird{Space}
Else if (key0 = "riofnm" or key0 = "riofnm;" or key0 = "RIOFNM")
    str = inform{Space}
Else if (key0 = "riom" or key0 = "riom;" or key0 = "RIOM")
    str = mirror{Space}
Else if (key0 = "rionm" or key0 = "rionm;" or key0 = "RIONM")
    str = minor{Space}
Else if (key0 = "ripal" or key0 = "ripal;" or key0 = "RIPAL")
    str = April{Space}
Else if (key0 = "risc" or key0 = "risc;" or key0 = "RISC")
    str = crisis{Space}
Else if (key0 = "riscn" or key0 = "riscn;" or key0 = "RISCN")
    str = insurance{Space}
Else if (key0 = "rlcm" or key0 = "rlcm;" or key0 = "RLCM")
    str = commercial{Space}
Else if (key0 = "roajm" or key0 = "roajm;" or key0 = "ROAJM")
    str = major{Space}
Else if (key0 = "rodn" or key0 = "rodn;" or key0 = "RODN")
    str = donor{Space}
Else if (key0 = "rolc" or key0 = "rolc;" or key0 = "ROLC")
    str = color{Space}
Else if (key0 = "roogm" or key0 = "roogm;" or key0 = "ROOGM")
    str = groom{Space}
Else if (key0 = "rpcn" or key0 = "rpcn;" or key0 = "RPCN")
    str = pronounce{Space}
Else if (key0 = "rpscb" or key0 = "rpscb;" or key0 = "RPSCB")
    str = prescribe{Space}
Else if (key0 = "rpscm" or key0 = "rpscm;" or key0 = "RPSCM")
    str = compromise{Space}
Else if (key0 = "rsc" or key0 = "rsc;" or key0 = "RSC")
    str = source{Space}
Else if (key0 = "rsjln" or key0 = "rsjln;" or key0 = "RSJLN")
    str = journalist{Space}
Else if (key0 = "rtashc" or key0 = "rtashc;" or key0 = "RTASHC")
    str = scratch{Space}
Else if (key0 = "rtav" or key0 = "rtav;" or key0 = "RTAV")
    str = avatar{Space}
Else if (key0 = "rtfgl" or key0 = "rtfgl;" or key0 = "RTFGL")
    str = grateful{Space}
Else if (key0 = "rtgn" or key0 = "rtgn;" or key0 = "RTGN")
    str = generate{Space}
Else if (key0 = "rtifcn" or key0 = "rtifcn;" or key0 = "RTIFCN")
    str = interface{Space}
Else if (key0 = "rtioavn" or key0 = "rtioavn;" or key0 = "RTIOAVN")
    str = innovator{Space}
Else if (key0 = "rtioscn" or key0 = "rtioscn;" or key0 = "RTIOSCN")
    str = constrict{Space}
Else if (key0 = "rtish" or key0 = "rtish;" or key0 = "RTISH")
    str = shirt{Space}
Else if (key0 = "rtodc" or key0 = "rtodc;" or key0 = "RTODC")
    str = doctor{Space}
Else if (key0 = "rtofh" or key0 = "rtofh;" or key0 = "RTOFH")
    str = forth{Space}
Else if (key0 = "rtpnm" or key0 = "rtpnm;" or key0 = "RTPNM")
    str = prominent{Space}
Else if (key0 = "rtpscn" or key0 = "rtpscn;" or key0 = "RTPSCN")
    str = transcript{Space}
Else if (key0 = "rtpsn" or key0 = "rtpsn;" or key0 = "RTPSN")
    str = proposition{Space}
Else if (key0 = "rtsdm" or key0 = "rtsdm;" or key0 = "RTSDM")
    str = mustard{Space}
Else if (key0 = "rtshlc" or key0 = "rtshlc;" or key0 = "RTSHLC")
    str = historical{Space}
Else if (key0 = "rtsjln" or key0 = "rtsjln;" or key0 = "RTSJLN")
    str = journalist{Space}
Else if (key0 = "rtuinm" or key0 = "rtuinm;" or key0 = "RTUINM")
    str = monitor{Space}
Else if (key0 = "rtukc" or key0 = "rtukc;" or key0 = "RTUKC")
    str = truck{Space}
Else if (key0 = "rtuoscn" or key0 = "rtuoscn;" or key0 = "RTUOSCN")
    str = construct{Space}
Else if (key0 = "rtupab" or key0 = "rtupab;" or key0 = "RTUPAB")
    str = abrupt{Space}
Else if (key0 = "rtuskc" or key0 = "rtuskc;" or key0 = "RTUSKC")
    str = struck{Space}
Else if (key0 = "rtyivn" or key0 = "rtyivn;" or key0 = "RTYIVN")
    str = inventory{Space}
Else if (key0 = "rtyoph" or key0 = "rtyoph;" or key0 = "RTYOPH")
    str = trophy{Space}
Else if (key0 = "rtyshlc" or key0 = "rtyshlc;" or key0 = "RTYSHLC")
    str = hysterical{Space}
Else if (key0 = "ruasg" or key0 = "ruasg;" or key0 = "RUASG")
    str = sugar{Space}
Else if (key0 = "ruogh" or key0 = "ruogh;" or key0 = "RUOGH")
    str = rough{Space}
Else if (key0 = "rydlv" or key0 = "rydlv;" or key0 = "RYDLV")
    str = delivery{Space}
Else if (key0 = "ryfb" or key0 = "ryfb;" or key0 = "RYFB")
    str = February{Space}
Else if (key0 = "ryjn" or key0 = "ryjn;" or key0 = "RYJN")
    str = January{Space}
Else if (key0 = "rysdcv" or key0 = "rysdcv;" or key0 = "RYSDCV")
    str = discovery{Space}
Else if (key0 = "rysg" or key0 = "rysg;" or key0 = "RYSG")
    str = surgery{Space}
Else if (key0 = "ryuasm" or key0 = "ryuasm;" or key0 = "RYUASM")
    str = summary{Space}
Else if (key0 = "rus" or key0 = "rus;" or key0 = "RUS")
    str = yours{Space}
Else if (key0 = "rtialc" or key0 = "rtialc;" or key0 = "RTIALC")
    str = critical{Space}
Else if (key0 = "ropasl" or key0 = "ropasl;" or key0 = "ROPASL")
    str = proposal{Space}
Else if (key0 = "rshc" or key0 = "rshc;" or key0 = "RSHC")
    str = proposal{Space}
Else if (key0 = "rsc" or key0 = "rsc;" or key0 = "RSC")
    str = source{Space}
Else if (key0 = "ryagn" or key0 = "ryagn;" or key0 = "RYAGN")
    str = angry{Space}
Else if (key0 = "rign" or key0 = "rign;" or key0 = "RIGN")
    str = ignore{Space}
Else if (key0 = "rtsglcn" or key0 = "rtsglcn;" or key0 = "RTSGLCN")
    str = congratulations{Space}
Else if (key0 = "rfv" or key0 = "rfv;" or key0 = "RFV")
    str = forever{Space}
Else if (key0 = "rtpcm" or key0 = "rtpcm;" or key0 = "RTPCM")
    str = competitor{Space}
Else if (key0 = "rl" or key0 = "rl;" or key0 = "RL")
    str = real{Space}
Else if (key0 = "rtiln" or key0 = "rtiln;" or key0 = "RTILN")
    str = internal{Space}
Else if (key0 = "rtualn" or key0 = "rtualn;" or key0 = "RTUALN")
    str = natural{Space}
Else if (key0 = "rthb" or key0 = "rthb;" or key0 = "RTHB")
    str = breath{Space}
Else if (key0 = "rtlcn" or key0 = "rtlcn;" or key0 = "RTLCN")
    str = control{Space}
Else if (key0 = "rdh" or key0 = "rdh;" or key0 = "RDH")
    str = heard{Space}
Else if (key0 = "rlcm" or key0 = "rlcm;" or key0 = "RLCM")
    str = molecular{Space}
Else if (key0 = "ryd" or key0 = "ryd;" or key0 = "RYD")
    str = ready{Space}
Else if (key0 = "roahcb" or key0 = "roahcb;" or key0 = "ROAHCB")
    str = broach{Space}
Else if (key0 = "riav" or key0 = "riav;" or key0 = "RIAV")
    str = vari{Space}
Else if (key0 = "rpsd" or key0 = "rpsd;" or key0 = "RPSD")
    str = spread{Space}
Else if (key0 = "rpshc" or key0 = "rpshc;" or key0 = "RPSHC")
    str = purchase{Space}
Else if (key0 = "rtaghlm" or key0 = "rtaghlm;" or key0 = "RTAGHLM")
    str = algorithm{Space}
Else if (key0 = "rodhc" or key0 = "rodhc;" or key0 = "RODHC")
    str = chord{Space}
Else if (key0 = "rtagnm" or key0 = "rtagnm;" or key0 = "RTAGNM")
    str = argument{Space}
Else if (key0 = "rtfh" or key0 = "rtfh;" or key0 = "RTFH")
    str = further{Space}
Else if (key0 = "rtisdc" or key0 = "rtisdc;" or key0 = "RTISDC")
    str = district{Space}
Else if (key0 = "rtpdxn" or key0 = "rtpdxn;" or key0 = "RTPDXN")
    str = expenditure{Space}
Else if (key0 = "rafm" or key0 = "rafm;" or key0 = "RAFM")
    str = farm{Space}
Else if (key0 = "rag" or key0 = "rag;" or key0 = "RAG")
    str = argue{Space}
Else if (key0 = "rakc" or key0 = "rakc;" or key0 = "RAKC")
    str = crack{Space}
Else if (key0 = "ram" or key0 = "ram;" or key0 = "RAM")
    str = arm{Space}
Else if (key0 = "rtlvn" or key0 = "rtlvn;" or key0 = "RTLVN")
    str = relevant{Space}
Else if (key0 = "ram" or key0 = "ram;" or key0 = "RAM")
    str = arm{Space}
Else if (key0 = "rdfcn" or key0 = "rdfcn;" or key0 = "RDFCN")
    str = difference{Space}
Else if (key0 = "rdfl" or key0 = "rdfl;" or key0 = "RDFL")
    str = federal{Space}
Else if (key0 = "rfb" or key0 = "rfb;" or key0 = "RFB")
    str = brief{Space}
Else if (key0 = "rfcnm" or key0 = "rfcnm;" or key0 = "RFCNM")
    str = confirm{Space}
Else if (key0 = "rfgn" or key0 = "rfgn;" or key0 = "RFGN")
    str = finger{Space}
Else if (key0 = "rghc" or key0 = "rghc;" or key0 = "RGHC")
    str = charge{Space}
Else if (key0 = "rgln" or key0 = "rgln;" or key0 = "RGLN")
    str = general{Space}
Else if (key0 = "rglv" or key0 = "rglv;" or key0 = "RGLV")
    str = leverage{Space}
Else if (key0 = "rhlcn" or key0 = "rhlcn;" or key0 = "RHLCN")
    str = chronicle{Space}
Else if (key0 = "ria" or key0 = "ria;" or key0 = "RIA")
    str = air{Space}
Else if (key0 = "riabn" or key0 = "riabn;" or key0 = "RIABN")
    str = brain{Space}
Else if (key0 = "ricb" or key0 = "ricb;" or key0 = "RICB")
    str = crib{Space}
Else if (key0 = "rid" or key0 = "rid;" or key0 = "RID")
    str = rid{Space}
Else if (key0 = "rif" or key0 = "rif;" or key0 = "RIF")
    str = riff{Space}
Else if (key0 = "ripaghc" or key0 = "ripaghc;" or key0 = "RIPAGHC")
    str = graphic{Space}
Else if (key0 = "ripalcn" or key0 = "ripalcn;" or key0 = "RIPALCN")
    str = principal{Space}
Else if (key0 = "ripsvm" or key0 = "ripsvm;" or key0 = "RIPSVM")
    str = improvise{Space}
Else if (key0 = "risk" or key0 = "risk;" or key0 = "RISK")
    str = risk{Space}
Else if (key0 = "rjn" or key0 = "rjn;" or key0 = "RJN")
    str = junior{Space}
Else if (key0 = "rkm" or key0 = "rkm;" or key0 = "RKM")
    str = maker{Space}
Else if (key0 = "rlc" or key0 = "rlc;" or key0 = "RLC")
    str = clear{Space}
Else if (key0 = "rlcm" or key0 = "rlcm;" or key0 = "RLCM")
    str = curriculum{Space}
Else if (key0 = "rlcm" or key0 = "rlcm;" or key0 = "RLCM")
    str = miracle{Space}
Else if (key0 = "roasb" or key0 = "roasb;" or key0 = "ROASB")
    str = absorb{Space}
Else if (key0 = "rosvb" or key0 = "rosvb;" or key0 = "ROSVB")
    str = observe{Space}
Else if (key0 = "rpagh" or key0 = "rpagh;" or key0 = "RPAGH")
    str = graph{Space}
Else if (key0 = "rpaghc" or key0 = "rpaghc;" or key0 = "RPAGHC")
    str = graphic{Space}
Else if (key0 = "rpg" or key0 = "rpg;" or key0 = "RPG")
    str = group{Space}
Else if (key0 = "rplcn" or key0 = "rplcn;" or key0 = "RPLCN")
    str = principle{Space}
Else if (key0 = "rpscnm" or key0 = "rpscnm;" or key0 = "RPSCNM")
    str = comparison{Space}
Else if (key0 = "rpshm" or key0 = "rpshm;" or key0 = "RPSHM")
    str = sophomore{Space}
Else if (key0 = "rpsl" or key0 = "rpsl;" or key0 = "RPSL")
    str = pleasure{Space}
Else if (key0 = "rpsln" or key0 = "rpsln;" or key0 = "RPSLN")
    str = personal{Space}
Else if (key0 = "rsfc" or key0 = "rsfc;" or key0 = "RSFC")
    str = surface{Space}
Else if (key0 = "rsfhnm" or key0 = "rsfhnm;" or key0 = "RSFHNM")
    str = freshman{Space}
Else if (key0 = "rsflc" or key0 = "rsflc;" or key0 = "RSFLC")
    str = salesforce{Space}
Else if (key0 = "rsgln" or key0 = "rsgln;" or key0 = "RSGLN")
    str = singular{Space}
Else if (key0 = "rsgln" or key0 = "rsgln;" or key0 = "RSGLN")
    str = singular{Space}
Else if (key0 = "rslcn" or key0 = "rslcn;" or key0 = "RSLCN")
    str = counselor{Space}
Else if (key0 = "rsxc" or key0 = "rsxc;" or key0 = "RSXC")
    str = exercise{Space}
Else if (key0 = "rtagn" or key0 = "rtagn;" or key0 = "RTAGN")
    str = grant{Space}
Else if (key0 = "rtasm" or key0 = "rtasm;" or key0 = "RTASM")
    str = smart{Space}
Else if (key0 = "rtfc" or key0 = "rtfc;" or key0 = "RTFC")
    str = factor{Space}
Else if (key0 = "rtfgn" or key0 = "rtfgn;" or key0 = "RTFGN")
    str = forgotten{Space}
Else if (key0 = "rthn" or key0 = "rthn;" or key0 = "RTHN")
    str = neither{Space}
Else if (key0 = "rtidh" or key0 = "rtidh;" or key0 = "RTIDH")
    str = third{Space}
Else if (key0 = "rtioshc" or key0 = "rtioshc;" or key0 = "RTIOSHC")
    str = historic{Space}
Else if (key0 = "rtisgn" or key0 = "rtisgn;" or key0 = "RTISGN")
    str = string{Space}
Else if (key0 = "rtkm" or key0 = "rtkm;" or key0 = "RTKM")
    str = market{Space}
Else if (key0 = "rtoafc" or key0 = "rtoafc;" or key0 = "RTOAFC")
    str = factor{Space}
Else if (key0 = "rtofg" or key0 = "rtofg;" or key0 = "RTOFG")
    str = forgot{Space}
Else if (key0 = "rtohn" or key0 = "rtohn;" or key0 = "RTOHN")
    str = north{Space}
Else if (key0 = "rtopa" or key0 = "rtopa;" or key0 = "RTOPA")
    str = parrot{Space}
Else if (key0 = "rtopa" or key0 = "rtopa;" or key0 = "RTOPA")
    str = transport{Space}
Else if (key0 = "rtplc" or key0 = "rtplc;" or key0 = "RTPLC")
    str = particular{Space}
Else if (key0 = "rtpslc" or key0 = "rtpslc;" or key0 = "RTPSLC")
    str = spectacular{Space}
Else if (key0 = "rtpslc" or key0 = "rtpslc;" or key0 = "RTPSLC")
    str = transport{Space}
Else if (key0 = "rtpsn." or key0 = "rtpsn.;" or key0 = "RTPSN.")
    str = transportation{Space}
Else if (key0 = "rtpvm" or key0 = "rtpvm;" or key0 = "RTPVM")
    str = primitive{Space}
Else if (key0 = "rtpvn" or key0 = "rtpvn;" or key0 = "RTPVN")
    str = prevent{Space}
Else if (key0 = "rtpxnm" or key0 = "rtpxnm;" or key0 = "RTPXNM")
    str = experiment{Space}
Else if (key0 = "rtscn" or key0 = "rtscn;" or key0 = "RTSCN")
    str = countries{Space}
Else if (key0 = "rtsdb" or key0 = "rtsdb;" or key0 = "RTSDB")
    str = disturb{Space}
Else if (key0 = "rtsfn" or key0 = "rtsfn;" or key0 = "RTSFN")
    str = transfer{Space}
Else if (key0 = "rtshc" or key0 = "rtshc;" or key0 = "RTSHC")
    str = historic{Space}
Else if (key0 = "rtuam" or key0 = "rtuam;" or key0 = "RTUAM")
    str = trauma{Space}
Else if (key0 = "rtuo" or key0 = "rtuo;" or key0 = "RTUO")
    str = tour{Space}
Else if (key0 = "rtuoah" or key0 = "rtuoah;" or key0 = "RTUOAH")
    str = author{Space}
Else if (key0 = "rtyan" or key0 = "rtyan;" or key0 = "RTYAN")
    str = attorney{Space}
Else if (key0 = "rtyp" or key0 = "rtyp;" or key0 = "RTYP")
    str = property{Space}
Else if (key0 = "rtyp" or key0 = "rtyp;" or key0 = "RTYP")
    str = property{Space}
Else if (key0 = "ruadg" or key0 = "ruadg;" or key0 = "RUADG")
    str = guard{Space}
Else if (key0 = "rubn" or key0 = "rubn;" or key0 = "RUBN")
    str = burn{Space}
Else if (key0 = "ruodn" or key0 = "ruodn;" or key0 = "RUODN")
    str = round{Space}
Else if (key0 = "ruos" or key0 = "ruos;" or key0 = "RUOS")
    str = ours{Space}
Else if (key0 = "rush" or key0 = "rush;" or key0 = "RUSH")
    str = rush{Space}
Else if (key0 = "ryanm" or key0 = "ryanm;" or key0 = "RYANM")
    str = anymore{Space}
Else if (key0 = "ryanm" or key0 = "ryanm;" or key0 = "RYANM")
    str = anymore{Space}
Else if (key0 = "ryjn" or key0 = "ryjn;" or key0 = "RYJN")
    str = journey{Space}
Else if (key0 = "rypas" or key0 = "rypas;" or key0 = "RYPAS")
    str = spray{Space}
Else if (key0 = "rtphc" or key0 = "rtphc;" or key0 = "RTPHC")
    str = chapter{Space}
Else if (key0 = "rtsdc" or key0 = "rtsdc;" or key0 = "RTSDC")
    str = district{Space}
Else if (key0 = "rtygc" or key0 = "rtygc;" or key0 = "RTYGC")
    str = category{Space}
Else if (key0 = "radc" or key0 = "radc;" or key0 = "RADC")
    str = card{Space}
Else if (key0 = "rof" or key0 = "rof;" or key0 = "ROF")
    str = for{Space}
Else if (key0 = "ryad" or key0 = "ryad;" or key0 = "RYAD")
    str = yard{Space}
Else if (key0 = "radg" or key0 = "radg;" or key0 = "RADG")
    str = grad{Space}
Else if (key0 = "radh" or key0 = "radh;" or key0 = "RADH")
    str = hard{Space}
Else if (key0 = "rakm" or key0 = "rakm;" or key0 = "RAKM")
    str = mark{Space}
Else if (key0 = "rasdv" or key0 = "rasdv;" or key0 = "RASDV")
    str = advisor{Space}
Else if (key0 = "rdcnm" or key0 = "rdcnm;" or key0 = "RDCNM")
    str = recommend{Space}
Else if (key0 = "rdgn" or key0 = "rdgn;" or key0 = "RDGN")
    str = gender{Space}
Else if (key0 = "rdhn" or key0 = "rdhn;" or key0 = "RDHN")
    str = hundred{Space}
Else if (key0 = "rdlv" or key0 = "rdlv;" or key0 = "RDLV")
    str = deliver{Space}
Else if (key0 = "rdm" or key0 = "rdm;" or key0 = "RDM")
    str = dream{Space}
Else if (key0 = "rdn" or key0 = "rdn;" or key0 = "RDN")
    str = round{Space}
Else if (key0 = "rdnm" or key0 = "rdnm;" or key0 = "RDNM")
    str = random{Space}
Else if (key0 = "rdvn" or key0 = "rdvn;" or key0 = "RDVN")
    str = vendor{Space}
Else if (key0 = "rfc" or key0 = "rfc;" or key0 = "RFC")
    str = force{Space}
Else if (key0 = "rfc" or key0 = "rfc;" or key0 = "RFC")
    str = force{Space}
Else if (key0 = "rfcn" or key0 = "rfcn;" or key0 = "RFCN")
    str = reference{Space}
Else if (key0 = "rfcn" or key0 = "rfcn;" or key0 = "RFCN")
    str = conference{Space}
Else if (key0 = "rflv" or key0 = "rflv;" or key0 = "RFLV")
    str = flavor{Space}
Else if (key0 = "rfm" or key0 = "rfm;" or key0 = "RFM")
    str = firm{Space}
Else if (key0 = "rg" or key0 = "rg;" or key0 = "RG")
    str = gear{Space}
Else if (key0 = "rgcn" or key0 = "rgcn;" or key0 = "RGCN")
    str = encourage{Space}
Else if (key0 = "rgl" or key0 = "rgl;" or key0 = "RGL")
    str = regular{Space}
Else if (key0 = "rglv" or key0 = "rglv;" or key0 = "RGLV")
    str = leverage{Space}
Else if (key0 = "rhcbm" or key0 = "rhcbm;" or key0 = "RHCBM")
    str = chamber{Space}
Else if (key0 = "rhvb" or key0 = "rhvb;" or key0 = "RHVB")
    str = behavior{Space}
Else if (key0 = "riadn" or key0 = "riadn;" or key0 = "RIADN")
    str = drain{Space}
Else if (key0 = "riah" or key0 = "riah;" or key0 = "RIAH")
    str = hair{Space}
Else if (key0 = "rifm" or key0 = "rifm;" or key0 = "RIFM")
    str = firm{Space}
Else if (key0 = "riscn" or key0 = "riscn;" or key0 = "RISCN")
    str = increase{Space}
Else if (key0 = "rlb" or key0 = "rlb;" or key0 = "RLB")
    str = reliable{Space}
Else if (key0 = "rlcm" or key0 = "rlcm;" or key0 = "RLCM")
    str = commercial{Space}
Else if (key0 = "rlv" or key0 = "rlv;" or key0 = "RLV")
    str = lever{Space}
Else if (key0 = "roalb" or key0 = "roalb;" or key0 = "ROALB")
    str = labor{Space}
Else if (key0 = "rod" or key0 = "rod;" or key0 = "ROD")
    str = door{Space}
Else if (key0 = "rogcn" or key0 = "rogcn;" or key0 = "ROGCN")
    str = organic{Space}
Else if (key0 = "rohn" or key0 = "rohn;" or key0 = "ROHN")
    str = honor{Space}
Else if (key0 = "rokc" or key0 = "rokc;" or key0 = "ROKC")
    str = rock{Space}
Else if (key0 = "rolc" or key0 = "rolc;" or key0 = "ROLC")
    str = color{Space}
Else if (key0 = "rpd" or key0 = "rpd;" or key0 = "RPD")
    str = drop{Space}
Else if (key0 = "rpav" or key0 = "rpav;" or key0 = "RPAV")
    str = approve{Space}
Else if (key0 = "rpcv" or key0 = "rpcv;" or key0 = "RPCV")
    str = perceive{Space}
Else if (key0 = "rpdn" or key0 = "rpdn;" or key0 = "RPDN")
    str = pardon{Space}
Else if (key0 = "rpghc" or key0 = "rpghc;" or key0 = "RPGHC")
    str = graphic{Space}
Else if (key0 = "rpl" or key0 = "rpl;" or key0 = "RPL")
    str = popular{Space}
Else if (key0 = "rpsc" or key0 = "rpsc;" or key0 = "RPSC")
    str = precise{Space}
Else if (key0 = "rpscn" or key0 = "rpscn;" or key0 = "RPSCN")
    str = presence{Space}
Else if (key0 = "rpsf" or key0 = "rpsf;" or key0 = "RPSF")
    str = profess{Space}
Else if (key0 = "rpsg" or key0 = "rpsg;" or key0 = "RPSG")
    str = progress{Space}
Else if (key0 = "rscn" or key0 = "rscn;" or key0 = "RSCN")
    str = increase{Space}
Else if (key0 = "rscnm" or key0 = "rscnm;" or key0 = "RSCNM")
    str = consumer{Space}
Else if (key0 = "rsd" or key0 = "rsd;" or key0 = "RSD")
    str = desire{Space}
Else if (key0 = "rsdc" or key0 = "rsdc;" or key0 = "RSDC")
    str = decrease{Space}
Else if (key0 = "rsdlc" or key0 = "rsdlc;" or key0 = "RSDLC")
    str = ridiculous{Space}
Else if (key0 = "rsdn" or key0 = "rsdn;" or key0 = "RSDN")
    str = surround{Space}
Else if (key0 = "rsdv" or key0 = "rsdv;" or key0 = "RSDV")
    str = deserve{Space}
Else if (key0 = "rsv" or key0 = "rsv;" or key0 = "RSV")
    str = various{Space}
Else if (key0 = "rsxc" or key0 = "rsxc;" or key0 = "RSXC")
    str = exercise{Space}
Else if (key0 = "rsxc" or key0 = "rsxc;" or key0 = "RSXC")
    str = exercise{Space}
Else if (key0 = "rtab" or key0 = "rtab;" or key0 = "RTAB")
    str = attribute{Space}
Else if (key0 = "rtalc" or key0 = "rtalc;" or key0 = "RTALC")
    str = article{Space}
Else if (key0 = "rtcbn" or key0 = "rtcbn;" or key0 = "RTCBN")
    str = contribute{Space}
Else if (key0 = "rtdcn" or key0 = "rtdcn;" or key0 = "RTDCN")
    str = coordinate{Space}
Else if (key0 = "rtidcn" or key0 = "rtidcn;" or key0 = "RTIDCN")
    str = coordinate{Space}
Else if (key0 = "rtfcnm" or key0 = "rtfcnm;" or key0 = "RTFCNM")
    str = manufacture{Space}
Else if (key0 = "rtflc" or key0 = "rtflc;" or key0 = "RTFLC")
    str = reflect{Space}
Else if (key0 = "rtial" or key0 = "rtial;" or key0 = "RTIAL")
    str = trial{Space}
Else if (key0 = "rtikc" or key0 = "rtikc;" or key0 = "RTIKC")
    str = trick{Space}
Else if (key0 = "rtlcb" or key0 = "rtlcb;" or key0 = "RTLCB")
    str = collaborate{Space}
Else if (key0 = "rto" or key0 = "rto;" or key0 = "RTO")
    str = root{Space}
Else if (key0 = "rtoashc" or key0 = "rtoashc;" or key0 = "RTOASHC")
    str = orchestra{Space}
Else if (key0 = "rtopm" or key0 = "rtopm;" or key0 = "RTOPM")
    str = prompt{Space}
Else if (key0 = "rtpf" or key0 = "rtpf;" or key0 = "RTPF")
    str = profit{Space}
Else if (key0 = "rtpfn" or key0 = "rtpfn;" or key0 = "RTPFN")
    str = nonprofit{Space}
Else if (key0 = "rtypscn" or key0 = "rtypscn;" or key0 = "RTYPSCN")
    str = transparency{Space}
Else if (key0 = "rtpsdcn" or key0 = "rtpsdcn;" or key0 = "RTPSDCN")
    str = description{Space}
Else if (key0 = "rtpsn" or key0 = "rtpsn;" or key0 = "RTPSN")
    str = inspiration{Space}
Else if (key0 = "rtipvn" or key0 = "rtipvn;" or key0 = "RTIPVN")
    str = prevent{Space}
Else if (key0 = "rtpvn" or key0 = "rtpvn;" or key0 = "RTPVN")
    str = prevent{Space}
Else if (key0 = "rtpx" or key0 = "rtpx;" or key0 = "RTPX")
    str = expert{Space}
Else if (key0 = "rtscn" or key0 = "rtscn;" or key0 = "RTSCN")
    str = contrast{Space}
Else if (key0 = "rtsdnm" or key0 = "rtsdnm;" or key0 = "RTSDNM")
    str = demonstrate{Space}
Else if (key0 = "rtsgl" or key0 = "rtsgl;" or key0 = "RTSGL")
    str = struggle{Space}
Else if (key0 = "rtsn" or key0 = "rtsn;" or key0 = "RTSN")
    str = restaurant{Space}
Else if (key0 = "rtsn" or key0 = "rtsn;" or key0 = "RTSN")
    str = resonate{Space}
Else if (key0 = "rtsn" or key0 = "rtsn;" or key0 = "RTSN")
    str = restaurant{Space}
Else if (key0 = "rtsnm" or key0 = "rtsnm;" or key0 = "RTSNM")
    str = instrument{Space}
Else if (key0 = "rtuom" or key0 = "rtuom;" or key0 = "RTUOM")
    str = tumor{Space}
Else if (key0 = "rtycn" or key0 = "rtycn;" or key0 = "RTYCN")
    str = country{Space}
Else if (key0 = "rtyhcm" or key0 = "rtyhcm;" or key0 = "RTYHCM")
    str = chemistry{Space}
Else if (key0 = "rtyhm" or key0 = "rtyhm;" or key0 = "RTYHM")
    str = rhythm{Space}
Else if (key0 = "rtysc" or key0 = "rtysc;" or key0 = "RTYSC")
    str = security{Space}
Else if (key0 = "rtysh" or key0 = "rtysh;" or key0 = "RTYSH")
    str = history{Space}
Else if (key0 = "rudg" or key0 = "rudg;" or key0 = "RUDG")
    str = drug{Space}
Else if (key0 = "rvb" or key0 = "rvb;" or key0 = "RVB")
    str = brave{Space}
Else if (key0 = "rvm" or key0 = "rvm;" or key0 = "RVM")
    str = remove{Space}
Else if (key0 = "rygln" or key0 = "rygln;" or key0 = "RYGLN")
    str = neurology{Space}
Else if (key0 = "ripvm" or key0 = "ripvm;" or key0 = "RIPVM")
    str = improve{Space}
Else if (key0 = "rudm" or key0 = "rudm;" or key0 = "RUDM")
    str = drum{Space}
Else if (key0 = "ragb" or key0 = "ragb;" or key0 = "RAGB")
    str = grab{Space}
Else if (key0 = "rcv" or key0 = "rcv;" or key0 = "RCV")
    str = receive{Space}
Else if (key0 = "rdbn" or key0 = "rdbn;" or key0 = "RDBN")
    str = burden{Space}
Else if (key0 = "riop" or key0 = "riop;" or key0 = "RIOP")
    str = prior{Space}
Else if (key0 = "rnm" or key0 = "rnm;" or key0 = "RNM")
    str = remain{Space}
Else if (key0 = "rpcm" or key0 = "rpcm;" or key0 = "RPCM")
    str = compare{Space}
Else if (key0 = "rpsm" or key0 = "rpsm;" or key0 = "RPSM")
    str = promise{Space}
Else if (key0 = "rpsm" or key0 = "rpsm;" or key0 = "RPSM")
    str = promise{Space}
Else if (key0 = "rscv" or key0 = "rscv;" or key0 = "RSCV")
    str = service{Space}
Else if (key0 = "rsdcv" or key0 = "rsdcv;" or key0 = "RSDCV")
    str = discover{Space}
Else if (key0 = "rsdn" or key0 = "rsdn;" or key0 = "RSDN")
    str = surround{Space}
Else if (key0 = "rsv" or key0 = "rsv;" or key0 = "RSV")
    str = survive{Space}
Else if (key0 = "rsvn" or key0 = "rsvn;" or key0 = "RSVN")
    str = version{Space}
Else if (key0 = "rtd" or key0 = "rtd;" or key0 = "RTD")
    str = tried{Space}
Else if (key0 = "rtdgh" or key0 = "rtdgh;" or key0 = "RTDGH")
    str = daughter{Space}
Else if (key0 = "rtfg" or key0 = "rtfg;" or key0 = "RTFG")
    str = forget{Space}
Else if (key0 = "rthc" or key0 = "rthc;" or key0 = "RTHC")
    str = teacher{Space}
Else if (key0 = "rtian" or key0 = "rtian;" or key0 = "RTIAN")
    str = train{Space}
Else if (key0 = "rtic" or key0 = "rtic;" or key0 = "RTIC")
    str = critic{Space}
Else if (key0 = "rtioscn" or key0 = "rtioscn;" or key0 = "RTIOSCN")
    str = construction{Space}
Else if (key0 = "rtiscm" or key0 = "rtiscm;" or key0 = "RTISCM")
    str = criticism{Space}
Else if (key0 = "rtlm" or key0 = "rtlm;" or key0 = "RTLM")
    str = material{Space}
Else if (key0 = "rtln" or key0 = "rtln;" or key0 = "RTLN")
    str = relation{Space}
Else if (key0 = "rtscn" or key0 = "rtscn;" or key0 = "RTSCN")
    str = construct{Space}
Else if (key0 = "rtscvn" or key0 = "rtscvn;" or key0 = "RTSCVN")
    str = constructive{Space}
Else if (key0 = "rtsln" or key0 = "rtsln;" or key0 = "RTSLN")
    str = resolution{Space}
Else if (key0 = "ryac" or key0 = "ryac;" or key0 = "RYAC")
    str = carry{Space}
Else if (key0 = "rth" or key0 = "rth;" or key0 = "RTH")
    str = rather{Space}
Else if (key0 = "rab" or key0 = "rab;" or key0 = "RAB")
    str = bar{Space}
Else if (key0 = "rac" or key0 = "rac;" or key0 = "RAC")
    str = across{Space}
Else if (key0 = "radbn" or key0 = "radbn;" or key0 = "RADBN")
    str = brand{Space}
Else if (key0 = "radh" or key0 = "radh;" or key0 = "RADH")
    str = hard{Space}
Else if (key0 = "raf" or key0 = "raf;" or key0 = "RAF")
    str = far{Space}
Else if (key0 = "rafkn" or key0 = "rafkn;" or key0 = "RAFKN")
    str = frank{Space}
Else if (key0 = "ral" or key0 = "ral;" or key0 = "RAL")
    str = ral
Else if (key0 = "rax" or key0 = "rax;" or key0 = "RAX")
    str = extra{Space}
Else if (key0 = "rb" or key0 = "rb;" or key0 = "RB")
    str = br
Else if (key0 = "rbm" or key0 = "rbm;" or key0 = "RBM")
    str = remember{Space}
Else if (key0 = "rbn" or key0 = "rbn;" or key0 = "RBN")
    str = brain{Space}
Else if (key0 = "rc" or key0 = "rc;" or key0 = "RC")
    str = crazy{Space}
Else if (key0 = "rd" or key0 = "rd;" or key0 = "RD")
    str = read{Space}
Else if (key0 = "rdg" or key0 = "rdg;" or key0 = "RDG")
    str = during{Space}
Else if (key0 = "rdlz" or key0 = "rdlz;" or key0 = "RDLZ")
    str = realized{Space}
Else if (key0 = "rf" or key0 = "rf;" or key0 = "RF")
    str = from{Space}
Else if (key0 = "rfg" or key0 = "rfg;" or key0 = "RFG")
    str = figure{Space}
Else if (key0 = "rflm" or key0 = "rflm;" or key0 = "RFLM")
    str = familiar{Space}
Else if (key0 = "rfn" or key0 = "rfn;" or key0 = "RFN")
    str = refine{Space}
Else if (key0 = "rgb" or key0 = "rgb;" or key0 = "RGB")
    str = bring{Space}
Else if (key0 = "rgnm" or key0 = "rgnm;" or key0 = "RGNM")
    str = manager{Space}
Else if (key0 = "riognm" or key0 = "riognm;" or key0 = "RIOGNM")
    str = morning{Space}
Else if (key0 = "rgzcn" or key0 = "rgzcn;" or key0 = "RGZCN")
    str = recognize{Space}
Else if (key0 = "rh" or key0 = "rh;" or key0 = "RH")
    str = here{Space}
Else if (key0 = "riaf" or key0 = "riaf;" or key0 = "RIAF")
    str = fair{Space}
Else if (key0 = "ridhlc" or key0 = "ridhlc;" or key0 = "RIDHLC")
    str = children{Space}
Else if (key0 = "rdhlcn" or key0 = "rdhlcn;" or key0 = "RDHLCN")
    str = children{Space}
Else if (key0 = "rigbn" or key0 = "rigbn;" or key0 = "RIGBN")
    str = bring{Space}
Else if (key0 = "rigl" or key0 = "rigl;" or key0 = "RIGL")
    str = girl{Space}
Else if (key0 = "rihc" or key0 = "rihc;" or key0 = "RIHC")
    str = rich{Space}
Else if (key0 = "riocm" or key0 = "riocm;" or key0 = "RIOCM")
    str = micro
Else if (key0 = "ripa" or key0 = "ripa;" or key0 = "RIPA")
    str = pair{Space}
Else if (key0 = "rjm" or key0 = "rjm;" or key0 = "RJM")
    str = major{Space}
Else if (key0 = "rlnm" or key0 = "rlnm;" or key0 = "RLNM")
    str = normal{Space}
Else if (key0 = "rlz" or key0 = "rlz;" or key0 = "RLZ")
    str = realize{Space}
Else if (key0 = "rm" or key0 = "rm;" or key0 = "RM")
    str = more{Space}
Else if (key0 = "rn" or key0 = "rn;" or key0 = "RN")
    str = right now{Space}
Else if (key0 = "ro" or key0 = "ro;" or key0 = "RO")
    str = or{Space}
Else if (key0 = "roacm" or key0 = "roacm;" or key0 = "ROACM")
    str = macro
Else if (key0 = "road" or key0 = "road;" or key0 = "ROAD")
    str = road{Space}
Else if (key0 = "roadb" or key0 = "roadb;" or key0 = "ROADB")
    str = board{Space}
Else if (key0 = "roadbn" or key0 = "roadbn;" or key0 = "ROADBN")
    str = onboard{Space}
Else if (key0 = "roadl" or key0 = "roadl;" or key0 = "ROADL")
    str = dollar{Space}
Else if (key0 = "roalnm" or key0 = "roalnm;" or key0 = "ROALNM")
    str = normal{Space}
Else if (key0 = "rofm" or key0 = "rofm;" or key0 = "ROFM")
    str = form{Space}
Else if (key0 = "rog" or key0 = "rog;" or key0 = "ROG")
    str = organization{Space}
Else if (key0 = "rogln" or key0 = "rogln;" or key0 = "ROGLN")
    str = original{Space}
Else if (key0 = "rogn" or key0 = "rogn;" or key0 = "ROGN")
    str = original{Space}
Else if (key0 = "rognm" or key0 = "rognm;" or key0 = "ROGNM")
    str = morning{Space}
Else if (key0 = "rol" or key0 = "rol;" or key0 = "ROL")
    str = roll{Space}
Else if (key0 = "rolnm" or key0 = "rolnm;" or key0 = "ROLNM")
    str = normal{Space}
Else if (key0 = "rom" or key0 = "rom;" or key0 = "ROM")
    str = room{Space}
Else if (key0 = "rop" or key0 = "rop;" or key0 = "ROP")
    str = pro
Else if (key0 = "ropb" or key0 = "ropb;" or key0 = "ROPB")
    str = probably{Space}
Else if (key0 = "ropd" or key0 = "ropd;" or key0 = "ROPD")
    str = drop{Space}
Else if (key0 = "rtpdc" or key0 = "rtpdc;" or key0 = "RTPDC")
    str = product{Space}
Else if (key0 = "ropj" or key0 = "ropj;" or key0 = "ROPJ")
    str = project{Space}
Else if (key0 = "roplb" or key0 = "roplb;" or key0 = "ROPLB")
    str = problem{Space}
Else if (key0 = "rosc" or key0 = "rosc;" or key0 = "ROSC")
    str = cross{Space}
Else if (key0 = "rosg" or key0 = "rosg;" or key0 = "ROSG")
    str = organizations{Space}
Else if (key0 = "roslc" or key0 = "roslc;" or key0 = "ROSLC")
    str = scroll{Space}
Else if (key0 = "rpa" or key0 = "rpa;" or key0 = "RPA")
    str = appreciate{Space}
Else if (key0 = "rpahc" or key0 = "rpahc;" or key0 = "RPAHC")
    str = approach{Space}
Else if (key0 = "rpak" or key0 = "rpak;" or key0 = "RPAK")
    str = park{Space}
Else if (key0 = "rpb" or key0 = "rpb;" or key0 = "RPB")
    str = problem{Space}
Else if (key0 = "rpc" or key0 = "rpc;" or key0 = "RPC")
    str = process{Space}
Else if (key0 = "rpdc" or key0 = "rpdc;" or key0 = "RPDC")
    str = proceed{Space}
Else if (key0 = "rpdv" or key0 = "rpdv;" or key0 = "RPDV")
    str = provide{Space}
Else if (key0 = "rpf" or key0 = "rpf;" or key0 = "RPF")
    str = professional{Space}
Else if (key0 = "rpfcnm" or key0 = "rpfcnm;" or key0 = "RPFCNM")
    str = performance{Space}
Else if (key0 = "rpfl" or key0 = "rpfl;" or key0 = "RPFL")
    str = profile{Space}
Else if (key0 = "rpfm" or key0 = "rpfm;" or key0 = "RPFM")
    str = perform{Space}
Else if (key0 = "rpgm" or key0 = "rpgm;" or key0 = "RPGM")
    str = program{Space}
Else if (key0 = "rplb" or key0 = "rplb;" or key0 = "RPLB")
    str = problem{Space}
Else if (key0 = "rplx" or key0 = "rplx;" or key0 = "RPLX")
    str = explore{Space}
Else if (key0 = "rps" or key0 = "rps;" or key0 = "RPS")
    str = surprise{Space}
Else if (key0 = "rpslbn" or key0 = "rpslbn;" or key0 = "RPSLBN")
    str = responsible{Space}
Else if (key0 = "rpsdn" or key0 = "rpsdn;" or key0 = "RPSDN")
    str = respond{Space}
Else if (key0 = "rpsh" or key0 = "rpsh;" or key0 = "RPSH")
    str = perhaps{Space}
Else if (key0 = "rtpsbn" or key0 = "rtpsbn;" or key0 = "RTPSBN")
    str = responsibility{Space}
Else if (key0 = "rpsn" or key0 = "rpsn;" or key0 = "RPSN")
    str = response{Space}
Else if (key0 = "rs" or key0 = "rs;" or key0 = "RS")
    str = sure{Space}
Else if (key0 = "rsdcb" or key0 = "rsdcb;" or key0 = "RSDCB")
    str = describe{Space}
Else if (key0 = "rsdcn" or key0 = "rsdcn;" or key0 = "RSDCN")
    str = consider{Space}
Else if (key0 = "rsl" or key0 = "rsl;" or key0 = "RSL")
    str = release{Space}
Else if (key0 = "rslm" or key0 = "rslm;" or key0 = "RSLM")
    str = similar{Space}
Else if (key0 = "rslv" or key0 = "rslv;" or key0 = "RSLV")
    str = several{Space}
Else if (key0 = "rsn" or key0 = "rsn;" or key0 = "RSN")
    str = reason{Space}
Else if (key0 = "rt" or key0 = "rt;" or key0 = "RT")
    str = right{Space}
Else if (key0 = "rtad" or key0 = "rtad;" or key0 = "RTAD")
    str = traditional{Space}
Else if (key0 = "rtakc" or key0 = "rtakc;" or key0 = "RTAKC")
    str = track{Space}
Else if (key0 = "rtal" or key0 = "rtal;" or key0 = "RTAL")
    str = alright{Space}
Else if (key0 = "rtalc" or key0 = "rtalc;" or key0 = "RTALC")
    str = article{Space}
Else if (key0 = "rtan" or key0 = "rtan;" or key0 = "RTAN")
    str = another{Space}
Else if (key0 = "rtas" or key0 = "rtas;" or key0 = "RTAS")
    str = strategy{Space}
Else if (key0 = "rtasdn" or key0 = "rtasdn;" or key0 = "RTASDN")
    str = standard{Space}
Else if (key0 = "rtasn" or key0 = "rtasn;" or key0 = "RTASN")
    str = trans{Space}
Else if (key0 = "rtc" or key0 = "rtc;" or key0 = "RTC")
    str = create{Space}
Else if (key0 = "rtcn" or key0 = "rtcn;" or key0 = "RTCN")
    str = certain{Space}
Else if (key0 = "rtcv" or key0 = "rtcv;" or key0 = "RTCV")
    str = creative{Space}
Else if (key0 = "rtflc" or key0 = "rtflc;" or key0 = "RTFLC")
    str = reflect{Space}
Else if (key0 = "rtfn" or key0 = "rtfn;" or key0 = "RTFN")
    str = fortunate{Space}
Else if (key0 = "rtg" or key0 = "rtg;" or key0 = "RTG")
    str = trying{Space}
Else if (key0 = "rtgc" or key0 = "rtgc;" or key0 = "RTGC")
    str = creating{Space}
Else if (key0 = "rtgh" or key0 = "rtgh;" or key0 = "RTGH")
    str = together{Space}
Else if (key0 = "rti" or key0 = "rti;" or key0 = "RTI")
    str = tri
Else if (key0 = "rtiafc" or key0 = "rtiafc;" or key0 = "RTIAFC")
    str = traffic{Space}
Else if (key0 = "rtian" or key0 = "rtian;" or key0 = "RTIAN")
    str = intra
Else if (key0 = "rtiasn" or key0 = "rtiasn;" or key0 = "RTIASN")
    str = strain{Space}
Else if (key0 = "rtioasn" or key0 = "rtioasn;" or key0 = "RTIOASN")
    str = transition{Space}
Else if (key0 = "rtign" or key0 = "rtign;" or key0 = "RTIGN")
    str = integrate{Space}
Else if (key0 = "rtil" or key0 = "rtil;" or key0 = "RTIL")
    str = literally{Space}
Else if (key0 = "rtiodcn" or key0 = "rtiodcn;" or key0 = "RTIODCN")
    str = coordinate{Space}
Else if (key0 = "rtiodn" or key0 = "rtiodn;" or key0 = "RTIODN")
    str = introduce{Space}
Else if (key0 = "rtion" or key0 = "rtion;" or key0 = "RTION")
    str = intro{Space}
Else if (key0 = "rtipa" or key0 = "rtipa;" or key0 = "RTIPA")
    str = particular{Space}
Else if (key0 = "rtl" or key0 = "rtl;" or key0 = "RTL")
    str = literal{Space}
Else if (key0 = "rtlb" or key0 = "rtlb;" or key0 = "RTLB")
    str = trouble{Space}
Else if (key0 = "rtlc" or key0 = "rtlc;" or key0 = "RTLC")
    str = control{Space}
Else if (key0 = "rtlcb" or key0 = "rtlcb;" or key0 = "RTLCB")
    str = collaborate{Space}
Else if (key0 = "rtlv" or key0 = "rtlv;" or key0 = "RTLV")
    str = relative{Space}
Else if (key0 = "rtm" or key0 = "rtm;" or key0 = "RTM")
    str = remote{Space}
Else if (key0 = "rtn" or key0 = "rtn;" or key0 = "RTN")
    str = entire{Space}
Else if (key0 = "rtoac" or key0 = "rtoac;" or key0 = "RTOAC")
    str = actor{Space}
Else if (key0 = "rtoacn" or key0 = "rtoacn;" or key0 = "RTOACN")
    str = contract{Space}
Else if (key0 = "rtob" or key0 = "rtob;" or key0 = "RTOB")
    str = obtrusive{Space}
Else if (key0 = "rtocn" or key0 = "rtocn;" or key0 = "RTOCN")
    str = contro
Else if (key0 = "rtofn" or key0 = "rtofn;" or key0 = "RTOFN")
    str = front{Space}
Else if (key0 = "rtom" or key0 = "rtom;" or key0 = "RTOM")
    str = tomorrow{Space}
Else if (key0 = "rtos" or key0 = "rtos;" or key0 = "RTOS")
    str = sort{Space}
Else if (key0 = "rtosg" or key0 = "rtosg;" or key0 = "RTOSG")
    str = storage{Space}
Else if (key0 = "rtosgn" or key0 = "rtosgn;" or key0 = "RTOSGN")
    str = strong{Space}
Else if (key0 = "rtosh" or key0 = "rtosh;" or key0 = "RTOSH")
    str = short{Space}
Else if (key0 = "rtp" or key0 = "rtp;" or key0 = "RTP")
    str = repeat{Space}
Else if (key0 = "rtpa" or key0 = "rtpa;" or key0 = "RTPA")
    str = part{Space}
Else if (key0 = "rtpac" or key0 = "rtpac;" or key0 = "RTPAC")
    str = practice{Space}
Else if (key0 = "rtpan" or key0 = "rtpan;" or key0 = "RTPAN")
    str = apparent{Space}
Else if (key0 = "rtpc" or key0 = "rtpc;" or key0 = "RTPC")
    str = picture{Space}
Else if (key0 = "rtpcn" or key0 = "rtpcn;" or key0 = "RTPCN")
    str = perception{Space}
Else if (key0 = "rtps" or key0 = "rtps;" or key0 = "RTPS")
    str = separate{Space}
Else if (key0 = "rtpsc" or key0 = "rtpsc;" or key0 = "RTPSC")
    str = respect{Space}
Else if (key0 = "rtpscv" or key0 = "rtpscv;" or key0 = "RTPSCV")
    str = perspective{Space}
Else if (key0 = "rtpv" or key0 = "rtpv;" or key0 = "RTPV")
    str = private{Space}
Else if (key0 = "rts" or key0 = "rts;" or key0 = "RTS")
    str = start{Space}
Else if (key0 = "rtsbn" or key0 = "rtsbn;" or key0 = "RTSBN")
    str = stubborn{Space}
Else if (key0 = "rtscm" or key0 = "rtscm;" or key0 = "RTSCM")
    str = customer{Space}
Else if (key0 = "rtsd" or key0 = "rtsd;" or key0 = "RTSD")
    str = disastrous{Space}
Else if (key0 = "rtsdc" or key0 = "rtsdc;" or key0 = "RTSDC")
    str = distract{Space}
Else if (key0 = "rtsdn" or key0 = "rtsdn;" or key0 = "RTSDN")
    str = standard{Space}
Else if (key0 = "rtsg" or key0 = "rtsg;" or key0 = "RTSG")
    str = starting{Space}
Else if (key0 = "rtsgh" or key0 = "rtsgh;" or key0 = "RTSGH")
    str = straight{Space}
Else if (key0 = "rtsm" or key0 = "rtsm;" or key0 = "RTSM")
    str = stream{Space}
Else if (key0 = "rtualb" or key0 = "rtualb;" or key0 = "RTUALB")
    str = brutal{Space}
Else if (key0 = "rtualc" or key0 = "rtualc;" or key0 = "RTUALC")
    str = cultural{Space}
Else if (key0 = "rtuh" or key0 = "rtuh;" or key0 = "RTUH")
    str = hurt{Space}
Else if (key0 = "rtuogh" or key0 = "rtuogh;" or key0 = "RTUOGH")
    str = through{Space}
Else if (key0 = "rtun" or key0 = "rtun;" or key0 = "RTUN")
    str = turn{Space}
Else if (key0 = "rtuops" or key0 = "rtuops;" or key0 = "RTUOPS")
    str = support{Space}
Else if (key0 = "rtus" or key0 = "rtus;" or key0 = "RTUS")
    str = trust{Space}
Else if (key0 = "rtvn" or key0 = "rtvn;" or key0 = "RTVN")
    str = narrative{Space}
Else if (key0 = "rty" or key0 = "rty;" or key0 = "RTY")
    str = try{Space}
Else if (key0 = "rtyos" or key0 = "rtyos;" or key0 = "RTYOS")
    str = story{Space}
Else if (key0 = "rtypa" or key0 = "rtypa;" or key0 = "RTYPA")
    str = party{Space}
Else if (key0 = "rtyul" or key0 = "rtyul;" or key0 = "RTYUL")
    str = truly{Space}
Else if (key0 = "ru" or key0 = "ru;" or key0 = "RU")
    str = your{Space}
Else if (key0 = "ruioasv" or key0 = "ruioasv;" or key0 = "RUIOASV")
    str = various{Space}
Else if (key0 = "ruiosc" or key0 = "ruiosc;" or key0 = "RUIOSC")
    str = curious{Space}
Else if (key0 = "run" or key0 = "run;" or key0 = "RUN")
    str = run{Space}
Else if (key0 = "ruo" or key0 = "ruo;" or key0 = "RUO")
    str = our{Space}
Else if (key0 = "ruoc" or key0 = "ruoc;" or key0 = "RUOC")
    str = occur{Space}
Else if (key0 = "ruodgn" or key0 = "ruodgn;" or key0 = "RUODGN")
    str = ground{Space}
Else if (key0 = "ruoh" or key0 = "ruoh;" or key0 = "RUOH")
    str = hour{Space}
Else if (key0 = "ruopg" or key0 = "ruopg;" or key0 = "RUOPG")
    str = group{Space}
Else if (key0 = "ruphc" or key0 = "ruphc;" or key0 = "RUPHC")
    str = purchase{Space}
Else if (key0 = "rv" or key0 = "rv;" or key0 = "RV")
    str = virtual reality{Space}
Else if (key0 = "ry" or key0 = "ry;" or key0 = "RY")
    str = year{Space}
Else if (key0 = "rya" or key0 = "rya;" or key0 = "RYA")
    str = {BackSpace}ary{Space}
Else if (key0 = "ryafkln" or key0 = "ryafkln;" or key0 = "RYAFKLN")
    str = frankly{Space}
Else if (key0 = "ryav" or key0 = "ryav;" or key0 = "RYAV")
    str = vary{Space}
Else if (key0 = "ryos" or key0 = "ryos;" or key0 = "RYOS")
    str = sorry{Space}
Else if (key0 = "rypcv" or key0 = "rypcv;" or key0 = "RYPCV")
    str = privacy{Space}
Else if (key0 = "rys" or key0 = "rys;" or key0 = "RYS")
    str = years{Space}
Else if (key0 = "ran" or key0 = "ran;" or key0 = "RAN")
    str = ran{Space}
Else if (key0 = "rdcv" or key0 = "rdcv;" or key0 = "RDCV")
    str = received{Space}
Else if (key0 = "rjln" or key0 = "rjln;" or key0 = "RJLN")
    str = journal{Space}
Else if (key0 = "ropa" or key0 = "ropa;" or key0 = "ROPA")
    str = approach{Space}
Else if (key0 = "ropahc" or key0 = "ropahc;" or key0 = "ROPAHC")
    str = approach{Space}
Else if (key0 = "rpam" or key0 = "rpam;" or key0 = "RPAM")
    str = ramp{Space}
Else if (key0 = "rpsv" or key0 = "rpsv;" or key0 = "RPSV")
    str = previous{Space}
Else if (key0 = "rsm" or key0 = "rsm;" or key0 = "RSM")
    str = measure{Space}
Else if (key0 = "rta" or key0 = "rta;" or key0 = "RTA")
    str = art{Space}
Else if (key0 = "rtac" or key0 = "rtac;" or key0 = "RTAC")
    str = attract{Space}
Else if (key0 = "rtdc" or key0 = "rtdc;" or key0 = "RTDC")
    str = direct{Space}
Else if (key0 = "rtdg" or key0 = "rtdg;" or key0 = "RTDG")
    str = graduate{Space}
Else if (key0 = "rtdnm" or key0 = "rtdnm;" or key0 = "RTDNM")
    str = determine{Space}
Else if (key0 = "rtf" or key0 = "rtf;" or key0 = "RTF")
    str = feature{Space}
Else if (key0 = "rtghb" or key0 = "rtghb;" or key0 = "RTGHB")
    str = brought{Space}
Else if (key0 = "rtian" or key0 = "rtian;" or key0 = "RTIAN")
    str = train{Space}
Else if (key0 = "rtias" or key0 = "rtias;" or key0 = "RTIAS")
    str = artist{Space}
Else if (key0 = "rtipn" or key0 = "rtipn;" or key0 = "RTIPN")
    str = print{Space}
Else if (key0 = "rtpl" or key0 = "rtpl;" or key0 = "RTPL")
    str = partial{Space}
Else if (key0 = "rtpm" or key0 = "rtpm;" or key0 = "RTPM")
    str = promote{Space}
Else if (key0 = "rtsdb" or key0 = "rtsdb;" or key0 = "RTSDB")
    str = distribute{Space}
Else if (key0 = "ruopd" or key0 = "ruopd;" or key0 = "RUOPD")
    str = proud{Space}
Else if (key0 = "rtpn" or key0 = "rtpn;" or key0 = "RTPN")
    str = pattern{Space}
Else if (key0 = "rypm" or key0 = "rypm;" or key0 = "RYPM")
    str = primary{Space}
Return

SENDT:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "ta" or key0 = "ta;" or key0 = "TA")
    str = at{Space}
Else if (key0 = "tadh" or key0 = "tadh;" or key0 = "TADH")
    str = that'd{Space}
Else if (key0 = "tisv" or key0 = "tisv;" or key0 = "TISV")
    str = visit{Space}
Else if (key0 = "tadgvn" or key0 = "tadgvn;" or key0 = "TADGVN")
    str = advantage{Space}
Else if (key0 = "tafl" or key0 = "tafl;" or key0 = "TAFL")
    str = flat{Space}
Else if (key0 = "tal" or key0 = "tal;" or key0 = "TAL")
    str = tall{Space}
Else if (key0 = "taskl" or key0 = "taskl;" or key0 = "TASKL")
    str = stalk{Space}
Else if (key0 = "tasv" or key0 = "tasv;" or key0 = "TASV")
    str = vast{Space}
Else if (key0 = "tdvn" or key0 = "tdvn;" or key0 = "TDVN")
    str = divinity{Space}
Else if (key0 = "tfcn" or key0 = "tfcn;" or key0 = "TFCN")
    str = notification{Space}
Else if (key0 = "tflcn" or key0 = "tflcn;" or key0 = "TFLCN")
    str = conflict{Space}
Else if (key0 = "thbn" or key0 = "thbn;" or key0 = "THBN")
    str = beneath{Space}
Else if (key0 = "tiab" or key0 = "tiab;" or key0 = "TIAB")
    str = bait{Space}
Else if (key0 = "tiagn" or key0 = "tiagn;" or key0 = "TIAGN")
    str = giant{Space}
Else if (key0 = "tialcn" or key0 = "tialcn;" or key0 = "TIALCN")
    str = atlantic{Space}
Else if (key0 = "tiasc" or key0 = "tiasc;" or key0 = "TIASC")
    str = statistic{Space}
Else if (key0 = "tiasln" or key0 = "tiasln;" or key0 = "TIASLN")
    str = install{Space}
Else if (key0 = "tihcb" or key0 = "tihcb;" or key0 = "TIHCB")
    str = bitch{Space}
Else if (key0 = "tikc" or key0 = "tikc;" or key0 = "TIKC")
    str = tick{Space}
Else if (key0 = "tiod" or key0 = "tiod;" or key0 = "TIOD")
    str = idiot{Space}
Else if (key0 = "tipaslc" or key0 = "tipaslc;" or key0 = "TIPASLC")
    str = plastic{Space}
Else if (key0 = "tiscn" or key0 = "tiscn;" or key0 = "TISCN")
    str = instance{Space}
Else if (key0 = "toafl" or key0 = "toafl;" or key0 = "TOAFL")
    str = float{Space}
Else if (key0 = "tofn" or key0 = "tofn;" or key0 = "TOFN")
    str = font{Space}
Else if (key0 = "tokc" or key0 = "tokc;" or key0 = "TOKC")
    str = tock{Space}
Else if (key0 = "toskc" or key0 = "toskc;" or key0 = "TOSKC")
    str = stock{Space}
Else if (key0 = "tpad" or key0 = "tpad;" or key0 = "TPAD")
    str = adapt{Space}
Else if (key0 = "tpasm" or key0 = "tpasm;" or key0 = "TPASM")
    str = stamp{Space}
Else if (key0 = "tplnm" or key0 = "tplnm;" or key0 = "TPLNM")
    str = implement{Space}
Else if (key0 = "tpsd" or key0 = "tpsd;" or key0 = "TPSD")
    str = despite{Space}
Else if (key0 = "tpsgh" or key0 = "tpsgh;" or key0 = "TPSGH")
    str = spaghetti{Space}
Else if (key0 = "tpslc" or key0 = "tpslc;" or key0 = "TPSLC")
    str = plastic{Space}
Else if (key0 = "tpslcb" or key0 = "tpslcb;" or key0 = "TPSLCB")
    str = susceptible{Space}
Else if (key0 = "tsgvn" or key0 = "tsgvn;" or key0 = "TSGVN")
    str = investigate{Space}
Else if (key0 = "tshlb" or key0 = "tshlb;" or key0 = "TSHLB")
    str = establish{Space}
Else if (key0 = "tslc" or key0 = "tslc;" or key0 = "TSLC")
    str = statistical{Space}
Else if (key0 = "tuilb" or key0 = "tuilb;" or key0 = "TUILB")
    str = built{Space}
Else if (key0 = "tun" or key0 = "tun;" or key0 = "TUN")
    str = nut{Space}
Else if (key0 = "tuohc" or key0 = "tuohc;" or key0 = "TUOHC")
    str = touch{Space}
Else if (key0 = "tuosh" or key0 = "tuosh;" or key0 = "TUOSH")
    str = shout{Space}
Else if (key0 = "tyipac" or key0 = "tyipac;" or key0 = "TYIPAC")
    str = capacity{Space}
Else if (key0 = "typlm" or key0 = "typlm;" or key0 = "TYPLM")
    str = multiply{Space}
Else if (key0 = "tplcm" or key0 = "tplcm;" or key0 = "tPLCM")
    str = complete{Space}
Else if (key0 = "tuoab" or key0 = "tuoab;" or key0 = "TUOAB")
    str = about{Space}
Else if (key0 = "tihn" or key0 = "tihn;" or key0 = "TIHN")
    str = thin{Space}
Else if (key0 = "tpsln" or key0 = "tpsln;" or key0 = "TPSLN")
    str = pleasant{Space}
Else if (key0 = "tadcv" or key0 = "tadcv;" or key0 = "TADCV")
    str = advocate{Space}
Else if (key0 = "tahm" or key0 = "tahm;" or key0 = "TAHM")
    str = math{Space}
Else if (key0 = "tupg" or key0 = "tupg;" or key0 = "TUPG")
    str = putting{Space}
Else if (key0 = "takn" or key0 = "takn;" or key0 = "TAKN")
    str = tank{Space}
Else if (key0 = "tglv" or key0 = "tglv;" or key0 = "TGLV")
    str = vegetable{Space}
Else if (key0 = "tgvn" or key0 = "tgvn;" or key0 = "TGVN")
    str = navigate{Space}
Else if (key0 = "tiafh" or key0 = "tiafh;" or key0 = "TIAFH")
    str = faith{Space}
Else if (key0 = "tipsl" or key0 = "tipsl;" or key0 = "TIPSL")
    str = split{Space}
Else if (key0 = "tial" or key0 = "tial;" or key0 = "TIAL")
    str = tail{Space}
Else if (key0 = "tias" or key0 = "tias;" or key0 = "TIAS")
    str = assist{Space}
Else if (key0 = "tifghl" or key0 = "tifghl;" or key0 = "TIFGHL")
    str = flight{Space}
Else if (key0 = "tighm" or key0 = "tighm;" or key0 = "TIGHM")
    str = might{Space}
Else if (key0 = "tilcn" or key0 = "tilcn;" or key0 = "TILCN")
    str = inoculate{Space}
Else if (key0 = "tioflcn" or key0 = "tioflcn;" or key0 = "TIOFLCN")
    str = conflict{Space}
Else if (key0 = "tipan" or key0 = "tipan;" or key0 = "TIPAN")
    str = paint{Space}
Else if (key0 = "tipan" or key0 = "tipan;" or key0 = "TIPAN")
    str = paint{Space}
Else if (key0 = "tisv" or key0 = "tisv;" or key0 = "TISV")
    str = visit{Space}
Else if (key0 = "tohcb" or key0 = "tohcb;" or key0 = "TOHCB")
    str = botch{Space}
Else if (key0 = "tohlc" or key0 = "tohlc;" or key0 = "TOHLC")
    str = cloth{Space}
Else if (key0 = "topsg" or key0 = "topsg;" or key0 = "TOPSG")
    str = stopping{Space}
Else if (key0 = "tosd" or key0 = "tosd;" or key0 = "TOSD")
    str = stood{Space}
Else if (key0 = "toshm" or key0 = "toshm;" or key0 = "TOSHM")
    str = smooth{Space}
Else if (key0 = "toshm" or key0 = "toshm;" or key0 = "TOSHM")
    str = smooth{Space}
Else if (key0 = "tosl" or key0 = "tosl;" or key0 = "TOSL")
    str = lost{Space}
Else if (key0 = "tpasnm" or key0 = "tpasnm;" or key0 = "TPASNM")
    str = assumption{Space}
Else if (key0 = "tpcn" or key0 = "tpcn;" or key0 = "TPCN")
    str = patience{Space}
Else if (key0 = "tpcvm" or key0 = "tpcvm;" or key0 = "TPCVM")
    str = competitive{Space}
Else if (key0 = "tphkc" or key0 = "tphkc;" or key0 = "TPHKC")
    str = ketchup{Space}
Else if (key0 = "tpslc" or key0 = "tpslc;" or key0 = "TPSLC")
    str = telescope{Space}
Else if (key0 = "tsdnm" or key0 = "tsdnm;" or key0 = "TSDNM")
    str = disseminate{Space}
Else if (key0 = "tsfc" or key0 = "tsfc;" or key0 = "TSFC")
    str = suffocate{Space}
Else if (key0 = "tshlb" or key0 = "tshlb;" or key0 = "TSHLB")
    str = bullshit{Space}
Else if (key0 = "tuadl" or key0 = "tuadl;" or key0 = "TUADL")
    str = adult{Space}
Else if (key0 = "tuafl" or key0 = "tuafl;" or key0 = "TUAFL")
    str = fault{Space}
Else if (key0 = "tuasg" or key0 = "tuasg;" or key0 = "TUASG")
    str = August{Space}
Else if (key0 = "tuhn" or key0 = "tuhn;" or key0 = "TUHN")
    str = hunt{Space}
Else if (key0 = "tuin" or key0 = "tuin;" or key0 = "TUIN")
    str = unit{Space}
Else if (key0 = "tuioacn" or key0 = "tuioacn;" or key0 = "TUIOACN")
    str = caution{Space}
Else if (key0 = "tuipsd" or key0 = "tuipsd;" or key0 = "TUIPSD")
    str = stupid{Space}
Else if (key0 = "tuiscn" or key0 = "tuiscn;" or key0 = "TUISCN")
    str = succinct{Space}
Else if (key0 = "tulz" or key0 = "tulz;" or key0 = "TULZ")
    str = utilize{Space}
Else if (key0 = "tuoascm" or key0 = "tuoascm;" or key0 = "TUOASCM")
    str = accustom{Space}
Else if (key0 = "tuocm" or key0 = "tuocm;" or key0 = "TUOCM")
    str = outcome{Space}
Else if (key0 = "tuoslcn" or key0 = "tuoslcn;" or key0 = "TUOSLCN")
    str = consult{Space}
Else if (key0 = "tupg" or key0 = "tupg;" or key0 = "TUPG")
    str = putting{Space}
Else if (key0 = "tuskc" or key0 = "tuskc;" or key0 = "TUSKC")
    str = stuck{Space}
Else if (key0 = "tyflc" or key0 = "tyflc;" or key0 = "TYFLC")
    str = facility{Space}
Else if (key0 = "tuoghb" or key0 = "tuoghb;" or key0 = "TUOGHB")
    str = bought{Space}
Else if (key0 = "tpxc" or key0 = "tpxc;" or key0 = "TPXC")
    str = expect{Space}
Else if (key0 = "tpcn" or key0 = "tpcn;" or key0 = "TPCN")
    str = patience{Space}
Else if (key0 = "tpn" or key0 = "tpn;" or key0 = "TPN")
    str = patient{Space}
Else if (key0 = "tpcvm" or key0 = "tpcvm;" or key0 = "TPCVM")
    str = competitive{Space}
Else if (key0 = "tuaghc" or key0 = "tuaghc;" or key0 = "TUAGHC")
    str = caught{Space}
Else if (key0 = "tpscnm" or key0 = "tpscnm;" or key0 = "TPSCNM")
    str = compensate{Space}
Else if (key0 = "tfl" or key0 = "tfl;" or key0 = "TFL")
    str = left{Space}
Else if (key0 = "tuadl" or key0 = "tuadl;" or key0 = "TUADL")
    str = adult{Space}
Else if (key0 = "tsvn" or key0 = "tsvn;" or key0 = "TSVN")
    str = sensitive{Space}
Else if (key0 = "tgvm" or key0 = "tgvm;" or key0 = "TGVM")
    str = government{Space}
Else if (key0 = "todn" or key0 = "todn;" or key0 = "TODN")
    str = don't{Space}
Else if (key0 = "tacm" or key0 = "tacm;" or key0 = "TACM")
    str = automatic{Space}
Else if (key0 = "tx" or key0 = "tx;" or key0 = "TX")
    str = text{Space}
Else if (key0 = "tahc" or key0 = "tahc;" or key0 = "TAHC")
    str = catch{Space}
Else if (key0 = "tahcm" or key0 = "tahcm;" or key0 = "TAHCM")
    str = match{Space}
Else if (key0 = "tas" or key0 = "tas;" or key0 = "TAS")
    str = sat{Space}
Else if (key0 = "tadln" or key0 = "tadln;" or key0 = "TADLN")
    str = additional{Space}
Else if (key0 = "tadn" or key0 = "tadn;" or key0 = "TADN")
    str = addition{Space}
Else if (key0 = "tdlv" or key0 = "tdlv;" or key0 = "TDLV")
    str = validate{Space}
Else if (key0 = "tidcn" or key0 = "tidcn;" or key0 = "TIDCN")
    str = indicate{Space}
Else if (key0 = "tipalc" or key0 = "tipalc;" or key0 = "TIPALC")
    str = capital{Space}
Else if (key0 = "tisdn" or key0 = "tisdn;" or key0 = "TISDN")
    str = instead{Space}
Else if (key0 = "tpxc" or key0 = "tpxc;" or key0 = "TPXC")
    str = expect{Space}
Else if (key0 = "tosl" or key0 = "tosl;" or key0 = "TOSL")
    str = lost{Space}
Else if (key0 = "tplnm" or key0 = "tplnm;" or key0 = "TPLNM")
    str = implement{Space}
Else if (key0 = "tscnl" or key0 = "tscnl;" or key0 = "TSCNL")
    str = constantly{Space}
Else if (key0 = "tsdcn" or key0 = "tsdcn;" or key0 = "TSDCN")
    str = distance{Space}
Else if (key0 = "tsfgcn" or key0 = "tsfgcn;" or key0 = "TSFGCN")
    str = significant{Space}
Else if (key0 = "tuipn" or key0 = "tuipn;" or key0 = "TUIPN")
    str = input{Space}
Else if (key0 = "tydfn" or key0 = "tydfn;" or key0 = "TYDFN")
    str = identify{Space}
Else if (key0 = "tyusd" or key0 = "tyusd;" or key0 = "TYUSD")
    str = study{Space}
Else if (key0 = "tasc" or key0 = "tasc;" or key0 = "TASC")
    str = cast{Space}
Else if (key0 = "tadhn" or key0 = "tadhn;" or key0 = "TADHN")
    str = hadn’t{Space}
Else if (key0 = "tahl" or key0 = "tahl;" or key0 = "TAHL")
    str = that’ll{Space}
Else if (key0 = "tasgn" or key0 = "tasgn;" or key0 = "TASGN")
    str = against{Space}
Else if (key0 = "tashkn" or key0 = "tashkn;" or key0 = "TASHKN")
    str = thanks{Space}
Else if (key0 = "tbn" or key0 = "tbn;" or key0 = "TBN")
    str = button{Space}
Else if (key0 = "tiac" or key0 = "tiac;" or key0 = "TIAC")
    str = attic{Space}
Else if (key0 = "tiasn" or key0 = "tiasn;" or key0 = "TIASN")
    str = instant{Space}
Else if (key0 = "tidg" or key0 = "tidg;" or key0 = "TIDG")
    str = digit{Space}
Else if (key0 = "tif" or key0 = "tif;" or key0 = "TIF")
    str = fit{Space}
Else if (key0 = "tifg" or key0 = "tifg;" or key0 = "TIFG")
    str = gift{Space}
Else if (key0 = "tifgh" or key0 = "tifgh;" or key0 = "TIFGH")
    str = fight{Space}
Else if (key0 = "tihkc" or key0 = "tihkc;" or key0 = "TIHKC")
    str = thick{Space}
Else if (key0 = "tilm" or key0 = "tilm;" or key0 = "TILM")
    str = limit{Space}
Else if (key0 = "tioacn" or key0 = "tioacn;" or key0 = "TIOACN")
    str = contain{Space}
Else if (key0 = "tioghn" or key0 = "tioghn;" or key0 = "TIOGHN")
    str = tonight{Space}
Else if (key0 = "tionm" or key0 = "tionm;" or key0 = "TIONM")
    str = motion{Space}
Else if (key0 = "tism" or key0 = "tism;" or key0 = "TISM")
    str = mist{Space}
Else if (key0 = "tkn" or key0 = "tkn;" or key0 = "TKN")
    str = think{Space}
Else if (key0 = "toa" or key0 = "toa;" or key0 = "TOA")
    str = tattoo{Space}
Else if (key0 = "toasc" or key0 = "toasc;" or key0 = "TOASC")
    str = coast{Space}
Else if (key0 = "tof" or key0 = "tof;" or key0 = "TOF")
    str = foot{Space}
Else if (key0 = "toghn" or key0 = "toghn;" or key0 = "TOGHN")
    str = thong{Space}
Else if (key0 = "tops" or key0 = "tops;" or key0 = "TOPS")
    str = stop{Space}
Else if (key0 = "tpdn" or key0 = "tpdn;" or key0 = "TPDN")
    str = independent{Space}
Else if (key0 = "tpl" or key0 = "tpl;" or key0 = "TPL")
    str = pollute{Space}
Else if (key0 = "tplcnm" or key0 = "tplcnm;" or key0 = "TPLCNM")
    str = implication{Space}
Else if (key0 = "tplnm" or key0 = "tplnm;" or key0 = "TPLNM")
    str = implement{Space}
Else if (key0 = "tpslcnm" or key0 = "tpslcnm;" or key0 = "TPSLCNM")
    str = implications{Space}
Else if (key0 = "tpsm" or key0 = "tpsm;" or key0 = "TPSM")
    str = symptom{Space}
Else if (key0 = "trade" or key0 = "trade;" or key0 = "TRADE")
    str = trade{Space}
Else if (key0 = "tsbm" or key0 = "tsbm;" or key0 = "TSBM")
    str = submit{Space}
Else if (key0 = "tscbn" or key0 = "tscbn;" or key0 = "TSCBN")
    str = substance{Space}
Else if (key0 = "tsfnm" or key0 = "tsfnm;" or key0 = "TSFNM")
    str = manifest{Space}
Else if (key0 = "tsgn" or key0 = "tsgn;" or key0 = "TSGN")
    str = suggestion{Space}
Else if (key0 = "tsk" or key0 = "tsk;" or key0 = "TSK")
    str = takes{Space}
Else if (key0 = "tsxn" or key0 = "tsxn;" or key0 = "TSXN")
    str = extension{Space}
Else if (key0 = "tuah" or key0 = "tuah;" or key0 = "TUAH")
    str = authorize{Space}
Else if (key0 = "tuahcn" or key0 = "tuahcn;" or key0 = "TUAHCN")
    str = authentic{Space}
Else if (key0 = "tuioanm" or key0 = "tuioanm;" or key0 = "TUIOANM")
    str = mountain{Space}
Else if (key0 = "tuisln" or key0 = "tuisln;" or key0 = "TUISLN")
    str = insult{Space}
Else if (key0 = "tulc" or key0 = "tulc;" or key0 = "TULC")
    str = cult{Space}
Else if (key0 = "tuosd" or key0 = "tuosd;" or key0 = "TUOSD")
    str = outside{Space}
Else if (key0 = "tuosh" or key0 = "tuosh;" or key0 = "TUOSH")
    str = south{Space}
Else if (key0 = "tuosh" or key0 = "tuosh;" or key0 = "TUOSH")
    str = shout{Space}
Else if (key0 = "tvn" or key0 = "tvn;" or key0 = "TVN")
    str = initiative{Space}
Else if (key0 = "tvnm" or key0 = "tvnm;" or key0 = "TVNM")
    str = motivation{Space}
Else if (key0 = "typsm" or key0 = "typsm;" or key0 = "TYPSM")
    str = symptom{Space}
Else if (key0 = "tyuocn" or key0 = "tyuocn;" or key0 = "TYUOCN")
    str = county{Space}
Else if (key0 = "tdcn" or key0 = "tdcn;" or key0 = "TDCN")
    str = condition{Space}
Else if (key0 = "tdcn" or key0 = "tdcn;" or key0 = "TDCN")
    str = candidate{Space}
Else if (key0 = "tdcnm" or key0 = "tdcnm;" or key0 = "TDCNM")
    str = document{Space}
Else if (key0 = "tdxn" or key0 = "tdxn;" or key0 = "TDXN")
    str = extend{Space}
Else if (key0 = "tgn" or key0 = "tgn;" or key0 = "TGN")
    str = negotiate{Space}
Else if (key0 = "tidc" or key0 = "tidc;" or key0 = "TIDC")
    str = dict{Space}
Else if (key0 = "tidfn" or key0 = "tidfn;" or key0 = "TIDFN")
    str = identify{Space}
Else if (key0 = "tidm" or key0 = "tidm;" or key0 = "TIDM")
    str = immediate{Space}
Else if (key0 = "tifl" or key0 = "tifl;" or key0 = "TIFL")
    str = lift{Space}
Else if (key0 = "tiocm" or key0 = "tiocm;" or key0 = "TIOCM")
    str = commit{Space}
Else if (key0 = "tiopc" or key0 = "tiopc;" or key0 = "TIOPC")
    str = topic{Space}
Else if (key0 = "tip" or key0 = "tip;" or key0 = "TIP")
    str = tip{Space}
Else if (key0 = "tips" or key0 = "tips;" or key0 = "TIPS")
    str = tips{Space}
Else if (key0 = "tisfh" or key0 = "tisfh;" or key0 = "TISFH")
    str = shift{Space}
Else if (key0 = "tisghl" or key0 = "tisghl;" or key0 = "TISGHL")
    str = slight{Space}
Else if (key0 = "tisn" or key0 = "tisn;" or key0 = "TISN")
    str = isn't{Space}
Else if (key0 = "tlcm" or key0 = "tlcm;" or key0 = "TLCM")
    str = climate{Space}
Else if (key0 = "tln" or key0 = "tln;" or key0 = "TLN")
    str = national{Space}
Else if (key0 = "tocv" or key0 = "tocv;" or key0 = "TOCV")
    str = octave{Space}
Else if (key0 = "tojcvb" or key0 = "tojcvb;" or key0 = "TOJCVB")
    str = objective{Space}
Else if (key0 = "tpan" or key0 = "tpan;" or key0 = "TPAN")
    str = appoint{Space}
Else if (key0 = "tpanm" or key0 = "tpanm;" or key0 = "TPANM")
    str = appointment{Space}
Else if (key0 = "tpcm" or key0 = "tpcm;" or key0 = "TPCM")
    str = compete{Space}
Else if (key0 = "tplc" or key0 = "tplc;" or key0 = "TPLC")
    str = politic{Space}
Else if (key0 = "tplcnm" or key0 = "tplcnm;" or key0 = "TPLCNM")
    str = complement{Space}
Else if (key0 = "tpshcn" or key0 = "tpshcn;" or key0 = "TPSHCN")
    str = snapchat{Space}
Else if (key0 = "tpsn" or key0 = "tpsn;" or key0 = "TPSN")
    str = position{Space}
Else if (key0 = "tscn" or key0 = "tscn;" or key0 = "TSCN")
    str = constant{Space}
Else if (key0 = "tscn" or key0 = "tscn;" or key0 = "TSCN")
    str = consistent{Space}
Else if (key0 = "tscn" or key0 = "tscn;" or key0 = "TSCN")
    str = constant{Space}
Else if (key0 = "tscn" or key0 = "tscn;" or key0 = "TSCN")
    str = scientist{Space}
Else if (key0 = "tsdcn" or key0 = "tsdcn;" or key0 = "TSDCN")
    str = distance{Space}
Else if (key0 = "tsdhn" or key0 = "tsdhn;" or key0 = "TSDHN")
    str = thousand{Space}
Else if (key0 = "tudc" or key0 = "tudc;" or key0 = "TUDC")
    str = duct{Space}
Else if (key0 = "tuiosd" or key0 = "tuiosd;" or key0 = "TUIOSD")
    str = studio{Space}
Else if (key0 = "tuis" or key0 = "tuis;" or key0 = "TUIS")
    str = suit{Space}
Else if (key0 = "tuodb" or key0 = "tuodb;" or key0 = "TUODB")
    str = doubt{Space}
Else if (key0 = "tuodcn" or key0 = "tuodcn;" or key0 = "TUODCN")
    str = conduct{Space}
Else if (key0 = "tuokl" or key0 = "tuokl;" or key0 = "TUOKL")
    str = outlook{Space}
Else if (key0 = "tush" or key0 = "tush;" or key0 = "TUSH")
    str = shut{Space}
Else if (key0 = "tvm" or key0 = "tvm;" or key0 = "TVM")
    str = motive{Space}
Else if (key0 = "tvn" or key0 = "tvn;" or key0 = "TVN")
    str = invite{Space}
Else if (key0 = "tyb" or key0 = "tyb;" or key0 = "TYB")
    str = beauty{Space}
Else if (key0 = "tycn" or key0 = "tycn;" or key0 = "TYCN")
    str = county{Space}
Else if (key0 = "tyin" or key0 = "tyin;" or key0 = "TYIN")
    str = tiny{Space}
Else if (key0 = "typac" or key0 = "typac;" or key0 = "TYPAC")
    str = capacity{Space}
Else if (key0 = "typc" or key0 = "typc;" or key0 = "TYPC")
    str = capacity{Space}
Else if (key0 = "tac" or key0 = "tac;" or key0 = "TAC")
    str = act{Space}
Else if (key0 = "tflb" or key0 = "tflb;" or key0 = "TFLB")
    str = beautiful{Space}
Else if (key0 = "tashn" or key0 = "tashn;" or key0 = "TASHN")
    str = hasn't{Space}
Else if (key0 = "tflb" or key0 = "tflb;" or key0 = "TFLB")
    str = beautiful{Space}
Else if (key0 = "tgvn" or key0 = "tgvn;" or key0 = "TGVN")
    str = negative{Space}
Else if (key0 = "tianm" or key0 = "tianm;" or key0 = "TIANM")
    str = maintain{Space}
Else if (key0 = "til" or key0 = "til;" or key0 = "TIL")
    str = it'll{Space}
Else if (key0 = "tipacm" or key0 = "tipacm;" or key0 = "TIPACM")
    str = impact{Space}
Else if (key0 = "tosh" or key0 = "tosh;" or key0 = "TOSH")
    str = shot{Space}
Else if (key0 = "tscm" or key0 = "tscm;" or key0 = "TSCM")
    str = costume{Space}
Else if (key0 = "tsfcn" or key0 = "tsfcn;" or key0 = "TSFCN")
    str = fantastic{Space}
Else if (key0 = "tuioas" or key0 = "tuioas;" or key0 = "TUIOAS")
    str = situation{Space}
Else if (key0 = "tuioas" or key0 = "tuioas;" or key0 = "TUIOAS")
    str = situation{Space}
Else if (key0 = "tacn" or key0 = "tacn;" or key0 = "TACN")
    str = can't{Space}
Else if (key0 = "tad" or key0 = "tad;" or key0 = "TAD")
    str = data{Space}
Else if (key0 = "tafc" or key0 = "tafc;" or key0 = "TAFC")
    str = fact{Space}
Else if (key0 = "tagkl" or key0 = "tagkl;" or key0 = "TAGKL")
    str = talking{Space}
Else if (key0 = "tagn" or key0 = "tagn;" or key0 = "TAGN")
    str = against{Space}
Else if (key0 = "tah" or key0 = "tah;" or key0 = "TAH")
    str = that{Space}
Else if (key0 = "tahc" or key0 = "tahc;" or key0 = "TAHC")
    str = chat{Space}
Else if (key0 = "tahkn" or key0 = "tahkn;" or key0 = "TAHKN")
    str = thank{Space}
Else if (key0 = "tahn" or key0 = "tahn;" or key0 = "TAHN")
    str = than{Space}
Else if (key0 = "takl" or key0 = "takl;" or key0 = "TAKL")
    str = talk{Space}
Else if (key0 = "talc" or key0 = "talc;" or key0 = "TALC")
    str = actually{Space}
Else if (key0 = "tam" or key0 = "tam;" or key0 = "TAM")
    str = amount{Space}
Else if (key0 = "tan" or key0 = "tan;" or key0 = "TAN")
    str = attention{Space}
Else if (key0 = "tasdn" or key0 = "tasdn;" or key0 = "TASDN")
    str = stand{Space}
Else if (key0 = "tasf" or key0 = "tasf;" or key0 = "TASF")
    str = fast{Space}
Else if (key0 = "tash" or key0 = "tash;" or key0 = "TASH")
    str = that's{Space}
Else if (key0 = "taskc" or key0 = "taskc;" or key0 = "TASKC")
    str = stack{Space}
Else if (key0 = "tasl" or key0 = "tasl;" or key0 = "TASL")
    str = last{Space}
Else if (key0 = "tbm" or key0 = "tbm;" or key0 = "TBM")
    str = bottom{Space}
Else if (key0 = "tc" or key0 = "tc;" or key0 = "TC")
    str = content{Space}
Else if (key0 = "tcm" or key0 = "tcm;" or key0 = "TCM")
    str = community{Space}
Else if (key0 = "tcn" or key0 = "tcn;" or key0 = "TCN")
    str = continue{Space}
Else if (key0 = "td" or key0 = "td;" or key0 = "TD")
    str = today{Space}
Else if (key0 = "tdcmn" or key0 = "tdcmn;" or key0 = "TDCMN")
    str = document{Space}
Else if (key0 = "tdfcn" or key0 = "tdfcn;" or key0 = "TDFCN")
    str = confident{Space}
Else if (key0 = "tdgl" or key0 = "tdgl;" or key0 = "TDGL")
    str = digital{Space}
Else if (key0 = "tdl" or key0 = "tdl;" or key0 = "TDL")
    str = detail{Space}
Else if (key0 = "tdn" or key0 = "tdn;" or key0 = "TDN")
    str = don't{Space}
Else if (key0 = "tdx" or key0 = "tdx;" or key0 = "TDX")
    str = excited{Space}
Else if (key0 = "tf" or key0 = "tf;" or key0 = "TF")
    str = first{Space}
Else if (key0 = "tfbn" or key0 = "tfbn;" or key0 = "TFBN")
    str = benefit{Space}
Else if (key0 = "tg" or key0 = "tg;" or key0 = "TG")
    str = thing{Space}
Else if (key0 = "tghlc" or key0 = "tghlc;" or key0 = "TGHLC")
    str = glitch{Space}
Else if (key0 = "tgk" or key0 = "tgk;" or key0 = "TGK")
    str = taking{Space}
Else if (key0 = "tgk" or key0 = "tgk;" or key0 = "TGK")
    str = taking{Space}
Else if (key0 = "tgkl" or key0 = "tgkl;" or key0 = "TGKL")
    str = talking{Space}
Else if (key0 = "tgkl" or key0 = "tgkl;" or key0 = "TGKL")
    str = talking{Space}
Else if (key0 = "tgkn" or key0 = "tgkn;" or key0 = "TGKN")
    str = thinking{Space}
Else if (key0 = "tgm" or key0 = "tgm;" or key0 = "TGM")
    str = meeting{Space}
Else if (key0 = "tgnm" or key0 = "tgnm;" or key0 = "TGNM")
    str = management{Space}
Else if (key0 = "th" or key0 = "th;" or key0 = "TH")
    str = this{Space}
Else if (key0 = "thb" or key0 = "thb;" or key0 = "THB")
    str = to be honest{Space}
Else if (key0 = "thkn" or key0 = "thkn;" or key0 = "THKN")
    str = think{Space}
Else if (key0 = "thvn" or key0 = "thvn;" or key0 = "THVN")
    str = haven't{Space}
Else if (key0 = "ti" or key0 = "ti;" or key0 = "TI")
    str = it{Space}
Else if (key0 = "tiagh" or key0 = "tiagh;" or key0 = "TIAGH")
    str = aight{Space}
Else if (key0 = "tialn" or key0 = "tialn;" or key0 = "TIALN")
    str = initial{Space}
Else if (key0 = "tian" or key0 = "tian;" or key0 = "TIAN")
    str = anti
Else if (key0 = "tib" or key0 = "tib;" or key0 = "TIB")
    str = bit{Space}
Else if (key0 = "tid" or key0 = "tid;" or key0 = "TID")
    str = it'd{Space}
Else if (key0 = "tidm" or key0 = "tidm;" or key0 = "TIDM")
    str = immediate{Space}
Else if (key0 = "tidn" or key0 = "tidn;" or key0 = "TIDN")
    str = didn't{Space}
Else if (key0 = "tig" or key0 = "tig;" or key0 = "TIG")
    str = {BackSpace}ight{Space}
Else if (key0 = "tigh" or key0 = "tigh;" or key0 = "TIGH")
    str = tight{Space}
Else if (key0 = "tighl" or key0 = "tighl;" or key0 = "TIGHL")
    str = light{Space}
Else if (key0 = "tighn" or key0 = "tighn;" or key0 = "TIGHN")
    str = night{Space}
Else if (key0 = "tign" or key0 = "tign;" or key0 = "TIGN")
    str = interesting{Space}
Else if (key0 = "tih" or key0 = "tih;" or key0 = "TIH")
    str = I think{Space}
Else if (key0 = "tihc" or key0 = "tihc;" or key0 = "TIHC")
    str = itch{Space}
Else if (key0 = "tihkn" or key0 = "tihkn;" or key0 = "TIHKN")
    str = think{Space}
Else if (key0 = "tiln" or key0 = "tiln;" or key0 = "TILN")
    str = internal{Space}
Else if (key0 = "tin" or key0 = "tin;" or key0 = "TIN")
    str = interest{Space}
Else if (key0 = "tio" or key0 = "tio;" or key0 = "TIO")
    str = in terms of{Space}
Else if (key0 = "tioan" or key0 = "tioan;" or key0 = "TIOAN")
    str = {BackSpace}ation{Space}
Else if (key0 = "tioln" or key0 = "tioln;" or key0 = "TIOLN")
    str = international{Space}
Else if (key0 = "tion" or key0 = "tion;" or key0 = "TION")
    str = into{Space}
Else if (key0 = "tiopsn" or key0 = "tiopsn;" or key0 = "TIOPSN")
    str = position{Space}
Else if (key0 = "tis" or key0 = "tis;" or key0 = "TIS")
    str = it's{Space}
Else if (key0 = "tisdcn" or key0 = "tisdcn;" or key0 = "TISDCN")
    str = distinct{Space}
Else if (key0 = "tisgh" or key0 = "tisgh;" or key0 = "TISGH")
    str = sight{Space}
Else if (key0 = "tish" or key0 = "tish;" or key0 = "TISH")
    str = this{Space}
Else if (key0 = "tish" or key0 = "tish;" or key0 = "TISH")
    str = this{Space}
Else if (key0 = "tiskc" or key0 = "tiskc;" or key0 = "TISKC")
    str = stick{Space}
Else if (key0 = "tisl" or key0 = "tisl;" or key0 = "TISL")
    str = still{Space}
Else if (key0 = "tisn" or key0 = "tisn;" or key0 = "TISN")
    str = instead{Space}
Else if (key0 = "tivn" or key0 = "tivn;" or key0 = "TIVN")
    str = interview{Space}
Else if (key0 = "tiz" or key0 = "tiz;" or key0 = "TIZ")
    str = ization
Else if (key0 = "tk" or key0 = "tk;" or key0 = "TK")
    str = take{Space}
Else if (key0 = "tkl" or key0 = "tkl;" or key0 = "TKL")
    str = talk{Space}
Else if (key0 = "tkm" or key0 = "tkm;" or key0 = "TKM")
    str = market{Space}
Else if (key0 = "tlb" or key0 = "tlb;" or key0 = "TLB")
    str = built{Space}
Else if (key0 = "tlcn" or key0 = "tlcn;" or key0 = "TLCN")
    str = technical{Space}
Else if (key0 = "tlnm" or key0 = "tlnm;" or key0 = "TLNM")
    str = mental{Space}
Else if (key0 = "tlxn" or key0 = "tlxn;" or key0 = "TLXN")
    str = excellent{Space}
Else if (key0 = "tm" or key0 = "tm;" or key0 = "TM")
    str = time{Space}
Else if (key0 = "tnm" or key0 = "tnm;" or key0 = "TNM")
    str = minute{Space}
Else if (key0 = "to" or key0 = "to;" or key0 = "TO")
    str = to{Space}
Else if (key0 = "to" or key0 = "to;" or key0 = "TO")
    str = too{Space}
Else if (key0 = "toacn" or key0 = "toacn;" or key0 = "TOACN")
    str = contact{Space}
Else if (key0 = "toahl" or key0 = "toahl;" or key0 = "TOAHL")
    str = although{Space}
Else if (key0 = "toal" or key0 = "toal;" or key0 = "TOAL")
    str = total{Space}
Else if (key0 = "tobm" or key0 = "tobm;" or key0 = "TOBM")
    str = bottom{Space}
Else if (key0 = "tocn" or key0 = "tocn;" or key0 = "TOCN")
    str = contract{Space}
Else if (key0 = "todl" or key0 = "todl;" or key0 = "TODL")
    str = told{Space}
Else if (key0 = "todn" or key0 = "todn;" or key0 = "TODN")
    str = don't{Space}
Else if (key0 = "tog" or key0 = "tog;" or key0 = "TOG")
    str = got{Space}
Else if (key0 = "toh" or key0 = "toh;" or key0 = "TOH")
    str = though{Space}
Else if (key0 = "tohb" or key0 = "tohb;" or key0 = "TOHB")
    str = both{Space}
Else if (key0 = "tohnm" or key0 = "tohnm;" or key0 = "TOHNM")
    str = month{Space}
Else if (key0 = "tok" or key0 = "tok;" or key0 = "TOK")
    str = took{Space}
Else if (key0 = "tol" or key0 = "tol;" or key0 = "TOL")
    str = lot{Space}
Else if (key0 = "ton" or key0 = "ton;" or key0 = "TON")
    str = not{Space}
Else if (key0 = "ton" or key0 = "ton;" or key0 = "TON")
    str = not{Space}
Else if (key0 = "top" or key0 = "top;" or key0 = "TOP")
    str = top{Space}
Else if (key0 = "topad" or key0 = "topad;" or key0 = "TOPAD")
    str = adopt{Space}
Else if (key0 = "toph" or key0 = "toph;" or key0 = "TOPH")
    str = photo{Space}
Else if (key0 = "tops" or key0 = "tops;" or key0 = "TOPS")
    str = stop{Space}
Else if (key0 = "topzm" or key0 = "topzm;" or key0 = "TOPZM")
    str = optimize{Space}
Else if (key0 = "tosc" or key0 = "tosc;" or key0 = "TOSC")
    str = cost{Space}
Else if (key0 = "tosl" or key0 = "tosl;" or key0 = "TOSL")
    str = lost{Space}
Else if (key0 = "tosm" or key0 = "tosm;" or key0 = "TOSM")
    str = most{Space}
Else if (key0 = "tp" or key0 = "tp;" or key0 = "TP")
    str = point{Space}
Else if (key0 = "tpaflm" or key0 = "tpaflm;" or key0 = "TPAFLM")
    str = platform{Space}
Else if (key0 = "tpaln" or key0 = "tpaln;" or key0 = "TPALN")
    str = plant{Space}
Else if (key0 = "tpas" or key0 = "tpas;" or key0 = "TPAS")
    str = past{Space}
Else if (key0 = "tpc" or key0 = "tpc;" or key0 = "TPC")
    str = corporate{Space}
Else if (key0 = "tpcnm" or key0 = "tpcnm;" or key0 = "TPCNM")
    str = component{Space}
Else if (key0 = "tpd" or key0 = "tpd;" or key0 = "TPD")
    str = department{Space}
Else if (key0 = "tplm" or key0 = "tplm;" or key0 = "TPLM")
    str = multiple{Space}
Else if (key0 = "tpln" or key0 = "tpln;" or key0 = "TPLN")
    str = potential{Space}
Else if (key0 = "tps" or key0 = "tps;" or key0 = "TPS")
    str = post{Space}
Else if (key0 = "tpsn" or key0 = "tpsn;" or key0 = "TPSN")
    str = postpone{Space}
Else if (key0 = "tpsv" or key0 = "tpsv;" or key0 = "TPSV")
    str = positive{Space}
Else if (key0 = "ts" or key0 = "ts;" or key0 = "TS")
    str = its{Space}
Else if (key0 = "ts" or key0 = "ts;" or key0 = "TS")
    str = st
Else if (key0 = "tsdn" or key0 = "tsdn;" or key0 = "TSDN")
    str = doesn't{Space}
Else if (key0 = "tsfgn" or key0 = "tsfgn;" or key0 = "TSFGN")
    str = significant{Space}
Else if (key0 = "tsg" or key0 = "tsg;" or key0 = "TSG")
    str = things{Space}
Else if (key0 = "tsdhn" or key0 = "tsdhn;" or key0 = "TSDHN")
    str = shouldn't{Space}
Else if (key0 = "tskm" or key0 = "tskm;" or key0 = "TSKM")
    str = mistake{Space}
Else if (key0 = "tsl" or key0 = "tsl;" or key0 = "TSL")
    str = list{Space}
Else if (key0 = "tsln" or key0 = "tsln;" or key0 = "TSLN")
    str = listen{Space}
Else if (key0 = "tslvm" or key0 = "tslvm;" or key0 = "TSLVM")
    str = themselves{Space}
Else if (key0 = "tsm" or key0 = "tsm;" or key0 = "TSM")
    str = sometimes{Space}
Else if (key0 = "tsn" or key0 = "tsn;" or key0 = "TSN")
    str = essentially{Space}
Else if (key0 = "tua" or key0 = "tua;" or key0 = "TUA")
    str = uation
Else if (key0 = "tuagh" or key0 = "tuagh;" or key0 = "TUAGH")
    str = taught{Space}
Else if (key0 = "tualc" or key0 = "tualc;" or key0 = "TUALC")
    str = actual{Space}
Else if (key0 = "tub" or key0 = "tub;" or key0 = "TUB")
    str = but{Space}
Else if (key0 = "tuc" or key0 = "tuc;" or key0 = "TUC")
    str = cut{Space}
Else if (key0 = "tuiln" or key0 = "tuiln;" or key0 = "TUILN")
    str = until{Space}
Else if (key0 = "tuioasn" or key0 = "tuioasn;" or key0 = "TUIOASN")
    str = situation{Space}
Else if (key0 = "tuipdlc" or key0 = "tuipdlc;" or key0 = "TUIPDLC")
    str = duplicate{Space}
Else if (key0 = "tul" or key0 = "tul;" or key0 = "TUL")
    str = ultimately{Space}
Else if (key0 = "tuo" or key0 = "tuo;" or key0 = "TUO")
    str = out{Space}
Else if (key0 = "tuoa" or key0 = "tuoa;" or key0 = "TUOA")
    str = auto{Space}
Else if (key0 = "tuoacn" or key0 = "tuoacn;" or key0 = "TUOACN")
    str = account{Space}
Else if (key0 = "tuobn" or key0 = "tuobn;" or key0 = "TUOBN")
    str = button{Space}
Else if (key0 = "tuocn" or key0 = "tuocn;" or key0 = "TUOCN")
    str = count{Space}
Else if (key0 = "tuohc" or key0 = "tuohc;" or key0 = "TUOHC")
    str = touch{Space}
Else if (key0 = "tuohm" or key0 = "tuohm;" or key0 = "TUOHM")
    str = mouth{Space}
Else if (key0 = "tuoscm" or key0 = "tuoscm;" or key0 = "TUOSCM")
    str = custom{Space}
Else if (key0 = "tup" or key0 = "tup;" or key0 = "TUP")
    str = put{Space}
Else if (key0 = "tusf" or key0 = "tusf;" or key0 = "TUSF")
    str = stuff{Space}
Else if (key0 = "tusm" or key0 = "tusm;" or key0 = "TUSM")
    str = must{Space}
Else if (key0 = "txc" or key0 = "txc;" or key0 = "TXC")
    str = context{Space}
Else if (key0 = "ty" or key0 = "ty;" or key0 = "TY")
    str = thank you{Space}
Else if (key0 = "tyas" or key0 = "tyas;" or key0 = "TYAS")
    str = stay{Space}
Else if (key0 = "tyaslv" or key0 = "tyaslv;" or key0 = "TYASLV")
    str = vastly{Space}
Else if (key0 = "tyd" or key0 = "tyd;" or key0 = "TYD")
    str = today{Space}
Else if (key0 = "tyi" or key0 = "tyi;" or key0 = "TYI")
    str = {BackSpace}ity{Space}
Else if (key0 = "tyiacv" or key0 = "tyiacv;" or key0 = "TYIACV")
    str = activity{Space}
Else if (key0 = "tyial" or key0 = "tyial;" or key0 = "TYIAL")
    str = {BackSpace}ality{Space}
Else if (key0 = "tyialb" or key0 = "tyialb;" or key0 = "TYIALB")
    str = ability{Space}
Else if (key0 = "tyidn" or key0 = "tyidn;" or key0 = "TYIDN")
    str = identity{Space}
Else if (key0 = "tyik" or key0 = "tyik;" or key0 = "TYIK")
    str = kitty{Space}
Else if (key0 = "tyil" or key0 = "tyil;" or key0 = "TYIL")
    str = ility{Space}
Else if (key0 = "tyilb" or key0 = "tyilb;" or key0 = "TYILB")
    str = ibility{Space}
Else if (key0 = "tyo" or key0 = "tyo;" or key0 = "TYO")
    str = toy{Space}
Else if (key0 = "tyoal" or key0 = "tyoal;" or key0 = "TYOAL")
    str = totally{Space}
Else if (key0 = "typhlc" or key0 = "typhlc;" or key0 = "TYPHLC")
    str = hypothetical{Space}
Else if (key0 = "typlc" or key0 = "typlc;" or key0 = "TYPLC")
    str = typical{Space}
Else if (key0 = "tyvm" or key0 = "tyvm;" or key0 = "TYVM")
    str = thank you very much{Space}
Else if (key0 = "toaghc" or key0 = "toaghc;" or key0 = "TOAGHC")
    str = got you.{Space}
Else if (key0 = "tpah" or key0 = "tpah;" or key0 = "TPAH")
    str = path{Space}
Else if (key0 = "tsc" or key0 = "tsc;" or key0 = "TSC")
    str = society{Space}
Else if (key0 = "tslvm" or key0 = "tslvm;" or key0 = "TSLVM")
    str = themselves{Space}
Else if (key0 = "tuiasn" or key0 = "tuiasn;" or key0 = "TUIASN")
    str = sustain{Space}
Else if (key0 = "tuiosn" or key0 = "tuiosn;" or key0 = "TUIOSN")
    str = institution{Space}
Else if (key0 = "tuogh" or key0 = "tuogh;" or key0 = "TUOGH")
    str = thought{Space}
Else if (key0 = "tvn" or key0 = "tvn;" or key0 = "TVN")
    str = native{Space}
Else if (key0 = "tyic" or key0 = "tyic;" or key0 = "TYIC")
    str = city{Space}
Return

SENDY:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "yac" or key0 = "yac;" or key0 = "YAC")
    str = {BackSpace}acy{Space}
Else if (key0 = "yad" or key0 = "yad;" or key0 = "YAD")
    str = day{Space}
Else if (key0 = "yaslvn" or key0 = "yaslvn;" or key0 = "YASLVN")
    str = sylvan{Space}
Else if (key0 = "ydl" or key0 = "ydl;" or key0 = "YDL")
    str = yield{Space}
Else if (key0 = "yisl" or key0 = "yisl;" or key0 = "YISL")
    str = silly{Space}
Else if (key0 = "ysk" or key0 = "ysk;" or key0 = "YSK")
    str = sky{Space}
Else if (key0 = "yup" or key0 = "yup;" or key0 = "YUP")
    str = yup{Space}
Else if (key0 = "yugl" or key0 = "yugl;" or key0 = "YUGL")
    str = ugly{Space}
Else if (key0 = "tysg" or key0 = "tysg;" or key0 = "TYSG")
    str = staying{Space}
Else if (key0 = "eyagcn" or key0 = "eyagcn;" or key0 = "EYAGCN")
    str = agency{Space}
Else if (key0 = "yc" or key0 = "yc;" or key0 = "YC")
    str = {BackSpace}cy{Space}
Else if (key0 = "yadbn" or key0 = "yadbn;" or key0 = "YADBN")
    str = anybody{Space}
Else if (key0 = "ydgb" or key0 = "ydgb;" or key0 = "YDGB")
    str = goodbye{Space}
Else if (key0 = "ypg" or key0 = "ypg;" or key0 = "YPG")
    str = paying{Space}
Else if (key0 = "ydvn" or key0 = "ydvn;" or key0 = "YDVN")
    str = vineyard{Space}
Else if (key0 = "yalb" or key0 = "yalb;" or key0 = "YALB")
    str = {backspace}ably{Space}
Else if (key0 = "ycvn" or key0 = "ycvn;" or key0 = "YCVN")
    str = convey{Space}
Else if (key0 = "yfl" or key0 = "yfl;" or key0 = "YFL")
    str = fly{Space}
Else if (key0 = "yohl" or key0 = "yohl;" or key0 = "YOHL")
    str = holy{Space}
Else if (key0 = "yoph" or key0 = "yoph;" or key0 = "YOPH")
    str = hypo
Else if (key0 = "ysln" or key0 = "ysln;" or key0 = "YSLN")
    str = analysis{Space}
Else if (key0 = "yudb" or key0 = "yudb;" or key0 = "YUDB")
    str = buddy{Space}
Else if (key0 = "yusg" or key0 = "yusg;" or key0 = "YUSG")
    str = guys{Space}
Else if (key0 = "yab" or key0 = "yab;" or key0 = "YAB")
    str = baby{Space}
Else if (key0 = "yoglcn" or key0 = "yoglcn;" or key0 = "YOGLCN")
    str = oncology{Space}
Else if (key0 = "ypal" or key0 = "ypal;" or key0 = "YPAL")
    str = play{Space}
Else if (key0 = "ysnm" or key0 = "ysnm;" or key0 = "YSNM")
    str = mayonnaise{Space}
Else if (key0 = "yujl" or key0 = "yujl;" or key0 = "YUJL")
    str = July{Space}
Else if (key0 = "yopc" or key0 = "yopc;" or key0 = "YOPC")
    str = copy{Space}
Else if (key0 = "ypshcn" or key0 = "ypshcn;" or key0 = "YPSHCN")
    str = physician{Space}
Else if (key0 = "yam" or key0 = "yam;" or key0 = "YAM")
    str = may{Space}
Else if (key0 = "yglcn" or key0 = "yglcn;" or key0 = "YGLCN")
    str = oncology{Space}
Else if (key0 = "yoglcn" or key0 = "yoglcn;" or key0 = "YOGLCN")
    str = oncology{Space}
Else if (key0 = "ydbn" or key0 = "ydbn;" or key0 = "YDBN")
    str = beyond{Space}
Else if (key0 = "yif" or key0 = "yif;" or key0 = "YIF")
    str = {BackSpace}ify{Space}
Else if (key0 = "yoj" or key0 = "yoj;" or key0 = "YOJ")
    str = joy{Space}
Else if (key0 = "ypshlc" or key0 = "ypshlc;" or key0 = "YPSHLC")
    str = physical{Space}
Else if (key0 = "yan" or key0 = "yan;" or key0 = "YAN")
    str = any{Space}
Else if (key0 = "yanm" or key0 = "yanm;" or key0 = "YANM")
    str = many{Space}
Else if (key0 = "yas" or key0 = "yas;" or key0 = "YAS")
    str = say{Space}
Else if (key0 = "yasg" or key0 = "yasg;" or key0 = "YASG")
    str = saying{Space}
Else if (key0 = "yb" or key0 = "yb;" or key0 = "YB")
    str = by{Space}
Else if (key0 = "yd" or key0 = "yd;" or key0 = "YD")
    str = yesterday{Space}
Else if (key0 = "yfln" or key0 = "yfln;" or key0 = "YFLN")
    str = finally{Space}
Else if (key0 = "yiadl" or key0 = "yiadl;" or key0 = "YIADL")
    str = daily{Space}
Else if (key0 = "yiaflm" or key0 = "yiaflm;" or key0 = "YIAFLM")
    str = family{Space}
Else if (key0 = "yiasln" or key0 = "yiasln;" or key0 = "YIASLN")
    str = analysis{Space}
Else if (key0 = "yif" or key0 = "yif;" or key0 = "YIF")
    str = ify{Space}
Else if (key0 = "yil" or key0 = "yil;" or key0 = "YIL")
    str = {BackSpace}ily{Space}
Else if (key0 = "yk" or key0 = "yk;" or key0 = "YK")
    str = you know{Space}
Else if (key0 = "yl" or key0 = "yl;" or key0 = "YL")
    str = {BackSpace}ly{Space}
Else if (key0 = "ym" or key0 = "ym;" or key0 = "YM")
    str = my{Space}
Else if (key0 = "yoan" or key0 = "yoan;" or key0 = "YOAN")
    str = annoy{Space}
Else if (key0 = "yoanm" or key0 = "yoanm;" or key0 = "YOANM")
    str = anymore{Space}
Else if (key0 = "yob" or key0 = "yob;" or key0 = "YOB")
    str = boy{Space}
Else if (key0 = "yodb" or key0 = "yodb;" or key0 = "YODB")
    str = body{Space}
Else if (key0 = "yoln" or key0 = "yoln;" or key0 = "YOLN")
    str = only{Space}
Else if (key0 = "ypa" or key0 = "ypa;" or key0 = "YPA")
    str = pay{Space}
Else if (key0 = "ypah" or key0 = "ypah;" or key0 = "YPAH")
    str = happy{Space}
Else if (key0 = "ypal" or key0 = "ypal;" or key0 = "YPAL")
    str = play{Space}
Else if (key0 = "ypcm" or key0 = "ypcm;" or key0 = "YPCM")
    str = completely{Space}
Else if (key0 = "ysda" or key0 = "ysda;" or key0 = "YSDA")
    str = days{Space}
Else if (key0 = "ysg" or key0 = "ysg;" or key0 = "YSG")
    str = saying{Space}
Else if (key0 = "ysm" or key0 = "ysm;" or key0 = "YSM")
    str = sym
Else if (key0 = "ysn" or key0 = "ysn;" or key0 = "YSN")
    str = syn
Else if (key0 = "yuasl" or key0 = "yuasl;" or key0 = "YUASL")
    str = usually{Space}
Else if (key0 = "yub" or key0 = "yub;" or key0 = "YUB")
    str = buy{Space}
Else if (key0 = "yug" or key0 = "yug;" or key0 = "YUG")
    str = guy{Space}
Else if (key0 = "yuogn" or key0 = "yuogn;" or key0 = "YUOGN")
    str = young{Space}
Else if (key0 = "yal" or key0 = "yal;" or key0 = "YAL")
    str = lay{Space}
Else if (key0 = "yufn" or key0 = "yufn;" or key0 = "YUFN")
    str = funny{Space}
Else if (key0 = "yusb" or key0 = "yusb;" or key0 = "YUSB")
    str = busy{Space}
Return

SENDU:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "ua" or key0 = "ua;" or key0 = "UA")
    str = au
Else if (key0 = "uab" or key0 = "uab;" or key0 = "UAB")
    str = a bunch{Space}
Else if (key0 = "uion" or key0 = "uion;" or key0 = "UION")
    str = union{Space}
Else if (key0 = "uas" or key0 = "uas;" or key0 = "UAS")
    str = Australia{Space}
Else if (key0 = "uiosl" or key0 = "uiosl;" or key0 = "UIOSL")
    str = solution{Space}
Else if (key0 = "ukcb" or key0 = "ukcb;" or key0 = "UKCB")
    str = buck{Space}
Else if (key0 = "uoasfm" or key0 = "uoasfm;" or key0 = "UOASFM")
    str = famous{Space}
Else if (key0 = "uodbn" or key0 = "uodbn;" or key0 = "UODBN")
    str = bound{Space}
Else if (key0 = "uohc" or key0 = "uohc;" or key0 = "UOHC")
    str = ouch{Space}
Else if (key0 = "uosbn" or key0 = "uosbn;" or key0 = "UOSBN")
    str = bonus{Space}
Else if (key0 = "upsl" or key0 = "upsl;" or key0 = "UPSL")
    str = plus{Space}
Else if (key0 = "usdk" or key0 = "usdk;" or key0 = "USDK")
    str = dusk{Space}
Else if (key0 = "ush" or key0 = "ush;" or key0 = "USH")
    str = hush{Space}
Else if (key0 = "uskc" or key0 = "uskc;" or key0 = "USKC")
    str = suck{Space}
Else if (key0 = "uion" or key0 = "uion;" or key0 = "UION")
    str = union{Space}
Else if (key0 = "uiosl" or key0 = "uiosl;" or key0 = "UIOSL")
    str = solution{Space}
Else if (key0 = "ukcb" or key0 = "ukcb;" or key0 = "UKCB")
    str = buck{Space}
Else if (key0 = "uoasfm" or key0 = "uoasfm;" or key0 = "UOASFM")
    str = famous{Space}
Else if (key0 = "uodbn" or key0 = "uodbn;" or key0 = "UODBN")
    str = bound{Space}
Else if (key0 = "uohc" or key0 = "uohc;" or key0 = "UOHC")
    str = ouch{Space}
Else if (key0 = "uosbn" or key0 = "uosbn;" or key0 = "UOSBN")
    str = bonus{Space}
Else if (key0 = "upsl" or key0 = "upsl;" or key0 = "UPSL")
    str = plus{Space}
Else if (key0 = "uahnm" or key0 = "uahnm;" or key0 = "UAHNM")
    str = human{Space}
Else if (key0 = "uasdhbn" or key0 = "uasdhbn;" or key0 = "UASDHBN")
    str = husband{Space}
Else if (key0 = "uinm" or key0 = "uinm;" or key0 = "UINM")
    str = minimum{Space}
Else if (key0 = "uiolcn" or key0 = "uiolcn;" or key0 = "UIOLCN")
    str = council{Space}
Else if (key0 = "uodbn" or key0 = "uodbn;" or key0 = "UODBN")
    str = bound{Space}
Else if (key0 = "uodc" or key0 = "uodc;" or key0 = "UODC")
    str = docu
Else if (key0 = "uahlcn" or key0 = "uahlcn;" or key0 = "UAHLCN")
    str = launch{Space}
Else if (key0 = "uashbn" or key0 = "uashbn;" or key0 = "UASHBN")
    str = husband{Space}
Else if (key0 = "udh" or key0 = "udh;" or key0 = "UDH")
    str = duh{Space}
Else if (key0 = "ugn" or key0 = "ugn;" or key0 = "UGN")
    str = gun{Space}
Else if (key0 = "uhcbn" or key0 = "uhcbn;" or key0 = "UHCBN")
    str = bunch{Space}
Else if (key0 = "uioac" or key0 = "uioac;" or key0 = "UIOAC")
    str = caution{Space}
Else if (key0 = "upbm" or key0 = "upbm;" or key0 = "UPBM")
    str = bump{Space}
Else if (key0 = "uanm" or key0 = "uanm;" or key0 = "UANM")
    str = manu{Space}
Else if (key0 = "ufkc" or key0 = "ufkc;" or key0 = "UFKC")
    str = fuck{Space}
Else if (key0 = "uklc" or key0 = "uklc;" or key0 = "UKLC")
    str = luck{Space}
Else if (key0 = "uisdc" or key0 = "uisdc;" or key0 = "UISDC")
    str = discuss{Space}
Else if (key0 = "usg" or key0 = "usg;" or key0 = "USG")
    str = using{Space}
Else if (key0 = "usgn" or key0 = "usgn;" or key0 = "USGN")
    str = sung{Space}
Else if (key0 = "ualbm" or key0 = "ualbm;" or key0 = "UALBM")
    str = albums{Space}
Else if (key0 = "uiosl" or key0 = "uiosl;" or key0 = "UIOSL")
    str = solution{Space}
Else if (key0 = "uad" or key0 = "uad;" or key0 = "UAD")
    str = audience{Space}
Else if (key0 = "uag" or key0 = "uag;" or key0 = "UAG")
    str = aug{Space}
Else if (key0 = "uaghl" or key0 = "uaghl;" or key0 = "UAGHL")
    str = laugh{Space}
Else if (key0 = "uagl" or key0 = "uagl;" or key0 = "UAGL")
    str = laugh{Space}
Else if (key0 = "uahlcn" or key0 = "uahlcn;" or key0 = "UAHLCN")
    str = launch{Space}
Else if (key0 = "uasl" or key0 = "uasl;" or key0 = "UASL")
    str = usual{Space}
Else if (key0 = "ucm" or key0 = "ucm;" or key0 = "UCM")
    str = communicate{Space}
Else if (key0 = "ud" or key0 = "ud;" or key0 = "UD")
    str = you'd{Space}
Else if (key0 = "udn" or key0 = "udn;" or key0 = "UDN")
    str = understand{Space}
Else if (key0 = "ufl" or key0 = "ufl;" or key0 = "UFL")
    str = full{Space}
Else if (key0 = "uhcm" or key0 = "uhcm;" or key0 = "UHCM")
    str = much{Space}
Else if (key0 = "uicm" or key0 = "uicm;" or key0 = "UICM")
    str = communication{Space}
Else if (key0 = "uiocm" or key0 = "uiocm;" or key0 = "UIOCM")
    str = communication{Space}
Else if (key0 = "uidn" or key0 = "uidn;" or key0 = "UIDN")
    str = industry{Space}
Else if (key0 = "uin" or key0 = "uin;" or key0 = "UIN")
    str = uni
Else if (key0 = "uiofcn" or key0 = "uiofcn;" or key0 = "UIOFCN")
    str = function{Space}
Else if (key0 = "uios" or key0 = "uios;" or key0 = "UIOS")
    str = ious
Else if (key0 = "uioscn" or key0 = "uioscn;" or key0 = "UIOSCN")
    str = conscious{Space}
Else if (key0 = "uioslcn" or key0 = "uioslcn;" or key0 = "UIOSLCN")
    str = conclusion{Space}
Else if (key0 = "uipdl" or key0 = "uipdl;" or key0 = "UIPDL")
    str = dupli{Space}
Else if (key0 = "uiscm" or key0 = "uiscm;" or key0 = "UISCM")
    str = music{Space}
Else if (key0 = "uisn" or key0 = "uisn;" or key0 = "UISN")
    str = insurance{Space}
Else if (key0 = "uivn" or key0 = "uivn;" or key0 = "UIVN")
    str = university{Space}
Else if (key0 = "ul" or key0 = "ul;" or key0 = "UL")
    str = you'll{Space}
Else if (key0 = "un" or key0 = "un;" or key0 = "UN")
    str = un
Else if (key0 = "unm" or key0 = "unm;" or key0 = "UNM")
    str = number{Space}
Else if (key0 = "uo" or key0 = "uo;" or key0 = "UO")
    str = ou
Else if (key0 = "uodfn" or key0 = "uodfn;" or key0 = "UODFN")
    str = found{Space}
Else if (key0 = "uodl" or key0 = "uodl;" or key0 = "UODL")
    str = loud{Space}
Else if (key0 = "uodlc" or key0 = "uodlc;" or key0 = "UODLC")
    str = cloud{Space}
Else if (key0 = "uogh" or key0 = "uogh;" or key0 = "UOGH")
    str = ough{Space}
Else if (key0 = "uop" or key0 = "uop;" or key0 = "UOP")
    str = population{Space}
Else if (key0 = "uopn" or key0 = "uopn;" or key0 = "UOPN")
    str = upon{Space}
Else if (key0 = "uos" or key0 = "uos;" or key0 = "UOS")
    str = {BackSpace}ous{Space}
Else if (key0 = "uosdn" or key0 = "uosdn;" or key0 = "UOSDN")
    str = sound{Space}
Else if (key0 = "uosfc" or key0 = "uosfc;" or key0 = "UOSFC")
    str = focus{Space}
Else if (key0 = "uosm" or key0 = "uosm;" or key0 = "UOSM")
    str = so much{Space}
Else if (key0 = "up" or key0 = "up;" or key0 = "UP")
    str = up{Space}
Else if (key0 = "upascm" or key0 = "upascm;" or key0 = "UPASCM")
    str = campus{Space}
Else if (key0 = "upc" or key0 = "upc;" or key0 = "UPC")
    str = computer{Space}
Else if (key0 = "upjm" or key0 = "upjm;" or key0 = "UPJM")
    str = jump{Space}
Else if (key0 = "upl" or key0 = "upl;" or key0 = "UPL")
    str = pull{Space}
Else if (key0 = "upsh" or key0 = "upsh;" or key0 = "UPSH")
    str = push{Space}
Else if (key0 = "us" or key0 = "us;" or key0 = "US")
    str = us{Space}
Else if (key0 = "usb" or key0 = "usb;" or key0 = "USB")
    str = sub
Else if (key0 = "usf" or key0 = "usf;" or key0 = "USF")
    str = yourself{Space}
Else if (key0 = "ushc" or key0 = "ushc;" or key0 = "USHC")
    str = such{Space}
Else if (key0 = "usn" or key0 = "usn;" or key0 = "USN")
    str = sun{Space}
Else if (key0 = "uv" or key0 = "uv;" or key0 = "UV")
    str = you've{Space}
Else if (key0 = "udfn" or key0 = "udfn;" or key0 = "UDFN")
    str = fund{Space}
Else if (key0 = "ufn" or key0 = "ufn;" or key0 = "UFN")
    str = fun{Space}
Else if (key0 = "usfl" or key0 = "usfl;" or key0 = "USFL")
    str = yourself{Space}
Return

SENDE:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "ea" or key0 = "ea;" or key0 = "EA")
    str = ea
Else if (key0 = "epalcb" or key0 = "epalcb;" or key0 = "EPALCB")
    str = capable{Space}
Else if (key0 = "eashc" or key0 = "eashc;" or key0 = "EASHC")
    str = chase{Space}
Else if (key0 = "eashm" or key0 = "eashm;" or key0 = "EASHM")
    str = shame{Space}
Else if (key0 = "edlbn" or key0 = "edlbn;" or key0 = "EDLBN")
    str = blend{Space}
Else if (key0 = "eialxcm" or key0 = "eialxcm;" or key0 = "EIALXCM")
    str = exclaim{Space}
Else if (key0 = "eidcvn" or key0 = "eidcvn;" or key0 = "EIDCVN")
    str = evidence{Space}
Else if (key0 = "eidh" or key0 = "eidh;" or key0 = "EIDH")
    str = hide{Space}
Else if (key0 = "eidh" or key0 = "eidh;" or key0 = "EIDH")
    str = hide{Space}
Else if (key0 = "eidxn" or key0 = "eidxn;" or key0 = "EIDXN")
    str = index{Space}
Else if (key0 = "eipsc" or key0 = "eipsc;" or key0 = "EIPSC")
    str = spice{Space}
Else if (key0 = "eisdl" or key0 = "eisdl;" or key0 = "EISDL")
    str = slide{Space}
Else if (key0 = "eisghln" or key0 = "eisghln;" or key0 = "EISGHLN")
    str = english{Space}
Else if (key0 = "eoacn" or key0 = "eoacn;" or key0 = "EOACN")
    str = ocean{Space}
Else if (key0 = "eoacn" or key0 = "eoacn;" or key0 = "EOACN")
    str = ocean{Space}
Else if (key0 = "eohkc" or key0 = "eohkc;" or key0 = "EOHKC")
    str = choke{Space}
Else if (key0 = "eolvn" or key0 = "eolvn;" or key0 = "EOLVN")
    str = novel{Space}
Else if (key0 = "eopaslc" or key0 = "eopaslc;" or key0 = "EOPASLC")
    str = collapse{Space}
Else if (key0 = "eopm" or key0 = "eopm;" or key0 = "EOPM")
    str = poem{Space}
Else if (key0 = "eopscm" or key0 = "eopscm;" or key0 = "EOPSCM")
    str = compose{Space}
Else if (key0 = "eoshv" or key0 = "eoshv;" or key0 = "EOSHV")
    str = shove{Space}
Else if (key0 = "eovn" or key0 = "eovn;" or key0 = "EOVN")
    str = oven{Space}
Else if (key0 = "epadn" or key0 = "epadn;" or key0 = "EPADN")
    str = append{Space}
Else if (key0 = "epaln" or key0 = "epaln;" or key0 = "EPALN")
    str = plane{Space}
Else if (key0 = "epaslm" or key0 = "epaslm;" or key0 = "EPASLM")
    str = sample{Space}
Else if (key0 = "epl" or key0 = "epl;" or key0 = "EPL")
    str = peel{Space}
Else if (key0 = "epshl" or key0 = "epshl;" or key0 = "EPSHL")
    str = helps{Space}
Else if (key0 = "erd" or key0 = "erd;" or key0 = "ERD")
    str = red{Space}
Else if (key0 = "eriacm" or key0 = "eriacm;" or key0 = "ERIACM")
    str = america{Space}
Else if (key0 = "eriagnm" or key0 = "eriagnm;" or key0 = "ERIAGNM")
    str = migraine{Space}
Else if (key0 = "erid" or key0 = "erid;" or key0 = "ERID")
    str = ride{Space}
Else if (key0 = "eridcn" or key0 = "eridcn;" or key0 = "ERIDCN")
    str = discern{Space}
Else if (key0 = "eridn" or key0 = "eridn;" or key0 = "ERIDN")
    str = dinner{Space}
Else if (key0 = "erifgn" or key0 = "erifgn;" or key0 = "ERIFGN")
    str = finger{Space}
Else if (key0 = "eripz" or key0 = "eripz;" or key0 = "ERIPZ")
    str = prize{Space}
Else if (key0 = "eriscn" or key0 = "eriscn;" or key0 = "ERISCN")
    str = sincere{Space}
Else if (key0 = "erisdv" or key0 = "erisdv;" or key0 = "ERISDV")
    str = diverse{Space}
Else if (key0 = "erohc" or key0 = "erohc;" or key0 = "EROHC")
    str = chore{Space}
Else if (key0 = "erpsv" or key0 = "erpsv;" or key0 = "ERPSV")
    str = preserve{Space}
Else if (key0 = "ersfh" or key0 = "ersfh;" or key0 = "ERSFH")
    str = fresh{Space}
Else if (key0 = "ertab" or key0 = "ertab;" or key0 = "ERTAB")
    str = batter{Space}
Else if (key0 = "ertalc" or key0 = "ertalc;" or key0 = "ERTALC")
    str = accelerate{Space}
Else if (key0 = "ertalc" or key0 = "ertalc;" or key0 = "ERTALC")
    str = accelerate{Space}
Else if (key0 = "ertib" or key0 = "ertib;" or key0 = "ERTIB")
    str = tribe{Space}
Else if (key0 = "erticm" or key0 = "erticm;" or key0 = "ERTICM")
    str = metric{Space}
Else if (key0 = "erticn" or key0 = "erticn;" or key0 = "ERTICN")
    str = eccentric{Space}
Else if (key0 = "ertisn" or key0 = "ertisn;" or key0 = "ERTISN")
    str = insert{Space}
Else if (key0 = "ertlacn" or key0 = "ertlacn;" or key0 = "ERTLACN")
    str = central{Space}
Else if (key0 = "ertsc" or key0 = "ertsc;" or key0 = "ERTSC")
    str = secret{Space}
Else if (key0 = "ertshc" or key0 = "ertshc;" or key0 = "ERTSHC")
    str = stretch{Space}
Else if (key0 = "ertuac" or key0 = "ertuac;" or key0 = "ERTUAC")
    str = creature{Space}
Else if (key0 = "ertugl" or key0 = "ertugl;" or key0 = "ERTUGL")
    str = regulate{Space}
Else if (key0 = "ertuocn" or key0 = "ertuocn;" or key0 = "ERTUOCN")
    str = counter{Space}
Else if (key0 = "ertyab" or key0 = "ertyab;" or key0 = "ERTYAB")
    str = battery{Space}
Else if (key0 = "erug" or key0 = "erug;" or key0 = "ERUG")
    str = urge{Space}
Else if (key0 = "eruisc" or key0 = "eruisc;" or key0 = "ERUISC")
    str = cruise{Space}
Else if (key0 = "eruop" or key0 = "eruop;" or key0 = "ERUOP")
    str = europe{Space}
Else if (key0 = "erusm" or key0 = "erusm;" or key0 = "ERUSM")
    str = summer{Space}
Else if (key0 = "erypl" or key0 = "erypl;" or key0 = "ERYPL")
    str = reply{Space}
Else if (key0 = "esdk" or key0 = "esdk;" or key0 = "ESDK")
    str = desk{Space}
Else if (key0 = "etadgvn" or key0 = "etadgvn;" or key0 = "ETADGVN")
    str = advantage{Space}
Else if (key0 = "etag" or key0 = "etag;" or key0 = "ETAG")
    str = gate{Space}
Else if (key0 = "etahbn" or key0 = "etahbn;" or key0 = "ETAHBN")
    str = beneath{Space}
Else if (key0 = "etascn" or key0 = "etascn;" or key0 = "ETASCN")
    str = stance{Space}
Else if (key0 = "etdl" or key0 = "etdl;" or key0 = "ETDL")
    str = delete{Space}
Else if (key0 = "etiacn" or key0 = "etiacn;" or key0 = "ETIACN")
    str = ancient{Space}
Else if (key0 = "etiasgvn" or key0 = "etiasgvn;" or key0 = "ETIASGVN")
    str = investigate{Space}
Else if (key0 = "etiashlb" or key0 = "etiashlb;" or key0 = "ETIASHLB")
    str = establish{Space}
Else if (key0 = "etib" or key0 = "etib;" or key0 = "ETIB")
    str = bite{Space}
Else if (key0 = "etick" or key0 = "etick;" or key0 = "ETICK")
    str = ticket{Space}
Else if (key0 = "etid" or key0 = "etid;" or key0 = "ETID")
    str = diet{Space}
Else if (key0 = "etioasc" or key0 = "etioasc;" or key0 = "ETIOASC")
    str = associate{Space}
Else if (key0 = "etiopzmt" or key0 = "etiopzmt;" or key0 = "ETIOPZMT")
    str = optimize{Space}
Else if (key0 = "etiplnm" or key0 = "etiplnm;" or key0 = "ETIPLNM")
    str = implement{Space}
Else if (key0 = "etips" or key0 = "etips;" or key0 = "ETIPS")
    str = spite{Space}
Else if (key0 = "etipsd" or key0 = "etipsd;" or key0 = "ETIPSD")
    str = despite{Space}
Else if (key0 = "etlvn" or key0 = "etlvn;" or key0 = "ETLVN")
    str = evolution{Space}
Else if (key0 = "eto" or key0 = "eto;" or key0 = "ETO")
    str = toe{Space}
Else if (key0 = "etocm" or key0 = "etocm;" or key0 = "ETOCM")
    str = comet{Space}
Else if (key0 = "etodhm" or key0 = "etodhm;" or key0 = "ETODHM")
    str = method{Space}
Else if (key0 = "etpdh" or key0 = "etpdh;" or key0 = "ETPDH")
    str = depth{Space}
Else if (key0 = "etpdh" or key0 = "etpdh;" or key0 = "ETPDH")
    str = depth{Space}
Else if (key0 = "etshkc" or key0 = "etshkc;" or key0 = "ETSHKC")
    str = sketch{Space}
Else if (key0 = "etualc" or key0 = "etualc;" or key0 = "ETUALC")
    str = calculate{Space}
Else if (key0 = "etuin" or key0 = "etuin;" or key0 = "ETUIN")
    str = unite{Space}
Else if (key0 = "euagl" or key0 = "euagl;" or key0 = "EUAGL")
    str = league{Space}
Else if (key0 = "euosm" or key0 = "euosm;" or key0 = "EUOSM")
    str = mouse{Space}
Else if (key0 = "eupgln" or key0 = "eupgln;" or key0 = "EUPGLN")
    str = plunge{Space}
Else if (key0 = "eyidl" or key0 = "eyidl;" or key0 = "EYIDL")
    str = yield{Space}
Else if (key0 = "eyoplm" or key0 = "eyoplm;" or key0 = "EYOPLM")
    str = employ{Space}
Else if (key0 = "eyplm" or key0 = "eyplm;" or key0 = "EYPLM")
    str = employ{Space}
Else if (key0 = "edhl" or key0 = "edhl;" or key0 = "EDHL")
    str = held{Space}
Else if (key0 = "eriv" or key0 = "eriv;" or key0 = "ERIV")
    str = river{Space}
Else if (key0 = "eruipm" or key0 = "eruipm;" or key0 = "ERUIPM")
    str = premium{Space}
Else if (key0 = "etf" or key0 = "etf;" or key0 = "ETF")
    str = feet{Space}
Else if (key0 = "eri" or key0 = "eri;" or key0 = "ERI")
    str = {BackSpace}ier{Space}
Else if (key0 = "ertypah" or key0 = "ertypah;" or key0 = "ERTYPAH")
    str = therapy{Space}
Else if (key0 = "eriacm" or key0 = "eriacm;" or key0 = "ERIACM")
    str = America{Space}
Else if (key0 = "eruop" or key0 = "eruop;" or key0 = "ERUOP")
    str = Europe{Space}
Else if (key0 = "eosln" or key0 = "eosln;" or key0 = "EOSLN")
    str = lesson{Space}
Else if (key0 = "epaln" or key0 = "epaln;" or key0 = "EPALN")
    str = plane{Space}
Else if (key0 = "ealcn" or key0 = "ealcn;" or key0 = "EALCN")
    str = cancel{Space}
Else if (key0 = "epaslc" or key0 = "epaslc;" or key0 = "EPASLC")
    str = places{Space}
Else if (key0 = "ealn" or key0 = "ealn;" or key0 = "EALN")
    str = lane{Space}
Else if (key0 = "etpasln" or key0 = "etpasln;" or key0 = "ETPASLN")
    str = pleasant{Space}
Else if (key0 = "eas" or key0 = "eas;" or key0 = "EAS")
    str = assess{Space}
Else if (key0 = "eruips" or key0 = "eruips;" or key0 = "ERUIPS")
    str = surprise{Space}
Else if (key0 = "easf" or key0 = "easf;" or key0 = "EASF")
    str = safe{Space}
Else if (key0 = "efhc" or key0 = "efhc;" or key0 = "EFHC")
    str = chef{Space}
Else if (key0 = "erualcn" or key0 = "erualcn;" or key0 = "ERUALCN")
    str = nuclear{Space}
Else if (key0 = "eialv" or key0 = "eialv;" or key0 = "EIALV")
    str = alive{Space}
Else if (key0 = "eyiasl" or key0 = "eyiasl;" or key0 = "EYIASL")
    str = easily{Space}
Else if (key0 = "eiasn" or key0 = "eiasn;" or key0 = "EIASN")
    str = insane{Space}
Else if (key0 = "eifkn" or key0 = "eifkn;" or key0 = "EIFKN")
    str = knife{Space}
Else if (key0 = "eihcn" or key0 = "eihcn;" or key0 = "EIHCN")
    str = niche{Space}
Else if (key0 = "eihk" or key0 = "eihk;" or key0 = "EIHK")
    str = hike{Space}
Else if (key0 = "eil" or key0 = "eil;" or key0 = "EIL")
    str = lie{Space}
Else if (key0 = "eilcn" or key0 = "eilcn;" or key0 = "EILCN")
    str = incline{Space}
Else if (key0 = "eiocnm" or key0 = "eiocnm;" or key0 = "EIOCNM")
    str = economic{Space}
Else if (key0 = "eiocnm" or key0 = "eiocnm;" or key0 = "EIOCNM")
    str = income{Space}
Else if (key0 = "eiplcn" or key0 = "eiplcn;" or key0 = "EIPLCN")
    str = pencil{Space}
Else if (key0 = "eisdl" or key0 = "eisdl;" or key0 = "EISDL")
    str = slide{Space}
Else if (key0 = "eiskvn" or key0 = "eiskvn;" or key0 = "EISKVN")
    str = knives{Space}
Else if (key0 = "eislm" or key0 = "eislm;" or key0 = "EISLM")
    str = smile{Space}
Else if (key0 = "eisz" or key0 = "eisz;" or key0 = "EISZ")
    str = seize{Space}
Else if (key0 = "ekn" or key0 = "ekn;" or key0 = "EKN")
    str = knee{Space}
Else if (key0 = "elb" or key0 = "elb;" or key0 = "ELB")
    str = bell{Space}
Else if (key0 = "eoadb" or key0 = "eoadb;" or key0 = "EOADB")
    str = Adobe{Space}
Else if (key0 = "eoaslm" or key0 = "eoaslm;" or key0 = "EOASLM")
    str = molasses{Space}
Else if (key0 = "eofc" or key0 = "eofc;" or key0 = "EOFC")
    str = coffee{Space}
Else if (key0 = "eosdcn" or key0 = "eosdcn;" or key0 = "EOSDCN")
    str = condense{Space}
Else if (key0 = "eosln" or key0 = "eosln;" or key0 = "EOSLN")
    str = lesson{Space}
Else if (key0 = "eosn" or key0 = "eosn;" or key0 = "EOSN")
    str = nose{Space}
Else if (key0 = "epa" or key0 = "epa;" or key0 = "EPA")
    str = ape{Space}
Else if (key0 = "epn" or key0 = "epn;" or key0 = "EPN")
    str = pen{Space}
Else if (key0 = "epsl" or key0 = "epsl;" or key0 = "EPSL")
    str = spell{Space}
Else if (key0 = "erab" or key0 = "erab;" or key0 = "ERAB")
    str = bear{Space}
Else if (key0 = "eradg" or key0 = "eradg;" or key0 = "ERADG")
    str = regard{Space}
Else if (key0 = "eradlc" or key0 = "eradlc;" or key0 = "ERADLC")
    str = declare{Space}
Else if (key0 = "eraf" or key0 = "eraf;" or key0 = "ERAF")
    str = fear{Space}
Else if (key0 = "eraf" or key0 = "eraf;" or key0 = "ERAF")
    str = fear{Space}
Else if (key0 = "eralx" or key0 = "eralx;" or key0 = "ERALX")
    str = relax{Space}
Else if (key0 = "eras" or key0 = "eras;" or key0 = "ERAS")
    str = erase{Space}
Else if (key0 = "erdcbm" or key0 = "erdcbm;" or key0 = "ERDCBM")
    str = December{Space}
Else if (key0 = "erf" or key0 = "erf;" or key0 = "ERF")
    str = free{Space}
Else if (key0 = "erhc" or key0 = "erhc;" or key0 = "ERHC")
    str = cheer{Space}
Else if (key0 = "erias" or key0 = "erias;" or key0 = "ERIAS")
    str = raise{Space}
Else if (key0 = "eridb" or key0 = "eridb;" or key0 = "ERIDB")
    str = bride{Space}
Else if (key0 = "eridgb" or key0 = "eridgb;" or key0 = "ERIDGB")
    str = bridge{Space}
Else if (key0 = "eridl" or key0 = "eridl;" or key0 = "ERIDL")
    str = riddle{Space}
Else if (key0 = "erin" or key0 = "erin;" or key0 = "ERIN")
    str = inner{Space}
Else if (key0 = "eriopscm" or key0 = "eriopscm;" or key0 = "ERIOPSCM")
    str = comprise{Space}
Else if (key0 = "eripscb" or key0 = "eripscb;" or key0 = "ERIPSCB")
    str = prescribe{Space}
Else if (key0 = "erm" or key0 = "erm;" or key0 = "ERM")
    str = mere{Space}
Else if (key0 = "ero" or key0 = "ero;" or key0 = "ERO")
    str = error{Space}
Else if (key0 = "eroash" or key0 = "eroash;" or key0 = "EROASH")
    str = hoarse{Space}
Else if (key0 = "erocm" or key0 = "erocm;" or key0 = "EROCM")
    str = commerce{Space}
Else if (key0 = "erokb" or key0 = "erokb;" or key0 = "EROKB")
    str = broke{Space}
Else if (key0 = "eros" or key0 = "eros;" or key0 = "EROS")
    str = rose{Space}
Else if (key0 = "eroscn" or key0 = "eroscn;" or key0 = "EROSCN")
    str = censor{Space}
Else if (key0 = "erovbnm" or key0 = "erovbnm;" or key0 = "EROVBNM")
    str = November{Space}
Else if (key0 = "erpas" or key0 = "erpas;" or key0 = "ERPAS")
    str = spare{Space}
Else if (key0 = "ertag" or key0 = "ertag;" or key0 = "ERTAG")
    str = target{Space}
Else if (key0 = "ertagn" or key0 = "ertagn;" or key0 = "ERTAGN")
    str = generate{Space}
Else if (key0 = "ertiacn" or key0 = "ertiacn;" or key0 = "ERTIACN")
    str = interact{Space}
Else if (key0 = "ertiagc" or key0 = "ertiagc;" or key0 = "ERTIAGC")
    str = cigarette{Space}
Else if (key0 = "ertihn" or key0 = "ertihn;" or key0 = "ERTIHN")
    str = inherent{Space}
Else if (key0 = "ertion" or key0 = "ertion;" or key0 = "ERTION")
    str = orient{Space}
Else if (key0 = "ertipac" or key0 = "ertipac;" or key0 = "ERTIPAC")
    str = practice{Space}
Else if (key0 = "ertoa" or key0 = "ertoa;" or key0 = "ERTOA")
    str = rotate{Space}
Else if (key0 = "ertocb" or key0 = "ertocb;" or key0 = "ERTOCB")
    str = October{Space}
Else if (key0 = "ertosk" or key0 = "ertosk;" or key0 = "ERTOSK")
    str = stroke{Space}
Else if (key0 = "ertpsbm" or key0 = "ertpsbm;" or key0 = "ERTPSBM")
    str = September{Space}
Else if (key0 = "ertuanm" or key0 = "ertuanm;" or key0 = "ERTUANM")
    str = remunerate{Space}
Else if (key0 = "ertycm" or key0 = "ertycm;" or key0 = "ERTYCM")
    str = cemetery{Space}
Else if (key0 = "ertyop" or key0 = "ertyop;" or key0 = "ERTYOP")
    str = property{Space}
Else if (key0 = "erud" or key0 = "erud;" or key0 = "ERUD")
    str = educator{Space}
Else if (key0 = "erudbn" or key0 = "erudbn;" or key0 = "ERUDBN")
    str = burden{Space}
Else if (key0 = "eruin" or key0 = "eruin;" or key0 = "ERUIN")
    str = urine{Space}
Else if (key0 = "eruopcn" or key0 = "eruopcn;" or key0 = "ERUOPCN")
    str = pronounce{Space}
Else if (key0 = "erusc" or key0 = "erusc;" or key0 = "ERUSC")
    str = rescue{Space}
Else if (key0 = "eruvn" or key0 = "eruvn;" or key0 = "ERUVN")
    str = revenue{Space}
Else if (key0 = "eryoasc" or key0 = "eryoasc;" or key0 = "ERYOASC")
    str = accessory{Space}
Else if (key0 = "eshcm" or key0 = "eshcm;" or key0 = "ESHCM")
    str = scheme{Space}
Else if (key0 = "eslm" or key0 = "eslm;" or key0 = "ESLM")
    str = smell{Space}
Else if (key0 = "etadn" or key0 = "etadn;" or key0 = "ETADN")
    str = attend{Space}
Else if (key0 = "etagn" or key0 = "etagn;" or key0 = "ETAGN")
    str = agent{Space}
Else if (key0 = "etagn" or key0 = "etagn;" or key0 = "ETAGN")
    str = tangent{Space}
Else if (key0 = "etaln" or key0 = "etaln;" or key0 = "ETALN")
    str = talent{Space}
Else if (key0 = "etanm" or key0 = "etanm;" or key0 = "ETANM")
    str = meant{Space}
Else if (key0 = "etask" or key0 = "etask;" or key0 = "ETASK")
    str = stake{Space}
Else if (key0 = "etghln" or key0 = "etghln;" or key0 = "ETGHLN")
    str = length{Space}
Else if (key0 = "etiahlcn" or key0 = "etiahlcn;" or key0 = "ETIAHLCN")
    str = technical{Space}
Else if (key0 = "etioanm" or key0 = "etioanm;" or key0 = "ETIOANM")
    str = nominate{Space}
Else if (key0 = "etiosn" or key0 = "etiosn;" or key0 = "ETIOSN")
    str = tension{Space}
Else if (key0 = "etiosn" or key0 = "etiosn;" or key0 = "ETIOSN")
    str = tension{Space}
Else if (key0 = "etolb" or key0 = "etolb;" or key0 = "ETOLB")
    str = bottle{Space}
Else if (key0 = "etolb" or key0 = "etolb;" or key0 = "ETOLB")
    str = bottle{Space}
Else if (key0 = "etoshlc" or key0 = "etoshlc;" or key0 = "ETOSHLC")
    str = clothes{Space}
Else if (key0 = "etpal" or key0 = "etpal;" or key0 = "ETPAL")
    str = plate{Space}
Else if (key0 = "etpasc" or key0 = "etpasc;" or key0 = "ETPASC")
    str = aspect{Space}
Else if (key0 = "etps" or key0 = "etps;" or key0 = "ETPS")
    str = steep{Space}
Else if (key0 = "etscn" or key0 = "etscn;" or key0 = "ETSCN")
    str = sentence{Space}
Else if (key0 = "etub" or key0 = "etub;" or key0 = "ETUB")
    str = tube{Space}
Else if (key0 = "etuhc" or key0 = "etuhc;" or key0 = "ETUHC")
    str = chute{Space}
Else if (key0 = "etum" or key0 = "etum;" or key0 = "ETUM")
    str = mute{Space}
Else if (key0 = "etuocm" or key0 = "etuocm;" or key0 = "ETUOCM")
    str = outcome{Space}
Else if (key0 = "etups" or key0 = "etups;" or key0 = "ETUPS")
    str = upset{Space}
Else if (key0 = "etyoscm" or key0 = "etyoscm;" or key0 = "ETYOSCM")
    str = ecosystem{Space}
Else if (key0 = "eudgj" or key0 = "eudgj;" or key0 = "EUDGJ")
    str = judge{Space}
Else if (key0 = "eudgn" or key0 = "eudgn;" or key0 = "EUDGN")
    str = nudge{Space}
Else if (key0 = "eujn" or key0 = "eujn;" or key0 = "EUJN")
    str = June{Space}
Else if (key0 = "eupsl" or key0 = "eupsl;" or key0 = "EUPSL")
    str = pulse{Space}
Else if (key0 = "eyagcn" or key0 = "eyagcn;" or key0 = "EYAGCN")
    str = agency{Space}
Else if (key0 = "eyp" or key0 = "eyp;" or key0 = "EYP")
    str = yep{Space}
Else if (key0 = "rtyl" or key0 = "rtyl;" or key0 = "RTYL")
    str = reality{Space}
Else if (key0 = "etanm" or key0 = "etanm;" or key0 = "ETANM")
    str = meant{Space}
Else if (key0 = "easn" or key0 = "easn;" or key0 = "EASN")
    str = sane{Space}
Else if (key0 = "eiasn" or key0 = "eiasn;" or key0 = "EIASN")
    str = insane{Space}
Else if (key0 = "epsd" or key0 = "epsd;" or key0 = "EPSD")
    str = sped{Space}
Else if (key0 = "ec" or key0 = "ec;" or key0 = "EC")
    str = {BackSpace}{BackSpace}ce{Space}
Else if (key0 = "etun" or key0 = "etun;" or key0 = "ETUN")
    str = tune{Space}
Else if (key0 = "erofc" or key0 = "erofc;" or key0 = "EROFC")
    str = force{Space}
Else if (key0 = "etioasc" or key0 = "etioasc;" or key0 = "ETIOASC")
    str = associate{Space}
Else if (key0 = "eionm" or key0 = "eionm;" or key0 = "EIONM")
    str = mention{Space}
Else if (key0 = "eyh" or key0 = "eyh;" or key0 = "EYH")
    str = hey{Space}
Else if (key0 = "eyp" or key0 = "eyp;" or key0 = "EYP")
    str = yep{Space}
Else if (key0 = "eodcnm" or key0 = "eodcnm;" or key0 = "EODCNM")
    str = commend{Space}
Else if (key0 = "etisn" or key0 = "etisn;" or key0 = "ETISN")
    str = intense{Space}
Else if (key0 = "eruios" or key0 = "eruios;" or key0 = "ERUIOS")
    str = serious{Space}
Else if (key0 = "eualvb" or key0 = "eualvb;" or key0 = "EUALVB")
    str = valuable{Space}
Else if (key0 = "etiagvn" or key0 = "etiagvn;" or key0 = "ETIAGVN")
    str = navigate{Space}
Else if (key0 = "erasc" or key0 = "erasc;" or key0 = "ERASC")
    str = scare{Space}
Else if (key0 = "ertom" or key0 = "ertom;" or key0 = "ERTOM")
    str = remote{Space}
Else if (key0 = "ertlxn" or key0 = "ertlxn;" or key0 = "ERTLXN")
    str = internal{Space}
Else if (key0 = "eropsc" or key0 = "eropsc;" or key0 = "EROPSC")
    str = process{Space}
Else if (key0 = "eacbm" or key0 = "eacbm;" or key0 = "EACBM")
    str = became{Space}
Else if (key0 = "eaghlcn" or key0 = "eaghlcn;" or key0 = "EAGHLCN")
    str = challenge{Space}
Else if (key0 = "etakn" or key0 = "etakn;" or key0 = "ETAKN")
    str = taken{Space}
Else if (key0 = "etpam" or key0 = "etpam;" or key0 = "ETPAM")
    str = attempt{Space}
Else if (key0 = "eivn" or key0 = "eivn;" or key0 = "EIVN")
    str = vein{Space}
Else if (key0 = "erpash" or key0 = "erpash;" or key0 = "ERPASH")
    str = phrase{Space}
Else if (key0 = "ertpasn" or key0 = "ertpasn;" or key0 = "ERTPASN")
    str = transparent{Space}
Else if (key0 = "ead" or key0 = "ead;" or key0 = "EAD")
    str = dead{Space}
Else if (key0 = "eadhln" or key0 = "eadhln;" or key0 = "EADHLN")
    str = handle{Space}
Else if (key0 = "eagbn" or key0 = "eagbn;" or key0 = "EAGBN")
    str = began{Space}
Else if (key0 = "eashk" or key0 = "eashk;" or key0 = "EASHK")
    str = shake{Space}
Else if (key0 = "edcvn" or key0 = "edcvn;" or key0 = "EDCVN")
    str = evidence{Space}
Else if (key0 = "eiasd" or key0 = "eiasd;" or key0 = "EIASD")
    str = disease{Space}
Else if (key0 = "eiasl" or key0 = "eiasl;" or key0 = "EIASL")
    str = aisle{Space}
Else if (key0 = "eihlcv" or key0 = "eihlcv;" or key0 = "EIHLCV")
    str = vehicle{Space}
Else if (key0 = "eilm" or key0 = "eilm;" or key0 = "EILM")
    str = mile{Space}
Else if (key0 = "eiom" or key0 = "eiom;" or key0 = "EIOM")
    str = emotion{Space}
Else if (key0 = "eisdn" or key0 = "eisdn;" or key0 = "EISDN")
    str = inside{Space}
Else if (key0 = "eishn" or key0 = "eishn;" or key0 = "EISHN")
    str = shine{Space}
Else if (key0 = "eislcn" or key0 = "eislcn;" or key0 = "EISLCN")
    str = silence{Space}
Else if (key0 = "eakl" or key0 = "eakl;" or key0 = "EAKL")
    str = lake{Space}
Else if (key0 = "eoaln" or key0 = "eoaln;" or key0 = "EOALN")
    str = alone{Space}
Else if (key0 = "eocvn" or key0 = "eocvn;" or key0 = "EOCVN")
    str = convene{Space}
Else if (key0 = "eodgl" or key0 = "eodgl;" or key0 = "EODGL")
    str = lodge{Space}
Else if (key0 = "eolcn" or key0 = "eolcn;" or key0 = "EOLCN")
    str = clone{Space}
Else if (key0 = "eolnm" or key0 = "eolnm;" or key0 = "EOLNM")
    str = lemon{Space}
Else if (key0 = "eolnm" or key0 = "eolnm;" or key0 = "EOLNM")
    str = melon{Space}
Else if (key0 = "eopk" or key0 = "eopk;" or key0 = "EOPK")
    str = poke{Space}
Else if (key0 = "eoslv" or key0 = "eoslv;" or key0 = "EOSLV")
    str = solve{Space}
Else if (key0 = "eoslv" or key0 = "eoslv;" or key0 = "EOSLV")
    str = solve{Space}
Else if (key0 = "epahc" or key0 = "epahc;" or key0 = "EPAHC")
    str = cheap{Space}
Else if (key0 = "eradg" or key0 = "eradg;" or key0 = "ERADG")
    str = grade{Space}
Else if (key0 = "erafm" or key0 = "erafm;" or key0 = "ERAFM")
    str = frame{Space}
Else if (key0 = "eraghc" or key0 = "eraghc;" or key0 = "ERAGHC")
    str = charge{Space}
Else if (key0 = "eragnm" or key0 = "eragnm;" or key0 = "ERAGNM")
    str = manager{Space}
Else if (key0 = "erc" or key0 = "erc;" or key0 = "ERC")
    str = rec recognize{Space}
Else if (key0 = "erdh" or key0 = "erdh;" or key0 = "ERDH")
    str = herd{Space}
Else if (key0 = "ergcnm" or key0 = "ergcnm;" or key0 = "ERGCNM")
    str = emergency{Space}
Else if (key0 = "ergm" or key0 = "ergm;" or key0 = "ERGM")
    str = merge{Space}
Else if (key0 = "erial" or key0 = "erial;" or key0 = "ERIAL")
    str = earlier{Space}
Else if (key0 = "erialcm" or key0 = "erialcm;" or key0 = "ERIALCM")
    str = miracle{Space}
Else if (key0 = "erif" or key0 = "erif;" or key0 = "ERIF")
    str = fire{Space}
Else if (key0 = "eriosn" or key0 = "eriosn;" or key0 = "ERIOSN")
    str = senior{Space}
Else if (key0 = "eripl" or key0 = "eripl;" or key0 = "ERIPL")
    str = ripple{Space}
Else if (key0 = "eriplcn" or key0 = "eriplcn;" or key0 = "ERIPLCN")
    str = principle{Space}
Else if (key0 = "eripsn" or key0 = "eripsn;" or key0 = "ERIPSN")
    str = inspire{Space}
Else if (key0 = "erlv" or key0 = "erlv;" or key0 = "ERLV")
    str = lever{Space}
Else if (key0 = "ern" or key0 = "ern;" or key0 = "ERN")
    str = {backspace}ern{Space}
Else if (key0 = "eroc" or key0 = "eroc;" or key0 = "EROC")
    str = core{Space}
Else if (key0 = "eroc" or key0 = "eroc;" or key0 = "EROC")
    str = core{Space}
Else if (key0 = "eroh" or key0 = "eroh;" or key0 = "EROH")
    str = hero{Space}
Else if (key0 = "erohl" or key0 = "erohl;" or key0 = "EROHL")
    str = holler{Space}
Else if (key0 = "erosc" or key0 = "erosc;" or key0 = "EROSC")
    str = score{Space}
Else if (key0 = "eroslc" or key0 = "eroslc;" or key0 = "EROSLC")
    str = closer{Space}
Else if (key0 = "erta" or key0 = "erta;" or key0 = "ERTA")
    str = tear{Space}
Else if (key0 = "ertad" or key0 = "ertad;" or key0 = "ERTAD")
    str = trade{Space}
Else if (key0 = "ertd" or key0 = "ertd;" or key0 = "ERTD")
    str = editor{Space}
Else if (key0 = "ertihn" or key0 = "ertihn;" or key0 = "ERTIHN")
    str = neither{Space}
Else if (key0 = "ertilc" or key0 = "ertilc;" or key0 = "ERTILC")
    str = electric{Space}
Else if (key0 = "ertiod" or key0 = "ertiod;" or key0 = "ERTIOD")
    str = editor{Space}
Else if (key0 = "ertipac" or key0 = "ertipac;" or key0 = "ERTIPAC")
    str = practice{Space}
Else if (key0 = "ertish" or key0 = "ertish;" or key0 = "ERTISH")
    str = theirs{Space}
Else if (key0 = "ertjc" or key0 = "ertjc;" or key0 = "ERTJC")
    str = reject{Space}
Else if (key0 = "ertlc" or key0 = "ertlc;" or key0 = "ERTLC")
    str = electric{Space}
Else if (key0 = "ertofgn" or key0 = "ertofgn;" or key0 = "ERTOFGN")
    str = forgotten{Space}
Else if (key0 = "ertpvn" or key0 = "ertpvn;" or key0 = "ERTPVN")
    str = prevent{Space}
Else if (key0 = "ertuic" or key0 = "ertuic;" or key0 = "ERTUIC")
    str = recruit{Space}
Else if (key0 = "ertul" or key0 = "ertul;" or key0 = "ERTUL")
    str = turtle{Space}
Else if (key0 = "ertun" or key0 = "ertun;" or key0 = "ERTUN")
    str = return{Space}
Else if (key0 = "ertuo" or key0 = "ertuo;" or key0 = "ERTUO")
    str = route{Space}
Else if (key0 = "eruag" or key0 = "eruag;" or key0 = "ERUAG")
    str = argue{Space}
Else if (key0 = "eruas" or key0 = "eruas;" or key0 = "ERUAS")
    str = assure{Space}
Else if (key0 = "erubm" or key0 = "erubm;" or key0 = "ERUBM")
    str = bummer{Space}
Else if (key0 = "eruoslcn" or key0 = "eruoslcn;" or key0 = "ERUOSLCN")
    str = counselor{Space}
Else if (key0 = "eruosvn" or key0 = "eruosvn;" or key0 = "ERUOSVN")
    str = nervous{Space}
Else if (key0 = "erusn" or key0 = "erusn;" or key0 = "ERUSN")
    str = nurse{Space}
Else if (key0 = "eshl" or key0 = "eshl;" or key0 = "ESHL")
    str = shell{Space}
Else if (key0 = "etas" or key0 = "etas;" or key0 = "ETAS")
    str = state{Space}
Else if (key0 = "etb" or key0 = "etb;" or key0 = "ETB")
    str = bet{Space}
Else if (key0 = "etb" or key0 = "etb;" or key0 = "ETB")
    str = bet{Space}
Else if (key0 = "etdn" or key0 = "etdn;" or key0 = "ETDN")
    str = tend{Space}
Else if (key0 = "etfcn" or key0 = "etfcn;" or key0 = "ETFCN")
    str = efficient{Space}
Else if (key0 = "etfcn" or key0 = "etfcn;" or key0 = "ETFCN")
    str = efficient{Space}
Else if (key0 = "etihkcn" or key0 = "etihkcn;" or key0 = "ETIHKCN")
    str = kitchen{Space}
Else if (key0 = "etion" or key0 = "etion;" or key0 = "ETION")
    str = intention{Space}
Else if (key0 = "etionm" or key0 = "etionm;" or key0 = "ETIONM")
    str = emotion{Space}
Else if (key0 = "etipdn" or key0 = "etipdn;" or key0 = "ETIPDN")
    str = independent{Space}
Else if (key0 = "etisln" or key0 = "etisln;" or key0 = "ETISLN")
    str = nationalities{Space}
Else if (key0 = "etlvt" or key0 = "etlvt;" or key0 = "ETLVT")
    str = evaluate{Space}
Else if (key0 = "etop" or key0 = "etop;" or key0 = "ETOP")
    str = poet{Space}
Else if (key0 = "etpaln" or key0 = "etpaln;" or key0 = "ETPALN")
    str = planet{Space}
Else if (key0 = "etpxm" or key0 = "etpxm;" or key0 = "ETPXM")
    str = exempt{Space}
Else if (key0 = "etsg" or key0 = "etsg;" or key0 = "ETSG")
    str = setting{Space}
Else if (key0 = "etsg" or key0 = "etsg;" or key0 = "ETSG")
    str = gets{Space}
Else if (key0 = "etsln" or key0 = "etsln;" or key0 = "ETSLN")
    str = essential{Space}
Else if (key0 = "etualv" or key0 = "etualv;" or key0 = "ETUALV")
    str = evaluate{Space}
Else if (key0 = "etuascbn" or key0 = "etuascbn;" or key0 = "ETUASCBN")
    str = substance{Space}
Else if (key0 = "etuisn" or key0 = "etuisn;" or key0 = "ETUISN")
    str = institute{Space}
Else if (key0 = "etypln" or key0 = "etypln;" or key0 = "ETYPLN")
    str = plenty{Space}
Else if (key0 = "euag" or key0 = "euag;" or key0 = "EUAG")
    str = gauge{Space}
Else if (key0 = "euagv" or key0 = "euagv;" or key0 = "EUAGV")
    str = vague{Space}
Else if (key0 = "euasb" or key0 = "euasb;" or key0 = "EUASB")
    str = abuse{Space}
Else if (key0 = "euh" or key0 = "euh;" or key0 = "EUH")
    str = hue{Space}
Else if (key0 = "euiflcn" or key0 = "euiflcn;" or key0 = "EUIFLCN")
    str = influence{Space}
Else if (key0 = "euisdc" or key0 = "euisdc;" or key0 = "EUISDC")
    str = suicide{Space}
Else if (key0 = "euoslcn" or key0 = "euoslcn;" or key0 = "EUOSLCN")
    str = counsel{Space}
Else if (key0 = "eupdl" or key0 = "eupdl;" or key0 = "EUPDL")
    str = puddle{Space}
Else if (key0 = "ey" or key0 = "ey;" or key0 = "EY")
    str = eye{Space}
Else if (key0 = "eyadl" or key0 = "eyadl;" or key0 = "EYADL")
    str = delay{Space}
Else if (key0 = "eyiafc" or key0 = "eyiafc;" or key0 = "EYIAFC")
    str = efficacy{Space}
Else if (key0 = "eyl" or key0 = "eyl;" or key0 = "EYL")
    str = yell{Space}
Else if (key0 = "eyocvn" or key0 = "eyocvn;" or key0 = "EYOCVN")
    str = convey{Space}
Else if (key0 = "erpisn" or key0 = "erpisn;" or key0 = "ERPISN")
    str = inspire{Space}
Else if (key0 = "eopsk" or key0 = "eopsk;" or key0 = "EOPSK")
    str = spoke{Space}
Else if (key0 = "epal" or key0 = "epal;" or key0 = "EPAL")
    str = leap{Space}
Else if (key0 = "epdxn" or key0 = "epdxn;" or key0 = "EPDXN")
    str = expend{Space}
Else if (key0 = "eriav" or key0 = "eriav;" or key0 = "ERIAV")
    str = arrive{Space}
Else if (key0 = "erop" or key0 = "erop;" or key0 = "EROP")
    str = proper{Space}
Else if (key0 = "erpdc" or key0 = "erpdc;" or key0 = "ERPDC")
    str = deprec{Space}
Else if (key0 = "ertipn" or key0 = "ertipn;" or key0 = "ERTIPN")
    str = interpret{Space}
Else if (key0 = "ertuipn" or key0 = "ertuipn;" or key0 = "ERTUIPN")
    str = interrupt{Space}
Else if (key0 = "etialnm" or key0 = "etialnm;" or key0 = "ETIALNM")
    str = eliminate{Space}
Else if (key0 = "etiascn" or key0 = "etiascn;" or key0 = "ETIASCN")
    str = instance{Space}
Else if (key0 = "etiscn" or key0 = "etiscn;" or key0 = "ETISCN")
    str = scientist{Space}
Else if (key0 = "etivn" or key0 = "etivn;" or key0 = "ETIVN")
    str = invite{Space}
Else if (key0 = "eruopd" or key0 = "eruopd;" or key0 = "ERUOPD")
    str = produce{Space}
Else if (key0 = "eacm" or key0 = "eacm;" or key0 = "EACM")
    str = came{Space}
Else if (key0 = "eadcn" or key0 = "eadcn;" or key0 = "EADCN")
    str = dance{Space}
Else if (key0 = "erudm" or key0 = "erudm;" or key0 = "ERUDM")
    str = drummer{Space}
Else if (key0 = "easfl" or key0 = "easfl;" or key0 = "EASFL")
    str = false{Space}
Else if (key0 = "easl" or key0 = "easl;" or key0 = "EASL")
    str = sale{Space}
Else if (key0 = "easlc" or key0 = "easlc;" or key0 = "EASLC")
    str = scale{Space}
Else if (key0 = "edg" or key0 = "edg;" or key0 = "EDG")
    str = edge{Space}
Else if (key0 = "efb" or key0 = "efb;" or key0 = "EFB")
    str = beef{Space}
Else if (key0 = "eicv" or key0 = "eicv;" or key0 = "EICV")
    str = vice{Space}
Else if (key0 = "eidv" or key0 = "eidv;" or key0 = "EIDV")
    str = dive{Space}
Else if (key0 = "eign" or key0 = "eign;" or key0 = "EIGN")
    str = engine{Space}
Else if (key0 = "einm" or key0 = "einm;" or key0 = "EINM")
    str = mine{Space}
Else if (key0 = "eiocvn" or key0 = "eiocvn;" or key0 = "EIOCVN")
    str = convince{Space}
Else if (key0 = "eiosn" or key0 = "eiosn;" or key0 = "EIOSN")
    str = noise{Space}
Else if (key0 = "elc" or key0 = "elc;" or key0 = "ELC")
    str = cell{Space}
Else if (key0 = "eohn" or key0 = "eohn;" or key0 = "EOHN")
    str = hone{Space}
Else if (key0 = "eradm" or key0 = "eradm;" or key0 = "ERADM")
    str = dream{Space}
Else if (key0 = "erasd" or key0 = "erasd;" or key0 = "ERASD")
    str = address{Space}
Else if (key0 = "erdg" or key0 = "erdg;" or key0 = "ERDG")
    str = degree{Space}
Else if (key0 = "ergcn" or key0 = "ergcn;" or key0 = "ERGCN")
    str = encourage{Space}
Else if (key0 = "erih" or key0 = "erih;" or key0 = "ERIH")
    str = hire{Space}
Else if (key0 = "erilc" or key0 = "erilc;" or key0 = "ERILC")
    str = circle{Space}
Else if (key0 = "erpscn" or key0 = "erpscn;" or key0 = "ERPSCN")
    str = presence{Space}
Else if (key0 = "erti" or key0 = "erti;" or key0 = "ERTI")
    str = tire{Space}
Else if (key0 = "ertipac" or key0 = "ertipac;" or key0 = "ERTIPAC")
    str = practice{Space}
Else if (key0 = "ertlcn" or key0 = "ertlcn;" or key0 = "ERTLCN")
    str = electronic{Space}
Else if (key0 = "ertocn" or key0 = "ertocn;" or key0 = "ERTOCN")
    str = concert{Space}
Else if (key0 = "ertof" or key0 = "ertof;" or key0 = "ERTOF")
    str = effort{Space}
Else if (key0 = "ertopc" or key0 = "ertopc;" or key0 = "ERTOPC")
    str = protect{Space}
Else if (key0 = "ertpx" or key0 = "ertpx;" or key0 = "ERTPX")
    str = expert{Space}
Else if (key0 = "ertuion" or key0 = "ertuion;" or key0 = "ERTUION")
    str = routine{Space}
Else if (key0 = "ertuo" or key0 = "ertuo;" or key0 = "ERTUO")
    str = route{Space}
Else if (key0 = "eruosc" or key0 = "eruosc;" or key0 = "ERUOSC")
    str = course{Space}
Else if (key0 = "eruosc" or key0 = "eruosc;" or key0 = "ERUOSC")
    str = course{Space}
Else if (key0 = "erusc" or key0 = "erusc;" or key0 = "ERUSC")
    str = secure{Space}
Else if (key0 = "erusc" or key0 = "erusc;" or key0 = "ERUSC")
    str = secure{Space}
Else if (key0 = "eryl" or key0 = "eryl;" or key0 = "ERYL")
    str = rely{Space}
Else if (key0 = "escn" or key0 = "escn;" or key0 = "ESCN")
    str = scene{Space}
Else if (key0 = "esg" or key0 = "esg;" or key0 = "ESG")
    str = seeing{Space}
Else if (key0 = "etab" or key0 = "etab;" or key0 = "ETAB")
    str = beat{Space}
Else if (key0 = "etad" or key0 = "etad;" or key0 = "ETAD")
    str = date{Space}
Else if (key0 = "etad" or key0 = "etad;" or key0 = "ETAD")
    str = date{Space}
Else if (key0 = "etadh" or key0 = "etadh;" or key0 = "ETADH")
    str = death{Space}
Else if (key0 = "etalm" or key0 = "etalm;" or key0 = "ETALM")
    str = metal{Space}
Else if (key0 = "etfh" or key0 = "etfh;" or key0 = "ETFH")
    str = theft{Space}
Else if (key0 = "etiadc" or key0 = "etiadc;" or key0 = "ETIADC")
    str = dictate{Space}
Else if (key0 = "etin" or key0 = "etin;" or key0 = "ETIN")
    str = intent{Space}
Else if (key0 = "etiocm" or key0 = "etiocm;" or key0 = "ETIOCM")
    str = committee{Space}
Else if (key0 = "etivn" or key0 = "etivn;" or key0 = "ETIVN")
    str = invent{Space}
Else if (key0 = "etogn" or key0 = "etogn;" or key0 = "ETOGN")
    str = gotten{Space}
Else if (key0 = "etoscn" or key0 = "etoscn;" or key0 = "ETOSCN")
    str = consent{Space}
Else if (key0 = "etov" or key0 = "etov;" or key0 = "ETOV")
    str = vote{Space}
Else if (key0 = "etpxc" or key0 = "etpxc;" or key0 = "ETPXC")
    str = except{Space}
Else if (key0 = "etupad" or key0 = "etupad;" or key0 = "ETUPAD")
    str = update{Space}
Else if (key0 = "ety" or key0 = "ety;" or key0 = "ETY")
    str = yet{Space}
Else if (key0 = "etyuab" or key0 = "etyuab;" or key0 = "ETYUAB")
    str = beauty{Space}
Else if (key0 = "euagln" or key0 = "euagln;" or key0 = "EUAGLN")
    str = language{Space}
Else if (key0 = "euasm" or key0 = "euasm;" or key0 = "EUASM")
    str = assume{Space}
Else if (key0 = "euisdc" or key0 = "euisdc;" or key0 = "EUISDC")
    str = suicide{Space}
Else if (key0 = "eulb" or key0 = "eulb;" or key0 = "EULB")
    str = blue{Space}
Else if (key0 = "eunm" or key0 = "eunm;" or key0 = "EUNM")
    str = menu{Space}
Else if (key0 = "eunm" or key0 = "eunm;" or key0 = "EUNM")
    str = menu{Space}
Else if (key0 = "eupas" or key0 = "eupas;" or key0 = "EUPAS")
    str = pause{Space}
Else if (key0 = "eradcn" or key0 = "eradcn;" or key0 = "ERADCN")
    str = dancer{Space}
Else if (key0 = "eagn" or key0 = "eagn;" or key0 = "EAGN")
    str = engage{Space}
Else if (key0 = "eiom" or key0 = "eiom;" or key0 = "EIOM")
    str = emotion{Space}
Else if (key0 = "eoavb" or key0 = "eoavb;" or key0 = "EOAVB")
    str = above{Space}
Else if (key0 = "eojk" or key0 = "eojk;" or key0 = "EOJK")
    str = joke{Space}
Else if (key0 = "epd" or key0 = "epd;" or key0 = "EPD")
    str = deep{Space}
Else if (key0 = "ergn" or key0 = "ergn;" or key0 = "ERGN")
    str = green{Space}
Else if (key0 = "erianm" or key0 = "erianm;" or key0 = "ERIANM")
    str = remain{Space}
Else if (key0 = "eropv" or key0 = "eropv;" or key0 = "EROPV")
    str = prove{Space}
Else if (key0 = "erpf" or key0 = "erpf;" or key0 = "ERPF")
    str = prefer{Space}
Else if (key0 = "ertah" or key0 = "ertah;" or key0 = "ERTAH")
    str = heart{Space}
Else if (key0 = "ertahb" or key0 = "ertahb;" or key0 = "ERTAHB")
    str = breathe{Space}
Else if (key0 = "ertan" or key0 = "ertan;" or key0 = "ERTAN")
    str = aren't{Space}
Else if (key0 = "ertioa" or key0 = "ertioa;" or key0 = "ERTIOA")
    str = iteration{Space}
Else if (key0 = "ertioa" or key0 = "ertioa;" or key0 = "ERTIOA")
    str = iteration{Space}
Else if (key0 = "ertipac" or key0 = "ertipac;" or key0 = "ERTIPAC")
    str = practice{Space}
Else if (key0 = "ertpan" or key0 = "ertpan;" or key0 = "ERTPAN")
    str = parent{Space}
Else if (key0 = "erygn" or key0 = "erygn;" or key0 = "ERYGN")
    str = energy{Space}
Else if (key0 = "esdn" or key0 = "esdn;" or key0 = "ESDN")
    str = send{Space}
Else if (key0 = "etasg" or key0 = "etasg;" or key0 = "ETASG")
    str = stage{Space}
Else if (key0 = "etasg" or key0 = "etasg;" or key0 = "ETASG")
    str = stage{Space}
Else if (key0 = "etiops" or key0 = "etiops;" or key0 = "ETIOPS")
    str = opposite{Space}
Else if (key0 = "etlnm" or key0 = "etlnm;" or key0 = "ETLNM")
    str = element{Space}
Else if (key0 = "etolc" or key0 = "etolc;" or key0 = "ETOLC")
    str = collect{Space}
Else if (key0 = "eton" or key0 = "eton;" or key0 = "ETON")
    str = note{Space}
Else if (key0 = "etuc" or key0 = "etuc;" or key0 = "ETUC")
    str = cute{Space}
Else if (key0 = "etusg" or key0 = "etusg;" or key0 = "ETUSG")
    str = suggest{Space}
Else if (key0 = "etvn" or key0 = "etvn;" or key0 = "ETVN")
    str = event{Space}
Else if (key0 = "etyhd" or key0 = "etyhd;" or key0 = "ETYHD")
    str = they'd{Space}
Else if (key0 = "etyhl" or key0 = "etyhl;" or key0 = "ETYHL")
    str = theyll{Space}
Else if (key0 = "euasc" or key0 = "euasc;" or key0 = "EUASC")
    str = cause{Space}
Else if (key0 = "euoacn" or key0 = "euoacn;" or key0 = "EUOACN")
    str = announce{Space}
Else if (key0 = "eusdc" or key0 = "eusdc;" or key0 = "EUSDC")
    str = succeed{Space}
Else if (key0 = "eusdc" or key0 = "eusdc;" or key0 = "EUSDC")
    str = succeed{Space}
Else if (key0 = "eusln" or key0 = "eusln;" or key0 = "EUSLN")
    str = unless{Space}
Else if (key0 = "eyojn" or key0 = "eyojn;" or key0 = "EYOJN")
    str = enjoy{Space}
Else if (key0 = "eps" or key0 = "eps;" or key0 = "EPS")
    str = especially{Space}
Else if (key0 = "eacn" or key0 = "eacn;" or key0 = "EACN")
    str = {BackSpace}ance{Space}
Else if (key0 = "eadh" or key0 = "eadh;" or key0 = "EADH")
    str = head{Space}
Else if (key0 = "eadl" or key0 = "eadl;" or key0 = "EADL")
    str = lead{Space}
Else if (key0 = "eadm" or key0 = "eadm;" or key0 = "EADM")
    str = made{Space}
Else if (key0 = "eafc" or key0 = "eafc;" or key0 = "EAFC")
    str = face{Space}
Else if (key0 = "eaflm" or key0 = "eaflm;" or key0 = "EAFLM")
    str = female{Space}
Else if (key0 = "eafm" or key0 = "eafm;" or key0 = "EAFM")
    str = fame{Space}
Else if (key0 = "eag" or key0 = "eag;" or key0 = "EAG")
    str = age{Space}
Else if (key0 = "eaghcn" or key0 = "eaghcn;" or key0 = "EAGHCN")
    str = change{Space}
Else if (key0 = "eaghlcn" or key0 = "eaghlcn;" or key0 = "EAGHLCN")
    str = challenge{Space}
Else if (key0 = "eagm" or key0 = "eagm;" or key0 = "EAGM")
    str = game{Space}
Else if (key0 = "eagnm" or key0 = "eagnm;" or key0 = "EAGNM")
    str = manage{Space}
Else if (key0 = "eagv" or key0 = "eagv;" or key0 = "EAGV")
    str = gave{Space}
Else if (key0 = "eahc" or key0 = "eahc;" or key0 = "EAHC")
    str = each{Space}
Else if (key0 = "eahcn" or key0 = "eahcn;" or key0 = "EAHCN")
    str = chance{Space}
Else if (key0 = "eahl" or key0 = "eahl;" or key0 = "EAHL")
    str = heal{Space}
Else if (key0 = "eahv" or key0 = "eahv;" or key0 = "EAHV")
    str = have{Space}
Else if (key0 = "eakm" or key0 = "eakm;" or key0 = "EAKM")
    str = make{Space}
Else if (key0 = "ealb" or key0 = "ealb;" or key0 = "EALB")
    str = able{Space}
Else if (key0 = "ealcn" or key0 = "ealcn;" or key0 = "EALCN")
    str = clean{Space}
Else if (key0 = "ealm" or key0 = "ealm;" or key0 = "EALM")
    str = male{Space}
Else if (key0 = "ealn" or key0 = "ealn;" or key0 = "EALN")
    str = lean{Space}
Else if (key0 = "eanm" or key0 = "eanm;" or key0 = "EANM")
    str = name{Space}
Else if (key0 = "easb" or key0 = "easb;" or key0 = "EASB")
    str = base{Space}
Else if (key0 = "easc" or key0 = "easc;" or key0 = "EASC")
    str = case{Space}
Else if (key0 = "easdk" or key0 = "easdk;" or key0 = "EASDK")
    str = asked{Space}
Else if (key0 = "easf" or key0 = "easf;" or key0 = "EASF")
    str = safe{Space}
Else if (key0 = "easkm" or key0 = "easkm;" or key0 = "EASKM")
    str = makes{Space}
Else if (key0 = "easm" or key0 = "easm;" or key0 = "EASM")
    str = same{Space}
Else if (key0 = "easv" or key0 = "easv;" or key0 = "EASV")
    str = save{Space}
Else if (key0 = "eb" or key0 = "eb;" or key0 = "EB")
    str = be{Space}
Else if (key0 = "ecn" or key0 = "ecn;" or key0 = "ECN")
    str = necessary{Space}
Else if (key0 = "ecn" or key0 = "ecn;" or key0 = "ECN")
    str = {BackSpace}ence{Space}
Else if (key0 = "ed" or key0 = "ed;" or key0 = "ED")
    str = {BackSpace}ed{Space}
Else if (key0 = "edc" or key0 = "edc;" or key0 = "EDC")
    str = dec{Space}
Else if (key0 = "edf" or key0 = "edf;" or key0 = "EDF")
    str = definitely{Space}
Else if (key0 = "edl" or key0 = "edl;" or key0 = "EDL")
    str = led{Space}
Else if (key0 = "edn" or key0 = "edn;" or key0 = "EDN")
    str = need{Space}
Else if (key0 = "edn" or key0 = "edn;" or key0 = "EDN")
    str = end{Space}
Else if (key0 = "edv" or key0 = "edv;" or key0 = "EDV")
    str = develop{Space}
Else if (key0 = "ef" or key0 = "ef;" or key0 = "EF")
    str = for example{Space}
Else if (key0 = "eg" or key0 = "eg;" or key0 = "EG")
    str = everything{Space}
Else if (key0 = "egb" or key0 = "egb;" or key0 = "EGB")
    str = being{Space}
Else if (key0 = "egl" or key0 = "egl;" or key0 = "EGL")
    str = leg{Space}
Else if (key0 = "eh" or key0 = "eh;" or key0 = "EH")
    str = he{Space}
Else if (key0 = "ehkc" or key0 = "ehkc;" or key0 = "EHKC")
    str = check{Space}
Else if (key0 = "eiacvn" or key0 = "eiacvn;" or key0 = "EIACVN")
    str = vaccine{Space}
Else if (key0 = "eiad" or key0 = "eiad;" or key0 = "EIAD")
    str = idea{Space}
Else if (key0 = "eiadm" or key0 = "eiadm;" or key0 = "EIADM")
    str = media{Space}
Else if (key0 = "eiagnm" or key0 = "eiagnm;" or key0 = "EIAGNM")
    str = imagine{Space}
Else if (key0 = "eialm" or key0 = "eialm;" or key0 = "EIALM")
    str = email{Space}
Else if (key0 = "eic" or key0 = "eic;" or key0 = "EIC")
    str = ice{Space}
Else if (key0 = "eicn" or key0 = "eicn;" or key0 = "EICN")
    str = nice{Space}
Else if (key0 = "eid" or key0 = "eid;" or key0 = "EID")
    str = ide
Else if (key0 = "eidc" or key0 = "eidc;" or key0 = "EIDC")
    str = decide{Space}
Else if (key0 = "eidfl" or key0 = "eidfl;" or key0 = "EIDFL")
    str = field{Space}
Else if (key0 = "eidfl" or key0 = "eidfl;" or key0 = "EIDFL")
    str = field{Space}
Else if (key0 = "eidfn" or key0 = "eidfn;" or key0 = "EIDFN")
    str = define{Space}
Else if (key0 = "eidlm" or key0 = "eidlm;" or key0 = "EIDLM")
    str = middle{Space}
Else if (key0 = "eidn" or key0 = "eidn;" or key0 = "EIDN")
    str = indeed{Space}
Else if (key0 = "eifl" or key0 = "eifl;" or key0 = "EIFL")
    str = life{Space}
Else if (key0 = "eigbn" or key0 = "eigbn;" or key0 = "EIGBN")
    str = begin{Space}
Else if (key0 = "eigbn" or key0 = "eigbn;" or key0 = "EIGBN")
    str = beginning{Space}
Else if (key0 = "eilb" or key0 = "eilb;" or key0 = "EILB")
    str = {BackSpace}ible{Space}
Else if (key0 = "eilv" or key0 = "eilv;" or key0 = "EILV")
    str = live{Space}
Else if (key0 = "eiocv" or key0 = "eiocv;" or key0 = "EIOCV")
    str = voice{Space}
Else if (key0 = "eiodv" or key0 = "eiodv;" or key0 = "EIODV")
    str = video{Space}
Else if (key0 = "eiofc" or key0 = "eiofc;" or key0 = "EIOFC")
    str = office{Space}
Else if (key0 = "eiohc" or key0 = "eiohc;" or key0 = "EIOHC")
    str = choice{Space}
Else if (key0 = "eiolvn" or key0 = "eiolvn;" or key0 = "EIOLVN")
    str = involve{Space}
Else if (key0 = "eiosc" or key0 = "eiosc;" or key0 = "EIOSC")
    str = section{Space}
Else if (key0 = "eiosn" or key0 = "eiosn;" or key0 = "EIOSN")
    str = noise{Space}
Else if (key0 = "eip" or key0 = "eip;" or key0 = "EIP")
    str = pipe{Space}
Else if (key0 = "eipc" or key0 = "eipc;" or key0 = "EIPC")
    str = piece{Space}
Else if (key0 = "eis" or key0 = "eis;" or key0 = "EIS")
    str = {BackSpace}ies{Space}
Else if (key0 = "eiscn" or key0 = "eiscn;" or key0 = "EISCN")
    str = since{Space}
Else if (key0 = "eisd" or key0 = "eisd;" or key0 = "EISD")
    str = side{Space}
Else if (key0 = "eisgln" or key0 = "eisgln;" or key0 = "EISGLN")
    str = single{Space}
Else if (key0 = "eiv" or key0 = "eiv;" or key0 = "EIV")
    str = I've{Space}
Else if (key0 = "eiz" or key0 = "eiz;" or key0 = "EIZ")
    str = {BackSpace}ize{Space}
Else if (key0 = "ekcn" or key0 = "ekcn;" or key0 = "EKCN")
    str = neck{Space}
Else if (key0 = "elcn" or key0 = "elcn;" or key0 = "ELCN")
    str = necessarily{Space}
Else if (key0 = "elv" or key0 = "elv;" or key0 = "ELV")
    str = level{Space}
Else if (key0 = "em" or key0 = "em;" or key0 = "EM")
    str = me{Space}
Else if (key0 = "en" or key0 = "en;" or key0 = "EN")
    str = {BackSpace}en{Space}
Else if (key0 = "enm" or key0 = "enm;" or key0 = "ENM")
    str = men{Space}
Else if (key0 = "eoasn" or key0 = "eoasn;" or key0 = "EOASN")
    str = season{Space}
Else if (key0 = "eoc" or key0 = "eoc;" or key0 = "EOC")
    str = eco{Space}
Else if (key0 = "eocn" or key0 = "eocn;" or key0 = "EOCN")
    str = once{Space}
Else if (key0 = "eodc" or key0 = "eodc;" or key0 = "EODC")
    str = code{Space}
Else if (key0 = "eodlm" or key0 = "eodlm;" or key0 = "EODLM")
    str = model{Space}
Else if (key0 = "eodn" or key0 = "eodn;" or key0 = "EODN")
    str = done{Space}
Else if (key0 = "eogn" or key0 = "eogn;" or key0 = "EOGN")
    str = enough{Space}
Else if (key0 = "euoghn" or key0 = "euoghn;" or key0 = "EUOGHN")
    str = gone{Space}
Else if (key0 = "eohl" or key0 = "eohl;" or key0 = "EOHL")
    str = hole{Space}
Else if (key0 = "eohm" or key0 = "eohm;" or key0 = "EOHM")
    str = home{Space}
Else if (key0 = "eolv" or key0 = "eolv;" or key0 = "EOLV")
    str = love{Space}
Else if (key0 = "eon" or key0 = "eon;" or key0 = "EON")
    str = one{Space}
Else if (key0 = "eop" or key0 = "eop;" or key0 = "EOP")
    str = people{Space}
Else if (key0 = "eopdlv" or key0 = "eopdlv;" or key0 = "EOPDLV")
    str = develop{Space}
Else if (key0 = "eoph" or key0 = "eoph;" or key0 = "EOPH")
    str = hope{Space}
Else if (key0 = "eophn" or key0 = "eophn;" or key0 = "EOPHN")
    str = phone{Space}
Else if (key0 = "eopn" or key0 = "eopn;" or key0 = "EOPN")
    str = open{Space}
Else if (key0 = "eops" or key0 = "eops;" or key0 = "EOPS")
    str = pose{Space}
Else if (key0 = "eopshn" or key0 = "eopshn;" or key0 = "EOPSHN")
    str = phones{Space}
Else if (key0 = "eosd" or key0 = "eosd;" or key0 = "EOSD")
    str = does{Space}
Else if (key0 = "eosg" or key0 = "eosg;" or key0 = "EOSG")
    str = goes{Space}
Else if (key0 = "eosh" or key0 = "eosh;" or key0 = "EOSH")
    str = shoe{Space}
Else if (key0 = "eoshc" or key0 = "eoshc;" or key0 = "EOSHC")
    str = chose{Space}
Else if (key0 = "eosl" or key0 = "eosl;" or key0 = "EOSL")
    str = lose{Space}
Else if (key0 = "eoslc" or key0 = "eoslc;" or key0 = "EOSLC")
    str = close{Space}
Else if (key0 = "eosm" or key0 = "eosm;" or key0 = "EOSM")
    str = some{Space}
Else if (key0 = "eov" or key0 = "eov;" or key0 = "EOV")
    str = everyone{Space}
Else if (key0 = "eozn" or key0 = "eozn;" or key0 = "EOZN")
    str = zone{Space}
Else if (key0 = "epac" or key0 = "epac;" or key0 = "EPAC")
    str = pace{Space}
Else if (key0 = "epag" or key0 = "epag;" or key0 = "EPAG")
    str = page{Space}
Else if (key0 = "epak" or key0 = "epak;" or key0 = "EPAK")
    str = peak{Space}
Else if (key0 = "epalc" or key0 = "epalc;" or key0 = "EPALC")
    str = place{Space}
Else if (key0 = "epasc" or key0 = "epasc;" or key0 = "EPASC")
    str = space{Space}
Else if (key0 = "epash" or key0 = "epash;" or key0 = "EPASH")
    str = shape{Space}
Else if (key0 = "epask" or key0 = "epask;" or key0 = "EPASK")
    str = speak{Space}
Else if (key0 = "epasl" or key0 = "epasl;" or key0 = "EPASL")
    str = please{Space}
Else if (key0 = "epdn" or key0 = "epdn;" or key0 = "EPDN")
    str = depend{Space}
Else if (key0 = "ephl" or key0 = "ephl;" or key0 = "EPHL")
    str = help{Space}
Else if (key0 = "epk" or key0 = "epk;" or key0 = "EPK")
    str = keep{Space}
Else if (key0 = "epsc" or key0 = "epsc;" or key0 = "EPSC")
    str = spec{Space}
Else if (key0 = "epscl" or key0 = "epscl;" or key0 = "EPSCL")
    str = specifically{Space}
Else if (key0 = "epsdn" or key0 = "epsdn;" or key0 = "EPSDN")
    str = spend{Space}
Else if (key0 = "epsh" or key0 = "epsh;" or key0 = "EPSH")
    str = sheep{Space}
Else if (key0 = "epsl" or key0 = "epsl;" or key0 = "EPSL")
    str = sleep{Space}
Else if (key0 = "epx" or key0 = "epx;" or key0 = "EPX")
    str = experience{Space}
Else if (key0 = "er" or key0 = "er;" or key0 = "ER")
    str = {BackSpace}er{Space}
Else if (key0 = "era" or key0 = "era;" or key0 = "ERA")
    str = are{Space}
Else if (key0 = "erac" or key0 = "erac;" or key0 = "ERAC")
    str = care{Space}
Else if (key0 = "eracm" or key0 = "eracm;" or key0 = "ERACM")
    str = camera{Space}
Else if (key0 = "eradfl" or key0 = "eradfl;" or key0 = "ERADFL")
    str = federal
Else if (key0 = "eradh" or key0 = "eradh;" or key0 = "ERADH")
    str = heard{Space}
Else if (key0 = "erady" or key0 = "erady;" or key0 = "ERADY")
    str = ready{Space}
Else if (key0 = "erag" or key0 = "erag;" or key0 = "ERAG")
    str = agree{Space}
Else if (key0 = "eragh" or key0 = "eragh;" or key0 = "ERAGH")
    str = hearing{Space}
Else if (key0 = "eragl" or key0 = "eragl;" or key0 = "ERAGL")
    str = large{Space}
Else if (key0 = "eragn" or key0 = "eragn;" or key0 = "ERAGN")
    str = range{Space}
Else if (key0 = "erah" or key0 = "erah;" or key0 = "ERAH")
    str = hear{Space}
Else if (key0 = "erahc" or key0 = "erahc;" or key0 = "ERAHC")
    str = reach{Space}
Else if (key0 = "erakb" or key0 = "erakb;" or key0 = "ERAKB")
    str = break{Space}
Else if (key0 = "eral" or key0 = "eral;" or key0 = "ERAL")
    str = real{Space}
Else if (key0 = "eralc" or key0 = "eralc;" or key0 = "ERALC")
    str = clear{Space}
Else if (key0 = "eraln" or key0 = "eraln;" or key0 = "ERALN")
    str = learn{Space}
Else if (key0 = "eran" or key0 = "eran;" or key0 = "ERAN")
    str = near{Space}
Else if (key0 = "erash" or key0 = "erash;" or key0 = "ERASH")
    str = share{Space}
Else if (key0 = "erashc" or key0 = "erashc;" or key0 = "ERASHC")
    str = search{Space}
Else if (key0 = "erbm" or key0 = "erbm;" or key0 = "ERBM")
    str = member{Space}
Else if (key0 = "erf" or key0 = "erf;" or key0 = "ERF")
    str = free{Space}
Else if (key0 = "erh" or key0 = "erh;" or key0 = "ERH")
    str = her{Space}
Else if (key0 = "erias" or key0 = "erias;" or key0 = "ERIAS")
    str = raise{Space}
Else if (key0 = "eridfn" or key0 = "eridfn;" or key0 = "ERIDFN")
    str = friend{Space}
Else if (key0 = "eridlv" or key0 = "eridlv;" or key0 = "ERIDLV")
    str = deliver{Space}
Else if (key0 = "eridlv" or key0 = "eridlv;" or key0 = "ERIDLV")
    str = deliver{Space}
Else if (key0 = "eridnm" or key0 = "eridnm;" or key0 = "ERIDNM")
    str = remind{Space}
Else if (key0 = "eridv" or key0 = "eridv;" or key0 = "ERIDV")
    str = derive{Space}
Else if (key0 = "erifb" or key0 = "erifb;" or key0 = "ERIFB")
    str = brief{Space}
Else if (key0 = "erifn" or key0 = "erifn;" or key0 = "ERIFN")
    str = infer{Space}
Else if (key0 = "erign" or key0 = "erign;" or key0 = "ERIGN")
    str = engineer{Space}
Else if (key0 = "eriogn" or key0 = "eriogn;" or key0 = "ERIOGN")
    str = region{Space}
Else if (key0 = "eriopa" or key0 = "eriopa;" or key0 = "ERIOPA")
    str = operation{Space}
Else if (key0 = "eriopdv" or key0 = "eriopdv;" or key0 = "ERIOPDV")
    str = provide{Space}
Else if (key0 = "erioscn" or key0 = "erioscn;" or key0 = "ERIOSCN")
    str = scenario{Space}
Else if (key0 = "eriosdc" or key0 = "eriosdc;" or key0 = "ERIOSDC")
    str = description{Space}
Else if (key0 = "eriovn" or key0 = "eriovn;" or key0 = "ERIOVN")
    str = environment{Space}
Else if (key0 = "eripc" or key0 = "eripc;" or key0 = "ERIPC")
    str = price{Space}
Else if (key0 = "eriscb" or key0 = "eriscb;" or key0 = "ERISCB")
    str = scribe{Space}
Else if (key0 = "erisdc" or key0 = "erisdc;" or key0 = "ERISDC")
    str = describe{Space}
Else if (key0 = "eroasn" or key0 = "eroasn;" or key0 = "EROASN")
    str = reason{Space}
Else if (key0 = "erocn" or key0 = "erocn;" or key0 = "EROCN")
    str = concern{Space}
Else if (key0 = "erocv" or key0 = "erocv;" or key0 = "EROCV")
    str = cover{Space}
Else if (key0 = "erod" or key0 = "erod;" or key0 = "EROD")
    str = order{Space}
Else if (key0 = "erodc" or key0 = "erodc;" or key0 = "ERODC")
    str = record{Space}
Else if (key0 = "erof" or key0 = "erof;" or key0 = "EROF")
    str = offer{Space}
Else if (key0 = "erol" or key0 = "erol;" or key0 = "EROL")
    str = role{Space}
Else if (key0 = "eropacm" or key0 = "eropacm;" or key0 = "EROPACM")
    str = compare{Space}
Else if (key0 = "eropafcnm" or key0 = "eropafcnm;" or key0 = "EROPAFCNM")
    str = performance{Space}
Else if (key0 = "eroplbm" or key0 = "eroplbm;" or key0 = "EROPLBM")
    str = problem{Space}
Else if (key0 = "eroplx" or key0 = "eroplx;" or key0 = "EROPLX")
    str = explore{Space}
Else if (key0 = "eropsg" or key0 = "eropsg;" or key0 = "EROPSG")
    str = progress{Space}
Else if (key0 = "eropsn" or key0 = "eropsn;" or key0 = "EROPSN")
    str = person{Space}
Else if (key0 = "erosh" or key0 = "erosh;" or key0 = "EROSH")
    str = horse{Space}
Else if (key0 = "erov" or key0 = "erov;" or key0 = "EROV")
    str = over{Space}
Else if (key0 = "erp" or key0 = "erp;" or key0 = "ERP")
    str = per{Space}
Else if (key0 = "erpa" or key0 = "erpa;" or key0 = "ERPA")
    str = prepare{Space}
Else if (key0 = "erpalc" or key0 = "erpalc;" or key0 = "ERPALC")
    str = replace{Space}
Else if (key0 = "erps" or key0 = "erps;" or key0 = "ERPS")
    str = press{Space}
Else if (key0 = "ers" or key0 = "ers;" or key0 = "ERS")
    str = res{Space}
Else if (key0 = "erscn" or key0 = "erscn;" or key0 = "ERSCN")
    str = screen{Space}
Else if (key0 = "ersv" or key0 = "ersv;" or key0 = "ERSV")
    str = serve{Space}
Else if (key0 = "ert" or key0 = "ert;" or key0 = "ERT")
    str = tree{Space}
Else if (key0 = "erta" or key0 = "erta;" or key0 = "ERTA")
    str = rate{Space}
Else if (key0 = "ertac" or key0 = "ertac;" or key0 = "ERTAC")
    str = react{Space}
Else if (key0 = "ertafh" or key0 = "ertafh;" or key0 = "ERTAFH")
    str = father{Space}
Else if (key0 = "ertag" or key0 = "ertag;" or key0 = "ERTAG")
    str = great{Space}
Else if (key0 = "ertahc" or key0 = "ertahc;" or key0 = "ERTAHC")
    str = character{Space}
Else if (key0 = "ertal" or key0 = "ertal;" or key0 = "ERTAL")
    str = later{Space}
Else if (key0 = "ertalcn" or key0 = "ertalcn;" or key0 = "ERTALCN")
    str = central{Space}
Else if (key0 = "ertam" or key0 = "ertam;" or key0 = "ERTAM")
    str = matter{Space}
Else if (key0 = "ertax" or key0 = "ertax;" or key0 = "ERTAX")
    str = extra
Else if (key0 = "ertb" or key0 = "ertb;" or key0 = "ERTB")
    str = better{Space}
Else if (key0 = "ertcn" or key0 = "ertcn;" or key0 = "ERTCN")
    str = recent{Space}
Else if (key0 = "erth" or key0 = "erth;" or key0 = "ERTH")
    str = there{Space}
Else if (key0 = "erths" or key0 = "erths;" or key0 = "ERTHS")
    str = there's{Space}
Else if (key0 = "ertiacn" or key0 = "ertiacn;" or key0 = "ERTIACN")
    str = certain{Space}
Else if (key0 = "ertiagn" or key0 = "ertiagn;" or key0 = "ERTIAGN")
    str = integrate{Space}
Else if (key0 = "ertial" or key0 = "ertial;" or key0 = "ERTIAL")
    str = retail{Space}
Else if (key0 = "ertialcv" or key0 = "ertialcv;" or key0 = "ERTIALCV")
    str = vertical{Space}
Else if (key0 = "ertialv" or key0 = "ertialv;" or key0 = "ERTIALV")
    str = relative{Space}
Else if (key0 = "ertidc" or key0 = "ertidc;" or key0 = "ERTIDC")
    str = credit{Space}
Else if (key0 = "ertifl" or key0 = "ertifl;" or key0 = "ERTIFL")
    str = filter{Space}
Else if (key0 = "ertih" or key0 = "ertih;" or key0 = "ERTIH")
    str = their{Space}
Else if (key0 = "ertin" or key0 = "ertin;" or key0 = "ERTIN")
    str = inter
Else if (key0 = "ertioadcn" or key0 = "ertioadcn;" or key0 = "ERTIOADCN")
    str = coordinate{Space}
Else if (key0 = "ertipa" or key0 = "ertipa;" or key0 = "ERTIPA")
    str = therapist{Space}
Else if (key0 = "ertipah" or key0 = "ertipah;" or key0 = "ERTIPAH")
    str = therapist{Space}
Else if (key0 = "ertipash" or key0 = "ertipash;" or key0 = "ERTIPASH")
    str = therapist{Space}
Else if (key0 = "ertiph" or key0 = "ertiph;" or key0 = "ERTIPH")
    str = therapist{Space}
Else if (key0 = "ertis" or key0 = "ertis;" or key0 = "ERTIS")
    str = sister{Space}
Else if (key0 = "ertl" or key0 = "ertl;" or key0 = "ERTL")
    str = letter{Space}
Else if (key0 = "ertm" or key0 = "ertm;" or key0 = "ERTM")
    str = term{Space}
Else if (key0 = "ertn" or key0 = "ertn;" or key0 = "ERTN")
    str = enter{Space}
Else if (key0 = "erto" or key0 = "erto;" or key0 = "ERTO")
    str = tore{Space}
Else if (key0 = "ertoasg" or key0 = "ertoasg;" or key0 = "ERTOASG")
    str = storage{Space}
Else if (key0 = "ertoc" or key0 = "ertoc;" or key0 = "ERTOC")
    str = correct{Space}
Else if (key0 = "ertogh" or key0 = "ertogh;" or key0 = "ERTOGH")
    str = together{Space}
Else if (key0 = "ertoh" or key0 = "ertoh;" or key0 = "ERTOH")
    str = other{Space}
Else if (key0 = "ertohb" or key0 = "ertohb;" or key0 = "ERTOHB")
    str = bother{Space}
Else if (key0 = "ertohm" or key0 = "ertohm;" or key0 = "ERTOHM")
    str = mother{Space}
Else if (key0 = "ertop" or key0 = "ertop;" or key0 = "ERTOP")
    str = report{Space}
Else if (key0 = "ertos" or key0 = "ertos;" or key0 = "ERTOS")
    str = store{Space}
Else if (key0 = "ertosn" or key0 = "ertosn;" or key0 = "ERTOSN")
    str = testosterone{Space}
Else if (key0 = "ertpa" or key0 = "ertpa;" or key0 = "ERTPA")
    str = parate{Space}
Else if (key0 = "ertpan" or key0 = "ertpan;" or key0 = "ERTPAN")
    str = partner{Space}
Else if (key0 = "ertpcn" or key0 = "ertpcn;" or key0 = "ERTPCN")
    str = percent{Space}
Else if (key0 = "ertpsn" or key0 = "ertpsn;" or key0 = "ERTPSN")
    str = present{Space}
Else if (key0 = "erts" or key0 = "erts;" or key0 = "ERTS")
    str = rest{Space}
Else if (key0 = "ertsh" or key0 = "ertsh;" or key0 = "ERTSH")
    str = there's{Space}
Else if (key0 = "ertu" or key0 = "ertu;" or key0 = "ERTU")
    str = true{Space}
Else if (key0 = "ertuac" or key0 = "ertuac;" or key0 = "ERTUAC")
    str = accurate{Space}
Else if (key0 = "ertuafcnm" or key0 = "ertuafcnm;" or key0 = "ERTUAFCNM")
    str = manufacture{Space}
Else if (key0 = "ertuan" or key0 = "ertuan;" or key0 = "ERTUAN")
    str = nature{Space}
Else if (key0 = "ertucn" or key0 = "ertucn;" or key0 = "ERTUCN")
    str = current{Space}
Else if (key0 = "ertuf" or key0 = "ertuf;" or key0 = "ERTUF")
    str = future{Space}
Else if (key0 = "ertuipc" or key0 = "ertuipc;" or key0 = "ERTUIPC")
    str = picture{Space}
Else if (key0 = "ertulc" or key0 = "ertulc;" or key0 = "ERTULC")
    str = culture{Space}
Else if (key0 = "ertusl" or key0 = "ertusl;" or key0 = "ERTUSL")
    str = result{Space}
Else if (key0 = "ertvnm" or key0 = "ertvnm;" or key0 = "ERTVNM")
    str = environment{Space}
Else if (key0 = "ertxm" or key0 = "ertxm;" or key0 = "ERTXM")
    str = extreme{Space}
Else if (key0 = "ertyh" or key0 = "ertyh;" or key0 = "ERTYH")
    str = they're{Space}
Else if (key0 = "ertyn" or key0 = "ertyn;" or key0 = "ERTYN")
    str = entry{Space}
Else if (key0 = "eru" or key0 = "eru;" or key0 = "ERU")
    str = you're{Space}
Else if (key0 = "erudc" or key0 = "erudc;" or key0 = "ERUDC")
    str = reduce{Space}
Else if (key0 = "erudn" or key0 = "erudn;" or key0 = "ERUDN")
    str = under{Space}
Else if (key0 = "erul" or key0 = "erul;" or key0 = "ERUL")
    str = rule{Space}
Else if (key0 = "eruops" or key0 = "eruops;" or key0 = "ERUOPS")
    str = purpose{Space}
Else if (key0 = "erups" or key0 = "erups;" or key0 = "ERUPS")
    str = super{Space}
Else if (key0 = "erus" or key0 = "erus;" or key0 = "ERUS")
    str = sure{Space}
Else if (key0 = "erusfl" or key0 = "erusfl;" or key0 = "ERUSFL")
    str = yourself{Space}
Else if (key0 = "erusm" or key0 = "erusm;" or key0 = "ERUSM")
    str = summer{Space}
Else if (key0 = "erv" or key0 = "erv;" or key0 = "ERV")
    str = ever{Space}
Else if (key0 = "ervn" or key0 = "ervn;" or key0 = "ERVN")
    str = never{Space}
Else if (key0 = "ervn" or key0 = "ervn;" or key0 = "ERVN")
    str = never{Space}
Else if (key0 = "ery" or key0 = "ery;" or key0 = "ERY")
    str = every{Space}
Else if (key0 = "eryal" or key0 = "eryal;" or key0 = "ERYAL")
    str = early{Space}
Else if (key0 = "eryogc" or key0 = "eryogc;" or key0 = "ERYOGC")
    str = grocery{Space}
Else if (key0 = "eryph" or key0 = "eryph;" or key0 = "ERYPH")
    str = hyper
Else if (key0 = "eryusg" or key0 = "eryusg;" or key0 = "ERYUSG")
    str = surgery{Space}
Else if (key0 = "eryv" or key0 = "eryv;" or key0 = "ERYV")
    str = every{Space}
Else if (key0 = "es" or key0 = "es;" or key0 = "ES")
    str = see{Space}
Else if (key0 = "esc" or key0 = "esc;" or key0 = "ESC")
    str = second{Space}
Else if (key0 = "esdn" or key0 = "esdn;" or key0 = "ESDN")
    str = send{Space}
Else if (key0 = "esfl" or key0 = "esfl;" or key0 = "ESFL")
    str = self{Space}
Else if (key0 = "esh" or key0 = "esh;" or key0 = "ESH")
    str = she{Space}
Else if (key0 = "esk" or key0 = "esk;" or key0 = "ESK")
    str = seek{Space}
Else if (key0 = "esl" or key0 = "esl;" or key0 = "ESL")
    str = else{Space}
Else if (key0 = "eslv" or key0 = "eslv;" or key0 = "ESLV")
    str = {BackSpace}selves{Space}
Else if (key0 = "esm" or key0 = "esm;" or key0 = "ESM")
    str = seem{Space}
Else if (key0 = "esn" or key0 = "esn;" or key0 = "ESN")
    str = sense{Space}
Else if (key0 = "et" or key0 = "et;" or key0 = "ET")
    str = even though{Space}
Else if (key0 = "eta" or key0 = "eta;" or key0 = "ETA")
    str = ate{Space}
Else if (key0 = "etadh" or key0 = "etadh;" or key0 = "ETADH")
    str = hated{Space}
Else if (key0 = "etadln" or key0 = "etadln;" or key0 = "ETADLN")
    str = dental{Space}
Else if (key0 = "etafc" or key0 = "etafc;" or key0 = "ETAFC")
    str = affect{Space}
Else if (key0 = "etaghc" or key0 = "etaghc;" or key0 = "ETAGHC")
    str = teaching{Space}
Else if (key0 = "etah" or key0 = "etah;" or key0 = "ETAH")
    str = hate{Space}
Else if (key0 = "etahc" or key0 = "etahc;" or key0 = "ETAHC")
    str = teach{Space}
Else if (key0 = "etahl" or key0 = "etahl;" or key0 = "ETAHL")
    str = health{Space}
Else if (key0 = "etak" or key0 = "etak;" or key0 = "ETAK")
    str = take{Space}
Else if (key0 = "etal" or key0 = "etal;" or key0 = "ETAL")
    str = late{Space}
Else if (key0 = "etalb" or key0 = "etalb;" or key0 = "ETALB")
    str = table{Space}
Else if (key0 = "etam" or key0 = "etam;" or key0 = "ETAM")
    str = team{Space}
Else if (key0 = "etan" or key0 = "etan;" or key0 = "ETAN")
    str = neat{Space}
Else if (key0 = "etas" or key0 = "etas;" or key0 = "ETAS")
    str = state{Space}
Else if (key0 = "etascn" or key0 = "etascn;" or key0 = "ETASCN")
    str = stance{Space}
Else if (key0 = "etasl" or key0 = "etasl;" or key0 = "ETASL")
    str = least{Space}
Else if (key0 = "etaxc" or key0 = "etaxc;" or key0 = "ETAXC")
    str = exact{Space}
Else if (key0 = "etc" or key0 = "etc;" or key0 = "ETC")
    str = et cetera{Space}
Else if (key0 = "etcn" or key0 = "etcn;" or key0 = "ETCN")
    str = cent{Space}
Else if (key0 = "etdn" or key0 = "etdn;" or key0 = "ETDN")
    str = tend{Space}
Else if (key0 = "etfc" or key0 = "etfc;" or key0 = "ETFC")
    str = effect{Space}
Else if (key0 = "etfl" or key0 = "etfl;" or key0 = "ETFL")
    str = felt{Space}
Else if (key0 = "etg" or key0 = "etg;" or key0 = "ETG")
    str = get{Space}
Else if (key0 = "etgv" or key0 = "etgv;" or key0 = "ETGV")
    str = everything{Space}
Else if (key0 = "eth" or key0 = "eth;" or key0 = "ETH")
    str = the{Space}
Else if (key0 = "ethc" or key0 = "ethc;" or key0 = "ETHC")
    str = tech{Space}
Else if (key0 = "ethcn" or key0 = "ethcn;" or key0 = "ETHCN")
    str = technology{Space}
Else if (key0 = "ethm" or key0 = "ethm;" or key0 = "ETHM")
    str = them{Space}
Else if (key0 = "ethn" or key0 = "ethn;" or key0 = "ETHN")
    str = then{Space}
Else if (key0 = "etiacv" or key0 = "etiacv;" or key0 = "ETIACV")
    str = active{Space}
Else if (key0 = "etiav" or key0 = "etiav;" or key0 = "ETIAV")
    str = ative
Else if (key0 = "etiglcn" or key0 = "etiglcn;" or key0 = "ETIGLCN")
    str = intelligence{Space}
Else if (key0 = "etigln" or key0 = "etigln;" or key0 = "ETIGLN")
    str = intelligent{Space}
Else if (key0 = "etihc" or key0 = "etihc;" or key0 = "ETIHC")
    str = ethic{Space}
Else if (key0 = "etil" or key0 = "etil;" or key0 = "ETIL")
    str = little{Space}
Else if (key0 = "etilcn" or key0 = "etilcn;" or key0 = "ETILCN")
    str = client{Space}
Else if (key0 = "etim" or key0 = "etim;" or key0 = "ETIM")
    str = item{Space}
Else if (key0 = "etim" or key0 = "etim;" or key0 = "ETIM")
    str = time{Space}
Else if (key0 = "etiocm" or key0 = "etiocm;" or key0 = "ETIOCM")
    str = committee{Space}
Else if (key0 = "etiocn" or key0 = "etiocn;" or key0 = "ETIOCN")
    str = notice{Space}
Else if (key0 = "etionm" or key0 = "etionm;" or key0 = "ETIONM")
    str = mention{Space}
Else if (key0 = "etipan" or key0 = "etipan;" or key0 = "ETIPAN")
    str = patient{Space}
Else if (key0 = "etis" or key0 = "etis;" or key0 = "ETIS")
    str = site{Space}
Else if (key0 = "etis" or key0 = "etis;" or key0 = "ETIS")
    str = ities{Space}
Else if (key0 = "etism" or key0 = "etism;" or key0 = "ETISM")
    str = times{Space}
Else if (key0 = "etisvn" or key0 = "etisvn;" or key0 = "ETISVN")
    str = invest{Space}
Else if (key0 = "etisx" or key0 = "etisx;" or key0 = "ETISX")
    str = exist{Space}
Else if (key0 = "etiv" or key0 = "etiv;" or key0 = "ETIV")
    str = tive{Space}
Else if (key0 = "etixc" or key0 = "etixc;" or key0 = "ETIXC")
    str = excite{Space}
Else if (key0 = "etl" or key0 = "etl;" or key0 = "ETL")
    str = let{Space}
Else if (key0 = "etm" or key0 = "etm;" or key0 = "ETM")
    str = met{Space}
Else if (key0 = "etm" or key0 = "etm;" or key0 = "ETM")
    str = met{Space}
Else if (key0 = "etn" or key0 = "etn;" or key0 = "ETN")
    str = net{Space}
Else if (key0 = "etnm" or key0 = "etnm;" or key0 = "ETNM")
    str = {BackSpace}ment{Space}
Else if (key0 = "etoalc" or key0 = "etoalc;" or key0 = "ETOALC")
    str = locate{Space}
Else if (key0 = "etocn" or key0 = "etocn;" or key0 = "ETOCN")
    str = connect{Space}
Else if (key0 = "etocnm" or key0 = "etocnm;" or key0 = "ETOCNM")
    str = comment{Space}
Else if (key0 = "etofn" or key0 = "etofn;" or key0 = "ETOFN")
    str = often{Space}
Else if (key0 = "etogh" or key0 = "etogh;" or key0 = "ETOGH")
    str = together{Space}
Else if (key0 = "etohl" or key0 = "etohl;" or key0 = "ETOHL")
    str = hotel{Space}
Else if (key0 = "etojcb" or key0 = "etojcb;" or key0 = "ETOJCB")
    str = object{Space}
Else if (key0 = "etonm" or key0 = "etonm;" or key0 = "ETONM")
    str = moment{Space}
Else if (key0 = "etopcn" or key0 = "etopcn;" or key0 = "ETOPCN")
    str = concept{Space}
Else if (key0 = "etopkc" or key0 = "etopkc;" or key0 = "ETOPKC")
    str = pocket{Space}
Else if (key0 = "etosh" or key0 = "etosh;" or key0 = "ETOSH")
    str = those{Space}
Else if (key0 = "etoshn" or key0 = "etoshn;" or key0 = "ETOSHN")
    str = honest{Space}
Else if (key0 = "etpac" or key0 = "etpac;" or key0 = "ETPAC")
    str = accept{Space}
Else if (key0 = "etpdn" or key0 = "etpdn;" or key0 = "ETPDN")
    str = dependent{Space}
Else if (key0 = "etpk" or key0 = "etpk;" or key0 = "ETPK")
    str = kept{Space}
Else if (key0 = "etps" or key0 = "etps;" or key0 = "ETPS")
    str = step{Space}
Else if (key0 = "etps" or key0 = "etps;" or key0 = "ETPS")
    str = step{Space}
Else if (key0 = "etpsn" or key0 = "etpsn;" or key0 = "ETPSN")
    str = spent{Space}
Else if (key0 = "tpxc" or key0 = "tpxc;" or key0 = "TPXC")
    str = expect{Space}
Else if (key0 = "ets" or key0 = "ets;" or key0 = "ETS")
    str = set{Space}
Else if (key0 = "etsb" or key0 = "etsb;" or key0 = "ETSB")
    str = best{Space}
Else if (key0 = "etsh" or key0 = "etsh;" or key0 = "ETSH")
    str = these{Space}
Else if (key0 = "etshc" or key0 = "etshc;" or key0 = "ETSHC")
    str = chest{Space}
Else if (key0 = "etshlb" or key0 = "etshlb;" or key0 = "ETSHLB")
    str = establish{Space}
Else if (key0 = "etsl" or key0 = "etsl;" or key0 = "ETSL")
    str = let's{Space}
Else if (key0 = "etslc" or key0 = "etslc;" or key0 = "ETSLC")
    str = select{Space}
Else if (key0 = "etsn" or key0 = "etsn;" or key0 = "ETSN")
    str = sent{Space}
Else if (key0 = "etysln" or key0 = "etysln;" or key0 = "ETYSLN")
    str = sent{Space}
Else if (key0 = "etuadc" or key0 = "etuadc;" or key0 = "ETUADC")
    str = educate{Space}
Else if (key0 = "etuagnm" or key0 = "etuagnm;" or key0 = "ETUAGNM")
    str = augment{Space}
Else if (key0 = "etuinm" or key0 = "etuinm;" or key0 = "ETUINM")
    str = minute{Space}
Else if (key0 = "etuipadlc" or key0 = "etuipadlc;" or key0 = "ETUIPADLC")
    str = duplicate{Space}
Else if (key0 = "etuodcnm" or key0 = "etuodcnm;" or key0 = "ETUODCNM")
    str = document{Space}
Else if (key0 = "etusdn" or key0 = "etusdn;" or key0 = "ETUSDN")
    str = student{Space}
Else if (key0 = "etuvn" or key0 = "etuvn;" or key0 = "ETUVN")
    str = eventually{Space}
Else if (key0 = "etx" or key0 = "etx;" or key0 = "ETX")
    str = external{Space}
Else if (key0 = "etxn" or key0 = "etxn;" or key0 = "ETXN")
    str = next{Space}
Else if (key0 = "etyh" or key0 = "etyh;" or key0 = "ETYH")
    str = they{Space}
Else if (key0 = "etyhv" or key0 = "etyhv;" or key0 = "ETYHV")
    str = they've{Space}
Else if (key0 = "etyidn" or key0 = "etyidn;" or key0 = "ETYIDN")
    str = identity{Space}
Else if (key0 = "etyoscm" or key0 = "etyoscm;" or key0 = "ETYOSCM")
    str = ecosystem{Space}
Else if (key0 = "etyp" or key0 = "etyp;" or key0 = "ETYP")
    str = type{Space}
Else if (key0 = "etysl" or key0 = "etysl;" or key0 = "ETYSL")
    str = style{Space}
Else if (key0 = "etysm" or key0 = "etysm;" or key0 = "ETYSM")
    str = system{Space}
Else if (key0 = "euaglc" or key0 = "euaglc;" or key0 = "EUAGLC")
    str = colleague{Space}
Else if (key0 = "eualv" or key0 = "eualv;" or key0 = "EUALV")
    str = value{Space}
Else if (key0 = "eud" or key0 = "eud;" or key0 = "EUD")
    str = education{Space}
Else if (key0 = "eugh" or key0 = "eugh;" or key0 = "EUGH")
    str = huge{Space}
Else if (key0 = "euiadcn" or key0 = "euiadcn;" or key0 = "EUIADCN")
    str = audience{Space}
Else if (key0 = "euis" or key0 = "euis;" or key0 = "EUIS")
    str = issue{Space}
Else if (key0 = "euops" or key0 = "euops;" or key0 = "EUOPS")
    str = suppose{Space}
Else if (key0 = "euosfcn" or key0 = "euosfcn;" or key0 = "EUOSFCN")
    str = confuse{Space}
Else if (key0 = "euosh" or key0 = "euosh;" or key0 = "EUOSH")
    str = house{Space}
Else if (key0 = "eus" or key0 = "eus;" or key0 = "EUS")
    str = use{Space}
Else if (key0 = "eusc" or key0 = "eusc;" or key0 = "EUSC")
    str = success{Space}
Else if (key0 = "eusdn" or key0 = "eusdn;" or key0 = "EUSDN")
    str = sudden{Space}
Else if (key0 = "eusg" or key0 = "eusg;" or key0 = "EUSG")
    str = guess{Space}
Else if (key0 = "euv" or key0 = "euv;" or key0 = "EUV")
    str = you've{Space}
Else if (key0 = "ev" or key0 = "ev;" or key0 = "EV")
    str = ever{Space}
Else if (key0 = "evb" or key0 = "evb;" or key0 = "EVB")
    str = everybody{Space}
Else if (key0 = "evn" or key0 = "evn;" or key0 = "EVN")
    str = even{Space}
Else if (key0 = "ex" or key0 = "ex;" or key0 = "EX")
    str = exactly{Space}
Else if (key0 = "ex" or key0 = "ex;" or key0 = "EX")
    str = ex
Else if (key0 = "exc" or key0 = "exc;" or key0 = "EXC")
    str = excellent{Space}
Else if (key0 = "eyalzn" or key0 = "eyalzn;" or key0 = "EYALZN")
    str = analyze{Space}
Else if (key0 = "eyas" or key0 = "eyas;" or key0 = "EYAS")
    str = easy{Space}
Else if (key0 = "eyb" or key0 = "eyb;" or key0 = "EYB")
    str = bye{Space}
Else if (key0 = "eyk" or key0 = "eyk;" or key0 = "EYK")
    str = key{Space}
Else if (key0 = "eylc" or key0 = "eylc;" or key0 = "EYLC")
    str = cycle{Space}
Else if (key0 = "eyonm" or key0 = "eyonm;" or key0 = "EYONM")
    str = money{Space}
Else if (key0 = "eys" or key0 = "eys;" or key0 = "EYS")
    str = yes{Space}
Else if (key0 = "eysflm" or key0 = "eysflm;" or key0 = "EYSFLM")
    str = myself{Space}
Else if (key0 = "eysflm" or key0 = "eysflm;" or key0 = "EYSFLM")
    str = myself{Space}
Else if (key0 = "eyv" or key0 = "eyv;" or key0 = "EYV")
    str = every{Space}
Else if (key0 = "ealbm" or key0 = "ealbm;" or key0 = "EALBM")
    str = blame{Space}
Else if (key0 = "easl" or key0 = "easl;" or key0 = "EASL")
    str = lease{Space}
Else if (key0 = "edkc" or key0 = "edkc;" or key0 = "EDKC")
    str = deck{Space}
Else if (key0 = "eranm" or key0 = "eranm;" or key0 = "ERANM")
    str = manner{Space}
Else if (key0 = "erfl" or key0 = "erfl;" or key0 = "ERFL")
    str = freelance{Space}
Else if (key0 = "eriopd" or key0 = "eriopd;" or key0 = "ERIOPD")
    str = period{Space}
Else if (key0 = "eripx" or key0 = "eripx;" or key0 = "ERIPX")
    str = expire{Space}
Else if (key0 = "erpdc" or key0 = "erpdc;" or key0 = "ERPDC")
    str = precede{Space}
Else if (key0 = "ertian" or key0 = "ertian;" or key0 = "ERTIAN")
    str = entertain{Space}
Else if (key0 = "etid" or key0 = "etid;" or key0 = "ETID")
    str = edit{Space}
Else if (key0 = "etlc" or key0 = "etlc;" or key0 = "ETLC")
    str = elect{Space}
Else if (key0 = "euidg" or key0 = "euidg;" or key0 = "EUIDG")
    str = guide{Space}
Else if (key0 = "euign" or key0 = "euign;" or key0 = "EUIGN")
    str = genuine{Space}
Else if (key0 = "eyaglc" or key0 = "eyaglc;" or key0 = "EYAGLC")
    str = legacy{Space}
Return

SENDO:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "oa" or key0 = "oa;" or key0 = "OA")
    str = anyone{Space}
Else if (key0 = "oan" or key0 = "oan;" or key0 = "OAN")
    str = anyone{Space}
Else if (key0 = "oafm" or key0 = "oafm;" or key0 = "OAFM")
    str = foam{Space}
Else if (key0 = "osl" or key0 = "osl;" or key0 = "OSL")
    str = loss{Space}
Else if (key0 = "oadl" or key0 = "oadl;" or key0 = "OADL")
    str = load{Space}
Else if (key0 = "oagnm" or key0 = "oagnm;" or key0 = "OAGNM")
    str = among{Space}
Else if (key0 = "odfl" or key0 = "odfl;" or key0 = "ODFL")
    str = fold{Space}
Else if (key0 = "ogm" or key0 = "ogm;" or key0 = "OGM")
    str = Oh my god.{Space}
Else if (key0 = "oahlc" or key0 = "oahlc;" or key0 = "OAHLC")
    str = alcohol{Space}
Else if (key0 = "odgl" or key0 = "odgl;" or key0 = "ODGL")
    str = gold{Space}
Else if (key0 = "odlb" or key0 = "odlb;" or key0 = "ODLB")
    str = bold{Space}
Else if (key0 = "odlc" or key0 = "odlc;" or key0 = "ODLC")
    str = cold{Space}
Else if (key0 = "ofkl" or key0 = "ofkl;" or key0 = "OFKL")
    str = folk{Space}
Else if (key0 = "ogl" or key0 = "ogl;" or key0 = "OGL")
    str = log{Space}
Else if (key0 = "ozm" or key0 = "ozm;" or key0 = "OZM")
    str = zoom{Space}
Else if (key0 = "omsgh" or key0 = "omsgh;" or key0 = "OMSGH")
    str = Oh my gosh.{Space}
Else if (key0 = "osgh" or key0 = "osgh;" or key0 = "OSGH")
    str = gosh{Space}
Else if (key0 = "osn" or key0 = "osn;" or key0 = "OSN")
    str = soon{Space}
Else if (key0 = "oaln" or key0 = "oaln;" or key0 = "OALN")
    str = loan{Space}
Else if (key0 = "obm" or key0 = "obm;" or key0 = "OBM")
    str = bomb{Space}
Else if (key0 = "oshkc" or key0 = "oshkc;" or key0 = "OSHKC")
    str = shock{Space}
Else if (key0 = "oxb" or key0 = "oxb;" or key0 = "OXB")
    str = box{Space}
Else if (key0 = "oag" or key0 = "oag;" or key0 = "OAG")
    str = ago{Space}
Else if (key0 = "osn" or key0 = "osn;" or key0 = "OSN")
    str = son{Space}
Else if (key0 = "oagl" or key0 = "oagl;" or key0 = "OAGL")
    str = goal{Space}
Else if (key0 = "oagln" or key0 = "oagln;" or key0 = "OAGLN")
    str = along{Space}
Else if (key0 = "oagn" or key0 = "oagn;" or key0 = "OAGN")
    str = going to{Space}
Else if (key0 = "oasl" or key0 = "oasl;" or key0 = "OASL")
    str = also{Space}
Else if (key0 = "oc" or key0 = "oc;" or key0 = "OC")
    str = could{Space}
Else if (key0 = "ocm" or key0 = "ocm;" or key0 = "OCM")
    str = com
Else if (key0 = "ocn" or key0 = "ocn;" or key0 = "OCN")
    str = con
Else if (key0 = "ocnm" or key0 = "ocnm;" or key0 = "OCNM")
    str = common{Space}
Else if (key0 = "od" or key0 = "od;" or key0 = "OD")
    str = do{Space}
Else if (key0 = "odc" or key0 = "odc;" or key0 = "ODC")
    str = document{Space}
Else if (key0 = "odf" or key0 = "odf;" or key0 = "ODF")
    str = food{Space}
Else if (key0 = "odg" or key0 = "odg;" or key0 = "ODG")
    str = doing{Space}
Else if (key0 = "odhl" or key0 = "odhl;" or key0 = "ODHL")
    str = hold{Space}
Else if (key0 = "odl" or key0 = "odl;" or key0 = "ODL")
    str = old{Space}
Else if (key0 = "odm" or key0 = "odm;" or key0 = "ODM")
    str = {BackSpace}dom{Space}
Else if (key0 = "of" or key0 = "of;" or key0 = "OF")
    str = of{Space}
Else if (key0 = "ofc" or key0 = "ofc;" or key0 = "OFC")
    str = of course{Space}
Else if (key0 = "ofc" or key0 = "ofc;" or key0 = "OFC")
    str = of course{Space}
Else if (key0 = "ofcn" or key0 = "ofcn;" or key0 = "OFCN")
    str = confirm{Space}
Else if (key0 = "ofn" or key0 = "ofn;" or key0 = "OFN")
    str = information{Space}
Else if (key0 = "og" or key0 = "og;" or key0 = "OG")
    str = go{Space}
Else if (key0 = "ogln" or key0 = "ogln;" or key0 = "OGLN")
    str = long{Space}
Else if (key0 = "oglv" or key0 = "oglv;" or key0 = "OGLV")
    str = loving{Space}
Else if (key0 = "ogn" or key0 = "ogn;" or key0 = "OGN")
    str = gone{Space}
Else if (key0 = "ohm" or key0 = "ohm;" or key0 = "OHM")
    str = homo
Else if (key0 = "ojb" or key0 = "ojb;" or key0 = "OJB")
    str = job{Space}
Else if (key0 = "ok" or key0 = "ok;" or key0 = "OK")
    str = kind of{Space}
Else if (key0 = "okb" or key0 = "okb;" or key0 = "OKB")
    str = book{Space}
Else if (key0 = "okc" or key0 = "okc;" or key0 = "OKC")
    str = cook{Space}
Else if (key0 = "okl" or key0 = "okl;" or key0 = "OKL")
    str = look{Space}
Else if (key0 = "oklc" or key0 = "oklc;" or key0 = "OKLC")
    str = lock{Space}
Else if (key0 = "oln" or key0 = "oln;" or key0 = "OLN")
    str = online{Space}
Else if (key0 = "on" or key0 = "on;" or key0 = "ON")
    str = on{Space}
Else if (key0 = "onm" or key0 = "onm;" or key0 = "ONM")
    str = moon{Space}
Else if (key0 = "op" or key0 = "op;" or key0 = "OP")
    str = opportunity{Space}
Else if (key0 = "opn" or key0 = "opn;" or key0 = "OPN")
    str = open{Space}
Else if (key0 = "ops" or key0 = "ops;" or key0 = "OPS")
    str = opportunities{Space}
Else if (key0 = "opsh" or key0 = "opsh;" or key0 = "OPSH")
    str = shop{Space}
Else if (key0 = "os" or key0 = "os;" or key0 = "OS")
    str = so{Space}
Else if (key0 = "osf" or key0 = "osf;" or key0 = "OSF")
    str = sort of{Space}
Else if (key0 = "osfkl" or key0 = "osfkl;" or key0 = "OSFKL")
    str = folks{Space}
Else if (key0 = "osgn" or key0 = "osgn;" or key0 = "OSGN")
    str = song{Space}
Else if (key0 = "oshlc" or key0 = "oshlc;" or key0 = "OSHLC")
    str = school{Space}
Else if (key0 = "osm" or key0 = "osm;" or key0 = "OSM")
    str = someone{Space}
Else if (key0 = "osn" or key0 = "osn;" or key0 = "OSN")
    str = soon{Space}
Else if (key0 = "ovb" or key0 = "ovb;" or key0 = "OVB")
    str = obviously{Space}
Else if (key0 = "oalc" or key0 = "oalc;" or key0 = "OALC")
    str = local{Space}
Else if (key0 = "oflc" or key0 = "oflc;" or key0 = "OFLC")
    str = official{Space}
Else if (key0 = "oh" or key0 = "oh;" or key0 = "OH")
    str = Oh,{Space}
Else if (key0 = "osdl" or key0 = "osdl;" or key0 = "OSDL")
    str = sold{Space}
Return

SENDP:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "pac" or key0 = "pac;" or key0 = "PAC")
    str = cap{Space}
Else if (key0 = "pk" or key0 = "pk;" or key0 = "PK")
    str = keep{Space}
Else if (key0 = "pasn" or key0 = "pasn;" or key0 = "PASN")
    str = span{Space}
Else if (key0 = "pgln" or key0 = "pgln;" or key0 = "PGLN")
    str = plunge{Space}
Else if (key0 = "phlnm" or key0 = "phlnm;" or key0 = "PHLNM")
    str = phenomenal{Space}
Else if (key0 = "phnm" or key0 = "phnm;" or key0 = "PHNM")
    str = phenomenon{Space}
Else if (key0 = "plcm" or key0 = "plcm;" or key0 = "PLCM")
    str = compile{Space}
Else if (key0 = "plcnm" or key0 = "plcnm;" or key0 = "PLCNM")
    str = compliance{Space}
Else if (key0 = "psc" or key0 = "psc;" or key0 = "PSC")
    str = species{Space}
Else if (key0 = "pslc" or key0 = "pslc;" or key0 = "PSLC")
    str = collapse{Space}
Else if (key0 = "updg" or key0 = "updg;" or key0 = "UPDG")
    str = pudding{Space}
Else if (key0 = "psfc" or key0 = "psfc;" or key0 = "PSFC")
    str = specific{Space}
Else if (key0 = "pfhl" or key0 = "pfhl;" or key0 = "PFHL")
    str = helpful{Space}
Else if (key0 = "phl" or key0 = "phl;" or key0 = "PHL")
    str = helpful{Space}
Else if (key0 = "pakc" or key0 = "pakc;" or key0 = "PAKC")
    str = pack{Space}
Else if (key0 = "pam" or key0 = "pam;" or key0 = "PAM")
    str = map{Space}
Else if (key0 = "pasm" or key0 = "pasm;" or key0 = "PASM")
    str = spam{Space}
Else if (key0 = "pgk" or key0 = "pgk;" or key0 = "PGK")
    str = package{Space}
Else if (key0 = "pk" or key0 = "pk;" or key0 = "PK")
    str = keep{Space}
Else if (key0 = "pal" or key0 = "pal;" or key0 = "PAL")
    str = application{Space}
Else if (key0 = "pb" or key0 = "pb;" or key0 = "PB")
    str = possible{Space}
Else if (key0 = "pag" or key0 = "pag;" or key0 = "PAG")
    str = gap{Space}
Else if (key0 = "pasl" or key0 = "pasl;" or key0 = "PASL")
    str = applies{Space}
Else if (key0 = "pcnm" or key0 = "pcnm;" or key0 = "PCNM")
    str = companion{Space}
Else if (key0 = "pdxn" or key0 = "pdxn;" or key0 = "PDXN")
    str = expand{Space}
Else if (key0 = "pgk" or key0 = "pgk;" or key0 = "PGK")
    str = package{Space}
Else if (key0 = "plcnm" or key0 = "plcnm;" or key0 = "PLCNM")
    str = complain{Space}
Else if (key0 = "plcnm" or key0 = "plcnm;" or key0 = "PLCNM")
    str = complain{Space}
Else if (key0 = "psdn" or key0 = "psdn;" or key0 = "PSDN")
    str = dispense{Space}
Else if (key0 = "psxvn" or key0 = "psxvn;" or key0 = "PSXVN")
    str = expansive{Space}
Else if (key0 = "pa" or key0 = "pa;" or key0 = "PA")
    str = app{Space}
Else if (key0 = "paglz" or key0 = "paglz;" or key0 = "PAGLZ")
    str = apologize{Space}
Else if (key0 = "palcm" or key0 = "palcm;" or key0 = "PALCM")
    str = accomplish{Space}
Else if (key0 = "pashlcm" or key0 = "pashlcm;" or key0 = "PASHLCM")
    str = accomplish{Space}
Else if (key0 = "psk" or key0 = "psk;" or key0 = "PSK")
    str = speak{Space}
Else if (key0 = "pslbm" or key0 = "pslbm;" or key0 = "PSLBM")
    str = impossible{Space}
Else if (key0 = "psx" or key0 = "psx;" or key0 = "PSX")
    str = expose{Space}
Else if (key0 = "paln" or key0 = "paln;" or key0 = "PALN")
    str = plan{Space}
Else if (key0 = "pas" or key0 = "pas;" or key0 = "PAS")
    str = pass{Space}
Else if (key0 = "pfh" or key0 = "pfh;" or key0 = "PFH")
    str = hopefully{Space}
Else if (key0 = "ph" or key0 = "ph;" or key0 = "PH")
    str = hope{Space}
Else if (key0 = "pslc" or key0 = "pslc;" or key0 = "PSLC")
    str = special{Space}
Else if (key0 = "pcm" or key0 = "pcm;" or key0 = "PCM")
    str = company{Space}
Else if (key0 = "pdcm" or key0 = "pdcm;" or key0 = "PDCM")
    str = pandemic{Space}
Else if (key0 = "pf" or key0 = "pf;" or key0 = "PF")
    str = perfect{Space}
Else if (key0 = "pfh" or key0 = "pfh;" or key0 = "PFH")
    str = hopefully{Space}
Else if (key0 = "pg" or key0 = "pg;" or key0 = "PG")
    str = page{Space}
Else if (key0 = "pgh" or key0 = "pgh;" or key0 = "PGH")
    str = happening{Space}
Else if (key0 = "pglb" or key0 = "pglb;" or key0 = "PGLB")
    str = publishing{Space}
Else if (key0 = "phn" or key0 = "phn;" or key0 = "PHN")
    str = happen{Space}
Else if (key0 = "pjm" or key0 = "pjm;" or key0 = "PJM")
    str = jump{Space}
Else if (key0 = "pl" or key0 = "pl;" or key0 = "PL")
    str = people{Space}
Else if (key0 = "plb" or key0 = "plb;" or key0 = "PLB")
    str = possibly{Space}
Else if (key0 = "plc" or key0 = "plc;" or key0 = "PLC")
    str = couple{Space}
Else if (key0 = "plcb" or key0 = "plcb;" or key0 = "PLCB")
    str = public{Space}
Else if (key0 = "plxm" or key0 = "plxm;" or key0 = "PLXM")
    str = example{Space}
Else if (key0 = "plxn" or key0 = "plxn;" or key0 = "PLXN")
    str = explain{Space}
Else if (key0 = "pn" or key0 = "pn;" or key0 = "PN")
    str = no problem{Space}
Else if (key0 = "ps" or key0 = "ps;" or key0 = "PS")
    str = specifically{Space}
Else if (key0 = "pscm" or key0 = "pscm;" or key0 = "PSCM")
    str = companies{Space}
Else if (key0 = "psd" or key0 = "psd;" or key0 = "PSD")
    str = speed{Space}
Else if (key0 = "psh" or key0 = "psh;" or key0 = "PSH")
    str = hospital{Space}
Else if (key0 = "psl" or key0 = "psl;" or key0 = "PSL")
    str = please{Space}
Else if (key0 = "pslb" or key0 = "pslb;" or key0 = "PSLB")
    str = possible{Space}
Else if (key0 = "pslm" or key0 = "pslm;" or key0 = "PSLM")
    str = simple{Space}
Else if (key0 = "psn" or key0 = "psn;" or key0 = "PSN")
    str = passion{Space}
Else if (key0 = "px" or key0 = "px;" or key0 = "PX")
    str = experience{Space}
Else if (key0 = "pshlb" or key0 = "pshlb;" or key0 = "PSHLB")
    str = publish{Space}
Return

SENDA:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "ab" or key0 = "ab;" or key0 = "AB")
    str = about{Space}
Else if (key0 = "adv" or key0 = "adv;" or key0 = "ADV")
    str = avoid{Space}
Else if (key0 = "adlbm" or key0 = "adlbm;" or key0 = "ADLBM")
    str = lambda{Space}
Else if (key0 = "agb" or key0 = "agb;" or key0 = "AGB")
    str = bag{Space}
Else if (key0 = "ahklc" or key0 = "ahklc;" or key0 = "AHKLC")
    str = chalk{Space}
Else if (key0 = "asfkl" or key0 = "asfkl;" or key0 = "ASFKL")
    str = flask{Space}
Else if (key0 = "asg" or key0 = "asg;" or key0 = "ASG")
    str = gas{Space}
Else if (key0 = "adcvn" or key0 = "adcvn;" or key0 = "ADCVN")
    str = advance{Space}
Else if (key0 = "askc" or key0 = "askc;" or key0 = "ASKC")
    str = sack{Space}
Else if (key0 = "abn" or key0 = "abn;" or key0 = "ABN")
    str = banana{Space}
Else if (key0 = "afv" or key0 = "afv;" or key0 = "AFV")
    str = favorite{Space}
Else if (key0 = "ac" or key0 = "ac;" or key0 = "AC")
    str = actually{Space}
Else if (key0 = "adgl" or key0 = "adgl;" or key0 = "ADGL")
    str = glad{Space}
Else if (key0 = "adbn" or key0 = "adbn;" or key0 = "ADBN")
    str = band{Space}
Else if (key0 = "adln" or key0 = "adln;" or key0 = "ADLN")
    str = land{Space}
Else if (key0 = "adnm" or key0 = "adnm;" or key0 = "ADNM")
    str = damn{Space}
Else if (key0 = "aghn" or key0 = "aghn;" or key0 = "AGHN")
    str = hang{Space}
Else if (key0 = "agkbn" or key0 = "agkbn;" or key0 = "AGKBN")
    str = banking{Space}
Else if (key0 = "alcm" or key0 = "alcm;" or key0 = "ALCM")
    str = calm{Space}
Else if (key0 = "ascn" or key0 = "ascn;" or key0 = "ASCN")
    str = scan{Space}
Else if (key0 = "asdhn" or key0 = "asdhn;" or key0 = "ASDHN")
    str = hands{Space}
Else if (key0 = "asdnm" or key0 = "asdnm;" or key0 = "ASDNM")
    str = admission{Space}
Else if (key0 = "adcm" or key0 = "adcm;" or key0 = "ADCM")
    str = academic{Space}
Else if (key0 = "adcm" or key0 = "adcm;" or key0 = "ADCM")
    str = academic{Space}
Else if (key0 = "adcv" or key0 = "adcv;" or key0 = "ADCV")
    str = advice{Space}
Else if (key0 = "adcv" or key0 = "adcv;" or key0 = "ADCV")
    str = advice{Space}
Else if (key0 = "adm" or key0 = "adm;" or key0 = "ADM")
    str = mad{Space}
Else if (key0 = "adv" or key0 = "adv;" or key0 = "ADV")
    str = advertise{Space}
Else if (key0 = "agcn" or key0 = "agcn;" or key0 = "AGCN")
    str = agency{Space}
Else if (key0 = "agnm" or key0 = "agnm;" or key0 = "AGNM")
    str = among{Space}
Else if (key0 = "ahkc" or key0 = "ahkc;" or key0 = "AHKC")
    str = hack{Space}
Else if (key0 = "ahl" or key0 = "ahl;" or key0 = "AHL")
    str = hall{Space}
Else if (key0 = "aln" or key0 = "aln;" or key0 = "ALN")
    str = alone{Space}
Else if (key0 = "asd" or key0 = "asd;" or key0 = "ASD")
    str = ads{Space}
Else if (key0 = "asdv" or key0 = "asdv;" or key0 = "ASDV")
    str = advise{Space}
Else if (key0 = "ashc" or key0 = "ashc;" or key0 = "ASHC")
    str = cash{Space}
Else if (key0 = "asm" or key0 = "asm;" or key0 = "ASM")
    str = mass{Space}
Else if (key0 = "agv" or key0 = "agv;" or key0 = "AGV")
    str = average{Space}
Else if (key0 = "ahcv" or key0 = "ahcv;" or key0 = "AHCV")
    str = achieve{Space}
Else if (key0 = "aklcb" or key0 = "aklcb;" or key0 = "AKLCB")
    str = black{Space}
Else if (key0 = "avb" or key0 = "avb;" or key0 = "AVB")
    str = above{Space}
Else if (key0 = "acn" or key0 = "acn;" or key0 = "ACN")
    str = can{Space}
Else if (key0 = "adgcn" or key0 = "adgcn;" or key0 = "ADGCN")
    str = dancing{Space}
Else if (key0 = "adb" or key0 = "adb;" or key0 = "ADB")
    str = anybody{Space}
Else if (key0 = "adf" or key0 = "adf;" or key0 = "ADF")
    str = afterwards{Space}
Else if (key0 = "adgc" or key0 = "adgc;" or key0 = "ADGC")
    str = according{Space}
Else if (key0 = "adh" or key0 = "adh;" or key0 = "ADH")
    str = had{Space}
Else if (key0 = "adhn" or key0 = "adhn;" or key0 = "ADHN")
    str = hand{Space}
Else if (key0 = "adl" or key0 = "adl;" or key0 = "ADL")
    str = already{Space}
Else if (key0 = "af" or key0 = "af;" or key0 = "AF")
    str = after{Space}
Else if (key0 = "afg" or key0 = "afg;" or key0 = "AFG")
    str = affecting{Space}
Else if (key0 = "afhl" or key0 = "afhl;" or key0 = "AFHL")
    str = half{Space}
Else if (key0 = "afl" or key0 = "afl;" or key0 = "AFL")
    str = fall{Space}
Else if (key0 = "ag" or key0 = "ag;" or key0 = "AG")
    str = anything{Space}
Else if (key0 = "agm" or key0 = "agm;" or key0 = "AGM")
    str = amazing{Space}
Else if (key0 = "agn" or key0 = "agn;" or key0 = "AGN")
    str = again{Space}
Else if (key0 = "akc" or key0 = "akc;" or key0 = "AKC")
    str = {Backspace}ack{Space}
Else if (key0 = "akcb" or key0 = "akcb;" or key0 = "AKCB")
    str = back{Space}
Else if (key0 = "al" or key0 = "al;" or key0 = "AL")
    str = all{Space}
Else if (key0 = "alb" or key0 = "alb;" or key0 = "ALB")
    str = lab{Space}
Else if (key0 = "alc" or key0 = "alc;" or key0 = "ALC")
    str = call{Space}
Else if (key0 = "alm" or key0 = "alm;" or key0 = "ALM")
    str = almost{Space}
Else if (key0 = "alvb" or key0 = "alvb;" or key0 = "ALVB")
    str = available{Space}
Else if (key0 = "am" or key0 = "am;" or key0 = "AM")
    str = am{Space}
Else if (key0 = "an" or key0 = "an;" or key0 = "AN")
    str = an{Space}
Else if (key0 = "anm" or key0 = "anm;" or key0 = "ANM")
    str = man{Space}
Else if (key0 = "as" or key0 = "as;" or key0 = "AS")
    str = as{Space}
Else if (key0 = "asb" or key0 = "asb;" or key0 = "ASB")
    str = absolutely{Space}
Else if (key0 = "asdk" or key0 = "asdk;" or key0 = "ASDK")
    str = asked{Space}
Else if (key0 = "asgl" or key0 = "asgl;" or key0 = "ASGL")
    str = glass{Space}
Else if (key0 = "ash" or key0 = "ash;" or key0 = "ASH")
    str = has{Space}
Else if (key0 = "ashl" or key0 = "ashl;" or key0 = "ASHL")
    str = lash{Space}
Else if (key0 = "ask" or key0 = "ask;" or key0 = "ASK")
    str = ask{Space}
Else if (key0 = "aslc" or key0 = "aslc;" or key0 = "ASLC")
    str = class{Space}
Else if (key0 = "aslm" or key0 = "aslm;" or key0 = "ASLM")
    str = small{Space}
Else if (key0 = "akbn" or key0 = "akbn;" or key0 = "AKBN")
    str = bank{Space}
Else if (key0 = "asn" or key0 = "asn;" or key0 = "ASN")
    str = answer{Space}
Else if (key0 = "axv" or key0 = "axv;" or key0 = "AXV")
    str = vaccine{Space}
Else if (key0 = "azm" or key0 = "azm;" or key0 = "AZM")
    str = Amazon{Space}
Else if (key0 = "ad" or key0 = "ad;" or key0 = "AD")
    str = ad{Space}
Return

SENDS:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "sbn" or key0 = "sbn;" or key0 = "SBN")
    str = business{Space}
Else if (key0 = "scb" or key0 = "scb;" or key0 = "SCB")
    str = basic{Space}
Else if (key0 = "sdvn" or key0 = "sdvn;" or key0 = "SDVN")
    str = division{Space}
Else if (key0 = "sfm" or key0 = "sfm;" or key0 = "SFM")
    str = famous{Space}
Else if (key0 = "sghln" or key0 = "sghln;" or key0 = "SGHLN")
    str = english{Space}
Else if (key0 = "shlab" or key0 = "shlab;" or key0 = "SHLAB")
    str = abolish{Space}
Else if (key0 = "shm" or key0 = "shm;" or key0 = "SHM")
    str = somehow{Space}
Else if (key0 = "sdhlc" or key0 = "sdhlc;" or key0 = "SDHLC")
    str = schedule{Space}
Else if (key0 = "sz" or key0 = "sz;" or key0 = "SZ")
    str = size{Space}
Else if (key0 = "scm" or key0 = "scm;" or key0 = "SCM")
    str = comes{Space}
Else if (key0 = "sdb" or key0 = "sdb;" or key0 = "SDB")
    str = besides{Space}
Else if (key0 = "sdhbn" or key0 = "sdhbn;" or key0 = "SDHBN")
    str = husband{Space}
Else if (key0 = "sdn" or key0 = "sdn;" or key0 = "SDN")
    str = inside{Space}
Else if (key0 = "shl" or key0 = "shl;" or key0 = "SHL")
    str = she'll{Space}
Else if (key0 = "slvb" or key0 = "slvb;" or key0 = "SLVB")
    str = visible{Space}
Else if (key0 = "sd" or key0 = "sd;" or key0 = "SD")
    str = somebody{Space}
Else if (key0 = "scnm" or key0 = "scnm;" or key0 = "SCNM")
    str = consume{Space}
Else if (key0 = "slcn" or key0 = "slcn;" or key0 = "SLCN")
    str = license{Space}
Else if (key0 = "sln" or key0 = "sln;" or key0 = "SLN")
    str = lesson{Space}
Else if (key0 = "snm" or key0 = "snm;" or key0 = "SNM")
    str = mission{Space}
Else if (key0 = "snm" or key0 = "snm;" or key0 = "SNM")
    str = mission{Space}
Else if (key0 = "svm" or key0 = "svm;" or key0 = "SVM")
    str = massive{Space}
Else if (key0 = "svn" or key0 = "svn;" or key0 = "SVN")
    str = vision{Space}
Else if (key0 = "sdc" or key0 = "sdc;" or key0 = "SDC")
    str = describe{Space}
Else if (key0 = "sfcn" or key0 = "sfcn;" or key0 = "SFCN")
    str = confuse{Space}
Else if (key0 = "sfl" or key0 = "sfl;" or key0 = "SFL")
    str = {BackSpace}self{Space}
Else if (key0 = "shn" or key0 = "shn;" or key0 = "SHN")
    str = hasn't{Space}
Else if (key0 = "sdcn" or key0 = "sdcn;" or key0 = "SDCN")
    str = decision{Space}
Else if (key0 = "sdgn" or key0 = "sdgn;" or key0 = "SDGN")
    str = design{Space}
Else if (key0 = "sdlcm" or key0 = "sdlcm;" or key0 = "SDLCM")
    str = social media{Space}
Else if (key0 = "sf" or key0 = "sf;" or key0 = "SF")
    str = For sure.{Space}
Else if (key0 = "sfgcn" or key0 = "sfgcn;" or key0 = "SFGCN")
    str = significant{Space}
Else if (key0 = "sflm" or key0 = "sflm;" or key0 = "SFLM")
    str = myself{Space}
Else if (key0 = "sg" or key0 = "sg;" or key0 = "SG")
    str = something{Space}
Else if (key0 = "sgm" or key0 = "sgm;" or key0 = "SGM")
    str = message{Space}
Else if (key0 = "sh" or key0 = "sh;" or key0 = "SH")
    str = should{Space}
Else if (key0 = "sdhn" or key0 = "sdhn;" or key0 = "SDHN")
    str = shouldn't{Space}
Else if (key0 = "shn" or key0 = "shn;" or key0 = "SHN")
    str = shouldn't{Space}
Else if (key0 = "sh" or key0 = "sh;" or key0 = "SH")
    str = should{Space}
Else if (key0 = "sl" or key0 = "sl;" or key0 = "SL")
    str = sell{Space}
Else if (key0 = "slc" or key0 = "slc;" or key0 = "SLC")
    str = social{Space}
Else if (key0 = "slcb" or key0 = "slcb;" or key0 = "SLCB")
    str = basically{Space}
Else if (key0 = "slp" or key0 = "slp;" or key0 = "SLP")
    str = sleep{Space}
Else if (key0 = "slv" or key0 = "slv;" or key0 = "SLV")
    str = visual{Space}
Else if (key0 = "sm" or key0 = "sm;" or key0 = "SM")
    str = some{Space}
Else if (key0 = "sn" or key0 = "sn;" or key0 = "SN")
    str = seen{Space}
Else if (key0 = "srcv" or key0 = "srcv;" or key0 = "SRCV")
    str = service{Space}
Else if (key0 = "st" or key0 = "st;" or key0 = "ST")
    str = street{Space}
Else if (key0 = "sv" or key0 = "sv;" or key0 = "SV")
    str = versus{Space}
Else if (key0 = "sxcvl" or key0 = "sxcvl;" or key0 = "SXCVL")
    str = exclusive{Space}
Return

SENDD:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "dbn" or key0 = "dbn;" or key0 = "DBN")
    str = nobody{Space}
Else if (key0 = "dcm" or key0 = "dcm;" or key0 = "DCM")
    str = command{Space}
Else if (key0 = "dcvn" or key0 = "dcvn;" or key0 = "DCVN")
    str = evidence{Space}
Else if (key0 = "dfgl" or key0 = "dfgl;" or key0 = "DFGL")
    str = fledgling{Space}
Else if (key0 = "dlbn" or key0 = "dlbn;" or key0 = "DLBN")
    str = blend{Space}
Else if (key0 = "dhln" or key0 = "dhln;" or key0 = "DHLN")
    str = handle{Space}
Else if (key0 = "dnm" or key0 = "dnm;" or key0 = "DNM")
    str = domain{Space}
Else if (key0 = "dhln" or key0 = "dhln;" or key0 = "DHLN")
    str = handle{Space}
Else if (key0 = "dghln" or key0 = "dghln;" or key0 = "DGHLN")
    str = handling{Space}
Else if (key0 = "dcn" or key0 = "dcn;" or key0 = "DCN")
    str = couldn't{Space}
Else if (key0 = "dcn" or key0 = "dcn;" or key0 = "DCN")
    str = candid{Space}
Else if (key0 = "dcnm" or key0 = "dcnm;" or key0 = "DCNM")
    str = medicine{Space}
Else if (key0 = "dhn" or key0 = "dhn;" or key0 = "DHN")
    str = hadn't{Space}
Else if (key0 = "dlcn" or key0 = "dlcn;" or key0 = "DLCN")
    str = include{Space}
Else if (key0 = "dcv" or key0 = "dcv;" or key0 = "DCV")
    str = device{Space}
Else if (key0 = "dfkb" or key0 = "dfkb;" or key0 = "DFKB")
    str = feedback{Space}
Else if (key0 = "dfn" or key0 = "dfn;" or key0 = "DFN")
    str = found{Space}
Else if (key0 = "dg" or key0 = "dg;" or key0 = "DG")
    str = good{Space}
Else if (key0 = "dgb" or key0 = "dgb;" or key0 = "DGB")
    str = background{Space}
Else if (key0 = "dglb" or key0 = "dglb;" or key0 = "DGLB")
    str = building{Space}
Else if (key0 = "dgm" or key0 = "dgm;" or key0 = "DGM")
    str = damage{Space}
Else if (key0 = "dgn" or key0 = "dgn;" or key0 = "DGN")
    str = ground{Space}
Else if (key0 = "dhbn" or key0 = "dhbn;" or key0 = "DHBN")
    str = behind{Space}
Else if (key0 = "dl" or key0 = "dl;" or key0 = "DL")
    str = deal{Space}
Else if (key0 = "dlb" or key0 = "dlb;" or key0 = "DLB")
    str = build{Space}
Else if (key0 = "dlcbn" or key0 = "dlcbn;" or key0 = "DLCBN")
    str = incredible{Space}
Else if (key0 = "dlcm" or key0 = "dlcm;" or key0 = "DLCM")
    str = medical{Space}
Else if (key0 = "dlcm" or key0 = "dlcm;" or key0 = "DLCM")
    str = medical{Space}
Else if (key0 = "dm" or key0 = "dm;" or key0 = "DM")
    str = made{Space}
Else if (key0 = "dn" or key0 = "dn;" or key0 = "DN")
    str = done{Space}
Else if (key0 = "drg" or key0 = "drg;" or key0 = "DRG")
    str = during {Space}
Else if (key0 = "dv" or key0 = "dv;" or key0 = "DV")
    str = everyday{Space}
Else if (key0 = "dvm" or key0 = "dvm;" or key0 = "DVM")
    str = development{Space}
Else if (key0 = "dx" or key0 = "dx;" or key0 = "DX")
    str = excited{Space}
Return

SENDF:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
if (key0 = "fb" or key0 = "fb;" or key0 = "FB")
    str = before{Space}
Else if (key0 = "fcm" or key0 = "fcm;" or key0 = "FCM")
    str = comfortable{Space}
Else if (key0 = "frst" or key0 = "frst;" or key0 = "FRST")
    str = forest{Space}
Else if (key0 = "fcn" or key0 = "fcn;" or key0 = "FCN")
    str = finance{Space}
Else if (key0 = "flb" or key0 = "flb;" or key0 = "FLB")
    str = belief{Space}
Else if (key0 = "flcbn" or key0 = "flcbn;" or key0 = "FLCBN")
    str = beneficial{Space}
Else if (key0 = "fh" or key0 = "fh;" or key0 = "FH")
    str = helpful{Space}
Else if (key0 = "fgl" or key0 = "fgl;" or key0 = "FGL")
    str = feeling{Space}
Else if (key0 = "fl" or key0 = "fl;" or key0 = "FL")
    str = feel{Space}
Else if (key0 = "flcn" or key0 = "flcn;" or key0 = "FLCN")
    str = financial{Space}
Else if (key0 = "fln" or key0 = "fln;" or key0 = "FLN")
    str = final{Space}
Else if (key0 = "fn" or key0 = "fn;" or key0 = "FN")
    str = fine{Space}
Return

SENDG:
   SentTick = %A_TickCount%            
   SentKeys = %key0% 
if (key0 = "gb" or key0 = "gb;" or key0 = "GB")
    str = being{Space}
Else if (key0 = "gc" or key0 = "gc;" or key0 = "GC")
    str = coming{Space}
Else if (key0 = "gen" or key0 = "gen;" or key0 = "GEN")
    str = general{Space}
Else if (key0 = "ghcn" or key0 = "ghcn;" or key0 = "GHCN")
    str = change{Space}
Else if (key0 = "glbn" or key0 = "glbn;" or key0 = "GLBN")
    str = belong{Space}
Else if (key0 = "gcm" or key0 = "gcm;" or key0 = "GCM")
    str = magic{Space}
Else if (key0 = "gh" or key0 = "gh;" or key0 = "GH")
    str = having{Space}
Else if (key0 = "gkl" or key0 = "gkl;" or key0 = "GKL")
    str = looking{Space}
Else if (key0 = "ghlcn" or key0 = "ghlcn;" or key0 = "GHLCN")
    str = challenge{Space}
Else if (key0 = "gkm" or key0 = "gkm;" or key0 = "GKM")
    str = making{Space}
Else if (key0 = "gl" or key0 = "gl;" or key0 = "GL")
    str = learning{Space}
Else if (key0 = "glc" or key0 = "glc;" or key0 = "GLC")
    str = college{Space}
Else if (key0 = "gln" or key0 = "gln;" or key0 = "GLN")
    str = general{Space}
Else if (key0 = "glv" or key0 = "glv;" or key0 = "GLV")
    str = leaving{Space}
Else if (key0 = "gf" or key0 = "gf;" or key0 = "GF")
    str = girlfriend{Space}
Else if (key0 = "gvn" or key0 = "gvn;" or key0 = "GVN")
    str = given{Space}
Else if (key0 = "gm" or key0 = "gm;" or key0 = "GM")
    str = making{Space}
Else if (key0 = "gn" or key0 = "gn;" or key0 = "GN")
    str = nothing{Space}
Else if (key0 = "gnm" or key0 = "gnm;" or key0 = "GNM")
    str = manage{Space}
Else if (key0 = "gv" or key0 = "gv;" or key0 = "GV")
    str = give{Space}
Else if (key0 = "gv" or key0 = "gv;" or key0 = "GV")
    str = very good{Space}
Else if (key0 = "gvm" or key0 = "gvm;" or key0 = "GVM")
    str = moving{Space}
Else if (key0 = "gx" or key0 = "gx;" or key0 = "GX")
    str = exciting{Space}
Else if (key0 = "gznm" or key0 = "gznm;" or key0 = "GZNM")
    str = magazine{Space}
Return

SENDH:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "hc" or key0 = "hc;" or key0 = "HC")
    str = choice{Space}
Else if (key0 = "hvb" or key0 = "hvb;" or key0 = "HVB")
    str = behave{Space}
Else if (key0 = "hkcn" or key0 = "hkcn;" or key0 = "HKCN")
    str = chicken{Space}
Else if (key0 = "hl" or key0 = "hl;" or key0 = "HL")
    str = he'll{Space}
Else if (key0 = "hlcv" or key0 = "hlcv;" or key0 = "HLCV")
    str = vehicle{Space}
Else if (key0 = "hm" or key0 = "hm;" or key0 = "HM")
    str = Mm-hmm.{Space}
Else if (key0 = "hv" or key0 = "hv;" or key0 = "HV")
    str = have{Space}
Else if (key0 = "hcnm" or key0 = "hcnm;" or key0 = "HCNM")
    str = machine{Space}
Else if (key0 = "hlcn" or key0 = "hlcn;" or key0 = "HLCN")
    str = channel{Space}
Return

SENDI:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "ia" or key0 = "ia;" or key0 = "IA")
    str = ai
Else if (key0 = "idfc" or key0 = "idfc;" or key0 = "IDFC")
    str = difficult{Space}
Else if (key0 = "idm" or key0 = "idm;" or key0 = "IDM")
    str = mid{Space}
Else if (key0 = "iacbn" or key0 = "iacbn;" or key0 = "IACBN")
    str = cabin{Space}
Else if (key0 = "ial" or key0 = "ial;" or key0 = "IAL")
    str = {backspace}ial{Space}
Else if (key0 = "ialcn" or key0 = "ialcn;" or key0 = "IALCN")
    str = clinical{Space}
Else if (key0 = "ialm" or key0 = "ialm;" or key0 = "IALM")
    str = mail{Space}
Else if (key0 = "ialn" or key0 = "ialn;" or key0 = "IALN")
    str = nail{Space}
Else if (key0 = "iasb" or key0 = "iasb;" or key0 = "IASB")
    str = bias{Space}
Else if (key0 = "iasflc" or key0 = "iasflc;" or key0 = "IASFLC")
    str = fascial{Space}
Else if (key0 = "ilb" or key0 = "ilb;" or key0 = "ILB")
    str = bill{Space}
Else if (key0 = "ilcbm" or key0 = "ilcbm;" or key0 = "ILCBM")
    str = climb{Space}
Else if (key0 = "iogbn" or key0 = "iogbn;" or key0 = "IOGBN")
    str = bingo{Space}
Else if (key0 = "iopsn" or key0 = "iopsn;" or key0 = "IOPSN")
    str = poison{Space}
Else if (key0 = "iosdvn" or key0 = "iosdvn;" or key0 = "IOSDVN")
    str = division{Space}
Else if (key0 = "ipafc" or key0 = "ipafc;" or key0 = "IPAFC")
    str = pacific{Space}
Else if (key0 = "isa" or key0 = "isa;" or key0 = "ISA")
    str = asia{Space}
Else if (key0 = "isdh" or key0 = "isdh;" or key0 = "ISDH")
    str = dish{Space}
Else if (key0 = "isdh" or key0 = "isdh;" or key0 = "ISDH")
    str = dish{Space}
Else if (key0 = "isdkn" or key0 = "isdkn;" or key0 = "ISDKN")
    str = kinds{Space}
Else if (key0 = "iahcn" or key0 = "iahcn;" or key0 = "IAHCN")
    str = China{Space}
Else if (key0 = "ias" or key0 = "ias;" or key0 = "IAS")
    str = Asia{Space}
Else if (key0 = "ialnm" or key0 = "ialnm;" or key0 = "IALNM")
    str = animal{Space}
Else if (key0 = "iahcn" or key0 = "iahcn;" or key0 = "IAHCN")
    str = chain{Space}
Else if (key0 = "iam" or key0 = "iam;" or key0 = "IAM")
    str = aim{Space}
Else if (key0 = "iasl" or key0 = "iasl;" or key0 = "IASL")
    str = sail{Space}
Else if (key0 = "iav" or key0 = "iav;" or key0 = "IAV")
    str = via{Space}
Else if (key0 = "igkln" or key0 = "igkln;" or key0 = "IGKLN")
    str = inkling{Space}
Else if (key0 = "iol" or key0 = "iol;" or key0 = "IOL")
    str = oil{Space}
Else if (key0 = "iolbm" or key0 = "iolbm;" or key0 = "IOLBM")
    str = limbo{Space}
Else if (key0 = "iphc" or key0 = "iphc;" or key0 = "IPHC")
    str = chip{Space}
Else if (key0 = "ipl" or key0 = "ipl;" or key0 = "IPL")
    str = pill{Space}
Else if (key0 = "ipsn" or key0 = "ipsn;" or key0 = "IPSN")
    str = spin{Space}
Else if (key0 = "iskl" or key0 = "iskl;" or key0 = "ISKL")
    str = skill{Space}
Else if (key0 = "ixm" or key0 = "ixm;" or key0 = "IXM")
    str = mix{Space}
Else if (key0 = "ian" or key0 = "ian;" or key0 = "IAN")
    str = {BackSpace}ian{Space}
Else if (key0 = "iafl" or key0 = "iafl;" or key0 = "IAFL")
    str = fail{Space}
Else if (key0 = "ipslbm" or key0 = "ipslbm;" or key0 = "IPSLBM")
    str = impossible{Space}
Else if (key0 = "ioa" or key0 = "ioa;" or key0 = "IOA")
    str = {BackSpace}ation{Space}
Else if (key0 = "ioadv" or key0 = "ioadv;" or key0 = "IOADV")
    str = avoid{Space}
Else if (key0 = "igz" or key0 = "igz;" or key0 = "IGZ")
    str = {BackSpace}izing{Space}
Else if (key0 = "iadc" or key0 = "iadc;" or key0 = "IADC")
    str = acid{Space}
Else if (key0 = "iagcm" or key0 = "iagcm;" or key0 = "IAGCM")
    str = magic{Space}
Else if (key0 = "idg" or key0 = "idg;" or key0 = "IDG")
    str = dig{Space}
Else if (key0 = "iflcn" or key0 = "iflcn;" or key0 = "IFLCN")
    str = influence{Space}
Else if (key0 = "ikc" or key0 = "ikc;" or key0 = "IKC")
    str = kick{Space}
Else if (key0 = "ikn" or key0 = "ikn;" or key0 = "IKN")
    str = ink{Space}
Else if (key0 = "inm" or key0 = "inm;" or key0 = "INM")
    str = mini{Space}
Else if (key0 = "ioadnm" or key0 = "ioadnm;" or key0 = "IOADNM")
    str = domain{Space}
Else if (key0 = "iodb" or key0 = "iodb;" or key0 = "IODB")
    str = biodegradable{Space}
Else if (key0 = "iodv" or key0 = "iodv;" or key0 = "IODV")
    str = void{Space}
Else if (key0 = "iom" or key0 = "iom;" or key0 = "IOM")
    str = in my opinion{Space}
Else if (key0 = "iosdl" or key0 = "iosdl;" or key0 = "IOSDL")
    str = solid{Space}
Else if (key0 = "ips" or key0 = "ips;" or key0 = "IPS")
    str = piss{Space}
Else if (key0 = "ipsgl" or key0 = "ipsgl;" or key0 = "IPSGL")
    str = slipping{Space}
Else if (key0 = "ipsl" or key0 = "ipsl;" or key0 = "IPSL")
    str = slip{Space}
Else if (key0 = "ipsl" or key0 = "ipsl;" or key0 = "IPSL")
    str = slip{Space}
Else if (key0 = "iajl" or key0 = "iajl;" or key0 = "IAJL")
    str = jail{Space}
Else if (key0 = "iagn" or key0 = "iagn;" or key0 = "IAGN")
    str = gain{Space}
Else if (key0 = "ib" or key0 = "ib;" or key0 = "IB")
    str = no{Space}
Else if (key0 = "iadlv" or key0 = "iadlv;" or key0 = "IADLV")
    str = valid{Space}
Else if (key0 = "ioan" or key0 = "ioan;" or key0 = "IOAN")
    str = nation{Space}
Else if (key0 = "ishcm" or key0 = "ishcm;" or key0 = "ISHCM")
    str = schism{Space}
Else if (key0 = "iasb" or key0 = "iasb;" or key0 = "IASB")
    str = basis{Space}
Else if (key0 = "iaslc" or key0 = "iaslc;" or key0 = "IASLC")
    str = classic{Space}
Else if (key0 = "ihcn" or key0 = "ihcn;" or key0 = "IHCN")
    str = inch{Space}
Else if (key0 = "ikl" or key0 = "ikl;" or key0 = "IKL")
    str = kill{Space}
Else if (key0 = "ilcn" or key0 = "ilcn;" or key0 = "ILCN")
    str = clinic{Space}
Else if (key0 = "iofn" or key0 = "iofn;" or key0 = "IOFN")
    str = info{Space}
Else if (key0 = "iphn" or key0 = "iphn;" or key0 = "IPHN")
    str = iphone{Space}
Else if (key0 = "iskn" or key0 = "iskn;" or key0 = "ISKN")
    str = skin{Space}
Else if (key0 = "ism" or key0 = "ism;" or key0 = "ISM")
    str = miss{Space}
Else if (key0 = "iadnm" or key0 = "iadnm;" or key0 = "IADNM")
    str = admin{Space}
Else if (key0 = "iasdnm" or key0 = "iasdnm;" or key0 = "IASDNM")
    str = administrator{Space}
Else if (key0 = "igm" or key0 = "igm;" or key0 = "IGM")
    str = image{Space}
Else if (key0 = "ikln" or key0 = "ikln;" or key0 = "IKLN")
    str = link{Space}
Else if (key0 = "ioadnm" or key0 = "ioadnm;" or key0 = "IOADNM")
    str = administration{Space}
Else if (key0 = "isn" or key0 = "isn;" or key0 = "ISN")
    str = isn't{Space}
Else if (key0 = "ialcm" or key0 = "ialcm;" or key0 = "IALCM")
    str = claim{Space}
Else if (key0 = "ianm" or key0 = "ianm;" or key0 = "IANM")
    str = main{Space}
Else if (key0 = "iasd" or key0 = "iasd;" or key0 = "IASD")
    str = said{Space}
Else if (key0 = "id" or key0 = "id;" or key0 = "ID")
    str = did{Space}
Else if (key0 = "idf" or key0 = "idf;" or key0 = "IDF")
    str = different{Space}
Else if (key0 = "idfn" or key0 = "idfn;" or key0 = "IDFN")
    str = find{Space}
Else if (key0 = "idhlc" or key0 = "idhlc;" or key0 = "IDHLC")
    str = child{Space}
Else if (key0 = "idk" or key0 = "idk;" or key0 = "IDK")
    str = I don't know{Space}
Else if (key0 = "idkn" or key0 = "idkn;" or key0 = "IDKN")
    str = kind{Space}
Else if (key0 = "idn" or key0 = "idn;" or key0 = "IDN")
    str = individual{Space}
Else if (key0 = "idnm" or key0 = "idnm;" or key0 = "IDNM")
    str = mind{Space}
Else if (key0 = "if" or key0 = "if;" or key0 = "IF")
    str = if{Space}
Else if (key0 = "ifl" or key0 = "ifl;" or key0 = "IFL")
    str = fill{Space}
Else if (key0 = "ifx" or key0 = "ifx;" or key0 = "IFX")
    str = fix{Space}
Else if (key0 = "ig" or key0 = "ig;" or key0 = "IG")
    str = I guess{Space}
Else if (key0 = "igb" or key0 = "igb;" or key0 = "IGB")
    str = big{Space}
Else if (key0 = "igh" or key0 = "igh;" or key0 = "IGH")
    str = high{Space}
Else if (key0 = "iglv" or key0 = "iglv;" or key0 = "IGLV")
    str = living{Space}
Else if (key0 = "ign" or key0 = "ign;" or key0 = "IGN")
    str = {BackSpace}ing{Space}
Else if (key0 = "ihl" or key0 = "ihl;" or key0 = "IHL")
    str = hill{Space}
Else if (key0 = "ihm" or key0 = "ihm;" or key0 = "IHM")
    str = him{Space}
Else if (key0 = "ik" or key0 = "ik;" or key0 = "IK")
    str = I know{Space}
Else if (key0 = "iklbn" or key0 = "iklbn;" or key0 = "IKLBN")
    str = blink{Space}
Else if (key0 = "iklc" or key0 = "iklc;" or key0 = "IKLC")
    str = click{Space}
Else if (key0 = "iklm" or key0 = "iklm;" or key0 = "IKLM")
    str = milk{Space}
Else if (key0 = "il" or key0 = "il;" or key0 = "IL")
    str = I'll{Space}
Else if (key0 = "ilv" or key0 = "ilv;" or key0 = "ILV")
    str = live{Space}
Else if (key0 = "im" or key0 = "im;" or key0 = "IM")
    str = I'm{Space}
Else if (key0 = "in" or key0 = "in;" or key0 = "IN")
    str = in{Space}
Else if (key0 = "in" or key0 = "in;" or key0 = "IN")
    str = in{Space}
Else if (key0 = "io" or key0 = "io;" or key0 = "IO")
    str = {BackSpace}tion{Space}
Else if (key0 = "ioac" or key0 = "ioac;" or key0 = "IOAC")
    str = action{Space}
Else if (key0 = "ioalc" or key0 = "ioalc;" or key0 = "IOALC")
    str = location{Space}
Else if (key0 = "iojn" or key0 = "iojn;" or key0 = "IOJN")
    str = join{Space}
Else if (key0 = "ion" or key0 = "ion;" or key0 = "ION")
    str = {BackSpace}ion{Space}
Else if (key0 = "ionm" or key0 = "ionm;" or key0 = "IONM")
    str = omni
Else if (key0 = "iop" or key0 = "iop;" or key0 = "IOP")
    str = option{Space}
Else if (key0 = "iopn" or key0 = "iopn;" or key0 = "IOPN")
    str = opinion{Space}
Else if (key0 = "iosn" or key0 = "iosn;" or key0 = "IOSN")
    str = {BackSpace}sion{Space}
Else if (key0 = "iosn" or key0 = "iosn;" or key0 = "IOSN")
    str = ision{Space}
Else if (key0 = "ipad" or key0 = "ipad;" or key0 = "IPAD")
    str = paid{Space}
Else if (key0 = "ipafn" or key0 = "ipafn;" or key0 = "IPAFN")
    str = painful{Space}
Else if (key0 = "ipan" or key0 = "ipan;" or key0 = "IPAN")
    str = pain{Space}
Else if (key0 = "ipfl" or key0 = "ipfl;" or key0 = "IPFL")
    str = flip{Space}
Else if (key0 = "ipg" or key0 = "ipg;" or key0 = "IPG")
    str = pig{Space}
Else if (key0 = "ipkc" or key0 = "ipkc;" or key0 = "IPKC")
    str = pick{Space}
Else if (key0 = "ipm" or key0 = "ipm;" or key0 = "IPM")
    str = important{Space}
Else if (key0 = "ipsh" or key0 = "ipsh;" or key0 = "IPSH")
    str = {BackSpace}ship{Space}
Else if (key0 = "ipsk" or key0 = "ipsk;" or key0 = "IPSK")
    str = skip{Space}
Else if (key0 = "is" or key0 = "is;" or key0 = "IS")
    str = is{Space}
Else if (key0 = "isd" or key0 = "isd;" or key0 = "ISD")
    str = dis
Else if (key0 = "isdk" or key0 = "isdk;" or key0 = "ISDK")
    str = kids{Space}
Else if (key0 = "isfhn" or key0 = "isfhn;" or key0 = "ISFHN")
    str = finish{Space}
Else if (key0 = "isg" or key0 = "isg;" or key0 = "ISG")
    str = significant{Space}
Else if (key0 = "isgn" or key0 = "isgn;" or key0 = "ISGN")
    str = sign{Space}
Else if (key0 = "ish" or key0 = "ish;" or key0 = "ISH")
    str = his{Space}
Else if (key0 = "ish" or key0 = "ish;" or key0 = "ISH")
    str = {BackSpace}ish{Space}
Else if (key0 = "iskc" or key0 = "iskc;" or key0 = "ISKC")
    str = sick{Space}
Else if (key0 = "ism" or key0 = "ism;" or key0 = "ISM")
    str = mis
Else if (key0 = "iflm" or key0 = "iflm;" or key0 = "IFLM")
    str = film{Space}
Return

SENDL:
   SentTick = %A_TickCount%            
   SentKeys = %key0% 
if (key0 = "lb" or key0 = "lb;" or key0 = "LB")
    str = little bit{Space}
Else if (key0 = "lc" or key0 = "lc;" or key0 = "LC")
    str = cool{Space}
Else if (key0 = "lcnm" or key0 = "lcnm;" or key0 = "LCNM")
    str = column{Space}
Else if (key0 = "lxcm" or key0 = "lxcm;" or key0 = "LXCM")
    str = exclaim{Space}
Else if (key0 = "lcbn" or key0 = "lcbn;" or key0 = "LCBN")
    str = balance{Space}
Else if (key0 = "lnm" or key0 = "lnm;" or key0 = "LNM")
    str = manual{Space}
Else if (key0 = "lvm" or key0 = "lvm;" or key0 = "LVM")
    str = volume{Space}
Else if (key0 = "lcn" or key0 = "lcn;" or key0 = "LCN")
    str = clean{Space}
Else if (key0 = "lcbn" or key0 = "lcbn;" or key0 = "LCBN")
    str = balance{Space}
Else if (key0 = "lcm" or key0 = "lcm;" or key0 = "LCM")
    str = molecule{Space}
Else if (key0 = "ln" or key0 = "ln;" or key0 = "LN")
    str = line{Space}
Else if (key0 = "lv" or key0 = "lv;" or key0 = "LV")
    str = leave{Space}
Else if (key0 = "lvb" or key0 = "lvb;" or key0 = "LVB")
    str = believe{Space}
Else if (key0 = "lx" or key0 = "lx;" or key0 = "LX")
    str = exactly{Space}
Else if (key0 = "lxcn" or key0 = "lxcn;" or key0 = "LXCN")
    str = excellence{Space}
Return

SENDX:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "xc" or key0 = "xc;" or key0 = "XC")
    str = executive{Space}
Else if (key0 = "xnm" or key0 = "xnm;" or key0 = "XNM")
    str = examine{Space}
Else if (key0 = "xnm" or key0 = "xnm;" or key0 = "XNM")
    str = expect{Space}
Return

SENDV:
   SentTick = %A_TickCount%            
if (key0 = "vm" or key0 = "vm;" or key0 = "VM")
    str = move{Space}
Else if (key0 = "vn" or key0 = "vn;" or key0 = "VN")
    str = even{Space}
Return

SENDB:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
if (key0 = "bm" or key0 = "bm;" or key0 = "BM")
    str = maybe{Space}
Else if (key0 = "bf" or key0 = "bf;" or key0 = "BF")
    str = boyfriend{Space}
Else if (key0 = "bn" or key0 = "bn;" or key0 = "BN")
    str = been{Space}
Else if (key0 = "bsc" or key0 = "bsc;" or key0 = "BSC")
    str = basic{Space}
Else if (key0 = "bscl" or key0 = "bscl;" or key0 = "BSCL")
    str = basically{Space}
Return

SENDC:
   SentTick = %A_TickCount%          
   SentKeys = %key0%
if (key0 = "cb" or key0 = "cb;" or key0 = "CB")
    str = because{Space}
Else if (key0 = "cbm" or key0 = "cbm;" or key0 = "CBM")
    str = become{Space}
Else if (key0 = "cm" or key0 = "cm;" or key0 = "CM")
    str = come{Space}
Else if (key0 = "dfcn" or key0 = "dfcn;" or key0 = "DFCN")
    str = confidence{Space}
Else if (key0 = "cbnm" or key0 = "cbnm;" or key0 = "CBNM")
    str = combine{Space}
Else if (key0 = "cmg" or key0 = "cmg;" or key0 = "CMG")
    str = coming{Space}
Else if (key0 = "cn" or key0 = "cn;" or key0 = "CN")
    str = can{Space}
Else if (key0 = "cnm" or key0 = "cnm;" or key0 = "CNM")
    str = common{Space}
Else if (key0 = "cvn" or key0 = "cvn;" or key0 = "CVN")
    str = conversation{Space}
Return

SENDK:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "kc" or key0 = "kc;" or key0 = "KC")
    str = {Backspace}ck{Space}
Else if (key0 = "kl" or key0 = "kl;" or key0 = "KL")
    str = look{Space}
Else if (key0 = "kln" or key0 = "kln;" or key0 = "KLN")
    str = knowledge{Space}
Else if (key0 = "km" or key0 = "km;" or key0 = "KM")
    str = make{Space}
Else if (key0 = "kn" or key0 = "kn;" or key0 = "KN")
    str = know{Space}
Return

SENDJ:
   SentTick = %A_TickCount%            
   SentKeys = %key0% 
    
Return
 
SENDZ:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "zm" or key0 = "zm;" or key0 = "ZM")
    str = zoom{Space}
Return

SENDM:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 
Return

SENDN:
   SentTick = %A_TickCount%            
   SentKeys = %key0%
 if (key0 = "nm" or key0 = "nm;" or key0 = "NM")
    str = mean{Space}
Return

SENDDOT:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%

If (key0 = "r'" or key0 = "r';" or key0 = "R'")
    str = {BackSpace}r{Space}
Else if (key0 = "udn." or key0 = "udn.;" or key0 = "UDN>")
    str = understood{Space}
Else if (key0 = "yc." or key0 = "yc.;" or key0 = "YC>")
    str = {BackSpace}{BackSpace}cy{Space}
Else if (key0 = "artl." or key0 = "artl.;" or key0 = "ARTL.")
    str = alter{Space}
Else if (key0 = "eaflm." or key0 = "eaflm.;" or key0 = "EAFLM.")
    str = flame{Space}
Else if (key0 = "ealcn." or key0 = "ealcn.;" or key0 = "EALCN.")
    str = clean{Space}
Else if (key0 = "erag." or key0 = "erag.;" or key0 = "ERAG.")
    str = rage{Space}
Else if (key0 = "eidv." or key0 = "eidv.;" or key0 = "EIDV.")
    str = divide{Space}
Else if (key0 = "etal." or key0 = "etal.;" or key0 = "ETAL.")
    str = tale{Space}
Else if (key0 = "erpsv." or key0 = "erpsv.;" or key0 = "ERPSV.")
    str = persevere{Space}
Else if (key0 = "rtlcn." or key0 = "rtlcn.;" or key0 = "RTLCN.")
    str = central{Space}
Else if (key0 = "etid." or key0 = "etid.;" or key0 = "ETID.")
    str = tide{Space}
Else if (key0 = "etiscn." or key0 = "etiscn.;" or key0 = "ETISCN.")
    str = insect{Space}
Else if (key0 = "eridn." or key0 = "eridn.;" or key0 = "ERIDN.")
    str = diner{Space}
Else if (key0 = "od." or key0 = "od.;" or key0 = "OD.")
    str = odd{Space}
Else if (key0 = "uohc." or key0 = "uohc.;" or key0 = "UOHC.")
    str = couch{Space}
Else if (key0 = "wdan." or key0 = "wdan.;" or key0 = "WDAN.")
    str = dawn{Space}
Else if (key0 = "tihn." or key0 = "tihn.;" or key0 = "TIHN.")
    str = hint{Space}
Else if (key0 = "wton." or key0 = "wton.;" or key0 = "WTON.")
    str = won't{Space}
Else if (key0 = "yil." or key0 = "yil.;" or key0 = "YIL.")
    str = {backspace}{backspace}ily{Space}
Else if (key0 = "wetas." or key0 = "wetas.;" or key0 = "WETAS.")
    str = sweat{Space}
Else if (key0 = "tpc." or key0 = "tpc.;" or key0 = "TPC.")
    str = capacity{Space}
Else if (key0 = "tlsn." or key0 = "tlsn.;" or key0 = "TLSN.")
    str = solution{Space}
Else if (key0 = "euasc." or key0 = "euasc.;" or key0 = "EUASC.")
    str = sauce{Space}
Else if (key0 = "rtlvn." or key0 = "rtlvn.;" or key0 = "RTLVN.")
    str = revolution{Space}
Else if (key0 = "tasc." or key0 = "tasc.;" or key0 = "TASC.")
    str = associate{Space}
Else if (key0 = "rtuogh." or key0 = "rtuogh.;" or key0 = "RTUOGH.")
    str = thorough{Space}
Else if (key0 = "rohn." or key0 = "rohn.;" or key0 = "ROHN.")
    str = horn{Space}
Else if (key0 = "rsdcn." or key0 = "rsdcn.;" or key0 = "RSDCN.")
    str = discern{Space}
Else if (key0 = "rio." or key0 = "rio.;" or key0 = "RIO.")
    str = {backspace}{backspace}ior{Space}
Else if (key0 = "osn." or key0 = "osn.;" or key0 = "OSN.")
    str = son{Space}
Else if (key0 = "ial." or key0 = "ial.;" or key0 = "IAL.")
    str = {backspace}{backspace}ial{Space}
Else if (key0 = "eipsc." or key0 = "eipsc.;" or key0 = "EIPSC.")
    str = species{Space}
Else if (key0 = "ty." or key0 = "ty.;" or key0 = "ty>")
    str = {BackSpace}ty{Space}
Else if (key0 = "werth." or key0 = "werth.;" or key0 = "WERTH>")
    str = threw{Space}
Else if (key0 = "eiosn." or key0 = "eiosn.;" or key0 = "EIOSN>")
    str = session{Space}
Else if (key0 = "rsv." or key0 = "rsv.;" or key0 = "RSV>")
    str = verse{Space}
Else if (key0 = "onm." or key0 = "onm.;" or key0 = "ONM>")
    str = moon{Space}
Else if (key0 = "eri." or key0 = "eri.;" or key0 = "ERI>")
    str = {BackSpace}{BackSpace}ier{Space}
Else if (key0 = "rsv'" or key0 = "rsv';" or key0 = "RSV'")
    str = verse{Space}
Else if (key0 = "tasl." or key0 = "tasl.;" or key0 = "TASL>")
    str = salt{Space}
Else if (key0 = "ertah." or key0 = "ertah.;" or key0 = "ERTAH>")
    str = earth{Space}
Else if (key0 = "us." or key0 = "us.;" or key0 = "US>")
    str = United States{Space}
Else if (key0 = "uosdn." or key0 = "uosdn.;" or key0 = "UOSDN>")
    str = sounds{Space}
Else if (key0 = "tasl." or key0 = "tasl.;" or key0 = "TASL>")
    str = last{Space}
Else if (key0 = "tioan." or key0 = "tioan.;" or key0 = "TIOAN>")
    str = {BackSpace}{BackSpace}ation{Space}
Else if (key0 = "epsd." or key0 = "epsd.;" or key0 = "EPSD>")
    str = speed{Space}
Else if (key0 = "iadn." or key0 = "iadn.;" or key0 = "IADN>")
    str = Indian{Space}
Else if (key0 = "eas." or key0 = "eas.;" or key0 = "EAS>")
    str = sea{Space}
Else if (key0 = "tisl." or key0 = "tisl.;" or key0 = "TISL>")
    str = list{Space}
Else if (key0 = "eragn." or key0 = "eragn.;" or key0 = "ERAGN>")
    str = arrange{Space}
Else if (key0 = "erp'" or key0 = "erp';" or key0 = "ERP'")
    str = pepper{Space}
Else if (key0 = "epa." or key0 = "epa.;" or key0 = "EPA>")
    str = pea{Space}
Else if (key0 = "eadh." or key0 = "eadh.;" or key0 = "EADH>")
    str = ahead{Space}
Else if (key0 = "ajn." or key0 = "ajn.;" or key0 = "AJN>")
    str = January{Space}
Else if (key0 = "edc." or key0 = "edc.;" or key0 = "EDC>")
    str = December{Space}
Else if (key0 = "efb." or key0 = "efb.;" or key0 = "EFB>")
    str = February{Space}
Else if (key0 = "erign." or key0 = "erign.;" or key0 = "ERIGN>")
    str = reign{Space}
Else if (key0 = "erin." or key0 = "erin.;" or key0 = "ERIN>")
    str = rein{Space}
Else if (key0 = "eros." or key0 = "eros.;" or key0 = "EROS>")
    str = sore{Space}
Else if (key0 = "ersv." or key0 = "ersv.;" or key0 = "ERSV>")
    str = severe{Space}
Else if (key0 = "ertihn." or key0 = "ertihn.;" or key0 = "ERTIHN>")
    str = inherit{Space}
Else if (key0 = "eryal." or key0 = "eryal.;" or key0 = "ERYAL>")
    str = relay{Space}
Else if (key0 = "etask." or key0 = "etask.;" or key0 = "ETASK>")
    str = steak{Space}
Else if (key0 = "ethm." or key0 = "ethm.;" or key0 = "ETHM>")
    str = theme{Space}
Else if (key0 = "etivn." or key0 = "etivn.;" or key0 = "ETIVN>")
    str = invent{Space}
Else if (key0 = "etps." or key0 = "etps.;" or key0 = "ETPS>")
    str = September{Space}
Else if (key0 = "etups." or key0 = "etups.;" or key0 = "ETUPS>")
    str = setup{Space}
Else if (key0 = "eus." or key0 = "eus.;" or key0 = "EUS>")
    str = sue{Space}
Else if (key0 = "iskn." or key0 = "iskn.;" or key0 = "ISKN>")
    str = sink{Space}
Else if (key0 = "ovn." or key0 = "ovn.;" or key0 = "OVN>")
    str = November{Space}
Else if (key0 = "rahcm." or key0 = "rahcm.;" or key0 = "RAHCM>")
    str = March{Space}
Else if (key0 = "udn." or key0 = "udn.;" or key0 = "UDN>")
    str = understood{Space}
Else if (key0 = "wra." or key0 = "wra.;" or key0 = "WRA>")
    str = raw{Space}
Else if (key0 = "tian'" or key0 = "tian';" or key0 = "TIAN'")
    str = ain’t{Space}
Else if (key0 = "yam." or key0 = "yam.;" or key0 = "YAM>")
    str = May{Space}
Else if (key0 = "adh." or key0 = "adh.;" or key0 = "ADH>")
    str = dah{Space}
Else if (key0 = "uag." or key0 = "uag.;" or key0 = "UAG>")
    str = August{Space}
Else if (key0 = "tush." or key0 = "tush.;" or key0 = "TUSH>")
    str = thus{Space}
Else if (key0 = "toc." or key0 = "toc.;" or key0 = "TOC>")
    str = October{Space}
Else if (key0 = "tsfcn." or key0 = "tsfcn.;" or key0 = "TSFCN>")
    str = fascinate{Space}
Else if (key0 = "ertial." or key0 = "ertial.;" or key0 = "ERTIAL>")
    str = literal{Space}
Else if (key0 = "ian." or key0 = "ian.;" or key0 = "IAN>")
    str = {BackSpace}{BackSpace}ian{Space}
Else if (key0 = "iofn." or key0 = "iofn.;" or key0 = "IOFN>")
    str = information{Space}
Else if (key0 = "rpdc." or key0 = "rpdc.;" or key0 = "RPDC>")
    str = procedure{Space}
Else if (key0 = "ion." or key0 = "ion.;" or key0 = "ION>")
    str = {BackSpace}{BackSpace}ion{Space}
Else if (key0 = "asd." or key0 = "asd.;" or key0 = "ASD>")
    str = sad{Space}
Else if (key0 = "rpgm." or key0 = "rpgm.;" or key0 = "RPGM>")
    str = programmer{Space}
Else if (key0 = "etas'" or key0 = "etas';" or key0 = "ETAS'")
    str = east{Space}
Else if (key0 = "ioa." or key0 = "ioa.;" or key0 = "IOA>")
    str = {BackSpace}{BackSpace}ation{Space}
Else if (key0 = "etn." or key0 = "etn.;" or key0 = "ETN>")
    str = {BackSpace}ent{Space}
Else if (key0 = "epasc." or key0 = "epasc.;" or key0 = "EPASC>")
    str = escape{Space}
Else if (key0 = "alb." or key0 = "alb.;" or key0 = "ALB>")
    str = ball{Space}
Else if (key0 = "wton'" or key0 = "wton';" or key0 = "WTON'")
    str = won't{Space}
Else if (key0 = "ok'" or key0 = "ok';" or key0 = "OK'")
    str = okay{Space}
Else if (key0 = "epsl." or key0 = "epsl.;" or key0 = "EPSL>")
    str = spell{Space}
Else if (key0 = "eops." or key0 = "eops.;" or key0 = "EOPS>")
    str = oppose{Space}
Else if (key0 = "erias." or key0 = "erias.;" or key0 = "ERIAS>")
    str = easier{Space}
Else if (key0 = "tkn." or key0 = "tkn.;" or key0 = "TKN>")
    str = taken{Space}
Else if (key0 = "erashc." or key0 = "erashc.;" or key0 = "ERASHC>")
    str = research{Space}
Else if (key0 = "flcn." or key0 = "flcn.;" or key0 = "FLCN>")
    str = influence{Space}
Else if (key0 = "lcn." or key0 = "lcn.;" or key0 = "LCN>")
    str = council{Space}
Else if (key0 = "ro." or key0 = "ro.;" or key0 = "RO>")
    str = {backspace}or{Space}
Else if (key0 = "tnm." or key0 = "tnm.;" or key0 = "TNM>")
    str = mountain{Space}
Else if (key0 = "ef." or key0 = "ef.;" or key0 = "EF>")
    str = fee{Space}
Else if (key0 = "rplcn." or key0 = "rplcn.;" or key0 = "RPLCN>")
    str = principal{Space}
Else if (key0 = "etam." or key0 = "etam.;" or key0 = "ETAM>")
    str = meat{Space}
Else if (key0 = "ogl." or key0 = "ogl.;" or key0 = "OGL>")
    str = logging{Space}
Else if (key0 = "ozm." or key0 = "ozm.;" or key0 = "OZM>")
    str = zoom{Space}
Else if (key0 = "qrts." or key0 = "qrts.;" or key0 = "QRTS>")
    str = squirt{Space}
Else if (key0 = "ram." or key0 = "ram.;" or key0 = "RAM>")
    str = ram{Space}
Else if (key0 = "rdg." or key0 = "rdg.;" or key0 = "RDG>")
    str = grade{Space}
Else if (key0 = "flcn." or key0 = "flcn.;" or key0 = "FLCN>")
    str = influence{Space}
Else if (key0 = "rgnm." or key0 = "rgnm.;" or key0 = "RGNM>")
    str = manager{Space}
Else if (key0 = "rslv." or key0 = "rslv.;" or key0 = "RSLV>")
    str = resolve{Space}
Else if (key0 = "rsvn." or key0 = "rsvn.;" or key0 = "RSVN>")
    str = nervous{Space}
Else if (key0 = "rtfg." or key0 = "rtfg.;" or key0 = "RTFG>")
    str = forgot{Space}
Else if (key0 = "rtsg." or key0 = "rtsg.;" or key0 = "RTSG>")
    str = string{Space}
Else if (key0 = "wal." or key0 = "wal.;" or key0 = "WAL>")
    str = wall{Space}
Else if (key0 = "ruos." or key0 = "ruos.;" or key0 = "RUOS>")
    str = sour{Space}
Else if (key0 = "slcn." or key0 = "slcn.;" or key0 = "SLCN>")
    str = silence{Space}
Else if (key0 = "slv." or key0 = "slv.;" or key0 = "SLV>")
    str = solve{Space}
Else if (key0 = "tac." or key0 = "tac.;" or key0 = "TAC>")
    str = cat{Space}
Else if (key0 = "tcn." or key0 = "tcn.;" or key0 = "TCN>")
    str = contain{Space}
Else if (key0 = "tiac." or key0 = "tiac.;" or key0 = "TIAC>")
    str = {backspace}atic{Space}
Else if (key0 = "tian." or key0 = "tian.;" or key0 = "TIAN>")
    str = taint{Space}
Else if (key0 = "wo." or key0 = "wo.;" or key0 = "WO>")
    str = wow{Space}
Else if (key0 = "yas." or key0 = "yas.;" or key0 = "YAS>")
    str = says{Space}
Else if (key0 = "ypal." or key0 = "ypal.;" or key0 = "YPAL>")
    str = apply{Space}
Else if (key0 = "l'" or key0 = "l';" or key0 = "L'")
    str = {backspace}‘ll{Space}
Else if (key0 = "ghcn." or key0 = "ghcn.;" or key0 = "GHCN>")
    str = changing{Space}
Else if (key0 = "in." or key0 = "in.;" or key0 = "IN>")
    str = in
Else if (key0 = "idk." or key0 = "idk.;" or key0 = "IDK>")
    str = kid{Space}
Else if (key0 = "gln." or key0 = "gln.;" or key0 = "GLN>")
    str = language lng.{Space}
Else if (key0 = "eshl." or key0 = "eshl.;" or key0 = "ESHL>")
    str = she'll{Space}
Else if (key0 = "e'v" or key0 = "e'v;" or key0 = "E'V")
    str = {backspace}‘ve{Space}
Else if (key0 = "etsg." or key0 = "etsg.;" or key0 = "ETSG>")
    str = settings{Space}
Else if (key0 = "esc." or key0 = "esc.;" or key0 = "ESC>")
    str = escape{Space}
Else if (key0 = "ergm." or key0 = "ergm.;" or key0 = "ERGM>")
    str = emerge{Space}
Else if (key0 = "rtuogh." or key0 = "rtuogh.;" or key0 = "RTUOGH>")
    str = thorough{Space}
Else if (key0 = "ealb." or key0 = "ealb.;" or key0 = "EALB>")
    str = {backspace}able{Space}
Else if (key0 = "ealb." or key0 = "ealb.;" or key0 = "EALB>")
    str = {backspace}able{Space}
Else if (key0 = "wto'" or key0 = "wto';" or key0 = "WTO'")
    str = two{Space}
Else if (key0 = "epal." or key0 = "epal.;" or key0 = "EPAL>")
    str = appeal{Space}
Else if (key0 = "ets'" or key0 = "ets';" or key0 = "ETS'")
    str = {BackSpace}{BackSpace}est{Space}
Else if (key0 = "er'" or key0 = "er';" or key0 = "ER'")
    str = {backspace}‘re{Space}
Else if (key0 = "eiasl." or key0 = "eiasl.;" or key0 = "EIASL>")
    str = liaise{Space}
Else if (key0 = "erakb." or key0 = "erakb.;" or key0 = "ERAKB>")
    str = brake{Space}
Else if (key0 = "tvm." or key0 = "tvm.;" or key0 = "TVM>")
    str = motivate{Space}
Else if (key0 = "era." or key0 = "era.;" or key0 = "ERA>")
    str = rear{Space}
Else if (key0 = "rtdc." or key0 = "rtdc.;" or key0 = "RTDC>")
    str = direct{Space}
Else if (key0 = "era'" or key0 = "era';" or key0 = "ERA'")
    str = era{Space}
Else if (key0 = "tuogh." or key0 = "tuogh.;" or key0 = "TUOGH>")
    str = ought{Space}
Else if (key0 = "d." or key0 = "d.;" or key0 = "D>")
    str ={backspace}d{Space}
Else if (key0 = "hm." or key0 = "hm.;" or key0 = "HM>")
    str = Mm-mmm.{Space}
Else if (key0 = "ign." or key0 = "ign.;" or key0 = "IGN>")
    str = {backspace}{backspace}ing{Space}
Else if (key0 = "esl." or key0 = "esl.;" or key0 = "ESL>")
    str = less{Space}
Else if (key0 = "etan." or key0 = "etan.;" or key0 = "ETAN>")
    str = tenant{Space}
Else if (key0 = "rtfh." or key0 = "rtfh.;" or key0 = "RTFH>")
    str = further{Space}
Else if (key0 = "tivn." or key0 = "tivn.;" or key0 = "TIVN>")
    str = invite{Space}
Else if (key0 = "esdn." or key0 = "esdn.;" or key0 = "ESDN>")
    str = dense{Space}
Else if (key0 = "erias" or key0 = "erias;" or key0 = "ERIAS")
    str = easier{Space}
Else if (key0 = "rtln." or key0 = "rtln.;" or key0 = "RTLN>")
    str = natural{Space}
Else if (key0 = ".ertpsn" or key0 = ".ertpsn;" or key0 = ".ERTPSN")
    str = represent{Space}
Else if (key0 = "erf." or key0 = "erf.;" or key0 = "ERF>")
    str = refer{Space}
Else if (key0 = "eru." or key0 = "eru.;" or key0 = "ERU>")
    str = {backspace}ure{Space}
Else if (key0 = "etsh." or key0 = "etsh.;" or key0 = "ETSH>")
    str = sheet{Space}
Else if (key0 = "on." or key0 = "on.;" or key0 = "ON>")
    str = no{Space}
Else if (key0 = "rtipn." or key0 = "rtipn.;" or key0 = "RTIPN>")
    str = interrupt{Space}
Else if (key0 = "tas." or key0 = "tas.;" or key0 = "TAS>")
    str = asset{Space}
Else if (key0 = "scnm." or key0 = "scnm.;" or key0 = "SCNM>")
    str = musician{Space}
Else if (key0 = "tgvn." or key0 = "tgvn.;" or key0 = "TGVN>")
    str = vintage{Space}
Else if (key0 = "rtsg." or key0 = "rtsg.;" or key0 = "RTSG>")
    str = register{Space}
Else if (key0 = "eivn." or key0 = "eivn.;" or key0 = "EIVN>")
    str = vine{Space}
Else if (key0 = "etas." or key0 = "etas.;" or key0 = "ETAS>")
    str = taste{Space}
Else if (key0 = "etsn." or key0 = "etsn.;" or key0 = "ETSN>")
    str = nest{Space}
Else if (key0 = "tan." or key0 = "tan.;" or key0 = "TAN>")
    str = {BackSpace}ant{Space}
Else if (key0 = "eon." or key0 = "eon.;" or key0 = "EON>")
    str = none{Space}
Else if (key0 = "apl." or key0 = "apl.;" or key0 = "APL>")
    str = appeal{Space}
Else if (key0 = "eis." or key0 = "eis.;" or key0 = "EIS>")
    str = {BackSpace}{BackSpace}ies{Space}
Else if (key0 = "asb." or key0 = "asb.;" or key0 = "ASB>")
    str = bass{Space}
Else if (key0 = "dlb." or key0 = "dlb.;" or key0 = "DLB>")
    str = double{Space}
Else if (key0 = "eag." or key0 = "eag.;" or key0 = "EAG>")
    str = {BackSpace}age{Space}
Else if (key0 = "ecn." or key0 = "ecn.;" or key0 = "ECN>")
    str = {BackSpace}ence{Space}
Else if (key0 = "erta." or key0 = "erta.;" or key0 = "ERTA>")
    str = treat{Space}
Else if (key0 = "ertcn." or key0 = "ertcn.;" or key0 = "ERTCN>")
    str = center{Space}
Else if (key0 = "eta." or key0 = "eta.;" or key0 = "ETA>")
    str = eat{Space}
Else if (key0 = "ipsh." or key0 = "ipsh.;" or key0 = "IPSH>")
    str = ship{Space}
Else if (key0 = "rpsf." or key0 = "rpsf.;" or key0 = "RPSF>")
    str = professor{Space}
Else if (key0 = "rtg." or key0 = "rtg.;" or key0 = "RTG>")
    str = guitar{Space}
Else if (key0 = "rtlb." or key0 = "rtlb.;" or key0 = "RTLB>")
    str = terrible{Space}
Else if (key0 = "rtpa." or key0 = "rtpa.;" or key0 = "RTPA>")
    str = appropriate{Space}
Else if (key0 = "rtpc." or key0 = "rtpc.;" or key0 = "RTPC>")
    str = participate{Space}
Else if (key0 = "rtpn." or key0 = "rtpn.;" or key0 = "RTPN>")
    str = partner{Space}
Else if (key0 = "rtuh." or key0 = "rtuh.;" or key0 = "RTUH>")
    str = truth{Space}
Else if (key0 = "tgn." or key0 = "tgn.;" or key0 = "TGN>")
    str = negotiation{Space}
Else if (key0 = "tidn." or key0 = "tidn.;" or key0 = "TIDN>")
    str = identity{Space}
Else if (key0 = "tih." or key0 = "tih.;" or key0 = "TIH>")
    str = hit{Space}
Else if (key0 = "tplc." or key0 = "tplc.;" or key0 = "TPLC>")
    str = political{Space}
Else if (key0 = "tsn." or key0 = "tsn.;" or key0 = "TSN>")
    str = situation{Space}
Else if (key0 = "ty." or key0 = "ty.;" or key0 = "TY>")
    str = YouTube{Space}
Else if (key0 = "wn." or key0 = "wn.;" or key0 = "WN>")
    str = No worries.{Space}
Else if (key0 = "adb." or key0 = "adb.;" or key0 = "ADB>")
    str = bad{Space}
Else if (key0 = "asb." or key0 = "asb.;" or key0 = "ASB>")
    str = bass{Space}
Else if (key0 = "efl." or key0 = "efl.;" or key0 = "EFL>")
    str = fell{Space}
Else if (key0 = "eifv." or key0 = "eifv.;" or key0 = "EIFV>")
    str = five{Space}
Else if (key0 = "ein." or key0 = "ein.;" or key0 = "EIN>")
    str = nine{Space}
Else if (key0 = "eiv." or key0 = "eiv.;" or key0 = "EIV>")
    str = {BackSpace}ive{Space}
Else if (key0 = "em." or key0 = "em.;" or key0 = "EM>")
    str = em{Space}
Else if (key0 = "eran." or key0 = "eran.;" or key0 = "ERAN>")
    str = earn{Space}
Else if (key0 = "erth." or key0 = "erth.;" or key0 = "ERTH>")
    str = three{Space}
Else if (key0 = "esh." or key0 = "esh.;" or key0 = "ESH>")
    str = he's{Space}
Else if (key0 = "esvn." or key0 = "esvn.;" or key0 = "ESVN>")
    str = seven{Space}
Else if (key0 = "etigh." or key0 = "etigh.;" or key0 = "ETIGH>")
    str = eight{Space}
Else if (key0 = "eton." or key0 = "eton.;" or key0 = "ETON>")
    str = tone{Space}
Else if (key0 = "isx." or key0 = "isx.;" or key0 = "ISX>")
    str = six{Space}
Else if (key0 = "rpa." or key0 = "rpa.;" or key0 = "RPA>")
    str = appear{Space}
Else if (key0 = "ruof." or key0 = "ruof.;" or key0 = "RUOF>")
    str = four{Space}
Else if (key0 = "til." or key0 = "til.;" or key0 = "TIL>")
    str = till{Space}
Else if (key0 = "tosh." or key0 = "tosh.;" or key0 = "TOSH>")
    str = shoot{Space}
Else if (key0 = "wto." or key0 = "wto.;" or key0 = "WTO>")
    str = two{Space}
Else if (key0 = "rtos." or key0 = "rtos.;" or key0 = "RTOS>")
    str = sort of{Space}
Else if (key0 = "og." or key0 = "og.;" or key0 = "OG>")
    str = going{Space}
Else if (key0 = "tish." or key0 = "tish.;" or key0 = "TISH>")
    str = shit{Space}
Else if (key0 = "tm." or key0 = "tm.;" or key0 = "TM>")
    str = might{Space}
Else if (key0 = "idf." or key0 = "idf.;" or key0 = "IDF>")
    str = difficult{Space}
Else if (key0 = "tdn." or key0 = "tdn.;" or key0 = "TDN>")
    str = didn't{Space}
Else if (key0 = "tidn." or key0 = "tidn.;" or key0 = "TIDN>")
    str = didn't{Space}
Else if (key0 = "er." or key0 = "er.;" or key0 = "ER>")
    str = re
Else if (key0 = "erp." or key0 = "erp.;" or key0 = "ERP>")
    str = pre
Else if (key0 = "em." or key0 = "em.;" or key0 = "EM>")
    str = them{Space}
Else if (key0 = "ig." or key0 = "ig.;" or key0 = "IG>")
    str = Instagram{Space}
Else if (key0 = "fb." or key0 = "fb.;" or key0 = "FB>")
    str = Facebook{Space}
Else if (key0 = "gl." or key0 = "gl.;" or key0 = "GL>")
    str = Google{Space}
Else if (key0 = "id." or key0 = "id.;" or key0 = "ID>")
    str = I'd{Space}
Else if (key0 = "ok." or key0 = "ok.;" or key0 = "OK>")
    str = okay{Space}
Else if (key0 = "sm." or key0 = "sm.;" or key0 = "SM>")
    str = so much{Space}
Else if (key0 = "etc." or key0 = "etc.;" or key0 = "ETC>")
    str = technology{Space}
Else if (key0 = "th." or key0 = "th.;" or key0 = "TH>")
    str = th{Space}
Else if (key0 = "tsh." or key0 = "tsh.;" or key0 = "TSH>")
    str = that's{Space}
Else if (key0 = "ev." or key0 = "ev.;" or key0 = "EV>")
    str = ve{Space}
Else if (key0 = "c." or key0 = "c.;" or key0 = "C>")
    str = see{Space}
Else if (key0 = "u." or key0 = "u.;" or key0 = "U>")
    str = you{Space}
Else if (key0 = "n." or key0 = "n.;" or key0 = "N>")
    str = and{Space}
Else if (key0 = "t." or key0 = "t.;" or key0 = "T>")
    str = the{Space}
Else if (key0 = "y." or key0 = "y.;" or key0 = "Y>")
    str = yeah{Space}
Else if (key0 = "b." or key0 = "b.;" or key0 = "B>")
    str = but{Space}
Else if (key0 = "tion." or key0 = "tion.;" or key0 = "TION>")
    str = {BackSpace}ition{Space}
Else if (key0 = "w." or key0 = "w.;" or key0 = "W>")
    str = with{Space}
Else if (key0 = "p." or key0 = "p.;" or key0 = "P>")
    str = pretty{Space}
Else if (key0 = "k." or key0 = "k.;" or key0 = "K>")
    str = know{Space}
Else if (key0 = "q." or key0 = "q.;" or key0 = "Q>")
    str = quick{Space}
Else if (key0 = "g." or key0 = "g.;" or key0 = "G>")
    str = great{Space}
Else if (key0 = "l." or key0 = "l.;" or key0 = "L>")
    str = like{Space}
Else if (key0 = "r." or key0 = "r.;" or key0 = "R>")
    str = really{Space}
Else if (key0 = "sh." or key0 = "sh.;" or key0 = "SH>")
    str = sh{Space}
Else if (key0 = "j." or key0 = "j.;" or key0 = "J>")
    str = just{Space}
Else if (key0 = "m." or key0 = "m.;" or key0 = "M>")
    str = much{Space}
Else if (key0 = "e." or key0 = "e.;" or key0 = "E>")
    str = even{Space}
Else if (key0 = "d." or key0 = "d.;" or key0 = "D>")
    str = ed{Space}
Else if (key0 = "f." or key0 = "f.;" or key0 = "F>")
    str = for{Space}
Else if (key0 = "v." or key0 = "v.;" or key0 = "V>")
    str = very{Space}
Else if (key0 = "io." or key0 = "io.;" or key0 = "IO>")
    str = {BackSpace}{BackSpace}tion{Space}
Else if (key0 = "th." or key0 = "th.;" or key0 = "TH>")
    str = th{Space}
Else if (key0 = "hc." or key0 = "hc.;" or key0 = "HC>")
    str = ch{Space}
Else if (key0 = "to." or key0 = "to.;" or key0 = "TO>")
    str = too{Space}
Else if (key0 = "tuagh." or key0 = "tuagh.;" or key0 = "TUAGH>")
    str = aught{Space}
Else if (key0 = "ocn." or key0 = "ocn.;" or key0 = "OCN>")
    str = con{Space}
Else if (key0 = "era." or key0 = "era.;" or key0 = "ERA>")
    str = are{Space}
Else if (key0 = "gc." or key0 = "gc.;" or key0 = "GC>")
    str = seeing{Space}
Else if (key0 = "wya." or key0 = "wya.;" or key0 = "WYA>")
    str = away{Space}
Else if (key0 = "was." or key0 = "was.;" or key0 = "WAS>")
    str = saw{Space}
Else if (key0 = "3" or key0 = "3;" or key0 = "3")
    str = three{Space}
Else if (key0 = "1" or key0 = "1;" or key0 = "1")
    str = one{Space}
Else if (key0 = "2" or key0 = "2;" or key0 = "2")
    str = two{Space}
Else if (key0 = "4" or key0 = "4;" or key0 = "4")
    str = four{Space}
Else if (key0 = "5" or key0 = "5;" or key0 = "5")
    str = five{Space}
Else if (key0 = "ex." or key0 = "ex.;" or key0 = "EX>")
    str = exact{Space}
Else if (key0 = "6" or key0 = "6;" or key0 = "6")
    str = six{Space}
Else if (key0 = "7" or key0 = "7;" or key0 = "7")
    str = seven{Space}
Else if (key0 = "8" or key0 = "8;" or key0 = "8")
    str = eight{Space}
Else if (key0 = "9" or key0 = "9;" or key0 = "9")
    str = nine{Space}
Else if (key0 = "0" or key0 = "0;" or key0 = "0")
    str = 10{Space}
Else if (key0 = "woh." or key0 = "woh.;" or key0 = "WOH>")
    str = who{Space}
Else if (key0 = "etl." or key0 = "etl.;" or key0 = "ETL>")
    str = tell{Space}
Else if (key0 = "erts." or key0 = "erts.;" or key0 = "ERTS>")
    str = stress{Space}
Else if (key0 = "st." or key0 = "st.;" or key0 = "ST>")
    str = st{Space}
Else if (key0 = "tops." or key0 = "tops.;" or key0 = "TOPS>")
    str = post{Space}
Else if (key0 = "tis." or key0 = "tis.;" or key0 = "TIS>")
    str = sit{Space}
Else if (key0 = "ashl." or key0 = "ashl.;" or key0 = "ASHL>")
    str = shall{Space}
Else if (key0 = "esd." or key0 = "esd.;" or key0 = "ESD>")
    str = seed{Space}
Else if (key0 = "was." or key0 = "was.;" or key0 = "WAS>")
    str = saw{Space}
Else if (key0 = "won." or key0 = "won.;" or key0 = "WON>")
    str = own{Space}
Else if (key0 = "on." or key0 = "on.;" or key0 = "ON>")
    str = on{Space}
Else if (key0 = "etfl." or key0 = "etfl.;" or key0 = "ETFL>")
    str = left{Space}
Else if (key0 = "wtah." or key0 = "wtah.;" or key0 = "WTAH>")
    str = thaw{Space}
Else if (key0 = "of." or key0 = "of.;" or key0 = "OF>")
    str = off{Space}
Else if (key0 = "eanm." or key0 = "eanm.;" or key0 = "EANM>")
    str = name{Space}
Else if (key0 = "eilv." or key0 = "eilv.;" or key0 = "EILV>")
    str = evil{Space}
Else if (key0 = "epk." or key0 = "epk.;" or key0 = "EPK>")
    str = peek{Space}
Else if (key0 = "rtuh." or key0 = "rtuh.;" or key0 = "RTUH>")
    str = hurt{Space}
Else if (key0 = "toh." or key0 = "toh.;" or key0 = "TOH>")
    str = hot{Space}
Else if (key0 = "ish." or key0 = "ish.;" or key0 = "ISH>")
    str = ish{Space}
Else if (key0 = "erh." or key0 = "erh.;" or key0 = "ERH>")
    str = here{Space}
Else if (key0 = "og." or key0 = "og.;" or key0 = "OG>")
    str = original{Space}
Else if (key0 = "ed." or key0 = "ed.;" or key0 = "ED>")
    str = de
Else if (key0 = "tops." or key0 = "tops.;" or key0 = "TOPS>")
    str = post
Else if (key0 = "ism." or key0 = "ism.;" or key0 = "ISM>")
    str = mis{Space}
Else if (key0 = "al." or key0 = "al.;" or key0 = "AL>")
    str = {BackSpace}al{Space}
Else if (key0 = "s." or key0 = "s.;" or key0 = "S>")
    str = {BackSpace}s{Space}
Else if (key0 = "esn." or key0 = "esn.;" or key0 = "ESN>")
    str = {BackSpace}ness{Space}
Else if (key0 = "i." or key0 = "i.;" or key0 = "I>")
    str = I{Space}
Else if (key0 = "a." or key0 = "a.;" or key0 = "A>")
    str = a{Space}
Else if (key0 = "ufl." or key0 = "ufl.;" or key0 = "UFL>")
    str = {BackSpace}ful{Space}
Else if (key0 = "er." or key0 = "er.;" or key0 = "ER>")
    str = re
Else if (key0 = "toh." or key0 = "toh.;" or key0 = "TOH>")
    str = oth{Space}
Else if (key0 = "ton." or key0 = "ton.;" or key0 = "TON>")
    str = ton{Space}
Else if (key0 = "yal." or key0 = "yal.;" or key0 = "YAL>")
    str = {BackSpace}ally{Space}
Else if (key0 = "able." or key0 = "able.;" or key0 = "ABLE>")
    str = able
Else if (key0 = "ua." or key0 = "ua.;" or key0 = "UA>")
    str = ua
Else if (key0 = "edn." or key0 = "edn.;" or key0 = "EDN>")
    str = end{Space}
Else if (key0 = "er." or key0 = "er.;" or key0 = "ER>")
    str = {BackSpace}er
Else if (key0 = "etm." or key0 = "etm.;" or key0 = "ETM>")
    str = meet{Space}
Else if (key0 = "etg." or key0 = "etg.;" or key0 = "ETG>")
    str = getting{Space}
Else if (key0 = "al." or key0 = "al.;" or key0 = "AL>")
    str = {BackSpace}al
Else if (key0 = "tops." or key0 = "tops.;" or key0 = "TOPS>")
    str = post{Space}
Else if (key0 = "eag." or key0 = "eag.;" or key0 = "EAG>")
    str = age
Else if (key0 = "ertih." or key0 = "ertih.;" or key0 = "ERTIH>")
    str = either{Space}
Else if (key0 = "gv." or key0 = "gv.;" or key0 = "GV>")
    str = giving{Space}
Else if (key0 = "erashc." or key0 = "erashc.;" or key0 = "ERASHC>")
    str = research{Space}
Else if (key0 = "edf." or key0 = "edf.;" or key0 = "EDF>")
    str = feed{Space}
Else if (key0 = "eoshc." or key0 = "eoshc.;" or key0 = "EOSHC>")
    str = choose{Space}
Else if (key0 = "eigbn." or key0 = "eigbn.;" or key0 = "EIGBN>")
    str = beginning{Space}
Else if (key0 = "opsh." or key0 = "opsh.;" or key0 = "OPSH>")
    str = shops{Space}
Else if (key0 = "esm." or key0 = "esm.;" or key0 = "ESM>")
    str = seems{Space}
Else if (key0 = "ertal." or key0 = "ertal.;" or key0 = "ERTAL>")
    str = relate{Space}
Else if (key0 = "etis." or key0 = "etis.;" or key0 = "ETIS>")
    str = {BackSpace}ities{Space}
Else if (key0 = "tol." or key0 = "tol.;" or key0 = "TOL>")
    str = tool{Space}
Else if (key0 = "tasf." or key0 = "tasf.;" or key0 = "TASF>")
    str = staff{Space}
Else if (key0 = "sn." or key0 = "sn.;" or key0 = "SN>")
    str = season{Space}
Else if (key0 = "isgn." or key0 = "isgn.;" or key0 = "ISGN>")
    str = sing{Space}
Else if (key0 = "erpa." or key0 = "erpa.;" or key0 = "ERPA>")
    str = paper{Space}
Else if (key0 = "es." or key0 = "es.;" or key0 = "ES>")
    str = {BackSpace}es{Space}
Else if (key0 = "epsdn." or key0 = "epsdn.;" or key0 = "EPSDN>")
    str = depends{Space}
Else if (key0 = "rtlc." or key0 = "rtlc.;" or key0 = "RTLC>")
    str = critical{Space}
Else if (key0 = "ertpsn." or key0 = "ertpsn.;" or key0 = "ERTPSN>")
    str = represent{Space}
Else if (key0 = "oagln." or key0 = "oagln.;" or key0 = "OAGLN>")
    str = analog{Space}
Else if (key0 = "ral." or key0 = "ral.;" or key0 = "RAL>")
    str = lar
Else if (key0 = "tahc." or key0 = "tahc.;" or key0 = "TAHC>")
    str = attach{Space}
Else if (key0 = "ertpan." or key0 = "ertpan.;" or key0 = "ERTPAN>")
    str = parent{Space}
Else if (key0 = "igh." or key0 = "igh.;" or key0 = "IGH>")
    str = igh{Space}
Else if (key0 = "ets." or key0 = "ets.;" or key0 = "ETS>")
    str = test{Space}
Else if (key0 = "etsn." or key0 = "etsn.;" or key0 = "ETSN>")
    str = sent{Space}
Else if (key0 = "esfl." or key0 = "esfl.;" or key0 = "ESFL>")
    str = self{Space}
Else if (key0 = "epal." or key0 = "epal.;" or key0 = "EPAL>")
    str = Apple{Space}
Else if (key0 = "eiscn." or key0 = "eiscn.;" or key0 = "EISCN>")
    str = science{Space}
Else if (key0 = "rtlv." or key0 = "rtlv.;" or key0 = "RTLV>")
    str = virtual{Space}
Else if (key0 = "ts." or key0 = "ts.;" or key0 = "TS>")
    str = street{Space}
Else if (key0 = "odg." or key0 = "odg.;" or key0 = "ODG>")
    str = dog{Space}
Else if (key0 = "ertin." or key0 = "ertin.;" or key0 = "ERTIN>")
    str = internet{Space}
Else if (key0 = "rtpcn." or key0 = "rtpcn.;" or key0 = "RTPCN>")
    str = corporation{Space}
Else if (key0 = "werti." or key0 = "werti.;" or key0 = "WERTI>")
    str = Twitter{Space}
Else if (key0 = "erac." or key0 = "erac.;" or key0 = "ERAC>")
    str = race{Space}
Else if (key0 = "erus." or key0 = "erus.;" or key0 = "ERUS>")
    str = user{Space}
Else if (key0 = "rac." or key0 = "rac.;" or key0 = "RAC>")
    str = car{Space}
Else if (key0 = "roadb." or key0 = "roadb.;" or key0 = "ROADB>")
    str = broad{Space}
Else if (key0 = "wera." or key0 = "wera.;" or key0 = "WERA>")
    str = aware{Space}
Else if (key0 = "wrtoh." or key0 = "wrtoh.;" or key0 = "WRTOH>")
    str = worth{Space}
Else if (key0 = "ertafh." or key0 = "ertafh.;" or key0 = "ERTAFH>")
    str = farther{Space}
Else if (key0 = "ypal." or key0 = "ypal.;" or key0 = "YPAL>")
    str = apply{Space}
Else if (key0 = "rtpc." or key0 = "rtpc.;" or key0 = "RTPC>")
    str = capture{Space}
Else if (key0 = "erups." or key0 = "erups.;" or key0 = "ERUPS>")
    str = pressure{Space}
Else if (key0 = "esl." or key0 = "esl.;" or key0 = "ESL>")
    str = sell{Space}
Else if (key0 = "eifl." or key0 = "eifl.;" or key0 = "EIFL>")
    str = file{Space}
Else if (key0 = "weak." or key0 = "weak.;" or key0 = "WEAK>")
    str = wake{Space}
Else if (key0 = "deadl." or key0 = "deadl.;" or key0 = "DEADL>")
    str = lead{Space}
Else if (key0 = "wer'" or key0 = "wer';" or key0 = "WER'")
    str = we're{Space}
Else if (key0 = "esh'" or key0 = "esh';" or key0 = "ESH'")
    str = he's{Space}
Else if (key0 = "id'" or key0 = "id';" or key0 = "ID'")
    str = I'd{Space}
Else if (key0 = "yal'" or key0 = "yal';" or key0 = "YAL'")
    str = y'all{Space}
Else if (key0 = "t'" or key0 = "t';" or key0 = "T'")
    str = {BackSpace}'t{Space}
Else if (key0 = "wosh'" or key0 = "wosh';" or key0 = "WOSH'")
    str = who's{Space}
Else if (key0 = "tid'n" or key0 = "tid'n;" or key0 = "TID'N")
    str = didn't{Space}
Else if (key0 = "t'n" or key0 = "t'n;" or key0 = "T'N")
    str = {BackSpace}n't{Space}
Else if (key0 = "d'" or key0 = "d';" or key0 = "D'")
    str = {BackSpace}'d{Space}
Else if (key0 = "ts'" or key0 = "ts';" or key0 = "TS'")
    str = that's{Space}
Else if (key0 = "s'" or key0 = "s';" or key0 = "S'")
    str = {BackSpace}'s{Space}
Else if (key0 = "l" or key0 = "l;" or key0 = "L")
    str = {BackSpace}'ll{Space}
Else if (key0 = "ad." or key0 = "ad.;" or key0 = "AD>")
    str = add{Space}
Else if (key0 = "easc." or key0 = "easc.;" or key0 = "EASC>")
    str = access{Space}
Else if (key0 = "edc." or key0 = "edc.;" or key0 = "EDC>")
    str = {BackSpace}cede{Space}
Else if (key0 = "eis." or key0 = "eis.;" or key0 = "EIS>")
    str = {BackSpace}ies{Space}
Else if (key0 = "eolv." or key0 = "eolv.;" or key0 = "EOLV>")
    str = evolve{Space}
Else if (key0 = "epash." or key0 = "epash.;" or key0 = "EPASH>")
    str = phase{Space}
Else if (key0 = "ertal." or key0 = "ertal.;" or key0 = "ERTAL>")
    str = alter{Space}
Else if (key0 = "fl." or key0 = "fl.;" or key0 = "FL>")
    str = full{Space}
Else if (key0 = "til." or key0 = "til.;" or key0 = "TIL>")
    str = it'll{Space}
Else if (key0 = "til'" or key0 = "til';" or key0 = "TIL'")
    str = it'll{Space}
Else if (key0 = "tpln." or key0 = "tpln.;" or key0 = "TPLN>")
    str = population{Space}
Else if (key0 = "vm." or key0 = "vm.;" or key0 = "VM>")
    str = movie{Space}
Return
