# RegExp notes
This file mostly describes regular expressions as in R (POSIX BRE and ERE), but also partly covers vim patterns and flags

## NB!
All escapings in R's regexps should _be double-escaped_ (unlike using in, e.g. `cat()` or `writeLines()` call)
This also concerns replacement patterns, e.g. `\\1` for backreferencing.

`. () []` and so on _without escaping_ are _special symbols_ (unlike in vim)

In vim _all special symbols_ but `. * ^ $` _should be single-escaped!_

`. * ^ $` in vim _without escaping_ are special symbols, and _being escaped_ mean literally what they are.

## Escapings 
`\a` - BEL

`\e` - ESC

`\f` - FF

`\n` - LF

`\r` - CR

`\t` - TAB

`\d` - digit class

`\D` - its negation

`\s` - space class

`\S` - its negation

`\<` - empty string at the beginning of the word ('word' is locale-dependent)

`\>` - empty string at the end of the word

`\b` - previous two both

`\B` - empty string provided it is not at an edge of a word

`\w` - word (a synonym for `[[:alnum:]_]`)

`\W` - its negation

`\1 ... \9` - numbered backreference

`\U \L` - change the text inserted by all following backreferences to uppercase or lowercase [Ex.2]

`\E` - insert the following backreferences without any change of case

## Parentheses
`[a,b,c-e]` - a OR b OR c OR d OR e

`[^a,b]` - not a, nor b

`()` - grooping with capturing

`(?: )` - grooping without capturing

`(regex)*` - modifier `*` belongs to the whole group in `()` [Ex.3]

`(regex1) | (regex2)` - regex1 OR regex2 [Ex.4]

`{}` - quantifier (see below)

## Predefined classes (locale-dependent)
`[:alnum:]` - Alphanumeric characters: `[:alpha:]` and `[:digit:]`

`[:alpha:]` - Alphabetic characters: `[:lower:]` and `[:upper:]`

`[:blank:]` - Blank characters: space and tab, and possibly other locale-dependent characters such as non-breaking space

`[:cntrl:]` - Control characters. In ASCII, these characters have octal codes 000 through 037, and 177 (DEL). In another character set, these are the equivalent characters, if any

`[:digit:]` - Digits: `0 1 2 3 4 5 6 7 8 9`

`[:graph:]` - Graphical characters: `[:alnum:]` and `[:punct:]`

`[:lower:]` - Lower-case letters in the current locale

`[:print:]` - Printable characters: `[:alnum:]`, `[:punct:]` and space

`[:punct:]` - Punctuation characters: ``! " $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~``

`[:space:]` - Space characters: tab, newline, vertical tab, form feed, carriage return, space and possibly other locale-dependent characters

`[:upper:]` - Upper-case letters in the current locale

`[:xdigit:]` - Hexadecimal digits: `0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f`

`.` - any single character

`^` - empty space at the beginning of the line

`$` - empty space at the end of the line

## Modifiers and Quantifiers
`?` - The preceding item is optional and will be matched at most once

(In vim's search syntax `=` is used for that, e.g. `/files\=`)

`*` - The preceding item will be matched zero or more times

`+` - The preceding item will be matched one or more times

`{n}` - The preceding item is matched exactly ‘n’ times

`{n,}` - The preceding item is matched ‘n’ or more times

`{n,m}` - The preceding item is matched at least ‘n’ times, but not more than ‘m’ times

Normally, a repeated expression is greedy, that is, it matches as many characters as possible.

`{ }?` makes the quantifier minimal, or non-greedy (also works for one-character quantifiers, like `*?` ).
A non-greedy subexpression matches as few characters as possible.
(vim uses `{- , }` for that, e.g. `/ab\{-1,3}`)

## Examples
### vim

1. `\*(\w+)\*` matches any word between asteriscs
2. `Set(Value)?` matches 'Set' or 'SetValue'
3. `color=(red|green|blue)`
4. `\b(\w+)\s+\1\b` matches duplicated words, like "the the"
5. `\<\u\l\+\>\` matches a word beginning with an uppercase letter

### R
1.
```
sub("(a+)", "z\\U\\1z", c("abc", "def", "cba a", "aa"), perl=TRUE)
#[1] "zAzbc"  "def"  "cbzAz a"   "zAAz"
gsub("(a+)", "z\\1z", c("abc", "def", "cba a", "aa"), perl=TRUE)
#[1] "zAzbc"  "def"  "cbzAz zAz" "zAAz"
```
2.
```
taxa <- c("Limulus polyphemus  ", "Gammaridae ", "Amphipoda", " macoma balthica", "Babr   baikali")
taxa <- sub('\\+$', '', sub('^\\s*(\\w+)\\s*(\\w*)\\s*', '\\1\\+\\2', taxa))
# Remove extra spaces and turn a space between genus and species into plus sign
```
7.
```
Species <- "Gammarus tigrinus Sexton, 1939"
Auth <- regmatches(Species, regexpr("\\S*, \\d{4}\\)*", Species))
# "Sexton, 1939"
```
8.
```
# Splitting/removing "Species/Subgenus" and cutting occasional "tails" (like "\n» ")
childBlock <- "Macoma (Macalia) H. Adams, 1861 represented as Macalia H. Adams, 1861 (alternate representation)  » Species Macoma (Macalia) bruguieri (Hanley, 1844) represented as Macalia bruguieri (Hanley, 1844) (alternate representation)\nSubgenus Macoma (Macoma) Leach, 1819 represented as Macoma Leach, 1819 (alternate representation)  » Species Macoma (Macoma) coani Kafanov & Lutaenko, 1999 represented as Macoma coani Kafanov & Lutaenko, 1999 (alternate representation)\n» "
Children <- sub('(representation\\)).*$', '\\1', unlist(strsplit(childBlock, '[\n]?Species |Subgenus ')))[-1]
```