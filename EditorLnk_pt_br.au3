#cs 
Editor de arquivos LNK
Desenvolvido por Marx F. C. Monte


Editor LNK V1.3 (2025)
#ce

#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include <GuiStatusBar.au3>
#include <Timers.au3>
#include <Array.au3>

Opt("GUIOnEventMode", 1)
Global Const $JanelaNormal = @SW_SHOWNORMAL & " - Janela normal"
Global Const $JanelaMinimizada = 2 & " - Minimizada"
Global Const $JanelaMaximizada = @SW_SHOWMAXIMIZED & " - Maximizada"

#region - GUI

$GUI = GUICreate("Editor LNK - Editor de Arquivo LNK de Atalho do Windows", 800, 640, -1, -1, BitOr($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX ), $WS_EX_ACCEPTFILES)
GUISetOnEvent($GUI_EVENT_CLOSE, '_sair')
GUISetOnEvent($GUI_EVENT_DROPPED, "Ligar_InArquivo_Nome")
GUISetFont(10)

$Status = _GUICtrlStatusBar_Create($GUI)

GUICtrlCreateLabel("Arquivo:", 4, 6, 56, 24)
$inArquivoNome = GUICtrlCreateInput("", 56, 4, 640, 24)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

$btProcura = GUICtrlCreateButton("Navegar...", 712, 4, 84, 24)
GUICtrlSetOnEvent(-1, '_btProcura')

$btProcura1 = GUICtrlCreateButton("Procurar arquivo EXE", 20, 32,160, 28)
GUICtrlSetOnEvent(-1, '_btProcura1')

$btProcura2 = GUICtrlCreateButton("Procurar arquivo ICO", 220, 32,160, 28)
GUICtrlSetOnEvent(-1, '_btProcura2')

$btAbreArquivo = GUICtrlCreateButton("Carregar arquivo LNK", 420, 32, 160, 28)
GUICtrlSetOnEvent(-1, '_btAbreArquivo')
GUICtrlSetResizing($btAbreArquivo, $GUI_DOCKLEFT)

$btSalvaArquivo = GUICtrlCreateButton("Salvar arquivo LNK", 620, 32, 160, 28)
GUICtrlSetOnEvent(-1, '_btSalvaArquivo')
GUICtrlSetResizing($btSalvaArquivo, $GUI_DOCKRIGHT)

GUICtrlCreateLabel("EXE de destino", 4, 80, 172, 24)
$inAlvoEXE = GUICtrlCreateInput("", 4, 104, 792, 24)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Argumentos opcionais", 4, 148, 172, 24)
$editaAlvotArgs = GUICtrlCreateEdit("", 4, 172, 792, 96, $ES_MULTILINE)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Diretório do Executável", 4, 288, 280, 24)
$inDirExecutavel = GUICtrlCreateInput("", 4, 312, 792, 24)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Estado da janela", 4, 356, 172, 24)
$cmbEstadoJanela = GUICtrlCreateCombo("", 4, 380, 792, 24, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $JanelaNormal & "|" & $JanelaMinimizada & "|" & $JanelaMaximizada, $JanelaNormal) ; adicione outro item e defina um novo padrão

GUICtrlCreateLabel("Arquivo do ícone", 4, 424, 172, 24)
$inArquivoIcon = GUICtrlCreateInput("", 4, 448, 650, 24)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Índice de ícones", 680, 424, 172, 24)
$inIndiceIcone = GUICtrlCreateInput("", 674, 448, 112, 24)

GUICtrlCreateLabel("Comentário", 4, 492, 172, 24)
$ComentarioEdicao = GUICtrlCreateEdit("", 4, 516, 792, 96, $ES_MULTILINE)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUISetState(@SW_SHOW, $GUI)

#endregion - GUI

If $CmdLine[0] > 0 Then
	;MsgBox(0,0,$CmdLine[1])
	GUICtrlSetData($inArquivoNome, $CmdLine[1])
	_btAbreArquivo()
EndIf

While 1
	Sleep(100)
WEnd

;---------------------------------------------------------------
Func StatusBarNotify($msg)
		_GUICtrlStatusBar_SetText($Status, $msg)
		_Timer_SetTimer($GUI, 5000, "_ClearStatusBar")
EndFunc

;---------------------------------------------------------------
Func _ClearStatusBar($hWnd, $msg, $iIDTimer, $dwTime)
    #forceref $hWnd, $msg, $iIDTimer, $dwTime
    _GUICtrlStatusBar_SetText($Status, "")
    _Timer_KillTimer($hWnd, $iIDTimer)
EndFunc

;---------------------------------------------------------------
Func _btProcura()
	Local $var = FileOpenDialog("Escolha ou crie um nome de arquivo LNK", "C:\", "Atalhos LNK (*.lnk)", 2) ; opção 2 = o diálogo permanece até que um caminho/arquivo válido seja selecionado
	If @error Then
		;MsgBox(4096, "", "Nenhum arquivo escolhido")
	Else
		$var = StringReplace($var, "|", @CRLF)
		GUICtrlSetData($inArquivoNome, $var)
	EndIf
EndFunc

;---------------------------------------------------------------
Func _btProcura1()
	Local $var1 = FileOpenDialog("Escolha um arquivo EXE", "C:\", "Executáveis EXE (*.exe)", 2) ; opção 2 = o diálogo permanece até que um caminho/arquivo válido seja selecionado
	If @error Then
		;MsgBox(4096, "", "Nenhum arquivo escolhido")
	Else
		$var4 = StringReplace($var1, "|", @CRLF)
		Local $var6=StringSplit($var4, "\", @CRLF)
		$var7 = ""
		For $i = 1 To $var6[0] - 1 ; percorre o array $var6
			If $i ==  $var6[0] - 1 Then
				$var5=StringReplace($var6[$i] , "|", @CRLF)
				$var7 = $var7 & $var5
			Else
				$var5=StringReplace($var6[$i] , "|", @CRLF)
				$var7 = $var7 & $var5 & '\'
			EndIf 
		 Next
		GUICtrlSetData($inAlvoEXE, $var4)
		GUICtrlSetData($inDirExecutavel, $var7)
	EndIf
EndFunc

;---------------------------------------------------------------
Func _btProcura2()
	Local $var2 = FileOpenDialog("Escolha um arquivo ICO", "C:\", "Imagens ICO (*.ico)", 2) ; opção 2 = o diálogo permanece até que um caminho/arquivo válido seja selecionado
	If @error Then
		;MsgBox(4096, "", "Nenhum arquivo escolhido")
	Else
		$var2 = StringReplace($var2, "|", @CRLF)
		GUICtrlSetData($inArquivoIcon, $var2)
	EndIf
EndFunc

;---------------------------------------------------------------
Func Ligar_InArquivo_Nome()
	If ( (@GUI_DropId = $inArquivoNome) OR (@GUI_DropId = $inAlvoEXE) ) Then
    	GUICtrlSetData(@GUI_DropId, @GUI_DragFile)
	EndIf
	If ( (@GUI_DropId = $inArquivoNome) AND (@GUI_DragFile <> "") ) Then
		AbrirArquivo(@GUI_DragFile)
	EndIf
EndFunc

;---------------------------------------------------------------
Func _btAbreArquivo()

	Local $ArquivoNome = GUICtrlRead($inArquivoNome)
	If $ArquivoNome = "" Then
		;_btProcura()
		;$ArquivoNome = GUICtrlRead($inArquivoNome)
		StatusBarNotify("ERRO: Tentando abrir o arquivo, mas nenhum arquivo foi especificado.")
		MsgBox(0,"ERRO","Tentando abrir o arquivo, mas nenhum arquivo foi especificado.")
	Else
		AbrirArquivo($ArquivoNome)
	EndIf
EndFunc

;---------------------------------------------------------------
Func AbrirArquivo($ArquivoNome)
	Local $lnkArray = FileGetShortcut($ArquivoNome)
	If Not @error Then
		;_ArrayDisplay($lnkArray)
	Else
		StatusBarNotify("ERRO: Não foi possível abrir o arquivo.")
		MsgBox(0,"ERRO","Não é possível abrir o arquivo, verifique o nome do arquivo.")
		Return
	EndIf
	GUICtrlSetData($inAlvoEXE, $lnkArray[0])
	GUICtrlSetData($editaAlvotArgs, $lnkArray[2])
	GUICtrlSetData($inDirExecutavel, $lnkArray[1])
	GUICtrlSetData($inArquivoIcon, $lnkArray[4])
	GUICtrlSetData($inIndiceIcone, $lnkArray[5])
	GUICtrlSetData($ComentarioEdicao, $lnkArray[3])
	If($lnkArray[6] = @SW_SHOWNORMAL) Then
		GUICtrlSetData($cmbEstadoJanela, $JanelaNormal)
	ElseIf($lnkArray[6] = @SW_SHOWMINNOACTIVE) Then
		GUICtrlSetData($cmbEstadoJanela, $JanelaMinimizada)
	ElseIf($lnkArray[6] = @SW_SHOWMAXIMIZED) Then
		GUICtrlSetData($cmbEstadoJanela, $JanelaMaximizada)
	EndIf
	StatusBarNotify("Arquivo carregado com sucesso: " & $ArquivoNome)
EndFunc

;---------------------------------------------------------------
Func _btSalvaArquivo()

	$ArquivoNome = GUICtrlRead($inArquivoNome)
	If $ArquivoNome = "" Then
		StatusBarNotify("ERRO: Tentando salvar, mas nenhum nome de arquivo foi especificado.")
		MsgBox(0,"ERRO","Tentando salvar, mas nenhum nome de arquivo foi especificado.")
		Return
	EndIf

	Local $JanelaEstadoEscrita
	Switch GuiCtrlRead($cmbEstadoJanela)
	    Case $JanelaNormal
	    	$JanelaEstadoEscrita = @SW_SHOWNORMAL
	    Case $JanelaMinimizada
	    	$JanelaEstadoEscrita = @SW_SHOWMINNOACTIVE
	    Case $JanelaMaximizada
	    	$JanelaEstadoEscrita = @SW_SHOWMAXIMIZED
	    Case Else
	    	$JanelaEstadoEscrita = @SW_SHOWNORMAL
	EndSwitch

	$salvarResultado = FileCreateShortcut(GuiCtrlRead($inAlvoEXE), $ArquivoNome, GuiCtrlRead($inDirExecutavel), GuiCtrlRead($editaAlvotArgs), GuiCtrlRead($ComentarioEdicao), GuiCtrlRead($inArquivoIcon), "", GuiCtrlRead($inIndiceIcone), $JanelaEstadoEscrita)
	If($salvarResultado) Then
		StatusBarNotify("Arquivo salvo com sucesso em: " & $ArquivoNome)
	Else
		StatusBarNotify("ERRO: Não é possível salvar o arquivo. Verifique o nome do arquivo e os valores.")
		MsgBox(0,"ERRO","Não é possível salvar o arquivo, verifique o nome do arquivo e os valores.")
		EndIf

EndFunc

;---------------------------------------------------------------
Func _sair()
	Exit
EndFunc

;---------------------------------------------------------------

