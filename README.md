# Spellbook

Sick of typing every letter serially like a schmuck? You've come to the right place. Words at once is how we think about our language, so it's how we should output it digitally as well.

QWERTY+ chord dictionary based on https://www.autohotkey.com/board/topic/6426-chording-keyboard-strings-sent-at-key-combinations/ Worth noting I use a split ortholinear keyboard, which makes barring letters very convenient.

Requires Autohotkey which is a free program for scripting Windows automation (keystrokes, mouse movements, etc) https://www.autohotkey.com/ Simply download autohotkey and then launch Spellbook.ahk which is available here.

Mechanical keyboards are best. Otherwise you may have a cap on character count or only certain amounts of letters per row/column at a time due to key matrices.

**Formatting Google Sheet: https://docs.google.com/spreadsheets/d/17YKyU0r6uJQZS2O3WcbopYCI5au4ueC6Ibu241bXTAI/edit?usp=sharing**

This is a dictionary I built for myself to work faster and with less fatigue as a transcriptionist. It has many full spellings, common abbreviations, and shortcuts for common words. I found stenography fascinating, but thought that the phonetic spelling concept and alternate keyboard took me longer to learn than generating spellings based on how words are spelled (crazy, right?). There is also the massive benefit of being able to casually type single letters and chords interchangeably with greater ease than a stenographic keyboard, allowing for a smoother learning curve and simple compensation for library holes. Please use it and build on it!

If you disagree on the spellings I've chosen or observe some of the many holes, please fork the repository and share what you've come up with that works better!

Technical Stuff and Rules
- Please Read Laszlo's post at the top

- Definitions are entered using the keys in QWERTY order, and then Send ____ If you look at the script, the syntax is fairly clear.

- CTRL + F for these lines to modify the time window that defines a chord vs a single character, how long between subsequent presses to count as a single chord
     Else {                              ; NO KEY CHANGE keys == key0
      if (keys = ""
       or A_TickCount - KeyTick  < 20  and keyn = 0
       or A_TickCount - SentTick < 360 and keyn = 1
       or A_TickCount - SentTick < 37 and keyn > 1)
         Return
      keyn++
      GoTo SEND
      

Logic Outline
- Please reference this article for more comprehensive theory https://griffonagedotcom.wordpress.com/2018/11/20/shorthand-on-the-qwerty-keyboard-1875-1917/

Full Words: Just hit the letters in the word! how (how), their (their)

; - modifier for starting sentence. period, space, capital

. , ' / - modifiers for accessing alternate spellings

single letter . - this sends the most common word beginning with the letter

single letter / - backspace letter space

single letter ; - - backspace backspace letter space

shift works like shift, capitalizes word

Fewest Letters to Generate Unique Memorable Identifer: conversation (cnv), executive (xc), company (cmp), department (dpt), amazing (amg), communicate (cmu)

Subtracted Vowels Unless Vowel is First Letter or First Letter Makes Vowel Sound (Words without vowels that sound/look close enough): multiple (mltpl -> mltp), again (agn), examine (xmn), relation (rltn), compensate (cmpnst), cool (cl)

Word Chunks *Suffixes that end full roots (moral + ity) automatically backspace to compensate for the space at the end of words*: {backspace}ity (ity), ought (ought), br (br) , {backspace}tion (io), {backspace}ship (ship), {backspace}ing (ing)

Phrases: I don't know (idk), Oh my god. (omg), I think (ith), I know (ik),  all (al) right (rt) -> all right (alrt)

Common Abbreviations: because (bc), about (ab), Instagram (ig.), I guess (ig), years (yrs)

Shortcuts: nothing (ng), everything (eg), nobody (nbd), just (j.), and (n.), much (m.), know (k.), wouldn't (wdn), before (bf)

Plural/Apostrophe: *Automatically backspace to compensate for the space at the end of words*: {backspace}n't (n't), {backspace}'s ('s), {backspace}s (s.)

Capitalization: Just use shift and a chord!

Sentence starting: To avoid separate strokes for period, space, shift, word/letter at the beginning of a sentence, adding ; to a word capitalizes it and adds a period to the word before.

Weird stuff (frequently used to avoid common spellings): 
- SENDDOT (words including .) uses period as a modifier for words with common spellings. This can be extended to other punctuation so long as SENDs are added accordingly (update the sorting that starts at line 83 with something like SENDSLASH (positioning must be according to QWERTY order), and then also add SENDSLASH below following the same format as the other SENDs)
- no (ib) This is because of on (on) and non (on.) I tried to layer them but either way I repeatedly would hit the wrong one so I just moved it over a row. Similarly, trying (trg) rather than (tryg) because the Y gummed up the works and made it two handed. Also, gone (gon), enough (enog).
- Also I use g to signify ing and io to signify tion in spellings. If a word already contains g like go, I use . for going (go.) Interest (int) so interesting (intg)
- related to above, thing (tg) things (tgs), bring (brg)
- going to (gonna -> gona), got you (gotcha)


These are just examples, I can't generate a comprehensive explanation at this point so ctrl F is really going to be your friend. I can also hear you saying, "Hey, wouldn't it standardized rules be awesome instead of this hodge podge of ideas put together on the fly?!" To that I respond emphatically that, yes, it would be great. You are welcome to give it a shot. I'm fairly sure language itself is a hodge podge of ideas put together on the fly, so it kind of mandates some oddity and idiosyncracy when you try to contract it.

---------------
"Does it work?"
- I was able to match/break my standard typing speed (90-105 WPM) with this dictionary using many fewer strokes before moving to a more editing based, mouse heavy workload and falling off a bit. I am confident with some time, love, and care it could reach stenographic speeds (200 WPM).
