# stenotypy AKA Spellbook

Sick of typing every letter in serial like a schmuck? You've come to the right place. Words at once is how we think about our language, so it's how we should output it digitally as well.

AHK QWERTY (and beyond for the Dvorak et al oddballs) chord dictionary based on Laszlo's code https://www.autohotkey.com/board/topic/6426-chording-keyboard-strings-sent-at-key-combinations/

Requires Autohotkey which is a free program for scripting Windows automation (keystrokes, mouse movements, etc) https://www.autohotkey.com/ Simply download autohotkey and then launch Spellbook.ahk which is available here.

- Please note some keyboards will not completely work based on their matrix. Mechanical keyboards are recommended, but my laptop keyboard works surprisingly well (not perfectly) so YMMV

This is a dictionary I built for myself to work faster and with less fatigue as a transcriptionist. It has many full spellings, common abbreviations, and shortcuts for common words. I found stenography fascinating, but thought that the phonetic spelling concept and new keyboard were actually taking me longer to learn than generating my own spellings for a layout that was intuitive to me. There is also the massive benefit of being able to casually type single letters and chords interchangeably much more easily than with a stenographic keyboard, allowing for a smoother learning curve and simple compensation for library holes. Please use it if it makes any sense to you or learn from it to build your own!

If you disagree on the spellings I've chosen or observe some of the many holes in entries, please fork the repository and share what you've come up with that works better!

Technical Stuff and Rules
- Please Read Laszlo's post at the top
The only addiition I made to the code beyond my words is I branched the SENDs using first letters to avoid hitting the recursion limit and keep things neater. Starting at line 83 you can see how each word is checked to see what letter it begins with (the QWERTY spelling, not the word/chord (jump = upjm)). When adding words, they must be put in the corresponding "chapter." SENDDOT is used for words containing . 
-  There is a chunk at line 72 which determines what time period in ms your inputs are chunked by, which will impact single letter typing speed and chord ease inversely.
- Definitions are entered using the keys in QWERTY order, and then Send ____ If you look at the script, the syntax is fairly clear.

Logic Outline
- Please reference this article for more comprehensive theory https://griffonagedotcom.wordpress.com/2018/11/20/shorthand-on-the-qwerty-keyboard-1875-1917/

Full Words: Just hit the letters in the word! how (how), their (their)

Fewest Letters to Generate Unique Memorable Identifer: conversation (cnv), executive (xc), company (cmp), department (dpt), amazing (amg)

Subtracted Vowels Unless Vowel is First Letter or First Letter Makes Vowel Sound (Words without vowels that sound/look close enough): multiple (mltpl -> mltp), again (agn), examine (xmn), relation (rltn), compensate (cmpnst), cool (cl)

Word Chunks *Suffixes that end full roots (moral + ity) automatically backspace to compensate for the space at the end of words*: {backspace}ity (ity), ought (ought), br (br) , {backspace}tion (io), {backspace}ship (ship), {backspace}ing (ing)

Phrases: I don't know (idk), Oh my god. (omg), I think (ith), I know (ik),  all (al) right (rt) -> all right (alrt)

Common Abbreviations: because (bc), about (ab), Instagram (ig.), I guess (ig), years (yrs)

Shortcuts: nothing (ng), everything (eg), nobody (nbd), just (j.), and (n.), much (m.), know (k.), wouldn't (wdn), before (bf)

Plural/Apostrophe *Automatically backspace to compensate for the space at the end of words*: {backspace}n't (n't), {backspace}'s ('s), {backspace}s (s.)


Weird stuff (frequently used to avoid common spellings): 
- SENDDOT (words including .) uses period as a modifier for words with common spellings. This can be extended to other punctuation so long as SENDs are added accordingly (update the sorting that starts at line 83 with something like SENDSLASH (positioning must be according to QWERTY order), and then also add SENDSLASH below following the same format as the other SENDs)
- no (ib) This is because of on (on) and non (on.) I tried to layer them but either way I repeatedly would hit the wrong one so I just moved it over a row. Similarly, trying (trg) rather than (tryg) because the Y gummed up the works and made it two handed. Also, gone (gon), enough (enog).
- Also I use g to signify ing and io to signify tion in spellings. If a word already contains g like go, I use . for going (go.)
- related to above, thing (tg) things (tgs), bring (brg)
- going to (gonna -> gona), got you (gotcha)
- every (ery) to avoid very and because "erryday" makes it stick in my mind and rye is very infrequently used


Common Combos: thought (though (tho) + backspace + t) or (th (th.) + ought (ought)), brought (br (br) + ought)

These are just examples, I can't generate a comprehensive explanation at this point so ctrl F is really going to be your friend. I can also hear you saying, "Hey, wouldn't it standardized rules be awesome instead of this hodge podge of ideas put together on the fly?!" To that I respond emphatically that, yes, it would be great. You are welcome to give it a shot. I'm fairly sure language itself is a hodge podge of ideas put together on the fly, so it kind of mandates some oddity and idiosyncracy when you try to contract it.

---------------
"Does it work?"
- I was able to match/break my standard typing speed (90-105 WPM) with this dictionary using many fewer strokes before moving to a more editing based, mouse heavy workload and falling off a bit. I am confident with some time, love, and care it could reach stenographic speeds (200 WPM).
