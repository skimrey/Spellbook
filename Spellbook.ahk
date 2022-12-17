; Dictionary by Solomon Kimrey, initial code from Laszlo https://www.autohotkey.com/board/topic/6426-chording-keyboard-strings-sent-at-key-combinations/
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
   IfLess len0,%len1%, Send {}         ; no send at releasing keys
SEND1:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%

If InStr(key0, ".") or InStr(key0, "'")
GoSub SENDDOT
Else If InStr(key0, "/")
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
If InStr(key0, ">")
GoSub SENDDOTup
Else If InStr(key0, "?")
GoSub SENDSLASHup
Else If InStr(key0, "Q")
GoSub SENDQup
Else If InStr(key0, "W")
GoSub SENDWup
Else If InStr(key0, "E")
GoSub SENDEup
Else If InStr(key0, "R")
GoSub SENDRup
Else If InStr(key0, "T")
GoSub SENDTup
Else If InStr(key0, "Y")
GoSub SENDYup
Else If InStr(key0, "U")
GoSub SENDUup
Else If InStr(key0, "I")
GoSub SENDIup
Else If InStr(key0, "O")
GoSub SENDOup
Else If InStr(key0, "P")
GoSub SENDPup
Else If InStr(key0, "A")
GoSub SENDAup
Else If InStr(key0, "S")
GoSub SENDSup
Else If InStr(key0, "D")
GoSub SENDDup
Else If InStr(key0, "F")
GoSub SENDFup
Else If InStr(key0, "G")
GoSub SENDGup
Else If InStr(key0, "H")
GoSub SENDHup
Else If InStr(key0, "J")
GoSub SENDJup
Else If InStr(key0, "K")
GoSub SENDKup
Else If InStr(key0, "L")
GoSub SENDLup
Else If InStr(key0, "Z")
GoSub SENDZup
Else If InStr(key0, "X")
GoSub SENDXup
Else If InStr(key0, "C")
GoSub SENDCup
Else If InStr(key0, "V")
GoSub SENDVup
Else If InStr(key0, "B")
GoSub SENDBup
Else If InStr(key0, "N")
GoSub SENDNup
Else If InStr(key0, "M")
GoSub SENDMup
Else If StrLen(key0) = 1
      Send {%key0%}  

Return
SENDSLASH:
SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0% 
IfEqual key0,ets/, Send {BackSpace}est{Space}
Else IfEqual key0,era/, Send ear{Space}
Else IfEqual key0,r/, Send {BackSpace}r{Space}
Else IfEqual key0,tops/, Send spot{Space}
Else IfEqual key0,ertal/, Send latter{Space}
Else IfEqual key0,erts/, Send steer{Space}
Else IfEqual key0,tosh/, Send host{Space}
Else IfEqual key0,erp/, Send peer{Space}
Else IfEqual key0,ealb/, Send {BackSpace}{BackSpace}able{Space}
Else IfEqual key0,etas/, Send tease{Space}
Else IfEqual key0,wal/, Send law{Space}
Else IfEqual key0,esl/, Send {BackSpace}less{Space}
Else IfEqual key0,era/, Send ear{Space}
Else IfEqual key0,ersv/, Send sever{Space}
Else IfEqual key0,tis/, Send {BackSpace}ist{Space}
 Else IfEqual key0,eis/, Send {BackSpace}ise{Space}	
Else IfEqual key0,slcn/, Send counsel{Space}
Else IfEqual key0,erups/, Send pursue{Space}
Else IfEqual key0,won/, Send won{Space}
Else IfEqual key0,y/, Send {backspace}y{Space}
Else IfEqual key0,n/, Send {backspace}n{Space}

Return
SENDQ:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,qerf, Send frequency{Space}
Else IfEqual key0,qerfn, Send frequent{Space}
Else IfEqual key0,qerui, Send queue{Space}
Else IfEqual key0,qeu, Send queue{Space}
Else IfEqual key0,qrac, Send acquire{Space}
Else IfEqual key0,qrts, Send request{Space}
Else IfEqual key0,qetui, Send quiet{Space}
Else IfEqual key0,qeuin, Send unique{Space}
Else IfEqual key0,qel, Send equal{Space}
Else IfEqual key0,qeru, Send queer{Space}
Else IfEqual key0,ql, Send quickly{Space}
Else IfEqual key0,qetuo, Send quote{Space}
Else IfEqual key0,qfl, Send qualify{Space}
Else IfEqual key0,qrtuis, Send squirt{Space}
Else IfEqual key0,qyfl, Send qualify{Space}
Else IfEqual key0,qeuip, Send equip{Space}
Else IfEqual key0,qeuoscn, Send consequence{Space}
Else IfEqual key0,qeus, Send esque
Else IfEqual key0,qr, Send require{Space}
Else IfEqual key0,qrsl, Send squirrel{Space}
Else IfEqual key0,qeryu, Send query{Space}
Else IfEqual key0,qes, Send sequence{Space}
Else IfEqual key0,qetyui, Send equity{Space}
Else IfEqual key0,qrf, Send frequent{Space}
Else IfEqual key0,qrtfn, Send frequent{Space}
Else IfEqual key0,qscn, Send sequence{Space}
Else IfEqual key0,qtuanm, Send quantum{Space}
Else IfEqual key0,qt, Send question{Space}
Else IfEqual key0,qti, Send quite{Space}
Else IfEqual key0,qtl, Send quality{Space}
Else IfEqual key0,qts, Send questions{Space}
Else IfEqual key0,qtui, Send quit{Space}
Else IfEqual key0,qun, Send unique{Space}
Else IfEqual key0,qrt, Send quarter{Space}
Return
SENDW:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,wa, Send as well{Space}
Else IfEqual key0,wrhv, Send however{Space}
Else IfEqual key0,wtn, Send won't{Space}
Else IfEqual key0,werhvn, Send whenever{Space}
Else IfEqual key0,weoasm, Send awesome{Space}
Else IfEqual key0,wrpa, Send wrap{Space}
Else IfEqual key0,wlb, Send below{Space}
Else IfEqual key0,weolb, Send below{Space}
Else IfEqual key0,wan, Send want to{Space}
Else IfEqual key0,wehc, Send chew{Space}
Else IfEqual key0,weif, Send wife{Space}
Else IfEqual key0,weislv, Send swivel{Space}
Else IfEqual key0,werash, Send whereas{Space}
Else IfEqual key0,werhvn, Send whenever{Space}
Else IfEqual key0,werin, Send winner{Space}
Else IfEqual key0,weropm, Send empower{Space}
Else IfEqual key0,werosh, Send shower{Space}
Else IfEqual key0,wertih, Send wither{Space}
Else IfEqual key0,wesk, Send skew{Space}
Else IfEqual key0,wetishl, Send whistle{Space}
Else IfEqual key0,whkm, Send homework{Space}
Else IfEqual key0,wism, Send swim{Space}
Else IfEqual key0,woasl, Send swallow{Space}
Else IfEqual key0,wolb, Send blow{Space}
Else IfEqual key0,wra, Send war{Space}
Else IfEqual key0,wrb, Send borrow{Space}
Else IfEqual key0,wrsm, Send worrisome{Space}
Else IfEqual key0,wrpf, Send powerful{Space}
Else IfEqual key0,wdv, Send would've{Space}
Else IfEqual key0,werohn, Send nowhere{Space}
Else IfEqual key0,werohv, Send however{Space}
Else IfEqual key0,wrth, Send worth{Space}
Else IfEqual key0,weros, Send worse{Space}
Else IfEqual key0,wed, Send we'd{Space}
Else IfEqual key0,wein, Send wine{Space}
Else IfEqual key0,wetah, Send weather{Space}
Else IfEqual key0,wetahl, Send wealth{Space}
Else IfEqual key0,wofl, Send flow{Space}
Else IfEqual key0,werop, Send power{Space}
Else IfEqual key0,wertn, Send weren't{Space}
Else IfEqual key0,wrtn, Send written{Space}
Else IfEqual key0,wadn, Send wand{Space}
Else IfEqual key0,wdl, Send wield{Space}
Else IfEqual key0,weav, Send wave{Space}
Else IfEqual key0,welb, Send blew{Space}
Else IfEqual key0,welb, Send blew{Space}
Else IfEqual key0,weonm, Send women{Space}
Else IfEqual key0,werto, Send wrote{Space}
Else IfEqual key0,werto, Send wrote{Space}
Else IfEqual key0,wlcm, Send welcome{Space}
Else IfEqual key0,wnm, Send women{Space}
Else IfEqual key0,wnm, Send woman{Space}
Else IfEqual key0,wosl, Send slow{Space}
Else IfEqual key0,wrdh, Send hardware{Space}
Else IfEqual key0,wrtos, Send worst{Space}
Else IfEqual key0,wryo, Send worry{Space}
Else IfEqual key0,wagn, Send gnaw{Space}
Else IfEqual key0,waln, Send lawn{Space}
Else IfEqual key0,wan, Send awn{Space}
Else IfEqual key0,waskl, Send walks{Space}
Else IfEqual key0,wdln, Send download{Space}
Else IfEqual key0,weahl, Send whale{Space}
Else IfEqual key0,wehl, Send wheel{Space}
Else IfEqual key0,weif, Send wife{Space}
Else IfEqual key0,weigh, Send weigh{Space}
Else IfEqual key0,weis, Send wise{Space}
Else IfEqual key0,weosh, Send whose{Space}
Else IfEqual key0,weosh, Send swore{Space}
Else IfEqual key0,wertah, Send weather{Space}
Else IfEqual key0,wetigh, Send weight{Space}
Else IfEqual key0,wets, Send west{Space}
Else IfEqual key0,widl, Send wild{Space}
Else IfEqual key0,win, Send win{Space}
Else IfEqual key0,woc, Send cow{Space}
Else IfEqual key0,wom, Send mow{Space}
Else IfEqual key0,wrgln, Send wrangle{Space}
Else IfEqual key0,wrhn, Send nowhere{Space}
Else IfEqual key0,wrlnm, Send lawnmower{Space}
Else IfEqual key0,wrs, Send worse{Space}
Else IfEqual key0,wrtos, Send worst{Space}
Else IfEqual key0,wsdm, Send wisdom{Space}
Else IfEqual key0,wakl, Send walk{Space}
Else IfEqual key0,wal, Send always{Space}
Else IfEqual key0,was, Send was{Space}
Else IfEqual key0,was, Send was{Space}
Else IfEqual key0,wash, Send wash{Space}
Else IfEqual key0,wdf, Send forward{Space}
Else IfEqual key0,wdn, Send wouldn't{Space}
Else IfEqual key0,we, Send we{Space}
Else IfEqual key0,weak, Send weak{Space}
Else IfEqual key0,weasm, Send awesome{Space}
Else IfEqual key0,wef, Send few{Space}
Else IfEqual key0,weh, Send when{Space}
Else IfEqual key0,wehn, Send when{Space}
Else IfEqual key0,weid, Send wide{Space}
Else IfEqual key0,weid, Send wide{Space}
Else IfEqual key0,weihl, Send while{Space}
Else IfEqual key0,weis, Send wise{Space}
Else IfEqual key0,weisdh, Send wished{Space}
Else IfEqual key0,weiv, Send view{Space}
Else IfEqual key0,wek, Send week{Space}
Else IfEqual key0,wekn, Send knew{Space}
Else IfEqual key0,wel, Send well{Space}
Else IfEqual key0,wen, Send new{Space}
Else IfEqual key0,weohl, Send whole{Space}
Else IfEqual key0,weohl, Send whole{Space}
Else IfEqual key0,weohl, Send whole{Space}
Else IfEqual key0,wer, Send were{Space}
Else IfEqual key0,wera, Send wear{Space}
Else IfEqual key0,werasn, Send answer{Space}
Else IfEqual key0,werc, Send crew{Space}
Else IfEqual key0,werh, Send where{Space}
Else IfEqual key0,werid, Send weird{Space}
Else IfEqual key0,weriv, Send review{Space}
Else IfEqual key0,werosb, Send browse{Space}
Else IfEqual key0,werta, Send water{Space}
Else IfEqual key0,werth, Send whether{Space}
Else IfEqual key0,werti, Send Twitter{Space}
Else IfEqual key0,wetadn, Send wanted{Space}
Else IfEqual key0,wetbn, Send between{Space}
Else IfEqual key0,wetih, Send white{Space}
Else IfEqual key0,wetn, Send went{Space}
Else IfEqual key0,wev, Send everywhere{Space}
Else IfEqual key0,wfl, Send follow{Space}
Else IfEqual key0,wgk, Send working{Space}
Else IfEqual key0,wgkl, Send walking{Space}
Else IfEqual key0,wh, Send who{Space}
Else IfEqual key0,when, Send when{Space}
Else IfEqual key0,whl, Send whole{Space}
Else IfEqual key0,whn, Send when{Space}
Else IfEqual key0,widn, Send wind{Space}
Else IfEqual key0,wihc, Send which{Space}
Else IfEqual key0,wil, Send will{Space}
Else IfEqual key0,wiodn, Send window{Space}
Else IfEqual key0,wish, Send wish{Space}
Else IfEqual key0,wk, Send work{Space}
Else IfEqual key0,wkl, Send walk{Space}
Else IfEqual key0,wl, Send we'll{Space}
Else IfEqual key0,wn, Send network{Space}
Else IfEqual key0,wo, Send would{Space}
Else IfEqual key0,woal, Send allow{Space}
Else IfEqual key0,wod, Send wood{Space}
Else IfEqual key0,wodn, Send down{Space}
Else IfEqual key0,woh, Send how{Space}
Else IfEqual key0,wokn, Send know{Space}
Else IfEqual key0,wol, Send low{Space}
Else IfEqual key0,won, Send now{Space}
Else IfEqual key0,wosh, Send show{Space}
Else IfEqual key0,wosn, Send snow{Space}
Else IfEqual key0,wpn, Send newspaper{Space}
Else IfEqual key0,wr, Send we're{Space}
Else IfEqual key0,wr, Send we're{Space}
Else IfEqual key0,wrad, Send draw{Space}
Else IfEqual key0,wram, Send warm{Space}
Else IfEqual key0,wrdf, Send wonderful{Space}
Else IfEqual key0,wrdfn, Send wonderful{Space}
Else IfEqual key0,wrdn, Send wonder{Space}
Else IfEqual key0,wrk, Send work{Space}
Else IfEqual key0,wrod, Send word{Space}
Else IfEqual key0,wrodl, Send world{Space}
Else IfEqual key0,wrog, Send grow{Space}
Else IfEqual key0,wrogn, Send wrong{Space}
Else IfEqual key0,wrok, Send work{Space}
Else IfEqual key0,wrt, Send write{Space}
Else IfEqual key0,wrtg, Send writing{Space}
Else IfEqual key0,wrtm, Send tomorrow{Space}
Else IfEqual key0,wrtoh, Send throw{Space}
Else IfEqual key0,wrtv, Send whatever{Space}
Else IfEqual key0,wrv, Send review{Space}
Else IfEqual key0,ws, Send website{Space}
Else IfEqual key0,wsf, Send software{Space}
Else IfEqual key0,wsm, Send somewhere{Space}
Else IfEqual key0,wt, Send what{Space}
Else IfEqual key0,wtadn, Send wanted{Space}
Else IfEqual key0,wtadn, Send wanted{Space}
Else IfEqual key0,wtah, Send what{Space}
Else IfEqual key0,wtahc, Send watch{Space}
Else IfEqual key0,wtan, Send want{Space}
Else IfEqual key0,wtasn, Send wasn't{Space}
Else IfEqual key0,wsn, Send wasn't{Space}
Else IfEqual key0,wtb, Send by the way{Space}
Else IfEqual key0,wtd, Send toward{Space}
Else IfEqual key0,wth, Send whether{Space}
Else IfEqual key0,wthc, Send watch{Space}
Else IfEqual key0,wti, Send within{Space}
Else IfEqual key0,wtia, Send wait{Space}
Else IfEqual key0,wtishc, Send switch{Space}
Else IfEqual key0,wto, Send without{Space}
Else IfEqual key0,wton, Send town{Space}
Else IfEqual key0,wtuo, Send without{Space}
Else IfEqual key0,wtv, Send whatever{Space}
Else IfEqual key0,wtvn, Send interview{Space}
Else IfEqual key0,wv, Send we've{Space}
Else IfEqual key0,wv, Send we've{Space}
Else IfEqual key0,wya, Send way{Space}
Else IfEqual key0,wyahn, Send anywhere{Space}
Else IfEqual key0,wyan, Send anyway{Space}
Else IfEqual key0,wyh, Send why{Space}
Else IfEqual key0,wyl, Send yellow{Space}
Else IfEqual key0,werg, Send grew{Space}
Else IfEqual key0,wetic, Send twice{Space}
Else IfEqual key0,wtash, Send what's{Space}
Else IfEqual key0,wts, Send what's{Space}
Return
SENDR:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0% 
IfEqual key0,ra, Send around{Space}
Else IfEqual key0,ruioasv, Send saviour{Space}
Else IfEqual key0,rtyph, Send therapy{Space}
Else IfEqual key0,rtdlnm, Send detrimental{Space}
Else IfEqual key0,rtdln, Send traditional{Space}
Else IfEqual key0,ryc, Send cry{Space}
Else IfEqual key0,rtpsdn, Send president{Space}
Else IfEqual key0,rtuiag, Send guitar	{Space}
Else IfEqual key0,rtip, Send trip{Space}
Else IfEqual key0,ruosh, Send hours{Space}
Else IfEqual key0,ridkn, Send drink{Space}
Else IfEqual key0,riafc, Send Africa{Space}
Else IfEqual key0,rtiac, Send arctic{Space}
Else IfEqual key0,rtiacn, Send Antarctica{Space}
Else IfEqual key0,wrb, Send borrow{Space}
Else IfEqual key0,rhlb, Send horrible{Space}
Else IfEqual key0,rp, Send peer{Space}
Else IfEqual key0,rahcm, Send march{Space}
Else IfEqual key0,rdv, Send drive{Space}
Else IfEqual key0,rdbn, Send burden{Space}
Else IfEqual key0,rdgn, Send garden{Space}
Else IfEqual key0,rfcn, Send conference{Space}
Else IfEqual key0,rfnm, Send inform{Space}
Else IfEqual key0,riagc, Send cigar{Space}
Else IfEqual key0,rid, Send rid{Space}
Else IfEqual key0,ridb, Send bird{Space}
Else IfEqual key0,riofnm, Send inform{Space}
Else IfEqual key0,riom, Send mirror{Space}
Else IfEqual key0,rionm, Send minor{Space}
Else IfEqual key0,ripal, Send April{Space}
Else IfEqual key0,risc, Send crisis{Space}
Else IfEqual key0,riscn, Send insurance{Space}
Else IfEqual key0,rlcm, Send commercial{Space}
Else IfEqual key0,roajm, Send major{Space}
Else IfEqual key0,rodn, Send donor{Space}
Else IfEqual key0,rolc, Send color{Space}
Else IfEqual key0,roogm, Send groom{Space}
Else IfEqual key0,rpcn, Send pronounce{Space}
Else IfEqual key0,rpscb, Send prescribe{Space}
Else IfEqual key0,rpscm, Send compromise{Space}
Else IfEqual key0,rsc, Send source{Space}
Else IfEqual key0,rsjln, Send journalist{Space}
Else IfEqual key0,rtashc, Send scratch{Space}
Else IfEqual key0,rtav, Send avatar{Space}
Else IfEqual key0,rtfgl, Send grateful{Space}
Else IfEqual key0,rtgn, Send generate{Space}
Else IfEqual key0,rtifcn, Send interface{Space}
Else IfEqual key0,rtioavn, Send innovator{Space}
Else IfEqual key0,rtioscn, Send constrict{Space}
Else IfEqual key0,rtish, Send shirt{Space}
Else IfEqual key0,rtodc, Send doctor{Space}
Else IfEqual key0,rtofh, Send forth{Space}
Else IfEqual key0,rtpnm, Send prominent{Space}
Else IfEqual key0,rtpscn, Send transcript{Space}
Else IfEqual key0,rtpsn, Send proposition{Space}
Else IfEqual key0,rtsdm, Send mustard{Space}
Else IfEqual key0,rtshlc, Send historical{Space}
Else IfEqual key0,rtsjln, Send journalist{Space}
Else IfEqual key0,rtuinm, Send monitor{Space}
Else IfEqual key0,rtukc, Send truck{Space}
Else IfEqual key0,rtuoscn, Send construct{Space}
Else IfEqual key0,rtupab, Send abrupt{Space}
Else IfEqual key0,rtuskc, Send struck{Space}
Else IfEqual key0,rtyivn, Send inventory{Space}
Else IfEqual key0,rtyoph, Send trophy{Space}
Else IfEqual key0,rtyshlc, Send hysterical{Space}
Else IfEqual key0,ruasg, Send sugar{Space}
Else IfEqual key0,ruogh, Send rough{Space}
Else IfEqual key0,rydlv, Send delivery{Space}
Else IfEqual key0,ryfb, Send February{Space}
Else IfEqual key0,ryjn, Send January{Space}
Else IfEqual key0,rysdcv, Send discovery{Space}
Else IfEqual key0,rysg, Send surgery{Space}
Else IfEqual key0,ryuasm, Send summary{Space}
Else IfEqual key0,rus, Send yours{Space}
Else IfEqual key0,rtialc, Send critical{Space}
Else IfEqual key0,ropasl, Send proposal{Space}
Else IfEqual key0,rshc, Send proposal{Space}
Else IfEqual key0,rsc, Send source{Space}
Else IfEqual key0,ryagn, Send angry{Space}
Else IfEqual key0,rign, Send ignore{Space}
Else IfEqual key0,rtsglcn, Send congratulations{Space}
Else IfEqual key0,rfv, Send forever{Space}
Else IfEqual key0,rtpcm, Send competitor{Space}
Else IfEqual key0,rl, Send real{Space}
Else IfEqual key0,rtiln, Send internal{Space}
Else IfEqual key0,rtualn, Send natural{Space}
Else IfEqual key0,rthb, Send breath{Space}
Else IfEqual key0,rtlcn, Send control{Space}
Else IfEqual key0,rdh, Send heard{Space}
Else IfEqual key0,rlcm, Send molecular{Space}
Else IfEqual key0,ryd, Send ready{Space}
Else IfEqual key0,roahcb, Send broach{Space}
Else IfEqual key0,riav, Send vari{Space}
Else IfEqual key0,rpsd, Send spread{Space}
Else IfEqual key0,rpshc, Send purchase{Space}
Else IfEqual key0,rtaghlm, Send algorithm{Space}
Else IfEqual key0,rodhc, Send chord{Space}
Else IfEqual key0,rtagnm, Send argument{Space}
Else IfEqual key0,rtfh, Send further{Space}
Else IfEqual key0,rtisdc, Send district{Space}
Else IfEqual key0,rtpdxn, Send expenditure{Space}
Else IfEqual key0,rafm, Send farm{Space}
Else IfEqual key0,rag, Send argue{Space}
Else IfEqual key0,rakc, Send crack{Space}
Else IfEqual key0,ram, Send arm{Space}
 Else IfEqual key0,rtlvn, Send relevant{Space}
Else IfEqual key0,ram, Send arm{Space}
Else IfEqual key0,rdfcn, Send difference{Space}
Else IfEqual key0,rdfl, Send federal{Space}
Else IfEqual key0,rfb, Send brief{Space}
Else IfEqual key0,rfcnm, Send confirm{Space}
Else IfEqual key0,rfgn, Send finger{Space}
Else IfEqual key0,rghc, Send charge{Space}
Else IfEqual key0,rgln, Send general{Space}
Else IfEqual key0,rglv, Send leverage{Space}
Else IfEqual key0,rhlcn, Send chronicle{Space}
Else IfEqual key0,ria, Send air{Space}
Else IfEqual key0,riabn, Send brain{Space}
Else IfEqual key0,ricb, Send crib{Space}
Else IfEqual key0,rid, Send rid{Space}
Else IfEqual key0,rif, Send riff{Space}
Else IfEqual key0,ripaghc, Send graphic{Space}
Else IfEqual key0,ripalcn, Send principal{Space}
Else IfEqual key0,ripsvm, Send improvise{Space}
Else IfEqual key0,risk, Send risk{Space}
Else IfEqual key0,rjn, Send junior{Space}
Else IfEqual key0,rkm, Send maker{Space}
Else IfEqual key0,rlc, Send clear{Space}
Else IfEqual key0,rlcm, Send curriculum{Space}
Else IfEqual key0,rlcm, Send miracle{Space}
Else IfEqual key0,roasb, Send absorb{Space}
Else IfEqual key0,rosvb, Send observe{Space}
Else IfEqual key0,rpagh, Send graph{Space}
Else IfEqual key0,rpaghc, Send graphic{Space}
Else IfEqual key0,rpg, Send grp group{Space}
Else IfEqual key0,rplcn, Send principle{Space}
Else IfEqual key0,rpscnm, Send comparison{Space}
Else IfEqual key0,rpshm, Send sophomore{Space}
Else IfEqual key0,rpsl, Send pleasure{Space}
Else IfEqual key0,rpsln, Send personal{Space}
Else IfEqual key0,rsfc, Send surface{Space}
Else IfEqual key0,rsfhnm, Send freshman{Space}
Else IfEqual key0,rsflc, Send salesforce{Space}
Else IfEqual key0,rsgln, Send singular{Space}
Else IfEqual key0,rsgln, Send singular{Space}
Else IfEqual key0,rslcn, Send counselor{Space}
Else IfEqual key0,rsxc, Send exercise{Space}
Else IfEqual key0,rtagn, Send grant{Space}
Else IfEqual key0,rtasm, Send smart{Space}
Else IfEqual key0,rtfc, Send factor{Space}
Else IfEqual key0,rtfgn, Send forgotten{Space}
Else IfEqual key0,rthn, Send neither{Space}
Else IfEqual key0,rtidh, Send third{Space}
Else IfEqual key0,rtioshc, Send historic{Space}
Else IfEqual key0,rtisgn, Send string{Space}
Else IfEqual key0,rtkm, Send market{Space}
Else IfEqual key0,rtoafc, Send factor{Space}
Else IfEqual key0,rtofg, Send forgot{Space}
Else IfEqual key0,rtohn, Send north{Space}
Else IfEqual key0,rtopa, Send parrot{Space}
Else IfEqual key0,rtopa, Send transport{Space}
Else IfEqual key0,rtplc, Send particular{Space}
Else IfEqual key0,rtpslc, Send spectacular{Space}
Else IfEqual key0,rtpslc, Send transport{Space}
Else IfEqual key0,rtpsn., Send transportation{Space}
Else IfEqual key0,rtpvm, Send primitive{Space}
Else IfEqual key0,rtpvn, Send prevent{Space}
Else IfEqual key0,rtpxnm, Send experiment{Space}
Else IfEqual key0,rtscn, Send countries{Space}
Else IfEqual key0,rtsdb, Send disturb{Space}
Else IfEqual key0,rtsfn, Send transfer{Space}
Else IfEqual key0,rtshc, Send historic{Space}
Else IfEqual key0,rtuam, Send trauma{Space}
Else IfEqual key0,rtuo, Send tour{Space}
Else IfEqual key0,rtuoah, Send author{Space}
Else IfEqual key0,rtyan, Send attorney{Space}
Else IfEqual key0,rtyp, Send property{Space}
Else IfEqual key0,rtyp, Send property{Space}
Else IfEqual key0,ruadg, Send guard{Space}
Else IfEqual key0,rubn, Send burn{Space}
Else IfEqual key0,ruodn, Send round{Space}
Else IfEqual key0,ruos, Send ours{Space}
Else IfEqual key0,rush, Send rush{Space}
Else IfEqual key0,ryanm, Send anymore{Space}
Else IfEqual key0,ryanm, Send anymore{Space}
Else IfEqual key0,ryjn, Send journey{Space}
Else IfEqual key0,rypas, Send spray{Space}
Else IfEqual key0,rtphc, Send chapter{Space}
Else IfEqual key0,rtsdc, Send district{Space}
Else IfEqual key0,rtygc, Send category{Space}
Else IfEqual key0,radc, Send card{Space}
Else IfEqual key0,rof, Send for{Space}
Else IfEqual key0,ryad, Send yard{Space}
Else IfEqual key0,radg, Send grad{Space}
Else IfEqual key0,radh, Send hard{Space}
Else IfEqual key0,rakm, Send mark{Space}
Else IfEqual key0,rakm, Send mark{Space}
Else IfEqual key0,rasdv, Send advisor{Space}
Else IfEqual key0,rdcnm, Send recommend{Space}
Else IfEqual key0,rdgn, Send gender{Space}
Else IfEqual key0,rdgn, Send gender{Space}
Else IfEqual key0,rdhn, Send hundred{Space}
Else IfEqual key0,rdlv, Send deliver{Space}
Else IfEqual key0,rdm, Send dream{Space}
Else IfEqual key0,rdn, Send round{Space}
Else IfEqual key0,rdnm, Send random{Space}
Else IfEqual key0,rdvn, Send vendor{Space}
Else IfEqual key0,rfc, Send force{Space}
Else IfEqual key0,rfc, Send force{Space}
Else IfEqual key0,rfcn, Send reference{Space}
Else IfEqual key0,rfcn, Send reference{Space}
Else IfEqual key0,rfcn, Send conference{Space}
Else IfEqual key0,rflv, Send flavor{Space}
Else IfEqual key0,rfm, Send firm{Space}
Else IfEqual key0,rg, Send regard{Space}
Else IfEqual key0,rgcn, Send encourage{Space}
Else IfEqual key0,rgcn, Send encourage{Space}
Else IfEqual key0,rgl, Send regular{Space}
Else IfEqual key0,rgl, Send regardless{Space}
Else IfEqual key0,rgl, Send regular{Space}
Else IfEqual key0,rglv, Send leverage{Space}
Else IfEqual key0,rhcbm, Send chamber{Space}
Else IfEqual key0,rhvb, Send behavior{Space}
Else IfEqual key0,riadn, Send drain{Space}
Else IfEqual key0,riah, Send hair{Space}
Else IfEqual key0,rifm, Send firm{Space}
Else IfEqual key0,riscn, Send increase{Space}
Else IfEqual key0,rlb, Send reliable{Space}
Else IfEqual key0,rlcm, Send commercial{Space}
Else IfEqual key0,rlv, Send lever{Space}
Else IfEqual key0,roalb, Send labor{Space}
Else IfEqual key0,rod, Send door{Space}
Else IfEqual key0,rogcn, Send organic{Space}
Else IfEqual key0,rohn, Send honor{Space}
Else IfEqual key0,rokc, Send rock{Space}
Else IfEqual key0,rolc, Send color{Space}
Else IfEqual key0,rpd, Send drop{Space}
Else IfEqual key0,rpav, Send approve{Space}
Else IfEqual key0,rpcv, Send perceive{Space}
Else IfEqual key0,rpdn, Send pardon{Space}
Else IfEqual key0,rpghc, Send graphic{Space}
Else IfEqual key0,rpl, Send popular{Space}
Else IfEqual key0,rpl, Send popular{Space}
Else IfEqual key0,rpsc, Send precise{Space}
Else IfEqual key0,rpscn, Send presence{Space}
Else IfEqual key0,rpsf, Send profess{Space}
Else IfEqual key0,rpsg, Send progress{Space}
Else IfEqual key0,rscn, Send increase{Space}
Else IfEqual key0,rscn, Send increase{Space}
Else IfEqual key0,rscnm, Send consumer{Space}
Else IfEqual key0,rsd, Send desire{Space}
Else IfEqual key0,rsdc, Send decrease{Space}
Else IfEqual key0,rsdlc, Send ridiculous{Space}
Else IfEqual key0,rsdlc, Send ridiculous{Space}
Else IfEqual key0,rsdn, Send surround{Space}
Else IfEqual key0,rsdv, Send deserve{Space}
Else IfEqual key0,rsv, Send various{Space}
Else IfEqual key0,rsxc, Send exercise{Space}
Else IfEqual key0,rsxc, Send exercise{Space}
Else IfEqual key0,rtab, Send attribute{Space}
Else IfEqual key0,rtalc, Send article{Space}
Else IfEqual key0,rtcbn, Send contribute{Space}
Else IfEqual key0,rtdcn, Send coordinate{Space}
Else IfEqual key0,rtidcn, Send coordinate{Space}
Else IfEqual key0,rtfcnm, Send manufacture{Space}
Else IfEqual key0,rtflc, Send reflect{Space}
Else IfEqual key0,rtial, Send trial{Space}
Else IfEqual key0,rtikc, Send trick{Space}
Else IfEqual key0,rtlcb, Send collaborate{Space}
Else IfEqual key0,rto, Send root{Space}
Else IfEqual key0,rtoashc, Send orchestra{Space}
Else IfEqual key0,rtopm, Send prompt{Space}
Else IfEqual key0,rtpf, Send profit{Space}
Else IfEqual key0,rtpfn, Send nonprofit{Space}
Else IfEqual key0,rtypscn, Send transparency{Space}
Else IfEqual key0,rtpsdcn, Send description{Space}
Else IfEqual key0,rtpsn, Send inspiration{Space}
Else IfEqual key0,rtipvn, Send prevent{Space}
Else IfEqual key0,rtpvn, Send prevent{Space}
Else IfEqual key0,rtpx, Send expert{Space}
Else IfEqual key0,rtscn, Send contrast{Space}
Else IfEqual key0,rtsdnm, Send demonstrate{Space}
Else IfEqual key0,rtsgl, Send struggle{Space}
Else IfEqual key0,rtsn, Send restaurant{Space}
Else IfEqual key0,rtsn, Send resonate{Space}
Else IfEqual key0,rtsn, Send restaurant{Space}
Else IfEqual key0,rtsnm, Send instrument{Space}
Else IfEqual key0,rtuom, Send tumor{Space}
Else IfEqual key0,rtycn, Send country{Space}
Else IfEqual key0,rtyhcm, Send chemistry{Space}
Else IfEqual key0,rtyhm, Send rhythm{Space}
Else IfEqual key0,rtysc, Send security{Space}
Else IfEqual key0,rtysh, Send history{Space}
Else IfEqual key0,rudg, Send drug{Space}
Else IfEqual key0,rvb, Send brave{Space}
Else IfEqual key0,rvm, Send remove{Space}
Else IfEqual key0,rygln, Send neurology{Space}
Else IfEqual key0,ripvm, Send improve{Space}	
Else IfEqual key0,rudm, Send drum{Space}
Else IfEqual key0,ragb, Send grab{Space}
Else IfEqual key0,rcv, Send receive{Space}
Else IfEqual key0,rdbn, Send burden{Space}
Else IfEqual key0,riop, Send prior{Space}
Else IfEqual key0,rnm, Send remain{Space}
Else IfEqual key0,rpcm, Send compare{Space}
Else IfEqual key0,rpsm, Send promise{Space}
Else IfEqual key0,rpsm, Send promise{Space}
Else IfEqual key0,rscv, Send service{Space}
Else IfEqual key0,rsdcv, Send discover{Space}
Else IfEqual key0,rsdn, Send surround{Space}
Else IfEqual key0,rsv, Send survive{Space}
Else IfEqual key0,rsvn, Send version{Space}
Else IfEqual key0,rtd, Send tried{Space}
Else IfEqual key0,rtdgh, Send daughter{Space}
Else IfEqual key0,rtfg, Send forget{Space}
Else IfEqual key0,rthc, Send teacher{Space}
Else IfEqual key0,rtian, Send train{Space}
Else IfEqual key0,rtic, Send critic{Space}
Else IfEqual key0,rtioscn, Send construction{Space}
Else IfEqual key0,rtiscm, Send criticism{Space}
Else IfEqual key0,rtlm, Send material{Space}
Else IfEqual key0,rtln, Send relation{Space}
Else IfEqual key0,rtscn, Send construct{Space}
Else IfEqual key0,rtscvn, Send constructive{Space}
Else IfEqual key0,rtsln, Send resolution{Space}
Else IfEqual key0,ryac, Send carry{Space}
Else IfEqual key0,rth, Send rather{Space}	
Else IfEqual key0,rab, Send bar{Space}
Else IfEqual key0,rac, Send across{Space}
Else IfEqual key0,radbn, Send brand{Space}
Else IfEqual key0,radh, Send hard{Space}
Else IfEqual key0,raf, Send far{Space}
Else IfEqual key0,rafkn, Send frank{Space}
Else IfEqual key0,ral, Send ral
Else IfEqual key0,rax, Send extra{Space}
Else IfEqual key0,rb, Send br
Else IfEqual key0,rbm, Send remember{Space}
Else IfEqual key0,rbn, Send brain{Space}
Else IfEqual key0,rc, Send crazy{Space}
Else IfEqual key0,rd, Send read{Space}
Else IfEqual key0,rdg, Send during{Space}
Else IfEqual key0,rdlz, Send realized{Space}
Else IfEqual key0,rf, Send from{Space}
Else IfEqual key0,rfg, Send figure{Space}
Else IfEqual key0,rflm, Send familiar{Space}
Else IfEqual key0,rfn, Send refine{Space}
Else IfEqual key0,rgb, Send bring{Space}
Else IfEqual key0,rgnm, Send manager{Space}
Else IfEqual key0,riognm, Send morning{Space}
Else IfEqual key0,rgzcn, Send recognize{Space}
Else IfEqual key0,rh, Send here{Space}
Else IfEqual key0,riaf, Send fair{Space}
Else IfEqual key0,ridhlc, Send children{Space}
Else IfEqual key0,rdhlcn, Send children{Space}
Else IfEqual key0,rigbn, Send bring{Space}
Else IfEqual key0,rigl, Send girl{Space}
Else IfEqual key0,rihc, Send rich{Space}
Else IfEqual key0,riocm, Send micro
Else IfEqual key0,ripa, Send pair{Space}
Else IfEqual key0,rjm, Send major{Space}
Else IfEqual key0,rlnm, Send normal{Space}
Else IfEqual key0,rlz, Send realize{Space}
Else IfEqual key0,rm, Send more{Space}
Else IfEqual key0,rn, Send right now{Space}
Else IfEqual key0,ro, Send or{Space}
Else IfEqual key0,roacm, Send macro
Else IfEqual key0,road, Send road{Space}
Else IfEqual key0,roadb, Send board{Space}
Else IfEqual key0,roadbn, Send onboard{Space}
Else IfEqual key0,roadl, Send dollar{Space}
Else IfEqual key0,roalnm, Send normal{Space}
Else IfEqual key0,rofm, Send form{Space}
Else IfEqual key0,rog, Send organization{Space}
Else IfEqual key0,rogln, Send original{Space}
Else IfEqual key0,rogn, Send original{Space}
Else IfEqual key0,rognm, Send morning{Space}
Else IfEqual key0,rol, Send roll{Space}
Else IfEqual key0,rolnm, Send normal{Space}
Else IfEqual key0,rom, Send room{Space}
Else IfEqual key0,rop, Send pro
Else IfEqual key0,ropb, Send probably{Space}
Else IfEqual key0,ropd, Send drop{Space}
Else IfEqual key0,rtpdc, Send product{Space}
Else IfEqual key0,ropj, Send project{Space}
Else IfEqual key0,roplb, Send problem{Space}
Else IfEqual key0,rosc, Send cross{Space}
Else IfEqual key0,rosg, Send organizations{Space}
Else IfEqual key0,roslc, Send scroll{Space}
Else IfEqual key0,rpa, Send appreciate{Space}
Else IfEqual key0,rpahc, Send approach{Space}
Else IfEqual key0,rpak, Send park{Space}
Else IfEqual key0,rpb, Send problem{Space}
Else IfEqual key0,rpc, Send process{Space}
Else IfEqual key0,rpdc, Send proceed{Space}
Else IfEqual key0,rpdv, Send provide{Space}
Else IfEqual key0,rpf, Send professional{Space}
Else IfEqual key0,rpfcnm, Send performance{Space}
Else IfEqual key0,rpfl, Send profile{Space}
Else IfEqual key0,rpfm, Send perform{Space}
Else IfEqual key0,rpgm, Send program{Space}
Else IfEqual key0,rplb, Send problem{Space}
Else IfEqual key0,rplx, Send explore{Space}
Else IfEqual key0,rps, Send surprise{Space}
Else IfEqual key0,rpslbn, Send responsible{Space}
Else IfEqual key0,rpsdn, Send respond{Space}
Else IfEqual key0,rpsh, Send perhaps{Space}
Else IfEqual key0,rtpsbn  , Send responsibility{Space}
Else IfEqual key0,rpsn, Send response{Space}
Else IfEqual key0,rs, Send sure{Space}
Else IfEqual key0,rsdcb, Send describe{Space}
Else IfEqual key0,rsdcn, Send consider{Space}
Else IfEqual key0,rsl, Send release{Space}
Else IfEqual key0,rslm, Send similar{Space}
Else IfEqual key0,rslv, Send several{Space}
Else IfEqual key0,rsn, Send reason{Space}
Else IfEqual key0,rt, Send right{Space}
Else IfEqual key0,rtad, Send traditional{Space}
Else IfEqual key0,rtakc, Send track{Space}
Else IfEqual key0,rtal, Send alright{Space}
Else IfEqual key0,rtalc, Send article{Space}
Else IfEqual key0,rtan, Send another{Space}
Else IfEqual key0,rtas, Send strategy{Space}
Else IfEqual key0,rtasdn, Send standard{Space}
Else IfEqual key0,rtasn, Send trans{Space}
Else IfEqual key0,rtc, Send create{Space}
Else IfEqual key0,rtcn, Send certain{Space}
Else IfEqual key0,rtcv, Send creative{Space}
Else IfEqual key0,rtflc, Send reflect{Space}
Else IfEqual key0,rtfn, Send fortunate{Space}
Else IfEqual key0,rtg, Send trying{Space}
Else IfEqual key0,rtgc, Send creating{Space}
Else IfEqual key0,rtgh, Send together{Space}
Else IfEqual key0,rti, Send tri
Else IfEqual key0,rtiafc, Send traffic{Space}
Else IfEqual key0,rtian, Send intra
Else IfEqual key0,rtiasn, Send strain{Space}
Else IfEqual key0,rtioasn, Send transition{Space}
Else IfEqual key0,rtign, Send integrate{Space}
Else IfEqual key0,rtil, Send literally{Space}
Else IfEqual key0,rtiodcn, Send coordinate{Space}
Else IfEqual key0,rtiodn, Send introduce{Space}
Else IfEqual key0,rtion, Send intro
Else IfEqual key0,rtipa, Send particular{Space}
Else IfEqual key0,rtl, Send literal{Space}
Else IfEqual key0,rtlb, Send trouble{Space}
Else IfEqual key0,rtlc, Send control{Space}
Else IfEqual key0,rtlcb, Send collaborate{Space}
Else IfEqual key0,rtlv, Send relative{Space}
Else IfEqual key0,rtm, Send remote{Space}
Else IfEqual key0,rtn, Send entire{Space}
Else IfEqual key0,rtoac, Send actor{Space}
Else IfEqual key0,rtoacn, Send contract{Space}
Else IfEqual key0,rtob, Send obtrusive{Space}
Else IfEqual key0,rtocn, Send contro
Else IfEqual key0,rtofn, Send front{Space}
Else IfEqual key0,rtom, Send tomorrow{Space}
Else IfEqual key0,rtos, Send sort{Space}
Else IfEqual key0,rtosg, Send storage{Space}
Else IfEqual key0,rtosgn, Send strong{Space}
Else IfEqual key0,rtosh, Send short{Space}
Else IfEqual key0,rtp, Send repeat{Space}
Else IfEqual key0,rtpa, Send part{Space}
Else IfEqual key0,rtpac, Send practice{Space}
Else IfEqual key0,rtpan, Send apparent{Space}
Else IfEqual key0,rtpc, Send picture{Space}
Else IfEqual key0,rtpcn, Send perception{Space}
Else IfEqual key0,rtps, Send separate{Space}
Else IfEqual key0,rtpsc, Send respect{Space}
Else IfEqual key0,rtpscv, Send perspective{Space}
Else IfEqual key0,rtpv, Send private{Space}
Else IfEqual key0,rts, Send start{Space}
Else IfEqual key0,rtsbn, Send stubborn{Space}
Else IfEqual key0,rtscm, Send customer{Space}
Else IfEqual key0,rtsd, Send disastrous{Space}
Else IfEqual key0,rtsdc, Send distract{Space}
Else IfEqual key0,rtsdn, Send standard{Space}
Else IfEqual key0,rtsg, Send starting{Space}
Else IfEqual key0,rtsgh, Send straight{Space}
Else IfEqual key0,rtsm, Send stream{Space}
Else IfEqual key0,rtualb, Send brutal{Space}
Else IfEqual key0,rtualc, Send cultural{Space}
Else IfEqual key0,rtuh, Send hurt{Space}
Else IfEqual key0,rtuogh, Send through{Space}
Else IfEqual key0,rtun, Send turn{Space}
Else IfEqual key0,rtuops, Send support{Space}
Else IfEqual key0,rtus, Send trust{Space}
Else IfEqual key0,rtvn, Send narrative{Space}
Else IfEqual key0,rty, Send try{Space}
Else IfEqual key0,rtyos, Send story{Space}
Else IfEqual key0,rtypa, Send party{Space}
Else IfEqual key0,rtyul, Send truly{Space}
Else IfEqual key0,ru, Send your{Space}
Else IfEqual key0,ruioasv, Send various{Space}
Else IfEqual key0,ruiosc, Send curious{Space}
Else IfEqual key0,run, Send run{Space}
Else IfEqual key0,ruo, Send our{Space}
Else IfEqual key0,ruoc, Send occur{Space}
Else IfEqual key0,ruodgn, Send ground{Space}
Else IfEqual key0,ruoh, Send hour{Space}
Else IfEqual key0,ruopg, Send group{Space}
Else IfEqual key0,ruphc, Send purchase{Space}
Else IfEqual key0,rv, Send virtual reality{Space}
Else IfEqual key0,ry, Send year{Space}
Else IfEqual key0,rya, Send {BackSpace}ary{Space}
Else IfEqual key0,ryafkln, Send frankly{Space}
Else IfEqual key0,ryav, Send vary{Space}
Else IfEqual key0,ryos, Send sorry{Space}
Else IfEqual key0,rypcv, Send privacy{Space}
Else IfEqual key0,rys, Send years{Space}
Else IfEqual key0,ran, Send ran{Space}
Else IfEqual key0,rdcv, Send received{Space}
Else IfEqual key0,rjln, Send journal{Space}
Else IfEqual key0,ropa, Send approach{Space}
Else IfEqual key0,ropahc, Send approach{Space}
Else IfEqual key0,rpam, Send ramp{Space}
Else IfEqual key0,rpsv, Send previous{Space}
Else IfEqual key0,rsm, Send measure{Space}
Else IfEqual key0,rta, Send art{Space}
Else IfEqual key0,rtac, Send attract{Space}
Else IfEqual key0,rtdc, Send direct{Space}
Else IfEqual key0,rtdg, Send graduate{Space}
Else IfEqual key0,rtdnm, Send determine{Space}
Else IfEqual key0,rtf, Send feature{Space}
Else IfEqual key0,rtghb, Send brought{Space}
Else IfEqual key0,rtian, Send train{Space}
Else IfEqual key0,rtias, Send artist{Space}
Else IfEqual key0,rtipn, Send print{Space}
Else IfEqual key0,rtpl, Send partial{Space}
Else IfEqual key0,rtpm, Send promote{Space}
Else IfEqual key0,rtsdb, Send distribute{Space}
Else IfEqual key0,ruopd, Send proud{Space}
Else IfEqual key0,rtpn, Send pattern{Space}
Else IfEqual key0,rypm, Send primary{Space}
Return
SENDT:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,ta, Send at{Space}
Else IfEqual key0,tadh, Send that'd{Space}
Else IfEqual key0,tisv, Send visit{Space}
Else IfEqual key0,tihn, Send thin{Space}
Else IfEqual key0,tpsln, Send pleasant{Space}
Else IfEqual key0,tadcv, Send advocate{Space}
Else IfEqual key0,tahm, Send math{Space}
Else IfEqual key0,tupg, Send putting{Space}
Else IfEqual key0,takn, Send tank{Space}
Else IfEqual key0,tglv, Send vegetable{Space}
Else IfEqual key0,tgvn, Send navigate{Space}
Else IfEqual key0,tiafh, Send faith{Space}
Else IfEqual key0,tipsl, Send split{Space}
Else IfEqual key0,tial, Send tail{Space}
Else IfEqual key0,tias, Send assist{Space}
Else IfEqual key0,tifghl, Send flight{Space}
Else IfEqual key0,tighm, Send might{Space}
Else IfEqual key0,tilcn, Send inoculate{Space}
Else IfEqual key0,tioflcn, Send conflict{Space}
Else IfEqual key0,tipan, Send paint{Space}
Else IfEqual key0,tipan, Send paint{Space}
Else IfEqual key0,tisv, Send visit{Space}
Else IfEqual key0,tohcb, Send botch{Space}
Else IfEqual key0,tohlc, Send cloth{Space}
Else IfEqual key0,topsg, Send stopping{Space}
Else IfEqual key0,tosd, Send stood{Space}
Else IfEqual key0,toshm, Send smooth{Space}
Else IfEqual key0,toshm, Send smooth{Space}
Else IfEqual key0,tosl, Send lost{Space}
Else IfEqual key0,tpasnm, Send assumption{Space}
Else IfEqual key0,tpcn, Send patience{Space}
Else IfEqual key0,tpcvm, Send competitive{Space}
Else IfEqual key0,tphkc, Send ketchup{Space}
Else IfEqual key0,tpslc, Send telescope{Space}
Else IfEqual key0,tsdnm, Send disseminate{Space}
Else IfEqual key0,tsfc, Send suffocate{Space}
Else IfEqual key0,tshlb, Send bullshit{Space}
Else IfEqual key0,tuadl, Send adult{Space}
Else IfEqual key0,tuafl, Send fault{Space}
Else IfEqual key0,tuasg, Send August{Space}
Else IfEqual key0,tuhn, Send hunt{Space}
Else IfEqual key0,tuin, Send unit{Space}
Else IfEqual key0,tuioacn, Send caution{Space}
Else IfEqual key0,tuipsd, Send stupid{Space}
Else IfEqual key0,tuiscn, Send succinct{Space}
Else IfEqual key0,tulz, Send utilize{Space}
Else IfEqual key0,tuoascm, Send accustom{Space}
Else IfEqual key0,tuocm, Send outcome{Space}
Else IfEqual key0,tuoslcn, Send consult{Space}
Else IfEqual key0,tupg, Send putting{Space}
Else IfEqual key0,tuskc, Send stuck{Space}
Else IfEqual key0,tyflc, Send facility{Space}
Else IfEqual key0,tuoghb, Send bought{Space}
Else IfEqual key0,tpxc, Send expect{Space}
Else IfEqual key0,tpcn, Send patience{Space}
Else IfEqual key0,tpn, Send patient{Space}
Else IfEqual key0,tpcvm, Send competitive{Space}
Else IfEqual key0,tuaghc, Send caught{Space}
Else IfEqual key0,tpscnm, Send compensate{Space}
Else IfEqual key0,tfl, Send left{Space}
Else IfEqual key0,tuadl, Send adult{Space}
Else IfEqual key0,tsvn, Send sensitive{Space}
Else IfEqual key0,tgvm, Send government{Space}
Else IfEqual key0,todn, Send don't{Space}
Else IfEqual key0,tacm, Send automatic{Space}
Else IfEqual key0,tx, Send text{Space}
Else IfEqual key0,tahc, Send catch{Space}
Else IfEqual key0,tahcm, Send match{Space}
Else IfEqual key0,tas, Send sat{Space}
Else IfEqual key0,tadln, Send additional{Space}
Else IfEqual key0,tadn, Send addition{Space}
Else IfEqual key0,tdlv, Send validate{Space}
Else IfEqual key0,tidcn, Send indicate{Space}
Else IfEqual key0,tipalc, Send capital{Space}
Else IfEqual key0,tisdn, Send instead{Space}
Else IfEqual key0,tpxc, Send expect{Space}	
Else IfEqual key0,tosl, Send lost{Space}
Else IfEqual key0,tplnm, Send implement{Space}
Else IfEqual key0,tscnl, Send constantly{Space}
Else IfEqual key0,tsdcn, Send distance{Space}
Else IfEqual key0,tsfgcn, Send significant{Space}
Else IfEqual key0,tuipn, Send input{Space}
Else IfEqual key0,tydfn, Send identify{Space}
Else IfEqual key0,tyusd, Send study{Space}
Else IfEqual key0,tasc, Send cast{Space}
Else IfEqual key0,tadhn, Send hadn’t{Space}
Else IfEqual key0,tahl, Send that’ll{Space}
Else IfEqual key0,tasgn, Send against{Space}
Else IfEqual key0,tashkn, Send thanks{Space}
Else IfEqual key0,tbn, Send button{Space}	
Else IfEqual key0,tiac, Send attic{Space}
Else IfEqual key0,tiasn, Send instant{Space}
Else IfEqual key0,tidg, Send digit{Space}
Else IfEqual key0,tif, Send fit{Space}
Else IfEqual key0,tifg, Send gift{Space}
Else IfEqual key0,tifgh, Send fight{Space}
Else IfEqual key0,tihkc, Send thick{Space}
Else IfEqual key0,tilm, Send limit{Space}
Else IfEqual key0,tioacn, Send contain{Space}
Else IfEqual key0,tioghn, Send tonight{Space}
Else IfEqual key0,tionm, Send motion{Space}
Else IfEqual key0,tism, Send mist{Space}
Else IfEqual key0,tkn, Send think{Space}
Else IfEqual key0,toa, Send tattoo{Space}
Else IfEqual key0,toasc, Send coast{Space}
Else IfEqual key0,tof, Send foot{Space}
Else IfEqual key0,toghn, Send thong{Space}
Else IfEqual key0,tops, Send stop{Space}
Else IfEqual key0,tpdn, Send independent{Space}
Else IfEqual key0,tpl, Send pollute{Space}
Else IfEqual key0,tplcnm, Send implication{Space}
Else IfEqual key0,tplnm, Send implement{Space}
Else IfEqual key0,tpslcnm, Send implications{Space}
Else IfEqual key0,tpsm, Send symptom{Space}
Else IfEqual key0,trade, Send trade{Space}
Else IfEqual key0,tsbm, Send submit{Space}
Else IfEqual key0,tscbn, Send substance{Space}
Else IfEqual key0,tsfnm, Send manifest{Space}
Else IfEqual key0,tsgn, Send suggestion{Space}
Else IfEqual key0,tsk, Send takes{Space}
Else IfEqual key0,tsxn, Send extension{Space}
Else IfEqual key0,tuah, Send authorize{Space}
Else IfEqual key0,tuahcn, Send authentic{Space}
Else IfEqual key0,tuioanm, Send mountain{Space}
Else IfEqual key0,tuisln, Send insult{Space}
Else IfEqual key0,tulc, Send cult{Space}
Else IfEqual key0,tuosd, Send outside{Space}
Else IfEqual key0,tuosh, Send south{Space}
Else IfEqual key0,tuosh, Send shout{Space}
Else IfEqual key0,tvn, Send initiative{Space}
Else IfEqual key0,tvnm, Send motivation{Space}
Else IfEqual key0,typsm, Send symptom{Space}
Else IfEqual key0,tyuocn, Send county{Space}
Else IfEqual key0,tdcn, Send condition{Space}
Else IfEqual key0,tdcn, Send candidate{Space}
Else IfEqual key0,tdcnm, Send document{Space}
Else IfEqual key0,tdxn, Send extend{Space}
Else IfEqual key0,tgn, Send negotiate{Space}
Else IfEqual key0,tidc, Send dict{Space}
Else IfEqual key0,tidfn, Send identify{Space}
Else IfEqual key0,tidm, Send immediate{Space}
Else IfEqual key0,tifl, Send lift{Space}
Else IfEqual key0,tiocm, Send commit{Space}
Else IfEqual key0,tiopc, Send topic{Space}
Else IfEqual key0,tip, Send tip{Space}
Else IfEqual key0,tips, Send tips{Space}
Else IfEqual key0,tisfh, Send shift{Space}
Else IfEqual key0,tisghl, Send slight{Space}
Else IfEqual key0,tisn, Send isn't{Space}
Else IfEqual key0,tlcm, Send climate{Space}
Else IfEqual key0,tln, Send national{Space}
Else IfEqual key0,tocv, Send octave{Space}
Else IfEqual key0,tojcvb, Send objective{Space}
Else IfEqual key0,tpan, Send appoint{Space}
Else IfEqual key0,tpanm, Send appointment{Space}
Else IfEqual key0,tpcm, Send compete{Space}
Else IfEqual key0,tplc, Send politic{Space}
Else IfEqual key0,tplcnm, Send complement{Space}
Else IfEqual key0,tpshcn, Send snapchat{Space}
Else IfEqual key0,tpsn, Send position{Space}
Else IfEqual key0,tscn, Send constant{Space}
Else IfEqual key0,tscn, Send consistent{Space}
Else IfEqual key0,tscn, Send constant{Space}
Else IfEqual key0,tscn, Send scientist{Space}
Else IfEqual key0,tsdcn, Send distance{Space}
Else IfEqual key0,tsdhn, Send thousand{Space}
Else IfEqual key0,tudc, Send duct{Space}
Else IfEqual key0,tuiosd, Send studio{Space}
Else IfEqual key0,tuis, Send suit{Space}
Else IfEqual key0,tuodb, Send doubt{Space}
Else IfEqual key0,tuodcn, Send conduct{Space}
Else IfEqual key0,tuokl, Send outlook{Space}
Else IfEqual key0,tush, Send shut{Space}
Else IfEqual key0,tvm, Send motive{Space}
Else IfEqual key0,tvn, Send invite{Space}
Else IfEqual key0,tyb, Send beauty{Space}
Else IfEqual key0,tycn, Send county{Space}
Else IfEqual key0,tyin, Send tiny{Space}
Else IfEqual key0,typac, Send capacity{Space}
Else IfEqual key0,tac, Send act{Space}
Else IfEqual key0,tflb, Send beautiful{Space}
Else IfEqual key0,tashn, Send hasn't{Space}
Else IfEqual key0,tflb, Send beautiful{Space}
Else IfEqual key0,tgvn, Send negative{Space}
Else IfEqual key0,tianm, Send maintain{Space}
Else IfEqual key0,til, Send it'll{Space}
Else IfEqual key0,tipacm, Send impact{Space}
Else IfEqual key0,tosh, Send shot{Space}
Else IfEqual key0,tscm, Send costume{Space}
Else IfEqual key0,tsfcn, Send fantastic{Space}
Else IfEqual key0,tuioas, Send situation{Space}
Else IfEqual key0,tuioas, Send situation{Space}
Else IfEqual key0,tacn, Send can't{Space}
Else IfEqual key0,tad, Send data{Space}
Else IfEqual key0,tafc, Send fact{Space}
Else IfEqual key0,tagkl, Send talking{Space}
Else IfEqual key0,tagn, Send against{Space}
Else IfEqual key0,tah, Send that{Space}
Else IfEqual key0,tahc, Send chat{Space}
Else IfEqual key0,tahkn, Send thank{Space}
Else IfEqual key0,tahn, Send than{Space}
Else IfEqual key0,takl, Send talk{Space}
Else IfEqual key0,talc, Send actually{Space}
Else IfEqual key0,tam, Send amount{Space}
Else IfEqual key0,tan, Send attention{Space}
Else IfEqual key0,tasdn, Send stand{Space}
Else IfEqual key0,tasf, Send fast{Space}
Else IfEqual key0,tash, Send that's{Space}
Else IfEqual key0,taskc, Send stack{Space}
Else IfEqual key0,tasl, Send last{Space}
Else IfEqual key0,tbm, Send bottom{Space}
Else IfEqual key0,tc, Send content{Space}
Else IfEqual key0,tcm, Send community{Space}
Else IfEqual key0,tcn, Send continue{Space}
Else IfEqual key0,td, Send today{Space}
Else IfEqual key0,tdcmn, Send document{Space}
Else IfEqual key0,tdfcn, Send confident{Space}
Else IfEqual key0,tdgl, Send digital{Space}
Else IfEqual key0,tdl, Send detail{Space}
Else IfEqual key0,tdn, Send don't{Space}
Else IfEqual key0,tdx, Send excited{Space}
Else IfEqual key0,tf, Send first{Space}
Else IfEqual key0,tfbn, Send benefit{Space}
Else IfEqual key0,tg, Send thing{Space}
Else IfEqual key0,tghlc, Send glitch{Space}
Else IfEqual key0,tgk, Send taking{Space}
Else IfEqual key0,tgk, Send taking{Space}
Else IfEqual key0,tgkl, Send talking{Space}
Else IfEqual key0,tgkl, Send talking{Space}
Else IfEqual key0,tgkn, Send thinking{Space}
Else IfEqual key0,tgm, Send meeting{Space}
Else IfEqual key0,tgnm, Send management{Space}
Else IfEqual key0,th, Send this{Space}
Else IfEqual key0,thb, Send to be honest{Space}
Else IfEqual key0,thkn, Send think{Space}
Else IfEqual key0,thvn, Send haven't{Space}
Else IfEqual key0,ti, Send it{Space}
Else IfEqual key0,tiagh, Send aight{Space}
Else IfEqual key0,tialn, Send initial{Space}
Else IfEqual key0,tian, Send anti
Else IfEqual key0,tib, Send bit{Space}
Else IfEqual key0,tid, Send it'd{Space}
Else IfEqual key0,tidm, Send immediate{Space}
Else IfEqual key0,tidn, Send didn't{Space}
Else IfEqual key0,tig, Send {BackSpace}ight{Space}
Else IfEqual key0,tigh, Send tight{Space}
Else IfEqual key0,tighl, Send light{Space}
Else IfEqual key0,tighn, Send night{Space}
Else IfEqual key0,tign, Send interesting{Space}
Else IfEqual key0,tih, Send I think{Space}
Else IfEqual key0,tihc, Send itch{Space}
Else IfEqual key0,tihkn, Send think{Space}
Else IfEqual key0,tiln, Send internal{Space}
Else IfEqual key0,tin, Send interest{Space}
Else IfEqual key0,tio, Send in terms of{Space}
Else IfEqual key0,tioan, Send {BackSpace}ation{Space}
Else IfEqual key0,tioln, Send international{Space}
Else IfEqual key0,tion, Send into{Space}
Else IfEqual key0,tiopsn, Send position{Space}
Else IfEqual key0,tis, Send it's{Space}
Else IfEqual key0,tisdcn, Send distinct{Space}
Else IfEqual key0,tisgh, Send sight{Space}
Else IfEqual key0,tish, Send this{Space}
Else IfEqual key0,tish, Send this{Space}
Else IfEqual key0,tiskc, Send stick{Space}
Else IfEqual key0,tisl, Send still{Space}
Else IfEqual key0,tisn, Send instead{Space}
Else IfEqual key0,tivn, Send interview{Space}
Else IfEqual key0,tiz, Send ization
Else IfEqual key0,tk, Send take{Space}
Else IfEqual key0,tkl, Send talk{Space}
Else IfEqual key0,tkm, Send market{Space}
Else IfEqual key0,tlb, Send built{Space}
Else IfEqual key0,tlcn, Send technical{Space}
Else IfEqual key0,tlnm, Send mental{Space}
Else IfEqual key0,tlxn, Send excellent{Space}
Else IfEqual key0,tm, Send time{Space}
Else IfEqual key0,tnm, Send minute{Space}
Else IfEqual key0,to, Send to{Space}
Else IfEqual key0,to, Send too{Space}
Else IfEqual key0,toacn, Send contact{Space}
Else IfEqual key0,toahl, Send although{Space}
Else IfEqual key0,toal, Send total{Space}
Else IfEqual key0,tobm, Send bottom{Space}
Else IfEqual key0,tocn, Send contract{Space}
Else IfEqual key0,todl, Send told{Space}
Else IfEqual key0,todn, Send don't{Space}
Else IfEqual key0,tog, Send got{Space}
Else IfEqual key0,toh, Send though{Space}
Else IfEqual key0,tohb, Send both{Space}
Else IfEqual key0,tohnm, Send month{Space}
Else IfEqual key0,tok, Send took{Space}
Else IfEqual key0,tol, Send lot{Space}
Else IfEqual key0,ton, Send not{Space}
Else IfEqual key0,ton, Send not{Space}
Else IfEqual key0,top, Send top{Space}
Else IfEqual key0,topad, Send adopt{Space}
Else IfEqual key0,toph, Send photo{Space}
Else IfEqual key0,tops, Send stop{Space}
Else IfEqual key0,topzm, Send optimize{Space}
Else IfEqual key0,tosc, Send cost{Space}
Else IfEqual key0,tosl, Send lost{Space}
Else IfEqual key0,tosm, Send most{Space}
Else IfEqual key0,tp, Send point{Space}
Else IfEqual key0,tpaflm, Send platform{Space}
Else IfEqual key0,tpaln, Send plant{Space}
Else IfEqual key0,tpas, Send past{Space}
Else IfEqual key0,tpc, Send corporate{Space}
Else IfEqual key0,tpcnm, Send component{Space}
Else IfEqual key0,tpd, Send department{Space}
Else IfEqual key0,tplm, Send multiple{Space}
Else IfEqual key0,tpln, Send potential{Space}
Else IfEqual key0,tps, Send post{Space}
Else IfEqual key0,tpsn, Send postpone{Space}
Else IfEqual key0,tpsv, Send positive{Space}
Else IfEqual key0,ts, Send its{Space}
Else IfEqual key0,ts, Send st
Else IfEqual key0,tsdn, Send doesn't{Space}
Else IfEqual key0,tsfgn, Send significant{Space}
Else IfEqual key0,tsg, Send things{Space}
Else IfEqual key0,tsdhn, Send shouldn't{Space}
Else IfEqual key0,tskm, Send mistake{Space}
Else IfEqual key0,tsl, Send list{Space}
Else IfEqual key0,tsln, Send listen{Space}
Else IfEqual key0,tslvm, Send themselves{Space}
Else IfEqual key0,tsm, Send sometimes{Space}
Else IfEqual key0,tsn, Send essentially{Space}
Else IfEqual key0,tua, Send uation
Else IfEqual key0,tuagh, Send taught{Space}
Else IfEqual key0,tualc, Send actual{Space}
Else IfEqual key0,tub, Send but{Space}
Else IfEqual key0,tuc, Send cut{Space}
Else IfEqual key0,tuiln, Send until{Space}
Else IfEqual key0,tuioasn, Send situation{Space}
Else IfEqual key0,tuipdlc, Send duplicate{Space}
Else IfEqual key0,tul, Send ultimately{Space}
Else IfEqual key0,tuo, Send out{Space}
Else IfEqual key0,tuoa, Send auto{Space}
Else IfEqual key0,tuoacn, Send account{Space}
Else IfEqual key0,tuobn, Send button{Space}
Else IfEqual key0,tuocn, Send count{Space}
Else IfEqual key0,tuohc, Send touch{Space}
Else IfEqual key0,tuohm, Send mouth{Space}
Else IfEqual key0,tuoscm, Send custom{Space}
Else IfEqual key0,tup, Send put{Space}
Else IfEqual key0,tusf, Send stuff{Space}
Else IfEqual key0,tusm, Send must{Space}
Else IfEqual key0,txc, Send context{Space}
Else IfEqual key0,ty, Send thank you{Space}
Else IfEqual key0,tyas, Send stay{Space}
Else IfEqual key0,tyaslv, Send vastly{Space}
Else IfEqual key0,tyd, Send today{Space}
Else IfEqual key0,tyi, Send {BackSpace}ity{Space}
Else IfEqual key0,tyiacv, Send activity{Space}
Else IfEqual key0,tyial, Send {BackSpace}ality{Space}
Else IfEqual key0,tyialb, Send ability{Space}
Else IfEqual key0,tyidn, Send identity{Space}
Else IfEqual key0,tyik, Send kitty{Space}
Else IfEqual key0,tyil, Send ility{Space}
Else IfEqual key0,tyilb, Send ibility{Space}
Else IfEqual key0,tyo, Send toy{Space}
Else IfEqual key0,tyoal, Send totally{Space}
Else IfEqual key0,typhlc, Send hypothetical{Space}
Else IfEqual key0,typlc, Send typical{Space}
Else IfEqual key0,tyvm, Send thank you very much{Space}
Else IfEqual key0,toaghc, Send got you.{Space}
Else IfEqual key0,tpah, Send path{Space}
Else IfEqual key0,tsc, Send society{Space}
Else IfEqual key0,tslvm, Send themselves{Space}
Else IfEqual key0,tuiasn, Send sustain{Space}
Else IfEqual key0,tuiosn, Send institution{Space}
Else IfEqual key0,tuogh, Send thought{Space}
Else IfEqual key0,tvn, Send native{Space}
Else IfEqual key0,tyic, Send city{Space}
Return
SENDY:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,yac, Send {BackSpace}acy{Space}
Else IfEqual key0,yad, Send day{Space}
Else IfEqual key0,yugl, Send ugly{Space}
Else IfEqual key0,tysg, Send staying{Space}
Else IfEqual key0,eyagcn, Send agency{Space}
Else IfEqual key0,yc, Send {BackSpace}cy{Space}
Else IfEqual key0,yadbn, Send anybody{Space}
Else IfEqual key0,ydgb, Send goodbye{Space}
Else IfEqual key0,ypg, Send paying{Space}
 Else IfEqual key0,ydvn, Send vineyard{Space}
Else IfEqual key0,yalb, Send {backspace}ably{Space}
Else IfEqual key0,ycvn, Send convey{Space}
Else IfEqual key0,yfl, Send fly{Space}
Else IfEqual key0,yohl, Send holy{Space}
Else IfEqual key0,yoph, Send hypo
Else IfEqual key0,ysln, Send analysis{Space}
Else IfEqual key0,yudb, Send buddy{Space}
Else IfEqual key0,yusg, Send guys{Space}
Else IfEqual key0,yab, Send baby{Space}
Else IfEqual key0,yoglcn, Send oncology{Space}
Else IfEqual key0,ypal, Send play{Space}
Else IfEqual key0,ysnm, Send mayonnaise{Space}
Else IfEqual key0,yujl, Send July{Space}
Else IfEqual key0,yopc, Send copy{Space}
Else IfEqual key0,ypshcn, Send physician{Space}
Else IfEqual key0,yam, Send may{Space}
Else IfEqual key0,yglcn, Send oncology{Space}
Else IfEqual key0,yoglcn, Send oncology{Space}
Else IfEqual key0,ydbn, Send beyond{Space}
Else IfEqual key0,yif, Send {BackSpace}ify{Space}
Else IfEqual key0,yoj, Send joy{Space}
Else IfEqual key0,ypshlc, Send physical{Space}
Else IfEqual key0,yan, Send any{Space}
Else IfEqual key0,yanm, Send many{Space}
Else IfEqual key0,yas, Send say{Space}
Else IfEqual key0,yasg, Send saying{Space}
Else IfEqual key0,yb, Send by{Space}
Else IfEqual key0,yd, Send yesterday{Space}
Else IfEqual key0,yfln, Send finally{Space}
Else IfEqual key0,yiadl, Send daily{Space}
Else IfEqual key0,yiaflm, Send family{Space}
Else IfEqual key0,yiasln, Send analysis{Space}
Else IfEqual key0,yif, Send ify{Space}
Else IfEqual key0,yil, Send {BackSpace}ily{Space}
Else IfEqual key0,yk, Send you know{Space}
Else IfEqual key0,yl, Send {BackSpace}ly{Space}
Else IfEqual key0,ym, Send my{Space}
Else IfEqual key0,yoan, Send annoy{Space}
Else IfEqual key0,yoanm, Send anymore{Space}
Else IfEqual key0,yob, Send boy{Space}
Else IfEqual key0,yodb, Send body{Space}
Else IfEqual key0,yoln, Send only{Space}
Else IfEqual key0,ypa, Send pay{Space}
Else IfEqual key0,ypah, Send happy{Space}
Else IfEqual key0,ypal, Send play{Space}
Else IfEqual key0,ypcm, Send completely{Space}
Else IfEqual key0,ysda, Send days{Space}
Else IfEqual key0,ysg, Send saying{Space}
Else IfEqual key0,ysm, Send sym
Else IfEqual key0,ysn, Send syn
Else IfEqual key0,yuasl, Send usually{Space}
Else IfEqual key0,yub, Send buy{Space}
Else IfEqual key0,yug, Send guy{Space}
Else IfEqual key0,yuogn, Send young{Space}
Else IfEqual key0,yal, Send lay{Space}
Else IfEqual key0,yufn, Send funny{Space}
Else IfEqual key0,yusb, Send busy{Space}
Return
SENDU:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,ua, Send au
Else IfEqual key0,uab, Send a bunch{Space}
Else IfEqual key0,uahnm, Send human{Space}
Else IfEqual key0,uasdhbn, Send husband{Space}
Else IfEqual key0,uinm, Send minimum{Space}
Else IfEqual key0,uiolcn, Send council{Space}
Else IfEqual key0,uodbn, Send bound{Space}
Else IfEqual key0,uodc, Send docu
Else IfEqual key0,uahlcn, Send launch{Space}
Else IfEqual key0,uashbn, Send husband{Space}
Else IfEqual key0,udh, Send duh{Space}
Else IfEqual key0,ugn, Send gun{Space}
Else IfEqual key0,uhcbn, Send bunch{Space}
Else IfEqual key0,uioac, Send caution{Space}
Else IfEqual key0,upbm, Send bump{Space}
Else IfEqual key0,uanm, Send manu{Space}
Else IfEqual key0,ufkc, Send fuck{Space}
Else IfEqual key0,uklc, Send luck{Space}
Else IfEqual key0,uisdc, Send discuss{Space}
Else IfEqual key0,usg, Send using{Space}
Else IfEqual key0,usgn, Send sung{Space}
Else IfEqual key0,ualbm, Send albums{Space}
Else IfEqual key0,uiosl, Send solution{Space}
Else IfEqual key0,uad, Send audience{Space}
Else IfEqual key0,uag, Send aug{Space}
Else IfEqual key0,uaghl, Send laugh{Space}
Else IfEqual key0,uagl, Send laugh{Space}
Else IfEqual key0,uahlcn, Send launch{Space}
Else IfEqual key0,uasl, Send usual{Space}
Else IfEqual key0,ucm, Send communicate{Space}
Else IfEqual key0,ud, Send you'd{Space}
Else IfEqual key0,udn, Send understand{Space}
Else IfEqual key0,ufl, Send full{Space}
Else IfEqual key0,uhcm, Send much{Space}
Else IfEqual key0,uicm, Send communication{Space}
Else IfEqual key0,uiocm, Send communication{Space}
Else IfEqual key0,uidn, Send industry{Space}
Else IfEqual key0,uin, Send uni
Else IfEqual key0,uiofcn, Send function{Space}
Else IfEqual key0,uios, Send ious
Else IfEqual key0,uioscn, Send conscious{Space}
Else IfEqual key0,uioslcn, Send conclusion{Space}
Else IfEqual key0,uipdl, Send dupli{Space}
Else IfEqual key0,uiscm, Send music{Space}
Else IfEqual key0,uisn, Send insurance{Space}
Else IfEqual key0,uivn, Send university{Space}
Else IfEqual key0,ul, Send you'll{Space}
Else IfEqual key0,un, Send un
Else IfEqual key0,unm, Send number{Space}
Else IfEqual key0,uo, Send ou
Else IfEqual key0,uodfn, Send found{Space}
Else IfEqual key0,uodl, Send loud{Space}
Else IfEqual key0,uodlc, Send cloud{Space}
Else IfEqual key0,uogh, Send ough{Space}
Else IfEqual key0,uop, Send population{Space}
Else IfEqual key0,uopn, Send upon{Space}
Else IfEqual key0,uos, Send {BackSpace}ous{Space}
Else IfEqual key0,uosdn, Send sound{Space}
Else IfEqual key0,uosfc, Send focus{Space}
Else IfEqual key0,uosm, Send so much{Space}
Else IfEqual key0,up, Send up{Space}
Else IfEqual key0,upascm, Send campus{Space}
Else IfEqual key0,upc, Send computer{Space}
Else IfEqual key0,upjm, Send jump{Space}
Else IfEqual key0,upl, Send pull{Space}
Else IfEqual key0,upsh, Send push{Space}
Else IfEqual key0,us, Send us{Space}
Else IfEqual key0,usb, Send sub
Else IfEqual key0,usf, Send yourself{Space}
Else IfEqual key0,ushc, Send such{Space}
Else IfEqual key0,usn, Send sun{Space}
Else IfEqual key0,uv, Send you've{Space}
Else IfEqual key0,udfn, Send fund{Space}
Else IfEqual key0,ufn, Send fun{Space}
Else IfEqual key0,usfl, Send yourself{Space}
Return
SENDE:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,ea, Send ea	
Else IfEqual key0,epalcb, Send capable{Space}
Else IfEqual key0,eriv, Send river{Space}
Else IfEqual key0,eruipm, Send premium{Space}
Else IfEqual key0,etf, Send feet{Space}
Else IfEqual key0,ertypah, Send therapy{Space}
Else IfEqual key0,eriacm, Send America{Space}
Else IfEqual key0,eruop, Send Europe{Space}
Else IfEqual key0,eosln, Send lesson{Space}
Else IfEqual key0,epaln, Send plane{Space}
Else IfEqual key0,ealcn, Send cancel{Space}
Else IfEqual key0,epaslc, Send places{Space}
Else IfEqual key0,ealn, Send lane{Space}
Else IfEqual key0,etpasln, Send pleasant{Space}
Else IfEqual key0,eas, Send assess{Space}
Else IfEqual key0,eruips, Send surprise{Space}
Else IfEqual key0,easf, Send safety{Space}
Else IfEqual key0,efhc, Send chef{Space}
Else IfEqual key0,erualcn, Send nuclear{Space}
Else IfEqual key0,eialv, Send alive{Space}
Else IfEqual key0,eyiasl, Send easily{Space}
Else IfEqual key0,eiasn, Send insane{Space}
Else IfEqual key0,eifkn, Send knife{Space}
Else IfEqual key0,eihcn, Send niche{Space}
Else IfEqual key0,eihk, Send hike{Space}
Else IfEqual key0,eil, Send lie{Space}
Else IfEqual key0,eil, Send lie{Space}
Else IfEqual key0,eilcn, Send incline{Space}
Else IfEqual key0,eiocnm, Send economic{Space}
Else IfEqual key0,eiocnm, Send income{Space}
Else IfEqual key0,eiplcn, Send pencil{Space}
Else IfEqual key0,eisdl, Send slide{Space}
Else IfEqual key0,eiskvn, Send knives{Space}
Else IfEqual key0,eislm, Send smile{Space}
Else IfEqual key0,eisz, Send seize{Space}
Else IfEqual key0,ekn, Send knee{Space}
Else IfEqual key0,elb, Send bell{Space}
Else IfEqual key0,eoadb, Send Adobe{Space}
Else IfEqual key0,eoaslm, Send molasses{Space}
Else IfEqual key0,eofc, Send coffee{Space}
Else IfEqual key0,eosdcn, Send condense{Space}
Else IfEqual key0,eosln, Send lesson{Space}
Else IfEqual key0,eosn, Send nose{Space}
Else IfEqual key0,epa, Send ape{Space}
Else IfEqual key0,epn, Send pen{Space}
Else IfEqual key0,epsl, Send spell{Space}
Else IfEqual key0,erab, Send bear{Space}
Else IfEqual key0,eradg, Send regard{Space}
Else IfEqual key0,eradlc, Send declare{Space}
Else IfEqual key0,eraf, Send fear{Space}
Else IfEqual key0,eraf, Send fear{Space}
Else IfEqual key0,eralx, Send relax{Space}
Else IfEqual key0,eras, Send erase{Space}
Else IfEqual key0,erdcbm, Send December{Space}
Else IfEqual key0,erf, Send refer{Space}
Else IfEqual key0,erhc, Send cheer{Space}
Else IfEqual key0,erias, Send raise{Space}
Else IfEqual key0,eridb, Send bride{Space}
Else IfEqual key0,eridgb, Send bridge{Space}
Else IfEqual key0,eridl, Send riddle{Space}
Else IfEqual key0,erin, Send inner{Space}
Else IfEqual key0,eriopscm, Send comprise{Space}
Else IfEqual key0,eripscb, Send prescribe{Space}
Else IfEqual key0,erm, Send mere{Space}
Else IfEqual key0,ero, Send error{Space}
Else IfEqual key0,eroash, Send hoarse{Space}
Else IfEqual key0,erocm, Send commerce{Space}
Else IfEqual key0,erokb, Send broke{Space}
Else IfEqual key0,eros, Send rose{Space}
Else IfEqual key0,eroscn, Send censor{Space}
Else IfEqual key0,erovbnm, Send November{Space}
Else IfEqual key0,erpas, Send spare{Space}
Else IfEqual key0,ertag, Send target{Space}
Else IfEqual key0,ertagn, Send generate{Space}
Else IfEqual key0,ertiacn, Send interact{Space}
Else IfEqual key0,ertiagc, Send cigarette{Space}
Else IfEqual key0,ertihn, Send inherent{Space}
Else IfEqual key0,ertion, Send orient{Space}
Else IfEqual key0,ertipac, Send practice{Space}
Else IfEqual key0,ertoa, Send rotate{Space}
Else IfEqual key0,ertocb, Send October{Space}
Else IfEqual key0,ertosk, Send stroke{Space}
Else IfEqual key0,ertpsbm, Send September{Space}
Else IfEqual key0,ertuanm, Send remunerate{Space}
Else IfEqual key0,ertycm, Send cemetery{Space}
Else IfEqual key0,ertyop, Send property{Space}
Else IfEqual key0,erud, Send educator{Space}
Else IfEqual key0,erudbn, Send burden{Space}
Else IfEqual key0,eruin, Send urine{Space}
Else IfEqual key0,eruopcn, Send pronounce{Space}
Else IfEqual key0,erusc, Send rescue{Space}
Else IfEqual key0,eruvn, Send revenue{Space}
Else IfEqual key0,eryoasc, Send accessory{Space}
Else IfEqual key0,eshcm, Send scheme{Space}
Else IfEqual key0,eslm, Send smell{Space}
Else IfEqual key0,etadn, Send attend{Space}
Else IfEqual key0,etagn, Send agent{Space}
Else IfEqual key0,etagn, Send tangent{Space}
Else IfEqual key0,etaln, Send talent{Space}
Else IfEqual key0,etanm, Send meant{Space}
Else IfEqual key0,etask, Send stake{Space}
Else IfEqual key0,etghln, Send length{Space}
Else IfEqual key0,etiahlcn, Send technical{Space}
Else IfEqual key0,etioanm, Send nominate{Space}
Else IfEqual key0,etiosn, Send tension{Space}
Else IfEqual key0,etiosn, Send tension{Space}
Else IfEqual key0,etolb, Send bottle{Space}
Else IfEqual key0,etolb, Send bottle{Space}
Else IfEqual key0,etoshlc, Send clothes{Space}
Else IfEqual key0,etpal, Send plate{Space}
Else IfEqual key0,etpasc, Send aspect{Space}
Else IfEqual key0,etps, Send steep{Space}
Else IfEqual key0,etscn, Send sentence{Space}
Else IfEqual key0,etub, Send tube{Space}
Else IfEqual key0,etuhc, Send chute{Space}
Else IfEqual key0,etum, Send mute{Space}
Else IfEqual key0,etuocm, Send outcome{Space}
Else IfEqual key0,etups, Send upset{Space}
Else IfEqual key0,etyoscm, Send ecosystem{Space}
Else IfEqual key0,eudgj, Send judge{Space}
Else IfEqual key0,eudgn, Send nudge{Space}
Else IfEqual key0,eujn, Send June{Space}
Else IfEqual key0,eupsl, Send pulse{Space}
Else IfEqual key0,eyagcn, Send agency{Space}
Else IfEqual key0,eyp, Send yep{Space}
Else IfEqual key0,rtyl, Send reality{Space}
Else IfEqual key0,etanm, Send meant{Space}
Else IfEqual key0,easn, Send sane{Space}
Else IfEqual key0,eiasn, Send insane{Space}
Else IfEqual key0,epsd, Send sped{Space}
Else IfEqual key0,ec, Send {BackSpace}{BackSpace}ce{Space}
Else IfEqual key0,etun, Send tune{Space}
Else IfEqual key0,erofc, Send force{Space}
Else IfEqual key0,etioasc, Send associate{Space}
Else IfEqual key0,eionm, Send mention{Space}
Else IfEqual key0,eyh, Send hey{Space}
Else IfEqual key0,eyp, Send yep{Space}
Else IfEqual key0,eodcnm, Send commend{Space}
Else IfEqual key0,etisn, Send intense{Space}
Else IfEqual key0,eruios, Send capable{Space}
Else IfEqual key0,eualvb, Send valuable{Space}
Else IfEqual key0,etiagvn, Send navigate{Space}
Else IfEqual key0,erasc, Send scare{Space}
Else IfEqual key0,ertom, Send remote{Space}
Else IfEqual key0,ertlxn, Send internal{Space}
Else IfEqual key0,eropsc, Send process{Space}
Else IfEqual key0,eacbm, Send became{Space}
Else IfEqual key0,eaghlcn, Send challenge{Space}
Else IfEqual key0,etakn, Send taken{Space}
Else IfEqual key0,etpam, Send attempt{Space}
Else IfEqual key0,eivn, Send vein{Space}
Else IfEqual key0,erpash, Send phrase{Space}
Else IfEqual key0,ertpasn, Send transparent{Space}
Else IfEqual key0,ead, Send dead{Space}
Else IfEqual key0,eadhln, Send handle{Space}
Else IfEqual key0,eagbn, Send began{Space}
Else IfEqual key0,eashk, Send shake{Space}
Else IfEqual key0,edcvn, Send evidence{Space}
Else IfEqual key0,eiasd, Send disease{Space}
Else IfEqual key0,eiasl, Send aisle{Space}
Else IfEqual key0,eihlcv, Send vehicle{Space}
Else IfEqual key0,eilm, Send mile{Space}
Else IfEqual key0,eiom, Send emotion{Space}
Else IfEqual key0,eisdn, Send inside{Space}
Else IfEqual key0,eishn, Send shine{Space}
Else IfEqual key0,eislcn, Send silence{Space}
Else IfEqual key0,eakl, Send lake{Space}
Else IfEqual key0,eoaln, Send alone{Space}
Else IfEqual key0,eocvn, Send convene{Space}
Else IfEqual key0,eodgl, Send lodge{Space}
Else IfEqual key0,eolcn, Send clone{Space}
Else IfEqual key0,eolnm, Send lemon{Space}
Else IfEqual key0,eolnm, Send melon{Space}
Else IfEqual key0,eopk, Send poke{Space}
Else IfEqual key0,eoslv, Send solve{Space}
Else IfEqual key0,eoslv, Send solve{Space}
Else IfEqual key0,epahc, Send cheap{Space}
Else IfEqual key0,eradg, Send grade{Space}
Else IfEqual key0,erafm, Send frame{Space}
Else IfEqual key0,eraghc, Send charge{Space}
Else IfEqual key0,eragnm, Send manager{Space}
Else IfEqual key0,erc, Send rec recognize{Space}
Else IfEqual key0,erdh, Send herd{Space}
Else IfEqual key0,ergcnm, Send emergency{Space}
Else IfEqual key0,ergm, Send merge{Space}
Else IfEqual key0,erial, Send earlier{Space}
Else IfEqual key0,erialcm, Send miracle{Space}
Else IfEqual key0,erif, Send fire{Space}
Else IfEqual key0,eriosn, Send senior{Space}
Else IfEqual key0,eripl, Send ripple{Space}
Else IfEqual key0,eriplcn, Send principle{Space}
Else IfEqual key0,eripsn, Send inspire{Space}
Else IfEqual key0,erlv, Send lever{Space}
Else IfEqual key0,ern, Send {backspace}ern{Space}
Else IfEqual key0,eroc, Send core{Space}
Else IfEqual key0,eroc, Send core{Space}
Else IfEqual key0,eroh, Send hero{Space}
Else IfEqual key0,erohl, Send holler{Space}
Else IfEqual key0,erosc, Send score{Space}
Else IfEqual key0,eroslc, Send closer{Space}
Else IfEqual key0,erta, Send tear{Space}
Else IfEqual key0,ertad, Send trade{Space}
Else IfEqual key0,ertd, Send editor{Space}
Else IfEqual key0,ertihn, Send neither{Space}
Else IfEqual key0,ertilc, Send electric{Space}
Else IfEqual key0,ertiod, Send editor{Space}
Else IfEqual key0,ertipac, Send practice{Space}
Else IfEqual key0,ertipac, Send practice{Space}
Else IfEqual key0,ertish, Send theirs{Space}
Else IfEqual key0,ertjc, Send reject{Space}
Else IfEqual key0,ertlc, Send electric{Space}
Else IfEqual key0,ertofgn, Send forgotten{Space}
Else IfEqual key0,ertpvn, Send prevent{Space}
Else IfEqual key0,ertuic, Send recruit{Space}
Else IfEqual key0,ertul, Send turtle{Space}
Else IfEqual key0,ertun, Send return{Space}
Else IfEqual key0,ertuo, Send route{Space}
Else IfEqual key0,eruag, Send argue{Space}
Else IfEqual key0,eruas, Send assure{Space}
Else IfEqual key0,erubm, Send bummer{Space}
Else IfEqual key0,eruoslcn, Send counselor{Space}
Else IfEqual key0,eruosvn, Send nervous{Space}
Else IfEqual key0,erusn, Send nurse{Space}
Else IfEqual key0,eshl, Send shell{Space}
Else IfEqual key0,etas, Send state{Space}
Else IfEqual key0,etb, Send bet{Space}
Else IfEqual key0,etb, Send bet{Space}
Else IfEqual key0,etdn, Send tend{Space}
Else IfEqual key0,etfcn, Send efficient{Space}
Else IfEqual key0,etfcn, Send efficient{Space}
Else IfEqual key0,etihkcn, Send kitchen{Space}
Else IfEqual key0,etion, Send intention{Space}
Else IfEqual key0,etionm, Send emotion{Space}
Else IfEqual key0,etipdn, Send independent{Space}
Else IfEqual key0,etisln, Send nationalities{Space}
Else IfEqual key0,etlvt, Send evaluate{Space}
Else IfEqual key0,etop, Send poet{Space}
Else IfEqual key0,etpaln, Send planet{Space}
Else IfEqual key0,etpxm, Send exempt{Space}
Else IfEqual key0,etsg, Send setting{Space}
Else IfEqual key0,etsg, Send gets{Space}
Else IfEqual key0,etsln, Send essential{Space}
Else IfEqual key0,etualv, Send evaluate{Space}
Else IfEqual key0,etuascbn, Send substance{Space}
Else IfEqual key0,etuisn, Send institute{Space}
Else IfEqual key0,etypln, Send plenty{Space}
Else IfEqual key0,euag, Send gauge{Space}
Else IfEqual key0,euagv, Send vague{Space}
Else IfEqual key0,euasb, Send abuse{Space}
Else IfEqual key0,euh, Send hue{Space}
Else IfEqual key0,euiflcn, Send influence{Space}
Else IfEqual key0,euisdc, Send suicide{Space}
Else IfEqual key0,euoslcn, Send counsel{Space}
Else IfEqual key0,eupdl, Send puddle{Space}
Else IfEqual key0,ey, Send eye{Space}
Else IfEqual key0,eyadl, Send delay{Space}
Else IfEqual key0,eyiafc, Send efficacy{Space}
Else IfEqual key0,eyl, Send yell{Space}
Else IfEqual key0,eyocvn, Send convey{Space}	
Else IfEqual key0,erpisn, Send inspire{Space}
Else IfEqual key0,eopsk, Send spoke{Space}
Else IfEqual key0,epal, Send leap{Space}
Else IfEqual key0,epdxn, Send expend{Space}
Else IfEqual key0,eriav, Send arrive{Space}
Else IfEqual key0,erop, Send proper{Space}
Else IfEqual key0,erpdc, Send deprec{Space}
Else IfEqual key0,ertipn, Send interpret{Space}
Else IfEqual key0,ertuipn, Send interrupt{Space}
Else IfEqual key0,etialnm, Send eliminate{Space}
Else IfEqual key0,etiascn, Send instance{Space}
Else IfEqual key0,etiscn, Send scientist{Space}
Else IfEqual key0,etivn, Send invite{Space}
Else IfEqual key0,eruopd, Send produce{Space}
Else IfEqual key0,eacm, Send came{Space}	
Else IfEqual key0,eadcn, Send dance{Space}	
Else IfEqual key0,erudm, Send drummer{Space}
Else IfEqual key0,easfl, Send false{Space}
Else IfEqual key0,easl, Send sale{Space}
Else IfEqual key0,easlc, Send scale{Space}
Else IfEqual key0,edg, Send edge{Space}
Else IfEqual key0,efb, Send beef{Space}
Else IfEqual key0,eicv, Send vice{Space}
Else IfEqual key0,eidv, Send dive{Space}
Else IfEqual key0,eign, Send engine{Space}
Else IfEqual key0,einm, Send mine{Space}
Else IfEqual key0,eiocvn, Send convince{Space}
Else IfEqual key0,eiosn, Send session{Space}
Else IfEqual key0,elc, Send cell{Space}
Else IfEqual key0,eohn, Send hone{Space}
Else IfEqual key0,eradm, Send dream{Space}
Else IfEqual key0,erasd, Send address{Space}
Else IfEqual key0,erdg, Send degree{Space}
Else IfEqual key0,ergcn, Send encourage{Space}
Else IfEqual key0,erih, Send hire{Space}
Else IfEqual key0,erilc, Send circle{Space}
Else IfEqual key0,erpscn, Send presence{Space}
Else IfEqual key0,erti, Send tire{Space}
Else IfEqual key0,ertipac, Send practice{Space}
Else IfEqual key0,ertlcn, Send electronic{Space}
Else IfEqual key0,ertocn, Send concert{Space}
Else IfEqual key0,ertof, Send effort{Space}
Else IfEqual key0,ertopc, Send protect{Space}
Else IfEqual key0,ertpx, Send expert{Space}
Else IfEqual key0,ertuion, Send routine{Space}
Else IfEqual key0,ertuo, Send route{Space}
Else IfEqual key0,eruosc, Send course{Space}
Else IfEqual key0,eruosc, Send course{Space}
Else IfEqual key0,erusc, Send secure{Space}
Else IfEqual key0,erusc, Send secure{Space}
Else IfEqual key0,eryl, Send rely{Space}
Else IfEqual key0,escn, Send scene{Space}
Else IfEqual key0,esg, Send seeing{Space}
Else IfEqual key0,etab, Send beat{Space}
Else IfEqual key0,etad, Send date{Space}
Else IfEqual key0,etad, Send date{Space}
Else IfEqual key0,etadh, Send death{Space}
Else IfEqual key0,etalm, Send metal{Space}
Else IfEqual key0,etfh, Send theft{Space}
Else IfEqual key0,etiadc, Send dictate{Space}
Else IfEqual key0,etin, Send intent{Space}
Else IfEqual key0,etiocm, Send committee{Space}
Else IfEqual key0,etivn, Send invent{Space}
Else IfEqual key0,etogn, Send gotten{Space}
Else IfEqual key0,etoscn, Send consent{Space}
Else IfEqual key0,etov, Send vote{Space}
Else IfEqual key0,etpxc, Send except{Space}
Else IfEqual key0,etupad, Send update{Space}
Else IfEqual key0,ety, Send yet{Space}
Else IfEqual key0,etyuab, Send beauty{Space}
Else IfEqual key0,euagln, Send language{Space}
Else IfEqual key0,euasm, Send assume{Space}
Else IfEqual key0,euisdc, Send suicide{Space}
Else IfEqual key0,eulb, Send blue{Space}
Else IfEqual key0,eunm, Send menu{Space}
Else IfEqual key0,eunm, Send menu{Space}
Else IfEqual key0,eupas, Send pause{Space}
Else IfEqual key0,eradcn, Send dancer{Space}	
Else IfEqual key0,eagn, Send engage{Space}
Else IfEqual key0,eiom, Send emotion{Space}
Else IfEqual key0,eoavb, Send above{Space}
Else IfEqual key0,eojk, Send joke{Space}
Else IfEqual key0,epd, Send deep{Space}
Else IfEqual key0,ergn, Send green{Space}
Else IfEqual key0,erianm, Send remain{Space}
Else IfEqual key0,eropv, Send prove{Space}
Else IfEqual key0,erpf, Send prefer{Space}
Else IfEqual key0,ertah, Send heart{Space}
Else IfEqual key0,ertahb, Send breathe{Space}
Else IfEqual key0,ertan, Send aren't{Space}
Else IfEqual key0,ertioa, Send iteration{Space}
Else IfEqual key0,ertioa, Send iteration{Space}
Else IfEqual key0,ertipac, Send practice{Space}
Else IfEqual key0,ertpan, Send parent{Space}
Else IfEqual key0,erygn, Send energy{Space}
Else IfEqual key0,esdn, Send send{Space}
Else IfEqual key0,etasg, Send stage{Space}
Else IfEqual key0,etasg, Send stage{Space}
Else IfEqual key0,etiops, Send opposite{Space}
Else IfEqual key0,etlnm, Send element{Space}
Else IfEqual key0,etolc, Send collect{Space}
Else IfEqual key0,eton, Send note{Space}
Else IfEqual key0,etuc, Send cute{Space}
Else IfEqual key0,etusg, Send suggest{Space}
Else IfEqual key0,etvn, Send event{Space}
Else IfEqual key0,etyhd, Send they'd{Space}
Else IfEqual key0,etyhl, Send theyll{Space}
Else IfEqual key0,euasc, Send cause{Space}
Else IfEqual key0,euoacn, Send announce{Space}
Else IfEqual key0,eusdc, Send succeed{Space}
Else IfEqual key0,eusdc, Send succeed{Space}
Else IfEqual key0,eusln, Send unless{Space}
Else IfEqual key0,eyojn, Send enjoy{Space}
Else IfEqual key0,eps, Send especially{Space} 
Else IfEqual key0,eacn, Send {BackSpace}ance{Space}	
Else IfEqual key0,eadh, Send head{Space}		
Else IfEqual key0,eadl, Send lead{Space}	
Else IfEqual key0,eadm, Send made{Space}	
Else IfEqual key0,eafc, Send face{Space}	
Else IfEqual key0,eaflm, Send female{Space}	
Else IfEqual key0,eafm, Send fame{Space}	
Else IfEqual key0,eag, Send age{Space}	
Else IfEqual key0,eaghcn, Send change{Space}	
Else IfEqual key0,eaghlcn, Send challenge{Space}	
Else IfEqual key0,eagm, Send game{Space}	
Else IfEqual key0,eagnm, Send manage{Space}	
Else IfEqual key0,eagv, Send gave{Space}	
Else IfEqual key0,eahc, Send each{Space}	
Else IfEqual key0,eahcn, Send chance{Space}	
Else IfEqual key0,eahl, Send heal{Space}	
Else IfEqual key0,eahv, Send have{Space}	
Else IfEqual key0,eakm, Send make{Space}	
Else IfEqual key0,ealb, Send able{Space}	
Else IfEqual key0,ealcn, Send clean{Space}	
Else IfEqual key0,ealm, Send male{Space}	
Else IfEqual key0,ealn, Send lean{Space}	
Else IfEqual key0,eanm, Send name{Space}	
Else IfEqual key0,easb, Send base{Space}	
Else IfEqual key0,easc, Send case{Space}	
Else IfEqual key0,easdk, Send asked{Space}	
Else IfEqual key0,easf, Send safe{Space}	
Else IfEqual key0,easkm, Send makes{Space}	
Else IfEqual key0,easm, Send same{Space}	
Else IfEqual key0,easv, Send save{Space}	
Else IfEqual key0,eb, Send be{Space}	
Else IfEqual key0,ecn, Send necessary{Space}	
Else IfEqual key0,ecn, Send {BackSpace}ence{Space}	
Else IfEqual key0,ed, Send {BackSpace}ed{Space}	
Else IfEqual key0,edc, Send dec{Space}	
Else IfEqual key0,edf, Send definitely{Space}	
Else IfEqual key0,edl, Send led{Space}	
Else IfEqual key0,edn, Send need{Space}	
Else IfEqual key0,edn, Send end{Space}	
Else IfEqual key0,edv, Send develop{Space}	
Else IfEqual key0,ef, Send for example{Space}	
Else IfEqual key0,eg, Send everything{Space}	
Else IfEqual key0,egb, Send being{Space}	
Else IfEqual key0,egl, Send leg{Space}	
Else IfEqual key0,eh, Send he{Space}	
Else IfEqual key0,ehkc, Send check{Space}	
Else IfEqual key0,eiacvn, Send vaccine{Space}	
Else IfEqual key0,eiad, Send idea{Space}	
Else IfEqual key0,eiadm, Send media{Space}	
Else IfEqual key0,eiagnm, Send imagine{Space}	
Else IfEqual key0,eialm, Send email{Space}	
Else IfEqual key0,eic, Send ice{Space}
Else IfEqual key0,eicn, Send nice{Space}	
Else IfEqual key0,eid, Send ide	
Else IfEqual key0,eidc, Send decide{Space}	
Else IfEqual key0,eidfl, Send field{Space}	
Else IfEqual key0,eidfl, Send field{Space}	
Else IfEqual key0,eidfn, Send define{Space}	
Else IfEqual key0,eidlm, Send middle{Space}	
Else IfEqual key0,eidn, Send indeed{Space}	
Else IfEqual key0,eifl, Send life{Space}	
Else IfEqual key0,eigbn, Send begin{Space}	
Else IfEqual key0,eigbn, Send beginning{Space}	
Else IfEqual key0,eilb, Send {BackSpace}ible{Space}	
Else IfEqual key0,eilv, Send live{Space}	
Else IfEqual key0,eiocv, Send voice{Space}	
Else IfEqual key0,eiodv, Send video{Space}	
Else IfEqual key0,eiofc, Send office{Space}	
Else IfEqual key0,eiohc, Send choice{Space}	
Else IfEqual key0,eiolvn, Send involve{Space}	
Else IfEqual key0,eiosc, Send section{Space}	
Else IfEqual key0,eiosn, Send noise{Space}	
Else IfEqual key0,eip, Send pipe{Space}	
Else IfEqual key0,eipc, Send piece{Space}	
Else IfEqual key0,eis, Send {BackSpace}ies{Space}	
Else IfEqual key0,eiscn, Send since{Space}	
Else IfEqual key0,eisd, Send side{Space}	
Else IfEqual key0,eisgln, Send single{Space}	
Else IfEqual key0,eiv, Send I've{Space}	
Else IfEqual key0,eiz, Send {BackSpace}ize{Space}	
Else IfEqual key0,ekcn, Send neck{Space}	
Else IfEqual key0,elcn, Send necessarily{Space}	
Else IfEqual key0,elv, Send level{Space}	
Else IfEqual key0,em, Send me{Space}	
Else IfEqual key0,en, Send en	
Else IfEqual key0,en, Send en	
Else IfEqual key0,enm, Send men{Space}	
Else IfEqual key0,eoasn, Send season{Space}	
Else IfEqual key0,eoc, Send eco{Space}	
Else IfEqual key0,eocn, Send once{Space}	
Else IfEqual key0,eodc, Send code{Space}	
Else IfEqual key0,eodlm, Send model{Space}	
Else IfEqual key0,eodn, Send done{Space}	
Else IfEqual key0,eogn, Send enough{Space}
Else IfEqual key0,euoghn, Send gone{Space}	
Else IfEqual key0,eohl, Send hole{Space}	
Else IfEqual key0,eohm, Send home{Space}	
Else IfEqual key0,eolv, Send love{Space}	
Else IfEqual key0,eon, Send one{Space}	
Else IfEqual key0,eop, Send people{Space}	
Else IfEqual key0,eopdlv, Send develop{Space}	
Else IfEqual key0,eoph, Send hope{Space}	
Else IfEqual key0,eophn, Send phone{Space}	
Else IfEqual key0,eopn, Send open{Space}	
Else IfEqual key0,eops, Send pose{Space}	
Else IfEqual key0,eopshn, Send phones{Space}	
Else IfEqual key0,eosd, Send does{Space}	
Else IfEqual key0,eosg, Send goes{Space}	
Else IfEqual key0,eosh, Send shoe{Space}	
Else IfEqual key0,eoshc, Send chose{Space}	
Else IfEqual key0,eosl, Send lose{Space}	
Else IfEqual key0,eoslc, Send close{Space}	
Else IfEqual key0,eosm, Send some{Space}	
Else IfEqual key0,eov, Send everyone{Space}	
Else IfEqual key0,eozn, Send zone{Space}	
Else IfEqual key0,epac, Send pace{Space}	
Else IfEqual key0,epag, Send page{Space}	
Else IfEqual key0,epak, Send peak{Space}	
Else IfEqual key0,epalc, Send place{Space}	
Else IfEqual key0,epasc, Send space{Space}	
Else IfEqual key0,epash, Send shape{Space}	
Else IfEqual key0,epask, Send speak{Space}	
Else IfEqual key0,epasl, Send please{Space}	
Else IfEqual key0,epdn, Send depend{Space}	
Else IfEqual key0,ephl, Send help{Space}	
Else IfEqual key0,epk, Send keep{Space}	
Else IfEqual key0,epsc, Send spec{Space}	
Else IfEqual key0,epscl, Send specifically{Space}	
Else IfEqual key0,epsdn, Send spend{Space}	
Else IfEqual key0,epsh, Send sheep{Space}	
Else IfEqual key0,epsl, Send sleep{Space}	
Else IfEqual key0,epx, Send experience{Space}	
Else IfEqual key0,er, Send {BackSpace}er{Space}	
Else IfEqual key0,era, Send are{Space}	
Else IfEqual key0,erac, Send care{Space}	
Else IfEqual key0,eracm, Send camera{Space}	
Else IfEqual key0,eradfl, Send federal	
Else IfEqual key0,eradh, Send heard{Space}	
Else IfEqual key0,erady, Send ready{Space}	
Else IfEqual key0,erag, Send agree{Space}	
Else IfEqual key0,eragh, Send hearing{Space}	
Else IfEqual key0,eragl, Send large{Space}	
Else IfEqual key0,eragn, Send range{Space}	
Else IfEqual key0,erah, Send hear{Space}	
Else IfEqual key0,erahc, Send reach{Space}	
Else IfEqual key0,erakb, Send break{Space}	
Else IfEqual key0,eral, Send real{Space}	
Else IfEqual key0,eralc, Send clear{Space}	
Else IfEqual key0,eraln, Send learn{Space}	
Else IfEqual key0,eran, Send near{Space}	
Else IfEqual key0,erash, Send share{Space}	
Else IfEqual key0,erashc, Send search{Space}	
Else IfEqual key0,erbm, Send member{Space}	
Else IfEqual key0,erf, Send free{Space}	
Else IfEqual key0,erh, Send her{Space}	
Else IfEqual key0,erias, Send raise{Space}	
Else IfEqual key0,eridfn, Send friend{Space}	
Else IfEqual key0,eridlv, Send deliver{Space}	
Else IfEqual key0,eridlv, Send deliver{Space}	
Else IfEqual key0,eridnm, Send remind{Space}	
Else IfEqual key0,eridv, Send derive{Space}	
Else IfEqual key0,erifb, Send brief{Space}	
Else IfEqual key0,erifn, Send infer{Space}	
Else IfEqual key0,erign, Send engineer{Space}	
Else IfEqual key0,eriogn, Send region{Space}	
Else IfEqual key0,eriopa, Send operation{Space}	
Else IfEqual key0,eriopdv, Send provide{Space}	
Else IfEqual key0,erioscn, Send scenario{Space}	
Else IfEqual key0,eriosdc, Send description{Space}	
Else IfEqual key0,eriovn, Send environment{Space}	
Else IfEqual key0,eripc, Send price{Space}	
Else IfEqual key0,eriscb, Send scribe{Space}	
Else IfEqual key0,erisdc, Send describe{Space}	
Else IfEqual key0,eroasn, Send reason{Space}	
Else IfEqual key0,erocn, Send concern{Space}	
Else IfEqual key0,erocv, Send cover{Space}	
Else IfEqual key0,erod, Send order{Space}	
Else IfEqual key0,erodc, Send record{Space}	
Else IfEqual key0,erof, Send offer{Space}	
Else IfEqual key0,erol, Send role{Space}	
Else IfEqual key0,eropacm, Send compare{Space}	
Else IfEqual key0,eropafcnm, Send performance{Space}	
Else IfEqual key0,eroplbm, Send problem{Space}	
Else IfEqual key0,eroplx, Send explore{Space}	
Else IfEqual key0,eropsg, Send progress{Space}	
Else IfEqual key0,eropsn, Send person{Space}	
Else IfEqual key0,erosh, Send horse{Space}	
Else IfEqual key0,erov, Send over{Space}	
Else IfEqual key0,erp, Send per{Space}
Else IfEqual key0,erpa, Send prepare{Space}	
Else IfEqual key0,erpalc, Send replace{Space}	
Else IfEqual key0,erps, Send press{Space}	
Else IfEqual key0,ers, Send res{Space}	
Else IfEqual key0,erscn, Send screen{Space}	
Else IfEqual key0,ersv, Send serve{Space}	
Else IfEqual key0,ert, Send tree{Space}	
Else IfEqual key0,erta, Send rate{Space}	
Else IfEqual key0,ertac, Send react{Space}	
Else IfEqual key0,ertafh, Send father{Space}	
Else IfEqual key0,ertag, Send great{Space}	
Else IfEqual key0,ertahc, Send character{Space}	
Else IfEqual key0,ertal, Send later{Space}	
Else IfEqual key0,ertalcn, Send central{Space}	
Else IfEqual key0,ertam, Send matter{Space}	
Else IfEqual key0,ertax, Send extra	
Else IfEqual key0,ertb, Send better{Space}	
Else IfEqual key0,ertcn, Send recent{Space}	
Else IfEqual key0,erth, Send there{Space}	
Else IfEqual key0,erths, Send there's{Space}	
Else IfEqual key0,ertiacn, Send certain{Space}	
Else IfEqual key0,ertiagn, Send integrate{Space}	
Else IfEqual key0,ertial, Send retail{Space}	
Else IfEqual key0,ertialcv, Send vertical{Space}	
Else IfEqual key0,ertialv, Send relative{Space}	
Else IfEqual key0,ertidc, Send credit{Space}	
Else IfEqual key0,ertifl, Send filter{Space}	
Else IfEqual key0,ertih, Send their{Space}	
Else IfEqual key0,ertin, Send inter	
Else IfEqual key0,ertioadcn, Send coordinate{Space}	
Else IfEqual key0,ertipa, Send therapist{Space}	
Else IfEqual key0,ertipah, Send therapist{Space}	
Else IfEqual key0,ertipash, Send therapist{Space}	
Else IfEqual key0,ertiph, Send therapist{Space}	
Else IfEqual key0,ertis, Send sister{Space}	
Else IfEqual key0,ertl, Send letter{Space}	
Else IfEqual key0,ertm, Send term{Space}	
Else IfEqual key0,ertn, Send enter{Space}	
Else IfEqual key0,erto, Send tore{Space}	
Else IfEqual key0,ertoasg, Send storage{Space}	
Else IfEqual key0,ertoc, Send correct{Space}	
Else IfEqual key0,ertogh, Send together{Space}	
Else IfEqual key0,ertoh, Send other{Space}	
Else IfEqual key0,ertohb, Send bother{Space}	
Else IfEqual key0,ertohm, Send mother{Space}	
Else IfEqual key0,ertop, Send report{Space}	
Else IfEqual key0,ertos, Send store{Space}	
Else IfEqual key0,ertosn, Send testosterone{Space}	
Else IfEqual key0,ertpa, Send parate{Space}	
Else IfEqual key0,ertpan, Send partner{Space}	
Else IfEqual key0,ertpcn, Send percent{Space}	
Else IfEqual key0,ertpsn, Send present{Space}	
Else IfEqual key0,erts, Send rest{Space}	
Else IfEqual key0,ertsh, Send there's{Space}	
Else IfEqual key0,ertu, Send true{Space}	
Else IfEqual key0,ertuac, Send accurate{Space}	
Else IfEqual key0,ertuafcnm, Send manufacture{Space}	
Else IfEqual key0,ertuan, Send nature{Space}	
Else IfEqual key0,ertucn, Send current{Space}	
Else IfEqual key0,ertuf, Send future{Space}	
Else IfEqual key0,ertuipc, Send picture{Space}	
Else IfEqual key0,ertulc, Send culture{Space}	
Else IfEqual key0,ertusl, Send result{Space}	
Else IfEqual key0,ertvnm, Send environment{Space}	
Else IfEqual key0,ertxm, Send extreme{Space}	
Else IfEqual key0,ertyh, Send they're{Space}	
Else IfEqual key0,ertyn, Send entry{Space}	
Else IfEqual key0,eru, Send you're{Space}	
Else IfEqual key0,erudc, Send reduce{Space}	
Else IfEqual key0,erudn, Send under{Space}	
Else IfEqual key0,erul, Send rule{Space}	
Else IfEqual key0,eruops, Send purpose{Space}	
Else IfEqual key0,erups, Send super{Space}	
Else IfEqual key0,erus, Send sure{Space}	
Else IfEqual key0,erusfl, Send yourself{Space}	
Else IfEqual key0,erusm, Send summer{Space}	
Else IfEqual key0,erv, Send ever{Space}	
Else IfEqual key0,ervn, Send never{Space}	
Else IfEqual key0,ervn, Send never{Space}	
Else IfEqual key0,ery, Send every{Space}	
Else IfEqual key0,eryal, Send early{Space}	
Else IfEqual key0,eryogc, Send grocery{Space}	
Else IfEqual key0,eryph, Send hyper	
Else IfEqual key0,eryusg, Send surgery{Space}	
Else IfEqual key0,eryv, Send every{Space}	
Else IfEqual key0,es, Send see{Space}	
Else IfEqual key0,esc, Send second{Space}	
Else IfEqual key0,esdn, Send send{Space}	
Else IfEqual key0,esfl, Send self{Space}	
Else IfEqual key0,esh, Send she{Space}	
Else IfEqual key0,esk, Send seek{Space}	
Else IfEqual key0,esl, Send else{Space}	
Else IfEqual key0,eslv, Send {BackSpace}selves{Space}	
Else IfEqual key0,esm, Send seem{Space}	
Else IfEqual key0,esn, Send sense{Space}	
Else IfEqual key0,et, Send even though{Space}	
Else IfEqual key0,eta, Send ate{Space}	
Else IfEqual key0,etadh, Send hated{Space}	
Else IfEqual key0,etadln, Send dental{Space}	
Else IfEqual key0,etafc, Send affect{Space}	
Else IfEqual key0,etaghc, Send teaching{Space}	
Else IfEqual key0,etah, Send hate{Space}	
Else IfEqual key0,etahc, Send teach{Space}	
Else IfEqual key0,etahl, Send health{Space}	
Else IfEqual key0,etak, Send take{Space}	
Else IfEqual key0,etal, Send late{Space}	
Else IfEqual key0,etalb, Send table{Space}	
Else IfEqual key0,etam, Send team{Space}	
Else IfEqual key0,etan, Send neat{Space}	
Else IfEqual key0,etas, Send state{Space}	
Else IfEqual key0,etascn, Send stance{Space}	
Else IfEqual key0,etasl, Send least{Space}	
Else IfEqual key0,etaxc, Send exact{Space}	
Else IfEqual key0,etc, Send et cetera{Space}	
Else IfEqual key0,etcn, Send cent{Space}	
Else IfEqual key0,etdn, Send tend{Space}	
Else IfEqual key0,etfc, Send effect{Space}	
Else IfEqual key0,etfl, Send felt{Space}	
Else IfEqual key0,etg, Send get{Space}	
Else IfEqual key0,etgv, Send everything{Space}	
Else IfEqual key0,eth, Send the{Space}	
Else IfEqual key0,ethc, Send tech{Space}	
Else IfEqual key0,ethcn, Send technology{Space}	
Else IfEqual key0,ethm, Send them{Space}	
Else IfEqual key0,ethn, Send then{Space}	
Else IfEqual key0,etiacv, Send active{Space}	
Else IfEqual key0,etiav, Send ative	
Else IfEqual key0,etiglcn, Send intelligence{Space}	
Else IfEqual key0,etigln, Send intelligent{Space}	
Else IfEqual key0,etihc, Send ethic{Space}	
Else IfEqual key0,etil, Send little{Space}	
Else IfEqual key0,etilcn, Send client{Space}	
Else IfEqual key0,etim, Send item{Space}	
Else IfEqual key0,etim, Send time{Space}	
Else IfEqual key0,etiocm, Send committee{Space}	
Else IfEqual key0,etiocn, Send notice{Space}	
Else IfEqual key0,etionm, Send mention{Space}	
Else IfEqual key0,etipan, Send patient{Space}	
Else IfEqual key0,etis, Send site{Space}	
Else IfEqual key0,etis, Send ities{Space}	
Else IfEqual key0,etism, Send times{Space}	
Else IfEqual key0,etisvn, Send invest{Space}	
Else IfEqual key0,etisx, Send exist{Space}	
Else IfEqual key0,etiv, Send tive{Space}	
Else IfEqual key0,etixc, Send excite{Space}	
Else IfEqual key0,etl, Send let{Space}	
Else IfEqual key0,etm, Send met{Space}	
Else IfEqual key0,etm, Send met{Space}	
Else IfEqual key0,etn, Send net{Space}	
Else IfEqual key0,etnm, Send {BackSpace}ment{Space}	
Else IfEqual key0,etoalc, Send locate{Space}	
Else IfEqual key0,etocn, Send connect{Space}	
Else IfEqual key0,etocnm, Send comment{Space}	
Else IfEqual key0,etofn, Send often{Space}	
Else IfEqual key0,etogh, Send together{Space}	
Else IfEqual key0,etohl, Send hotel{Space}	
Else IfEqual key0,etojcb, Send object{Space}	
Else IfEqual key0,etonm, Send moment{Space}	
Else IfEqual key0,etopcn, Send concept{Space}	
Else IfEqual key0,etopkc, Send pocket{Space}	
Else IfEqual key0,etosh, Send those{Space}	
Else IfEqual key0,etoshn, Send honest{Space}	
Else IfEqual key0,etpac, Send accept{Space}	
Else IfEqual key0,etpdn, Send dependent{Space}	
Else IfEqual key0,etpk, Send kept{Space}	
Else IfEqual key0,etps, Send step{Space}	
Else IfEqual key0,etps, Send step{Space}	
Else IfEqual key0,etpsn, Send spent{Space}	
Else IfEqual key0,tpxc, Send expect{Space}	
Else IfEqual key0,ets, Send set{Space}	
Else IfEqual key0,etsb, Send best{Space}	
Else IfEqual key0,etsh, Send these{Space}	
Else IfEqual key0,etshc, Send chest{Space}	
Else IfEqual key0,etshlb, Send establish{Space}	
Else IfEqual key0,etsl, Send let's{Space}	
Else IfEqual key0,etslc, Send select{Space}	
Else IfEqual key0,etsn, Send sent{Space}
Else IfEqual key0,etysln, Send sent{Space}	
Else IfEqual key0,etuadc, Send educate{Space}	
Else IfEqual key0,etuagnm, Send augment{Space}	
Else IfEqual key0,etuinm, Send minute{Space}	
Else IfEqual key0,etuipadlc, Send duplicate{Space}	
Else IfEqual key0,etuodcnm, Send document{Space}	
Else IfEqual key0,etusdn, Send student{Space}	
Else IfEqual key0,etuvn, Send eventually{Space}	
Else IfEqual key0,etx, Send external{Space}	
Else IfEqual key0,etxn, Send next{Space}	
Else IfEqual key0,etyh, Send they{Space}	
Else IfEqual key0,etyhv, Send they've{Space}	
Else IfEqual key0,etyidn, Send identity{Space}	
Else IfEqual key0,etyoscm, Send ecosystem{Space}	
Else IfEqual key0,etyp, Send type{Space}	
Else IfEqual key0,etysl, Send style{Space}	
Else IfEqual key0,etysm, Send system{Space}	
Else IfEqual key0,euaglc, Send colleague{Space}	
Else IfEqual key0,eualv, Send value{Space}	
Else IfEqual key0,eud, Send education{Space}	
Else IfEqual key0,eugh, Send huge{Space}	
Else IfEqual key0,euiadcn, Send audience{Space}	
Else IfEqual key0,euis, Send issue{Space}	
Else IfEqual key0,euops, Send suppose{Space}	
Else IfEqual key0,euosfcn, Send confuse{Space}	
Else IfEqual key0,euosh, Send house{Space}	
Else IfEqual key0,eus, Send use{Space}	
Else IfEqual key0,eusc, Send success{Space}	
Else IfEqual key0,eusdn, Send sudden{Space}	
Else IfEqual key0,eusg, Send guess{Space}	
Else IfEqual key0,euv, Send you've{Space}	
Else IfEqual key0,ev, Send ever{Space}	
Else IfEqual key0,evb, Send everybody{Space}	
Else IfEqual key0,evn, Send even{Space}	
Else IfEqual key0,ex, Send exactly{Space}	
Else IfEqual key0,ex, Send ex	
Else IfEqual key0,exc, Send excellent{Space}	
Else IfEqual key0,eyalzn, Send analyze{Space}	
Else IfEqual key0,eyas, Send easy{Space}	
Else IfEqual key0,eyb, Send bye{Space}	
Else IfEqual key0,eyk, Send key{Space}	
Else IfEqual key0,eylc, Send cycle{Space}	
Else IfEqual key0,eyonm, Send money{Space}	
Else IfEqual key0,eys, Send yes{Space}	
Else IfEqual key0,eysflm, Send myself{Space}	
Else IfEqual key0,eysflm, Send myself{Space}	
Else IfEqual key0,eyv, Send every{Space}
Else IfEqual key0,ealbm, Send blame{Space}
Else IfEqual key0,easl, Send lease{Space}
Else IfEqual key0,edkc, Send deck{Space}
Else IfEqual key0,eranm, Send manner{Space}
Else IfEqual key0,erfl, Send freelance{Space}
Else IfEqual key0,eriopd, Send period{Space}
Else IfEqual key0,eripx, Send expire{Space}
Else IfEqual key0,erpdc, Send precede{Space}
Else IfEqual key0,ertian, Send entertain{Space}
Else IfEqual key0,etid, Send edit{Space}
Else IfEqual key0,etlc, Send elect{Space}
Else IfEqual key0,euidg, Send guide{Space}
Else IfEqual key0,euign, Send genuine{Space}
Else IfEqual key0,eyaglc, Send legacy{Space}	
Return
SENDO:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,oa, Send anyone{Space}
Else IfEqual key0,oan, Send anyone{Space}
Else IfEqual key0,oadl, Send load{Space}
Else IfEqual key0,oagnm, Send among{Space}
Else IfEqual key0,odfl, Send fold{Space}
Else IfEqual key0,ogm, Send Oh my god.{Space}
Else IfEqual key0,oahlc, Send alcohol{Space}
Else IfEqual key0,odgl, Send gold{Space}
Else IfEqual key0,odlb, Send bold{Space}
Else IfEqual key0,odlc, Send cold{Space}
Else IfEqual key0,ofkl, Send folk{Space}
Else IfEqual key0,ogl, Send log{Space}
Else IfEqual key0,ozm, Send zoom{Space}
Else IfEqual key0,omsgh, Send Oh my gosh.{Space}
Else IfEqual key0,osgh, Send gosh{Space}
Else IfEqual key0,osn, Send soon{Space}
Else IfEqual key0,oaln, Send loan{Space}
Else IfEqual key0,obm, Send bomb{Space}
Else IfEqual key0,oshkc, Send shock{Space}
Else IfEqual key0,oxb, Send box{Space}
Else IfEqual key0,oag, Send ago{Space}
Else IfEqual key0,osn, Send son{Space}
Else IfEqual key0,oagl, Send goal{Space}
Else IfEqual key0,oagln, Send along{Space}
Else IfEqual key0,oagn, Send going to{Space}
Else IfEqual key0,oasl, Send also{Space}
Else IfEqual key0,oc, Send could{Space}
Else IfEqual key0,ocm, Send com
Else IfEqual key0,ocn, Send con
Else IfEqual key0,ocnm, Send common{Space}
Else IfEqual key0,od, Send do{Space}
Else IfEqual key0,odc, Send document{Space}
Else IfEqual key0,odf, Send food{Space}
Else IfEqual key0,odg, Send doing{Space}
Else IfEqual key0,odhl, Send hold{Space}
Else IfEqual key0,odl, Send old{Space}
Else IfEqual key0,odm, Send {BackSpace}dom{Space}
Else IfEqual key0,of, Send of{Space}
Else IfEqual key0,ofc, Send of course{Space}
Else IfEqual key0,ofc, Send of course{Space}
Else IfEqual key0,ofcn, Send confirm{Space}
Else IfEqual key0,ofn, Send information{Space}
Else IfEqual key0,og, Send go{Space}
Else IfEqual key0,ogln, Send long{Space}
Else IfEqual key0,oglv, Send loving{Space}
Else IfEqual key0,ogn, Send gone{Space}
Else IfEqual key0,ohm, Send homo
Else IfEqual key0,ojb, Send job{Space}
Else IfEqual key0,ok, Send kind of{Space}
Else IfEqual key0,okb, Send book{Space}
Else IfEqual key0,okc, Send cook{Space}
Else IfEqual key0,okl, Send look{Space}
Else IfEqual key0,oklc, Send lock{Space}
Else IfEqual key0,oln, Send online{Space}
Else IfEqual key0,on, Send on{Space}
Else IfEqual key0,onm, Send moon{Space}
Else IfEqual key0,op, Send opportunity{Space}
Else IfEqual key0,opn, Send open{Space}
Else IfEqual key0,ops, Send opportunities{Space}
Else IfEqual key0,opsh, Send shop{Space}
Else IfEqual key0,os, Send so{Space}
Else IfEqual key0,osf, Send sort of{Space}
Else IfEqual key0,osfkl, Send folks{Space}
Else IfEqual key0,osgn, Send song{Space}
Else IfEqual key0,oshlc, Send school{Space}
Else IfEqual key0,osm, Send someone{Space}
Else IfEqual key0,osn, Send soon{Space}
Else IfEqual key0,ovb, Send obviously{Space}
Else IfEqual key0,oalc, Send local{Space}
Else IfEqual key0,oflc, Send official{Space}
Else IfEqual key0,oh, Send Oh,{Space}
Else IfEqual key0,osdl, Send sold{Space}
Return
SENDP:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
    Send {%key0%}  
IfEqual key0,pac, Send cap{Space}
Else IfEqual key0,pk, Send keep{Space}	
Else IfEqual key0,updg, Send pudding{Space}		
Else IfEqual key0,psfc, Send specific{Space}
Else IfEqual key0,pfhl, Send helpful{Space}
Else IfEqual key0,phl, Send helpful{Space}
Else IfEqual key0,pakc, Send pack{Space}
Else IfEqual key0,pam, Send map{Space}
Else IfEqual key0,pasm, Send spam{Space}
Else IfEqual key0,pgk, Send package{Space}
Else IfEqual key0,pk, Send keep{Space}
Else IfEqual key0,pal, Send application{Space}
Else IfEqual key0,pb, Send possible{Space}
Else IfEqual key0,pag, Send gap{Space}
Else IfEqual key0,pasl, Send applies{Space}
Else IfEqual key0,pcnm, Send companion{Space}
Else IfEqual key0,pdxn, Send expand{Space}
Else IfEqual key0,pgk, Send package{Space}
Else IfEqual key0,plcnm, Send complain{Space}
Else IfEqual key0,plcnm, Send complain{Space}
Else IfEqual key0,psdn, Send dispense{Space}
Else IfEqual key0,psxvn, Send expansive{Space}
Else IfEqual key0,pa, Send app{Space}
Else IfEqual key0,paglz, Send apologize{Space}
Else IfEqual key0,palcm, Send accomplish{Space}
Else IfEqual key0,pashlcm, Send accomplish{Space}
Else IfEqual key0,psk, Send speak{Space}
Else IfEqual key0,pslbm, Send impossible{Space}
Else IfEqual key0,psx, Send expose{Space}
Else IfEqual key0,paln, Send plan{Space}
Else IfEqual key0,pas, Send pass{Space}
Else IfEqual key0,pfh, Send hopefully{Space}
Else IfEqual key0,ph, Send hope{Space}
Else IfEqual key0,pslc, Send special{Space}
Else IfEqual key0,pcm, Send company{Space}
Else IfEqual key0,pdcm, Send pandemic{Space}
Else IfEqual key0,pf, Send perfect{Space}
Else IfEqual key0,pfh, Send hopefully{Space}
Else IfEqual key0,pg, Send page{Space}
Else IfEqual key0,pgh, Send happening{Space}
Else IfEqual key0,pglb, Send publishing{Space}
Else IfEqual key0,phn, Send happen{Space}
Else IfEqual key0,pjm, Send jump{Space}
Else IfEqual key0,pl, Send people{Space}
Else IfEqual key0,plb, Send possibly{Space}
Else IfEqual key0,plc, Send couple{Space}
Else IfEqual key0,plcb, Send public{Space}
Else IfEqual key0,plcm, Send complete{Space}
Else IfEqual key0,plxm, Send example{Space}
Else IfEqual key0,plxn, Send explain{Space}
Else IfEqual key0,pn, Send no problem{Space}
Else IfEqual key0,ps, Send specifically{Space}
Else IfEqual key0,pscm, Send companies{Space}
Else IfEqual key0,psd, Send speed{Space}
Else IfEqual key0,psh, Send hospital{Space}
Else IfEqual key0,psl, Send please{Space}
Else IfEqual key0,pslb, Send possible{Space}
Else IfEqual key0,pslm, Send simple{Space}
Else IfEqual key0,psn, Send passion{Space}
Else IfEqual key0,px, Send experience{Space}
Else IfEqual key0,pshlb, Send publish{Space}
Return
SENDA:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,ab, Send about{Space}
Else IfEqual key0,adv, Send avoid{Space}
Else IfEqual key0,adcvn, Send advance{Space}
Else IfEqual key0,askc, Send sack{Space}
Else IfEqual key0,abn, Send banana{Space}
Else IfEqual key0,afv, Send favorite{Space}
Else IfEqual key0,ac, Send actually{Space}
Else IfEqual key0,adgl, Send glad{Space}
Else IfEqual key0,adbn, Send band{Space}
Else IfEqual key0,adln, Send land{Space}
Else IfEqual key0,adnm, Send damn{Space}
Else IfEqual key0,aghn, Send hang{Space}
Else IfEqual key0,agkbn, Send banking{Space}
Else IfEqual key0,alcm, Send calm{Space}
Else IfEqual key0,ascn, Send scan{Space}
Else IfEqual key0,asdhn, Send hands{Space}
Else IfEqual key0,asdnm, Send admission{Space}
Else IfEqual key0,adcm, Send academic{Space}
Else IfEqual key0,adcm, Send academic{Space}
Else IfEqual key0,adcv, Send advice{Space}
Else IfEqual key0,adcv, Send advice{Space}
Else IfEqual key0,adm, Send mad{Space}
Else IfEqual key0,adv, Send advertise{Space}
Else IfEqual key0,agcn, Send agency{Space}
Else IfEqual key0,agnm, Send among{Space}
Else IfEqual key0,ahkc, Send hack{Space}
Else IfEqual key0,ahl, Send hall{Space}
Else IfEqual key0,aln, Send alone{Space}
Else IfEqual key0,asd, Send ads{Space}
Else IfEqual key0,asdv, Send advise{Space}
Else IfEqual key0,ashc, Send cash{Space}
Else IfEqual key0,asm, Send assume{Space}
Else IfEqual key0,agv, Send average{Space}
Else IfEqual key0,ahcv, Send achieve{Space}
Else IfEqual key0,aklcb, Send black{Space}
Else IfEqual key0,avb, Send above{Space}
Else IfEqual key0,acn, Send can{Space}
Else IfEqual key0,adgcn, Send dancing{Space}	
Else IfEqual key0,adb, Send anybody{Space}
Else IfEqual key0,adf, Send afterwards{Space}
Else IfEqual key0,adgc, Send according{Space}
Else IfEqual key0,adh, Send had{Space}
Else IfEqual key0,adhn, Send hand{Space}
Else IfEqual key0,adl, Send already{Space}
Else IfEqual key0,af, Send after{Space}
Else IfEqual key0,afg, Send affecting{Space}
Else IfEqual key0,afhl, Send half{Space}
Else IfEqual key0,afl, Send fall{Space}
Else IfEqual key0,ag, Send anything{Space}
Else IfEqual key0,agm, Send amazing{Space}
Else IfEqual key0,agn, Send again{Space}
Else IfEqual key0,akc, Send {Backspace}ack{Space}
Else IfEqual key0,akcb, Send back{Space}
Else IfEqual key0,al, Send all{Space}
Else IfEqual key0,alb, Send lab{Space}
Else IfEqual key0,alc, Send call{Space}
Else IfEqual key0,alm, Send almost{Space}
Else IfEqual key0,alvb, Send available{Space}
Else IfEqual key0,am, Send am{Space}
Else IfEqual key0,an, Send an{Space}
Else IfEqual key0,anm, Send man{Space}
Else IfEqual key0,as, Send as{Space}
Else IfEqual key0,asb, Send absolutely{Space}
Else IfEqual key0,asdk, Send asked{Space}
Else IfEqual key0,asgl, Send glass{Space}
Else IfEqual key0,ash, Send has{Space}
Else IfEqual key0,ashl, Send lash{Space}
Else IfEqual key0,ask, Send ask{Space}
Else IfEqual key0,aslc, Send class{Space}
Else IfEqual key0,aslm, Send small{Space}
Else IfEqual key0,akbn, Send bank{Space}
Else IfEqual key0,asn, Send answer{Space}
Else IfEqual key0,axv, Send vaccine{Space}
Else IfEqual key0,azm, Send Amazon{Space}
Else IfEqual key0,ad, Send ad{Space}
Return
SENDS:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,sbn, Send business{Space}
Else IfEqual key0,scb, Send basic{Space}
Else IfEqual key0,shm, Send somehow{Space}
Else IfEqual key0,sdhlc, Send schedule{Space}
Else IfEqual key0,sz, Send size{Space}
Else IfEqual key0,scm, Send comes{Space}
Else IfEqual key0,sdb, Send besides{Space}
Else IfEqual key0,sdhbn, Send husband{Space}
Else IfEqual key0,sdn, Send inside{Space}
Else IfEqual key0,shl, Send she'll{Space}
Else IfEqual key0,slvb, Send visible{Space}
Else IfEqual key0,sd, Send somebody{Space}
Else IfEqual key0,scnm, Send consume{Space}
Else IfEqual key0,slcn, Send license{Space}
Else IfEqual key0,sln, Send lesson{Space}
Else IfEqual key0,snm, Send mission{Space}
Else IfEqual key0,snm, Send mission{Space}
Else IfEqual key0,svm, Send massive{Space}
Else IfEqual key0,svn, Send vision{Space}
Else IfEqual key0,sdc, Send describe{Space}
Else IfEqual key0,sfcn, Send confuse{Space}
Else IfEqual key0,sfl, Send {BackSpace}self{Space}
Else IfEqual key0,shn, Send hasn't{Space}
Else IfEqual key0,sdcn, Send decision{Space}
Else IfEqual key0,sdgn, Send design{Space}
Else IfEqual key0,sdlcm, Send social media{Space}
Else IfEqual key0,sf, Send For sure.{Space}
Else IfEqual key0,sfgcn, Send significant{Space}
Else IfEqual key0,sflm, Send myself{Space}
Else IfEqual key0,sg, Send something{Space}
Else IfEqual key0,sgm, Send message{Space}
Else IfEqual key0,sh, Send should{Space}
Else IfEqual key0,sdhn, Send shouldn't{Space}
Else IfEqual key0,shn, Send shouldn't{Space}
Else IfEqual key0,sh, Send should{Space}
Else IfEqual key0,sl, Send sell{Space}
Else IfEqual key0,slc, Send social{Space}
Else IfEqual key0,slcb, Send basically{Space}
Else IfEqual key0,slp, Send sleep{Space}
Else IfEqual key0,slv, Send visual{Space}
Else IfEqual key0,sm, Send some{Space}
Else IfEqual key0,sn, Send seen{Space}
Else IfEqual key0,srcv, Send service{Space}
Else IfEqual key0,st, Send street{Space}
Else IfEqual key0,sv, Send versus{Space}
Else IfEqual key0,sxcvl, Send exclusive{Space}
Return
SENDD:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,dbn, Send nobody{Space}
Else IfEqual key0,dcm, Send command{Space}
Else IfEqual key0,dhln, Send handle{Space}
Else IfEqual key0,dnm, Send domain{Space}
Else IfEqual key0,dhln, Send handle{Space}
Else IfEqual key0,dghln, Send handling{Space}
Else IfEqual key0,dcn, Send couldn't{Space}
Else IfEqual key0,dcn, Send candid{Space}
Else IfEqual key0,dcnm, Send medicine{Space}
Else IfEqual key0,dhn, Send hadn't{Space}
Else IfEqual key0,dlcn, Send include{Space}
Else IfEqual key0,dcv, Send device{Space}
Else IfEqual key0,dfkb, Send feedback{Space}
Else IfEqual key0,dfn, Send found{Space}
Else IfEqual key0,dg, Send good{Space}
Else IfEqual key0,dgb, Send background{Space}
Else IfEqual key0,dglb, Send building{Space}
Else IfEqual key0,dgm, Send damage{Space}
Else IfEqual key0,dgn, Send ground{Space}
Else IfEqual key0,dhbn, Send behind{Space}
Else IfEqual key0,dl, Send deal{Space}
Else IfEqual key0,dlb, Send build{Space}
Else IfEqual key0,dlcbn, Send incredible{Space}
Else IfEqual key0,dlcm, Send medical{Space}
Else IfEqual key0,dlcm, Send medical{Space}
Else IfEqual key0,dm, Send made{Space}
Else IfEqual key0,dn, Send done{Space}
Else IfEqual key0,drg, Send during {Space}
Else IfEqual key0,dv, Send everyday{Space}
Else IfEqual key0,dvm, Send development{Space}
Else IfEqual key0,dx, Send excited{Space}
Return
SENDF:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,fb, Send before{Space}
Else IfEqual key0,fcm, Send comfortable{Space}
Else IfEqual key0,fcn, Send finance{Space}
Else IfEqual key0,flb, Send belief{Space}
Else IfEqual key0,flcbn, Send beneficial{Space}
Else IfEqual key0,fh, Send helpful{Space}
Else IfEqual key0,fgl, Send feeling{Space}	
Else IfEqual key0,fl, Send feel{Space}
Else IfEqual key0,flcn, Send financial{Space}
Else IfEqual key0,fln, Send final{Space}
Else IfEqual key0,fn, Send fine{Space}
Return
SENDG:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0% 
IfEqual key0,gb, Send being{Space}
Else IfEqual key0,gc, Send coming{Space}
Else IfEqual key0,gen, Send general{Space}
Else IfEqual key0,ghcn, Send change{Space}
Else IfEqual key0,glbn, Send belong{Space}
Else IfEqual key0,gcm, Send magic{Space}
Else IfEqual key0,gh, Send having{Space}
Else IfEqual key0,gkl, Send looking{Space}
Else IfEqual key0,ghlcn, Send challenge{Space}
Else IfEqual key0,gkm, Send making{Space}
Else IfEqual key0,gl, Send learning{Space}
Else IfEqual key0,glc, Send college{Space}
Else IfEqual key0,gln, Send general{Space}
Else IfEqual key0,glv, Send leaving{Space}
Else IfEqual key0,gf, Send girlfriend{Space}
Else IfEqual key0,gvn, Send given{Space}
Else IfEqual key0,gm, Send making{Space}
Else IfEqual key0,gn, Send nothing{Space}
Else IfEqual key0,gnm, Send manage{Space}
Else IfEqual key0,gv, Send give{Space}
Else IfEqual key0,gv, Send very good{Space}
Else IfEqual key0,gvm, Send moving{Space}
Else IfEqual key0,gx, Send exciting{Space}
Else IfEqual key0,gznm, Send magazine{Space}
Return
SENDH:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,hc, Send choice{Space}
Else IfEqual key0,hkcn, Send chicken{Space}
Else IfEqual key0,hl, Send he'll{Space}
Else IfEqual key0,hlcv, Send vehicle{Space}
 Else IfEqual key0,hm, Send Mm-hmm.{Space}
Else IfEqual key0,hv, Send have{Space}
Else IfEqual key0,hcnm, Send machine{Space}
Else IfEqual key0,hlcn, Send channel{Space}
Return

SENDI:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,ia, Send ai
Else IfEqual key0,idfc, Send difficult{Space}
Else IfEqual key0,idm, Send mid{Space}
Else IfEqual key0,iahcn, Send China{Space}
Else IfEqual key0,ias, Send Asia{Space}
Else IfEqual key0,ialnm, Send animal{Space}
Else IfEqual key0,iahcn, Send chain{Space}
Else IfEqual key0,iam, Send aim{Space}
Else IfEqual key0,iasl, Send sail{Space}
Else IfEqual key0,iav, Send via{Space}
Else IfEqual key0,igkln, Send inkling{Space}
Else IfEqual key0,iol, Send oil{Space}
Else IfEqual key0,iolbm, Send limbo{Space}
Else IfEqual key0,iphc, Send chip{Space}
Else IfEqual key0,ipl, Send pill{Space}
Else IfEqual key0,ipsn, Send spin{Space}
Else IfEqual key0,iskl, Send skill{Space}
Else IfEqual key0,ixm, Send mix{Space}
Else IfEqual key0,ian, Send {BackSpace}ian{Space}
Else IfEqual key0,iafl, Send fail{Space}
Else IfEqual key0,ipslbm, Send impossible{Space}
Else IfEqual key0,ioa, Send {BackSpace}ation{Space}
Else IfEqual key0,ioadv, Send avoid{Space}
Else IfEqual key0,igz, Send {BackSpace}izing{Space}
Else IfEqual key0,iadc, Send acid{Space}
Else IfEqual key0,iagcm, Send magic{Space}
Else IfEqual key0,idg, Send dig{Space}
Else IfEqual key0,iflcn, Send influence{Space}
Else IfEqual key0,ikc, Send kick{Space}
Else IfEqual key0,ikn, Send ink{Space}
Else IfEqual key0,inm, Send mini{Space}
Else IfEqual key0,ioadnm, Send domain{Space}
Else IfEqual key0,iodb, Send biodegradable{Space}
Else IfEqual key0,iodv, Send void{Space}
Else IfEqual key0,iom, Send in my opinion{Space}
Else IfEqual key0,iosdl, Send solid{Space}
Else IfEqual key0,ips, Send piss{Space}
Else IfEqual key0,ipsgl, Send slipping{Space}
Else IfEqual key0,ipsl, Send slip{Space}
Else IfEqual key0,ipsl, Send slip{Space}
Else IfEqual key0,iajl, Send jail{Space}
Else IfEqual key0,iagn, Send gain{Space}
Else IfEqual key0,ib, Send no{Space}
Else IfEqual key0,iadlv, Send valid{Space}
Else IfEqual key0,ioan, Send nation{Space}
Else IfEqual key0,ishcm, Send schism{Space}
Else IfEqual key0,iasb, Send basis{Space}
Else IfEqual key0,iaslc, Send classic{Space}
Else IfEqual key0,ihcn, Send inch{Space}
Else IfEqual key0,ikl, Send kill{Space}
Else IfEqual key0,ilcn, Send clinic{Space}
Else IfEqual key0,iofn, Send info{Space}
Else IfEqual key0,iphn, Send iphone{Space}
Else IfEqual key0,iskn, Send skin{Space}
Else IfEqual key0,ism, Send miss{Space}
Else IfEqual key0,iadnm, Send admin{Space}
Else IfEqual key0,iasdnm, Send administrator{Space}
Else IfEqual key0,igm, Send image{Space}
Else IfEqual key0,ikln, Send link{Space}
Else IfEqual key0,ioadnm, Send administration{Space}
Else IfEqual key0,isn, Send isn't{Space}
Else IfEqual key0,ialcm, Send claim{Space}
Else IfEqual key0,ianm, Send main{Space}
Else IfEqual key0,iasd, Send said{Space}
Else IfEqual key0,id, Send did{Space}
Else IfEqual key0,idf, Send different{Space}
Else IfEqual key0,idfn, Send find{Space}
Else IfEqual key0,idhlc, Send child{Space}
Else IfEqual key0,idk, Send I don't know{Space}
Else IfEqual key0,idkn, Send kind{Space}
Else IfEqual key0,idn, Send individual{Space}
Else IfEqual key0,idnm, Send mind{Space}
Else IfEqual key0,if, Send if{Space}
Else IfEqual key0,ifl, Send fill{Space}
Else IfEqual key0,ifx, Send fix{Space}
Else IfEqual key0,ig, Send I guess{Space}
Else IfEqual key0,igb, Send big{Space}
Else IfEqual key0,igh, Send high{Space}
Else IfEqual key0,iglv, Send living{Space}
Else IfEqual key0,ign, Send {BackSpace}ing{Space}
Else IfEqual key0,ihl, Send hill{Space}
Else IfEqual key0,ihm, Send him{Space}
Else IfEqual key0,ik, Send I know{Space}
Else IfEqual key0,iklbn, Send blink{Space}
Else IfEqual key0,iklc, Send click{Space}
Else IfEqual key0,iklm, Send milk{Space}
Else IfEqual key0,il, Send I'll{Space}
Else IfEqual key0,ilv, Send live{Space}
Else IfEqual key0,im, Send I'm{Space}
Else IfEqual key0,in, Send in{Space}
Else IfEqual key0,in, Send in{Space}
Else IfEqual key0,io, Send {BackSpace}tion{Space}
Else IfEqual key0,ioac, Send action{Space}
Else IfEqual key0,ioalc, Send location{Space}
Else IfEqual key0,iojn, Send join{Space}
Else IfEqual key0,ion, Send {BackSpace}ion{Space}
Else IfEqual key0,ionm, Send omni
Else IfEqual key0,iop, Send option{Space}
Else IfEqual key0,iopn, Send opinion{Space}
Else IfEqual key0,iosn, Send {BackSpace}sion{Space}
Else IfEqual key0,iosn, Send ision{Space}
Else IfEqual key0,ipad, Send paid{Space}
Else IfEqual key0,ipafn, Send painful{Space}
Else IfEqual key0,ipan, Send pain{Space}
Else IfEqual key0,ipfl, Send flip{Space}
Else IfEqual key0,ipg, Send pig{Space}
Else IfEqual key0,ipkc, Send pick{Space}
Else IfEqual key0,ipm, Send important{Space}
Else IfEqual key0,ipsh, Send {BackSpace}ship{Space}
Else IfEqual key0,ipsk, Send skip{Space}
Else IfEqual key0,is, Send is{Space}
Else IfEqual key0,isd, Send dis
Else IfEqual key0,isdk, Send kids{Space}
Else IfEqual key0,isfhn, Send finish{Space}
Else IfEqual key0,isg, Send significant{Space}
Else IfEqual key0,isgn, Send sign{Space}
Else IfEqual key0,ish, Send his{Space}
Else IfEqual key0,ish, Send {BackSpace}ish{Space}
Else IfEqual key0,iskc, Send sick{Space}
Else IfEqual key0,ism, Send mis
Else IfEqual key0,iflm, Send film{Space}
Return
SENDL:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0% 
IfEqual key0,lb, Send little bit{Space}
Else IfEqual key0,lc, Send cool{Space}
Else IfEqual key0,lcbn, Send balance{Space}
Else IfEqual key0,lnm, Send manual{Space}
Else IfEqual key0,lvm, Send volume{Space}
Else IfEqual key0,lcn, Send clinical{Space}
Else IfEqual key0,lcbn, Send balance{Space}
Else IfEqual key0,lcm, Send molecule{Space}
Else IfEqual key0,ln, Send line{Space}
Else IfEqual key0,lv, Send leave{Space}
Else IfEqual key0,lvb, Send believe{Space}
Else IfEqual key0,lx, Send exactly{Space}
Else IfEqual key0,lxcn, Send excellence{Space}
Return
SENDX:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,xc, Send executive{Space}
Else IfEqual key0,xnm, Send examine{Space}
Else IfEqual key0,xnm, Send expect{Space}
Return
SENDV:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,vm, Send move{Space}
Else IfEqual key0,vn, Send even{Space}
Return
SENDB:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,bm, Send maybe{Space}
Else IfEqual key0,bf, Send boyfriend{Space}
Else IfEqual key0,bn, Send been{Space}
Else IfEqual key0,bsc, Send basic{Space}
Else IfEqual key0,bscl, Send basically{Space}
Return
SENDC:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,cb, Send because{Space}
Else IfEqual key0,cbm, Send become{Space}
Else IfEqual key0,cm, Send come{Space}
Else IfEqual key0,dfcn, Send confidence{Space}
Else IfEqual key0,cbnm, Send combine{Space}
Else IfEqual key0,cmg, Send coming{Space}
Else IfEqual key0,cn, Send can{Space}
Else IfEqual key0,cnm, Send common{Space}
Else IfEqual key0,cvn, Send conversation{Space}
Return
SENDK:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
IfEqual key0,kc, Send {Backspace}ck{Space}
Else IfEqual key0,kl, Send look{Space}
Else IfEqual key0,kln, Send knowledge{Space}
Else IfEqual key0,km, Send make{Space}
Else IfEqual key0,kn, Send know{Space}
Return
SENDJ:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0% 
    
    Return
SENDZ:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
  
IfEqual key0,zm, Send Zoom{Space}

Return
SENDM:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
 
Return
SENDN:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%

IfEqual key0,nm, Send mean{Space}
Return
SENDDOT:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%

IfEqual key0,r', Send {BackSpace}r{Space}
Else IfEqual key0,udn., Send understood{Space}
Else IfEqual key0,werth., Send threw{Space}
Else IfEqual key0,rsv., Send verse{Space}
Else IfEqual key0,onm., Send moon{Space}
Else IfEqual key0,rsv', Send verse{Space}
Else IfEqual key0,tasl., Send salt{Space}
Else IfEqual key0,ertah., Send earth{Space}
Else IfEqual key0,us., Send United States{Space}
Else IfEqual key0,uosdn., Send sounds{Space}
Else IfEqual key0,tasl., Send last{Space}
Else IfEqual key0,tioan., Send {BackSpace}{BackSpace}ation{Space}
Else IfEqual key0,epsd., Send speed{Space}
Else IfEqual key0,iadn., Send Indian{Space}
Else IfEqual key0,eas., Send sea{Space}
Else IfEqual key0,tisl., Send list{Space}
Else IfEqual key0,eragn., Send arrange{Space}
Else IfEqual key0,erp', Send pepper{Space}
Else IfEqual key0,epa., Send pea{Space}
Else IfEqual key0,eadh., Send ahead{Space}
Else IfEqual key0,ajn., Send January{Space}
Else IfEqual key0,edc., Send December{Space}
Else IfEqual key0,efb., Send February{Space}
Else IfEqual key0,erign., Send reign{Space}
Else IfEqual key0,erin., Send rein{Space}
Else IfEqual key0,eros., Send sore{Space}
Else IfEqual key0,ersv., Send severe{Space}
Else IfEqual key0,ertihn., Send inherit{Space}
Else IfEqual key0,eryal., Send relay{Space}
Else IfEqual key0,etask., Send steak{Space}
Else IfEqual key0,ethm., Send theme{Space}
Else IfEqual key0,etivn., Send invent{Space}
Else IfEqual key0,etps., Send September{Space}
Else IfEqual key0,etups., Send setup{Space}
Else IfEqual key0,eus., Send sue{Space}
Else IfEqual key0,iskn., Send sink{Space}
Else IfEqual key0,ovn., Send November{Space}
Else IfEqual key0,rahcm., Send March{Space}
Else IfEqual key0,udn., Send understood{Space}
Else IfEqual key0,wra., Send raw{Space}
Else IfEqual key0,tian', Send ain’t{Space}
Else IfEqual key0,yam., Send May{Space}
Else IfEqual key0,adh., Send dah{Space}
Else IfEqual key0,uag., Send August{Space}
Else IfEqual key0,tush., Send thus{Space}
Else IfEqual key0,toc., Send October{Space}
Else IfEqual key0,tsfcn., Send fascinate{Space}
Else IfEqual key0,ertial., Send literal{Space}	
Else IfEqual key0,ian., Send {BackSpace}{BackSpace}ian{Space}
Else IfEqual key0,iofn., Send information{Space}
Else IfEqual key0,rpdc., Send procedure{Space}
Else IfEqual key0,ion., Send {BackSpace}{BackSpace}ion{Space}
Else IfEqual key0,asd., Send sad{Space}
Else IfEqual key0,rpgm., Send programmer{Space}
Else IfEqual key0,etas', Send east{Space}
Else IfEqual key0,ioa., Send {BackSpace}{BackSpace}ation{Space}
Else IfEqual key0,etn., Send {BackSpace}ent{Space}
Else IfEqual key0,epasc., Send escape{Space}
Else IfEqual key0,alb., Send ball{Space}
Else IfEqual key0,wton', Send won't{Space}
Else IfEqual key0,ok', Send okay{Space}
Else IfEqual key0,epsl., Send spell{Space}
Else IfEqual key0,eops., Send oppose{Space}
Else IfEqual key0,erias., Send easier{Space}
Else IfEqual key0,tkn., Send taken{Space}
Else IfEqual key0,erashc., Send research{Space}
Else IfEqual key0,flcn., Send influence{Space}
Else IfEqual key0,lcn., Send council{Space}
Else IfEqual key0,ro., Send {backspace}or{Space}
Else IfEqual key0,tnm., Send mountain{Space}
Else IfEqual key0,ef., Send fee{Space}
Else IfEqual key0,rplcn., Send principal{Space}
Else IfEqual key0,etam., Send meat{Space}
Else IfEqual key0,ogl., Send logging{Space}
Else IfEqual key0,ozm., Send zoom{Space}
Else IfEqual key0,qrts., Send squirt{Space}
Else IfEqual key0,ram., Send ram{Space}
Else IfEqual key0,rdg., Send grade{Space}
Else IfEqual key0,flcn., Send influence{Space}
Else IfEqual key0,rgnm., Send manager{Space}
Else IfEqual key0,rslv., Send resolve{Space}
Else IfEqual key0,rsvn., Send nervous{Space}
Else IfEqual key0,rtfg., Send forgot{Space}
Else IfEqual key0,rtsg., Send string{Space}
Else IfEqual key0,wal., Send wall{Space}
Else IfEqual key0,ruos., Send sour{Space}
Else IfEqual key0,slcn., Send silence{Space}
Else IfEqual key0,slv., Send solve{Space}
Else IfEqual key0,tac., Send cat{Space}
Else IfEqual key0,tcn., Send contain{Space}
Else IfEqual key0,tiac., Send {backspace}atic{Space}
Else IfEqual key0,tian., Send taint{Space}
Else IfEqual key0,wo., Send wow{Space}
Else IfEqual key0,yas., Send says{Space}
Else IfEqual key0,ypal., Send apply{Space}
Else IfEqual key0,l', Send {backspace}‘ll{Space}
Else IfEqual key0,ghcn., Send changing{Space}
Else IfEqual key0,in., Send in
Else IfEqual key0,idk., Send kid{Space}
Else IfEqual key0,gln., Send language lng.{Space}
Else IfEqual key0,eshl., Send she'll{Space}
Else IfEqual key0,e'v, Send {backspace}‘ve{Space}
Else IfEqual key0,etsg., Send settings{Space}
Else IfEqual key0,esc., Send escape{Space}
Else IfEqual key0,ergm., Send emerge{Space}
Else IfEqual key0,rtuogh., Send thorough{Space}
Else IfEqual key0,ealb., Send {backspace}able{Space}
Else IfEqual key0,ealb., Send {backspace}able{Space}
 Else IfEqual key0,wto', Send two{Space}
Else IfEqual key0,epal., Send appeal{Space}
Else IfEqual key0,ets', Send {BackSpace}est{Space}
Else IfEqual key0,er', Send {backspace}‘re{Space}
Else IfEqual key0,eiasl., Send liaise{Space}
Else IfEqual key0,erakb., Send brake{Space}
 Else IfEqual key0,tvm., Send motivate{Space}
Else IfEqual key0,era., Send rear{Space}
Else IfEqual key0,rtdc., Send direct{Space}
Else IfEqual key0,era', Send era{Space}
Else IfEqual key0,tuogh., Send ought{Space}
Else IfEqual key0,d., Send{backspace}d{Space}
  Else IfEqual key0,hm., Send Mm-mmm.{Space}
  Else IfEqual key0,ign., Send {backspace}{backspace}ing{Space}
 Else IfEqual key0,esl., Send less{Space}
 Else IfEqual key0,etan., Send tenant{Space}
Else IfEqual key0,rtfh., Send further{Space}
 Else IfEqual key0,tivn., Send invite{Space}
 Else IfEqual key0,esdn., Send dense{Space}
Else IfEqual key0,erias, Send easier{Space}
Else IfEqual key0,rtln., Send natural{Space}
Else IfEqual key0,.ertpsn, Send represent{Space}
Else IfEqual key0,erf., Send refer{Space}
Else IfEqual key0,eru., Send {backspace}ure{Space}
Else IfEqual key0,etsh., Send sheet{Space}
Else IfEqual key0,on., Send non{Space}
Else IfEqual key0,rtipn., Send interrupt{Space}
Else IfEqual key0,tas., Send asset{Space}
Else IfEqual key0,scnm., Send musician{Space}
 Else IfEqual key0,tgvn., Send vintage{Space}
 Else IfEqual key0,rtsg., Send register{Space}
 Else IfEqual key0,eivn., Send vine{Space}
 Else IfEqual key0,etas., Send taste{Space}
Else IfEqual key0,etsn., Send nest{Space}
  Else IfEqual key0,tan., Send {BackSpace}ant{Space}
 Else IfEqual key0,eon., Send none{Space}	
 Else IfEqual key0,apl., Send appeal{Space}
 Else IfEqual key0,eis., Send {BackSpace}{BackSpace}ies{Space}	
Else IfEqual key0,asb., Send bass{Space}
Else IfEqual key0,dlb., Send double{Space}
Else IfEqual key0,eag., Send {BackSpace}age{Space}
Else IfEqual key0,ecn., Send {BackSpace}ence{Space}
Else IfEqual key0,erta., Send treat{Space}
Else IfEqual key0,ertcn., Send center{Space}
Else IfEqual key0,eta., Send eat{Space}
Else IfEqual key0,ipsh., Send ship{Space}
Else IfEqual key0,rpsf., Send professor{Space}
Else IfEqual key0,rtg., Send guitar{Space}
Else IfEqual key0,rtlb., Send terrible{Space}
Else IfEqual key0,rtpa., Send appropriate{Space}
Else IfEqual key0,rtpc., Send participate{Space}
Else IfEqual key0,rtpn., Send partner{Space}
Else IfEqual key0,rtuh., Send truth{Space}
Else IfEqual key0,tgn., Send negotiation{Space}
Else IfEqual key0,tidn., Send identity{Space}
Else IfEqual key0,tih., Send hit{Space}
Else IfEqual key0,tplc., Send political{Space}
Else IfEqual key0,tsn., Send situation{Space}
Else IfEqual key0,ty., Send YouTube{Space}
Else IfEqual key0,wn., Send No worries.{Space}
 Else IfEqual key0,adb., Send bad{Space}
 Else IfEqual key0,asb., Send bass{Space}
Else IfEqual key0,efl., Send fell{Space}
Else IfEqual key0,eifv., Send five{Space}
Else IfEqual key0,ein., Send nine{Space}
Else IfEqual key0,eiv., Send {BackSpace}ive{Space}
Else IfEqual key0,em., Send em{Space}
Else IfEqual key0,eran., Send earn{Space}
Else IfEqual key0,erth., Send three{Space}
Else IfEqual key0,esh., Send he's{Space}
Else IfEqual key0,esvn., Send seven{Space}
Else IfEqual key0,etigh., Send eight{Space}
Else IfEqual key0,eton., Send tone{Space}
Else IfEqual key0,isx., Send six{Space}
Else IfEqual key0,rpa., Send appear{Space}
Else IfEqual key0,ruof., Send four{Space}
Else IfEqual key0,til., Send till{Space}
Else IfEqual key0,tosh., Send shoot{Space}
Else IfEqual key0,wto., Send two{Space}
 Else IfEqual key0,rtos., Send sort of{Space} 
 Else IfEqual key0,og., Send going{Space}
 Else IfEqual key0,tish., Send shit{Space} 
 Else IfEqual key0,tm., Send might{Space}
 Else IfEqual key0,idf., Send difficult{Space} 
 Else IfEqual key0,tdn., Send didn't{Space}
 Else IfEqual key0,tidn., Send didn't{Space} 
 Else IfEqual key0,er., Send re
  Else IfEqual key0,erp., Send pre
 Else IfEqual key0,em., Send them{Space} 
 Else IfEqual key0,ig., Send Instagram{Space} 
 Else IfEqual key0,fb., Send Facebook{Space} 
 Else IfEqual key0,gl., Send Google{Space} 
 Else IfEqual key0,id., Send I'd{Space} 
 Else IfEqual key0,ok., Send okay{Space} 
 Else IfEqual key0,sm., Send so much{Space} 
 Else IfEqual key0,etc., Send technology{Space}
 Else IfEqual key0,th., Send th{Space} 
 Else IfEqual key0,tsh., Send that's{Space}
 Else IfEqual key0,ev., Send ve{Space} 
 Else IfEqual key0,c., Send see{Space}
 Else IfEqual key0,u., Send you{Space}
 Else IfEqual key0,n., Send and{Space}
 Else IfEqual key0,t., Send the{Space}
 Else IfEqual key0,y., Send yeah{Space}
 Else IfEqual key0,b., Send but{Space}
 Else IfEqual key0,tion., Send ition{Space}
 Else IfEqual key0,w., Send with{Space}
 Else IfEqual key0,p., Send pretty{Space}
 Else IfEqual key0,k., Send know{Space}
 Else IfEqual key0,q., Send quick{Space}
 Else IfEqual key0,g., Send great{Space}
 Else IfEqual key0,l., Send like{Space}
 Else IfEqual key0,r., Send really{Space}
 Else IfEqual key0,sh., Send sh{Space} 
 Else IfEqual key0,j., Send just{Space}
 Else IfEqual key0,m., Send much{Space}
 Else IfEqual key0,e., Send even{Space}
 Else IfEqual key0,d., Send ed{Space}
 Else IfEqual key0,f., Send for{Space}
 Else IfEqual key0,v., Send very{Space}
 Else IfEqual key0,io., Send {BackSpace}{BackSpace}tion{Space} 
 Else IfEqual key0,th., Send th{Space} 
 Else IfEqual key0,hc., Send ch{Space} 
 Else IfEqual key0,to., Send too{Space} 
 Else IfEqual key0,tuagh., Send aught{Space}
 Else IfEqual key0,ocn., Send con{Space}
 Else IfEqual key0,era., Send are{Space}
 Else IfEqual key0,gc., Send seeing{Space} 
 Else IfEqual key0,wya., Send away{Space}
 Else IfEqual key0,was., Send saw{Space}
 Else IfEqual key0,3., Send three{Space}
 Else IfEqual key0,1., Send one{Space}
 Else IfEqual key0,2., Send two{Space}
 Else IfEqual key0,4., Send four{Space}
 Else IfEqual key0,5., Send five{Space}
 Else IfEqual key0,ex., Send exact{Space}
 Else IfEqual key0,6., Send six{Space}
 Else IfEqual key0,7., Send seven{Space}
 Else IfEqual key0,8., Send eight{Space}
 Else IfEqual key0,9., Send nine{Space}
 Else IfEqual key0,0., Send 10{Space}
 Else IfEqual key0,woh., Send who{Space} 
 Else IfEqual key0,etl., Send tell{Space}
 Else IfEqual key0,erts., Send stress{Space} 
 Else IfEqual key0,st., Send st{Space} 
 Else IfEqual key0,tops., Send post{Space} 
 Else IfEqual key0,tis., Send sit{Space}
 Else IfEqual key0,ashl., Send shall{Space} 
 Else IfEqual key0,esd., Send seed{Space}
 Else IfEqual key0,was., Send saw{Space}
 Else IfEqual key0,won., Send own{Space}
 Else IfEqual key0,on., Send on{Space} 
 Else IfEqual key0,etfl., Send left{Space} 
 Else IfEqual key0,wtah., Send thaw{Space} 
 Else IfEqual key0,of., Send off{Space} 
 Else IfEqual key0,eanm., Send name{Space} 
 Else IfEqual key0,eilv., Send evil{Space} 
 Else IfEqual key0,epk., Send peek{Space}
 Else IfEqual key0,rtuh., Send hurt{Space} 
 Else IfEqual key0,toh., Send hot{Space} 
 Else IfEqual key0,ish., Send ish{Space}
 Else IfEqual key0,erh., Send here{Space}
 Else IfEqual key0,og., Send original{Space} 
 Else IfEqual key0,ed., Send de
 Else IfEqual key0,tops., Send post
 Else IfEqual key0,ism., Send mis{Space}
 Else IfEqual key0,al., Send {BackSpace}al{Space}
 Else IfEqual key0,s., Send {BackSpace}s{Space}
 Else IfEqual key0,esn., Send {BackSpace}ness{Space}
 Else IfEqual key0,i., Send I{Space}
 Else IfEqual key0,a., Send a{Space}
 Else IfEqual key0,ufl., Send {BackSpace}ful{Space}
 Else IfEqual key0,er., Send re
 Else IfEqual key0,toh., Send oth{Space} 
 Else IfEqual key0,ton., Send ton{Space} 
Else IfEqual key0,yal., Send {BackSpace}ally{Space}
Else IfEqual key0,able., Send able
Else IfEqual key0,ua., Send ua   
Else IfEqual key0,edn., Send end{Space}
Else IfEqual key0,er., Send {BackSpace}er
Else IfEqual key0,etm., Send meet{Space}
Else IfEqual key0,etg., Send getting{Space}
Else IfEqual key0,al., Send {BackSpace}al
Else IfEqual key0,tops., Send post{Space}
Else IfEqual key0,eag., Send age
Else IfEqual key0,ertih., Send either{Space}
Else IfEqual key0,gv., Send giving{Space}
Else IfEqual key0,erashc., Send research{Space}
Else IfEqual key0,edf., Send feed{Space}
Else IfEqual key0,eoshc., Send choose{Space}
Else IfEqual key0,eigbn., Send beginning{Space}
Else IfEqual key0,opsh., Send shops{Space}
Else IfEqual key0,esm., Send seems{Space}
Else IfEqual key0,ertal., Send relate{Space}
Else IfEqual key0,etis., Send {BackSpace}ities{Space}
Else IfEqual key0,tol., Send tool{Space}
Else IfEqual key0,tasf., Send staff{Space}
Else IfEqual key0,sn., Send season{Space}
 Else IfEqual key0,isgn., Send sing{Space}
  Else IfEqual key0,erpa., Send paper{Space}
 Else IfEqual key0,es., Send {BackSpace}es{Space}
Else IfEqual key0,epsdn., Send depends{Space}
Else IfEqual key0,rtlc., Send critical{Space}
Else IfEqual key0,ertpsn., Send represent{Space}
Else IfEqual key0,oagln., Send analog{Space}
Else IfEqual key0,ral., Send lar
Else IfEqual key0,tahc., Send attach{Space}
Else IfEqual key0,ertpan., Send parent{Space}
Else IfEqual key0,igh., Send igh{Space}
Else IfEqual key0,ets., Send test{Space}	
Else IfEqual key0,etsn., Send sent{Space}
Else IfEqual key0,esfl., Send self{Space}
Else IfEqual key0,epal., Send Apple{Space}
Else IfEqual key0,eiscn., Send science{Space}
Else IfEqual key0,rtlv., Send virtual{Space}
Else IfEqual key0,ts., Send street{Space}
Else IfEqual key0,odg., Send dog{Space}
Else IfEqual key0,ertin., Send internet{Space}
Else IfEqual key0,rtpcn., Send corporation{Space}
Else IfEqual key0,werti., Send Twitter{Space}
Else IfEqual key0,erac., Send race{Space}
Else IfEqual key0,erus., Send user{Space}
Else IfEqual key0,rac., Send car{Space}
Else IfEqual key0,roadb., Send broad{Space}
Else IfEqual key0,wera., Send aware{Space}
Else IfEqual key0,wrtoh., Send worth{Space}
Else IfEqual key0,ertafh., Send farther{Space}
Else IfEqual key0,ypal., Send apply{Space}
Else IfEqual key0,rtpc., Send capture{Space}
Else IfEqual key0,erups., Send pressure{Space}
Else IfEqual key0,esl., Send sell{Space}
Else IfEqual key0,eifl., Send file{Space}
Else IfEqual key0,weak., Send wake{Space}
Else IfEqual key0,deadl., Send lead{Space}
 Else IfEqual key0,wer', Send we're{Space}
 Else IfEqual key0,esh', Send he's{Space} 
  Else IfEqual key0,id', Send I'd{Space}
 Else IfEqual key0,yal', Send y'all{Space}
 Else IfEqual key0,t', Send {BackSpace}'t{Space} 
 Else IfEqual key0,wosh', Send who's{Space} 
 Else IfEqual key0,tid'n, Send didn't{Space} 
 Else IfEqual key0,t'n, Send {BackSpace}n't{Space}
 Else IfEqual key0,d', Send {BackSpace}'d{Space}
 Else IfEqual key0,ts', Send that's{Space} 
 Else IfEqual key0,s', Send {BackSpace}'s{Space}
 Else IfEqual key0,'l, Send {BackSpace}'ll{Space}
Else IfEqual key0,ad., Send add{Space}
Else IfEqual key0,easc., Send access{Space}
Else IfEqual key0,edc., Send {BackSpace}cede{Space}
Else IfEqual key0,eis., Send {BackSpace}ies{Space}
Else IfEqual key0,eolv., Send evolve{Space}
Else IfEqual key0,epash., Send phase{Space}
Else IfEqual key0,ertal., Send alter{Space}
Else IfEqual key0,fl., Send full{Space}
Else IfEqual key0,til., Send it'll{Space}
Else IfEqual key0,til', Send it'll{Space}
Else IfEqual key0,tpln., Send population{Space}
Else IfEqual key0,vm., Send movie{Space}
Return

SENDSLASHup:
SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%}, 	 
Else IfEqual key0, ERA?, Send Ear{Space} 
Else IfEqual key0, TOPS?, Send Spot{Space} 
Else IfEqual key0, ERTAL?, Send Latter{Space} 
Else IfEqual key0, ERTS?, Send Steer{Space} 
Else IfEqual key0, TOSH?, Send Host{Space} 
Else IfEqual key0, ERP?, Send Peer{Space} 
Else IfEqual key0, ETAS?, Send Tease{Space} 
Else IfEqual key0, WAL?, Send Law{Space} 
Else IfEqual key0, ERA?, Send Ear{Space} 
Else IfEqual key0, ERSV?, Send Sever{Space} 	
Else IfEqual key0, SLCN?, Send Counsel{Space} 
Else IfEqual key0, ERUPS?, Send Pursue{Space} 
Else IfEqual key0, WON?, Send Won{Space} 

Return
SENDQup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, QERF, Send Frequency{Space} 
Else IfEqual key0, QERFN, Send Frequent{Space} 
Else IfEqual key0, QERUI, Send Queue{Space} 
Else IfEqual key0, QEU, Send Queue{Space} 
Else IfEqual key0, QRAC, Send Acquire{Space} 
Else IfEqual key0, QRTS, Send Request{Space} 
Else IfEqual key0, QETUI, Send Quiet{Space} 
Else IfEqual key0, QEUIN, Send Unique{Space} 
Else IfEqual key0, QEL, Send Equal{Space} 
Else IfEqual key0, QERU, Send Queer{Space} 
Else IfEqual key0, QL, Send Quickly{Space} 
Else IfEqual key0, QETUO, Send Quote{Space} 
Else IfEqual key0, QFL, Send Qualify{Space} 
Else IfEqual key0, QRTUIS, Send Squirt{Space} 
Else IfEqual key0, QYFL, Send Qualify{Space} 
Else IfEqual key0, QEUIP, Send Equip{Space} 
Else IfEqual key0, QEUOSCN, Send Consequence{Space} 
Else IfEqual key0, QEUS, Send Esque
Else IfEqual key0, QR, Send Require{Space} 
Else IfEqual key0, QRSL, Send Squirrel{Space} 
Else IfEqual key0, QERYU, Send Query{Space} 
Else IfEqual key0, QES, Send Sequence{Space} 
Else IfEqual key0, QETYUI, Send Equity{Space} 
Else IfEqual key0, QRF, Send Frequent{Space} 
Else IfEqual key0, QRTFN, Send Frequent{Space} 
Else IfEqual key0, QSCN, Send Sequence{Space} 
Else IfEqual key0, QTUANM, Send Quantum{Space} 
Else IfEqual key0, QT, Send Question{Space} 
Else IfEqual key0, QTI, Send Quite{Space} 
Else IfEqual key0, QTL, Send Quality{Space} 
Else IfEqual key0, QTS, Send Questions{Space} 
Else IfEqual key0, QTUI, Send Quit{Space} 
Else IfEqual key0, QUN, Send Unique{Space} 
Else IfEqual key0, QRT, Send Quarter{Space} 
Return
SENDWup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, WA, Send As Well{Space} 
Else IfEqual key0, WRHV, Send However{Space} 
Else IfEqual key0, WTN, Send Won't{Space} 
Else IfEqual key0, WERHVN, Send Whenever{Space} 
Else IfEqual key0, WEOASM, Send Awesome{Space} 
Else IfEqual key0, WRPA, Send Wrap{Space} 
Else IfEqual key0, WLB, Send Below{Space} 
Else IfEqual key0, WEOLB, Send Below{Space} 
Else IfEqual key0, WAN, Send Want To{Space} 
Else IfEqual key0, WEHC, Send Chew{Space} 
Else IfEqual key0, WEIF, Send Wife{Space} 
Else IfEqual key0, WEISLV, Send Swivel{Space} 
Else IfEqual key0, WERASH, Send Whereas{Space} 
Else IfEqual key0, WERHVN, Send Whenever{Space} 
Else IfEqual key0, WERIN, Send Winner{Space} 
Else IfEqual key0, WEROPM, Send Empower{Space} 
Else IfEqual key0, WEROSH, Send Shower{Space} 
Else IfEqual key0, WERTIH, Send Wither{Space} 
Else IfEqual key0, WESK, Send Skew{Space} 
Else IfEqual key0, WETISHL, Send Whistle{Space} 
Else IfEqual key0, WHKM, Send Homework{Space} 
Else IfEqual key0, WISM, Send Swim{Space} 
Else IfEqual key0, WOASL, Send Swallow{Space} 
Else IfEqual key0, WOLB, Send Blow{Space} 
Else IfEqual key0, WRA, Send War{Space} 
Else IfEqual key0, WRB, Send Borrow{Space} 
Else IfEqual key0, WRSM, Send Worrisome{Space} 
Else IfEqual key0, WRPF, Send Powerful{Space} 
Else IfEqual key0, WDV, Send Would've{Space} 
Else IfEqual key0, WEROHN, Send Nowhere{Space} 
Else IfEqual key0, WEROHV, Send However{Space} 
Else IfEqual key0, WRTH, Send Worth{Space} 
Else IfEqual key0, WEROS, Send Worse{Space} 
Else IfEqual key0, WED, Send We'd{Space} 
Else IfEqual key0, WEIN, Send Wine{Space} 
Else IfEqual key0, WETAH, Send Weather{Space} 
Else IfEqual key0, WETAHL, Send Wealth{Space} 
Else IfEqual key0, WOFL, Send Flow{Space} 
Else IfEqual key0, WEROP, Send Power{Space} 
Else IfEqual key0, WERTN, Send Weren't{Space} 
Else IfEqual key0, WRTN, Send Written{Space} 
Else IfEqual key0, WADN, Send Wand{Space} 
Else IfEqual key0, WDL, Send Wield{Space} 
Else IfEqual key0, WEAV, Send Wave{Space} 
Else IfEqual key0, WELB, Send Blew{Space} 
Else IfEqual key0, WELB, Send Blew{Space} 
Else IfEqual key0, WEONM, Send Women{Space} 
Else IfEqual key0, WERTO, Send Wrote{Space} 
Else IfEqual key0, WERTO, Send Wrote{Space} 
Else IfEqual key0, WLCM, Send Welcome{Space} 
Else IfEqual key0, WNM, Send Women{Space} 
Else IfEqual key0, WNM, Send Woman{Space} 
Else IfEqual key0, WOSL, Send Slow{Space} 
Else IfEqual key0, WRDH, Send Hardware{Space} 
Else IfEqual key0, WRTOS, Send Worst{Space} 
Else IfEqual key0, WRYO, Send Worry{Space} 
Else IfEqual key0, WAGN, Send Gnaw{Space} 
Else IfEqual key0, WALN, Send Lawn{Space} 
Else IfEqual key0, WAN, Send Awn{Space} 
Else IfEqual key0, WASKL, Send Walks{Space} 
Else IfEqual key0, WDLN, Send Download{Space} 
Else IfEqual key0, WEAHL, Send Whale{Space} 
Else IfEqual key0, WEHL, Send Wheel{Space} 
Else IfEqual key0, WEIF, Send Wife{Space} 
Else IfEqual key0, WEIGH, Send Weigh{Space} 
Else IfEqual key0, WEIS, Send Wise{Space} 
Else IfEqual key0, WEOSH, Send Whose{Space} 
Else IfEqual key0, WEOSH, Send Swore{Space} 
Else IfEqual key0, WERTAH, Send Weather{Space} 
Else IfEqual key0, WETIGH, Send Weight{Space} 
Else IfEqual key0, WETS, Send West{Space} 
Else IfEqual key0, WIDL, Send Wild{Space} 
Else IfEqual key0, WIN, Send Win{Space} 
Else IfEqual key0, WOC, Send Cow{Space} 
Else IfEqual key0, WOM, Send Mow{Space} 
Else IfEqual key0, WRGLN, Send Wrangle{Space} 
Else IfEqual key0, WRHN, Send Nowhere{Space} 
Else IfEqual key0, WRLNM, Send Lawnmower{Space} 
Else IfEqual key0, WRS, Send Worse{Space} 
Else IfEqual key0, WRTOS, Send Worst{Space} 
Else IfEqual key0, WSDM, Send Wisdom{Space} 
Else IfEqual key0, WAKL, Send Walk{Space} 
Else IfEqual key0, WAL, Send Always{Space} 
Else IfEqual key0, WAS, Send Was{Space} 
Else IfEqual key0, WAS, Send Was{Space} 
Else IfEqual key0, WASH, Send Wash{Space} 
Else IfEqual key0, WDF, Send Forward{Space} 
Else IfEqual key0, WDN, Send Wouldn't{Space} 
Else IfEqual key0, WE, Send We{Space} 
Else IfEqual key0, WEAK, Send Weak{Space} 
Else IfEqual key0, WEASM, Send Awesome{Space} 
Else IfEqual key0, WEF, Send Few{Space} 
Else IfEqual key0, WEH, Send When{Space} 
Else IfEqual key0, WEHN, Send When{Space} 
Else IfEqual key0, WEID, Send Wide{Space} 
Else IfEqual key0, WEID, Send Wide{Space} 
Else IfEqual key0, WEIHL, Send While{Space} 
Else IfEqual key0, WEIS, Send Wise{Space} 
Else IfEqual key0, WEISDH, Send Wished{Space} 
Else IfEqual key0, WEIV, Send View{Space} 
Else IfEqual key0, WEK, Send Week{Space} 
Else IfEqual key0, WEKN, Send Knew{Space} 
Else IfEqual key0, WEL, Send Well{Space} 
Else IfEqual key0, WEN, Send New{Space} 
Else IfEqual key0, WEOHL, Send Whole{Space} 
Else IfEqual key0, WEOHL, Send Whole{Space} 
Else IfEqual key0, WEOHL, Send Whole{Space} 
Else IfEqual key0, WER, Send Were{Space} 
Else IfEqual key0, WERA, Send Wear{Space} 
Else IfEqual key0, WERASN, Send Answer{Space} 
Else IfEqual key0, WERC, Send Crew{Space} 
Else IfEqual key0, WERH, Send Where{Space} 
Else IfEqual key0, WERID, Send Weird{Space} 
Else IfEqual key0, WERIV, Send Review{Space} 
Else IfEqual key0, WEROSB, Send Browse{Space} 
Else IfEqual key0, WERTA, Send Water{Space} 
Else IfEqual key0, WERTH, Send Whether{Space} 
Else IfEqual key0, WERTI, Send Twitter{Space} 
Else IfEqual key0, WETADN, Send Wanted{Space} 
Else IfEqual key0, WETBN, Send Between{Space} 
Else IfEqual key0, WETIH, Send White{Space} 
Else IfEqual key0, WETN, Send Went{Space} 
Else IfEqual key0, WEV, Send Everywhere{Space} 
Else IfEqual key0, WFL, Send Follow{Space} 
Else IfEqual key0, WGK, Send Working{Space} 
Else IfEqual key0, WGKL, Send Walking{Space} 
Else IfEqual key0, WH, Send Who{Space} 
Else IfEqual key0, WHEN, Send When{Space} 
Else IfEqual key0, WHL, Send Whole{Space} 
Else IfEqual key0, WHN, Send When{Space} 
Else IfEqual key0, WIDN, Send Wind{Space} 
Else IfEqual key0, WIHC, Send Which{Space} 
Else IfEqual key0, WIL, Send Will{Space} 
Else IfEqual key0, WIODN, Send Window{Space} 
Else IfEqual key0, WISH, Send Wish{Space} 
Else IfEqual key0, WK, Send Work{Space} 
Else IfEqual key0, WKL, Send Walk{Space} 
Else IfEqual key0, WL, Send We'll{Space} 
Else IfEqual key0, WN, Send Network{Space} 
Else IfEqual key0, WO, Send Would{Space} 
Else IfEqual key0, WOAL, Send Allow{Space} 
Else IfEqual key0, WOD, Send Wood{Space} 
Else IfEqual key0, WODN, Send Down{Space} 
Else IfEqual key0, WOH, Send How{Space} 
Else IfEqual key0, WOKN, Send Know{Space} 
Else IfEqual key0, WOL, Send Low{Space} 
Else IfEqual key0, WON, Send Now{Space} 
Else IfEqual key0, WOSH, Send Show{Space} 
Else IfEqual key0, WOSN, Send Snow{Space} 
Else IfEqual key0, WPN, Send Newspaper{Space} 
Else IfEqual key0, WR, Send We're{Space} 
Else IfEqual key0, WR, Send We're{Space} 
Else IfEqual key0, WRAD, Send Draw{Space} 
Else IfEqual key0, WRAM, Send Warm{Space} 
Else IfEqual key0, WRDF, Send Wonderful{Space} 
Else IfEqual key0, WRDFN, Send Wonderful{Space} 
Else IfEqual key0, WRDN, Send Wonder{Space} 
Else IfEqual key0, WRK, Send Work{Space} 
Else IfEqual key0, WROD, Send Word{Space} 
Else IfEqual key0, WRODL, Send World{Space} 
Else IfEqual key0, WROG, Send Grow{Space} 
Else IfEqual key0, WROGN, Send Wrong{Space} 
Else IfEqual key0, WROK, Send Work{Space} 
Else IfEqual key0, WRT, Send Write{Space} 
Else IfEqual key0, WRTG, Send Writing{Space} 
Else IfEqual key0, WRTM, Send Tomorrow{Space} 
Else IfEqual key0, WRTOH, Send Throw{Space} 
Else IfEqual key0, WRTV, Send Whatever{Space} 
Else IfEqual key0, WRV, Send Review{Space} 
Else IfEqual key0, WS, Send Website{Space} 
Else IfEqual key0, WSF, Send Software{Space} 
Else IfEqual key0, WSM, Send Somewhere{Space} 
Else IfEqual key0, WT, Send What{Space} 
Else IfEqual key0, WTADN, Send Wanted{Space} 
Else IfEqual key0, WTADN, Send Wanted{Space} 
Else IfEqual key0, WTAH, Send What{Space} 
Else IfEqual key0, WTAHC, Send Watch{Space} 
Else IfEqual key0, WTAN, Send Want{Space} 
Else IfEqual key0, WTASN, Send Wasn't{Space} 
Else IfEqual key0, WSN, Send Wasn't{Space} 
Else IfEqual key0, WTB, Send By The Way{Space} 
Else IfEqual key0, WTD, Send Toward{Space} 
Else IfEqual key0, WTH, Send Whether{Space} 
Else IfEqual key0, WTHC, Send Watch{Space} 
Else IfEqual key0, WTI, Send Within{Space} 
Else IfEqual key0, WTIA, Send Wait{Space} 
Else IfEqual key0, WTISHC, Send Switch{Space} 
Else IfEqual key0, WTO, Send Without{Space} 
Else IfEqual key0, WTON, Send Town{Space} 
Else IfEqual key0, WTUO, Send Without{Space} 
Else IfEqual key0, WTV, Send Whatever{Space} 
Else IfEqual key0, WTVN, Send Interview{Space} 
Else IfEqual key0, WV, Send We've{Space} 
Else IfEqual key0, WV, Send We've{Space} 
Else IfEqual key0, WYA, Send Way{Space} 
Else IfEqual key0, WYAHN, Send Anywhere{Space} 
Else IfEqual key0, WYAN, Send Anyway{Space} 
Else IfEqual key0, WYH, Send Why{Space} 
Else IfEqual key0, WYL, Send Yellow{Space} 
Else IfEqual key0, WERG, Send Grew{Space} 
Else IfEqual key0, WETIC, Send Twice{Space} 
Else IfEqual key0, WTASH, Send What's{Space} 
Else IfEqual key0, WTS, Send What's{Space} 
Return
SENDRup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, RA, Send Around{Space} 
Else IfEqual key0, RUIOASV, Send Saviour{Space} 
Else IfEqual key0, RTYPH, Send Therapy{Space} 
Else IfEqual key0, RTDLNM, Send Detrimental{Space} 
Else IfEqual key0, RTDLN, Send Traditional{Space} 
Else IfEqual key0, RYC, Send Cry{Space} 
Else IfEqual key0, RTPSDN, Send President{Space} 
Else IfEqual key0, RTUIAG, Send Guitar	{Space} 
Else IfEqual key0, RTIP, Send Trip{Space} 
Else IfEqual key0, RUOSH, Send Hours{Space} 
Else IfEqual key0, RIDKN, Send Drink{Space} 
Else IfEqual key0, RIAFC, Send Africa{Space} 
Else IfEqual key0, RTIAC, Send Arctic{Space} 
Else IfEqual key0, RTIACN, Send Antarctica{Space} 
Else IfEqual key0, WRB, Send Borrow{Space} 
Else IfEqual key0, RHLB, Send Horrible{Space} 
Else IfEqual key0, RP, Send Peer{Space} 
Else IfEqual key0, RAHCM, Send March{Space} 
Else IfEqual key0, RDV, Send Drive{Space} 
Else IfEqual key0, RDBN, Send Burden{Space} 
Else IfEqual key0, RDGN, Send Garden{Space} 
Else IfEqual key0, RFCN, Send Conference{Space} 
Else IfEqual key0, RFNM, Send Inform{Space} 
Else IfEqual key0, RIAGC, Send Cigar{Space} 
Else IfEqual key0, RID, Send Rid{Space} 
Else IfEqual key0, RIDB, Send Bird{Space} 
Else IfEqual key0, RIOFNM, Send Inform{Space} 
Else IfEqual key0, RIOM, Send Mirror{Space} 
Else IfEqual key0, RIONM, Send Minor{Space} 
Else IfEqual key0, RIPAL, Send April{Space} 
Else IfEqual key0, RISC, Send Crisis{Space} 
Else IfEqual key0, RISCN, Send Insurance{Space} 
Else IfEqual key0, RLCM, Send Commercial{Space} 
Else IfEqual key0, ROAJM, Send Major{Space} 
Else IfEqual key0, RODN, Send Donor{Space} 
Else IfEqual key0, ROLC, Send Color{Space} 
Else IfEqual key0, ROOGM, Send Groom{Space} 
Else IfEqual key0, RPCN, Send Pronounce{Space} 
Else IfEqual key0, RPSCB, Send Prescribe{Space} 
Else IfEqual key0, RPSCM, Send Compromise{Space} 
Else IfEqual key0, RSC, Send Source{Space} 
Else IfEqual key0, RSJLN, Send Journalist{Space} 
Else IfEqual key0, RTASHC, Send Scratch{Space} 
Else IfEqual key0, RTAV, Send Avatar{Space} 
Else IfEqual key0, RTFGL, Send Grateful{Space} 
Else IfEqual key0, RTGN, Send Generate{Space} 
Else IfEqual key0, RTIFCN, Send Interface{Space} 
Else IfEqual key0, RTIOAVN, Send Innovator{Space} 
Else IfEqual key0, RTIOSCN, Send Constrict{Space} 
Else IfEqual key0, RTISH, Send Shirt{Space} 
Else IfEqual key0, RTODC, Send Doctor{Space} 
Else IfEqual key0, RTOFH, Send Forth{Space} 
Else IfEqual key0, RTPNM, Send Prominent{Space} 
Else IfEqual key0, RTPSCN, Send Transcript{Space} 
Else IfEqual key0, RTPSN, Send Proposition{Space} 
Else IfEqual key0, RTSDM, Send Mustard{Space} 
Else IfEqual key0, RTSHLC, Send Historical{Space} 
Else IfEqual key0, RTSJLN, Send Journalist{Space} 
Else IfEqual key0, RTUINM, Send Monitor{Space} 
Else IfEqual key0, RTUKC, Send Truck{Space} 
Else IfEqual key0, RTUOSCN, Send Construct{Space} 
Else IfEqual key0, RTUPAB, Send Abrupt{Space} 
Else IfEqual key0, RTUSKC, Send Struck{Space} 
Else IfEqual key0, RTYIVN, Send Inventory{Space} 
Else IfEqual key0, RTYOPH, Send Trophy{Space} 
Else IfEqual key0, RTYSHLC, Send Hysterical{Space} 
Else IfEqual key0, RUASG, Send Sugar{Space} 
Else IfEqual key0, RUOGH, Send Rough{Space} 
Else IfEqual key0, RYDLV, Send Delivery{Space} 
Else IfEqual key0, RYFB, Send February{Space} 
Else IfEqual key0, RYJN, Send January{Space} 
Else IfEqual key0, RYSDCV, Send Discovery{Space} 
Else IfEqual key0, RYSG, Send Surgery{Space} 
Else IfEqual key0, RYUASM, Send Summary{Space} 
Else IfEqual key0, RUS, Send Yours{Space} 
Else IfEqual key0, RTIALC, Send Critical{Space} 
Else IfEqual key0, ROPASL, Send Proposal{Space} 
Else IfEqual key0, RSHC, Send Proposal{Space} 
Else IfEqual key0, RSC, Send Source{Space} 
Else IfEqual key0, RYAGN, Send Angry{Space} 
Else IfEqual key0, RIGN, Send Ignore{Space} 
Else IfEqual key0, RTSGLCN, Send Congratulations{Space} 
Else IfEqual key0, RFV, Send Forever{Space} 
Else IfEqual key0, RTPCM, Send Competitor{Space} 
Else IfEqual key0, RL, Send Real{Space} 
Else IfEqual key0, RTILN, Send Internal{Space} 
Else IfEqual key0, RTUALN, Send Natural{Space} 
Else IfEqual key0, RTHB, Send Breath{Space} 
Else IfEqual key0, RTLCN, Send Control{Space} 
Else IfEqual key0, RDH, Send Heard{Space} 
Else IfEqual key0, RLCM, Send Molecular{Space} 
Else IfEqual key0, RYD, Send Ready{Space} 
Else IfEqual key0, ROAHCB, Send Broach{Space} 
Else IfEqual key0, RIAV, Send Vari{Space} 
Else IfEqual key0, RPSD, Send Spread{Space} 
Else IfEqual key0, RPSHC, Send Purchase{Space} 
Else IfEqual key0, RTAGHLM, Send Algorithm{Space} 
Else IfEqual key0, RODHC, Send Chord{Space} 
Else IfEqual key0, RTAGNM, Send Argument{Space} 
Else IfEqual key0, RTFH, Send Further{Space} 
Else IfEqual key0, RTISDC, Send District{Space} 
Else IfEqual key0, RTPDXN, Send Expenditure{Space} 
Else IfEqual key0, RAFM, Send Farm{Space} 
Else IfEqual key0, RAG, Send Argue{Space} 
Else IfEqual key0, RAKC, Send Crack{Space} 
Else IfEqual key0, RAM, Send Arm{Space} 
 Else IfEqual key0, RTLVN, Send Relevant{Space} 
Else IfEqual key0, RAM, Send Arm{Space} 
Else IfEqual key0, RDFCN, Send Difference{Space} 
Else IfEqual key0, RDFL, Send Federal{Space} 
Else IfEqual key0, RFB, Send Brief{Space} 
Else IfEqual key0, RFCNM, Send Confirm{Space} 
Else IfEqual key0, RFGN, Send Finger{Space} 
Else IfEqual key0, RGHC, Send Charge{Space} 
Else IfEqual key0, RGLN, Send General{Space} 
Else IfEqual key0, RGLV, Send Leverage{Space} 
Else IfEqual key0, RHLCN, Send Chronicle{Space} 
Else IfEqual key0, RIA, Send Air{Space} 
Else IfEqual key0, RIABN, Send Brain{Space} 
Else IfEqual key0, RICB, Send Crib{Space} 
Else IfEqual key0, RID, Send Rid{Space} 
Else IfEqual key0, RIF, Send Riff{Space} 
Else IfEqual key0, RIPAGHC, Send Graphic{Space} 
Else IfEqual key0, RIPALCN, Send Principal{Space} 
Else IfEqual key0, RIPSVM, Send Improvise{Space} 
Else IfEqual key0, RISK, Send Risk{Space} 
Else IfEqual key0, RJN, Send Junior{Space} 
Else IfEqual key0, RKM, Send Maker{Space} 
Else IfEqual key0, RLC, Send Clear{Space} 
Else IfEqual key0, RLCM, Send Curriculum{Space} 
Else IfEqual key0, RLCM, Send Miracle{Space} 
Else IfEqual key0, ROASB, Send Absorb{Space} 
Else IfEqual key0, ROSVB, Send Observe{Space} 
Else IfEqual key0, RPAGH, Send Graph{Space} 
Else IfEqual key0, RPAGHC, Send Graphic{Space} 
Else IfEqual key0, RPG, Send Grp Group{Space} 
Else IfEqual key0, RPLCN, Send Principle{Space} 
Else IfEqual key0, RPSCNM, Send Comparison{Space} 
Else IfEqual key0, RPSHM, Send Sophomore{Space} 
Else IfEqual key0, RPSL, Send Pleasure{Space} 
Else IfEqual key0, RPSLN, Send Personal{Space} 
Else IfEqual key0, RSFC, Send Surface{Space} 
Else IfEqual key0, RSFHNM, Send Freshman{Space} 
Else IfEqual key0, RSFLC, Send Salesforce{Space} 
Else IfEqual key0, RSGLN, Send Singular{Space} 
Else IfEqual key0, RSGLN, Send Singular{Space} 
Else IfEqual key0, RSLCN, Send Counselor{Space} 
Else IfEqual key0, RSXC, Send Exercise{Space} 
Else IfEqual key0, RTAGN, Send Grant{Space} 
Else IfEqual key0, RTASM, Send Smart{Space} 
Else IfEqual key0, RTFC, Send Factor{Space} 
Else IfEqual key0, RTFGN, Send Forgotten{Space} 
Else IfEqual key0, RTHN, Send Neither{Space} 
Else IfEqual key0, RTIDH, Send Third{Space} 
Else IfEqual key0, RTIOSHC, Send Historic{Space} 
Else IfEqual key0, RTISGN, Send String{Space} 
Else IfEqual key0, RTKM, Send Market{Space} 
Else IfEqual key0, RTOAFC, Send Factor{Space} 
Else IfEqual key0, RTOFG, Send Forgot{Space} 
Else IfEqual key0, RTOHN, Send North{Space} 
Else IfEqual key0, RTOPA, Send Parrot{Space} 
Else IfEqual key0, RTOPA, Send Transport{Space} 
Else IfEqual key0, RTPLC, Send Particular{Space} 
Else IfEqual key0, RTPSLC, Send Spectacular{Space} 
Else IfEqual key0, RTPSLC, Send Transport{Space} 
Else IfEqual key0, RTPSN>, Send Transportation{Space} 
Else IfEqual key0, RTPVM, Send Primitive{Space} 
Else IfEqual key0, RTPVN, Send Prevent{Space} 
Else IfEqual key0, RTPXNM, Send Experiment{Space} 
Else IfEqual key0, RTSCN, Send Countries{Space} 
Else IfEqual key0, RTSDB, Send Disturb{Space} 
Else IfEqual key0, RTSFN, Send Transfer{Space} 
Else IfEqual key0, RTSHC, Send Historic{Space} 
Else IfEqual key0, RTUAM, Send Trauma{Space} 
Else IfEqual key0, RTUO, Send Tour{Space} 
Else IfEqual key0, RTUOAH, Send Author{Space} 
Else IfEqual key0, RTYAN, Send Attorney{Space} 
Else IfEqual key0, RTYP, Send Property{Space} 
Else IfEqual key0, RTYP, Send Property{Space} 
Else IfEqual key0, RUADG, Send Guard{Space} 
Else IfEqual key0, RUBN, Send Burn{Space} 
Else IfEqual key0, RUODN, Send Round{Space} 
Else IfEqual key0, RUOS, Send Ours{Space} 
Else IfEqual key0, RUSH, Send Rush{Space} 
Else IfEqual key0, RYANM, Send Anymore{Space} 
Else IfEqual key0, RYANM, Send Anymore{Space} 
Else IfEqual key0, RYJN, Send Journey{Space} 
Else IfEqual key0, RYPAS, Send Spray{Space} 
Else IfEqual key0, RTPHC, Send Chapter{Space} 
Else IfEqual key0, RTSDC, Send District{Space} 
Else IfEqual key0, RTYGC, Send Category{Space} 
Else IfEqual key0, RADC, Send Card{Space} 
Else IfEqual key0, ROF, Send For{Space} 
Else IfEqual key0, RYAD, Send Yard{Space} 
Else IfEqual key0, RADG, Send Grad{Space} 
Else IfEqual key0, RADH, Send Hard{Space} 
Else IfEqual key0, RAKM, Send Mark{Space} 
Else IfEqual key0, RAKM, Send Mark{Space} 
Else IfEqual key0, RASDV, Send Advisor{Space} 
Else IfEqual key0, RDCNM, Send Recommend{Space} 
Else IfEqual key0, RDGN, Send Gender{Space} 
Else IfEqual key0, RDGN, Send Gender{Space} 
Else IfEqual key0, RDHN, Send Hundred{Space} 
Else IfEqual key0, RDLV, Send Deliver{Space} 
Else IfEqual key0, RDM, Send Dream{Space} 
Else IfEqual key0, RDN, Send Round{Space} 
Else IfEqual key0, RDNM, Send Random{Space} 
Else IfEqual key0, RDVN, Send Vendor{Space} 
Else IfEqual key0, RFC, Send Force{Space} 
Else IfEqual key0, RFC, Send Force{Space} 
Else IfEqual key0, RFCN, Send Reference{Space} 
Else IfEqual key0, RFCN, Send Reference{Space} 
Else IfEqual key0, RFCN, Send Conference{Space} 
Else IfEqual key0, RFLV, Send Flavor{Space} 
Else IfEqual key0, RFM, Send Firm{Space} 
Else IfEqual key0, RG, Send Regard{Space} 
Else IfEqual key0, RGCN, Send Encourage{Space} 
Else IfEqual key0, RGCN, Send Encourage{Space} 
Else IfEqual key0, RGL, Send Regular{Space} 
Else IfEqual key0, RGL, Send Regardless{Space} 
Else IfEqual key0, RGL, Send Regular{Space} 
Else IfEqual key0, RGLV, Send Leverage{Space} 
Else IfEqual key0, RHCBM, Send Chamber{Space} 
Else IfEqual key0, RHVB, Send Behavior{Space} 
Else IfEqual key0, RIADN, Send Drain{Space} 
Else IfEqual key0, RIAH, Send Hair{Space} 
Else IfEqual key0, RIFM, Send Firm{Space} 
Else IfEqual key0, RISCN, Send Increase{Space} 
Else IfEqual key0, RLB, Send Reliable{Space} 
Else IfEqual key0, RLCM, Send Commercial{Space} 
Else IfEqual key0, RLV, Send Lever{Space} 
Else IfEqual key0, ROALB, Send Labor{Space} 
Else IfEqual key0, ROD, Send Door{Space} 
Else IfEqual key0, ROGCN, Send Organic{Space} 
Else IfEqual key0, ROHN, Send Honor{Space} 
Else IfEqual key0, ROKC, Send Rock{Space} 
Else IfEqual key0, ROLC, Send Color{Space} 
Else IfEqual key0, RPD, Send Drop{Space} 
Else IfEqual key0, RPAV, Send Approve{Space} 
Else IfEqual key0, RPCV, Send Perceive{Space} 
Else IfEqual key0, RPDN, Send Pardon{Space} 
Else IfEqual key0, RPGHC, Send Graphic{Space} 
Else IfEqual key0, RPL, Send Popular{Space} 
Else IfEqual key0, RPL, Send Popular{Space} 
Else IfEqual key0, RPSC, Send Precise{Space} 
Else IfEqual key0, RPSCN, Send Presence{Space} 
Else IfEqual key0, RPSF, Send Profess{Space} 
Else IfEqual key0, RPSG, Send Progress{Space} 
Else IfEqual key0, RSCN, Send Increase{Space} 
Else IfEqual key0, RSCN, Send Increase{Space} 
Else IfEqual key0, RSCNM, Send Consumer{Space} 
Else IfEqual key0, RSD, Send Desire{Space} 
Else IfEqual key0, RSDC, Send Decrease{Space} 
Else IfEqual key0, RSDLC, Send Ridiculous{Space} 
Else IfEqual key0, RSDLC, Send Ridiculous{Space} 
Else IfEqual key0, RSDN, Send Surround{Space} 
Else IfEqual key0, RSDV, Send Deserve{Space} 
Else IfEqual key0, RSV, Send Various{Space} 
Else IfEqual key0, RSXC, Send Exercise{Space} 
Else IfEqual key0, RSXC, Send Exercise{Space} 
Else IfEqual key0, RTAB, Send Attribute{Space} 
Else IfEqual key0, RTALC, Send Article{Space} 
Else IfEqual key0, RTCBN, Send Contribute{Space} 
Else IfEqual key0, RTDCN, Send Coordinate{Space} 
Else IfEqual key0, RTIDCN, Send Coordinate{Space} 
Else IfEqual key0, RTFCNM, Send Manufacture{Space} 
Else IfEqual key0, RTFLC, Send Reflect{Space} 
Else IfEqual key0, RTIAL, Send Trial{Space} 
Else IfEqual key0, RTIKC, Send Trick{Space} 
Else IfEqual key0, RTLCB, Send Collaborate{Space} 
Else IfEqual key0, RTO, Send Root{Space} 
Else IfEqual key0, RTOASHC, Send Orchestra{Space} 
Else IfEqual key0, RTOPM, Send Prompt{Space} 
Else IfEqual key0, RTPF, Send Profit{Space} 
Else IfEqual key0, RTPFN, Send Nonprofit{Space} 
Else IfEqual key0, RTYPSCN, Send Transparency{Space} 
Else IfEqual key0, RTPSDCN, Send Description{Space} 
Else IfEqual key0, RTPSN, Send Inspiration{Space} 
Else IfEqual key0, RTIPVN, Send Prevent{Space} 
Else IfEqual key0, RTPVN, Send Prevent{Space} 
Else IfEqual key0, RTPX, Send Expert{Space} 
Else IfEqual key0, RTSCN, Send Contrast{Space} 
Else IfEqual key0, RTSDNM, Send Demonstrate{Space} 
Else IfEqual key0, RTSGL, Send Struggle{Space} 
Else IfEqual key0, RTSN, Send Restaurant{Space} 
Else IfEqual key0, RTSN, Send Resonate{Space} 
Else IfEqual key0, RTSN, Send Restaurant{Space} 
Else IfEqual key0, RTSNM, Send Instrument{Space} 
Else IfEqual key0, RTUOM, Send Tumor{Space} 
Else IfEqual key0, RTYCN, Send Country{Space} 
Else IfEqual key0, RTYHCM, Send Chemistry{Space} 
Else IfEqual key0, RTYHM, Send Rhythm{Space} 
Else IfEqual key0, RTYSC, Send Security{Space} 
Else IfEqual key0, RTYSH, Send History{Space} 
Else IfEqual key0, RUDG, Send Drug{Space} 
Else IfEqual key0, RVB, Send Brave{Space} 
Else IfEqual key0, RVM, Send Remove{Space} 
Else IfEqual key0, RYGLN, Send Neurology{Space} 
Else IfEqual key0, RIPVM, Send Improve{Space} 	
Else IfEqual key0, RUDM, Send Drum{Space} 
Else IfEqual key0, RAGB, Send Grab{Space} 
Else IfEqual key0, RCV, Send Receive{Space} 
Else IfEqual key0, RDBN, Send Burden{Space} 
Else IfEqual key0, RIOP, Send Prior{Space} 
Else IfEqual key0, RNM, Send Remain{Space} 
Else IfEqual key0, RPCM, Send Compare{Space} 
Else IfEqual key0, RPSM, Send Promise{Space} 
Else IfEqual key0, RPSM, Send Promise{Space} 
Else IfEqual key0, RSCV, Send Service{Space} 
Else IfEqual key0, RSDCV, Send Discover{Space} 
Else IfEqual key0, RSDN, Send Surround{Space} 
Else IfEqual key0, RSV, Send Survive{Space} 
Else IfEqual key0, RSVN, Send Version{Space} 
Else IfEqual key0, RTD, Send Tried{Space} 
Else IfEqual key0, RTDGH, Send Daughter{Space} 
Else IfEqual key0, RTFG, Send Forget{Space} 
Else IfEqual key0, RTHC, Send Teacher{Space} 
Else IfEqual key0, RTIAN, Send Train{Space} 
Else IfEqual key0, RTIC, Send Critic{Space} 
Else IfEqual key0, RTIOSCN, Send Construction{Space} 
Else IfEqual key0, RTISCM, Send Criticism{Space} 
Else IfEqual key0, RTLM, Send Material{Space} 
Else IfEqual key0, RTLN, Send Relation{Space} 
Else IfEqual key0, RTSCN, Send Construct{Space} 
Else IfEqual key0, RTSCVN, Send Constructive{Space} 
Else IfEqual key0, RTSLN, Send Resolution{Space} 
Else IfEqual key0, RYAC, Send Carry{Space} 
Else IfEqual key0, RTH, Send Rather{Space} 	
Else IfEqual key0, RAB, Send Bar{Space} 
Else IfEqual key0, RAC, Send Across{Space} 
Else IfEqual key0, RADBN, Send Brand{Space} 
Else IfEqual key0, RADH, Send Hard{Space} 
Else IfEqual key0, RAF, Send Far{Space} 
Else IfEqual key0, RAFKN, Send Frank{Space} 
Else IfEqual key0, RAL, Send Ral
Else IfEqual key0, RAX, Send Extra{Space} 
Else IfEqual key0, RB, Send Br
Else IfEqual key0, RBM, Send Remember{Space} 
Else IfEqual key0, RBN, Send Brain{Space} 
Else IfEqual key0, RC, Send Crazy{Space} 
Else IfEqual key0, RD, Send Read{Space} 
Else IfEqual key0, RDG, Send During{Space} 
Else IfEqual key0, RDLZ, Send Realized{Space} 
Else IfEqual key0, RF, Send From{Space} 
Else IfEqual key0, RFG, Send Figure{Space} 
Else IfEqual key0, RFLM, Send Familiar{Space} 
Else IfEqual key0, RFN, Send Refine{Space} 
Else IfEqual key0, RGB, Send Bring{Space} 
Else IfEqual key0, RGNM, Send Manager{Space} 
Else IfEqual key0, RIOGNM, Send Morning{Space} 
Else IfEqual key0, RGZCN, Send Recognize{Space} 
Else IfEqual key0, RH, Send Here{Space} 
Else IfEqual key0, RIAF, Send Fair{Space} 
Else IfEqual key0, RIDHLC, Send Children{Space} 
Else IfEqual key0, RDHLCN, Send Children{Space} 
Else IfEqual key0, RIGBN, Send Bring{Space} 
Else IfEqual key0, RIGL, Send Girl{Space} 
Else IfEqual key0, RIHC, Send Rich{Space} 
Else IfEqual key0, RIOCM, Send Micro
Else IfEqual key0, RIPA, Send Pair{Space} 
Else IfEqual key0, RJM, Send Major{Space} 
Else IfEqual key0, RLNM, Send Normal{Space} 
Else IfEqual key0, RLZ, Send Realize{Space} 
Else IfEqual key0, RM, Send More{Space} 
Else IfEqual key0, RN, Send Right Now{Space} 
Else IfEqual key0, RO, Send Or{Space} 
Else IfEqual key0, ROACM, Send Macro
Else IfEqual key0, ROAD, Send Road{Space} 
Else IfEqual key0, ROADB, Send Board{Space} 
Else IfEqual key0, ROADBN, Send Onboard{Space} 
Else IfEqual key0, ROADL, Send Dollar{Space} 
Else IfEqual key0, ROALNM, Send Normal{Space} 
Else IfEqual key0, ROFM, Send Form{Space} 
Else IfEqual key0, ROG, Send Organization{Space} 
Else IfEqual key0, ROGLN, Send Original{Space} 
Else IfEqual key0, ROGN, Send Original{Space} 
Else IfEqual key0, ROGNM, Send Morning{Space} 
Else IfEqual key0, ROL, Send Roll{Space} 
Else IfEqual key0, ROLNM, Send Normal{Space} 
Else IfEqual key0, ROM, Send Room{Space} 
Else IfEqual key0, ROP, Send Pro
Else IfEqual key0, ROPB, Send Probably{Space} 
Else IfEqual key0, ROPD, Send Drop{Space} 
Else IfEqual key0, RTPDC, Send Product{Space} 
Else IfEqual key0, ROPJ, Send Project{Space} 
Else IfEqual key0, ROPLB, Send Problem{Space} 
Else IfEqual key0, ROSC, Send Cross{Space} 
Else IfEqual key0, ROSG, Send Organizations{Space} 
Else IfEqual key0, ROSLC, Send Scroll{Space} 
Else IfEqual key0, RPA, Send Appreciate{Space} 
Else IfEqual key0, RPAHC, Send Approach{Space} 
Else IfEqual key0, RPAK, Send Park{Space} 
Else IfEqual key0, RPB, Send Problem{Space} 
Else IfEqual key0, RPC, Send Process{Space} 
Else IfEqual key0, RPDC, Send Proceed{Space} 
Else IfEqual key0, RPDV, Send Provide{Space} 
Else IfEqual key0, RPF, Send Professional{Space} 
Else IfEqual key0, RPFCNM, Send Performance{Space} 
Else IfEqual key0, RPFL, Send Profile{Space} 
Else IfEqual key0, RPFM, Send Perform{Space} 
Else IfEqual key0, RPGM, Send Program{Space} 
Else IfEqual key0, RPLB, Send Problem{Space} 
Else IfEqual key0, RPLX, Send Explore{Space} 
Else IfEqual key0, RPS, Send Surprise{Space} 
Else IfEqual key0, RPSLBN, Send Responsible{Space} 
Else IfEqual key0, RPSDN, Send Respond{Space} 
Else IfEqual key0, RPSH, Send Perhaps{Space} 
Else IfEqual key0, RTPSBN, Send Responsibility{Space} 
Else IfEqual key0, RPSN, Send Response{Space} 
Else IfEqual key0, RS, Send Sure{Space} 
Else IfEqual key0, RSDCB, Send Describe{Space} 
Else IfEqual key0, RSDCN, Send Consider{Space} 
Else IfEqual key0, RSL, Send Release{Space} 
Else IfEqual key0, RSLM, Send Similar{Space} 
Else IfEqual key0, RSLV, Send Several{Space} 
Else IfEqual key0, RSN, Send Reason{Space} 
Else IfEqual key0, RT, Send Right{Space} 
Else IfEqual key0, RTAD, Send Traditional{Space} 
Else IfEqual key0, RTAKC, Send Track{Space} 
Else IfEqual key0, RTAL, Send Alright{Space} 
Else IfEqual key0, RTALC, Send Article{Space} 
Else IfEqual key0, RTAN, Send Another{Space} 
Else IfEqual key0, RTAS, Send Strategy{Space} 
Else IfEqual key0, RTASDN, Send Standard{Space} 
Else IfEqual key0, RTASN, Send Trans{Space} 
Else IfEqual key0, RTC, Send Create{Space} 
Else IfEqual key0, RTCN, Send Certain{Space} 
Else IfEqual key0, RTCV, Send Creative{Space} 
Else IfEqual key0, RTFLC, Send Reflect{Space} 
Else IfEqual key0, RTFN, Send Fortunate{Space} 
Else IfEqual key0, RTG, Send Trying{Space} 
Else IfEqual key0, RTGC, Send Creating{Space} 
Else IfEqual key0, RTGH, Send Together{Space} 
Else IfEqual key0, RTI, Send Tri
Else IfEqual key0, RTIAFC, Send Traffic{Space} 
Else IfEqual key0, RTIAN, Send Intra
Else IfEqual key0, RTIASN, Send Strain{Space} 
Else IfEqual key0, RTIOASN, Send Transition{Space} 
Else IfEqual key0, RTIGN, Send Integrate{Space} 
Else IfEqual key0, RTIL, Send Literally{Space} 
Else IfEqual key0, RTIODCN, Send Coordinate{Space} 
Else IfEqual key0, RTIODN, Send Introduce{Space} 
Else IfEqual key0, RTION, Send Intro
Else IfEqual key0, RTIPA, Send Particular{Space} 
Else IfEqual key0, RTL, Send Literal{Space} 
Else IfEqual key0, RTLB, Send Trouble{Space} 
Else IfEqual key0, RTLC, Send Control{Space} 
Else IfEqual key0, RTLCB, Send Collaborate{Space} 
Else IfEqual key0, RTLV, Send Relative{Space} 
Else IfEqual key0, RTM, Send Remote{Space} 
Else IfEqual key0, RTN, Send Entire{Space} 
Else IfEqual key0, RTOAC, Send Actor{Space} 
Else IfEqual key0, RTOACN, Send Contract{Space} 
Else IfEqual key0, RTOB, Send Obtrusive{Space} 
Else IfEqual key0, RTOCN, Send Contro
Else IfEqual key0, RTOFN, Send Front{Space} 
Else IfEqual key0, RTOM, Send Tomorrow{Space} 
Else IfEqual key0, RTOS, Send Sort{Space} 
Else IfEqual key0, RTOSG, Send Storage{Space} 
Else IfEqual key0, RTOSGN, Send Strong{Space} 
Else IfEqual key0, RTOSH, Send Short{Space} 
Else IfEqual key0, RTP, Send Repeat{Space} 
Else IfEqual key0, RTPA, Send Part{Space} 
Else IfEqual key0, RTPAC, Send Practice{Space} 
Else IfEqual key0, RTPAN, Send Apparent{Space} 
Else IfEqual key0, RTPC, Send Picture{Space} 
Else IfEqual key0, RTPCN, Send Perception{Space} 
Else IfEqual key0, RTPS, Send Separate{Space} 
Else IfEqual key0, RTPSC, Send Respect{Space} 
Else IfEqual key0, RTPSCV, Send Perspective{Space} 
Else IfEqual key0, RTPV, Send Private{Space} 
Else IfEqual key0, RTS, Send Start{Space} 
Else IfEqual key0, RTSBN, Send Stubborn{Space} 
Else IfEqual key0, RTSCM, Send Customer{Space} 
Else IfEqual key0, RTSD, Send Disastrous{Space} 
Else IfEqual key0, RTSDC, Send Distract{Space} 
Else IfEqual key0, RTSDN, Send Standard{Space} 
Else IfEqual key0, RTSG, Send Starting{Space} 
Else IfEqual key0, RTSGH, Send Straight{Space} 
Else IfEqual key0, RTSM, Send Stream{Space} 
Else IfEqual key0, RTUALB, Send Brutal{Space} 
Else IfEqual key0, RTUALC, Send Cultural{Space} 
Else IfEqual key0, RTUH, Send Hurt{Space} 
Else IfEqual key0, RTUOGH, Send Through{Space} 
Else IfEqual key0, RTUN, Send Turn{Space} 
Else IfEqual key0, RTUOPS, Send Support{Space} 
Else IfEqual key0, RTUS, Send Trust{Space} 
Else IfEqual key0, RTVN, Send Narrative{Space} 
Else IfEqual key0, RTY, Send Try{Space} 
Else IfEqual key0, RTYOS, Send Story{Space} 
Else IfEqual key0, RTYPA, Send Party{Space} 
Else IfEqual key0, RTYUL, Send Truly{Space} 
Else IfEqual key0, RU, Send Your{Space} 
Else IfEqual key0, RUIOASV, Send Various{Space} 
Else IfEqual key0, RUIOSC, Send Curious{Space} 
Else IfEqual key0, RUN, Send Run{Space} 
Else IfEqual key0, RUO, Send Our{Space} 
Else IfEqual key0, RUOC, Send Occur{Space} 
Else IfEqual key0, RUODGN, Send Ground{Space} 
Else IfEqual key0, RUOH, Send Hour{Space} 
Else IfEqual key0, RUOPG, Send Group{Space} 
Else IfEqual key0, RUPHC, Send Purchase{Space} 
Else IfEqual key0, RV, Send Virtual Reality{Space} 
Else IfEqual key0, RY, Send Year{Space} 
Else IfEqual key0, RYAFKLN, Send Frankly{Space} 
Else IfEqual key0, RYAV, Send Vary{Space} 
Else IfEqual key0, RYOS, Send Sorry{Space} 
Else IfEqual key0, RYPCV, Send Privacy{Space} 
Else IfEqual key0, RYS, Send Years{Space} 
Else IfEqual key0, RAN, Send Ran{Space} 
Else IfEqual key0, RDCV, Send Received{Space} 
Else IfEqual key0, RJLN, Send Journal{Space} 
Else IfEqual key0, ROPA, Send Approach{Space} 
Else IfEqual key0, ROPAHC, Send Approach{Space} 
Else IfEqual key0, RPAM, Send Ramp{Space} 
Else IfEqual key0, RPSV, Send Previous{Space} 
Else IfEqual key0, RSM, Send Measure{Space} 
Else IfEqual key0, RTA, Send Art{Space} 
Else IfEqual key0, RTAC, Send Attract{Space} 
Else IfEqual key0, RTDC, Send Direct{Space} 
Else IfEqual key0, RTDG, Send Graduate{Space} 
Else IfEqual key0, RTDNM, Send Determine{Space} 
Else IfEqual key0, RTF, Send Feature{Space} 
Else IfEqual key0, RTGHB, Send Brought{Space} 
Else IfEqual key0, RTIAN, Send Train{Space} 
Else IfEqual key0, RTIAS, Send Artist{Space} 
Else IfEqual key0, RTIPN, Send Print{Space} 
Else IfEqual key0, RTPL, Send Partial{Space} 
Else IfEqual key0, RTPM, Send Promote{Space} 
Else IfEqual key0, RTSDB, Send Distribute{Space} 
Else IfEqual key0, RUOPD, Send Proud{Space} 
Else IfEqual key0, RTPN, Send Pattern{Space} 
Else IfEqual key0, RYPM, Send Primary{Space} 
Return
SENDTup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, TA, Send At{Space} 
Else IfEqual key0, TADH, Send That'd{Space} 
Else IfEqual key0, TISV, Send Visit{Space} 
Else IfEqual key0, TIHN, Send Thin{Space} 
Else IfEqual key0, TPSLN, Send Pleasant{Space} 
Else IfEqual key0, TADCV, Send Advocate{Space} 
Else IfEqual key0, TAHM, Send Math{Space} 
Else IfEqual key0, TUPG, Send Putting{Space} 
Else IfEqual key0, TAKN, Send Tank{Space} 
Else IfEqual key0, TGLV, Send Vegetable{Space} 
Else IfEqual key0, TGVN, Send Navigate{Space} 
Else IfEqual key0, TIAFH, Send Faith{Space} 
Else IfEqual key0, TIPSL, Send Split{Space} 
Else IfEqual key0, TIAL, Send Tail{Space} 
Else IfEqual key0, TIAS, Send Assist{Space} 
Else IfEqual key0, TIFGHL, Send Flight{Space} 
Else IfEqual key0, TIGHM, Send Might{Space} 
Else IfEqual key0, TILCN, Send Inoculate{Space} 
Else IfEqual key0, TIOFLCN, Send Conflict{Space} 
Else IfEqual key0, TIPAN, Send Paint{Space} 
Else IfEqual key0, TIPAN, Send Paint{Space} 
Else IfEqual key0, TISV, Send Visit{Space} 
Else IfEqual key0, TOHCB, Send Botch{Space} 
Else IfEqual key0, TOHLC, Send Cloth{Space} 
Else IfEqual key0, TOPSG, Send Stopping{Space} 
Else IfEqual key0, TOSD, Send Stood{Space} 
Else IfEqual key0, TOSHM, Send Smooth{Space} 
Else IfEqual key0, TOSHM, Send Smooth{Space} 
Else IfEqual key0, TOSL, Send Lost{Space} 
Else IfEqual key0, TPASNM, Send Assumption{Space} 
Else IfEqual key0, TPCN, Send Patience{Space} 
Else IfEqual key0, TPCVM, Send Competitive{Space} 
Else IfEqual key0, TPHKC, Send Ketchup{Space} 
Else IfEqual key0, TPSLC, Send Telescope{Space} 
Else IfEqual key0, TSDNM, Send Disseminate{Space} 
Else IfEqual key0, TSFC, Send Suffocate{Space} 
Else IfEqual key0, TSHLB, Send Bullshit{Space} 
Else IfEqual key0, TUADL, Send Adult{Space} 
Else IfEqual key0, TUAFL, Send Fault{Space} 
Else IfEqual key0, TUASG, Send August{Space} 
Else IfEqual key0, TUHN, Send Hunt{Space} 
Else IfEqual key0, TUIN, Send Unit{Space} 
Else IfEqual key0, TUIOACN, Send Caution{Space} 
Else IfEqual key0, TUIPSD, Send Stupid{Space} 
Else IfEqual key0, TUISCN, Send Succinct{Space} 
Else IfEqual key0, TULZ, Send Utilize{Space} 
Else IfEqual key0, TUOASCM, Send Accustom{Space} 
Else IfEqual key0, TUOCM, Send Outcome{Space} 
Else IfEqual key0, TUOSLCN, Send Consult{Space} 
Else IfEqual key0, TUPG, Send Putting{Space} 
Else IfEqual key0, TUSKC, Send Stuck{Space} 
Else IfEqual key0, TYFLC, Send Facility{Space} 
Else IfEqual key0, TUOGHB, Send Bought{Space} 
Else IfEqual key0, TPXC, Send Expect{Space} 
Else IfEqual key0, TPCN, Send Patience{Space} 
Else IfEqual key0, TPN, Send Patient{Space} 
Else IfEqual key0, TPCVM, Send Competitive{Space} 
Else IfEqual key0, TUAGHC, Send Caught{Space} 
Else IfEqual key0, TPSCNM, Send Compensate{Space} 
Else IfEqual key0, TFL, Send Left{Space} 
Else IfEqual key0, TUADL, Send Adult{Space} 
Else IfEqual key0, TSVN, Send Sensitive{Space} 
Else IfEqual key0, TGVM, Send Government{Space} 
Else IfEqual key0, TODN, Send Don't{Space} 
Else IfEqual key0, TACM, Send Automatic{Space} 
Else IfEqual key0, TX, Send Text{Space} 
Else IfEqual key0, TAHC, Send Catch{Space} 
Else IfEqual key0, TAHCM, Send Match{Space} 
Else IfEqual key0, TAS, Send Sat{Space} 
Else IfEqual key0, TADLN, Send Additional{Space} 
Else IfEqual key0, TADN, Send Addition{Space} 
Else IfEqual key0, TDLV, Send Validate{Space} 
Else IfEqual key0, TIDCN, Send Indicate{Space} 
Else IfEqual key0, TIPALC, Send Capital{Space} 
Else IfEqual key0, TISDN, Send Instead{Space} 
Else IfEqual key0, TPXC, Send Expect{Space} 	
Else IfEqual key0, TOSL, Send Lost{Space} 
Else IfEqual key0, TPLNM, Send Implement{Space} 
Else IfEqual key0, TSCNL, Send Constantly{Space} 
Else IfEqual key0, TSDCN, Send Distance{Space} 
Else IfEqual key0, TSFGCN, Send Significant{Space} 
Else IfEqual key0, TUIPN, Send Input{Space} 
Else IfEqual key0, TYDFN, Send Identify{Space} 
Else IfEqual key0, TYUSD, Send Study{Space} 
Else IfEqual key0, TASC, Send Cast{Space} 
Else IfEqual key0, TADHN, Send Hadn’T{Space} 
Else IfEqual key0, TAHL, Send That’Ll{Space} 
Else IfEqual key0, TASGN, Send Against{Space} 
Else IfEqual key0, TASHKN, Send Thanks{Space} 
Else IfEqual key0, TBN, Send Button{Space} 	
Else IfEqual key0, TIAC, Send Attic{Space} 
Else IfEqual key0, TIASN, Send Instant{Space} 
Else IfEqual key0, TIDG, Send Digit{Space} 
Else IfEqual key0, TIF, Send Fit{Space} 
Else IfEqual key0, TIFG, Send Gift{Space} 
Else IfEqual key0, TIFGH, Send Fight{Space} 
Else IfEqual key0, TIHKC, Send Thick{Space} 
Else IfEqual key0, TILM, Send Limit{Space} 
Else IfEqual key0, TIOACN, Send Contain{Space} 
Else IfEqual key0, TIOGHN, Send Tonight{Space} 
Else IfEqual key0, TIONM, Send Motion{Space} 
Else IfEqual key0, TISM, Send Mist{Space} 
Else IfEqual key0, TKN, Send Think{Space} 
Else IfEqual key0, TOA, Send Tattoo{Space} 
Else IfEqual key0, TOASC, Send Coast{Space} 
Else IfEqual key0, TOF, Send Foot{Space} 
Else IfEqual key0, TOGHN, Send Thong{Space} 
Else IfEqual key0, TOPS, Send Stop{Space} 
Else IfEqual key0, TPDN, Send Independent{Space} 
Else IfEqual key0, TPL, Send Pollute{Space} 
Else IfEqual key0, TPLCNM, Send Implication{Space} 
Else IfEqual key0, TPLNM, Send Implement{Space} 
Else IfEqual key0, TPSLCNM, Send Implications{Space} 
Else IfEqual key0, TPSM, Send Symptom{Space} 
Else IfEqual key0, TRADE, Send Trade{Space} 
Else IfEqual key0, TSBM, Send Submit{Space} 
Else IfEqual key0, TSCBN, Send Substance{Space} 
Else IfEqual key0, TSFNM, Send Manifest{Space} 
Else IfEqual key0, TSGN, Send Suggestion{Space} 
Else IfEqual key0, TSK, Send Takes{Space} 
Else IfEqual key0, TSXN, Send Extension{Space} 
Else IfEqual key0, TUAH, Send Authorize{Space} 
Else IfEqual key0, TUAHCN, Send Authentic{Space} 
Else IfEqual key0, TUIOANM, Send Mountain{Space} 
Else IfEqual key0, TUISLN, Send Insult{Space} 
Else IfEqual key0, TULC, Send Cult{Space} 
Else IfEqual key0, TUOSD, Send Outside{Space} 
Else IfEqual key0, TUOSH, Send South{Space} 
Else IfEqual key0, TUOSH, Send Shout{Space} 
Else IfEqual key0, TVN, Send Initiative{Space} 
Else IfEqual key0, TVNM, Send Motivation{Space} 
Else IfEqual key0, TYPSM, Send Symptom{Space} 
Else IfEqual key0, TYUOCN, Send County{Space} 
Else IfEqual key0, TDCN, Send Condition{Space} 
Else IfEqual key0, TDCN, Send Candidate{Space} 
Else IfEqual key0, TDCNM, Send Document{Space} 
Else IfEqual key0, TDXN, Send Extend{Space} 
Else IfEqual key0, TGN, Send Negotiate{Space} 
Else IfEqual key0, TIDC, Send Dict{Space} 
Else IfEqual key0, TIDFN, Send Identify{Space} 
Else IfEqual key0, TIDM, Send Immediate{Space} 
Else IfEqual key0, TIFL, Send Lift{Space} 
Else IfEqual key0, TIOCM, Send Commit{Space} 
Else IfEqual key0, TIOPC, Send Topic{Space} 
Else IfEqual key0, TIP, Send Tip{Space} 
Else IfEqual key0, TIPS, Send Tips{Space} 
Else IfEqual key0, TISFH, Send Shift{Space} 
Else IfEqual key0, TISGHL, Send Slight{Space} 
Else IfEqual key0, TISN, Send Isn't{Space} 
Else IfEqual key0, TLCM, Send Climate{Space} 
Else IfEqual key0, TLN, Send National{Space} 
Else IfEqual key0, TOCV, Send Octave{Space} 
Else IfEqual key0, TOJCVB, Send Objective{Space} 
Else IfEqual key0, TPAN, Send Appoint{Space} 
Else IfEqual key0, TPANM, Send Appointment{Space} 
Else IfEqual key0, TPCM, Send Compete{Space} 
Else IfEqual key0, TPLC, Send Politic{Space} 
Else IfEqual key0, TPLCNM, Send Complement{Space} 
Else IfEqual key0, TPSHCN, Send Snapchat{Space} 
Else IfEqual key0, TPSN, Send Position{Space} 
Else IfEqual key0, TSCN, Send Constant{Space} 
Else IfEqual key0, TSCN, Send Consistent{Space} 
Else IfEqual key0, TSCN, Send Constant{Space} 
Else IfEqual key0, TSCN, Send Scientist{Space} 
Else IfEqual key0, TSDCN, Send Distance{Space} 
Else IfEqual key0, TSDHN, Send Thousand{Space} 
Else IfEqual key0, TUDC, Send Duct{Space} 
Else IfEqual key0, TUIOSD, Send Studio{Space} 
Else IfEqual key0, TUIS, Send Suit{Space} 
Else IfEqual key0, TUODB, Send Doubt{Space} 
Else IfEqual key0, TUODCN, Send Conduct{Space} 
Else IfEqual key0, TUOKL, Send Outlook{Space} 
Else IfEqual key0, TUSH, Send Shut{Space} 
Else IfEqual key0, TVM, Send Motive{Space} 
Else IfEqual key0, TVN, Send Invite{Space} 
Else IfEqual key0, TYB, Send Beauty{Space} 
Else IfEqual key0, TYCN, Send County{Space} 
Else IfEqual key0, TYIN, Send Tiny{Space} 
Else IfEqual key0, TYPAC, Send Capacity{Space} 
Else IfEqual key0, TAC, Send Act{Space} 
Else IfEqual key0, TFLB, Send Beautiful{Space} 
Else IfEqual key0, TASHN, Send Hasn't{Space} 
Else IfEqual key0, TFLB, Send Beautiful{Space} 
Else IfEqual key0, TGVN, Send Negative{Space} 
Else IfEqual key0, TIANM, Send Maintain{Space} 
Else IfEqual key0, TIL, Send It'll{Space} 
Else IfEqual key0, TIPACM, Send Impact{Space} 
Else IfEqual key0, TOSH, Send Shot{Space} 
Else IfEqual key0, TSCM, Send Costume{Space} 
Else IfEqual key0, TSFCN, Send Fantastic{Space} 
Else IfEqual key0, TUIOAS, Send Situation{Space} 
Else IfEqual key0, TUIOAS, Send Situation{Space} 
Else IfEqual key0, TACN, Send Can't{Space} 
Else IfEqual key0, TAD, Send Data{Space} 
Else IfEqual key0, TAFC, Send Fact{Space} 
Else IfEqual key0, TAGKL, Send Talking{Space} 
Else IfEqual key0, TAGN, Send Against{Space} 
Else IfEqual key0, TAH, Send That{Space} 
Else IfEqual key0, TAHC, Send Chat{Space} 
Else IfEqual key0, TAHKN, Send Thank{Space} 
Else IfEqual key0, TAHN, Send Than{Space} 
Else IfEqual key0, TAKL, Send Talk{Space} 
Else IfEqual key0, TALC, Send Actually{Space} 
Else IfEqual key0, TAM, Send Amount{Space} 
Else IfEqual key0, TAN, Send Attention{Space} 
Else IfEqual key0, TASDN, Send Stand{Space} 
Else IfEqual key0, TASF, Send Fast{Space} 
Else IfEqual key0, TASH, Send That's{Space} 
Else IfEqual key0, TASKC, Send Stack{Space} 
Else IfEqual key0, TASL, Send Last{Space} 
Else IfEqual key0, TBM, Send Bottom{Space} 
Else IfEqual key0, TC, Send Content{Space} 
Else IfEqual key0, TCM, Send Community{Space} 
Else IfEqual key0, TCN, Send Continue{Space} 
Else IfEqual key0, TD, Send Today{Space} 
Else IfEqual key0, TDCMN, Send Document{Space} 
Else IfEqual key0, TDFCN, Send Confident{Space} 
Else IfEqual key0, TDGL, Send Digital{Space} 
Else IfEqual key0, TDL, Send Detail{Space} 
Else IfEqual key0, TDN, Send Don't{Space} 
Else IfEqual key0, TDX, Send Excited{Space} 
Else IfEqual key0, TF, Send First{Space} 
Else IfEqual key0, TFBN, Send Benefit{Space} 
Else IfEqual key0, TG, Send Thing{Space} 
Else IfEqual key0, TGHLC, Send Glitch{Space} 
Else IfEqual key0, TGK, Send Taking{Space} 
Else IfEqual key0, TGK, Send Taking{Space} 
Else IfEqual key0, TGKL, Send Talking{Space} 
Else IfEqual key0, TGKL, Send Talking{Space} 
Else IfEqual key0, TGKN, Send Thinking{Space} 
Else IfEqual key0, TGM, Send Meeting{Space} 
Else IfEqual key0, TGNM, Send Management{Space} 
Else IfEqual key0, TH, Send This{Space} 
Else IfEqual key0, THB, Send To Be Honest{Space} 
Else IfEqual key0, THKN, Send Think{Space} 
Else IfEqual key0, THVN, Send Haven't{Space} 
Else IfEqual key0, TI, Send It{Space} 
Else IfEqual key0, TIAGH, Send Aight{Space} 
Else IfEqual key0, TIALN, Send Initial{Space} 
Else IfEqual key0, TIAN, Send Anti
Else IfEqual key0, TIB, Send Bit{Space} 
Else IfEqual key0, TID, Send It'd{Space} 
Else IfEqual key0, TIDM, Send Immediate{Space} 
Else IfEqual key0, TIDN, Send Didn't{Space} 
Else IfEqual key0, TIGH, Send Tight{Space} 
Else IfEqual key0, TIGHL, Send Light{Space} 
Else IfEqual key0, TIGHN, Send Night{Space} 
Else IfEqual key0, TIGN, Send Interesting{Space} 
Else IfEqual key0, TIH, Send I Think{Space} 
Else IfEqual key0, TIHC, Send Itch{Space} 
Else IfEqual key0, TIHKN, Send Think{Space} 
Else IfEqual key0, TILN, Send Internal{Space} 
Else IfEqual key0, TIN, Send Interest{Space} 
Else IfEqual key0, TIO, Send In Terms Of{Space} 
Else IfEqual key0, TIOLN, Send International{Space} 
Else IfEqual key0, TION, Send Into{Space} 
Else IfEqual key0, TIOPSN, Send Position{Space} 
Else IfEqual key0, TIS, Send It's{Space} 
Else IfEqual key0, TISDCN, Send Distinct{Space} 
Else IfEqual key0, TISGH, Send Sight{Space} 
Else IfEqual key0, TISH, Send This{Space} 
Else IfEqual key0, TISH, Send This{Space} 
Else IfEqual key0, TISKC, Send Stick{Space} 
Else IfEqual key0, TISL, Send Still{Space} 
Else IfEqual key0, TISN, Send Instead{Space} 
Else IfEqual key0, TIVN, Send Interview{Space} 
Else IfEqual key0, TIZ, Send Ization
Else IfEqual key0, TK, Send Take{Space} 
Else IfEqual key0, TKL, Send Talk{Space} 
Else IfEqual key0, TKM, Send Market{Space} 
Else IfEqual key0, TLB, Send Built{Space} 
Else IfEqual key0, TLCN, Send Technical{Space} 
Else IfEqual key0, TLNM, Send Mental{Space} 
Else IfEqual key0, TLXN, Send Excellent{Space} 
Else IfEqual key0, TM, Send Time{Space} 
Else IfEqual key0, TNM, Send Minute{Space} 
Else IfEqual key0, TO, Send To{Space} 
Else IfEqual key0, TO, Send Too{Space} 
Else IfEqual key0, TOACN, Send Contact{Space} 
Else IfEqual key0, TOAHL, Send Although{Space} 
Else IfEqual key0, TOAL, Send Total{Space} 
Else IfEqual key0, TOBM, Send Bottom{Space} 
Else IfEqual key0, TOCN, Send Contract{Space} 
Else IfEqual key0, TODL, Send Told{Space} 
Else IfEqual key0, TODN, Send Don't{Space} 
Else IfEqual key0, TOG, Send Got{Space} 
Else IfEqual key0, TOH, Send Though{Space} 
Else IfEqual key0, TOHB, Send Both{Space} 
Else IfEqual key0, TOHNM, Send Month{Space} 
Else IfEqual key0, TOK, Send Took{Space} 
Else IfEqual key0, TOL, Send Lot{Space} 
Else IfEqual key0, TON, Send Not{Space} 
Else IfEqual key0, TON, Send Not{Space} 
Else IfEqual key0, TOP, Send Top{Space} 
Else IfEqual key0, TOPAD, Send Adopt{Space} 
Else IfEqual key0, TOPH, Send Photo{Space} 
Else IfEqual key0, TOPS, Send Stop{Space} 
Else IfEqual key0, TOPZM, Send Optimize{Space} 
Else IfEqual key0, TOSC, Send Cost{Space} 
Else IfEqual key0, TOSL, Send Lost{Space} 
Else IfEqual key0, TOSM, Send Most{Space} 
Else IfEqual key0, TP, Send Point{Space} 
Else IfEqual key0, TPAFLM, Send Platform{Space} 
Else IfEqual key0, TPALN, Send Plant{Space} 
Else IfEqual key0, TPAS, Send Past{Space} 
Else IfEqual key0, TPC, Send Corporate{Space} 
Else IfEqual key0, TPCNM, Send Component{Space} 
Else IfEqual key0, TPD, Send Department{Space} 
Else IfEqual key0, TPLM, Send Multiple{Space} 
Else IfEqual key0, TPLN, Send Potential{Space} 
Else IfEqual key0, TPS, Send Post{Space} 
Else IfEqual key0, TPSN, Send Postpone{Space} 
Else IfEqual key0, TPSV, Send Positive{Space} 
Else IfEqual key0, TS, Send Its{Space} 
Else IfEqual key0, TS, Send St
Else IfEqual key0, TSDN, Send Doesn't{Space} 
Else IfEqual key0, TSFGN, Send Significant{Space} 
Else IfEqual key0, TSG, Send Things{Space} 
Else IfEqual key0, TSDHN, Send Shouldn't{Space} 
Else IfEqual key0, TSKM, Send Mistake{Space} 
Else IfEqual key0, TSL, Send List{Space} 
Else IfEqual key0, TSLN, Send Listen{Space} 
Else IfEqual key0, TSLVM, Send Themselves{Space} 
Else IfEqual key0, TSM, Send Sometimes{Space} 
Else IfEqual key0, TSN, Send Essentially{Space} 
Else IfEqual key0, TUA, Send Uation
Else IfEqual key0, TUAGH, Send Taught{Space} 
Else IfEqual key0, TUALC, Send Actual{Space} 
Else IfEqual key0, TUB, Send But{Space} 
Else IfEqual key0, TUC, Send Cut{Space} 
Else IfEqual key0, TUILN, Send Until{Space} 
Else IfEqual key0, TUIOASN, Send Situation{Space} 
Else IfEqual key0, TUIPDLC, Send Duplicate{Space} 
Else IfEqual key0, TUL, Send Ultimately{Space} 
Else IfEqual key0, TUO, Send Out{Space} 
Else IfEqual key0, TUOA, Send Auto{Space} 
Else IfEqual key0, TUOACN, Send Account{Space} 
Else IfEqual key0, TUOBN, Send Button{Space} 
Else IfEqual key0, TUOCN, Send Count{Space} 
Else IfEqual key0, TUOHC, Send Touch{Space} 
Else IfEqual key0, TUOHM, Send Mouth{Space} 
Else IfEqual key0, TUOSCM, Send Custom{Space} 
Else IfEqual key0, TUP, Send Put{Space} 
Else IfEqual key0, TUSF, Send Stuff{Space} 
Else IfEqual key0, TUSM, Send Must{Space} 
Else IfEqual key0, TXC, Send Context{Space} 
Else IfEqual key0, TY, Send Thank You{Space} 
Else IfEqual key0, TYAS, Send Stay{Space} 
Else IfEqual key0, TYASLV, Send Vastly{Space} 
Else IfEqual key0, TYD, Send Today{Space} 
Else IfEqual key0, TYIACV, Send Activity{Space} 
Else IfEqual key0, TYIALB, Send Ability{Space} 
Else IfEqual key0, TYIDN, Send Identity{Space} 
Else IfEqual key0, TYIK, Send Kitty{Space} 
Else IfEqual key0, TYIL, Send Ility{Space} 
Else IfEqual key0, TYILB, Send Ibility{Space} 
Else IfEqual key0, TYO, Send Toy{Space} 
Else IfEqual key0, TYOAL, Send Totally{Space} 
Else IfEqual key0, TYPHLC, Send Hypothetical{Space} 
Else IfEqual key0, TYPLC, Send Typical{Space} 
Else IfEqual key0, TYVM, Send Thank You Very Much{Space} 
Else IfEqual key0, TOAGHC, Send Got You.{Space} 
Else IfEqual key0, TPAH, Send Path{Space} 
Else IfEqual key0, TSC, Send Society{Space} 
Else IfEqual key0, TSLVM, Send Themselves{Space} 
Else IfEqual key0, TUIASN, Send Sustain{Space} 
Else IfEqual key0, TUIOSN, Send Institution{Space} 
Else IfEqual key0, TUOGH, Send Thought{Space} 
Else IfEqual key0, TVN, Send Native{Space} 
Else IfEqual key0, TYIC, Send City{Space} 
Return
SENDYup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, YAD, Send Day{Space} 
Else IfEqual key0, YUGL, Send Ugly{Space} 
Else IfEqual key0, TYSG, Send Staying{Space} 
Else IfEqual key0, EYAGCN, Send Agency{Space} 
Else IfEqual key0, YADBN, Send Anybody{Space} 
Else IfEqual key0, YDGB, Send Goodbye{Space} 
Else IfEqual key0, YPG, Send Paying{Space} 
 Else IfEqual key0, YDVN, Send Vineyard{Space} 
Else IfEqual key0, YCVN, Send Convey{Space} 
Else IfEqual key0, YFL, Send Fly{Space} 
Else IfEqual key0, YOHL, Send Holy{Space} 
Else IfEqual key0, YOPH, Send Hypo
Else IfEqual key0, YSLN, Send Analysis{Space} 
Else IfEqual key0, YUDB, Send Buddy{Space} 
Else IfEqual key0, YUSG, Send Guys{Space} 
Else IfEqual key0, YAB, Send Baby{Space} 
Else IfEqual key0, YOGLCN, Send Oncology{Space} 
Else IfEqual key0, YPAL, Send Play{Space} 
Else IfEqual key0, YSNM, Send Mayonnaise{Space} 
Else IfEqual key0, YUJL, Send July{Space} 
Else IfEqual key0, YOPC, Send Copy{Space} 
Else IfEqual key0, YPSHCN, Send Physician{Space} 
Else IfEqual key0, YAM, Send May{Space} 
Else IfEqual key0, YGLCN, Send Oncology{Space} 
Else IfEqual key0, YOGLCN, Send Oncology{Space} 
Else IfEqual key0, YDBN, Send Beyond{Space} 
Else IfEqual key0, YOJ, Send Joy{Space} 
Else IfEqual key0, YPSHLC, Send Physical{Space} 
Else IfEqual key0, YAN, Send Any{Space} 
Else IfEqual key0, YANM, Send Many{Space} 
Else IfEqual key0, YAS, Send Say{Space} 
Else IfEqual key0, YASG, Send Saying{Space} 
Else IfEqual key0, YB, Send By{Space} 
Else IfEqual key0, YD, Send Yesterday{Space} 
Else IfEqual key0, YFLN, Send Finally{Space} 
Else IfEqual key0, YIADL, Send Daily{Space} 
Else IfEqual key0, YIAFLM, Send Family{Space} 
Else IfEqual key0, YIASLN, Send Analysis{Space} 
Else IfEqual key0, YIF, Send Ify{Space} 
Else IfEqual key0, YK, Send You Know{Space} 
Else IfEqual key0, YM, Send My{Space} 
Else IfEqual key0, YOAN, Send Annoy{Space} 
Else IfEqual key0, YOANM, Send Anymore{Space} 
Else IfEqual key0, YOB, Send Boy{Space} 
Else IfEqual key0, YODB, Send Body{Space} 
Else IfEqual key0, YOLN, Send Only{Space} 
Else IfEqual key0, YPA, Send Pay{Space} 
Else IfEqual key0, YPAH, Send Happy{Space} 
Else IfEqual key0, YPAL, Send Play{Space} 
Else IfEqual key0, YPCM, Send Completely{Space} 
Else IfEqual key0, YSDA, Send Days{Space} 
Else IfEqual key0, YSG, Send Saying{Space} 
Else IfEqual key0, YSM, Send Sym
Else IfEqual key0, YSN, Send Syn
Else IfEqual key0, YUASL, Send Usually{Space} 
Else IfEqual key0, YUB, Send Buy{Space} 
Else IfEqual key0, YUG, Send Guy{Space} 
Else IfEqual key0, YUOGN, Send Young{Space} 
Else IfEqual key0, YAL, Send Lay{Space} 
Else IfEqual key0, YUFN, Send Funny{Space} 
Else IfEqual key0, YUSB, Send Busy{Space} 
Return
SENDUup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, UA, Send Au
Else IfEqual key0, UAB, Send A Bunch{Space} 
Else IfEqual key0, UAHNM, Send Human{Space} 
Else IfEqual key0, UASDHBN, Send Husband{Space} 
Else IfEqual key0, UINM, Send Minimum{Space} 
Else IfEqual key0, UIOLCN, Send Council{Space} 
Else IfEqual key0, UODBN, Send Bound{Space} 
Else IfEqual key0, UODC, Send Docu
Else IfEqual key0, UAHLCN, Send Launch{Space} 
Else IfEqual key0, UASHBN, Send Husband{Space} 
Else IfEqual key0, UDH, Send Duh{Space} 
Else IfEqual key0, UGN, Send Gun{Space} 
Else IfEqual key0, UHCBN, Send Bunch{Space} 
Else IfEqual key0, UIOAC, Send Caution{Space} 
Else IfEqual key0, UPBM, Send Bump{Space} 
Else IfEqual key0, UANM, Send Manu{Space} 
Else IfEqual key0, UFKC, Send Fuck{Space} 
Else IfEqual key0, UKLC, Send Luck{Space} 
Else IfEqual key0, UISDC, Send Discuss{Space} 
Else IfEqual key0, USG, Send Using{Space} 
Else IfEqual key0, USGN, Send Sung{Space} 
Else IfEqual key0, UALBM, Send Albums{Space} 
Else IfEqual key0, UIOSL, Send Solution{Space} 
Else IfEqual key0, UAD, Send Audience{Space} 
Else IfEqual key0, UAG, Send Aug{Space} 
Else IfEqual key0, UAGHL, Send Laugh{Space} 
Else IfEqual key0, UAGL, Send Laugh{Space} 
Else IfEqual key0, UAHLCN, Send Launch{Space} 
Else IfEqual key0, UASL, Send Usual{Space} 
Else IfEqual key0, UCM, Send Communicate{Space} 
Else IfEqual key0, UD, Send You'd{Space} 
Else IfEqual key0, UDN, Send Understand{Space} 
Else IfEqual key0, UFL, Send Full{Space} 
Else IfEqual key0, UHCM, Send Much{Space} 
Else IfEqual key0, UICM, Send Communication{Space} 
Else IfEqual key0, UIOCM, Send Communication{Space} 
Else IfEqual key0, UIDN, Send Industry{Space} 
Else IfEqual key0, UIN, Send Uni
Else IfEqual key0, UIOFCN, Send Function{Space} 
Else IfEqual key0, UIOS, Send Ious
Else IfEqual key0, UIOSCN, Send Conscious{Space} 
Else IfEqual key0, UIOSLCN, Send Conclusion{Space} 
Else IfEqual key0, UIPDL, Send Dupli{Space} 
Else IfEqual key0, UISCM, Send Music{Space} 
Else IfEqual key0, UISN, Send Insurance{Space} 
Else IfEqual key0, UIVN, Send University{Space} 
Else IfEqual key0, UL, Send You'll{Space} 
Else IfEqual key0, UN, Send Un
Else IfEqual key0, UNM, Send Number{Space} 
Else IfEqual key0, UO, Send Ou
Else IfEqual key0, UODFN, Send Found{Space} 
Else IfEqual key0, UODL, Send Loud{Space} 
Else IfEqual key0, UODLC, Send Cloud{Space} 
Else IfEqual key0, UOGH, Send Ough{Space} 
Else IfEqual key0, UOP, Send Population{Space} 
Else IfEqual key0, UOPN, Send Upon{Space} 
Else IfEqual key0, UOSDN, Send Sound{Space} 
Else IfEqual key0, UOSFC, Send Focus{Space} 
Else IfEqual key0, UOSM, Send So Much{Space} 
Else IfEqual key0, UP, Send Up{Space} 
Else IfEqual key0, UPASCM, Send Campus{Space} 
Else IfEqual key0, UPC, Send Computer{Space} 
Else IfEqual key0, UPJM, Send Jump{Space} 
Else IfEqual key0, UPL, Send Pull{Space} 
Else IfEqual key0, UPSH, Send Push{Space} 
Else IfEqual key0, US, Send Us{Space} 
Else IfEqual key0, USB, Send Sub
Else IfEqual key0, USF, Send Yourself{Space} 
Else IfEqual key0, USHC, Send Such{Space} 
Else IfEqual key0, USN, Send Sun{Space} 
Else IfEqual key0, UV, Send You've{Space} 
Else IfEqual key0, UDFN, Send Fund{Space} 
Else IfEqual key0, UFN, Send Fun{Space} 
Else IfEqual key0, USFL, Send Yourself{Space} 
Return
SENDEup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, EA, Send Ea	
Else IfEqual key0, EPALCB, Send Capable{Space} 
Else IfEqual key0, ERIV, Send River{Space} 
Else IfEqual key0, ERUIPM, Send Premium{Space} 
Else IfEqual key0, ETF, Send Feet{Space} 
Else IfEqual key0, ERTYPAH, Send Therapy{Space} 
Else IfEqual key0, ERIACM, Send America{Space} 
Else IfEqual key0, ERUOP, Send Europe{Space} 
Else IfEqual key0, EOSLN, Send Lesson{Space} 
Else IfEqual key0, EPALN, Send Plane{Space} 
Else IfEqual key0, EALCN, Send Cancel{Space} 
Else IfEqual key0, EPASLC, Send Places{Space} 
Else IfEqual key0, EALN, Send Lane{Space} 
Else IfEqual key0, ETPASLN, Send Pleasant{Space} 
Else IfEqual key0, EAS, Send Assess{Space} 
Else IfEqual key0, ERUIPS, Send Surprise{Space} 
Else IfEqual key0, EASF, Send Safety{Space} 
Else IfEqual key0, EFHC, Send Chef{Space} 
Else IfEqual key0, ERUALCN, Send Nuclear{Space} 
Else IfEqual key0, EIALV, Send Alive{Space} 
Else IfEqual key0, EYIASL, Send Easily{Space} 
Else IfEqual key0, EIASN, Send Insane{Space} 
Else IfEqual key0, EIFKN, Send Knife{Space} 
Else IfEqual key0, EIHCN, Send Niche{Space} 
Else IfEqual key0, EIHK, Send Hike{Space} 
Else IfEqual key0, EIL, Send Lie{Space} 
Else IfEqual key0, EIL, Send Lie{Space} 
Else IfEqual key0, EILCN, Send Incline{Space} 
Else IfEqual key0, EIOCNM, Send Economic{Space} 
Else IfEqual key0, EIOCNM, Send Income{Space} 
Else IfEqual key0, EIPLCN, Send Pencil{Space} 
Else IfEqual key0, EISDL, Send Slide{Space} 
Else IfEqual key0, EISKVN, Send Knives{Space} 
Else IfEqual key0, EISLM, Send Smile{Space} 
Else IfEqual key0, EISZ, Send Seize{Space} 
Else IfEqual key0, EKN, Send Knee{Space} 
Else IfEqual key0, ELB, Send Bell{Space} 
Else IfEqual key0, EOADB, Send Adobe{Space} 
Else IfEqual key0, EOASLM, Send Molasses{Space} 
Else IfEqual key0, EOFC, Send Coffee{Space} 
Else IfEqual key0, EOSDCN, Send Condense{Space} 
Else IfEqual key0, EOSLN, Send Lesson{Space} 
Else IfEqual key0, EOSN, Send Nose{Space} 
Else IfEqual key0, EPA, Send Ape{Space} 
Else IfEqual key0, EPN, Send Pen{Space} 
Else IfEqual key0, EPSL, Send Spell{Space} 
Else IfEqual key0, ERAB, Send Bear{Space} 
Else IfEqual key0, ERADG, Send Regard{Space} 
Else IfEqual key0, ERADLC, Send Declare{Space} 
Else IfEqual key0, ERAF, Send Fear{Space} 
Else IfEqual key0, ERAF, Send Fear{Space} 
Else IfEqual key0, ERALX, Send Relax{Space} 
Else IfEqual key0, ERAS, Send Erase{Space} 
Else IfEqual key0, ERDCBM, Send December{Space} 
Else IfEqual key0, ERF, Send Refer{Space} 
Else IfEqual key0, ERHC, Send Cheer{Space} 
Else IfEqual key0, ERIAS, Send Raise{Space} 
Else IfEqual key0, ERIDB, Send Bride{Space} 
Else IfEqual key0, ERIDGB, Send Bridge{Space} 
Else IfEqual key0, ERIDL, Send Riddle{Space} 
Else IfEqual key0, ERIN, Send Inner{Space} 
Else IfEqual key0, ERIOPSCM, Send Comprise{Space} 
Else IfEqual key0, ERIPSCB, Send Prescribe{Space} 
Else IfEqual key0, ERM, Send Mere{Space} 
Else IfEqual key0, ERO, Send Error{Space} 
Else IfEqual key0, EROASH, Send Hoarse{Space} 
Else IfEqual key0, EROCM, Send Commerce{Space} 
Else IfEqual key0, EROKB, Send Broke{Space} 
Else IfEqual key0, EROS, Send Rose{Space} 
Else IfEqual key0, EROSCN, Send Censor{Space} 
Else IfEqual key0, EROVBNM, Send November{Space} 
Else IfEqual key0, ERPAS, Send Spare{Space} 
Else IfEqual key0, ERTAG, Send Target{Space} 
Else IfEqual key0, ERTAGN, Send Generate{Space} 
Else IfEqual key0, ERTIACN, Send Interact{Space} 
Else IfEqual key0, ERTIAGC, Send Cigarette{Space} 
Else IfEqual key0, ERTIHN, Send Inherent{Space} 
Else IfEqual key0, ERTION, Send Orient{Space} 
Else IfEqual key0, ERTIPAC, Send Practice{Space} 
Else IfEqual key0, ERTOA, Send Rotate{Space} 
Else IfEqual key0, ERTOCB, Send October{Space} 
Else IfEqual key0, ERTOSK, Send Stroke{Space} 
Else IfEqual key0, ERTPSBM, Send September{Space} 
Else IfEqual key0, ERTUANM, Send Remunerate{Space} 
Else IfEqual key0, ERTYCM, Send Cemetery{Space} 
Else IfEqual key0, ERTYOP, Send Property{Space} 
Else IfEqual key0, ERUD, Send Educator{Space} 
Else IfEqual key0, ERUDBN, Send Burden{Space} 
Else IfEqual key0, ERUIN, Send Urine{Space} 
Else IfEqual key0, ERUOPCN, Send Pronounce{Space} 
Else IfEqual key0, ERUSC, Send Rescue{Space} 
Else IfEqual key0, ERUVN, Send Revenue{Space} 
Else IfEqual key0, ERYOASC, Send Accessory{Space} 
Else IfEqual key0, ESHCM, Send Scheme{Space} 
Else IfEqual key0, ESLM, Send Smell{Space} 
Else IfEqual key0, ETADN, Send Attend{Space} 
Else IfEqual key0, ETAGN, Send Agent{Space} 
Else IfEqual key0, ETAGN, Send Tangent{Space} 
Else IfEqual key0, ETALN, Send Talent{Space} 
Else IfEqual key0, ETANM, Send Meant{Space} 
Else IfEqual key0, ETASK, Send Stake{Space} 
Else IfEqual key0, ETGHLN, Send Length{Space} 
Else IfEqual key0, ETIAHLCN, Send Technical{Space} 
Else IfEqual key0, ETIOANM, Send Nominate{Space} 
Else IfEqual key0, ETIOSN, Send Tension{Space} 
Else IfEqual key0, ETIOSN, Send Tension{Space} 
Else IfEqual key0, ETOLB, Send Bottle{Space} 
Else IfEqual key0, ETOLB, Send Bottle{Space} 
Else IfEqual key0, ETOSHLC, Send Clothes{Space} 
Else IfEqual key0, ETPAL, Send Plate{Space} 
Else IfEqual key0, ETPASC, Send Aspect{Space} 
Else IfEqual key0, ETPS, Send Steep{Space} 
Else IfEqual key0, ETSCN, Send Sentence{Space} 
Else IfEqual key0, ETUB, Send Tube{Space} 
Else IfEqual key0, ETUHC, Send Chute{Space} 
Else IfEqual key0, ETUM, Send Mute{Space} 
Else IfEqual key0, ETUOCM, Send Outcome{Space} 
Else IfEqual key0, ETUPS, Send Upset{Space} 
Else IfEqual key0, ETYOSCM, Send Ecosystem{Space} 
Else IfEqual key0, EUDGJ, Send Judge{Space} 
Else IfEqual key0, EUDGN, Send Nudge{Space} 
Else IfEqual key0, EUJN, Send June{Space} 
Else IfEqual key0, EUPSL, Send Pulse{Space} 
Else IfEqual key0, EYAGCN, Send Agency{Space} 
Else IfEqual key0, EYP, Send Yep{Space} 
Else IfEqual key0, RTYL, Send Reality{Space} 
Else IfEqual key0, ETANM, Send Meant{Space} 
Else IfEqual key0, EASN, Send Sane{Space} 
Else IfEqual key0, EIASN, Send Insane{Space} 
Else IfEqual key0, EPSD, Send Sped{Space} 
Else IfEqual key0, ETUN, Send Tune{Space} 
Else IfEqual key0, EROFC, Send Force{Space} 
Else IfEqual key0, ETIOASC, Send Associate{Space} 
Else IfEqual key0, EIONM, Send Mention{Space} 
Else IfEqual key0, EYH, Send Hey{Space} 
Else IfEqual key0, EYP, Send Yep{Space} 
Else IfEqual key0, EODCNM, Send Commend{Space} 
Else IfEqual key0, ETISN, Send Intense{Space} 
Else IfEqual key0, ERUIOS, Send Capable{Space} 
Else IfEqual key0, EUALVB, Send Valuable{Space} 
Else IfEqual key0, ETIAGVN, Send Navigate{Space} 
Else IfEqual key0, ERASC, Send Scare{Space} 
Else IfEqual key0, ERTOM, Send Remote{Space} 
Else IfEqual key0, ERTLXN, Send Internal{Space} 
Else IfEqual key0, EROPSC, Send Process{Space} 
Else IfEqual key0, EACBM, Send Became{Space} 
Else IfEqual key0, EAGHLCN, Send Challenge{Space} 
Else IfEqual key0, ETAKN, Send Taken{Space} 
Else IfEqual key0, ETPAM, Send Attempt{Space} 
Else IfEqual key0, EIVN, Send Vein{Space} 
Else IfEqual key0, ERPASH, Send Phrase{Space} 
Else IfEqual key0, ERTPASN, Send Transparent{Space} 
Else IfEqual key0, EAD, Send Dead{Space} 
Else IfEqual key0, EADHLN, Send Handle{Space} 
Else IfEqual key0, EAGBN, Send Began{Space} 
Else IfEqual key0, EASHK, Send Shake{Space} 
Else IfEqual key0, EDCVN, Send Evidence{Space} 
Else IfEqual key0, EIASD, Send Disease{Space} 
Else IfEqual key0, EIASL, Send Aisle{Space} 
Else IfEqual key0, EIHLCV, Send Vehicle{Space} 
Else IfEqual key0, EILM, Send Mile{Space} 
Else IfEqual key0, EIOM, Send Emotion{Space} 
Else IfEqual key0, EISDN, Send Inside{Space} 
Else IfEqual key0, EISHN, Send Shine{Space} 
Else IfEqual key0, EISLCN, Send Silence{Space} 
Else IfEqual key0, EAKL, Send Lake{Space} 
Else IfEqual key0, EOALN, Send Alone{Space} 
Else IfEqual key0, EOCVN, Send Convene{Space} 
Else IfEqual key0, EODGL, Send Lodge{Space} 
Else IfEqual key0, EOLCN, Send Clone{Space} 
Else IfEqual key0, EOLNM, Send Lemon{Space} 
Else IfEqual key0, EOLNM, Send Melon{Space} 
Else IfEqual key0, EOPK, Send Poke{Space} 
Else IfEqual key0, EOSLV, Send Solve{Space} 
Else IfEqual key0, EOSLV, Send Solve{Space} 
Else IfEqual key0, EPAHC, Send Cheap{Space} 

Else IfEqual key0, ERADG, Send Grade{Space} 
Else IfEqual key0, ERAFM, Send Frame{Space} 
Else IfEqual key0, ERAGHC, Send Charge{Space} 
Else IfEqual key0, ERAGNM, Send Manager{Space} 
Else IfEqual key0, ERC, Send Rec Recognize{Space} 
Else IfEqual key0, ERDH, Send Herd{Space} 
Else IfEqual key0, ERGCNM, Send Emergency{Space} 
Else IfEqual key0, ERGM, Send Merge{Space} 
Else IfEqual key0, ERIAL, Send Earlier{Space} 
Else IfEqual key0, ERIALCM, Send Miracle{Space} 
Else IfEqual key0, ERIF, Send Fire{Space} 
Else IfEqual key0, ERIOSN, Send Senior{Space} 
Else IfEqual key0, ERIPL, Send Ripple{Space} 
Else IfEqual key0, ERIPLCN, Send Principle{Space} 
Else IfEqual key0, ERIPSN, Send Inspire{Space} 
Else IfEqual key0, ERLV, Send Lever{Space} 
Else IfEqual key0, EROC, Send Core{Space} 
Else IfEqual key0, EROC, Send Core{Space} 
Else IfEqual key0, EROH, Send Hero{Space} 
Else IfEqual key0, EROHL, Send Holler{Space} 
Else IfEqual key0, EROSC, Send Score{Space} 
Else IfEqual key0, EROSLC, Send Closer{Space} 
Else IfEqual key0, ERTA, Send Tear{Space} 
Else IfEqual key0, ERTAD, Send Trade{Space} 
Else IfEqual key0, ERTD, Send Editor{Space} 
Else IfEqual key0, ERTIHN, Send Neither{Space} 
Else IfEqual key0, ERTILC, Send Electric{Space} 
Else IfEqual key0, ERTIOD, Send Editor{Space} 
Else IfEqual key0, ERTIPAC, Send Practice{Space} 
Else IfEqual key0, ERTIPAC, Send Practice{Space} 
Else IfEqual key0, ERTISH, Send Theirs{Space} 
Else IfEqual key0, ERTJC, Send Reject{Space} 
Else IfEqual key0, ERTLC, Send Electric{Space} 
Else IfEqual key0, ERTOFGN, Send Forgotten{Space} 
Else IfEqual key0, ERTPVN, Send Prevent{Space} 
Else IfEqual key0, ERTUIC, Send Recruit{Space} 
Else IfEqual key0, ERTUL, Send Turtle{Space} 
Else IfEqual key0, ERTUN, Send Return{Space} 
Else IfEqual key0, ERTUO, Send Route{Space} 
Else IfEqual key0, ERUAG, Send Argue{Space} 
Else IfEqual key0, ERUAS, Send Assure{Space} 
Else IfEqual key0, ERUBM, Send Bummer{Space} 
Else IfEqual key0, ERUOSLCN, Send Counselor{Space} 
Else IfEqual key0, ERUOSVN, Send Nervous{Space} 
Else IfEqual key0, ERUSN, Send Nurse{Space} 
Else IfEqual key0, ESHL, Send Shell{Space} 
Else IfEqual key0, ETAS, Send State{Space} 
Else IfEqual key0, ETB, Send Bet{Space} 
Else IfEqual key0, ETB, Send Bet{Space} 
Else IfEqual key0, ETDN, Send Tend{Space} 
Else IfEqual key0, ETFCN, Send Efficient{Space} 
Else IfEqual key0, ETFCN, Send Efficient{Space} 
Else IfEqual key0, ETIHKCN, Send Kitchen{Space} 
Else IfEqual key0, ETION, Send Intention{Space} 
Else IfEqual key0, ETIONM, Send Emotion{Space} 
Else IfEqual key0, ETIPDN, Send Independent{Space} 
Else IfEqual key0, ETISLN, Send Nationalities{Space} 
Else IfEqual key0, ETLVT, Send Evaluate{Space} 
Else IfEqual key0, ETOP, Send Poet{Space} 
Else IfEqual key0, ETPALN, Send Planet{Space} 
Else IfEqual key0, ETPXM, Send Exempt{Space} 
Else IfEqual key0, ETSG, Send Setting{Space} 
Else IfEqual key0, ETSG, Send Gets{Space} 
Else IfEqual key0, ETSLN, Send Essential{Space} 
Else IfEqual key0, ETUALV, Send Evaluate{Space} 
Else IfEqual key0, ETUASCBN, Send Substance{Space} 
Else IfEqual key0, ETUISN, Send Institute{Space} 
Else IfEqual key0, ETYPLN, Send Plenty{Space} 
Else IfEqual key0, EUAG, Send Gauge{Space} 
Else IfEqual key0, EUAGV, Send Vague{Space} 
Else IfEqual key0, EUASB, Send Abuse{Space} 
Else IfEqual key0, EUH, Send Hue{Space} 
Else IfEqual key0, EUIFLCN, Send Influence{Space} 
Else IfEqual key0, EUISDC, Send Suicide{Space} 
Else IfEqual key0, EUOSLCN, Send Counsel{Space} 
Else IfEqual key0, EUPDL, Send Puddle{Space} 
Else IfEqual key0, EY, Send Eye{Space} 
Else IfEqual key0, EYADL, Send Delay{Space} 
Else IfEqual key0, EYIAFC, Send Efficacy{Space} 
Else IfEqual key0, EYL, Send Yell{Space} 
Else IfEqual key0, EYOCVN, Send Convey{Space} 	
Else IfEqual key0, ERPISN, Send Inspire{Space} 
Else IfEqual key0, EOPSK, Send Spoke{Space} 
Else IfEqual key0, EPAL, Send Leap{Space} 
Else IfEqual key0, EPDXN, Send Expend{Space} 
Else IfEqual key0, ERIAV, Send Arrive{Space} 
Else IfEqual key0, EROP, Send Proper{Space} 
Else IfEqual key0, ERPDC, Send Deprec{Space} 
Else IfEqual key0, ERTIPN, Send Interpret{Space} 
Else IfEqual key0, ERTUIPN, Send Interrupt{Space} 
Else IfEqual key0, ETIALNM, Send Eliminate{Space} 
Else IfEqual key0, ETIASCN, Send Instance{Space} 
Else IfEqual key0, ETISCN, Send Scientist{Space} 
Else IfEqual key0, ETIVN, Send Invite{Space} 
Else IfEqual key0, ERUOPD, Send Produce{Space} 
Else IfEqual key0, EACM, Send Came{Space} 	
Else IfEqual key0, EADCN, Send Dance{Space} 	
Else IfEqual key0, ERUDM, Send Drummer{Space} 
Else IfEqual key0, EASFL, Send False{Space} 
Else IfEqual key0, EASL, Send Sale{Space} 
Else IfEqual key0, EASLC, Send Scale{Space} 
Else IfEqual key0, EDG, Send Edge{Space} 
Else IfEqual key0, EFB, Send Beef{Space} 
Else IfEqual key0, EICV, Send Vice{Space} 
Else IfEqual key0, EIDV, Send Dive{Space} 
Else IfEqual key0, EIGN, Send Engine{Space} 
Else IfEqual key0, EINM, Send Mine{Space} 
Else IfEqual key0, EIOCVN, Send Convince{Space} 
Else IfEqual key0, EIOSN, Send Session{Space} 
Else IfEqual key0, ELC, Send Cell{Space} 
Else IfEqual key0, EOHN, Send Hone{Space} 
Else IfEqual key0, ERADM, Send Dream{Space} 

Else IfEqual key0, ERASD, Send Address{Space} 
Else IfEqual key0, ERDG, Send Degree{Space} 
Else IfEqual key0, ERGCN, Send Encourage{Space} 

Else IfEqual key0, ERIH, Send Hire{Space} 
Else IfEqual key0, ERILC, Send Circle{Space} 
Else IfEqual key0, ERPSCN, Send Presence{Space} 
Else IfEqual key0, ERTI, Send Tire{Space} 
Else IfEqual key0, ERTIPAC, Send Practice{Space} 
Else IfEqual key0, ERTLCN, Send Electronic{Space} 
Else IfEqual key0, ERTOCN, Send Concert{Space} 
Else IfEqual key0, ERTOF, Send Effort{Space} 
Else IfEqual key0, ERTOPC, Send Protect{Space} 
Else IfEqual key0, ERTPX, Send Expert{Space} 
Else IfEqual key0, ERTUION, Send Routine{Space} 
Else IfEqual key0, ERTUO, Send Route{Space} 
Else IfEqual key0, ERUOSC, Send Course{Space} 
Else IfEqual key0, ERUOSC, Send Course{Space} 
Else IfEqual key0, ERUSC, Send Secure{Space} 
Else IfEqual key0, ERUSC, Send Secure{Space} 
Else IfEqual key0, ERYL, Send Rely{Space} 
Else IfEqual key0, ESCN, Send Scene{Space} 
Else IfEqual key0, ESG, Send Seeing{Space} 
Else IfEqual key0, ETAB, Send Beat{Space} 
Else IfEqual key0, ETAD, Send Date{Space} 
Else IfEqual key0, ETAD, Send Date{Space} 
Else IfEqual key0, ETADH, Send Death{Space} 
Else IfEqual key0, ETALM, Send Metal{Space} 
Else IfEqual key0, ETFH, Send Theft{Space} 
Else IfEqual key0, ETIADC, Send Dictate{Space} 
Else IfEqual key0, ETIN, Send Intent{Space} 
Else IfEqual key0, ETIOCM, Send Committee{Space} 
Else IfEqual key0, ETIVN, Send Invent{Space} 
Else IfEqual key0, ETOGN, Send Gotten{Space} 
Else IfEqual key0, ETOSCN, Send Consent{Space} 
Else IfEqual key0, ETOV, Send Vote{Space} 
Else IfEqual key0, ETPXC, Send Except{Space} 
Else IfEqual key0, ETUPAD, Send Update{Space} 
Else IfEqual key0, ETY, Send Yet{Space} 
Else IfEqual key0, ETYUAB, Send Beauty{Space} 
Else IfEqual key0, EUAGLN, Send Language{Space} 
Else IfEqual key0, EUASM, Send Assume{Space} 
Else IfEqual key0, EUISDC, Send Suicide{Space} 
Else IfEqual key0, EULB, Send Blue{Space} 
Else IfEqual key0, EUNM, Send Menu{Space} 
Else IfEqual key0, EUNM, Send Menu{Space} 
Else IfEqual key0, EUPAS, Send Pause{Space} 
Else IfEqual key0, ERADCN, Send Dancer{Space} 	
Else IfEqual key0, EAGN, Send Engage{Space} 
Else IfEqual key0, EIOM, Send Emotion{Space} 
Else IfEqual key0, EOAVB, Send Above{Space} 
Else IfEqual key0, EOJK, Send Joke{Space} 
Else IfEqual key0, EPD, Send Deep{Space} 
Else IfEqual key0, ERGN, Send Green{Space} 
Else IfEqual key0, ERIANM, Send Remain{Space} 
Else IfEqual key0, EROPV, Send Prove{Space} 
Else IfEqual key0, ERPF, Send Prefer{Space} 
Else IfEqual key0, ERTAH, Send Heart{Space} 
Else IfEqual key0, ERTAHB, Send Breathe{Space} 
Else IfEqual key0, ERTAN, Send Aren't{Space} 
Else IfEqual key0, ERTIOA, Send Iteration{Space} 
Else IfEqual key0, ERTIOA, Send Iteration{Space} 
Else IfEqual key0, ERTIPAC, Send Practice{Space} 
Else IfEqual key0, ERTPAN, Send Parent{Space} 
Else IfEqual key0, ERYGN, Send Energy{Space} 
Else IfEqual key0, ESDN, Send Send {Space} 
Else IfEqual key0, ETASG, Send Stage{Space} 
Else IfEqual key0, ETASG, Send Stage{Space} 
Else IfEqual key0, ETIOPS, Send Opposite{Space} 
Else IfEqual key0, ETLNM, Send Element{Space} 
Else IfEqual key0, ETOLC, Send Collect{Space} 
Else IfEqual key0, ETON, Send Note{Space} 
Else IfEqual key0, ETUC, Send Cute{Space} 
Else IfEqual key0, ETUSG, Send Suggest{Space} 
Else IfEqual key0, ETVN, Send Event{Space} 
Else IfEqual key0, ETYHD, Send They'd{Space} 
Else IfEqual key0, ETYHL, Send Theyll{Space} 
Else IfEqual key0, EUASC, Send Cause{Space} 
Else IfEqual key0, EUOACN, Send Announce{Space} 
Else IfEqual key0, EUSDC, Send Succeed{Space} 
Else IfEqual key0, EUSDC, Send Succeed{Space} 
Else IfEqual key0, EUSLN, Send Unless{Space} 
Else IfEqual key0, EYOJN, Send Enjoy{Space} 
Else IfEqual key0, EPS, Send Especially{Space} 	
Else IfEqual key0, EADH, Send Head{Space} 		
Else IfEqual key0, EADL, Send Lead{Space} 	
Else IfEqual key0, EADM, Send Made{Space} 	
Else IfEqual key0, EAFC, Send Face{Space} 	
Else IfEqual key0, EAFLM, Send Female{Space} 	
Else IfEqual key0, EAFM, Send Fame{Space} 	
Else IfEqual key0, EAG, Send Age{Space} 	
Else IfEqual key0, EAGHCN, Send Change{Space} 	
Else IfEqual key0, EAGHLCN, Send Challenge{Space} 	
Else IfEqual key0, EAGM, Send Game{Space} 	
Else IfEqual key0, EAGNM, Send Manage{Space} 	
Else IfEqual key0, EAGV, Send Gave{Space} 	
Else IfEqual key0, EAHC, Send Each{Space} 	
Else IfEqual key0, EAHCN, Send Chance{Space} 	
Else IfEqual key0, EAHL, Send Heal{Space} 	
Else IfEqual key0, EAHV, Send Have{Space} 	
Else IfEqual key0, EAKM, Send Make{Space} 	
Else IfEqual key0, EALB, Send Able{Space} 	
Else IfEqual key0, EALCN, Send Clean{Space} 	
Else IfEqual key0, EALM, Send Male{Space} 	
Else IfEqual key0, EALN, Send Lean{Space} 	
Else IfEqual key0, EANM, Send Name{Space} 	
Else IfEqual key0, EASB, Send Base{Space} 	
Else IfEqual key0, EASC, Send Case{Space} 	
Else IfEqual key0, EASDK, Send Asked{Space} 	
Else IfEqual key0, EASF, Send Safe{Space} 	
Else IfEqual key0, EASKM, Send Makes{Space} 	
Else IfEqual key0, EASM, Send Same{Space} 	
Else IfEqual key0, EASV, Send Save{Space} 	
Else IfEqual key0, EB, Send Be{Space} 	
Else IfEqual key0, ECN, Send Necessary{Space}
Else IfEqual key0, EDC, Send Dec{Space} 	
Else IfEqual key0, EDF, Send Definitely{Space} 	
Else IfEqual key0, EDL, Send Led{Space} 	
Else IfEqual key0, EDN, Send Need{Space} 	
Else IfEqual key0, EDN, Send End{Space} 	
Else IfEqual key0, EDV, Send Develop{Space} 	
Else IfEqual key0, EF, Send For Example{Space} 	
Else IfEqual key0, EG, Send Everything{Space} 	
Else IfEqual key0, EGB, Send Being{Space} 	
Else IfEqual key0, EGL, Send Leg{Space} 	
Else IfEqual key0, EH, Send He{Space} 	
Else IfEqual key0, EHKC, Send Check{Space} 	
Else IfEqual key0, EIACVN, Send Vaccine{Space} 	
Else IfEqual key0, EIAD, Send Idea{Space} 	
Else IfEqual key0, EIADM, Send Media{Space} 	
Else IfEqual key0, EIAGNM, Send Imagine{Space} 	
Else IfEqual key0, EIALM, Send Email{Space} 	
Else IfEqual key0, EIC, Send Ice{Space} 
Else IfEqual key0, EICN, Send Nice{Space} 	
Else IfEqual key0, EID, Send Ide	
Else IfEqual key0, EIDC, Send Decide{Space} 	
Else IfEqual key0, EIDFL, Send Field{Space} 	
Else IfEqual key0, EIDFL, Send Field{Space} 	
Else IfEqual key0, EIDFN, Send Define{Space} 	
Else IfEqual key0, EIDLM, Send Middle{Space} 	
Else IfEqual key0, EIDN, Send Indeed{Space} 	
Else IfEqual key0, EIFL, Send Life{Space} 	
Else IfEqual key0, EIGBN, Send Begin{Space} 	
Else IfEqual key0, EIGBN, Send Beginning{Space}
Else IfEqual key0, EILV, Send Live{Space} 	
Else IfEqual key0, EIOCV, Send Voice{Space} 	
Else IfEqual key0, EIODV, Send Video{Space} 	
Else IfEqual key0, EIOFC, Send Office{Space} 	
Else IfEqual key0, EIOHC, Send Choice{Space} 	
Else IfEqual key0, EIOLVN, Send Involve{Space} 	
Else IfEqual key0, EIOSC, Send Section{Space} 	
Else IfEqual key0, EIOSN, Send Noise{Space} 	
Else IfEqual key0, EIP, Send Pipe{Space} 	
Else IfEqual key0, EIPC, Send Piece{Space} 	
Else IfEqual key0, EISCN, Send Since{Space} 	
Else IfEqual key0, EISD, Send Side{Space} 	
Else IfEqual key0, EISGLN, Send Single{Space} 	
Else IfEqual key0, EIV, Send I've{Space}
Else IfEqual key0, EKCN, Send Neck{Space} 	
Else IfEqual key0, ELCN, Send Necessarily{Space} 	
Else IfEqual key0, ELV, Send Level{Space} 	
Else IfEqual key0, EM, Send Me{Space} 	
Else IfEqual key0, EN, Send En	
Else IfEqual key0, EN, Send En	
Else IfEqual key0, ENM, Send Men{Space} 	
Else IfEqual key0, EOASN, Send Season{Space} 	
Else IfEqual key0, EOC, Send Eco{Space} 	
Else IfEqual key0, EOCN, Send Once{Space} 	
Else IfEqual key0, EODC, Send Code{Space} 	
Else IfEqual key0, EODLM, Send Model{Space} 	
Else IfEqual key0, EODN, Send Done{Space} 	
Else IfEqual key0, EOGN, Send Enough{Space} 
Else IfEqual key0, EUOGHN, Send Gone{Space} 	
Else IfEqual key0, EOHL, Send Hole{Space} 	
Else IfEqual key0, EOHM, Send Home{Space} 	
Else IfEqual key0, EOLV, Send Love{Space} 	
Else IfEqual key0, EON, Send One{Space} 	
Else IfEqual key0, EOP, Send People{Space} 	
Else IfEqual key0, EOPDLV, Send Develop{Space} 	
Else IfEqual key0, EOPH, Send Hope{Space} 	
Else IfEqual key0, EOPHN, Send Phone{Space} 	
Else IfEqual key0, EOPN, Send Open{Space} 	
Else IfEqual key0, EOPS, Send Pose{Space} 	
Else IfEqual key0, EOPSHN, Send Phones{Space} 	
Else IfEqual key0, EOSD, Send Does{Space} 	
Else IfEqual key0, EOSG, Send Goes{Space} 	
Else IfEqual key0, EOSH, Send Shoe{Space} 	
Else IfEqual key0, EOSHC, Send Chose{Space} 	
Else IfEqual key0, EOSL, Send Lose{Space} 	
Else IfEqual key0, EOSLC, Send Close{Space} 	
Else IfEqual key0, EOSM, Send Some{Space} 	
Else IfEqual key0, EOV, Send Everyone{Space} 	
Else IfEqual key0, EOZN, Send Zone{Space} 	
Else IfEqual key0, EPAC, Send Pace{Space} 	
Else IfEqual key0, EPAG, Send Page{Space} 	
Else IfEqual key0, EPAK, Send Peak{Space} 	
Else IfEqual key0, EPALC, Send Place{Space} 	
Else IfEqual key0, EPASC, Send Space{Space} 	
Else IfEqual key0, EPASH, Send Shape{Space} 	
Else IfEqual key0, EPASK, Send Speak{Space} 	
Else IfEqual key0, EPASL, Send Please{Space} 	
Else IfEqual key0, EPDN, Send Depend{Space} 	
Else IfEqual key0, EPHL, Send Help{Space} 	
Else IfEqual key0, EPK, Send Keep{Space} 	
Else IfEqual key0, EPSC, Send Spec{Space} 	
Else IfEqual key0, EPSCL, Send Specifically{Space} 	
Else IfEqual key0, EPSDN, Send Spend{Space} 	
Else IfEqual key0, EPSH, Send Sheep{Space} 	
Else IfEqual key0, EPSL, Send Sleep{Space} 	
Else IfEqual key0, EPX, Send Experience{Space}
Else IfEqual key0, ERA, Send Are{Space} 	
Else IfEqual key0, ERAC, Send Care{Space} 	
Else IfEqual key0, ERACM, Send Camera{Space} 	
Else IfEqual key0, ERADFL, Send Federal	
Else IfEqual key0, ERADH, Send Heard{Space} 	
Else IfEqual key0, ERADY, Send Ready{Space} 	
Else IfEqual key0, ERAG, Send Agree{Space} 	
Else IfEqual key0, ERAGH, Send Hearing{Space} 	
Else IfEqual key0, ERAGL, Send Large{Space} 	
Else IfEqual key0, ERAGN, Send Range{Space} 	
Else IfEqual key0, ERAH, Send Hear{Space} 	
Else IfEqual key0, ERAHC, Send Reach{Space} 	
Else IfEqual key0, ERAKB, Send Break{Space} 	
Else IfEqual key0, ERAL, Send Real{Space} 	
Else IfEqual key0, ERALC, Send Clear{Space} 	
Else IfEqual key0, ERALN, Send Learn{Space} 	
Else IfEqual key0, ERAN, Send Near{Space} 	
Else IfEqual key0, ERASH, Send Share{Space} 	
Else IfEqual key0, ERASHC, Send Search{Space} 	
Else IfEqual key0, ERBM, Send Member{Space} 	
Else IfEqual key0, ERF, Send Free{Space} 	
Else IfEqual key0, ERH, Send Her{Space} 	
Else IfEqual key0, ERIAS, Send Raise{Space} 	
Else IfEqual key0, ERIDFN, Send Friend{Space} 	
Else IfEqual key0, ERIDLV, Send Deliver{Space} 	
Else IfEqual key0, ERIDLV, Send Deliver{Space} 	
Else IfEqual key0, ERIDNM, Send Remind{Space} 	
Else IfEqual key0, ERIDV, Send Derive{Space} 	
Else IfEqual key0, ERIFB, Send Brief{Space} 	
Else IfEqual key0, ERIFN, Send Infer{Space} 	
Else IfEqual key0, ERIGN, Send Engineer{Space} 	
Else IfEqual key0, ERIOGN, Send Region{Space} 	
Else IfEqual key0, ERIOPA, Send Operation{Space} 	
Else IfEqual key0, ERIOPDV, Send Provide{Space} 	
Else IfEqual key0, ERIOSCN, Send Scenario{Space} 	
Else IfEqual key0, ERIOSDC, Send Description{Space} 	
Else IfEqual key0, ERIOVN, Send Environment{Space} 	
Else IfEqual key0, ERIPC, Send Price{Space} 	
Else IfEqual key0, ERISCB, Send Scribe{Space} 	
Else IfEqual key0, ERISDC, Send Describe{Space} 	
Else IfEqual key0, EROASN, Send Reason{Space} 	
Else IfEqual key0, EROCN, Send Concern{Space} 	
Else IfEqual key0, EROCV, Send Cover{Space} 	
Else IfEqual key0, EROD, Send Order{Space} 	
Else IfEqual key0, ERODC, Send Record{Space} 	
Else IfEqual key0, EROF, Send Offer{Space} 	
Else IfEqual key0, EROL, Send Role{Space} 	
Else IfEqual key0, EROPACM, Send Compare{Space} 	
Else IfEqual key0, EROPAFCNM, Send Performance{Space} 	
Else IfEqual key0, EROPLBM, Send Problem{Space} 	
Else IfEqual key0, EROPLX, Send Explore{Space} 	
Else IfEqual key0, EROPSG, Send Progress{Space} 	
Else IfEqual key0, EROPSN, Send Person{Space} 	
Else IfEqual key0, EROSH, Send Horse{Space} 	
Else IfEqual key0, EROV, Send Over{Space} 	
Else IfEqual key0, ERP, Send Per{Space} 
Else IfEqual key0, ERPA, Send Prepare{Space} 	
Else IfEqual key0, ERPALC, Send Replace{Space} 	
Else IfEqual key0, ERPS, Send Press{Space} 	
Else IfEqual key0, ERS, Send Res{Space} 	
Else IfEqual key0, ERSCN, Send Screen{Space} 	
Else IfEqual key0, ERSV, Send Serve{Space} 	
Else IfEqual key0, ERT, Send Tree{Space} 	
Else IfEqual key0, ERTA, Send Rate{Space} 	
Else IfEqual key0, ERTAC, Send React{Space} 	
Else IfEqual key0, ERTAFH, Send Father{Space} 	
Else IfEqual key0, ERTAG, Send Great{Space} 	
Else IfEqual key0, ERTAHC, Send Character{Space} 	
Else IfEqual key0, ERTAL, Send Later{Space} 	
Else IfEqual key0, ERTALCN, Send Central{Space} 	
Else IfEqual key0, ERTAM, Send Matter{Space} 	
Else IfEqual key0, ERTAX, Send Extra	
Else IfEqual key0, ERTB, Send Better{Space} 	
Else IfEqual key0, ERTCN, Send Recent{Space} 	
Else IfEqual key0, ERTH, Send There{Space} 	
Else IfEqual key0, ERTHS, Send There's{Space} 	
Else IfEqual key0, ERTIACN, Send Certain{Space} 	
Else IfEqual key0, ERTIAGN, Send Integrate{Space} 	
Else IfEqual key0, ERTIAL, Send Retail{Space} 	
Else IfEqual key0, ERTIALCV, Send Vertical{Space} 	
Else IfEqual key0, ERTIALV, Send Relative{Space} 	
Else IfEqual key0, ERTIDC, Send Credit{Space} 	
Else IfEqual key0, ERTIFL, Send Filter{Space} 	
Else IfEqual key0, ERTIH, Send Their{Space} 	
Else IfEqual key0, ERTIN, Send Inter	
Else IfEqual key0, ERTIOADCN, Send Coordinate{Space} 	
Else IfEqual key0, ERTIPA, Send Therapist{Space} 	
Else IfEqual key0, ERTIPAH, Send Therapist{Space} 	
Else IfEqual key0, ERTIPASH, Send Therapist{Space} 	
Else IfEqual key0, ERTIPH, Send Therapist{Space} 	
Else IfEqual key0, ERTIS, Send Sister{Space} 	
Else IfEqual key0, ERTL, Send Letter{Space} 	
Else IfEqual key0, ERTM, Send Term{Space} 	
Else IfEqual key0, ERTN, Send Enter{Space} 	
Else IfEqual key0, ERTO, Send Tore{Space} 	
Else IfEqual key0, ERTOASG, Send Storage{Space} 	
Else IfEqual key0, ERTOC, Send Correct{Space} 	
Else IfEqual key0, ERTOGH, Send Together{Space} 	
Else IfEqual key0, ERTOH, Send Other{Space} 	
Else IfEqual key0, ERTOHB, Send Bother{Space} 	
Else IfEqual key0, ERTOHM, Send Mother{Space} 	
Else IfEqual key0, ERTOP, Send Report{Space} 	
Else IfEqual key0, ERTOS, Send Store{Space} 	
Else IfEqual key0, ERTOSN, Send Testosterone{Space} 	
Else IfEqual key0, ERTPA, Send Parate{Space} 	
Else IfEqual key0, ERTPAN, Send Partner{Space} 	
Else IfEqual key0, ERTPCN, Send Percent{Space} 	
Else IfEqual key0, ERTPSN, Send Present{Space} 	
Else IfEqual key0, ERTS, Send Rest{Space} 	
Else IfEqual key0, ERTSH, Send There's{Space} 	
Else IfEqual key0, ERTU, Send True{Space} 	
Else IfEqual key0, ERTUAC, Send Accurate{Space} 	
Else IfEqual key0, ERTUAFCNM, Send Manufacture{Space} 	
Else IfEqual key0, ERTUAN, Send Nature{Space} 	
Else IfEqual key0, ERTUCN, Send Current{Space} 	
Else IfEqual key0, ERTUF, Send Future{Space} 	
Else IfEqual key0, ERTUIPC, Send Picture{Space} 	
Else IfEqual key0, ERTULC, Send Culture{Space} 	
Else IfEqual key0, ERTUSL, Send Result{Space} 	
Else IfEqual key0, ERTVNM, Send Environment{Space} 	
Else IfEqual key0, ERTXM, Send Extreme{Space} 	
Else IfEqual key0, ERTYH, Send They're{Space} 	
Else IfEqual key0, ERTYN, Send Entry{Space} 	
Else IfEqual key0, ERU, Send You're{Space} 	
Else IfEqual key0, ERUDC, Send Reduce{Space} 	
Else IfEqual key0, ERUDN, Send Under{Space} 	
Else IfEqual key0, ERUL, Send Rule{Space} 	
Else IfEqual key0, ERUOPS, Send Purpose{Space} 	
Else IfEqual key0, ERUPS, Send Super{Space} 	
Else IfEqual key0, ERUS, Send Sure{Space} 	
Else IfEqual key0, ERUSFL, Send Yourself{Space} 	
Else IfEqual key0, ERUSM, Send Summer{Space} 	
Else IfEqual key0, ERV, Send Ever{Space} 	
Else IfEqual key0, ERVN, Send Never{Space} 	
Else IfEqual key0, ERVN, Send Never{Space} 	
Else IfEqual key0, ERY, Send Every{Space} 	
Else IfEqual key0, ERYAL, Send Early{Space} 	
Else IfEqual key0, ERYOGC, Send Grocery{Space} 	
Else IfEqual key0, ERYPH, Send Hyper	
Else IfEqual key0, ERYUSG, Send Surgery{Space} 	
Else IfEqual key0, ERYV, Send Every{Space} 	
Else IfEqual key0, ES, Send See{Space} 	
Else IfEqual key0, ESC, Send Second{Space} 	
Else IfEqual key0, ESDN, Send Send {Space} 	
Else IfEqual key0, ESFL, Send Self{Space} 	
Else IfEqual key0, ESH, Send She{Space} 	
Else IfEqual key0, ESK, Send Seek{Space} 	
Else IfEqual key0, ESL, Send Else{Space}
Else IfEqual key0, ESM, Send Seem{Space} 	
Else IfEqual key0, ESN, Send Sense{Space} 	
Else IfEqual key0, ET, Send Even Though{Space} 	
Else IfEqual key0, ETA, Send Ate{Space} 	
Else IfEqual key0, ETADH, Send Hated{Space} 	
Else IfEqual key0, ETADLN, Send Dental{Space} 	
Else IfEqual key0, ETAFC, Send Affect{Space} 	
Else IfEqual key0, ETAGHC, Send Teaching{Space} 	
Else IfEqual key0, ETAH, Send Hate{Space} 	
Else IfEqual key0, ETAHC, Send Teach{Space} 	
Else IfEqual key0, ETAHL, Send Health{Space} 	
Else IfEqual key0, ETAK, Send Take{Space} 	
Else IfEqual key0, ETAL, Send Late{Space} 	
Else IfEqual key0, ETALB, Send Table{Space} 	
Else IfEqual key0, ETAM, Send Team{Space} 	
Else IfEqual key0, ETAN, Send Neat{Space} 	
Else IfEqual key0, ETAS, Send State{Space} 	
Else IfEqual key0, ETASCN, Send Stance{Space} 	
Else IfEqual key0, ETASL, Send Least{Space} 	
Else IfEqual key0, ETAXC, Send Exact{Space} 	
Else IfEqual key0, ETC, Send Et Cetera{Space} 	
Else IfEqual key0, ETCN, Send Cent{Space} 	
Else IfEqual key0, ETDN, Send Tend{Space} 	
Else IfEqual key0, ETFC, Send Effect{Space} 	
Else IfEqual key0, ETFL, Send Felt{Space} 	
Else IfEqual key0, ETG, Send Get{Space} 	
Else IfEqual key0, ETGV, Send Everything{Space} 	
Else IfEqual key0, ETH, Send The{Space} 	
Else IfEqual key0, ETHC, Send Tech{Space} 	
Else IfEqual key0, ETHCN, Send Technology{Space} 	
Else IfEqual key0, ETHM, Send Them{Space} 	
Else IfEqual key0, ETHN, Send Then{Space} 	
Else IfEqual key0, ETIACV, Send Active{Space} 	
Else IfEqual key0, ETIAV, Send Ative	
Else IfEqual key0, ETIGLCN, Send Intelligence{Space} 	
Else IfEqual key0, ETIGLN, Send Intelligent{Space} 	
Else IfEqual key0, ETIHC, Send Ethic{Space} 	
Else IfEqual key0, ETIL, Send Little{Space} 	
Else IfEqual key0, ETILCN, Send Client{Space} 	
Else IfEqual key0, ETIM, Send Item{Space} 	
Else IfEqual key0, ETIM, Send Time{Space} 	
Else IfEqual key0, ETIOCM, Send Committee{Space} 	
Else IfEqual key0, ETIOCN, Send Notice{Space} 	
Else IfEqual key0, ETIONM, Send Mention{Space} 	
Else IfEqual key0, ETIPAN, Send Patient{Space} 	
Else IfEqual key0, ETIS, Send Site{Space} 	
Else IfEqual key0, ETIS, Send Ities{Space} 	
Else IfEqual key0, ETISM, Send Times{Space} 	
Else IfEqual key0, ETISVN, Send Invest{Space} 	
Else IfEqual key0, ETISX, Send Exist{Space} 	
Else IfEqual key0, ETIV, Send Tive{Space} 	
Else IfEqual key0, ETIXC, Send Excite{Space} 	
Else IfEqual key0, ETL, Send Let{Space} 	
Else IfEqual key0, ETM, Send Met{Space} 	
Else IfEqual key0, ETM, Send Met{Space} 	
Else IfEqual key0, ETN, Send Net{Space}
Else IfEqual key0, ETOALC, Send Locate{Space} 	
Else IfEqual key0, ETOCN, Send Connect{Space} 	
Else IfEqual key0, ETOCNM, Send Comment{Space} 	
Else IfEqual key0, ETOFN, Send Often{Space} 	
Else IfEqual key0, ETOGH, Send Together{Space} 	
Else IfEqual key0, ETOHL, Send Hotel{Space} 	
Else IfEqual key0, ETOJCB, Send Object{Space} 	
Else IfEqual key0, ETONM, Send Moment{Space} 	
Else IfEqual key0, ETOPCN, Send Concept{Space} 	
Else IfEqual key0, ETOPKC, Send Pocket{Space} 	
Else IfEqual key0, ETOSH, Send Those{Space} 	
Else IfEqual key0, ETOSHN, Send Honest{Space} 	
Else IfEqual key0, ETPAC, Send Accept{Space} 	
Else IfEqual key0, ETPDN, Send Dependent{Space} 	
Else IfEqual key0, ETPK, Send Kept{Space} 	
Else IfEqual key0, ETPS, Send Step{Space} 	
Else IfEqual key0, ETPS, Send Step{Space} 	
Else IfEqual key0, ETPSN, Send Spent{Space} 	
Else IfEqual key0, TPXC, Send Expect{Space} 	
Else IfEqual key0, ETS, Send Set{Space} 	
Else IfEqual key0, ETSB, Send Best{Space} 	
Else IfEqual key0, ETSH, Send These{Space} 	
Else IfEqual key0, ETSHC, Send Chest{Space} 	
Else IfEqual key0, ETSHLB, Send Establish{Space} 	
Else IfEqual key0, ETSL, Send Let's{Space} 	
Else IfEqual key0, ETSLC, Send Select{Space} 	
Else IfEqual key0, ETSN, Send Sent{Space} 
Else IfEqual key0, ETYSLN, Send Sent{Space} 	
	
Else IfEqual key0, ETUADC, Send Educate{Space} 	
Else IfEqual key0, ETUAGNM, Send Augment{Space} 	
Else IfEqual key0, ETUINM, Send Minute{Space} 	
Else IfEqual key0, ETUIPADLC, Send Duplicate{Space} 	
Else IfEqual key0, ETUODCNM, Send Document{Space} 	
Else IfEqual key0, ETUSDN, Send Student{Space} 	
Else IfEqual key0, ETUVN, Send Eventually{Space} 	
Else IfEqual key0, ETX, Send External{Space} 	
Else IfEqual key0, ETXN, Send Next{Space} 	
Else IfEqual key0, ETYH, Send They{Space} 	
Else IfEqual key0, ETYHV, Send They've{Space} 	
Else IfEqual key0, ETYIDN, Send Identity{Space} 	
Else IfEqual key0, ETYOSCM, Send Ecosystem{Space} 	
Else IfEqual key0, ETYP, Send Type{Space} 	
Else IfEqual key0, ETYSL, Send Style{Space} 	
Else IfEqual key0, ETYSM, Send System{Space} 	
Else IfEqual key0, EUAGLC, Send Colleague{Space} 	
Else IfEqual key0, EUALV, Send Value{Space} 	
Else IfEqual key0, EUD, Send Education{Space} 	
Else IfEqual key0, EUGH, Send Huge{Space} 	
Else IfEqual key0, EUIADCN, Send Audience{Space} 	
Else IfEqual key0, EUIS, Send Issue{Space} 	
Else IfEqual key0, EUOPS, Send Suppose{Space} 	
Else IfEqual key0, EUOSFCN, Send Confuse{Space} 	
Else IfEqual key0, EUOSH, Send House{Space} 	
Else IfEqual key0, EUS, Send Use{Space} 	
Else IfEqual key0, EUSC, Send Success{Space} 	
Else IfEqual key0, EUSDN, Send Sudden{Space} 	
Else IfEqual key0, EUSG, Send Guess{Space} 	
Else IfEqual key0, EUV, Send You've{Space} 	
Else IfEqual key0, EV, Send Ever{Space} 	
Else IfEqual key0, EVB, Send Everybody{Space} 	
Else IfEqual key0, EVN, Send Even{Space} 	
Else IfEqual key0, EX, Send Exactly{Space} 	
Else IfEqual key0, EX, Send Ex	
Else IfEqual key0, EXC, Send Excellent{Space} 	
Else IfEqual key0, EYALZN, Send Analyze{Space} 	
Else IfEqual key0, EYAS, Send Easy{Space} 	
Else IfEqual key0, EYB, Send Bye{Space} 	
Else IfEqual key0, EYK, Send Key{Space} 	
Else IfEqual key0, EYLC, Send Cycle{Space} 	
Else IfEqual key0, EYONM, Send Money{Space} 	
Else IfEqual key0, EYS, Send Yes{Space} 	
Else IfEqual key0, EYSFLM, Send Myself{Space} 	
Else IfEqual key0, EYSFLM, Send Myself{Space} 	
Else IfEqual key0, EYV, Send Every{Space} 
Else IfEqual key0, EALBM, Send Blame{Space} 
Else IfEqual key0, EASL, Send Lease{Space} 
Else IfEqual key0, EDKC, Send Deck{Space} 
Else IfEqual key0, ERANM, Send Manner{Space} 
Else IfEqual key0, ERFL, Send Freelance{Space} 
Else IfEqual key0, ERIOPD, Send Period{Space} 
Else IfEqual key0, ERIPX, Send Expire{Space} 
Else IfEqual key0, ERPDC, Send Precede{Space} 
Else IfEqual key0, ERTIAN, Send Entertain{Space} 
Else IfEqual key0, ETID, Send Edit{Space} 
Else IfEqual key0, ETLC, Send Elect{Space} 
Else IfEqual key0, EUIDG, Send Guide{Space} 
Else IfEqual key0, EUIGN, Send Genuine{Space} 
Else IfEqual key0, EYAGLC, Send Legacy{Space} 	
Return
SENDOup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, OA, Send Anyone{Space} 
Else IfEqual key0, OAN, Send Anyone{Space} 
Else IfEqual key0, OADL, Send Load{Space} 
Else IfEqual key0, OAGNM, Send Among{Space} 
Else IfEqual key0, ODFL, Send Fold{Space} 
Else IfEqual key0, OGM, Send Oh My God.{Space} 
Else IfEqual key0, OAHLC, Send Alcohol{Space} 
Else IfEqual key0, ODGL, Send Gold{Space} 
Else IfEqual key0, ODLB, Send Bold{Space} 
Else IfEqual key0, ODLC, Send Cold{Space} 
Else IfEqual key0, OFKL, Send Folk{Space} 
Else IfEqual key0, OGL, Send Log{Space} 
Else IfEqual key0, OZM, Send Zoom{Space} 
Else IfEqual key0, OMSGH, Send Oh My Gosh.{Space} 
Else IfEqual key0, OSGH, Send Gosh{Space} 
Else IfEqual key0, OSN, Send Soon{Space} 
Else IfEqual key0, OALN, Send Loan{Space} 
Else IfEqual key0, OBM, Send Bomb{Space} 
Else IfEqual key0, OSHKC, Send Shock{Space} 
Else IfEqual key0, OXB, Send Box{Space} 
Else IfEqual key0, OAG, Send Ago{Space} 
Else IfEqual key0, OSN, Send Son{Space} 
Else IfEqual key0, OAGL, Send Goal{Space} 
Else IfEqual key0, OAGLN, Send Along{Space} 
Else IfEqual key0, OAGN, Send Going To{Space} 
Else IfEqual key0, OASL, Send Also{Space} 
Else IfEqual key0, OC, Send Could{Space} 
Else IfEqual key0, OCM, Send Com
Else IfEqual key0, OCN, Send Con
Else IfEqual key0, OCNM, Send Common{Space} 
Else IfEqual key0, OD, Send Do{Space} 
Else IfEqual key0, ODC, Send Document{Space} 
Else IfEqual key0, ODF, Send Food{Space} 
Else IfEqual key0, ODG, Send Doing{Space} 
Else IfEqual key0, ODHL, Send Hold{Space} 
Else IfEqual key0, ODL, Send Old{Space} 
Else IfEqual key0, OF, Send Of{Space} 
Else IfEqual key0, OFC, Send Of Course{Space} 
Else IfEqual key0, OFC, Send Of Course{Space} 
Else IfEqual key0, OFCN, Send Confirm{Space} 
Else IfEqual key0, OFN, Send Information{Space} 
Else IfEqual key0, OG, Send Go{Space} 
Else IfEqual key0, OGLN, Send Long{Space} 
Else IfEqual key0, OGLV, Send Loving{Space} 
Else IfEqual key0, OGN, Send Gone{Space} 
Else IfEqual key0, OHM, Send Homo
Else IfEqual key0, OJB, Send Job{Space} 
Else IfEqual key0, OK, Send Kind Of{Space} 
Else IfEqual key0, OKB, Send Book{Space} 
Else IfEqual key0, OKC, Send Cook{Space} 
Else IfEqual key0, OKL, Send Look{Space} 
Else IfEqual key0, OKLC, Send Lock{Space} 
Else IfEqual key0, OLN, Send Online{Space} 
Else IfEqual key0, ON, Send On{Space} 
Else IfEqual key0, ONM, Send Moon{Space} 
Else IfEqual key0, OP, Send Opportunity{Space} 
Else IfEqual key0, OPN, Send Open{Space} 
Else IfEqual key0, OPS, Send Opportunities{Space} 
Else IfEqual key0, OPSH, Send Shop{Space} 
Else IfEqual key0, OS, Send So{Space} 
Else IfEqual key0, OSF, Send Sort Of{Space} 
Else IfEqual key0, OSFKL, Send Folks{Space} 
Else IfEqual key0, OSGN, Send Song{Space} 
Else IfEqual key0, OSHLC, Send School{Space} 
Else IfEqual key0, OSM, Send Someone{Space} 
Else IfEqual key0, OSN, Send Soon{Space} 
Else IfEqual key0, OVB, Send Obviously{Space} 
Else IfEqual key0, OALC, Send Local{Space} 
Else IfEqual key0, OFLC, Send Official{Space} 
Else IfEqual key0, OH, Send Oh, {Space} 
Else IfEqual key0, OSDL, Send Sold{Space} 
Return
SENDPup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
IfEqual key0, PAC, Send Cap{Space} 
Else IfEqual key0, PK, Send Keep{Space} 	
Else IfEqual key0, UPDG, Send Pudding{Space} 		
Else IfEqual key0, PSFC, Send Specific{Space} 
Else IfEqual key0, PFHL, Send Helpful{Space} 
Else IfEqual key0, PHL, Send Helpful{Space} 
Else IfEqual key0, PAKC, Send Pack{Space} 
Else IfEqual key0, PAM, Send Map{Space} 
Else IfEqual key0, PASM, Send Spam{Space} 
Else IfEqual key0, PGK, Send Package{Space} 
Else IfEqual key0, PK, Send Keep{Space} 
Else IfEqual key0, PAL, Send Application{Space} 
Else IfEqual key0, PB, Send Possible{Space} 
Else IfEqual key0, PAG, Send Gap{Space} 
Else IfEqual key0, PASL, Send Applies{Space} 
Else IfEqual key0, PCNM, Send Companion{Space} 
Else IfEqual key0, PDXN, Send Expand{Space} 
Else IfEqual key0, PGK, Send Package{Space} 
Else IfEqual key0, PLCNM, Send Complain{Space} 
Else IfEqual key0, PLCNM, Send Complain{Space} 
Else IfEqual key0, PSDN, Send Dispense{Space} 
Else IfEqual key0, PSXVN, Send Expansive{Space} 
Else IfEqual key0, PA, Send App{Space} 
Else IfEqual key0, PAGLZ, Send Apologize{Space} 
Else IfEqual key0, PALCM, Send Accomplish{Space} 
Else IfEqual key0, PASHLCM, Send Accomplish{Space} 
Else IfEqual key0, PSK, Send Speak{Space} 
Else IfEqual key0, PSLBM, Send Impossible{Space} 
Else IfEqual key0, PSX, Send Expose{Space} 
Else IfEqual key0, PALN, Send Plan{Space} 
Else IfEqual key0, PAS, Send Pass{Space} 
Else IfEqual key0, PFH, Send Hopefully{Space} 
Else IfEqual key0, PH, Send Hope{Space} 
Else IfEqual key0, PSLC, Send Special{Space} 
Else IfEqual key0, PCM, Send Company{Space} 
Else IfEqual key0, PDCM, Send Pandemic{Space} 
Else IfEqual key0, PF, Send Perfect{Space} 
Else IfEqual key0, PFH, Send Hopefully{Space} 
Else IfEqual key0, PG, Send Page{Space} 
Else IfEqual key0, PGH, Send Happening{Space} 
Else IfEqual key0, PGLB, Send Publishing{Space} 
Else IfEqual key0, PHN, Send Happen{Space} 
Else IfEqual key0, PJM, Send Jump{Space} 
Else IfEqual key0, PL, Send People{Space} 
Else IfEqual key0, PLB, Send Possibly{Space} 
Else IfEqual key0, PLC, Send Couple{Space} 
Else IfEqual key0, PLCB, Send Public{Space} 
Else IfEqual key0, PLCM, Send Complete{Space} 
Else IfEqual key0, PLXM, Send Example{Space} 
Else IfEqual key0, PLXN, Send Explain{Space} 
Else IfEqual key0, PN, Send No Problem{Space} 
Else IfEqual key0, PS, Send Specifically{Space} 
Else IfEqual key0, PSCM, Send Companies{Space} 
Else IfEqual key0, PSD, Send Speed{Space} 
Else IfEqual key0, PSH, Send Hospital{Space} 
Else IfEqual key0, PSL, Send Please{Space} 
Else IfEqual key0, PSLB, Send Possible{Space} 
Else IfEqual key0, PSLM, Send Simple{Space} 
Else IfEqual key0, PSN, Send Passion{Space} 
Else IfEqual key0, PX, Send Experience{Space} 
Else IfEqual key0, PSHLB, Send Publish{Space} 
Return
SENDAup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, AB, Send About{Space} 
Else IfEqual key0, ADV, Send Avoid{Space} 
Else IfEqual key0, ADCVN, Send Advance{Space} 
Else IfEqual key0, ASKC, Send Sack{Space} 
Else IfEqual key0, ABN, Send Banana{Space} 
Else IfEqual key0, AFV, Send Favorite{Space} 
Else IfEqual key0, AC, Send Actually{Space} 
Else IfEqual key0, ADGL, Send Glad{Space} 
Else IfEqual key0, ADBN, Send Band{Space} 
Else IfEqual key0, ADLN, Send Land{Space} 
Else IfEqual key0, ADNM, Send Damn{Space} 
Else IfEqual key0, AGHN, Send Hang{Space} 
Else IfEqual key0, AGKBN, Send Banking{Space} 
Else IfEqual key0, ALCM, Send Calm{Space} 
Else IfEqual key0, ASCN, Send Scan{Space} 
Else IfEqual key0, ASDHN, Send Hands{Space} 
Else IfEqual key0, ASDNM, Send Admission{Space} 
Else IfEqual key0, ADCM, Send Academic{Space} 
Else IfEqual key0, ADCM, Send Academic{Space} 
Else IfEqual key0, ADCV, Send Advice{Space} 
Else IfEqual key0, ADCV, Send Advice{Space} 
Else IfEqual key0, ADM, Send Mad{Space} 
Else IfEqual key0, ADV, Send Advertise{Space} 
Else IfEqual key0, AGCN, Send Agency{Space} 
Else IfEqual key0, AGNM, Send Among{Space} 
Else IfEqual key0, AHKC, Send Hack{Space} 
Else IfEqual key0, AHL, Send Hall{Space} 
Else IfEqual key0, ALN, Send Alone{Space} 
Else IfEqual key0, ASD, Send Ads{Space} 
Else IfEqual key0, ASDV, Send Advise{Space} 
Else IfEqual key0, ASHC, Send Cash{Space} 
Else IfEqual key0, ASM, Send Assume{Space} 
Else IfEqual key0, AGV, Send Average{Space} 
Else IfEqual key0, AHCV, Send Achieve{Space} 
Else IfEqual key0, AKLCB, Send Black{Space} 
Else IfEqual key0, AVB, Send Above{Space} 
Else IfEqual key0, ACN, Send Can{Space} 
Else IfEqual key0, ADGCN, Send Dancing{Space} 	
Else IfEqual key0, ADB, Send Anybody{Space} 
Else IfEqual key0, ADF, Send Afterwards{Space} 
Else IfEqual key0, ADGC, Send According{Space} 
Else IfEqual key0, ADH, Send Had{Space} 
Else IfEqual key0, ADHN, Send Hand{Space} 
Else IfEqual key0, ADL, Send Already{Space} 
Else IfEqual key0, AF, Send After{Space} 
Else IfEqual key0, AFG, Send Affecting{Space} 
Else IfEqual key0, AFHL, Send Half{Space} 
Else IfEqual key0, AFL, Send Fall{Space} 
Else IfEqual key0, AG, Send Anything{Space} 
Else IfEqual key0, AGM, Send Amazing{Space} 
Else IfEqual key0, AGN, Send Again{Space} 
Else IfEqual key0, AKCB, Send Back{Space} 
Else IfEqual key0, AL, Send All{Space} 
Else IfEqual key0, ALB, Send Lab{Space} 
Else IfEqual key0, ALC, Send Call{Space} 
Else IfEqual key0, ALM, Send Almost{Space} 
Else IfEqual key0, ALVB, Send Available{Space} 
Else IfEqual key0, AM, Send Am{Space} 
Else IfEqual key0, AN, Send An{Space} 
Else IfEqual key0, ANM, Send Man{Space} 
Else IfEqual key0, AS, Send As{Space} 
Else IfEqual key0, ASB, Send Absolutely{Space} 
Else IfEqual key0, ASDK, Send Asked{Space} 
Else IfEqual key0, ASGL, Send Glass{Space} 
Else IfEqual key0, ASH, Send Has{Space} 
Else IfEqual key0, ASHL, Send Lash{Space} 
Else IfEqual key0, ASK, Send Ask{Space} 
Else IfEqual key0, ASLC, Send Class{Space} 
Else IfEqual key0, ASLM, Send Small{Space} 
Else IfEqual key0, AKBN, Send Bank{Space} 
Else IfEqual key0, ASN, Send Answer{Space} 
Else IfEqual key0, AXV, Send Vaccine{Space} 
Else IfEqual key0, AZM, Send Amazon{Space} 
Else IfEqual key0, AD, Send Ad{Space} 
Return
SENDSup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, SBN, Send Business{Space} 
Else IfEqual key0, SCB, Send Basic{Space} 
Else IfEqual key0, SHM, Send Somehow{Space} 
Else IfEqual key0, SDHLC, Send Schedule{Space} 
Else IfEqual key0, SZ, Send Size{Space} 
Else IfEqual key0, SCM, Send Comes{Space} 
Else IfEqual key0, SDB, Send Besides{Space} 
Else IfEqual key0, SDHBN, Send Husband{Space} 
Else IfEqual key0, SDN, Send Inside{Space} 
Else IfEqual key0, SHL, Send She'll{Space} 
Else IfEqual key0, SLVB, Send Visible{Space} 
Else IfEqual key0, SD, Send Somebody{Space} 
Else IfEqual key0, SCNM, Send Consume{Space} 
Else IfEqual key0, SLCN, Send License{Space} 
Else IfEqual key0, SLN, Send Lesson{Space} 
Else IfEqual key0, SNM, Send Mission{Space} 
Else IfEqual key0, SNM, Send Mission{Space} 
Else IfEqual key0, SVM, Send Massive{Space} 
Else IfEqual key0, SVN, Send Vision{Space} 
Else IfEqual key0, SDC, Send Describe{Space} 
Else IfEqual key0, SFCN, Send Confuse{Space} 
Else IfEqual key0, SHN, Send Hasn't{Space} 
Else IfEqual key0, SDCN, Send Decision{Space} 
Else IfEqual key0, SDGN, Send Design{Space} 
Else IfEqual key0, SDLCM, Send Social Media{Space} 
Else IfEqual key0, SF, Send For Sure.{Space} 
Else IfEqual key0, SFGCN, Send Significant{Space} 
Else IfEqual key0, SFLM, Send Myself{Space} 
Else IfEqual key0, SG, Send Something{Space} 
Else IfEqual key0, SGM, Send Message{Space} 
Else IfEqual key0, SH, Send Should{Space} 
Else IfEqual key0, SDHN, Send Shouldn't{Space} 
Else IfEqual key0, SHN, Send Shouldn't{Space} 
Else IfEqual key0, SH, Send Should{Space} 
Else IfEqual key0, SL, Send Sell{Space} 
Else IfEqual key0, SLC, Send Social{Space} 
Else IfEqual key0, SLCB, Send Basically{Space} 
Else IfEqual key0, SLP, Send Sleep{Space} 
Else IfEqual key0, SLV, Send Visual{Space} 
Else IfEqual key0, SM, Send Some{Space} 
Else IfEqual key0, SN, Send Seen{Space} 
Else IfEqual key0, SRCV, Send Service{Space} 
Else IfEqual key0, ST, Send Street{Space} 
Else IfEqual key0, SV, Send Versus{Space} 
Else IfEqual key0, SXCVL, Send Exclusive{Space} 
Return
SENDDup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, DBN, Send Nobody{Space} 
Else IfEqual key0, DCM, Send Command{Space} 
Else IfEqual key0, DHLN, Send Handle{Space} 
Else IfEqual key0, DNM, Send Domain{Space} 
Else IfEqual key0, DHLN, Send Handle{Space} 
Else IfEqual key0, DGHLN, Send Handling{Space} 
Else IfEqual key0, DCN, Send Couldn't{Space} 
Else IfEqual key0, DCN, Send Candid{Space} 
Else IfEqual key0, DCNM, Send Medicine{Space} 
Else IfEqual key0, DHN, Send Hadn't{Space} 
Else IfEqual key0, DLCN, Send Include{Space} 
Else IfEqual key0, DCV, Send Device{Space} 
Else IfEqual key0, DFKB, Send Feedback{Space} 
Else IfEqual key0, DFN, Send Found{Space} 
Else IfEqual key0, DG, Send Good{Space} 
Else IfEqual key0, DGB, Send Background{Space} 
Else IfEqual key0, DGLB, Send Building{Space} 
Else IfEqual key0, DGM, Send Damage{Space} 
Else IfEqual key0, DGN, Send Ground{Space} 
Else IfEqual key0, DHBN, Send Behind{Space} 
Else IfEqual key0, DL, Send Deal{Space} 
Else IfEqual key0, DLB, Send Build{Space} 
Else IfEqual key0, DLCBN, Send Incredible{Space} 
Else IfEqual key0, DLCM, Send Medical{Space} 
Else IfEqual key0, DLCM, Send Medical{Space} 
Else IfEqual key0, DM, Send Made{Space} 
Else IfEqual key0, DN, Send Done{Space} 
Else IfEqual key0, DRG, Send During, {Space} 
Else IfEqual key0, DV, Send Everyday{Space} 
Else IfEqual key0, DVM, Send Development{Space} 
Else IfEqual key0, DX, Send Excited{Space} 
Return
SENDFup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, FB, Send Before{Space} 
Else IfEqual key0, FCM, Send Comfortable{Space} 
Else IfEqual key0, FCN, Send Finance{Space} 
Else IfEqual key0, FLB, Send Belief{Space} 
Else IfEqual key0, FLCBN, Send Beneficial{Space} 
Else IfEqual key0, FH, Send Helpful{Space} 
Else IfEqual key0, FGL, Send Feeling{Space} 	
Else IfEqual key0, FL, Send Feel{Space} 
Else IfEqual key0, FLCN, Send Financial{Space} 
Else IfEqual key0, FLN, Send Final{Space} 
Else IfEqual key0, FN, Send Fine{Space} 
Return
SENDGup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, GB, Send Being{Space} 
Else IfEqual key0, GC, Send Coming{Space} 
Else IfEqual key0, GEN, Send General{Space} 
Else IfEqual key0, GHCN, Send Change{Space} 
Else IfEqual key0, GLBN, Send Belong{Space} 
Else IfEqual key0, GCM, Send Magic{Space} 
Else IfEqual key0, GH, Send Having{Space} 
Else IfEqual key0, GKL, Send Looking{Space} 
Else IfEqual key0, GHLCN, Send Challenge{Space} 
Else IfEqual key0, GKM, Send Making{Space} 
Else IfEqual key0, GL, Send Learning{Space} 
Else IfEqual key0, GLC, Send College{Space} 
Else IfEqual key0, GLN, Send General{Space} 
Else IfEqual key0, GLV, Send Leaving{Space} 
Else IfEqual key0, GF, Send Girlfriend{Space} 
Else IfEqual key0, GVN, Send Given{Space} 
Else IfEqual key0, GM, Send Making{Space} 
Else IfEqual key0, GN, Send Nothing{Space} 
Else IfEqual key0, GNM, Send Manage{Space} 
Else IfEqual key0, GV, Send Give{Space} 
Else IfEqual key0, GV, Send Very Good{Space} 
Else IfEqual key0, GVM, Send Moving{Space} 
Else IfEqual key0, GX, Send Exciting{Space} 
Else IfEqual key0, GZNM, Send Magazine{Space} 
Return
SENDHup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, HC, Send Choice{Space} 
Else IfEqual key0, HKCN, Send Chicken{Space} 
Else IfEqual key0, HL, Send He'll{Space} 
Else IfEqual key0, HLCV, Send Vehicle{Space} 
 Else IfEqual key0, HM, Send Mm-hmm.{Space} 
Else IfEqual key0, HV, Send Have{Space} 
Else IfEqual key0, HCNM, Send Machine{Space} 
Else IfEqual key0, HLCN, Send Channel{Space} 
Return

SENDIup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, IA, Send Ai
Else IfEqual key0, IDFC, Send Difficult{Space} 
Else IfEqual key0, IDM, Send Mid{Space} 
Else IfEqual key0, IAHCN, Send China{Space} 
Else IfEqual key0, IAS, Send Asia{Space} 
Else IfEqual key0, IALNM, Send Animal{Space} 
Else IfEqual key0, IAHCN, Send Chain{Space} 
Else IfEqual key0, IAM, Send Aim{Space} 
Else IfEqual key0, IASL, Send Sail{Space} 
Else IfEqual key0, IAV, Send Via{Space} 
Else IfEqual key0, IGKLN, Send Inkling{Space} 
Else IfEqual key0, IOL, Send Oil{Space} 
Else IfEqual key0, IOLBM, Send Limbo{Space} 
Else IfEqual key0, IPHC, Send Chip{Space} 
Else IfEqual key0, IPL, Send Pill{Space} 
Else IfEqual key0, IPSN, Send Spin{Space} 
Else IfEqual key0, ISKL, Send Skill{Space} 
Else IfEqual key0, IXM, Send Mix{Space} 
Else IfEqual key0, IAFL, Send Fail{Space} 
Else IfEqual key0, IPSLBM, Send Impossible{Space} 
Else IfEqual key0, IOADV, Send Avoid{Space} 
Else IfEqual key0, IADC, Send Acid{Space} 
Else IfEqual key0, IAGCM, Send Magic{Space} 
Else IfEqual key0, IDG, Send Dig{Space} 
Else IfEqual key0, IFLCN, Send Influence{Space} 
Else IfEqual key0, IKC, Send Kick{Space} 
Else IfEqual key0, IKN, Send Ink{Space} 
Else IfEqual key0, INM, Send Mini{Space} 
Else IfEqual key0, IOADNM, Send Domain{Space} 
Else IfEqual key0, IODB, Send Biodegradable{Space} 
Else IfEqual key0, IODV, Send Void{Space} 
Else IfEqual key0, IOM, Send In My Opinion{Space} 
Else IfEqual key0, IOSDL, Send Solid{Space} 
Else IfEqual key0, IPS, Send Piss{Space} 
Else IfEqual key0, IPSGL, Send Slipping{Space} 
Else IfEqual key0, IPSL, Send Slip{Space} 
Else IfEqual key0, IPSL, Send Slip{Space} 
Else IfEqual key0, IAJL, Send Jail{Space} 
Else IfEqual key0, IAGN, Send Gain{Space} 
Else IfEqual key0, IB, Send No{Space} 
Else IfEqual key0, IADLV, Send Valid{Space} 
Else IfEqual key0, IOAN, Send Nation{Space} 
Else IfEqual key0, ISHCM, Send Schism{Space} 
Else IfEqual key0, IASB, Send Basis{Space} 
Else IfEqual key0, IASLC, Send Classic{Space} 
Else IfEqual key0, IHCN, Send Inch{Space} 
Else IfEqual key0, IKL, Send Kill{Space} 
Else IfEqual key0, ILCN, Send Clinic{Space} 
Else IfEqual key0, IOFN, Send Info{Space} 
Else IfEqual key0, IPHN, Send Iphone{Space} 
Else IfEqual key0, ISKN, Send Skin{Space} 
Else IfEqual key0, ISM, Send Miss{Space} 
Else IfEqual key0, IADNM, Send Admin{Space} 
Else IfEqual key0, IASDNM, Send Administrator{Space} 
Else IfEqual key0, IGM, Send Image{Space} 
Else IfEqual key0, IKLN, Send Link{Space} 
Else IfEqual key0, IOADNM, Send Administration{Space} 
Else IfEqual key0, ISN, Send Isn't{Space} 
Else IfEqual key0, IALCM, Send Claim{Space} 
Else IfEqual key0, IANM, Send Main{Space} 
Else IfEqual key0, IASD, Send Said{Space} 
Else IfEqual key0, ID, Send Did{Space} 
Else IfEqual key0, IDF, Send Different{Space} 
Else IfEqual key0, IDFN, Send Find{Space} 
Else IfEqual key0, IDHLC, Send Child{Space} 
Else IfEqual key0, IDK, Send I Don't Know{Space} 
Else IfEqual key0, IDKN, Send Kind{Space} 
Else IfEqual key0, IDN, Send Individual{Space} 
Else IfEqual key0, IDNM, Send Mind{Space} 
Else IfEqual key0, IF, Send If{Space} 
Else IfEqual key0, IFL, Send Fill{Space} 
Else IfEqual key0, IFX, Send Fix{Space} 
Else IfEqual key0, IG, Send I Guess{Space} 
Else IfEqual key0, IGB, Send Big{Space} 
Else IfEqual key0, IGH, Send High{Space} 
Else IfEqual key0, IGLV, Send Living{Space} 
Else IfEqual key0, IHL, Send Hill{Space} 
Else IfEqual key0, IHM, Send Him{Space} 
Else IfEqual key0, IK, Send I Know{Space} 
Else IfEqual key0, IKLBN, Send Blink{Space} 
Else IfEqual key0, IKLC, Send Click{Space} 
Else IfEqual key0, IKLM, Send Milk{Space} 
Else IfEqual key0, IL, Send I'll{Space} 
Else IfEqual key0, ILV, Send Live{Space} 
Else IfEqual key0, IM, Send I'm{Space} 
Else IfEqual key0, IN, Send In{Space} 
Else IfEqual key0, IN, Send In{Space} 
Else IfEqual key0, IOAC, Send Action{Space} 
Else IfEqual key0, IOALC, Send Location{Space} 
Else IfEqual key0, IOJN, Send Join{Space}
Else IfEqual key0, IONM, Send Omni
Else IfEqual key0, IOP, Send Option{Space} 
Else IfEqual key0, IOPN, Send Opinion{Space} 
Else IfEqual key0, IOSN, Send Ision{Space} 
Else IfEqual key0, IPAD, Send Paid{Space} 
Else IfEqual key0, IPAFN, Send Painful{Space} 
Else IfEqual key0, IPAN, Send Pain{Space} 
Else IfEqual key0, IPFL, Send Flip{Space} 
Else IfEqual key0, IPG, Send Pig{Space} 
Else IfEqual key0, IPKC, Send Pick{Space} 
Else IfEqual key0, IPM, Send Important{Space} 
Else IfEqual key0, IPSK, Send Skip{Space} 
Else IfEqual key0, IS, Send Is{Space} 
Else IfEqual key0, ISD, Send Dis
Else IfEqual key0, ISDK, Send Kids{Space} 
Else IfEqual key0, ISFHN, Send Finish{Space} 
Else IfEqual key0, ISG, Send Significant{Space} 
Else IfEqual key0, ISGN, Send Sign{Space} 
Else IfEqual key0, ISH, Send His{Space} 
Else IfEqual key0, ISKC, Send Sick{Space} 
Else IfEqual key0, ISM, Send Mis
Else IfEqual key0, IFLM, Send Film{Space} 
Return
SENDLup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, LB, Send Little Bit{Space} 
Else IfEqual key0, LC, Send Cool{Space} 
Else IfEqual key0, LCBN, Send Balance{Space} 
Else IfEqual key0, LNM, Send Manual{Space} 
Else IfEqual key0, LVM, Send Volume{Space} 
Else IfEqual key0, LCN, Send Clinical{Space} 
Else IfEqual key0, LCBN, Send Balance{Space} 
Else IfEqual key0, LCM, Send Molecule{Space} 
Else IfEqual key0, LN, Send Line{Space} 
Else IfEqual key0, LV, Send Leave{Space} 
Else IfEqual key0, LVB, Send Believe{Space} 
Else IfEqual key0, LX, Send Exactly{Space} 
Else IfEqual key0, LXCN, Send Excellence{Space} 
Return
SENDXup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, XC, Send Executive{Space} 
Else IfEqual key0, XNM, Send Examine{Space} 
Else IfEqual key0, XNM, Send Expect{Space} 
Return
SENDVup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, VM, Send Move{Space} 
Else IfEqual key0, VN, Send Even{Space} 
Return
SENDBup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, BM, Send Maybe{Space} 
Else IfEqual key0, BF, Send Boyfriend{Space} 
Else IfEqual key0, BN, Send Been{Space} 
Else IfEqual key0, BSC, Send Basic{Space} 
Else IfEqual key0, BSCL, Send Basically{Space} 
Return
SENDCup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, CB, Send Because{Space} 
Else IfEqual key0, CBM, Send Become{Space} 
Else IfEqual key0, CM, Send Come{Space} 
Else IfEqual key0, DFCN, Send Confidence{Space} 
Else IfEqual key0, CBNM, Send Combine{Space} 
Else IfEqual key0, CMG, Send Coming{Space} 
Else IfEqual key0, CN, Send Can{Space} 
Else IfEqual key0, CNM, Send Common{Space} 
Else IfEqual key0, CVN, Send Conversation{Space} 
Return
SENDKup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, KL, Send Look{Space} 
Else IfEqual key0, KLN, Send Knowledge{Space} 
Else IfEqual key0, KM, Send Make{Space} 
Else IfEqual key0, KN, Send Know{Space} 
Return
SENDJup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
 
 Return
SENDZup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, ZM, Send Zoom{Space} 

Return
SENDMup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 

Return
SENDNup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 If StrLen(key0) = 1
 Send {%key0%} 
Else IfEqual key0, NM, Send Mean{Space} 
Return
SENDDOTup:
 SentTick = %A_TickCount%, 
 SentKeys = %key0%
 IfEqual key0, UDN>, Send Understood{Space} 
Else IfEqual key0, WERTH>, Send Threw{Space} 
Else IfEqual key0, RSV>, Send Verse{Space} 
Else IfEqual key0, ONM>, Send Moon{Space} 
Else IfEqual key0, RSV:, Send Verse{Space} 
Else IfEqual key0, TASL>, Send Salt{Space} 
Else IfEqual key0, ERTAH>, Send Earth{Space} 
Else IfEqual key0, US>, Send United States{Space} 
Else IfEqual key0, UOSDN>, Send Sounds{Space} 
Else IfEqual key0, TASL>, Send Last{Space} 
Else IfEqual key0, EPSD>, Send Speed{Space} 
Else IfEqual key0, IADN>, Send Indian{Space} 
Else IfEqual key0, EAS>, Send Sea{Space} 
Else IfEqual key0, TISL>, Send List{Space} 
Else IfEqual key0, ERAGN>, Send Arrange{Space} 
Else IfEqual key0, ERP:, Send Pepper{Space} 
Else IfEqual key0, EPA>, Send Pea{Space} 
Else IfEqual key0, EADH>, Send Ahead{Space} 
Else IfEqual key0, AJN>, Send January{Space} 
Else IfEqual key0, EDC>, Send December{Space} 
Else IfEqual key0, EFB>, Send February{Space} 
Else IfEqual key0, ERIGN>, Send Reign{Space} 
Else IfEqual key0, ERIN>, Send Rein{Space} 
Else IfEqual key0, EROS>, Send Sore{Space} 
Else IfEqual key0, ERSV>, Send Severe{Space} 
Else IfEqual key0, ERTIHN>, Send Inherit{Space} 
Else IfEqual key0, ERYAL>, Send Relay{Space} 
Else IfEqual key0, ETASK>, Send Steak{Space} 
Else IfEqual key0, ETHM>, Send Theme{Space} 
Else IfEqual key0, ETIVN>, Send Invent{Space} 
Else IfEqual key0, ETPS>, Send September{Space} 
Else IfEqual key0, ETUPS>, Send Setup{Space} 
Else IfEqual key0, EUS>, Send Sue{Space} 
Else IfEqual key0, ISKN>, Send Sink{Space} 
Else IfEqual key0, OVN>, Send November{Space} 
Else IfEqual key0, RAHCM>, Send March{Space} 
Else IfEqual key0, UDN>, Send Understood{Space} 
Else IfEqual key0, WRA>, Send Raw{Space} 
Else IfEqual key0, TIAN:, Send Ain’T{Space} 
Else IfEqual key0, YAM>, Send May{Space} 
Else IfEqual key0, ADH>, Send Dah{Space} 
Else IfEqual key0, UAG>, Send August{Space} 
Else IfEqual key0, TUSH>, Send Thus{Space} 
Else IfEqual key0, TOC>, Send October{Space} 
Else IfEqual key0, TSFCN>, Send Fascinate{Space} 
Else IfEqual key0, ERTIAL>, Send Literal{Space}
Else IfEqual key0, IOFN>, Send Information{Space} 
Else IfEqual key0, RPDC>, Send Procedure{Space} 
Else IfEqual key0, ASD>, Send Sad{Space} 
Else IfEqual key0, RPGM>, Send Programmer{Space} 
Else IfEqual key0, ETAS:, Send East{Space} 
Else IfEqual key0, EPASC>, Send Escape{Space} 
Else IfEqual key0, ALB>, Send Ball{Space} 
Else IfEqual key0, WTON:, Send Won't{Space} 
Else IfEqual key0, OK:, Send Okay{Space} 
Else IfEqual key0, EPSL>, Send Spell{Space} 
Else IfEqual key0, EOPS>, Send Oppose{Space} 
Else IfEqual key0, ERIAS>, Send Easier{Space} 
Else IfEqual key0, TKN>, Send Taken{Space} 
Else IfEqual key0, ERASHC>, Send Research{Space} 
Else IfEqual key0, FLCN>, Send Influence{Space} 
Else IfEqual key0, LCN>, Send Council{Space} 
Else IfEqual key0, TNM>, Send Mountain{Space} 
Else IfEqual key0, EF>, Send Fee{Space} 
Else IfEqual key0, RPLCN>, Send Principal{Space} 
Else IfEqual key0, ETAM>, Send Meat{Space} 
Else IfEqual key0, OGL>, Send Logging{Space} 
Else IfEqual key0, OZM>, Send Zoom{Space} 
Else IfEqual key0, QRTS>, Send Squirt{Space} 
Else IfEqual key0, RAM>, Send Ram{Space} 
Else IfEqual key0, RDG>, Send Grade{Space} 
Else IfEqual key0, FLCN>, Send Influence{Space} 
Else IfEqual key0, RGNM>, Send Manager{Space} 
Else IfEqual key0, RSLV>, Send Resolve{Space} 
Else IfEqual key0, RSVN>, Send Nervous{Space} 
Else IfEqual key0, RTFG>, Send Forgot{Space} 
Else IfEqual key0, RTSG>, Send String{Space} 
Else IfEqual key0, WAL>, Send Wall{Space} 
Else IfEqual key0, RUOS>, Send Sour{Space} 
Else IfEqual key0, SLCN>, Send Silence{Space} 
Else IfEqual key0, SLV>, Send Solve{Space} 
Else IfEqual key0, TAC>, Send Cat{Space} 
Else IfEqual key0, TCN>, Send Contain{Space} 
Else IfEqual key0, TIAN>, Send Taint{Space} 
Else IfEqual key0, WO>, Send Wow{Space} 
Else IfEqual key0, YAS>, Send Says{Space} 
Else IfEqual key0, YPAL>, Send Apply{Space} 
Else IfEqual key0, GHCN>, Send Changing{Space} 
Else IfEqual key0, IN>, Send In
Else IfEqual key0, IDK>, Send Kid{Space} 
Else IfEqual key0, GLN>, Send Language Lng.{Space} 
Else IfEqual key0, ESHL>, Send She'll{Space}
Else IfEqual key0, ETSG>, Send Settings{Space} 
Else IfEqual key0, ESC>, Send Escape{Space} 
Else IfEqual key0, ERGM>, Send Emerge{Space} 
Else IfEqual key0, RTUOGH>, Send Thorough{Space}
 Else IfEqual key0, WTO:, Send Two{Space} 
Else IfEqual key0, EPAL>, Send Appeal{Space}
Else IfEqual key0, EIASL>, Send Liaise{Space} 
Else IfEqual key0, ERAKB>, Send Brake{Space} 
 Else IfEqual key0, TVM>, Send Motivate{Space} 
Else IfEqual key0, ERA>, Send Rear{Space} 
Else IfEqual key0, RTDC>, Send Direct{Space} 
Else IfEqual key0, ERA:, Send Era{Space} 
Else IfEqual key0, TUOGH>, Send Ought{Space} 
 Else IfEqual key0, HM>, Send Mm-Mmm.{Space} 
 Else IfEqual key0, ESL>, Send Less{Space} 
 Else IfEqual key0, ETAN>, Send Tenant{Space} 
Else IfEqual key0, RTFH>, Send Further{Space} 
 Else IfEqual key0, TIVN>, Send Invite{Space} 
 Else IfEqual key0, ESDN>, Send Dense{Space} 
Else IfEqual key0, ERIAS, Send Easier{Space} 
Else IfEqual key0, RTLN>, Send Natural{Space} 
Else IfEqual key0, >ERTPSN, Send Represent{Space} 
Else IfEqual key0, ERF>, Send Refer{Space} 
Else IfEqual key0, ETSH>, Send Sheet{Space} 
Else IfEqual key0, ON>, Send Non{Space} 
Else IfEqual key0, RTIPN>, Send Interrupt{Space} 
Else IfEqual key0, TAS>, Send Asset{Space} 
Else IfEqual key0, SCNM>, Send Musician{Space} 
 Else IfEqual key0, TGVN>, Send Vintage{Space} 
 Else IfEqual key0, RTSG>, Send Register{Space} 
 Else IfEqual key0, EIVN>, Send Vine{Space} 
 Else IfEqual key0, ETAS>, Send Taste{Space} 
Else IfEqual key0, ETSN>, Send Nest{Space} 
 Else IfEqual key0, TAN>, Send {BackSpace} ant{Space} 
 Else IfEqual key0, EON>, Send None{Space} 	
 Else IfEqual key0, APL>, Send Appeal{Space} 
 Else IfEqual key0, EIS>, Send {BackSpace}{BackSpace} ies{Space} 	
Else IfEqual key0, ASB>, Send Bass{Space} 
Else IfEqual key0, DLB>, Send Double{Space} 
Else IfEqual key0, EAG>, Send {BackSpace} age{Space} 
Else IfEqual key0, ECN>, Send {BackSpace} ence{Space} 
Else IfEqual key0, ERTA>, Send Treat{Space} 
Else IfEqual key0, ERTCN>, Send Center{Space} 
Else IfEqual key0, ETA>, Send Eat{Space} 
Else IfEqual key0, IPSH>, Send Ship{Space} 
Else IfEqual key0, RPSF>, Send Professor{Space} 
Else IfEqual key0, RTG>, Send Guitar{Space} 
Else IfEqual key0, RTLB>, Send Terrible{Space} 
Else IfEqual key0, RTPA>, Send Appropriate{Space} 
Else IfEqual key0, RTPC>, Send Participate{Space} 
Else IfEqual key0, RTPN>, Send Partner{Space} 
Else IfEqual key0, RTUH>, Send Truth{Space} 
Else IfEqual key0, TGN>, Send Negotiation{Space} 
Else IfEqual key0, TIDN>, Send Identity{Space} 
Else IfEqual key0, TIH>, Send Hit{Space} 
Else IfEqual key0, TPLC>, Send Political{Space} 
Else IfEqual key0, TSN>, Send Situation{Space} 
Else IfEqual key0, TY>, Send Youtube{Space} 
Else IfEqual key0, WN>, Send No Worries.{Space} 
 Else IfEqual key0, ADB>, Send Bad{Space} 
 Else IfEqual key0, ASB>, Send Bass{Space} 
Else IfEqual key0, EFL>, Send Fell{Space} 
Else IfEqual key0, EIFV>, Send Five{Space} 
Else IfEqual key0, EIN>, Send Nine{Space} 
Else IfEqual key0, EIV>, Send {BackSpace} ive{Space} 
Else IfEqual key0, EM>, Send Em{Space} 
Else IfEqual key0, ERAN>, Send Earn{Space} 
Else IfEqual key0, ERTH>, Send Three{Space} 
Else IfEqual key0, ESH>, Send He's{Space} 
Else IfEqual key0, ESVN>, Send Seven{Space} 
Else IfEqual key0, ETIGH>, Send Eight{Space} 
Else IfEqual key0, ETON>, Send Tone{Space} 
Else IfEqual key0, ISX>, Send Six{Space} 
Else IfEqual key0, RPA>, Send Appear{Space} 
Else IfEqual key0, RUOF>, Send Four{Space} 
Else IfEqual key0, TIL>, Send Till{Space} 
Else IfEqual key0, TOSH>, Send Shoot{Space} 
Else IfEqual key0, WTO>, Send Two{Space} 
 Else IfEqual key0, RTOS>, Send Sort Of{Space} 
 Else IfEqual key0, OG>, Send Going{Space} 
 Else IfEqual key0, TISH>, Send Shit{Space} 
 Else IfEqual key0, TM>, Send Might{Space} 
 Else IfEqual key0, IDF>, Send Difficult{Space} 
 Else IfEqual key0, TDN>, Send Didn't{Space} 
 Else IfEqual key0, TIDN>, Send Didn't{Space} 
 Else IfEqual key0, ER>, Send Re
 Else IfEqual key0, ERP>, Send Pre
 Else IfEqual key0, EM>, Send Them{Space} 
 Else IfEqual key0, IG>, Send Instagram{Space} 
 Else IfEqual key0, FB>, Send Facebook{Space} 
 Else IfEqual key0, GL>, Send Google{Space} 
 Else IfEqual key0, ID>, Send I'd{Space} 
 Else IfEqual key0, OK>, Send Okay{Space} 
 Else IfEqual key0, SM>, Send So Much{Space} 
 Else IfEqual key0, ETC>, Send Technology{Space} 
 Else IfEqual key0, TH>, Send Th{Space} 
 Else IfEqual key0, TSH>, Send That's{Space} 
 Else IfEqual key0, EV>, Send Ve{Space} 
 Else IfEqual key0, C>, Send See{Space} 
 Else IfEqual key0, U>, Send You{Space} 
 Else IfEqual key0, N>, Send And{Space} 
 Else IfEqual key0, T>, Send The{Space} 
 Else IfEqual key0, Y>, Send Yeah{Space} 
 Else IfEqual key0, B>, Send But{Space} 
 Else IfEqual key0, TION>, Send Ition{Space} 
 Else IfEqual key0, W>, Send With{Space} 
 Else IfEqual key0, P>, Send Pretty{Space} 
 Else IfEqual key0, K>, Send Know{Space} 
 Else IfEqual key0, Q>, Send Quick{Space} 
 Else IfEqual key0, G>, Send Great{Space} 
 Else IfEqual key0, L>, Send Like{Space} 
 Else IfEqual key0, R>, Send Really{Space} 
 Else IfEqual key0, SH>, Send Sh{Space} 
 Else IfEqual key0, J>, Send Just{Space} 
 Else IfEqual key0, M>, Send Much{Space} 
 Else IfEqual key0, E>, Send Even{Space} 
 Else IfEqual key0, D>, Send Ed{Space} 
 Else IfEqual key0, F>, Send For{Space} 
 Else IfEqual key0, V>, Send Very{Space} 
 Else IfEqual key0, IO>, Send {BackSpace}{BackSpace} tion{Space} 
 Else IfEqual key0, TH>, Send Th{Space} 
 Else IfEqual key0, HC>, Send Ch{Space} 
 Else IfEqual key0, TO>, Send Too{Space} 
 Else IfEqual key0, TUAGH>, Send Aught{Space} 
 Else IfEqual key0, OCN>, Send Con{Space} 
 Else IfEqual key0, ERA>, Send Are{Space} 
 Else IfEqual key0, GC>, Send Seeing{Space} 
 Else IfEqual key0, WYA>, Send Away{Space} 
 Else IfEqual key0, WAS>, Send Saw{Space} 
 Else IfEqual key0, 3>, Send Three{Space} 
 Else IfEqual key0, 1>, Send One{Space} 
 Else IfEqual key0, 2>, Send Two{Space} 
 Else IfEqual key0, 4>, Send Four{Space} 
 Else IfEqual key0, 5>, Send Five{Space} 
 Else IfEqual key0, EX>, Send Exact{Space} 
 Else IfEqual key0, 6>, Send Six{Space} 
 Else IfEqual key0, 7>, Send Seven{Space} 
 Else IfEqual key0, 8>, Send Eight{Space} 
 Else IfEqual key0, 9>, Send Nine{Space} 
 Else IfEqual key0, 0>, Send 10{Space} 
 Else IfEqual key0, WOH>, Send Who{Space} 
 Else IfEqual key0, ETL>, Send Tell{Space} 
 Else IfEqual key0, ERTS>, Send Stress{Space} 
 Else IfEqual key0, ST>, Send St{Space} 
 Else IfEqual key0, TOPS>, Send Post{Space} 
 Else IfEqual key0, TIS>, Send Sit{Space} 
 Else IfEqual key0, ASHL>, Send Shall{Space} 
 Else IfEqual key0, ESD>, Send Seed{Space} 
 Else IfEqual key0, WAS>, Send Saw{Space} 
 Else IfEqual key0, WON>, Send Own{Space} 
 Else IfEqual key0, ON>, Send On{Space} 
 Else IfEqual key0, ETFL>, Send Left{Space} 
 Else IfEqual key0, WTAH>, Send Thaw{Space} 
 Else IfEqual key0, OF>, Send Off{Space} 
 Else IfEqual key0, EANM>, Send Name{Space} 
 Else IfEqual key0, EILV>, Send Evil{Space} 
 Else IfEqual key0, EPK>, Send Peek{Space} 
 Else IfEqual key0, RTUH>, Send Hurt{Space} 
 Else IfEqual key0, TOH>, Send Hot{Space} 
 Else IfEqual key0, ISH>, Send Ish{Space} 
 Else IfEqual key0, ERH>, Send Here{Space} 
 Else IfEqual key0, OG>, Send Original{Space} 
 Else IfEqual key0, ED>, Send De
 Else IfEqual key0, TOPS>, Send Post
 Else IfEqual key0, ISM>, Send Mis{Space} 
 Else IfEqual key0, AL>, Send {BackSpace} al{Space} 
 Else IfEqual key0, S>, Send {BackSpace} s{Space} 
 Else IfEqual key0, ESN>, Send {BackSpace} ness{Space} 
 Else IfEqual key0, I>, Send I{Space} 
 Else IfEqual key0, A>, Send A{Space} 
 Else IfEqual key0, UFL>, Send {BackSpace} ful{Space} 
 Else IfEqual key0, ER>, Send Re
 Else IfEqual key0, TOH>, Send Oth{Space} 
 Else IfEqual key0, TON>, Send Ton{Space} 
Else IfEqual key0, YAL>, Send {BackSpace} ally{Space} 
Else IfEqual key0, ABLE>, Send Able
Else IfEqual key0, UA>, Send Ua 
Else IfEqual key0, EDN>, Send End{Space} 
Else IfEqual key0, ER>, Send {BackSpace} er
Else IfEqual key0, ETM>, Send Meet{Space} 
Else IfEqual key0, ETG>, Send Getting{Space} 
Else IfEqual key0, AL>, Send {BackSpace} al
Else IfEqual key0, TOPS>, Send Post{Space} 
Else IfEqual key0, EAG>, Send Age
Else IfEqual key0, ERTIH>, Send Either{Space} 
Else IfEqual key0, GV>, Send Giving{Space} 
Else IfEqual key0, ERASHC>, Send Research{Space} 
Else IfEqual key0, EDF>, Send Feed{Space} 
Else IfEqual key0, EOSHC>, Send Choose{Space} 
Else IfEqual key0, EIGBN>, Send Beginning{Space} 
Else IfEqual key0, OPSH>, Send Shops{Space} 
Else IfEqual key0, ESM>, Send Seems{Space} 
Else IfEqual key0, ERTAL>, Send Relate{Space} 
Else IfEqual key0, ETIS>, Send {BackSpace} ities{Space} 
Else IfEqual key0, TOL>, Send Tool{Space} 
Else IfEqual key0, TASF>, Send Staff{Space} 
Else IfEqual key0, SN>, Send Season{Space} 
 Else IfEqual key0, ISGN>, Send Sing{Space} 
 Else IfEqual key0, ERPA>, Send Paper{Space} 
 Else IfEqual key0, ES>, Send {BackSpace} es{Space} 
Else IfEqual key0, EPSDN>, Send Depends{Space} 
Else IfEqual key0, RTLC>, Send Critical{Space} 
Else IfEqual key0, ERTPSN>, Send Represent{Space} 
Else IfEqual key0, OAGLN>, Send Analog{Space} 
Else IfEqual key0, RAL>, Send Lar
Else IfEqual key0, TAHC>, Send Attach{Space} 
Else IfEqual key0, ERTPAN>, Send Parent{Space} 
Else IfEqual key0, IGH>, Send Igh{Space} 
Else IfEqual key0, ETS>, Send Test{Space} 	
Else IfEqual key0, ETSN>, Send Sent{Space} 
Else IfEqual key0, ESFL>, Send Self{Space} 
Else IfEqual key0, EPAL>, Send Apple{Space} 
Else IfEqual key0, EISCN>, Send Science{Space} 
Else IfEqual key0, RTLV>, Send Virtual{Space} 
Else IfEqual key0, TS>, Send Street{Space} 
Else IfEqual key0, ODG>, Send Dog{Space} 
Else IfEqual key0, ERTIN>, Send Internet{Space} 
Else IfEqual key0, RTPCN>, Send Corporation{Space} 
Else IfEqual key0, WERTI>, Send Twitter{Space} 
Else IfEqual key0, ERAC>, Send Race{Space} 
Else IfEqual key0, ERUS>, Send User{Space} 
Else IfEqual key0, RAC>, Send Car{Space} 
Else IfEqual key0, ROADB>, Send Broad{Space} 
Else IfEqual key0, WERA>, Send Aware{Space} 
Else IfEqual key0, WRTOH>, Send Worth{Space} 
Else IfEqual key0, ERTAFH>, Send Farther{Space} 
Else IfEqual key0, YPAL>, Send Apply{Space} 
Else IfEqual key0, RTPC>, Send Capture{Space} 
Else IfEqual key0, ERUPS>, Send Pressure{Space} 
Else IfEqual key0, ESL>, Send Sell{Space} 
Else IfEqual key0, EIFL>, Send File{Space} 
Else IfEqual key0, WEAK>, Send Wake{Space} 
Else IfEqual key0, DEADL>, Send Lead{Space} 
 Else IfEqual key0, WER:, Send We're{Space} 
 Else IfEqual key0, ESH:, Send He's{Space} 
 Else IfEqual key0, ID:, Send I'd{Space} 
 Else IfEqual key0, YAL:, Send Y'all{Space} 
 Else IfEqual key0, WOSH:, Send Who's{Space} 
 Else IfEqual key0, TID'N, Send Didn't{Space} 
 Else IfEqual key0, TS:, Send That's{Space}
Else IfEqual key0, AD>, Send Add{Space} 
Else IfEqual key0, EASC>, Send Access{Space} 
Else IfEqual key0, EOLV>, Send Evolve{Space} 
Else IfEqual key0, EPASH>, Send Phase{Space} 
Else IfEqual key0, ERTAL>, Send Alter{Space} 
Else IfEqual key0, FL>, Send Full{Space} 
Else IfEqual key0, TIL>, Send It'll{Space} 
Else IfEqual key0, TIL:, Send It'll{Space} 
Else IfEqual key0, TPLN>, Send Population{Space} 
Else IfEqual key0, VM>, Send Movie{Space} 
Return
