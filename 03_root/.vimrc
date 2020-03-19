syntax      on                                      "syntax에 맞게 항목 강조
filetype    on                                      "파일 종류에 따른 구문 강조
"colorscheme elflord                                 "색상 테마를 elfload로 지정
"colorscheme molokai                                 "색상 테마를 molokai로 지정
color dracula

set autoindent                                      "자동 들여쓰기
set smartindent                                     "지능적인 들여쓰기
set cindent                                         "C파일 자동 들여쓰기
set tabstop=4                                       "탭 간격
set background=dark                                 "화면 배경을 어둡게
set ruler                                           "우측 하단에 행, 열     번호 표시
set shiftwidth=4                                    "자동 들여쓰기시 4칸씩 들여쓰기
set hlsearch                                        "검색어 강조
set showmatch                                       "일치 괄호 보여주기
set number                                          "행번호 사용
set statusline=%h%F%m%r%=[%l:%c(%p%%)]              "상태표시줄 포맷팅
set title                                           "타이틀바에 현재 편집중인 파일 표시
set history=200                                     "명령어 기록 갯수
set nobackup                                        "백업 파일을 생성하지 않음
set fileencodings=utf8,euc-kr						"파일 인코딩 utf8, euc-kr
"set mouse=a										"hold shift to copy xterm
"set ttymouse=xterm2								"necessary for gnu screen & mouse
"set ignorecase										"찾기에서 대/소문자를 구별하지 않음

"========== ctags 설정 =========
set tags+=./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,../../../../../tags,../../../../../../../tags,../../../../../../../../tags,../../../../../../../../../tags,../../../../../../../../../../tags,../../../../../../../../../../../tags
if version >= 500
func! Sts()
            let st = expand("<cword>")
                    exe "sts ".st
                    endfunc
                    nmap ,st :call Sts()<cr>

                    func! Tj()
            let st = expand("<cword>")
                    exe "tf ".st
                    endfunc
                    nmap ,tj :call Tj()<cr>
                    endif
