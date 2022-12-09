; Dictionary by Solomon Kimrey, code from Laszlo https://www.autohotkey.com/board/topic/6426-chording-keyboard-strings-sent-at-key-combinations/
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
Else If StrLen(key0) = 1
      Send {%key0%}  

Return
SENDSLASH:
SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,ets/, Send {BackSpace}est{Space}
Else IfEqual key0,era/, Send ear{Space}
 Else IfEqual key0,r/, Send {BackSpace}r{Space}
Else IfEqual key0,tops/, Send spot{Space}
Else IfEqual key0,tosh/, Send host{Space}
Else IfEqual key0,ealb/, Send {BackSpace}{BackSpace}able{Space}
Else IfEqual key0,etas/, Send estate{Space}
Else IfEqual key0,wal/, Send law{Space}
Else IfEqual key0,esl/, Send {BackSpace}less{Space}
Else IfEqual key0,era/, Send ear avoid are rear{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,qerf, Send frequency{Space}
Else IfEqual key0,qerfn, Send frequent{Space}
Else IfEqual key0,qerui, Send require{Space}
Else IfEqual key0,qrac, Send acquire{Space}
Else IfEqual key0,qrts, Send request{Space}
Else IfEqual key0,qetui, Send quiet{Space}
Else IfEqual key0,qeuin, Send unique{Space}
Else IfEqual key0,qel, Send equal{Space}
Else IfEqual key0,qeru, Send queer{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,wa, Send as well{Space}
Else IfEqual key0,wtn, Send won't{Space}
Else IfEqual key0,werhvn, Send whenever{Space}
Else IfEqual key0,weoasm, Send awesome{Space}
Else IfEqual key0,wrpa, Send wrap{Space}
Else IfEqual key0,wan, Send want to{Space}
Else IfEqual key0,wehc, Send chew{Space}
Else IfEqual key0,weif, Send wife{Space}
Else IfEqual key0,weislv, Send swivel{Space}
Else IfEqual key0,werash, Send whereas{Space}
Else IfEqual key0,werhvn, Send whenever{Space}
Else IfEqual key0,werin, Send winner{Space}
Else IfEqual key0,weropm, Send empower{Space}
Else IfEqual key0,werosh, Send shower{Space}
Else IfEqual key0,werth, Send threw{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,ra, Send around{Space}
Else IfEqual key0,rtdln, Send traditional{Space}
Else IfEqual key0,ryc, Send cry{Space}
Else IfEqual key0,wrb, Send borrow{Space}
Else IfEqual key0,rhlb, Send horrible{Space}
Else IfEqual key0,rahcm, Send march{Space}
Else IfEqual key0,rdv, Send drive{Space}
Else IfEqual key0,rdbn, Send burden{Space}
Else IfEqual key0,rdgn, Send garden{Space}
Else IfEqual key0,rfcn, Send conference{Space}
Else IfEqual key0,rfnm, Send inform{Space}
Else IfEqual key0,rfnm, Send inform{Space}
Else IfEqual key0,riagc, Send cigar{Space}
Else IfEqual key0,rid, Send rid{Space}
Else IfEqual key0,ridb, Send bird{Space}
Else IfEqual key0,riofnm, Send inform{Space}
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
Else IfEqual key0,rypas, Send spray{Space}A
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
Else IfEqual key0,roadb, Send broad{Space}
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
Else IfEqual key0,rtyl, Send literally{Space}
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
   If StrLen(key0) = 1
    Send {%key0%} 
Else IfEqual key0,ta, Send at{Space}
Else IfEqual key0,tisv, Send visit{Space}
Else IfEqual key0,tihn, Send thin{Space}
Else IfEqual key0,tpsln, Send pleasant{Space}
Else IfEqual key0,tadcv, Send advocate{Space}
Else IfEqual key0,tahm, Send math{Space}
Else IfEqual key0,takn, Send tank{Space}
Else IfEqual key0,tasl, Send salt{Space}
Else IfEqual key0,tglv, Send vegetable{Space}
Else IfEqual key0,tgvn, Send navigate{Space}
Else IfEqual key0,tiafh, Send faith{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,yac, Send {BackSpace}acy{Space}
Else IfEqual key0,yad, Send day{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,ua, Send au
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,ea, Send ea	
Else IfEqual key0,epalcb, Send capable{Space}
Else IfEqual key0,eosln, Send lesson{Space}
Else IfEqual key0,ealcn, Send cancel{Space}
Else IfEqual key0,ealn, Send lane{Space}
Else IfEqual key0,etpasln, Send pleasant{Space}
Else IfEqual key0,eas, Send assess{Space}
Else IfEqual key0,eruips, Send surprise{Space}
Else IfEqual key0,easf, Send safety{Space}
Else IfEqual key0,efhc, Send chef{Space}
Else IfEqual key0,eialv, Send alive{Space}
Else IfEqual key0,eiasn, Send insane{Space}
Else IfEqual key0,eiasn, Send insane{Space}
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
Else IfEqual key0,eosn, Send ones{Space}
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
Else IfEqual key0,erp, Send pepper{Space}
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
Else IfEqual key0,ertyial, Send reality{Space}
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
Else IfEqual key0,etialnm, Send eliminate (etlmn is element){Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,oa, Send anyone{Space}
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
Else IfEqual key0,onm, Send mono
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,pac, Send cap{Space}
Else IfEqual key0,pk, Send keep{Space}	
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,ab, Send about{Space}
Else IfEqual key0,adv, Send avoid{Space}
Else IfEqual key0,adcvn, Send advance{Space}
Else IfEqual key0,askc, Send sack{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,sbn, Send business{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,dbn, Send nobody{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,fb, Send before{Space}

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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,gb, Send being{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,hc, Send choice{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,ia, Send ai
Else IfEqual key0,idfc, Send difficult{Space}
Else IfEqual key0,idm, Send mid{Space}
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
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,lb, Send little bit{Space}
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
   If StrLen(key0) = 1
    Send {%key0%} 
Else IfEqual key0,xc, Send executive{Space}
Else IfEqual key0,xnm, Send examine{Space}
Else IfEqual key0,xnm, Send expect{Space}
Return
SENDV:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%} 
Else IfEqual key0,vm, Send move{Space}
Else IfEqual key0,vn, Send even{Space}
Return
SENDB:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%} 
Else IfEqual key0,bm, Send maybe{Space}
Else IfEqual key0,bf, Send boyfriend{Space}
Else IfEqual key0,bn, Send been{Space}
Else IfEqual key0,bsc, Send basic{Space}
Else IfEqual key0,bscl, Send basically{Space}
Return
SENDC:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%} 
Else IfEqual key0,cb, Send because{Space}
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
   If StrLen(key0) = 1
    Send {%key0%} 
Else IfEqual key0,kc, Send {Backspace}ck{Space}
Else IfEqual key0,kl, Send look{Space}
Else IfEqual key0,kln, Send knowledge{Space}
Else IfEqual key0,km, Send make{Space}
Else IfEqual key0,kn, Send know{Space}
Return
SENDJ:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%}  
    
    Return
SENDZ:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,zm, Send Zoom{Space}

Return
SENDM:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%}  

Return
SENDN:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%} 
Else IfEqual key0,nm, Send mean{Space}
Return
SENDDOT:
   SentTick = %A_TickCount%            ; remember time of send
   SentKeys = %key0%
   If StrLen(key0) = 1
    Send {%key0%}  
Else IfEqual key0,r', Send {BackSpace}r{Space}
Else IfEqual key0,udn., Send understood{Space}
Else IfEqual key0,epsd., Send speed{Space}
Else IfEqual key0,eragn., Send arrange{Space}
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
Else IfEqual key0,etis., Send ities{Space}
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
Else IfEqual key0,roadb., Send board{Space}
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
