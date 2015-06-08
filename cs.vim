"spaces instead of tabs
:se expandtab
:retab

"add spaces before and after '='
:%s/\(\a\|\d\)=/\1 =/gc
:%s/=\(\a\|\d\|\$\)/= \1/gc

"add spaces before and after '+='
:%s/\(\a\|\d\)+=/\1 +=/gc
:%s/+=\(\a\|\d\|\$\)/+= \1/gc

"add spaces after <= (less or equal)
:%s/<=\(\a\|\d\|\$\)/<= \1/gc

"add spaces after >= (greater or equal)
:%s/>=\(\a\|\d\|\$\)/>= \1/gc

"add space before < (less than)
:%s/\(\a\|\d\)</\1 </gc

"add space after < (less than)
:%s/<\(\a\|\$\|\d\)/< \1/gc

"add spaces before and after '=>'
:%s/\(\S\)=>/\1 =>/gc
:%s/=>\(\S\)/=> \1/gc

"remove trailing whitespace
:%s/\s\+\n/\r

"add space between foreach and (
:%s/foreach(/foreach (
"))

"add space between catch and (
:%s/catch(/catch (
"))

"add space between while and (
:%s/while(/while (
"))

"add space between for and (
:%s/for(/for (
"))

"elseif to else if
:%s/else if/elseif
":%s/elseif \(([^)]*)\)\n\s*{/elseif \1 {
"}}

"if bracket on same line
:%s/if \(.*)\)\n\s*{/if \1 {
"}}
"alternate?
"%s/if \(\w\+([^)]*)\)\n\s*{/if \1 {

"close bracket on same line as else
:%s/}\n\s*else/} else

"open bracket on same line as else
:%s/else\n\s*{/else {
"}}

"space for function(
:%s/function(/function (
"))

"function bracket on same line
"%s/function (\(.*[^\{]\)\n\s*{/function (\1 {/g "closures only
%s/function \(.*\)\s*\n\s\+{/function \1 {
"}}

"while bracket on same line
%s/while \(.*\)\s*\n\s\+{/while \1 {
"}}

"foreach bracket on same line
%s/foreach \(.*\)\s*\n\s\+{/foreach \1 {
"}}

"catch bracket on same line
%s/catch \(.*\)\s*\n\s\+{/catch \1 {
"}}

"for bracket on same line
%s/for \(.*\)\s*\n\s\+{/for \1 {
"}}

"switch bracket on same line
%s/switch \(.*\)\s*\n\s\+{/switch \1 {
"}}

"functions have space between them
:%s/}\n\(\s*.*\)function/}\r\r\1function

"change protected properties to no leading underscore
:%s/$_\([a-z]\)/$\1/gI
:%s/this->_\([a-z]\)/this->\1/gI

""add spaces between function args
":%s/,\$/, \$

"controller return this display() to return $return
:%s/return \$this->display(\$result);/\$return = \$this->display(\$result);\r        return \$return;

""add spaces before and after '+' and '-'
":%s/\(+\|-\)\(\$\|\d\)/\1 \2/cg
":%s/\(\d\|\a\)\(+\|-\) /\1 \2 /gc

"find multiline functions and arrays and make sure parenthesis are on separate lines
"/\a([^)\n]\+\(\n[^;]*\)\+);

"find multiline if statements and make sure conditionals are on separate lines
"/if ([^)\n]\+\(\n[^;]*\)\+) {

"find lines over 80 chars
"/.\{81,\}


"macros
"@p separate contents within parenthesis to separate lines
:let @p='f(ajjk$%ijjl%'

"@p separate contents within conditional parenthesis to separate lines
:let @o='0f(%ijjl%'

"@r return $return on a new line
:let @r='0wi$jjwwi= jjoreturn $return;jj'

"@c move additional conditionals to new lines
:let @c=':s/ \([&|]\{2\}\)/\r            \1/g'

"@l move function arguments to their own lines
:let @l=':s/, /,\r            /g=i('

