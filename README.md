# stenotypy AKA Spellbook

AHK QWERTY chord dictionary based on Laszlo's code https://www.autohotkey.com/board/topic/6426-chording-keyboard-strings-sent-at-key-combinations/

- Please note some keyboards will not completely work based on their matrix. Mechanical keyboards are recommended, but my laptop keyboard works surprisingly well (not perfectly) so YMMV

This is a dictionary I built for myself to work faster and with less fatigue as a transcriptionist. It has many full spellings, common abbreviations, and shortcuts for common words. I found stenography fascinating, but thought that the phonetic spelling concept and idiosyncratic keyboard were actually taking me longer to learn than generating my own spellings for a layout that was intuitive to me. There is also the massive benefit of being able to casually type single letters and chords interchangeably much more easily than with a stenographic keyboard, allowing for a smoother learning curve, simple compensation for library holes, and pidgin typing where you swap between techniques.

If you disagree on the spellings I've chosen or observe some of the many holes in entries, please fork the repository and share what you've come up with that works better!

Technical Stuff and Rules
- Please Read Laszlo's post at the top
The only addiition I made to the code beyond my words is I branched the SENDs by word to avoid hitting the recursion limit and keep things neater. Starting at line 83 you can see how each word is checked to see what letter it begins with (the QWERTY spelling, not the word/chord (jump = upjm)). When adding words, they must be put in the corresponding "chapter." SENDDOT is used for words containing . 
-  There is a chunk at line 72 which determines what time period in ms your inputs are chunked by, which will impact single letter typing speed and chord ease inversely.
- Definitions are entered using the keys in QWERTY order, and then Send ____ If you look at the script, the syntax is fairly clear.

Additional Notes
- I initially built this with a split ortholinear whose keymap I have attached. The keymap is essentially QWERTY, I just got rid of space (since all chords include space), then duplicated XCVBNM a row lower for my thumbs. I also used pedals for space and backspace. I have since switched from using that back to a common QWERTY layout as I am not typing as much as I am editing these days and I like my laptop for quick mouse pad access (+ using a mouse with most inputs destroyed my home row). I still use chords for most words, so I am confident you don't need anything crazy to get going. You will find there are still some longer multicharacter spellings where you need to barre keys with a single finger though, which ortho lends itself to. I also found the split ortho layout+keymap+pedals to be great for maintaining homerow. 

Logic Outline
- Please reference this article for more comprehensive theory https://griffonagedotcom.wordpress.com/2018/11/20/shorthand-on-the-qwerty-keyboard-1875-1917/

Full Words: Just hit the letters in the word! how (how), their (their)

Fewest Letters to Generate Unique Memorable Identifer: conversation (cnv), executive (xc), company (cmp), department (dpt) 

Subtracted Vowels Unless Vowel is First Letter or First Letter Makes Vowel Sound (Words without vowels that sound/look close enough): multiple (mltpl -> mltp), again (agn), examine (xmn), relation (rltn), compensate (cmpnst)

Word Chunks *Suffixes that end full roots (moral + ity) automatically backspace to compensate for the space at the end of words*: {backspace}ity (ity), ought (ought), br (br) , {backspace}tion (io), {backspace}ship (ship), {backspace}ing (ing)

Phrases: I don't know (idk), Oh my god. (omg), I think (ith), I know (ik),  all (al) right (rt) -> all right (alrt)

Common Abbreviations: because (bc), about (ab), Instagram (ig.), I guess (ig)

Shortcuts: nothing (ng), nobody (nbd), just (j.), and (n.), much (m.), know (k.), wouldn't (wdn), before (bf)

Plural/Apostrophe *Automatically backspace to compensate for the space at the end of words*: {backspace}n't (n't), {backspace}'s ('s), {backspace}s (s.)


Weird stuff: 
- SENDDOT (words including .) uses period as a modifier for words with common spellings. This can be extended to other punctuation so long as SENDs are added accordingly (update the sorting that starts at line 83 with something like SENDSLASH (positioning must be according to QWERTY order), and then also add SENDSLASH below following the same format as the other SENDs)
- barring multiple letters is new
- no (ib) This is because of on (on) and non (on.) I tried to layer them but either way I repeatedly would hit the wrong one so I just moved it over a row. Similarly, trying (trg) rather than (tryg) because the Y gummed up the works and made it two handed. Also, gone (gon), enough (enog).
- Also I use g to signify ing and io to signify tion in spellings. If a word already contains g like go, I use . for going (go.)
- going to (gonna -> gona), got you (gotcha)


Common Combos: thought (though (tho) + backspace + t) or (th (th.) + ought (ought)), brought (br (br) + ought)

These are just examples, I can't generate a comprehensive explanation at this point so ctrl F is really going to be your friend. I can also hear you saying, "Hey, wouldn't it standardized rules be awesome instead of this hodge podge of ideas put together on the fly?!" To that I respond emphatically that, yes, it would be great. You are welcome to give it a shot. I'm fairly sure language itself is a hodge podge of ideas put together on the fly, so it kind of mandates some oddity and idiosyncracy when you try to contract it.
