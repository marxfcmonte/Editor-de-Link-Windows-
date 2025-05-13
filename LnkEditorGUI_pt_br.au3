#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include <GuiStatusBar.au3>
#include <Timers.au3>
#include <Array.au3>

Opt("GUIOnEventMode", 1)

Global Const $CmbWinstateNorm = @SW_SHOWNORMAL & " - Janela normal"
Global Const $CmbWinstateMin = @SW_SHOWMINNOACTIVE & " - Minimizada"
Global Const $CmbWinstateMax = @SW_SHOWMAXIMIZED & " - Maximizada"

#region - GUI

$GUI = GUICreate("Editor LNK - Editor de Arquivo LNK de Atalho do Windows", 800, 640, -1, -1, BitOr($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX ), $WS_EX_ACCEPTFILES)
GUISetOnEvent($GUI_EVENT_CLOSE, '_exit')
GUISetOnEvent($GUI_EVENT_DROPPED, "On_Drop_InFilename")
GUISetFont(10)

$Status = _GUICtrlStatusBar_Create($GUI)

GUICtrlCreateLabel("Arquivo:", 4, 6, 56, 24)
$inFilename = GUICtrlCreateInput("", 56, 4, 640, 24)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

$btBrowseForFile = GUICtrlCreateButton("Navegar...", 712, 4, 84, 24)
GUICtrlSetOnEvent(-1, '_btBrowseForFile')

$btBrowseForFile1 = GUICtrlCreateButton("Procurar arquivo EXE", 20, 32,200, 28)
GUICtrlSetOnEvent(-1, '_btBrowseForFile1')

$btOpenFile = GUICtrlCreateButton("Carregar arquivo LNK", 300, 32, 200, 28)
GUICtrlSetOnEvent(-1, '_btOpenFile')
GUICtrlSetResizing($btOpenFile, $GUI_DOCKLEFT)

$btSaveFile = GUICtrlCreateButton("Salvar arquivo LNK", 583, 32, 200, 28)
GUICtrlSetOnEvent(-1, '_btSaveFile')
GUICtrlSetResizing($btSaveFile, $GUI_DOCKRIGHT)

GUICtrlCreateLabel("EXE de destino", 4, 80, 172, 24)
$inTargetEXE = GUICtrlCreateInput("", 4, 104, 792, 24)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Argumentos opcionais", 4, 148, 172, 24)
$editTargetArgs = GUICtrlCreateEdit("", 4, 172, 792, 96, $ES_MULTILINE)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Diretório do Executável (Retire o arquivo .EXE)", 4, 288, 280, 24)
$inWorkingDir = GUICtrlCreateInput("", 4, 312, 792, 24)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Estado da janela", 4, 356, 172, 24)
$cmbWindowState = GUICtrlCreateCombo("", 4, 380, 792, 24, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $CmbWinstateNorm & "|" & $CmbWinstateMin & "|" & $CmbWinstateMax, $CmbWinstateNorm) ; add other item snd set a new default

GUICtrlCreateLabel("Arquivo do ícone", 4, 424, 172, 24)
$inIconFile = GUICtrlCreateInput("", 4, 448, 650, 24)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel("Índice de ícones", 680, 424, 172, 24)
$inIconIndex = GUICtrlCreateInput("", 674, 448, 112, 24)

GUICtrlCreateLabel("Comentário", 4, 492, 172, 24)
$editComment = GUICtrlCreateEdit("", 4, 516, 792, 96, $ES_MULTILINE)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUISetState(@SW_SHOW, $GUI)

#endregion - GUI

If $CmdLine[0] > 0 Then
	;MsgBox(0,0,$CmdLine[1])
	GUICtrlSetData($inFilename, $CmdLine[1])
	_btOpenFile()
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
Func _btBrowseForFile()
	Local $var = FileOpenDialog("Escolha ou crie um nome de arquivo LNK", "D:\", "Atalhos LNK (*.lnk)", 2) ; option 2 = dialog remains until valid path/file selected
	If @error Then
		;MsgBox(4096, "", "Nenhum arquivo(s) escolhido(s)")
	Else
		$var = StringReplace($var, "|", @CRLF)
		GUICtrlSetData($inFilename, $var)
	EndIf
EndFunc

;---------------------------------------------------------------
Func _btBrowseForFile1()
	Local $var1= FileOpenDialog("Escolha um arquivo EXE", "D:\", "Executáveis EXE (*.exe)", 2) ; option 2 = dialog remains until valid path/file selected
	If @error Then
		;MsgBox(4096, "", "Nenhum arquivo(s) escolhido(s)")
	Else
		$var1 = StringReplace($var1, "|", @CRLF)
		GUICtrlSetData($inTargetEXE, $var1)
		GUICtrlSetData($inWorkingDir, $var1)
	EndIf
EndFunc

;---------------------------------------------------------------
Func On_Drop_InFilename()
	If ( (@GUI_DropId = $inFilename) OR (@GUI_DropId = $inTargetEXE) ) Then
    	GUICtrlSetData(@GUI_DropId, @GUI_DragFile)
	EndIf
	If ( (@GUI_DropId = $inFilename) AND (@GUI_DragFile <> "") ) Then
		OpenFile(@GUI_DragFile)
	EndIf
EndFunc

;---------------------------------------------------------------
Func _btOpenFile()

	Local $filename = GUICtrlRead($inFilename)
	If $filename = "" Then
		;_btBrowseForFile()
		;$filename = GUICtrlRead($inFilename)
		StatusBarNotify("ERRO: Tentando abrir o arquivo, mas nenhum arquivo foi especificado.")
		MsgBox(0,"ERRO","Tentando abrir o arquivo, mas nenhum arquivo foi especificado.")
	Else
		OpenFile($filename)
	EndIf
EndFunc

;---------------------------------------------------------------
Func OpenFile($filename)
	Local $lnkArray = FileGetShortcut($filename)
	If Not @error Then
		;_ArrayDisplay($lnkArray)
	Else
		StatusBarNotify("ERRO: Não foi possível abrir o arquivo.")
		MsgBox(0,"ERRO","Não é possível abrir o arquivo, verifique o nome do arquivo.")
		Return
	EndIf
	GUICtrlSetData($inTargetEXE, $lnkArray[0])
	GUICtrlSetData($editTargetArgs, $lnkArray[2])
	GUICtrlSetData($inWorkingDir, $lnkArray[1])
	GUICtrlSetData($inIconFile, $lnkArray[4])
	GUICtrlSetData($inIconIndex, $lnkArray[5])
	GUICtrlSetData($editComment, $lnkArray[3])
	If($lnkArray[6] = @SW_SHOWNORMAL) Then
		GUICtrlSetData($cmbWindowState, $CmbWinstateNorm)
	ElseIf($lnkArray[6] = @SW_SHOWMINNOACTIVE) Then
		GUICtrlSetData($cmbWindowState, $CmbWinstateMin)
	ElseIf($lnkArray[6] = @SW_SHOWMAXIMIZED) Then
		GUICtrlSetData($cmbWindowState, $CmbWinstateMax)
	EndIf
	StatusBarNotify("Arquivo carregado com sucesso: " & $filename)
EndFunc

;---------------------------------------------------------------
Func _btSaveFile()

	$filename = GUICtrlRead($inFilename)
	If $filename = "" Then
		StatusBarNotify("ERRO: Tentando salvar, mas nenhum nome de arquivo foi especificado.")
		MsgBox(0,"ERRO","Tentando salvar, mas nenhum nome de arquivo foi especificado.")
		Return
	EndIf

	Local $WinStateToWrite
	Switch GuiCtrlRead($cmbWindowState)
	    Case $CmbWinstateNorm
	    	$WinStateToWrite = @SW_SHOWNORMAL
	    Case $CmbWinstateMin
	    	$WinStateToWrite = @SW_SHOWMINNOACTIVE
	    Case $CmbWinstateMax
	    	$WinStateToWrite = @SW_SHOWMAXIMIZED
	    Case Else
	    	$WinStateToWrite = @SW_SHOWNORMAL
	EndSwitch

	$saveResult = FileCreateShortcut(GuiCtrlRead($inTargetEXE), $filename, GuiCtrlRead($inWorkingDir), GuiCtrlRead($editTargetArgs), GuiCtrlRead($editComment), GuiCtrlRead($inIconFile), "", GuiCtrlRead($inIconIndex), $WinStateToWrite)
	If($saveResult) Then
		StatusBarNotify("Arquivo salvo com sucesso em: " & $filename)
	Else
		StatusBarNotify("ERRO: Não é possível salvar o arquivo. Verifique o nome do arquivo e os valores.")
		MsgBox(0,"ERRO","Não é possível salvar o arquivo, verifique o nome do arquivo e os valores.")
		EndIf

EndFunc

;---------------------------------------------------------------
Func _exit()
	Exit
EndFunc

;---------------------------------------------------------------

