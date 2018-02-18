" Vim syntax file
" Language:     Vyper
" Maintainer:       Vivek Menon <https://vvkmnn.xyz>
" Prev Maintainer:   Tomlion (qycpublic@gmail.com)
" URL:              https://github.com/vyper.vim-vyper

" Only load this syntax file when no other was loaded.
if exists("b:current_syntax")
    finish
endif


" Keywords {{{
" ============

syn keyword vyperStatement break continue del
syn keyword vyperStatement exec return
syn keyword vyperStatement pass raise
syn keyword vyperStatement global nonlocal assert
syn match   vyperStatement "\<yield\>" display
syn match   vyperStatement "\<yield\s\+from\>" display
syn keyword vyperLambdaExpr lambda
syn keyword vyperStatement with as

syn keyword vyperStatement def nextgroup=vyperFunction skipwhite
syn match vyperFunction "\%(\%(def\s\|@\)\s*\)\@<=\h\%(\w\|\.\)*" contained nextgroup=vyperVars
syn region vyperVars start="(" skip=+\(".*"\|'.*'\)+ end=")" contained contains=vyperParameters transparent keepend
syn match vyperParameters "[^,]*" contained contains=vyperParam skipwhite
syn match vyperParam "[^,]*" contained contains=vyperExtraOperator,vyperLambdaExpr,vyperBuiltinObj,vyperBuiltinType,vyperConstant,vyperString,vyperNumber,vyperBrackets,vyperSelf,vyperComment skipwhite
syn match vyperBrackets "{[(|)]}" contained skipwhite

syn keyword vyperStatement class nextgroup=vyperClass skipwhite
syn match vyperClass "\%(\%(class\s\)\s*\)\@<=\h\%(\w\|\.\)*" contained nextgroup=vyperClassVars
syn region vyperClassVars start="(" end=")" contained contains=vyperClassParameters transparent keepend
syn match vyperClassParameters "[^,\*]*" contained contains=vyperBuiltin,vyperBuiltinObj,vyperBuiltinType,vyperExtraOperatorvyperStatement,vyperBrackets,vyperString,vyperComment skipwhite

syn keyword vyperRepeat        for while
syn keyword vyperConditional   if elif else
syn keyword vyperInclude       import
syn match   vyperInclude       "\<from\>"
syn keyword vyperException     try except finally
syn keyword vyperOperator      and in is not or

syn match vyperExtraOperator "\%([~!^&|/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\.\.\.\|\.\.\|::\)"
syn match vyperExtraPseudoOperator "\%(-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\)"

syn keyword vyperStatement print

syn keyword vyperStatement async await
syn match vyperStatement "\<async\s\+def\>" nextgroup=vyperFunction skipwhite
syn match vyperStatement "\<async\s\+with\>" display
syn match vyperStatement "\<async\s\+for\>" nextgroup=vyperRepeat skipwhite

syn match vyperExtraOperator "\%(=\)"

syn match vyperExtraOperator "\%(\*\|\*\*\)"

syn keyword vyperSelf self cls

" }}}


" Decorators {{{
" ==============

syn match   vyperDecorator "@" display nextgroup=vyperDottedName skipwhite
syn match   vyperDottedName "[a-zA-Z_][a-zA-Z0-9_]*\(\.[a-zA-Z_][a-zA-Z0-9_]*\)*" display contained
syn match   vyperDot        "\." display containedin=vyperDottedName

" }}}


" Comments {{{
" ============

syn match   vyperComment   "#.*$" display contains=vyperTodo,@Spell
syn match   vyperRun       "\%^#!.*$"
syn match   vyperCoding    "\%^.*\(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword vyperTodo      TODO FIXME XXX contained

" }}}


" Errors {{{
" ==========

syn match vyperError       "\<\d\+\D\+\>" display
syn match vyperError       "[$?]" display
syn match vyperError       "[&|]\{2,}" display
syn match vyperError       "[=]\{3,}" display

" Indent errors (mix space and tabs)
syn match vyperIndentError "^\s*\( \t\|\t \)\s*\S"me=e-1 display

" Trailing space errors
syn match vyperSpaceError  "\s\+$" display

" }}}


" Strings {{{
" ===========

syn region vyperString     start=+[bB]\='+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=vyperEscape,vyperEscapeError,@Spell
syn region vyperString     start=+[bB]\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=vyperEscape,vyperEscapeError,@Spell
syn region vyperString     start=+[bB]\="""+ end=+"""+ keepend contains=vyperEscape,vyperEscapeError,vyperDocTest2,vyperSpaceError,@Spell
syn region vyperString     start=+[bB]\='''+ end=+'''+ keepend contains=vyperEscape,vyperEscapeError,vyperDocTest,vyperSpaceError,@Spell

syn match  vyperEscape     +\\[abfnrtv'"\\]+ display contained
syn match  vyperEscape     "\\\o\o\=\o\=" display contained
syn match  vyperEscapeError    "\\\o\{,2}[89]" display contained
syn match  vyperEscape     "\\x\x\{2}" display contained
syn match  vyperEscapeError    "\\x\x\=\X" display contained
syn match  vyperEscape     "\\$"

" Unicode
syn region vyperUniString  start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=vyperEscape,vyperUniEscape,vyperEscapeError,vyperUniEscapeError,@Spell
syn region vyperUniString  start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=vyperEscape,vyperUniEscape,vyperEscapeError,vyperUniEscapeError,@Spell
syn region vyperUniString  start=+[uU]"""+ end=+"""+ keepend contains=vyperEscape,vyperUniEscape,vyperEscapeError,vyperUniEscapeError,vyperDocTest2,vyperSpaceError,@Spell
syn region vyperUniString  start=+[uU]'''+ end=+'''+ keepend contains=vyperEscape,vyperUniEscape,vyperEscapeError,vyperUniEscapeError,vyperDocTest,vyperSpaceError,@Spell

syn match  vyperUniEscape          "\\u\x\{4}" display contained
syn match  vyperUniEscapeError     "\\u\x\{,3}\X" display contained
syn match  vyperUniEscape          "\\U\x\{8}" display contained
syn match  vyperUniEscapeError     "\\U\x\{,7}\X" display contained
syn match  vyperUniEscape          "\\N{[A-Z ]\+}" display contained
syn match  vyperUniEscapeError "\\N{[^A-Z ]\+}" display contained

" Raw strings
syn region vyperRawString  start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=vyperRawEscape,@Spell
syn region vyperRawString  start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=vyperRawEscape,@Spell
syn region vyperRawString  start=+[rR]"""+ end=+"""+ keepend contains=vyperDocTest2,vyperSpaceError,@Spell
syn region vyperRawString  start=+[rR]'''+ end=+'''+ keepend contains=vyperDocTest,vyperSpaceError,@Spell

syn match vyperRawEscape           +\\['"]+ display transparent contained

" Unicode raw strings
syn region vyperUniRawString   start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=vyperRawEscape,vyperUniRawEscape,vyperUniRawEscapeError,@Spell
syn region vyperUniRawString   start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=vyperRawEscape,vyperUniRawEscape,vyperUniRawEscapeError,@Spell
syn region vyperUniRawString   start=+[uU][rR]"""+ end=+"""+ keepend contains=vyperUniRawEscape,vyperUniRawEscapeError,vyperDocTest2,vyperSpaceError,@Spell
syn region vyperUniRawString   start=+[uU][rR]'''+ end=+'''+ keepend contains=vyperUniRawEscape,vyperUniRawEscapeError,vyperDocTest,vyperSpaceError,@Spell

syn match  vyperUniRawEscape   "\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
syn match  vyperUniRawEscapeError  "\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

" String formatting
syn match vyperStrFormatting   "%\(([^)]\+)\)\=[-#0 +]*\d*\(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=vyperString,vyperUniString,vyperRawString,vyperUniRawString
syn match vyperStrFormatting   "%[-#0 +]*\(\*\|\d\+\)\=\(\.\(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=vyperString,vyperUniString,vyperRawString,vyperUniRawString

" Str.format syntax
syn match vyperStrFormat "{{\|}}" contained containedin=vyperString,vyperUniString,vyperRawString,vyperUniRawString
syn match vyperStrFormat "{\([a-zA-Z0-9_]*\|\d\+\)\(\.[a-zA-Z_][a-zA-Z0-9_]*\|\[\(\d\+\|[^!:\}]\+\)\]\)*\(![rs]\)\=\(:\({\([a-zA-Z_][a-zA-Z0-9_]*\|\d\+\)}\|\([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*\(\.\d\+\)\=[bcdeEfFgGnoxX%]\=\)\=\)\=}" contained containedin=vyperString,vyperUniString,vyperRawString,vyperUniRawString

" String templates
syn match vyperStrTemplate "\$\$" contained containedin=vyperString,vyperUniString,vyperRawString,vyperUniRawString
syn match vyperStrTemplate "\${[a-zA-Z_][a-zA-Z0-9_]*}" contained containedin=vyperString,vyperUniString,vyperRawString,vyperUniRawString
syn match vyperStrTemplate "\$[a-zA-Z_][a-zA-Z0-9_]*" contained containedin=vyperString,vyperUniString,vyperRawString,vyperUniRawString

" DocTests
syn region vyperDocTest    start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
syn region vyperDocTest2   start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained

" DocStrings
syn region vyperDocstring  start=+^\s*[uU]\?[rR]\?"""+ end=+"""+ keepend excludenl contains=vyperEscape,@Spell,vyperDoctest,vyperDocTest2,vyperSpaceError
syn region vyperDocstring  start=+^\s*[uU]\?[rR]\?'''+ end=+'''+ keepend excludenl contains=vyperEscape,@Spell,vyperDoctest,vyperDocTest2,vyperSpaceError


" }}}

" Numbers {{{
" ===========

syn match   vyperHexError  "\<0[xX]\x*[g-zG-Z]\x*[lL]\=\>" display
syn match   vyperHexNumber "\<0[xX]\x\+[lL]\=\>" display
syn match   vyperOctNumber "\<0[oO]\o\+[lL]\=\>" display
syn match   vyperBinNumber "\<0[bB][01]\+[lL]\=\>" display
syn match   vyperNumber    "\<\d\+[lLjJ]\=\>" display
syn match   vyperFloat "\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   vyperFloat "\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   vyperFloat "\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\=" display
syn match   vyperOctError  "\<0[oO]\=\o*[8-9]\d*[lL]\=\>" display
syn match   vyperBinError  "\<0[bB][01]*[2-9]\d*[lL]\=\>" display

" }}}

" Builtins {{{
" ============

" Builtin objects and types
syn keyword vyperBuiltinObj True False Ellipsis None NotImplemented
syn keyword vyperBuiltinObj __debug__ __doc__ __file__ __name__ __package__

syn keyword vyperBuiltinType type object
syn keyword vyperBuiltinType str basestring unicode buffer bytearray bytes chr unichr
syn keyword vyperBuiltinType dict int long bool float complex set frozenset list tuple
syn keyword vyperBuiltinType file super

" Builtin functions
syn keyword vyperBuiltinFunc   __import__ abs all any ascii
syn keyword vyperBuiltinFunc   bin bytearray bytes callable classmethod compile
syn keyword vyperBuiltinFunc   delattr dir divmod enumerate eval exec filter
syn keyword vyperBuiltinFunc   format getattr globals locals hasattr hash help hex id
syn keyword vyperBuiltinFunc   input isinstance issubclass iter len map max memoryview min
syn keyword vyperBuiltinFunc   next oct open ord pow property range
syn keyword vyperBuiltinFunc   repr reversed round setattr
syn keyword vyperBuiltinFunc   slice sorted staticmethod sum vars zip

syn keyword vyperBuiltinFunc   print


" Builtin exceptions and warnings
syn keyword vyperExClass   BaseException
syn keyword vyperExClass   Exception StandardError ArithmeticError
syn keyword vyperExClass   LookupError EnvironmentError
syn keyword vyperExClass   AssertionError AttributeError BufferError EOFError
syn keyword vyperExClass   FloatingPointError GeneratorExit IOError
syn keyword vyperExClass   ImportError IndexError KeyError
syn keyword vyperExClass   KeyboardInterrupt MemoryError NameError
syn keyword vyperExClass   NotImplementedError OSError OverflowError
syn keyword vyperExClass   ReferenceError RuntimeError StopIteration
syn keyword vyperExClass   SyntaxError IndentationError TabError
syn keyword vyperExClass   SystemError SystemExit TypeError
syn keyword vyperExClass   UnboundLocalError UnicodeError
syn keyword vyperExClass   UnicodeEncodeError UnicodeDecodeError
syn keyword vyperExClass   UnicodeTranslateError ValueError VMSError
syn keyword vyperExClass   WindowsError ZeroDivisionError
syn keyword vyperExClass   Warning UserWarning BytesWarning DeprecationWarning
syn keyword vyperExClass   PendingDepricationWarning SyntaxWarning
syn keyword vyperExClass   RuntimeWarning FutureWarning
syn keyword vyperExClass   ImportWarning UnicodeWarning

" }}}


" Highlight {{{
" =============

hi def link  vyperStatement    Statement
hi def link  vyperLambdaExpr   Statement
hi def link  vyperInclude      Include
hi def link  vyperFunction     Function
hi def link  vyperClass        Type
hi def link  vyperParameters   Normal
hi def link  vyperParam        Normal
hi def link  vyperBrackets     Normal
hi def link  vyperClassParameters Normal
hi def link  vyperSelf         Identifier

hi def link  vyperConditional  Conditional
hi def link  vyperRepeat       Repeat
hi def link  vyperException    Exception
hi def link  vyperOperator     Operator
hi def link  vyperExtraOperator        Operator
hi def link  vyperExtraPseudoOperator  Operator

hi def link  vyperDecorator    Define
hi def link  vyperDottedName   Function
hi def link  vyperDot          Normal

hi def link  vyperComment      Comment
hi def link  vyperCoding       Special
hi def link  vyperRun          Special
hi def link  vyperTodo         Todo

hi def link  vyperError        Error
hi def link  vyperIndentError  Error
hi def link  vyperSpaceError   Error

hi def link  vyperString       String
hi def link  vyperDocstring    String
hi def link  vyperUniString    String
hi def link  vyperRawString    String
hi def link  vyperUniRawString String

hi def link  vyperEscape       Special
hi def link  vyperEscapeError  Error
hi def link  vyperUniEscape    Special
hi def link  vyperUniEscapeError Error
hi def link  vyperUniRawEscape Special
hi def link  vyperUniRawEscapeError Error

hi def link  vyperStrFormatting Special
hi def link  vyperStrFormat    Special
hi def link  vyperStrTemplate  Special

hi def link  vyperDocTest      Special
hi def link  vyperDocTest2     Special

hi def link  vyperNumber       Number
hi def link  vyperHexNumber    Number
hi def link  vyperOctNumber    Number
hi def link  vyperBinNumber    Number
hi def link  vyperFloat        Float
hi def link  vyperOctError     Error
hi def link  vyperHexError     Error
hi def link  vyperBinError     Error

hi def link  vyperBuiltinType  Type
hi def link  vyperBuiltinObj   Structure
hi def link  vyperBuiltinFunc  Function

hi def link  vyperExClass      Structure
