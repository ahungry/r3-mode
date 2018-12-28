Red [
	Title: "Rebol IDE Toolkit"
	Date: 29-July-2013
	File: %ide.r
	Author: "Inaimathi"
	Email: leo.zovic@gmail.com
	License: http://www.gnu.org/licenses/gpl-3.0.html
]

ide: context [
	args: func [word [any-type!]] [
		spec-of :word
	]
	arg-hint: func [ block [block!] ] [
		foreach w block [
			prin mold w
			prin " :: "
			if res: args w
			[ print mold res ]
			[ print " " ]
		]
	]
	completions-in: func ['word [any-type!]] [
		wd: get :word
		case [
			object? wd [ collect [ foreach [word val] wd [ keep word ]]]
		]
	]

	;; used to generate the highlighting keywords
	search-lib: func [ type ] [
		ty: form type
		foreach [ word val ] lib [
			if ty = form type?/word :val [
				print word
			]
		]
	]
	symbol-group: func [ label types ] [
		prin "R3IDE-NEW-KEYWORDS: "
		print label
		foreach t types [
			search-lib t
		] test
		none
	]
	types: func [] [ symbol-group "types" [ datatype! typeset! ] ]
	keywords: func [] [ symbol-group "keywords" [ action! native! op!]]
	funcions: func [] [ symbol-group "funcions" [ funcion! ] ]

	;; used for stuff
	show-help: func [ 'word ] [
		prin "R3IDE-HELP: "
		print word
		help :word
	]
	show-source: func [ 'word ] [
		print "R3IDE-SOURCE"
		source :word
	]
	load: func [ str ] [
		;; FAILED on failure
		;; SUCCESS + list of new bindings on success
		if error? try [ do to-file str ] [ print "FAILED LOAD"]
		;; do symbol pulling here
	]
	;; autocomplete-dict -- should generate a rebol-mode dict for auto-complete mode
]
